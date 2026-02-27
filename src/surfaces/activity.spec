// ActivityFeed — recent activity with icons and timestamps

surface ActivityFeed {
  @source {
    activityItems: ActivityAPI
  }

  @state {
    typeFilter: "all"
  }

  @computed {
    allActivity: activityItems != null ? activityItems : []
    filteredActivity: typeFilter == "all" ? allActivity : allActivity.filter(a -> a.type == typeFilter)
    activityCount: "{filteredActivity.length} events"
    hasNoActivity: filteredActivity.length == 0
  }

  @actions {
    setTypeFilter(v) { typeFilter = v }
  }

  layout: vertical, gap: spacing.5

  text("Activity Feed") { style: type.heading-lg }

  // Filter buttons
  block {
    role: "toolbar"
    aria-label: "Activity filters"
    padding: spacing.3
    background: palette.neutral.50
    border-radius: radius.md
    layout: horizontal, gap: spacing.2, align: center
    text(activityCount) { style: type.body-sm, color: semantic.text-secondary }
    Button(label: "All", variant: "secondary") {
      on click: setTypeFilter("all")
    }
    Button(label: "Tasks", variant: "secondary") {
      on click: setTypeFilter("task_created")
    }
    Button(label: "Comments", variant: "secondary") {
      on click: setTypeFilter("comment")
    }
    Button(label: "Deploys", variant: "secondary") {
      on click: setTypeFilter("deploy")
    }
  }

  // Loading
  block {
    aria-live: "polite"
    visibility: activityItemsLoading
    padding: spacing.4
    background: "#f0f9ff"
    border-radius: radius.md
    layout: horizontal, gap: spacing.2, align: center
    Icon(name: "loader", size: "18px", color: "#6366f1")
    text("Loading activity...") { style: type.body-sm, color: semantic.text-secondary }
  }

  // Error
  block {
    aria-live: "assertive"
    visibility: activityItemsError
    padding: spacing.3
    background: "#fef2f2"
    border: "1px solid #fecaca"
    border-radius: radius.md
    text("Failed to load activity feed.") { style: type.body-sm, color: palette.danger.500 }
  }

  // Empty state
  block {
    aria-live: "polite"
    visibility: hasNoActivity
    padding: spacing.4
    background: palette.neutral.50
    border-radius: radius.md
    layout: vertical, gap: spacing.2, align: center
    Icon(name: "clock", size: "24px", color: "#64748b")
    text("No activity events found.") { style: type.body-sm, color: semantic.text-secondary }
  }

  // Activity list
  each filteredActivity as item, idx {
    block {
      padding: spacing.3
      background: "#ffffff"
      border: "1px solid #e2e8f0"
      border-radius: radius.md
      layout: horizontal, gap: spacing.3, align: center

      ActivityIcon(item.type)

      block {
        layout: vertical, gap: spacing.1
        block {
          layout: horizontal, gap: spacing.2, align: center
          text(item.user) { style: type.label-md, weight: 600 }
          text(item.type) { style: type.label-sm, color: semantic.text-secondary }
        }
        text(item.detail) { style: type.body-sm }
        text(item.timestamp) { style: type.mono-sm, color: semantic.text-secondary }
      }
    }
  }

}
