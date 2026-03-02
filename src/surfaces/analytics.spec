// AnalyticsView — Enhanced for Gate #22
// Uses: Stat (Issue #17), Card (Issue #17), Progress (Issue #19),
//   CSS Grid (Issue #51), responsive breakpoints (Issue #58),
//   gradients (Issue #54), shadows (Issue #54), transforms (Issue #54),
//   hover states (Issue #53), transitions (Issue #52), text styling (Issue #55)

surface AnalyticsView {
  @source {
    stats: StatsAPI
    tasks: TasksAPI
  }

  @computed {
    total: stats != null ? stats.total : 0
    done: stats != null ? stats.done : 0
    inProgress: stats != null ? stats.inProgress : 0
    todo: stats != null ? stats.todo : 0
    donePercent: total > 0 ? (done * 100 / total) : 0
    inProgressPercent: total > 0 ? (inProgress * 100 / total) : 0
    todoPercent: total > 0 ? (todo * 100 / total) : 0

    taskList: tasks != null ? tasks : []
    highCount: taskList.filter(t => t.priority == "high").length
    mediumCount: taskList.filter(t => t.priority == "medium").length
    lowCount: taskList.filter(t => t.priority == "low").length

    aliceCount: taskList.filter(t => t.assignee == "Alice").length
    bobCount: taskList.filter(t => t.assignee == "Bob").length
    carolCount: taskList.filter(t => t.assignee == "Carol").length
  }

  layout: vertical, gap: spacing.6

  block {
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "bar-chart", size: icon.md, color: semantic.interactive)
    text("Analytics") { style: type.heading-lg, letter-spacing: "-0.02em" }
  }

  // Skeleton loading (Issue #19)
  block {
    visibility: statsLoading
    layout: grid, columns: responsive("1fr", md: "1fr 1fr", lg: "1fr 1fr 1fr 1fr"), gap: spacing.4
    Skeleton(height: "100px", width: "100%")
    Skeleton(height: "100px", width: "100%")
    Skeleton(height: "100px", width: "100%")
    Skeleton(height: "100px", width: "100%")
  }

  // Key metric cards — CSS Grid (Issue #51) with responsive breakpoints (Issue #58)
  block {
    layout: grid, columns: responsive("1fr 1fr", lg: "1fr 1fr 1fr 1fr"), gap: spacing.4

    Card() {
      block {
        padding: spacing.5
        background: gradient.stat-primary
        border-radius: radius.lg
        transition: transition.card-lift
        cursor: "pointer"
        layout: vertical, gap: spacing.3, align: center

        on hover {
          transform: transform.lift-md
          shadow: elevation.floating
        }

        Icon(name: "list", size: icon.xl, color: semantic.interactive)
        Stat(value: "{total}", label: "Total Tasks")
      }
    }

    Card() {
      block {
        padding: spacing.5
        background: gradient.stat-success
        border-radius: radius.lg
        transition: transition.card-lift
        cursor: "pointer"
        layout: vertical, gap: spacing.3, align: center

        on hover {
          transform: transform.lift-md
          shadow: elevation.floating
        }

        Icon(name: "check", size: icon.xl, color: semantic.success)
        Stat(value: "{done}", label: "Completed")
      }
    }

    Card() {
      block {
        padding: spacing.5
        background: gradient.stat-warning
        border-radius: radius.lg
        transition: transition.card-lift
        cursor: "pointer"
        layout: vertical, gap: spacing.3, align: center

        on hover {
          transform: transform.lift-md
          shadow: elevation.floating
        }

        Icon(name: "loader", size: icon.xl, color: semantic.warning)
        Stat(value: "{inProgress}", label: "In Progress")
      }
    }

    Card() {
      block {
        padding: spacing.5
        background: gradient.stat-neutral
        border-radius: radius.lg
        transition: transition.card-lift
        cursor: "pointer"
        layout: vertical, gap: spacing.3, align: center

        on hover {
          transform: transform.lift-md
          shadow: elevation.floating
        }

        Icon(name: "circle", size: icon.xl, color: semantic.text-muted)
        Stat(value: "{todo}", label: "Todo")
      }
    }
  }

  // Breakdown sections — CSS Grid 2-column (Issue #51)
  block {
    layout: grid, columns: responsive("1fr", lg: "1fr 1fr"), gap: spacing.5

    // Status breakdown with Progress bars (Issue #19)
    Card() {
      block {
        padding: spacing.5
        layout: vertical, gap: spacing.4

        text("Status Breakdown") { style: type.heading-md, letter-spacing: "-0.01em" }

        block {
          layout: vertical, gap: spacing.3

          block {
            layout: vertical, gap: spacing.2
            block {
              layout: horizontal, gap: spacing.2, align: center, justify: between
              text("Completed") { style: type.label-sm, color: semantic.success-text, text-transform: "uppercase", letter-spacing: "0.05em" }
              text("{done}") { style: type.label-md, weight: 700, color: semantic.success }
            }
            Progress(value: donePercent, label: "done")
          }

          block {
            layout: vertical, gap: spacing.2
            block {
              layout: horizontal, gap: spacing.2, align: center, justify: between
              text("In Progress") { style: type.label-sm, color: semantic.warning-text, text-transform: "uppercase", letter-spacing: "0.05em" }
              text("{inProgress}") { style: type.label-md, weight: 700, color: semantic.warning }
            }
            Progress(value: inProgressPercent, label: "in progress")
          }

          block {
            layout: vertical, gap: spacing.2
            block {
              layout: horizontal, gap: spacing.2, align: center, justify: between
              text("Todo") { style: type.label-sm, color: semantic.text-strong, text-transform: "uppercase", letter-spacing: "0.05em" }
              text("{todo}") { style: type.label-md, weight: 700, color: semantic.text-muted }
            }
            Progress(value: todoPercent, label: "todo")
          }
        }
      }
    }

    // Priority breakdown
    Card() {
      block {
        padding: spacing.5
        layout: vertical, gap: spacing.4

        text("Priority Breakdown") { style: type.heading-md, letter-spacing: "-0.01em" }

        block {
          layout: vertical, gap: spacing.3

          block {
            padding: spacing.3
            background: semantic.error-bg
            border-radius: radius.md
            border-left: borders.accent-error
            layout: horizontal, gap: spacing.3, align: center, justify: between
            transition: transition.subtle
            on hover {
              transform: transform.nudge-right
            }
            block {
              layout: horizontal, gap: spacing.2, align: center
              Icon(name: "alert-triangle", size: icon.sm, color: semantic.destructive)
              text("High Priority") { style: type.body-md, weight: 500 }
            }
            Badge(text: "{highCount}", variant: "error")
          }

          block {
            padding: spacing.3
            background: semantic.warning-light
            border-radius: radius.md
            border-left: borders.accent-warning
            layout: horizontal, gap: spacing.3, align: center, justify: between
            transition: transition.subtle
            on hover {
              transform: transform.nudge-right
            }
            block {
              layout: horizontal, gap: spacing.2, align: center
              Icon(name: "info", size: icon.sm, color: semantic.warning)
              text("Medium Priority") { style: type.body-md, weight: 500 }
            }
            Badge(text: "{mediumCount}", variant: "warning")
          }

          block {
            padding: spacing.3
            background: semantic.success-light
            border-radius: radius.md
            border-left: borders.accent-success
            layout: horizontal, gap: spacing.3, align: center, justify: between
            transition: transition.subtle
            on hover {
              transform: transform.nudge-right
            }
            block {
              layout: horizontal, gap: spacing.2, align: center
              Icon(name: "check", size: icon.sm, color: semantic.success)
              text("Low Priority") { style: type.body-md, weight: 500 }
            }
            Badge(text: "{lowCount}", variant: "success")
          }
        }
      }
    }
  }

  // Workload distribution — full width
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Workload Distribution") { style: type.heading-md, letter-spacing: "-0.01em" }

      block {
        layout: grid, columns: responsive("1fr", md: "1fr 1fr 1fr"), gap: spacing.4

        block {
          padding: spacing.4
          background: gradient.stat-primary-subtle
          border-radius: radius.md
          transition: transition.scale
          layout: vertical, gap: spacing.2, align: center
          on hover {
            transform: transform.grow-sm
          }
          Icon(name: "user", size: icon.lg, color: semantic.interactive)
          Stat(value: "{aliceCount}", label: "Alice's tasks")
        }

        block {
          padding: spacing.4
          background: gradient.stat-success-subtle
          border-radius: radius.md
          transition: transition.scale
          layout: vertical, gap: spacing.2, align: center
          on hover {
            transform: transform.grow-sm
          }
          Icon(name: "user", size: icon.lg, color: semantic.success)
          Stat(value: "{bobCount}", label: "Bob's tasks")
        }

        block {
          padding: spacing.4
          background: gradient.stat-warning-subtle
          border-radius: radius.md
          transition: transition.scale
          layout: vertical, gap: spacing.2, align: center
          on hover {
            transform: transform.grow-sm
          }
          Icon(name: "user", size: icon.lg, color: semantic.warning)
          Stat(value: "{carolCount}", label: "Carol's tasks")
        }
      }
    }
  }
}
