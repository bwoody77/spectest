// Badge and avatar components

component StatusBadge(status: string) {
  text(match status {
    "todo" -> "○ Todo",
    "in-progress" -> "◐ In Progress",
    "done" -> "● Done",
    _ -> "Unknown"
  }) { style: type.label-sm }
}

component PriorityBadge(priority: string) {
  text(match priority {
    "low" -> "▽ Low",
    "medium" -> "◇ Medium",
    "high" -> "△ High",
    "critical" -> "▲ Critical",
    _ -> "—"
  }) { style: type.label-sm }
}

component SeverityBadge(severity: string) {
  text(match severity {
    "info" -> "ⓘ Info",
    "success" -> "✔ Success",
    "warning" -> "⚠ Warning",
    "error" -> "✖ Error",
    _ -> "Unknown"
  }) { style: type.label-sm }
}

component ActivityIcon(activityType: string) {
  text(match activityType {
    "task_created" -> "New",
    "task_completed" -> "Done",
    "task_assigned" -> "Assigned",
    "comment" -> "Comment",
    "deploy" -> "Deploy",
    _ -> "Event"
  }) { style: type.label-md }
}

component UserAvatar(name: string, bgColor: string) {
  block {
    padding: spacing.2
    background: bgColor
    border-radius: radius.full
    layout: horizontal, align: center, justify: center
    text(name) { style: type.label-md, color: "#ffffff" }
  }
}
