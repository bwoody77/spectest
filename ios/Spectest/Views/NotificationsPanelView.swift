import SwiftUI
import SpecRuntime

@Observable
final class NotificationsPanelViewModel {
  var severityFilter: Any = "all"
  var readFilter: Any = "all"
  var allNotifications: Any { (notifications != nil ? notifications : [] as [Any]) }
  var filteredNotifications: Any { (specEq(severityFilter, "all") ? allNotifications : specFilter(allNotifications, { (n: Any) -> Bool in return specEq(specGet(n, "severity"), severityFilter) })) }
  var notifCount: Any { "\(specString(specLength(filteredNotifications))) notifications" }
  var unreadCount: Any { specLength(specFilter(allNotifications, { (n: Any) -> Bool in return ((!((specGet(n, "read")) as? Bool ?? false))) as? Bool ?? false })) }
  var hasUnread: Any { (specDouble(unreadCount) > specDouble(0)) }
  var unreadLabel: Any { "\(specString(unreadCount)) unread" }
  var hasNoNotifications: Any { specEq(specLength(filteredNotifications), 0) }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  let notificationsSource = DataSource(endpoint: "http://localhost:4000/api/notifications", method: "GET")
  var notifications: Any? { notificationsSource.data }
  var notificationsLoading: Bool { notificationsSource.loading }
  var notificationsError: String? { notificationsSource.error }
  func setSeverityFilter(_ v: Any) {
    severityFilter = v
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func loadSources() async {
    await notificationsSource.fetch()
  }
}

struct NotificationsPanelView: View {
  @State private var vm = NotificationsPanelViewModel()
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-5")) {
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        Image(systemName: specIconName(specString("bell")))
          .font(.system(size: specPx(ThemeManager.shared.resolve("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Notifications"))
          .font(.title2.bold())
        VStack() {
          if (vm.hasUnread) as? Bool ?? false {
            Text(specString(vm.unreadLabel))
              .font(.caption.weight(.medium))
              .padding(.horizontal, 8)
              .padding(.vertical, 4)
              .foregroundStyle(specBadgeForeground(specString("error")))
              .background(specBadgeBackground(specString("error")), in: Capsule())
          }
        }

      }

      VStack() {
        if (vm.hasUnread) as? Bool ?? false {
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: specAlertIcon(specString("info")))
              .foregroundStyle(specAlertColor(specString("info")))
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("You have unread notifications")).font(.subheadline.weight(.semibold))
              Text(specString("Review your notifications below to stay up to date.")).font(.subheadline)
            }
            Spacer(minLength: 0)
          }
          .padding(12)
          .background(specAlertColor(specString("info")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
      }

      VStack(alignment: .leading) {
        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
          Text(verbatim: specString("Filter:"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          Spacer(minLength: 0)
          Picker("", selection: Binding(get: { specString(vm.severityFilter) }, set: { vm.severityFilter = $0 })) {
            Text("All").tag("all")
            Text("Info").tag("info")
            Text("Success").tag("success")
            Text("Warning").tag("warning")
            Text("Error").tag("error")
          }
          .pickerStyle(.segmented)
        }
        .frame(maxWidth: .infinity)
        .padding(ThemeManager.shared.size("spacing-3"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(spacing: ThemeManager.shared.size("spacing-2")) {
        if (vm.notificationsLoading) as? Bool ?? false {
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("56px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("56px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("56px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("56px"))
            .overlay(ProgressView())
        }
      }

      VStack() {
        if (vm.notificationsError) as? Bool ?? false {
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: specAlertIcon(specString("error")))
              .foregroundStyle(specAlertColor(specString("error")))
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Failed to load notifications")).font(.subheadline.weight(.semibold))
              Text(specString("Could not retrieve notifications from the server.")).font(.subheadline)
            }
            Spacer(minLength: 0)
          }
          .padding(12)
          .background(specAlertColor(specString("error")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
      }

      ForEach(Array(specArr(vm.filteredNotifications).enumerated()), id: \.offset) { idx, notif in
        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
          Image(systemName: specIconName(specString(({ () -> Any in switch specString(specGet(notif, "severity")) {
case specString("success"): return "check"
case specString("error"): return "alert-triangle"
case specString("warning"): return "alert-triangle"
default: return "info"
} })())))
            .font(.system(size: specPx(ThemeManager.shared.resolve("icon-md"))))
            .foregroundStyle(({ () -> Color in switch specString(specGet(notif, "severity")) {
case specString("success"): return ThemeManager.shared.color("success")
case specString("error"): return ThemeManager.shared.color("destructive")
case specString("warning"): return ThemeManager.shared.color("warning")
default: return ThemeManager.shared.color("interactive")
} })())
          VStack(spacing: ThemeManager.shared.size("spacing-1")) {
            Text(verbatim: specString(specGet(notif, "title")))
              .font(.body.bold())
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
              SeverityBadgeView(severity: specGet(notif, "severity"))
              Text(verbatim: specString(specGet(notif, "createdAt")))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)

          }

          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .padding(ThemeManager.shared.size("spacing-3"))
        .background(((specGet(notif, "read")) as? Bool ?? false ? ThemeManager.shared.color("surface-raised") : ThemeManager.shared.color("surface-unread")), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
        .hoverEffect(.highlight)
      }
      VStack() {
        if (vm.hasNoNotifications) as? Bool ?? false {
          ContentUnavailableView(specString("No Notifications"), systemImage: "tray", description: Text(specString("No notifications match your current filter.")))
            .frame(height: 200)
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
