import SwiftUI
import SpecRuntime

// MARK: - Dashboard Screen (hand-crafted native iOS)

struct DashboardScreen: View {
  @State private var stats = DataSource(endpoint: "http://localhost:4000/api/stats", method: "GET")
  @State private var tasks = DataSource(endpoint: "http://localhost:4000/api/tasks", method: "GET")
  @State private var filter: TaskFilter = .all

  enum TaskFilter: String, CaseIterable {
    case all = "All"
    case todo = "Todo"
    case inProgress = "In Progress"
    case done = "Done"
  }

  private var taskList: [[String: Any]] {
    guard let arr = tasks.data as? [[String: Any]] else { return [] }
    switch filter {
    case .all: return arr
    case .todo: return arr.filter { ($0["status"] as? String) == "todo" }
    case .inProgress: return arr.filter { ($0["status"] as? String) == "in-progress" }
    case .done: return arr.filter { ($0["status"] as? String) == "done" }
    }
  }

  var body: some View {
    ScrollView {
      VStack(spacing: 20) {
        statsSection
        taskSection
      }
      .padding()
    }
    .background(Color(.systemGroupedBackground))
    .navigationTitle("Dashboard")
    .refreshable {
      await stats.fetch()
      await tasks.fetch()
    }
    .task {
      await stats.fetch()
      await tasks.fetch()
    }
  }

  // MARK: - Stats Cards

  @ViewBuilder
  private var statsSection: some View {
    if let s = stats.data as? [String: Any] {
      let total = s["total"] as? Int ?? 0
      let done = s["done"] as? Int ?? 0
      let inProg = s["inProgress"] as? Int ?? 0
      let todo = s["todo"] as? Int ?? 0

      LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
        StatCard(title: "Total", count: total, color: .blue, icon: "list.clipboard")
        StatCard(title: "Done", count: done, total: total, color: .green, icon: "checkmark.circle.fill")
        StatCard(title: "In Progress", count: inProg, total: total, color: .orange, icon: "arrow.triangle.2.circlepath")
        StatCard(title: "Todo", count: todo, total: total, color: .purple, icon: "circle.dashed")
      }
    } else if stats.loading {
      LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
        ForEach(0..<4, id: \.self) { _ in
          RoundedRectangle(cornerRadius: 16)
            .fill(Color(.secondarySystemGroupedBackground))
            .frame(height: 100)
            .overlay(ProgressView())
        }
      }
    }
  }

  // MARK: - Task List

  @ViewBuilder
  private var taskSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Text("Tasks")
          .font(.title2.bold())
        Spacer()
        Text("\(taskList.count)")
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .padding(.horizontal, 8)
          .padding(.vertical, 4)
          .background(.quaternary, in: Capsule())
      }

      Picker("Filter", selection: $filter) {
        ForEach(TaskFilter.allCases, id: \.self) { f in
          Text(f.rawValue).tag(f)
        }
      }
      .pickerStyle(.segmented)

      if tasks.loading && taskList.isEmpty {
        ForEach(0..<3, id: \.self) { _ in
          RoundedRectangle(cornerRadius: 12)
            .fill(Color(.secondarySystemGroupedBackground))
            .frame(height: 72)
            .overlay(ProgressView())
        }
      } else if taskList.isEmpty {
        ContentUnavailableView(
          "No Tasks",
          systemImage: "tray",
          description: Text("No tasks match the current filter.")
        )
        .frame(height: 200)
      } else {
        LazyVStack(spacing: 8) {
          ForEach(Array(taskList.enumerated()), id: \.offset) { _, task in
            TaskRow(task: task)
          }
        }
      }
    }
  }
}

// MARK: - Stat Card

private struct StatCard: View {
  let title: String
  let count: Int
  var total: Int? = nil
  let color: Color
  let icon: String

  private var percentage: String? {
    guard let t = total, t > 0 else { return nil }
    return "\(count * 100 / t)%"
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Image(systemName: icon)
          .font(.title3)
          .foregroundStyle(color)
        Spacer()
        if let pct = percentage {
          Text(pct)
            .font(.caption.bold())
            .foregroundStyle(color)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(color.opacity(0.12), in: Capsule())
        }
      }
      Text("\(count)")
        .font(.system(size: 32, weight: .bold, design: .rounded))
        .foregroundStyle(.primary)
      Text(title)
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
    .padding()
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16))
  }
}

// MARK: - Task Row

private struct TaskRow: View {
  let task: [String: Any]

  private var title: String { task["title"] as? String ?? "Untitled" }
  private var assignee: String { task["assignee"] as? String ?? "—" }
  private var status: String { task["status"] as? String ?? "todo" }
  private var priority: String { task["priority"] as? String ?? "low" }
  private var createdAt: String { task["createdAt"] as? String ?? "" }

  var body: some View {
    HStack(spacing: 12) {
      // Status indicator dot
      Circle()
        .fill(statusColor)
        .frame(width: 10, height: 10)

      VStack(alignment: .leading, spacing: 4) {
        Text(title)
          .font(.body.weight(.medium))
          .lineLimit(2)

        HStack(spacing: 8) {
          Label(assignee, systemImage: "person.fill")
            .font(.caption)
            .foregroundStyle(.secondary)

          Text("·")
            .foregroundStyle(.quaternary)

          Text(createdAt)
            .font(.caption)
            .foregroundStyle(.tertiary)
        }
      }

      Spacer()

      VStack(alignment: .trailing, spacing: 6) {
        StatusPill(status: status)
        PriorityPill(priority: priority)
      }
    }
    .padding(12)
    .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
  }

  private var statusColor: Color {
    switch status {
    case "done": return .green
    case "in-progress": return .orange
    default: return .gray
    }
  }
}

// MARK: - Status Pill

private struct StatusPill: View {
  let status: String

  private var label: String {
    switch status {
    case "done": return "Done"
    case "in-progress": return "In Progress"
    case "todo": return "Todo"
    default: return status
    }
  }

  private var color: Color {
    switch status {
    case "done": return .green
    case "in-progress": return .orange
    default: return .gray
    }
  }

  var body: some View {
    Text(label)
      .font(.caption2.bold())
      .foregroundStyle(color)
      .padding(.horizontal, 8)
      .padding(.vertical, 3)
      .background(color.opacity(0.12), in: Capsule())
  }
}

// MARK: - Priority Pill

private struct PriorityPill: View {
  let priority: String

  private var color: Color {
    switch priority {
    case "critical": return .red
    case "high": return .red.opacity(0.8)
    case "medium": return .orange
    default: return .gray
    }
  }

  var body: some View {
    Text(priority.capitalized)
      .font(.caption2)
      .foregroundStyle(color)
      .padding(.horizontal, 6)
      .padding(.vertical, 2)
      .background(color.opacity(0.08), in: Capsule())
  }
}
