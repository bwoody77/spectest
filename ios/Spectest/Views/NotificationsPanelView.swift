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
