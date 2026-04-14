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
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  let statsSource = DataSource(endpoint: "http://localhost:4000/api/stats", method: "GET")
  var stats: Any? { statsSource.data }
  var statsLoading: Bool { statsSource.loading }
  var statsError: String? { statsSource.error }
  let tasksSource = DataSource(endpoint: "http://localhost:4000/api/tasks", method: "GET")
  var tasks: Any? { tasksSource.data }
  var tasksLoading: Bool { tasksSource.loading }
  var tasksError: String? { tasksSource.error }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func loadSources() async {
    await statsSource.fetch()
    await tasksSource.fetch()
  }
}

struct AnalyticsViewView: View {
  @State private var vm = AnalyticsViewViewModel()
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-6")) {
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        Image(systemName: specIconName(specString("bar-chart")))
          .font(.system(size: specPx(ThemeManager.shared.resolve("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Analytics"))
          .font(.title2.bold())
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)

      LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: ThemeManager.shared.size("spacing-4")) {
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

      LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: ThemeManager.shared.size("spacing-4")) {
        VStack(spacing: ThemeManager.shared.size("spacing-3")) {
          Image(systemName: specIconName(specString("list")))
            .font(.system(size: specPx(ThemeManager.shared.resolve("icon-xl"))))
            .foregroundStyle(ThemeManager.shared.color("interactive"))
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("\(specString(vm.total))")).font(.system(size: 32, weight: .bold, design: .rounded))
            Text(specString("Total Tasks")).font(.subheadline).foregroundStyle(.secondary)
          }
        }
        .padding(ThemeManager.shared.size("spacing-5"))
        .background(ThemeManager.shared.color("gradient-stat-primary"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
        .hoverEffect(.highlight)
        VStack(spacing: ThemeManager.shared.size("spacing-3")) {
          Image(systemName: specIconName(specString("check")))
            .font(.system(size: specPx(ThemeManager.shared.resolve("icon-xl"))))
            .foregroundStyle(ThemeManager.shared.color("success"))
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("\(specString(vm.done))")).font(.system(size: 32, weight: .bold, design: .rounded))
            Text(specString("Completed")).font(.subheadline).foregroundStyle(.secondary)
          }
        }
        .padding(ThemeManager.shared.size("spacing-5"))
        .background(ThemeManager.shared.color("gradient-stat-success"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
        .hoverEffect(.highlight)
        VStack(spacing: ThemeManager.shared.size("spacing-3")) {
          Image(systemName: specIconName(specString("loader")))
            .font(.system(size: specPx(ThemeManager.shared.resolve("icon-xl"))))
            .foregroundStyle(ThemeManager.shared.color("warning"))
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("\(specString(vm.inProgress))")).font(.system(size: 32, weight: .bold, design: .rounded))
            Text(specString("In Progress")).font(.subheadline).foregroundStyle(.secondary)
          }
        }
        .padding(ThemeManager.shared.size("spacing-5"))
        .background(ThemeManager.shared.color("gradient-stat-warning"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
        .hoverEffect(.highlight)
        VStack(spacing: ThemeManager.shared.size("spacing-3")) {
          Image(systemName: specIconName(specString("circle")))
            .font(.system(size: specPx(ThemeManager.shared.resolve("icon-xl"))))
            .foregroundStyle(ThemeManager.shared.color("text-muted"))
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("\(specString(vm.todo))")).font(.system(size: 32, weight: .bold, design: .rounded))
            Text(specString("Todo")).font(.subheadline).foregroundStyle(.secondary)
          }
        }
        .padding(ThemeManager.shared.size("spacing-5"))
        .background(ThemeManager.shared.color("gradient-stat-neutral"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
        .hoverEffect(.highlight)
      }

      LazyVGrid(columns: [GridItem(.flexible())], spacing: ThemeManager.shared.size("spacing-5")) {
        VStack(alignment: .leading) {
          VStack(spacing: ThemeManager.shared.size("spacing-4")) {
            Text(verbatim: specString("Status Breakdown"))
              .font(.title3.bold())
            VStack(spacing: ThemeManager.shared.size("spacing-3")) {
              VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                  Text(verbatim: specString("Completed"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("success-text"))
                  Text(verbatim: specString("\(specString(vm.done))"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("success"))
                }

                ProgressView(value: (vm.donePercent as? Double ?? 0) / 100.0)
                  .tint(.accentColor)
              }

              VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                  Text(verbatim: specString("In Progress"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("warning-text"))
                  Text(verbatim: specString("\(specString(vm.inProgress))"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("warning"))
                }

                ProgressView(value: (vm.inProgressPercent as? Double ?? 0) / 100.0)
                  .tint(.accentColor)
              }

              VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                  Text(verbatim: specString("Todo"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-strong"))
                  Text(verbatim: specString("\(specString(vm.todo))"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-muted"))
                }

                ProgressView(value: (vm.todoPercent as? Double ?? 0) / 100.0)
                  .tint(.accentColor)
              }

            }

          }
          .padding(ThemeManager.shared.size("spacing-5"))
        }
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        VStack(alignment: .leading) {
          VStack(spacing: ThemeManager.shared.size("spacing-4")) {
            Text(verbatim: specString("Priority Breakdown"))
              .font(.title3.bold())
            VStack(spacing: ThemeManager.shared.size("spacing-3")) {
              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                  Image(systemName: specIconName(specString("alert-triangle")))
                    .font(.system(size: specPx(ThemeManager.shared.resolve("icon-sm"))))
                    .foregroundStyle(ThemeManager.shared.color("destructive"))
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
              .padding(ThemeManager.shared.size("spacing-3"))
              .background(ThemeManager.shared.color("error-bg"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
              .hoverEffect(.highlight)
              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                  Image(systemName: specIconName(specString("info")))
                    .font(.system(size: specPx(ThemeManager.shared.resolve("icon-sm"))))
                    .foregroundStyle(ThemeManager.shared.color("warning"))
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
              .padding(ThemeManager.shared.size("spacing-3"))
              .background(ThemeManager.shared.color("warning-light"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
              .hoverEffect(.highlight)
              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                  Image(systemName: specIconName(specString("check")))
                    .font(.system(size: specPx(ThemeManager.shared.resolve("icon-sm"))))
                    .foregroundStyle(ThemeManager.shared.color("success"))
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
              .padding(ThemeManager.shared.size("spacing-3"))
              .background(ThemeManager.shared.color("success-light"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
              .hoverEffect(.highlight)
            }

          }
          .padding(ThemeManager.shared.size("spacing-5"))
        }
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      }

      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          Text(verbatim: specString("Workload Distribution"))
            .font(.title3.bold())
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: ThemeManager.shared.size("spacing-4")) {
            VStack(spacing: ThemeManager.shared.size("spacing-2")) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx(ThemeManager.shared.resolve("icon-lg"))))
                .foregroundStyle(ThemeManager.shared.color("interactive"))
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("\(specString(vm.aliceCount))")).font(.system(size: 32, weight: .bold, design: .rounded))
                Text(specString("Alice's tasks")).font(.subheadline).foregroundStyle(.secondary)
              }
            }
            .padding(ThemeManager.shared.size("spacing-4"))
            .background(ThemeManager.shared.color("gradient-stat-primary-subtle"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
            .hoverEffect(.highlight)
            VStack(spacing: ThemeManager.shared.size("spacing-2")) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx(ThemeManager.shared.resolve("icon-lg"))))
                .foregroundStyle(ThemeManager.shared.color("success"))
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("\(specString(vm.bobCount))")).font(.system(size: 32, weight: .bold, design: .rounded))
                Text(specString("Bob's tasks")).font(.subheadline).foregroundStyle(.secondary)
              }
            }
            .padding(ThemeManager.shared.size("spacing-4"))
            .background(ThemeManager.shared.color("gradient-stat-success-subtle"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
            .hoverEffect(.highlight)
            VStack(spacing: ThemeManager.shared.size("spacing-2")) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx(ThemeManager.shared.resolve("icon-lg"))))
                .foregroundStyle(ThemeManager.shared.color("warning"))
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("\(specString(vm.carolCount))")).font(.system(size: 32, weight: .bold, design: .rounded))
                Text(specString("Carol's tasks")).font(.subheadline).foregroundStyle(.secondary)
              }
            }
            .padding(ThemeManager.shared.size("spacing-4"))
            .background(ThemeManager.shared.color("gradient-stat-warning-subtle"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
            .hoverEffect(.highlight)
          }

        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
