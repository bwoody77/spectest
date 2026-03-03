// NotificationsPanel — Enhanced for Gate #22
// Uses: Alert (Issue #19), Badge (Issue #17), Card (Issue #17),
//   hover states (Issue #53), transitions (Issue #52), text styling (Issue #55)

surface NotificationsPanel {
  @source {
    notifications: NotificationsAPI
  }

  @state {
    severityFilter: "all"
    readFilter: "all"
  }

  @computed {
    allNotifications: notifications != null ? notifications : []
    filteredNotifications: severityFilter == "all" ? allNotifications : allNotifications.filter(n => n.severity == severityFilter)
    notifCount: "{filteredNotifications.length} notifications"
    unreadCount: allNotifications.filter(n => !n.read).length
    hasUnread: unreadCount > 0
    unreadLabel: "{unreadCount} unread"
    hasNoNotifications: filteredNotifications.length == 0
  }

  @actions {
    setSeverityFilter(v) { severityFilter = v }
  }

  layout: vertical, gap: spacing.5

  block {
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "bell", size: icon.md, color: semantic.interactive)
    text("Notifications") { style: type.heading-lg, letter-spacing: "-0.01em" }
    block {
      visibility: hasUnread
      Badge(text: unreadLabel, variant: "error")
    }
  }

  // Summary banner with Alert (Issue #19)
  block {
    visibility: hasUnread
    Alert(severity: "info", message: "Review your notifications below to stay up to date.", title: "You have unread notifications")
  }

  // Filters
  Card() {
    block {
      role: "toolbar"
      aria-label: "Severity filters"
      padding: spacing.3
      layout: responsive(vertical, md: horizontal), gap: spacing.2, align: center
      text("Filter:") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
      Button(label: "All", variant: "secondary") {
        on click: setSeverityFilter("all")
      }
      Button(label: "Info", variant: "secondary") {
        on click: setSeverityFilter("info")
      }
      Button(label: "Success", variant: "secondary") {
        on click: setSeverityFilter("success")
      }
      Button(label: "Warning", variant: "secondary") {
        on click: setSeverityFilter("warning")
      }
      Button(label: "Error", variant: "secondary") {
        on click: setSeverityFilter("error")
      }
    }
  }

  // Skeleton loading (Issue #19)
  block {
    visibility: notificationsLoading
    layout: vertical, gap: spacing.2
    Skeleton(height: "56px", width: "100%")
    Skeleton(height: "56px", width: "100%")
    Skeleton(height: "56px", width: "100%")
    Skeleton(height: "56px", width: "95%")
  }

  // Error
  block {
    visibility: notificationsError
    Alert(severity: "error", message: "Could not retrieve notifications from the server.", title: "Failed to load notifications")
  }

  // Notification rows with hover
  each filteredNotifications as notif, idx {
    block {
      padding: spacing.3
      background: notif.read ? semantic.surface-raised : semantic.surface-unread
      border: borders.default
      border-left: notif.read ? borders.accent-none : borders.accent-interactive
      border-radius: radius.md
      shadow: elevation.flat
      cursor: "pointer"
      transition: transition.interactive-full
      layout: responsive(vertical, md: horizontal), gap: spacing.3, align: center

      on hover {
        shadow: elevation.raised
        background: semantic.surface
        transform: transform.nudge-right-sm
      }

      Icon(
        name: match notif.severity {
          "success" -> "check",
          "error" -> "alert-triangle",
          "warning" -> "alert-triangle",
          _ -> "info"
        },
        size: icon.md,
        color: match notif.severity {
          "success" -> semantic.success,
          "error" -> semantic.destructive,
          "warning" -> semantic.warning,
          _ -> semantic.interactive
        }
      )

      block {
        layout: vertical, gap: spacing.1
        text(notif.title) { style: type.body-md, weight: notif.read ? 400 : 600 }
        block {
          layout: horizontal, gap: spacing.2, align: center
          SeverityBadge(severity: notif.severity)
          text(notif.createdAt) { style: type.mono-sm, color: semantic.text-secondary }
        }
      }
    }
  }

  // Empty state (Issue #17)
  block {
    visibility: hasNoNotifications
    EmptyState(
      message: "No Notifications",
      description: "No notifications match your current filter."
    )
  }
}
