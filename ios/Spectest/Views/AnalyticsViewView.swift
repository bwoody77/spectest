import SwiftUI
import SpecRuntime

@Observable
final class AnalyticsViewViewModel {
  var total: Any { (stats != nil ? (stats as? [String: Any])?["total"] : 0) }
  var done: Any { (stats != nil ? (stats as? [String: Any])?["done"] : 0) }
  var inProgress: Any { (stats != nil ? (stats as? [String: Any])?["inProgress"] : 0) }
  var todo: Any { (stats != nil ? (stats as? [String: Any])?["todo"] : 0) }
  var donePercent: Any { (((total as? Double ?? 0) > (0 as? Double ?? 0)) ? ((((done as? Double ?? 0) * (100 as? Double ?? 0)) as? Double ?? 0) / (total as? Double ?? 0)) : 0) }
  var inProgressPercent: Any { (((total as? Double ?? 0) > (0 as? Double ?? 0)) ? ((((inProgress as? Double ?? 0) * (100 as? Double ?? 0)) as? Double ?? 0) / (total as? Double ?? 0)) : 0) }
  var todoPercent: Any { (((total as? Double ?? 0) > (0 as? Double ?? 0)) ? ((((todo as? Double ?? 0) * (100 as? Double ?? 0)) as? Double ?? 0) / (total as? Double ?? 0)) : 0) }
  var taskList: Any { (tasks != nil ? tasks : [] as [Any]) }
  var highCount: Any { specLength((taskList as? [Any] ?? []).filter { { t in (specString((t as? [String: Any])?["priority"]) == specString("high")) }($0) as? Bool ?? false }) }
  var mediumCount: Any { specLength((taskList as? [Any] ?? []).filter { { t in (specString((t as? [String: Any])?["priority"]) == specString("medium")) }($0) as? Bool ?? false }) }
  var lowCount: Any { specLength((taskList as? [Any] ?? []).filter { { t in (specString((t as? [String: Any])?["priority"]) == specString("low")) }($0) as? Bool ?? false }) }
  var aliceCount: Any { specLength((taskList as? [Any] ?? []).filter { { t in (specString((t as? [String: Any])?["assignee"]) == specString("Alice")) }($0) as? Bool ?? false }) }
  var bobCount: Any { specLength((taskList as? [Any] ?? []).filter { { t in (specString((t as? [String: Any])?["assignee"]) == specString("Bob")) }($0) as? Bool ?? false }) }
  var carolCount: Any { specLength((taskList as? [Any] ?? []).filter { { t in (specString((t as? [String: Any])?["assignee"]) == specString("Carol")) }($0) as? Bool ?? false }) }
  let statsSource = DataSource(endpoint: "http://localhost:4000/api/stats", method: "GET")
  var stats: Any? { statsSource.data }
  var statsLoading: Bool { statsSource.loading }
  var statsError: String? { statsSource.error }
  let tasksSource = DataSource(endpoint: "http://localhost:4000/api/tasks", method: "GET")
  var tasks: Any? { tasksSource.data }
  var tasksLoading: Bool { tasksSource.loading }
  var tasksError: String? { tasksSource.error }
  func loadSources() async {
    await statsSource.fetch()
    await tasksSource.fetch()
  }
}

