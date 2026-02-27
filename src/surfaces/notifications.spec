// NotificationsPanel — notification list with severity levels

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
    filteredNotifications: severityFilter == "all" ? allNotifications : allNotifications.filter(n -> n.severity == severityFilter)
    notifCount: "{filteredNotifications.length} notifications"
    hasNoNotifications: filteredNotifications.length == 0
  }

  @actions {
    setSeverityFilter(v) { severityFilter = v }
  }

  layout: vertical, gap: spacing.5

  text("Notifications") { style: type.heading-lg }

  // Summary bar
  block {
    aria-label: "Notification summary"
    padding: spacing.3
    background: "#eef2ff"
    border-radius: radius.md
    layout: horizontal, gap: spacing.4, align: center
    Icon(name: "bell", size: "20px", color: "#6366f1")
    text(notifCount) { style: type.body-md }
  }

  // Filters
  block {
    role: "toolbar"
    aria-label: "Severity filters"
    padding: spacing.3
    background: palette.neutral.50
    border-radius: radius.md
    layout: horizontal, gap: spacing.2, align: center
    text("Severity:") { style: type.label-sm, color: semantic.text-secondary }
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

  // Loading
  block {
    aria-live: "polite"
    visibility: notificationsLoading
    padding: spacing.4
    background: "#f0f9ff"
    border-radius: radius.md
    text("Loading notifications...") { style: type.body-sm, color: semantic.text-secondary }
  }

  // Error
  block {
    aria-live: "assertive"
    visibility: notificationsError
    padding: spacing.3
    background: "#fef2f2"
    border: "1px solid #fecaca"
    border-radius: radius.md
    text("Failed to load notifications.") { style: type.body-sm, color: palette.danger.500 }
  }

  // Notification rows
  each filteredNotifications as notif, idx {
    block {
      padding: spacing.3
      background: "#ffffff"
      border: "1px solid #e2e8f0"
      border-radius: radius.md
      layout: horizontal, gap: spacing.3, align: center

      Icon(name: "bell", size: "20px", color: "#6366f1")

      block {
        layout: vertical, gap: spacing.1
        text(notif.title) { style: type.body-md }
        block {
          layout: horizontal, gap: spacing.2, align: center
          SeverityBadge(notif.severity)
          text(notif.createdAt) { style: type.mono-sm, color: semantic.text-secondary }
        }
      }
    }
  }

  // Empty state
  block {
    aria-live: "polite"
    visibility: hasNoNotifications
    padding: spacing.4
    background: palette.neutral.50
    border-radius: radius.md
    layout: vertical, gap: spacing.2, align: center
    Icon(name: "bell-off", size: "24px", color: "#64748b")
    text("No notifications match your filters.") { style: type.body-sm, color: semantic.text-secondary }
  }
}
