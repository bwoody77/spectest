// FeatureTest — verifies all implemented priorities P1-P8
//
// P1: Component Declarations — @children, @slot("name"), @watch, default params
// P2: Client-side routing (@router) — see "Routing" in sidebar for full demo
// P3: Icon system — Icon component with size/color, @icons namespace declaration
// P4: Data Visualization (Chart) — five chart types, reactive data
// P5: SSR — deferred, not yet implemented
// P6: Form Validation (@form) — see "Form Validation" in sidebar for full demo
// P7: Drag & Drop (Sortable, KanbanBoard) — see "Drag & Drop" for full demo
// P8: match statement — expression and surface-level lazy mounting

// ── Helper components for P1 demo ─────────────────────────────────────────

component InfoBox(title: string = "Info Box") {
  block {
    border: borders.default
    border-radius: radius.md
    padding: spacing.4
    background: semantic.surface-raised
    layout: vertical, gap: spacing.2
    text(title) { style: type.label-sm, color: semantic.text-secondary }
    @children
  }
}

component SplitRow() {
  block {
    layout: horizontal, gap: spacing.4
    block {
      grow: true
      @slot("left")
    }
    block {
      grow: true
      @slot("right")
    }
  }
}

component CountDisplay(value: number) {
  @state { changes: 0 }
  @watch {
    value: { changes = changes + 1 }
  }
  block {
    padding: spacing.3
    background: semantic.surface-raised
    border-radius: radius.md
    border: borders.default
    layout: vertical, gap: spacing.1
    text("Received value: {value}") { style: type.body-md, color: semantic.text-primary }
    text("@watch fired {changes} time(s)") { style: type.body-sm, color: semantic.interactive }
  }
}

// ── Main surface ───────────────────────────────────────────────────────────

