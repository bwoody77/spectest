// ActivityFeed — Enhanced for Gate #22
// Uses: Timeline (Issue #17), Card (Issue #17), Badge (Issue #17),
//   hover states (Issue #53), transitions (Issue #52), Skeleton (Issue #19)

surface ActivityFeed {
  @source {
    activityItems: ActivityAPI
  }

  @state {
    typeFilter: "all"
  }

  @computed {
    allActivity: activityItems != null ? activityItems : []
    filteredActivity: typeFilter == "all" ? allActivity : allActivity.filter(a => a.type == typeFilter)
    activityCount: "{filteredActivity.length} events"
    hasNoActivity: filteredActivity.length == 0

    // Map activity data to Timeline item format
    timelineItems: filteredActivity.map(a => ({id: a.id, title: a.user, description: a.detail, date: a.timestamp, status: match a.type { "task_completed" -> "completed", "deploy" -> "completed", _ -> "active" }}))
  }

  @actions {
    setTypeFilter(v) { typeFilter = v }
  }

  layout: vertical, gap: spacing.5

  block {
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "clock", size: icon.md, color: semantic.interactive)
    text("Activity Feed") { style: type.heading-lg, letter-spacing: "-0.01em" }
  }

  // Filter buttons
  Card() {
    block {
      role: "toolbar"
      aria-label: "Activity filters"
      padding: spacing.3
      layout: responsive(vertical, md: horizontal), gap: spacing.2, align: center
      Badge(text: activityCount, variant: "neutral")
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
  }

  // Skeleton loading (Issue #19)
  block {
    visibility: activityItemsLoading
    layout: vertical, gap: spacing.3
    Skeleton(height: "60px", width: "100%")
    Skeleton(height: "60px", width: "100%")
    Skeleton(height: "60px", width: "100%")
    Skeleton(height: "60px", width: "90%")
  }

  // Error
  block {
    visibility: activityItemsError
    Alert(severity: "error", message: "Could not retrieve the activity feed.", title: "Failed to load activity")
  }

  // Empty state (Issue #17)
  block {
    visibility: hasNoActivity
    EmptyState(
      message: "No Activity",
      description: "No activity events match your current filter."
    )
  }

  // Timeline (Issue #17) — chronological activity display
  block {
    visibility: !activityItemsLoading
    Timeline(
      items: timelineItems,
      orientation: "vertical"
    )
  }

  // Detailed activity cards with hover effects
  block {
    visibility: !activityItemsLoading
    layout: vertical, gap: spacing.3

    each filteredActivity as item, idx {
      block {
        padding: spacing.3
        background: semantic.surface-raised
        border-radius: radius.md
        shadow: elevation.raised
        transition: transition.interactive
        layout: responsive(vertical, md: horizontal), gap: spacing.3, align: center

        on hover {
          shadow: elevation.layered
          transform: transform.nudge-right
        }

        ActivityIcon(item.type)

        block {
          layout: vertical, gap: spacing.1
          block {
            layout: horizontal, gap: spacing.2, align: center
            text(item.user) { style: type.label-md, weight: 600 }
            Badge(text: item.type, variant: "neutral")
          }
          text(item.detail) { style: type.body-sm }
          text(item.timestamp) { style: type.mono-sm, color: semantic.text-secondary }
        }
      }
    }
  }
}
