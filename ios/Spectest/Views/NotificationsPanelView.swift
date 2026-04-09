import SwiftUI
import SpecRuntime

@Observable
final class NotificationsPanelViewModel {
  var severityFilter: Any = "all"
  var readFilter: Any = "all"
  var allNotifications: Any { (notifications != nil ? notifications : [] as [Any]) }
  var filteredNotifications: Any { ((specString(severityFilter) == specString("all")) ? allNotifications : (allNotifications as? [Any] ?? []).filter { { n in (specString((n as? [String: Any])?["severity"]) == specString(severityFilter)) }($0) as? Bool ?? false }) }
  var notifCount: Any { "\(specString(specLength(filteredNotifications))) notifications" }
  var unreadCount: Any { specLength((allNotifications as? [Any] ?? []).filter { { n in !((n as? [String: Any])?["read"] as? Bool ?? false) }($0) as? Bool ?? false }) }
  var hasUnread: Any { ((unreadCount as? Double ?? 0) > (0 as? Double ?? 0)) }
  var unreadLabel: Any { "\(specString(unreadCount)) unread" }
  var hasNoNotifications: Any { (specString(specLength(filteredNotifications)) == specString(0)) }
  let notificationsSource = DataSource(endpoint: "http://localhost:4000/api/notifications", method: "GET")
  var notifications: Any? { notificationsSource.data }
  var notificationsLoading: Bool { notificationsSource.loading }
  var notificationsError: String? { notificationsSource.error }
  func setSeverityFilter(_ v: Any) {
    severityFilter = v
  }
  func loadSources() async {
    await notificationsSource.fetch()
  }
}

struct NotificationsPanelView: View {
  @State private var vm = NotificationsPanelViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      HStack(alignment: .center, spacing: CGFloat(12)) {
        Image(systemName: specIconName(specString("bell")))
          .font(.system(size: specPx("20px")))
          .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
        Text(specString("Notifications"))
          .font(.title2.bold())
        VStack() {
          if vm.hasUnread as? Bool ?? false {
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
        if vm.hasUnread as? Bool ?? false {
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
        HStack(alignment: .center, spacing: CGFloat(8)) {
          Text(specString("Filter:"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
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
        .padding(CGFloat(12))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(spacing: CGFloat(8)) {
        if vm.notificationsLoading as? Bool ?? false {
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
        if vm.notificationsError as? Bool ?? false {
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

      ForEach(Array((vm.filteredNotifications as? [Any] ?? []).enumerated()), id: \.offset) { idx, notif in
        HStack(alignment: .center, spacing: CGFloat(12)) {
          Image(systemName: specIconName(specString(({ () -> Any in switch specString((notif as? [String: Any])?["severity"]) {
case specString("success"): return "check"
case specString("error"): return "alert-triangle"
case specString("warning"): return "alert-triangle"
default: return "info"
} })())))
            .font(.system(size: specPx("20px")))
            .foregroundStyle(Color(hex: ({ () -> Any in switch specString((notif as? [String: Any])?["severity"]) {
case specString("success"): return "#52c41a"
case specString("error"): return "#ff4d4f"
case specString("warning"): return "#faad14"
default: return "#1677ff"
} })() as? String ?? "#000"))
          VStack(spacing: CGFloat(4)) {
            Text(specString((notif as? [String: Any])?["title"]))
              .font(.body.bold())
            HStack(alignment: .center, spacing: CGFloat(8)) {
              SeverityBadgeView(severity: (notif as? [String: Any])?["severity"])
              Text(specString((notif as? [String: Any])?["createdAt"]))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)

          }

          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .padding(CGFloat(12))
        .background(Color(hex: (((notif as? [String: Any])?["read"]) as? Bool ?? false ? "#ffffff" : "#f0f9ff") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      }
      VStack() {
        if vm.hasNoNotifications as? Bool ?? false {
          ContentUnavailableView(specString("No Notifications"), systemImage: "tray", description: Text(specString("No notifications match your current filter.")))
            .frame(height: 200)
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
