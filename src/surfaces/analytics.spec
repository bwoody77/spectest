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
    highCount: taskList.filter(t -> t.priority == "high").length
    mediumCount: taskList.filter(t -> t.priority == "medium").length
    lowCount: taskList.filter(t -> t.priority == "low").length

    aliceCount: taskList.filter(t -> t.assignee == "Alice").length
    bobCount: taskList.filter(t -> t.assignee == "Bob").length
    carolCount: taskList.filter(t -> t.assignee == "Carol").length
  }

  layout: vertical, gap: spacing.6

  block {
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "bar-chart", size: "20px", color: "#6366f1")
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
        background: "linear-gradient(135deg, #eef2ff, #c7d2fe)"
        border-radius: radius.lg
        transition: "transform 200ms ease, shadow 200ms ease"
        cursor: "pointer"
        layout: vertical, gap: spacing.3, align: center

        on hover {
          transform: "translateY(-3px)"
          shadow: elevation.floating
        }

        Icon(name: "list", size: "32px", color: "#6366f1")
        Stat(value: "{total}", label: "Total Tasks")
      }
    }

    Card() {
      block {
        padding: spacing.5
        background: "linear-gradient(135deg, #ecfdf5, #a7f3d0)"
        border-radius: radius.lg
        transition: "transform 200ms ease, shadow 200ms ease"
        cursor: "pointer"
        layout: vertical, gap: spacing.3, align: center

        on hover {
          transform: "translateY(-3px)"
          shadow: elevation.floating
        }

        Icon(name: "check", size: "32px", color: "#10b981")
        Stat(value: "{done}", label: "Completed")
      }
    }

    Card() {
      block {
        padding: spacing.5
        background: "linear-gradient(135deg, #fffbeb, #fde68a)"
        border-radius: radius.lg
        transition: "transform 200ms ease, shadow 200ms ease"
        cursor: "pointer"
        layout: vertical, gap: spacing.3, align: center

        on hover {
          transform: "translateY(-3px)"
          shadow: elevation.floating
        }

        Icon(name: "loader", size: "32px", color: "#f59e0b")
        Stat(value: "{inProgress}", label: "In Progress")
      }
    }

    Card() {
      block {
        padding: spacing.5
        background: "linear-gradient(135deg, #f8fafc, #cbd5e1)"
        border-radius: radius.lg
        transition: "transform 200ms ease, shadow 200ms ease"
        cursor: "pointer"
        layout: vertical, gap: spacing.3, align: center

        on hover {
          transform: "translateY(-3px)"
          shadow: elevation.floating
        }

        Icon(name: "circle", size: "32px", color: "#64748b")
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
              text("Completed") { style: type.label-sm, color: "#065f46", text-transform: "uppercase", letter-spacing: "0.05em" }
              text("{done}") { style: type.label-md, weight: 700, color: "#10b981" }
            }
            Progress(value: donePercent, label: "done")
          }

          block {
            layout: vertical, gap: spacing.2
            block {
              layout: horizontal, gap: spacing.2, align: center, justify: between
              text("In Progress") { style: type.label-sm, color: "#92400e", text-transform: "uppercase", letter-spacing: "0.05em" }
              text("{inProgress}") { style: type.label-md, weight: 700, color: "#f59e0b" }
            }
            Progress(value: inProgressPercent, label: "in progress")
          }

          block {
            layout: vertical, gap: spacing.2
            block {
              layout: horizontal, gap: spacing.2, align: center, justify: between
              text("Todo") { style: type.label-sm, color: "#334155", text-transform: "uppercase", letter-spacing: "0.05em" }
              text("{todo}") { style: type.label-md, weight: 700, color: "#64748b" }
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
            background: "#fef2f2"
            border-radius: radius.md
            border-left: "3px solid #ef4444"
            layout: horizontal, gap: spacing.3, align: center, justify: between
            transition: "transform 150ms ease"
            on hover {
              transform: "translateX(4px)"
            }
            block {
              layout: horizontal, gap: spacing.2, align: center
              Icon(name: "alert-triangle", size: "18px", color: "#ef4444")
              text("High Priority") { style: type.body-md, weight: 500 }
            }
            Badge(text: "{highCount}", variant: "error")
          }

          block {
            padding: spacing.3
            background: "#fffbeb"
            border-radius: radius.md
            border-left: "3px solid #f59e0b"
            layout: horizontal, gap: spacing.3, align: center, justify: between
            transition: "transform 150ms ease"
            on hover {
              transform: "translateX(4px)"
            }
            block {
              layout: horizontal, gap: spacing.2, align: center
              Icon(name: "info", size: "18px", color: "#f59e0b")
              text("Medium Priority") { style: type.body-md, weight: 500 }
            }
            Badge(text: "{mediumCount}", variant: "warning")
          }

          block {
            padding: spacing.3
            background: "#ecfdf5"
            border-radius: radius.md
            border-left: "3px solid #10b981"
            layout: horizontal, gap: spacing.3, align: center, justify: between
            transition: "transform 150ms ease"
            on hover {
              transform: "translateX(4px)"
            }
            block {
              layout: horizontal, gap: spacing.2, align: center
              Icon(name: "check", size: "18px", color: "#10b981")
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
          background: "linear-gradient(135deg, #eef2ff, #e0e7ff)"
          border-radius: radius.md
          transition: "transform 200ms ease"
          layout: vertical, gap: spacing.2, align: center
          on hover {
            transform: "scale(1.02)"
          }
          Icon(name: "user", size: "24px", color: "#6366f1")
          Stat(value: "{aliceCount}", label: "Alice's tasks")
        }

        block {
          padding: spacing.4
          background: "linear-gradient(135deg, #ecfdf5, #d1fae5)"
          border-radius: radius.md
          transition: "transform 200ms ease"
          layout: vertical, gap: spacing.2, align: center
          on hover {
            transform: "scale(1.02)"
          }
          Icon(name: "user", size: "24px", color: "#10b981")
          Stat(value: "{bobCount}", label: "Bob's tasks")
        }

        block {
          padding: spacing.4
          background: "linear-gradient(135deg, #fffbeb, #fef3c7)"
          border-radius: radius.md
          transition: "transform 200ms ease"
          layout: vertical, gap: spacing.2, align: center
          on hover {
            transform: "scale(1.02)"
          }
          Icon(name: "user", size: "24px", color: "#f59e0b")
          Stat(value: "{carolCount}", label: "Carol's tasks")
        }
      }
    }
  }
}
