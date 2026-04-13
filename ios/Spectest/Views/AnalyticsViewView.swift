import SwiftUI
import SpecRuntime

@Observable
final class AnalyticsViewViewModel {
  var total: Any { (stats != nil ? specGet(stats, "total") : 0) }
  var done: Any { (stats != nil ? specGet(stats, "done") : 0) }
  var inProgress: Any { (stats != nil ? specGet(stats, "inProgress") : 0) }
  var todo: Any { (stats != nil ? specGet(stats, "todo") : 0) }
  var donePercent: Any { ((specDouble(total) > specDouble(0)) ? (specDouble((specDouble(done) * specDouble(100))) / specDouble(total)) : 0) }
  var inProgressPercent: Any { ((specDouble(total) > specDouble(0)) ? (specDouble((specDouble(inProgress) * specDouble(100))) / specDouble(total)) : 0) }
  var todoPercent: Any { ((specDouble(total) > specDouble(0)) ? (specDouble((specDouble(todo) * specDouble(100))) / specDouble(total)) : 0) }
  var taskList: Any { (tasks != nil ? tasks : [] as [Any]) }
  var highCount: Any { specLength(specFilter(taskList, { (t: Any) -> Bool in return specEq(specGet(t, "priority"), "high") })) }
  var mediumCount: Any { specLength(specFilter(taskList, { (t: Any) -> Bool in return specEq(specGet(t, "priority"), "medium") })) }
  var lowCount: Any { specLength(specFilter(taskList, { (t: Any) -> Bool in return specEq(specGet(t, "priority"), "low") })) }
  var aliceCount: Any { specLength(specFilter(taskList, { (t: Any) -> Bool in return specEq(specGet(t, "assignee"), "Alice") })) }
  var bobCount: Any { specLength(specFilter(taskList, { (t: Any) -> Bool in return specEq(specGet(t, "assignee"), "Bob") })) }
  var carolCount: Any { specLength(specFilter(taskList, { (t: Any) -> Bool in return specEq(specGet(t, "assignee"), "Carol") })) }
  let statsSource = DataSource(endpoint: "http://localhost:4000/api/stats", method: "GET")
  var stats: Any? { statsSource.data }
  var statsLoading: Bool { statsSource.loading }
  var statsError: String? { statsSource.error }
  let tasksSource = DataSource(endpoint: "http://localhost:4000/api/tasks", method: "GET")
  var tasks: Any? { tasksSource.data }
  var tasksLoading: Bool { tasksSource.loading }
  var tasksError: String? { tasksSource.error }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
          .foregroundStyle(Color(hex: "#1677ff" as? String ?? "transparent"))
        Text(verbatim: specString("Analytics"))
          .font(.title2.bold())
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)

      LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: CGFloat(16)) {
        if (vm.statsLoading) as? Bool ?? false {
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
            .foregroundStyle(Color(hex: "#1677ff" as? String ?? "transparent"))
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("\(specString(vm.total))")).font(.system(size: 32, weight: .bold, design: .rounded))
            Text(specString("Total Tasks")).font(.subheadline).foregroundStyle(.secondary)
          }
        }
        .padding(CGFloat(20))
        .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.info-bg"), ThemeManager.shared.color("semantic.focus-ring")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
        VStack(spacing: CGFloat(12)) {
          Image(systemName: specIconName(specString("check")))
            .font(.system(size: specPx("32px")))
            .foregroundStyle(Color(hex: "#52c41a" as? String ?? "transparent"))
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("\(specString(vm.done))")).font(.system(size: 32, weight: .bold, design: .rounded))
            Text(specString("Completed")).font(.subheadline).foregroundStyle(.secondary)
          }
        }
        .padding(CGFloat(20))
        .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.success-light"), ThemeManager.shared.color("semantic.success-muted")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
        VStack(spacing: CGFloat(12)) {
          Image(systemName: specIconName(specString("loader")))
            .font(.system(size: specPx("32px")))
            .foregroundStyle(Color(hex: "#faad14" as? String ?? "transparent"))
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("\(specString(vm.inProgress))")).font(.system(size: 32, weight: .bold, design: .rounded))
            Text(specString("In Progress")).font(.subheadline).foregroundStyle(.secondary)
          }
        }
        .padding(CGFloat(20))
        .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.warning-light"), ThemeManager.shared.color("semantic.warning-muted")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
        VStack(spacing: CGFloat(12)) {
          Image(systemName: specIconName(specString("circle")))
            .font(.system(size: specPx("32px")))
            .foregroundStyle(Color(hex: "#5c7aa3" as? String ?? "transparent"))
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("\(specString(vm.todo))")).font(.system(size: 32, weight: .bold, design: .rounded))
            Text(specString("Todo")).font(.subheadline).foregroundStyle(.secondary)
          }
        }
        .padding(CGFloat(20))
        .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.surface"), ThemeManager.shared.color("semantic.text-disabled")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
      }

      LazyVGrid(columns: [GridItem(.flexible())], spacing: CGFloat(20)) {
        VStack(alignment: .leading) {
          VStack(spacing: CGFloat(16)) {
            Text(verbatim: specString("Status Breakdown"))
              .font(.title3.bold())
            VStack(spacing: CGFloat(12)) {
              VStack(spacing: CGFloat(8)) {
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Text(verbatim: specString("Completed"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.success-text"))
                  Text(verbatim: specString("\(specString(vm.done))"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.success"))
                }

                ProgressView(value: (vm.donePercent as? Double ?? 0) / 100.0)
                  .tint(.accentColor)
              }

              VStack(spacing: CGFloat(8)) {
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Text(verbatim: specString("In Progress"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.warning-text"))
                  Text(verbatim: specString("\(specString(vm.inProgress))"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.warning"))
                }

                ProgressView(value: (vm.inProgressPercent as? Double ?? 0) / 100.0)
                  .tint(.accentColor)
              }

              VStack(spacing: CGFloat(8)) {
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Text(verbatim: specString("Todo"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-strong"))
                  Text(verbatim: specString("\(specString(vm.todo))"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-muted"))
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
            Text(verbatim: specString("Priority Breakdown"))
              .font(.title3.bold())
            VStack(spacing: CGFloat(12)) {
              HStack(alignment: .center, spacing: CGFloat(12)) {
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Image(systemName: specIconName(specString("alert-triangle")))
                    .font(.system(size: specPx("18px")))
                    .foregroundStyle(Color(hex: "#ff4d4f" as? String ?? "transparent"))
                  Text(verbatim: specString("High Priority"))
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
              .background(ThemeManager.shared.color("semantic.error-bg"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              HStack(alignment: .center, spacing: CGFloat(12)) {
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Image(systemName: specIconName(specString("info")))
                    .font(.system(size: specPx("18px")))
                    .foregroundStyle(Color(hex: "#faad14" as? String ?? "transparent"))
                  Text(verbatim: specString("Medium Priority"))
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
              .background(ThemeManager.shared.color("semantic.warning-light"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
              HStack(alignment: .center, spacing: CGFloat(12)) {
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Image(systemName: specIconName(specString("check")))
                    .font(.system(size: specPx("18px")))
                    .foregroundStyle(Color(hex: "#52c41a" as? String ?? "transparent"))
                  Text(verbatim: specString("Low Priority"))
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
              .background(ThemeManager.shared.color("semantic.success-light"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            }

          }
          .padding(CGFloat(20))
        }
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      }

      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          Text(verbatim: specString("Workload Distribution"))
            .font(.title3.bold())
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: CGFloat(16)) {
            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx("24px")))
                .foregroundStyle(Color(hex: "#1677ff" as? String ?? "transparent"))
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("\(specString(vm.aliceCount))")).font(.system(size: 32, weight: .bold, design: .rounded))
                Text(specString("Alice's tasks")).font(.subheadline).foregroundStyle(.secondary)
              }
            }
            .padding(CGFloat(16))
            .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.info-bg"), Color(hex: "#bae0ff")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx("24px")))
                .foregroundStyle(Color(hex: "#52c41a" as? String ?? "transparent"))
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("\(specString(vm.bobCount))")).font(.system(size: 32, weight: .bold, design: .rounded))
                Text(specString("Bob's tasks")).font(.subheadline).foregroundStyle(.secondary)
              }
            }
            .padding(CGFloat(16))
            .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.success-light"), Color(hex: "#b7eb8f")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            VStack(spacing: CGFloat(8)) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx("24px")))
                .foregroundStyle(Color(hex: "#faad14" as? String ?? "transparent"))
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("\(specString(vm.carolCount))")).font(.system(size: 32, weight: .bold, design: .rounded))
                Text(specString("Carol's tasks")).font(.subheadline).foregroundStyle(.secondary)
              }
            }
            .padding(CGFloat(16))
            .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.warning-light"), Color(hex: "#ffe58f")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          }

        }
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
