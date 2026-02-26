// ============================================================================
// Spec Test App — exercises state, bindings, actions, each, visibility,
// computed, blocks, layout, and event handlers across multiple surfaces.
// ============================================================================

// ---------------------------------------------------------------------------
// Surface: Counter — state, computed, actions, visibility, click events
// ---------------------------------------------------------------------------
surface Counter() {
  @state {
    count: 0
  }

  @computed {
    doubled: count * 2
    isPositive: count > 0
    isNegative: count < 0
    label: count == 1 ? "click" : "clicks"
  }

  @actions {
    increment() { count = count + 1 }
    decrement() { count = count - 1 }
    reset() { count = 0 }
    add(n) { count = count + n }
  }

  text("Counter") {
    style: type.heading-md
  }

  // Current count display
  block {
    layout: horizontal, gap: spacing.2, align: center

    text(count) {
      style: type.display-md
    }

    text(label) {
      style: type.body-md
    }
  }

  // Doubled display
  block {
    layout: horizontal, gap: spacing.1, align: baseline

    text(doubled) {
      style: type.heading-sm
    }

    text("(doubled)") {
      style: type.label-sm
    }
  }

  // Action buttons row
  block {
    layout: horizontal, gap: spacing.2

    block {
      text("- 1") { style: type.label-md }
      on click: decrement()
    }

    block {
      text("+ 1") { style: type.label-md }
      on click: increment()
    }

    block {
      text("+ 5") { style: type.label-md }
      on click: add(5)
    }

    block {
      text("+ 10") { style: type.label-md }
      on click: add(10)
    }
  }

  // Reset button — only visible when count != 0
  block {
    text("Reset to zero") { style: type.label-md }
    on click: reset()
    visibility: count != 0
  }

  // Positive indicator — conditional visibility
  block {
    text("Count is positive") { style: type.body-sm }
    visibility: isPositive
  }

  // Negative indicator — conditional visibility
  block {
    text("Count is negative") { style: type.body-sm }
    visibility: isNegative
  }
}

// ---------------------------------------------------------------------------
// Surface: ItemList — each loops, visibility, nested blocks
// ---------------------------------------------------------------------------
surface ItemList() {
  @state {
    items: [
      { id: 1, text: "Learn the Spec language", done: false },
      { id: 2, text: "Build a test app", done: true },
      { id: 3, text: "Run spec dev", done: false },
      { id: 4, text: "Validate hot reload", done: false },
      { id: 5, text: "Cross-browser test", done: false }
    ]
    showCompleted: true
  }

  @computed {
    totalCount: items.length
  }

  @actions {
    toggleShowCompleted() {
      showCompleted = !showCompleted
    }
  }

  text("Checklist") {
    style: type.heading-md
  }

  // Item count
  block {
    layout: horizontal, gap: spacing.1, align: baseline

    text(totalCount) {
      style: type.heading-sm
    }

    text("items total") {
      style: type.body-sm
    }
  }

  // Toggle completed visibility
  block {
    text("Toggle completed items") { style: type.label-md }
    on click: toggleShowCompleted()
  }

  // Item list using each loop
  block {
    layout: vertical, gap: spacing.2

    each items as item {
      block {
        layout: horizontal, gap: spacing.2, align: center

        text(item.done ? "DONE" : "TODO") {
          style: type.label-xs
          weight: 700
        }

        text(item.text) {
          style: type.body-md
        }
      }
    }
  }

  // Show/hide completed status
  block {
    text("Completed items are visible") { style: type.label-sm }
    visibility: showCompleted
  }

  block {
    text("Completed items are hidden") { style: type.label-sm }
    visibility: !showCompleted
  }
}

// ---------------------------------------------------------------------------
// Surface: TabPanel — tab switching via state + visibility
// ---------------------------------------------------------------------------
surface TabPanel() {
  @state {
    activeTab: "overview"
  }

  @actions {
    switchTab(tab) { activeTab = tab }
  }

  text("Tabbed Panel") {
    style: type.heading-md
  }

  // Tab buttons
  block {
    layout: horizontal, gap: spacing.3

    block {
      text("Overview") { style: type.label-md }
      on click: switchTab("overview")
    }

    block {
      text("Details") { style: type.label-md }
      on click: switchTab("details")
    }

    block {
      text("Settings") { style: type.label-md }
      on click: switchTab("settings")
    }
  }

  // Active tab indicator
  block {
    layout: horizontal, gap: spacing.1, align: baseline

    text("Active tab:") {
      style: type.label-sm
    }

    text(activeTab) {
      style: type.heading-xs
    }
  }

  // Tab content — only one visible at a time
  block {
    text("This is the Overview panel. It shows a summary of your project status.") {
      style: type.body-md
    }
    visibility: activeTab == "overview"
  }

  block {
    layout: vertical, gap: spacing.2

    text("Detail View") {
      style: type.heading-sm
    }

    text("Here you would see detailed information about selected items.") {
      style: type.body-md
    }

    text("This panel demonstrates multi-line content in a visibility-gated block.") {
      style: type.body-sm
    }

    visibility: activeTab == "details"
  }

  block {
    text("Settings panel — configure your preferences here.") {
      style: type.body-md
    }
    visibility: activeTab == "settings"
  }
}

// ---------------------------------------------------------------------------
// Surface: App — top-level composition
// ---------------------------------------------------------------------------
surface App() {
  @state {
    appReady: true
  }

  layout: vertical, gap: spacing.4

  text("Spec Framework Test") {
    style: type.heading-lg
  }

  // Ready indicator
  block {
    text("App loaded and reactive") { style: type.body-sm }
    visibility: appReady
  }

  // Composed sections
  Counter()
  ItemList()
  TabPanel()
}
