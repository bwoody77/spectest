// Badge and avatar components — Enhanced for Gate #22
// Uses: Badge component (Issue #17), interactive states (Issue #53),
//   transitions (Issue #52), text styling (Issue #55)

component StatusBadge(status: string) {
  Badge(
    text: match status {
      "todo" -> "Todo",
      "in-progress" -> "In Progress",
      "done" -> "Done",
      _ -> "Unknown"
    },
    variant: match status {
      "todo" -> "neutral",
      "in-progress" -> "warning",
      "done" -> "success",
      _ -> "neutral"
    }
  )
}

component PriorityBadge(priority: string) {
  Badge(
    text: match priority {
      "low" -> "Low",
      "medium" -> "Medium",
      "high" -> "High",
      "critical" -> "Critical",
      _ -> "—"
    },
    variant: match priority {
      "low" -> "neutral",
      "medium" -> "warning",
      "high" -> "error",
      "critical" -> "error",
      _ -> "neutral"
    }
  )
}

component SeverityBadge(severity: string) {
  Badge(
    text: match severity {
      "info" -> "Info",
      "success" -> "Success",
      "warning" -> "Warning",
      "error" -> "Error",
      _ -> "Unknown"
    },
    variant: match severity {
      "info" -> "info",
      "success" -> "success",
      "warning" -> "warning",
      "error" -> "error",
      _ -> "neutral"
    }
  )
}

component ProductStatusBadge(status: string) {
  Badge(
    text: match status {
      "active" -> "Active",
      "out-of-stock" -> "Out of Stock",
      "discontinued" -> "Discontinued",
      _ -> status
    },
    variant: match status {
      "active" -> "success",
      "out-of-stock" -> "warning",
      "discontinued" -> "error",
      _ -> "neutral"
    }
  )
}

component ActivityIcon(activityType: string) {
  Icon(
    name: match activityType {
      "task_created" -> "plus",
      "task_completed" -> "check",
      "task_assigned" -> "user",
      "comment" -> "message-circle",
      "deploy" -> "upload",
      _ -> "circle"
    },
    size: "18px",
    color: match activityType {
      "task_created" -> "#3b82f6",
      "task_completed" -> "#10b981",
      "task_assigned" -> "#8b5cf6",
      "comment" -> "#f59e0b",
      "deploy" -> "#06b6d4",
      _ -> "#64748b"
    }
  )
}

component UserAvatar(name: string, bgColor: string) {
  block {
    padding: spacing.3
    background: bgColor
    border-radius: radius.full
    layout: horizontal, align: center, justify: center
    shadow: elevation.raised
    transition: "transform 150ms ease, shadow 150ms ease"

    on hover {
      transform: "scale(1.1)"
      shadow: elevation.layered
    }

    text(name) { style: type.label-md, color: "#ffffff" }
  }
}
