import SwiftUI
import SpecRuntime

@Observable
final class ActivityFeedViewModel {
  var typeFilter: Any = "all"
  var allActivity: Any { (activityItems != nil ? activityItems : [] as [Any]) }
  var filteredActivity: Any { (specEq(typeFilter, "all") ? allActivity : specFilter(allActivity, { (a: Any) -> Bool in return specEq(specGet(a, "type"), typeFilter) })) }
  var activityCount: Any { "\(specString(specLength(filteredActivity))) events" }
  var hasNoActivity: Any { specEq(specLength(filteredActivity), 0) }
  var timelineItems: Any { specMap(filteredActivity, { (a: Any) -> Any in return ["id": specGet(a, "id") as Any, "title": specGet(a, "user") as Any, "description": specGet(a, "detail") as Any, "date": specGet(a, "timestamp") as Any, "status": ({ () -> Any in switch specString(specGet(a, "type")) {
case specString("task_completed"): return "completed"
case specString("deploy"): return "completed"
default: return "active"
} })() as Any] as [String: Any] }) }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  let activityItemsSource = DataSource(endpoint: "http://localhost:4000/api/activity", method: "GET")
  var activityItems: Any? { activityItemsSource.data }
  var activityItemsLoading: Bool { activityItemsSource.loading }
  var activityItemsError: String? { activityItemsSource.error }
  func setTypeFilter(_ v: Any) {
    typeFilter = v
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func loadSources() async {
    await activityItemsSource.fetch()
  }
}

struct ActivityFeedView: View {
  @State private var vm = ActivityFeedViewModel()
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-5")) {
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        Image(systemName: specIconName(specString("clock")))
          .font(.system(size: specPx(ThemeManager.shared.resolve("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Activity Feed"))
          .font(.title2.bold())
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)

      VStack(alignment: .leading) {
        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
          Text(specString(vm.activityCount))
            .font(.caption.weight(.medium))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .foregroundStyle(specBadgeForeground(specString("neutral")))
            .background(specBadgeBackground(specString("neutral")), in: Capsule())
          Picker("", selection: Binding(get: { specString(vm.typeFilter) }, set: { vm.typeFilter = $0 })) {
            Text("All").tag("all")
            Text("Tasks").tag("task_created")
            Text("Comments").tag("comment")
            Text("Deploys").tag("deploy")
          }
          .pickerStyle(.segmented)
        }
        .padding(ThemeManager.shared.size("spacing-3"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(spacing: ThemeManager.shared.size("spacing-3")) {
        if (vm.activityItemsLoading) as? Bool ?? false {
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("60px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("60px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("60px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("60px"))
            .overlay(ProgressView())
        }
      }

      VStack() {
        if (vm.activityItemsError) as? Bool ?? false {
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: specAlertIcon(specString("error")))
              .foregroundStyle(specAlertColor(specString("error")))
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Failed to load activity")).font(.subheadline.weight(.semibold))
              Text(specString("Could not retrieve the activity feed.")).font(.subheadline)
            }
            Spacer(minLength: 0)
          }
          .padding(12)
          .background(specAlertColor(specString("error")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
      }

      VStack() {
        if (vm.hasNoActivity) as? Bool ?? false {
          ContentUnavailableView(specString("No Activity"), systemImage: "tray", description: Text(specString("No activity events match your current filter.")))
            .frame(height: 200)
        }
      }

      VStack() {
        if ((!((vm.activityItemsLoading) as? Bool ?? false))) as? Bool ?? false {
          VStack(alignment: .leading, spacing: 0) {
            ForEach(Array((vm.timelineItems as? [Any] ?? []).enumerated()), id: \.offset) { idx, item in
              HStack(alignment: .top, spacing: 12) {
                VStack(spacing: 0) {
                  Circle().fill(Color.blue).frame(width: 10, height: 10)
                  if idx < (vm.timelineItems as? [Any] ?? []).count - 1 {
                    Rectangle().fill(Color(.separator)).frame(width: 2).frame(maxHeight: .infinity)
                  }
                }
                VStack(alignment: .leading, spacing: 2) {
                  Text(specString((item as? [String: Any])?["title"])).font(.subheadline.weight(.medium))
                  Text(specString((item as? [String: Any])?["description"])).font(.caption).foregroundStyle(.secondary)
                }
                .padding(.bottom, 16)
              }
            }
          }
        }
      }

      VStack(spacing: ThemeManager.shared.size("spacing-3")) {
        if ((!((vm.activityItemsLoading) as? Bool ?? false))) as? Bool ?? false {
          ForEach(Array(specArr(vm.filteredActivity).enumerated()), id: \.offset) { idx, item in
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
              ActivityIconView(activityType: specGet(item, "type"))
              VStack(spacing: ThemeManager.shared.size("spacing-1")) {
                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                  Text(verbatim: specString(specGet(item, "user")))
                    .font(.body.bold())
                  Spacer(minLength: 0)
                  Text(specString(specGet(item, "type")))
                    .font(.caption.weight(.medium))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .foregroundStyle(specBadgeForeground(specString("neutral")))
                    .background(specBadgeBackground(specString("neutral")), in: Capsule())
                }
                .frame(maxWidth: .infinity)

                Text(verbatim: specString(specGet(item, "detail")))
                  .font(.callout.bold())
                Text(verbatim: specString(specGet(item, "timestamp")))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }

              Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            .padding(ThemeManager.shared.size("spacing-3"))
            .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
            .hoverEffect(.highlight)
          }
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