surface FeatureTest() {
  @state {
    activeTab: "p1"
    matchValue: "A"
    counter: 0
  }

  @computed {
    isP1: activeTab == "p1"
    isP2: activeTab == "p2"
    isP3: activeTab == "p3"
    isP4: activeTab == "p4"
    isP6: activeTab == "p6"
    isP7: activeTab == "p7"
    isP8: activeTab == "p8"

    matchResult: match matchValue {
      "A" -> "Arm 'A' matched — the match expression chose this literal arm.",
      "B" -> "Arm 'B' matched — second arm works.",
      "C" -> "Arm 'C' matched — third arm works.",
      _ -> "Wildcard arm matched — no literal arm for this value."
    }

    counterLabel: match counter {
      0 -> "zero",
      1 -> "one",
      2 -> "two",
      3 -> "three",
      _ -> "many"
    }
  }

  @actions {
    setTab(t) { activeTab = t }
    setMatch(v) { matchValue = v }
    increment() { counter = counter + 1 }
    resetCounter() { counter = 0 }
    noOp(items) { }
  }

  layout: vertical, gap: spacing.5

  text("Feature Test — P1 through P8") { style: type.heading-lg, color: semantic.text-primary }
  text("Verify each completed priority. Use the tabs to navigate between features. P5 (SSR) was deferred.") {
    style: type.body-md
    color: semantic.text-secondary
  }

  // Tab bar
  block {
    layout: horizontal, gap: spacing.2

    block {
      padding: "6px 12px"
      border-radius: radius.md
      cursor: "pointer"
      background: isP1 ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setTab("p1")
      text("P1 · Slots") { style: type.body-sm, color: isP1 ? "#fff" : semantic.text-primary }
    }
    block {
      padding: "6px 12px"
      border-radius: radius.md
      cursor: "pointer"
      background: isP2 ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setTab("p2")
      text("P2 · Router") { style: type.body-sm, color: isP2 ? "#fff" : semantic.text-primary }
    }
    block {
      padding: "6px 12px"
      border-radius: radius.md
      cursor: "pointer"
      background: isP3 ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setTab("p3")
      text("P3 · Icons") { style: type.body-sm, color: isP3 ? "#fff" : semantic.text-primary }
    }
    block {
      padding: "6px 12px"
      border-radius: radius.md
      cursor: "pointer"
      background: isP4 ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setTab("p4")
      text("P4 · Charts") { style: type.body-sm, color: isP4 ? "#fff" : semantic.text-primary }
    }
    block {
      padding: "6px 12px"
      border-radius: radius.md
      cursor: "pointer"
      background: isP6 ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setTab("p6")
      text("P6 · @form") { style: type.body-sm, color: isP6 ? "#fff" : semantic.text-primary }
    }
    block {
      padding: "6px 12px"
      border-radius: radius.md
      cursor: "pointer"
      background: isP7 ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setTab("p7")
      text("P7 · Drag") { style: type.body-sm, color: isP7 ? "#fff" : semantic.text-primary }
    }
    block {
      padding: "6px 12px"
      border-radius: radius.md
      cursor: "pointer"
      background: isP8 ? semantic.primary : semantic.surface-raised
      border: borders.default
      on click: setTab("p8")
      text("P8 · match") { style: type.body-sm, color: isP8 ? "#fff" : semantic.text-primary }
    }
  }

  // ── P1: Component Declarations ──────────────────────────────────────────
  block {
    visibility: isP1
    layout: vertical, gap: spacing.5

    text("P1 — Component Declarations") { style: type.heading-sm, color: semantic.text-primary }

    // @children demo
    block {
      layout: vertical, gap: spacing.3

      text("@children — default slot") { style: type.label-sm, color: semantic.text-secondary }

      InfoBox(title: "Custom Title (prop)") {
        text("This content was passed from the call site and rendered at @children.") {
          style: type.body-sm
          color: semantic.text-primary
        }
      }

      InfoBox() {
        text("Default title used — 'title' param defaulted to \"Info Box\".") {
          style: type.body-sm
          color: semantic.text-primary
        }
      }
    }

    // @slot("name") demo
    block {
      layout: vertical, gap: spacing.3

      text("@slot(\"name\") — named slots") { style: type.label-sm, color: semantic.text-secondary }

      SplitRow() {
        slot("left") {
          block {
            padding: spacing.3
            background: "#ede9fe"
            border-radius: radius.sm
            layout: vertical, gap: spacing.1
            text("Left slot") { style: type.label-sm, color: "#7c3aed" }
            text("Content from slot(\"left\") \{ \} at call site.") { style: type.body-sm, color: "#7c3aed" }
          }
        }
        slot("right") {
          block {
            padding: spacing.3
            background: "#dcfce7"
            border-radius: radius.sm
            layout: vertical, gap: spacing.1
            text("Right slot") { style: type.label-sm, color: "#166534" }
            text("Content from slot(\"right\") \{ \} at call site.") { style: type.body-sm, color: "#166534" }
          }
        }
      }
    }

    // @watch demo
    block {
      layout: vertical, gap: spacing.3

      text("@watch — prop change watcher") { style: type.label-sm, color: semantic.text-secondary }
      text("CountDisplay watches its 'value' prop and tracks how many times it changed.") {
        style: type.body-sm
        color: semantic.text-secondary
      }

      block {
        layout: horizontal, gap: spacing.4, align: "center"

        CountDisplay(value: counter)

        block {
          layout: horizontal, gap: spacing.2

          block {
            padding: "8px 16px"
            border-radius: radius.md
            cursor: "pointer"
            background: semantic.primary
            on click: increment()
            text("Increment ({counter})") { color: "#fff" }
          }

          block {
            padding: "8px 16px"
            border-radius: radius.md
            cursor: "pointer"
            background: semantic.surface-raised
            border: borders.default
            on click: resetCounter()
            text("Reset") { color: semantic.text-primary }
          }
        }
      }
    }
  }

  // ── P2: Routing ──────────────────────────────────────────────────────────
  block {
    visibility: isP2
    layout: vertical, gap: spacing.4

    text("P2 — Client-Side Routing (@router)") { style: type.heading-sm, color: semantic.text-primary }
    text("The @router block generates _routePath, _routeParams, and navigate() for path-based routing without a page reload.") {
      style: type.body-md
      color: semantic.text-secondary
    }

    block {
      layout: vertical, gap: spacing.2
      padding: spacing.4
      background: semantic.surface-raised
      border-radius: radius.md
      border: borders.default

      text("Generated by @router:") { style: type.label-sm, color: semantic.text-primary }
      text("_routePath — current URL pathname (string signal)") { style: type.body-sm, color: semantic.text-secondary }
      text("_routeParams — object with :param values extracted from the URL") { style: type.body-sm, color: semantic.text-secondary }
      text("navigate(path) — action: calls history.pushState + updates signals") { style: type.body-sm, color: semantic.text-secondary }
      text("Back/forward handled via popstate listener (auto-generated)") { style: type.body-sm, color: semantic.text-secondary }
    }

    block {
      padding: spacing.4
      background: "#f0fdf4"
      border-radius: radius.md
      border: "1px solid #bbf7d0"
      text("Navigate to Components > Routing in the sidebar for the full interactive demo with sidebar navigation, user detail routes, and 404 fallback.") {
        style: type.body-sm
        color: "#166534"
      }
    }
  }

  // ── P3: Icons ─────────────────────────────────────────────────────────────
  block {
    visibility: isP3
    layout: vertical, gap: spacing.4

    text("P3 — Icon System") { style: type.heading-sm, color: semantic.text-primary }
    text("The Icon component renders SVG icons by name. The @icons declaration enables namespaced external icon providers.") {
      style: type.body-md
      color: semantic.text-secondary
    }

    block {
      layout: vertical, gap: spacing.3

      text("Icon component — name, size, color props:") { style: type.label-sm, color: semantic.text-secondary }

      block {
        layout: horizontal, gap: spacing.5, align: "center"

        block {
          layout: vertical, gap: spacing.2, align: "center"
          Icon(name: "home", size: 32, color: semantic.primary)
          text("home") { style: type.body-sm, color: semantic.text-secondary }
        }
        block {
          layout: vertical, gap: spacing.2, align: "center"
          Icon(name: "settings", size: 32, color: "#f59e0b")
          text("settings") { style: type.body-sm, color: semantic.text-secondary }
        }
        block {
          layout: vertical, gap: spacing.2, align: "center"
          Icon(name: "user", size: 32, color: "#10b981")
          text("user") { style: type.body-sm, color: semantic.text-secondary }
        }
        block {
          layout: vertical, gap: spacing.2, align: "center"
          Icon(name: "bell", size: 32, color: "#ef4444")
          text("bell") { style: type.body-sm, color: semantic.text-secondary }
        }
        block {
          layout: vertical, gap: spacing.2, align: "center"
          Icon(name: "star", size: 32, color: "#6366f1")
          text("star") { style: type.body-sm, color: semantic.text-secondary }
        }
        block {
          layout: vertical, gap: spacing.2, align: "center"
          Icon(name: "zap", size: 32, color: "#f59e0b")
          text("zap") { style: type.body-sm, color: semantic.text-secondary }
        }
      }

      text("Size variants (16 / 24 / 32 / 48 px):") { style: type.label-sm, color: semantic.text-secondary }

      block {
        layout: horizontal, gap: spacing.4, align: "center"
        Icon(name: "check-circle", size: 16, color: "#10b981")
        Icon(name: "check-circle", size: 24, color: "#10b981")
        Icon(name: "check-circle", size: 32, color: "#10b981")
        Icon(name: "check-circle", size: 48, color: "#10b981")
      }

      text("@icons declaration (namespaced providers):") { style: type.label-sm, color: semantic.text-secondary }

      block {
        padding: spacing.3
        background: semantic.surface-raised
        border-radius: radius.md
        border: borders.default
        layout: vertical, gap: spacing.1
        text("@icons \{ lucide: '@spec/icons-lucide' (default) \}") { style: type.code, color: semantic.text-primary }
        text("// Usage: Icon(name: \"lucide:arrow-right\")") { style: type.code, color: semantic.text-secondary }
      }
    }
  }

  // ── P4: Charts ────────────────────────────────────────────────────────────
  block {
    visibility: isP4
    layout: vertical, gap: spacing.4

    text("P4 — Data Visualization (Chart)") { style: type.heading-sm, color: semantic.text-primary }
    text("Built-in SVG charts — line, bar, area, pie, donut. Zero external dependencies. Responsive via ResizeObserver.") {
      style: type.body-md
      color: semantic.text-secondary
    }

    // Mini bar chart showing priority status
    Chart(
      type: "bar",
      data: [
        {label: "P1", done: 1, skipped: 0},
        {label: "P2", done: 1, skipped: 0},
        {label: "P3", done: 1, skipped: 0},
        {label: "P4", done: 1, skipped: 0},
        {label: "P5", done: 0, skipped: 1},
        {label: "P6", done: 1, skipped: 0},
        {label: "P7", done: 1, skipped: 0},
        {label: "P8", done: 1, skipped: 0}
      ],
      xKey: "label",
      series: [
        {key: "done",    label: "Done",    color: "#10b981"},
        {key: "skipped", label: "Deferred", color: "#f59e0b"}
      ],
      height: "200px",
      showGrid: true,
      showLegend: true,
      showValues: true
    )

    text("Supported types: line · bar · area · pie · donut") {
      style: type.body-sm
      color: semantic.text-secondary
    }

    block {
      padding: spacing.4
      background: "#f0fdf4"
      border-radius: radius.md
      border: "1px solid #bbf7d0"
      text("Navigate to Components > Charts in the sidebar for the full interactive demo with all five chart types.") {
        style: type.body-sm
        color: "#166534"
      }
    }
  }

  // ── P6: @form ─────────────────────────────────────────────────────────────
  block {
    visibility: isP6
    layout: vertical, gap: spacing.4

    text("P6 — Form Validation (@form)") { style: type.heading-sm, color: semantic.text-primary }
    text("The @form block generates field-level validation signals and actions with zero boilerplate.") {
      style: type.body-md
      color: semantic.text-secondary
    }

    block {
      layout: horizontal, gap: spacing.4, align: "flex-start"

      block {
        grow: true
        padding: spacing.4
        background: semantic.surface-raised
        border-radius: radius.md
        border: borders.default
        layout: vertical, gap: spacing.2

        text("Per-field signals (e.g. for field 'email'):") { style: type.label-sm, color: semantic.text-primary }
        text("_fld_email_touched — bool, true after blur or submit attempt") { style: type.body-sm, color: semantic.text-secondary }
        text("_fld_email_error — null | error string (first failing validator)") { style: type.body-sm, color: semantic.text-secondary }
      }

      block {
        grow: true
        padding: spacing.4
        background: semantic.surface-raised
        border-radius: radius.md
        border: borders.default
        layout: vertical, gap: spacing.2

        text("Surface-wide signals and actions:") { style: type.label-sm, color: semantic.text-primary }
        text("_form_valid — true when all fields pass") { style: type.body-sm, color: semantic.text-secondary }
        text("_form_dirty — true when any field changed from initial") { style: type.body-sm, color: semantic.text-secondary }
        text("_form_submit_attempted — set by _submitForm()") { style: type.body-sm, color: semantic.text-secondary }
        text("_touchField(name), _submitForm(), _resetForm(), _formData()") { style: type.body-sm, color: semantic.text-secondary }
      }
    }

    block {
      padding: spacing.4
      background: semantic.surface-raised
      border-radius: radius.md
      border: borders.default
      layout: vertical, gap: spacing.1

      text("Built-in validators:") { style: type.label-sm, color: semantic.text-primary }
      text("required · email · min-length(n) · max-length(n) · min(n) · max(n) · pattern(\"regex\")") {
        style: type.body-sm
        color: semantic.text-secondary
      }
    }

    block {
      padding: spacing.4
      background: "#f0fdf4"
      border-radius: radius.md
      border: "1px solid #bbf7d0"
      text("Navigate to Components > Form Validation for the full interactive demo with live error display and form state inspector.") {
        style: type.body-sm
        color: "#166534"
      }
    }
  }

  // ── P7: Drag & Drop ───────────────────────────────────────────────────────
  block {
    visibility: isP7
    layout: vertical, gap: spacing.4

    text("P7 — Drag & Drop (Sortable, KanbanBoard)") { style: type.heading-sm, color: semantic.text-primary }
    text("HTML5 Drag and Drop — reorderable lists and multi-column kanban boards. Zero external dependencies.") {
      style: type.body-md
      color: semantic.text-secondary
    }

    text("Drag these rows to reorder:") { style: type.label-sm, color: semantic.text-secondary }

    Sortable(
      items: [
        {id: "1", name: "P1 — Component Declarations",  priority: "Done"},
        {id: "2", name: "P2 — Client-Side Routing",     priority: "Done"},
        {id: "3", name: "P3 — Icon System",             priority: "Done"},
        {id: "4", name: "P4 — Chart Component",         priority: "Done"},
        {id: "5", name: "P5 — Server-Side Rendering",   priority: "Deferred"},
        {id: "6", name: "P6 — Form Validation (@form)", priority: "Done"},
        {id: "7", name: "P7 — Drag & Drop",             priority: "Done"},
        {id: "8", name: "P8 — match statement",         priority: "Done"}
      ],
      labelKey: "name",
      badgeKey: "priority",
      badgeColors: {Done: "#dcfce7", Deferred: "#fef9c3"},
      onReorder: noOp,
      gap: "6px"
    )

    block {
      padding: spacing.4
      background: "#f0fdf4"
      border-radius: radius.md
      border: "1px solid #bbf7d0"
      text("Navigate to Components > Drag & Drop for the full demo including KanbanBoard with WIP limits and cross-column drag.") {
        style: type.body-sm
        color: "#166534"
      }
    }
  }

  // ── P8: match ─────────────────────────────────────────────────────────────
  block {
    visibility: isP8
    layout: vertical, gap: spacing.4

    text("P8 — match Statement") { style: type.heading-sm, color: semantic.text-primary }
    text("match works both as an expression (returns a value) and as a surface-level construct (lazily mounts one component arm).") {
      style: type.body-md
      color: semantic.text-secondary
    }

    // match as expression
    block {
      layout: vertical, gap: spacing.3

      text("match as expression — select an option:") { style: type.label-sm, color: semantic.text-secondary }

      block {
        layout: horizontal, gap: spacing.2

        block {
          padding: "6px 14px"
          border-radius: radius.md
          cursor: "pointer"
          background: matchValue == "A" ? semantic.primary : semantic.surface-raised
          border: borders.default
          on click: setMatch("A")
          text("A") { style: type.body-sm, color: matchValue == "A" ? "#fff" : semantic.text-primary }
        }
        block {
          padding: "6px 14px"
          border-radius: radius.md
          cursor: "pointer"
          background: matchValue == "B" ? semantic.primary : semantic.surface-raised
          border: borders.default
          on click: setMatch("B")
          text("B") { style: type.body-sm, color: matchValue == "B" ? "#fff" : semantic.text-primary }
        }
        block {
          padding: "6px 14px"
          border-radius: radius.md
          cursor: "pointer"
          background: matchValue == "C" ? semantic.primary : semantic.surface-raised
          border: borders.default
          on click: setMatch("C")
          text("C") { style: type.body-sm, color: matchValue == "C" ? "#fff" : semantic.text-primary }
        }
        block {
          padding: "6px 14px"
          border-radius: radius.md
          cursor: "pointer"
          background: matchValue == "D" ? semantic.primary : semantic.surface-raised
          border: borders.default
          on click: setMatch("D")
          text("D") { style: type.body-sm, color: matchValue == "D" ? "#fff" : semantic.text-primary }
        }
      }

      block {
        padding: spacing.4
        background: "#ede9fe"
        border-radius: radius.md
        border: "1px solid #c4b5fd"
        text(matchResult) { style: type.body-md, color: "#5b21b6" }
      }
    }

    // match with number arms
    block {
      layout: vertical, gap: spacing.3

      text("match with number arms and wildcard:") { style: type.label-sm, color: semantic.text-secondary }
      text("counter matched to a label: {counterLabel} (counter = {counter})") {
        style: type.body-md
        color: semantic.text-primary
      }

      block {
        layout: horizontal, gap: spacing.2

        block {
          padding: "8px 16px"
          border-radius: radius.md
          cursor: "pointer"
          background: semantic.primary
          on click: increment()
          text("Count up") { color: "#fff" }
        }

        block {
          padding: "8px 16px"
          border-radius: radius.md
          cursor: "pointer"
          background: semantic.surface-raised
          border: borders.default
          on click: resetCounter()
          text("Reset to 0") { color: semantic.text-primary }
        }
      }
    }

    // match as surface-level construct
    block {
      layout: vertical, gap: spacing.2

      text("match as surface-level construct:") { style: type.label-sm, color: semantic.text-secondary }
      text("Used throughout app.spec — viewTitle and breadcrumbSection are both match expressions over 'view'.") {
        style: type.body-sm
        color: semantic.text-secondary
      }
      block {
        padding: spacing.3
        background: semantic.surface-raised
        border-radius: radius.md
        border: borders.default
        layout: vertical, gap: spacing.1
        text("viewTitle: match view \{") { style: type.code, color: semantic.text-primary }
        text("  \"dashboard\" -> \"Dashboard\",") { style: type.code, color: semantic.text-primary }
        text("  \"charts\"    -> \"Charts\",") { style: type.code, color: semantic.text-primary }
        text("  _ -> \"Admin\"") { style: type.code, color: semantic.text-primary }
        text("\}") { style: type.code, color: semantic.text-primary }
      }
    }
  }
}
