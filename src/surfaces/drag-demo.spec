// DragDemo — demonstrates Sortable and KanbanBoard components.
//
// Sortable — a drag-and-drop reorderable list. Accepts an items array and
// a renderItem callback. Fires onReorder with the new sorted array whenever
// the user drops an item in a new position.
//
// KanbanBoard — a multi-column drag-and-drop board. Items can be reordered
// within a column and dragged between columns. Fires onMove with the card ID,
// source column, destination column, and insert index.
//
// Usage:
//   Sortable(items: [...], renderItem: (el, item) => { ... }, onReorder: fn)
//   KanbanBoard(columns: [...], onMove: fn)

surface DragDemo() {
  @state {
    activeDemo: "sortable"
    sortableItems: [
      {id: "1", name: "Design system tokens", priority: "High"},
      {id: "2", name: "Implement auth flow", priority: "Critical"},
      {id: "3", name: "Write API tests", priority: "Medium"},
      {id: "4", name: "Update documentation", priority: "Low"},
      {id: "5", name: "Performance audit", priority: "Medium"},
      {id: "6", name: "Accessibility review", priority: "High"}
    ]
    lastReorder: ""
    kanbanColumns: [
      {id: "backlog", title: "Backlog", color: "#f3f4f6", items: [
        {id: "k1", title: "Research competitors", tag: "Research"},
        {id: "k2", title: "Define MVP scope",     tag: "Planning"},
        {id: "k3", title: "Set up CI/CD",         tag: "Infra"}
      ]},
      {id: "todo", title: "To Do", color: "#ede9fe", items: [
        {id: "k4", title: "Design login page",   tag: "Design"},
        {id: "k5", title: "Create data models",  tag: "Backend"}
      ]},
      {id: "progress", title: "In Progress", color: "#dbeafe", limit: 3, items: [
        {id: "k6", title: "Build dashboard",     tag: "Frontend"},
        {id: "k7", title: "API integration",     tag: "Backend"}
      ]},
      {id: "review", title: "Review", color: "#fef9c3", items: [
        {id: "k8", title: "User onboarding UX",  tag: "Design"}
      ]},
      {id: "done", title: "Done", color: "#dcfce7", items: [
        {id: "k9",  title: "Project kickoff",    tag: "Planning"},
        {id: "k10", title: "Tech stack decision", tag: "Infra"}
      ]}
    ]
    lastMove: ""
  }

  @computed {
    isSortable: activeDemo == "sortable"
    isKanban: activeDemo == "kanban"
  }

  @actions {
    setActiveDemo(d) { activeDemo = d }
    reorderItems(items) {
      sortableItems = items
      lastReorder = "Reordered to: " + items[0].name + " → " + items[items.length - 1].name
    }
    moveCard(cardId, fromCol, toCol, idx) {
      lastMove = "Moved card to " + toCol + " at position " + idx
    }
  }

  layout: vertical, gap: spacing.5

  text("Drag & Drop") { style: type.heading-lg, color: semantic.text-primary }
  text("Sortable lists and Kanban boards with HTML5 drag-and-drop. Zero external dependencies.") {
    style: type.body-md
    color: semantic.text-secondary
  }

  // Demo switcher
  block {
    layout: horizontal, gap: spacing.2

    block {
      padding: "6px 14px"
      border-radius: radius.md
      cursor: "pointer"
      background: isSortable ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setActiveDemo("sortable")
      text("Sortable List") { color: isSortable ? "#fff" : semantic.text-primary }
    }
    block {
      padding: "6px 14px"
      border-radius: radius.md
      cursor: "pointer"
      background: isKanban ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setActiveDemo("kanban")
      text("Kanban Board") { color: isKanban ? "#fff" : semantic.text-primary }
    }
  }

  // ── Sortable ─────────────────────────────────────────────────────────────
  block {
    visibility: activeDemo == "sortable"
    layout: vertical, gap: spacing.4

    block {
      layout: horizontal, gap: spacing.4, align: "flex-start"

      // Sortable list
      block {
        grow: true
        Card() {
          block {
            padding: spacing.5
            layout: vertical, gap: spacing.4

            block {
              layout: horizontal, justify: "space-between", align: "center"
              text("Task Priority Queue") { style: type.heading-sm, color: semantic.text-primary }
              text("Drag to reorder") { style: type.body-sm, color: semantic.text-tertiary }
            }

            Sortable(
              items: sortableItems,
              labelKey: "name",
              badgeKey: "priority",
              badgeColors: {Critical: "#fef2f2", High: "#fef9c3", Medium: "#ede9fe", Low: "#f0fdf4"},
              onReorder: reorderItems,
              gap: "6px"
            )
          }
        }
      }

      // Status panel
      block {
        width: 220px
        Card() {
          block {
            padding: spacing.5
            layout: vertical, gap: spacing.3

            text("How it works") { style: type.heading-sm, color: semantic.text-primary }
            text("Drag any row by its handle icon to change the order. The onReorder callback fires with the updated array.") {
              style: type.body-sm
              color: semantic.text-secondary
            }

            block {
              visibility: lastReorder != ""
              padding: spacing.3
              background: "#f0fdf4"
              border-radius: radius.md
              border: "1px solid #bbf7d0"
              text(lastReorder) { style: type.body-sm, color: "#166534" }
            }

            text("Items: {sortableItems.length}") { style: type.body-sm, color: semantic.text-tertiary }
          }
        }
      }
    }
  }

  // ── Kanban ────────────────────────────────────────────────────────────────
  block {
    visibility: activeDemo == "kanban"
    layout: vertical, gap: spacing.4

    block {
      layout: horizontal, justify: "space-between", align: "center"
      text("Project Board") { style: type.heading-sm, color: semantic.text-primary }
      block {
        layout: horizontal, gap: spacing.3, align: "center"
        text("Drag cards between columns. The In Progress column has a WIP limit of 3.") {
          style: type.body-sm
          color: semantic.text-secondary
        }
        block {
          visibility: lastMove != ""
          padding: "4px 12px"
          background: "#f0fdf4"
          border-radius: radius.md
          border: "1px solid #bbf7d0"
          text(lastMove) { style: type.body-sm, color: "#166534" }
        }
      }
    }

    block {
      overflow: "auto"
      KanbanBoard(
        columns: kanbanColumns,
        onMove: moveCard,
        columnWidth: "220px",
        showCount: true
      )
    }
  }
}