struct AnalyticsViewView: View {
  @State private var vm = AnalyticsViewViewModel()
  var body: some View {
    VStack(spacing: CGFloat(24)) {
      HStack(alignment: .center, spacing: CGFloat(12)) {
        Image(systemName: specIconName(specString("bar-chart")))
          .font(.system(size: specPx("20px")))
          .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
        Text(specString("Analytics"))
          .font(.title2.bold())
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)

      LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: CGFloat(16)) {
        if vm.statsLoading as? Bool ?? false {
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("100px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("100px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("100px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("100px"))
            .overlay(ProgressView())
        }
      }

      LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: CGFloat(16)) {
        VStack(spacing: CGFloat(12)) {
          Image(systemName: specIconName(specString("list")))
            .font(.system(size: specPx("32px")))
            .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("\(specString(vm.total))")).font(.system(size: 32, weight: .bold, design: .rounded))
            Text(specString("Total Tasks")).font(.subheadline).foregroundStyle(.secondary)
          }
        }
        .padding(CGFloat(20))
        .background(LinearGradient(colors: [Color(hex: "#e6f4ff"), Color(hex: "#91caff")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: CGFloat(12)))
        VStack(spacing: CGFloat(12)) {
          Image(systemName: specIconName(specString("check")))
            .font(.system(size: specPx("32px")))
            .foregroundStyle(Color(hex: "#52c41a" as? String ?? "#000"))
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("\(specString(vm.done))")).font(.system(size: 32, weight: .bold, design: .rounded))
            Text(specString("Completed")).font(.subheadline).foregroundStyle(.secondary)
          }
        }
        .padding(CGFloat(20))
        .background(LinearGradient(colors: [Color(hex: "#f6ffed"), Color(hex: "#d9f7be")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: CGFloat(12)))
        VStack(spacing: CGFloat(12)) {
          Image(systemName: specIconName(specString("loader")))
            .font(.system(size: specPx("32px")))
            .foregroundStyle(Color(hex: "#faad14" as? String ?? "#000"))
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("\(specString(vm.inProgress))")).font(.system(size: 32, weight: .bold, design: .rounded))
            Text(specString("In Progress")).font(.subheadline).foregroundStyle(.secondary)
          }
        }
        .padding(CGFloat(20))
        .background(LinearGradient(colors: [Color(hex: "#fffbe6"), Color(hex: "#fff1b8")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: CGFloat(12)))
        VStack(spacing: CGFloat(12)) {
          Image(systemName: specIconName(specString("circle")))
            .font(.system(size: specPx("32px")))
            .foregroundStyle(Color(hex: "#5c7aa3" as? String ?? "#000"))
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("\(specString(vm.todo))")).font(.system(size: 32, weight: .bold, design: .rounded))
            Text(specString("Todo")).font(.subheadline).foregroundStyle(.secondary)
          }
        }
        .padding(CGFloat(20))
        .background(LinearGradient(colors: [Color(.systemGroupedBackground), Color(hex: "#bdc5d1")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: CGFloat(12)))
      }

      LazyVGrid(columns: [GridItem(.flexible())], spacing: CGFloat(20)) {
        VStack(alignment: .leading) {
          VStack(spacing: CGFloat(16)) {
            Text(specString("Status Breakdown"))
              .font(.title3.bold())
            VStack(spacing: CGFloat(12)) {
              VStack(spacing: CGFloat(8)) {
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Text(specString("Completed"))
                    .font(.body.bold())
                    .foregroundStyle(Color(hex: "#135200"))
                  Text(specString("\(specString(vm.done))"))
                    .font(.body.bold())
                    .foregroundStyle(Color(hex: "#52c41a"))
                }

                ProgressView(value: (vm.donePercent as? Double ?? 0) / 100.0)
                  .tint(.accentColor)
              }

              VStack(spacing: CGFloat(8)) {
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Text(specString("In Progress"))
                    .font(.body.bold())
                    .foregroundStyle(Color(hex: "#614700"))
                  Text(specString("\(specString(vm.inProgress))"))
                    .font(.body.bold())
                    .foregroundStyle(Color(hex: "#faad14"))
                }

                ProgressView(value: (vm.inProgressPercent as? Double ?? 0) / 100.0)
                  .tint(.accentColor)
              }

              VStack(spacing: CGFloat(8)) {
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Text(specString("Todo"))
                    .font(.body.bold())
                    .foregroundStyle(Color(hex: "#3b4e68"))
                  Text(specString("\(specString(vm.todo))"))
                    .font(.body.bold())
                    .foregroundStyle(Color(hex: "#5c7aa3"))
                }

                ProgressView(value: (vm.todoPercent as? Double ?? 0) / 100.0)
                  .tint(.accentColor)
              }

            }

          }
          .padding(CGFloat(20))
        }
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        VStack(alignment: .leading) {
          VStack(spacing: CGFloat(16)) {
            Text(specString("Priority Breakdown"))
              .font(.title3.bold())
            VStack(spacing: CGFloat(12)) {
              HStack(alignment: .center, spacing: CGFloat(12)) {
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Image(systemName: specIconName(specString("alert-triangle")))
                    .font(.system(size: specPx("18px")))
                    .foregroundStyle(Color(hex: "#ff4d4f" as? String ?? "#000"))
                  Text(specString("High Priority"))
                    .font(.body.bold())
                  Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)

                Spacer(minLength: 0)
                Text(specString("\(specString(vm.highCount))"))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("error")))
                  .background(specBadgeBackground(specString("error")), in: Capsule())
              }
              .frame(maxWidth: .infinity)
              .padding(CGFloat(12))
              .background(Color(hex: "#fff2f0"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
              HStack(alignment: .center, spacing: CGFloat(12)) {
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Image(systemName: specIconName(specString("info")))
                    .font(.system(size: specPx("18px")))
                    .foregroundStyle(Color(hex: "#faad14" as? String ?? "#000"))
                  Text(specString("Medium Priority"))
                    .font(.body.bold())
                  Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)

                Spacer(minLength: 0)
                Text(specString("\(specString(vm.mediumCount))"))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("warning")))
                  .background(specBadgeBackground(specString("warning")), in: Capsule())
              }
              .frame(maxWidth: .infinity)
              .padding(CGFloat(12))
              .background(Color(hex: "#fffbe6"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
              HStack(alignment: .center, spacing: CGFloat(12)) {
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Image(systemName: specIconName(specString("check")))
                    .font(.system(size: specPx("18px")))
                    .foregroundStyle(Color(hex: "#52c41a" as? String ?? "#000"))
                  Text(specString("Low Priority"))
                    .font(.body.bold())
                  Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)

                Spacer(minLength: 0)
                Text(specString("\(specString(vm.lowCount))"))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("success")))
                  .background(specBadgeBackground(specString("success")), in: Capsule())
              }
              .frame(maxWidth: .infinity)
              .padding(CGFloat(12))
              .background(Color(hex: "#f6ffed"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
            }

          }
          .padding(CGFloat(20))
        }
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      }

      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          Text(specString("Workload Distribution"))
            .font(.title3.bold())
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: CGFloat(16)) {
            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx("24px")))
                .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("\(specString(vm.aliceCount))")).font(.system(size: 32, weight: .bold, design: .rounded))
                Text(specString("Alice's tasks")).font(.subheadline).foregroundStyle(.secondary)
              }
            }
            .padding(CGFloat(16))
            .background(LinearGradient(colors: [Color(hex: "#e6f4ff"), Color(hex: "#bae0ff")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: CGFloat(8)))
            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx("24px")))
                .foregroundStyle(Color(hex: "#52c41a" as? String ?? "#000"))
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("\(specString(vm.bobCount))")).font(.system(size: 32, weight: .bold, design: .rounded))
                Text(specString("Bob's tasks")).font(.subheadline).foregroundStyle(.secondary)
              }
            }
            .padding(CGFloat(16))
            .background(LinearGradient(colors: [Color(hex: "#f6ffed"), Color(hex: "#b7eb8f")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: CGFloat(8)))
            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx("24px")))
                .foregroundStyle(Color(hex: "#faad14" as? String ?? "#000"))
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("\(specString(vm.carolCount))")).font(.system(size: 32, weight: .bold, design: .rounded))
                Text(specString("Carol's tasks")).font(.subheadline).foregroundStyle(.secondary)
              }
            }
            .padding(CGFloat(16))
            .background(LinearGradient(colors: [Color(hex: "#fffbe6"), Color(hex: "#ffe58f")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: CGFloat(8)))
          }

        }
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
    .foregroundStyle(.primary)
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
