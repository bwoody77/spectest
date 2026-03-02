// ThemePreview — Component showcase for comparing theme styles
// Shows: buttons, inputs, selects, checkboxes, toggles, progress, badges, tabs, stepper, typography

surface ThemePreview() {
  @state {
    inputValue: ""
    selectValue: ""
    checkboxChecked: false
    toggleChecked: false
    activeTab: "overview"
    stepperStep: 1
    pickedDate: null
  }

  @computed {
    progressValue: 65
    progressHalf: 40
  }

  @actions {
    setInput(v) { inputValue = v }
    setSelect(v) { selectValue = v }
    setCheckbox(v) { checkboxChecked = v }
    setToggle(v) { toggleChecked = v }
    setTab(id) { activeTab = id }
    nextStep() { stepperStep = stepperStep < 4 ? stepperStep + 1 : 1 }
    prevStep() { stepperStep = stepperStep > 1 ? stepperStep - 1 : 1 }
    setDate(d) { pickedDate = d }
  }

  layout: vertical, gap: spacing.5

  // Title
  text("Component Showcase") { style: type.heading-lg, color: semantic.text-primary }
  text("Switch themes above to compare how each one styles these components.") {
    style: type.body-md
    color: semantic.text-secondary
  }

  // ===== Buttons =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Buttons") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: horizontal, gap: spacing.3, align: center
        Button(label: "Primary", variant: "primary") {}
        Button(label: "Secondary", variant: "secondary") {}
        Button(label: "Ghost", variant: "ghost") {}
        Button(label: "Destructive", variant: "destructive") {}
      }
      block {
        layout: horizontal, gap: spacing.3, align: center
        Button(label: "Disabled", variant: "primary", disabled: true) {}
        Button(label: "Loading", variant: "primary", loading: true) {}
        Button(label: "Small Ghost", variant: "ghost") {}
        Button(label: "Small Secondary", variant: "secondary") {}
      }
    }
  }

  // ===== Form Controls =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Form Controls") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: grid, columns: responsive("1fr", md: "1fr 1fr"), gap: spacing.4

        // Left: text inputs + select
        block {
          layout: vertical, gap: spacing.3

          Input(type: "text", label: "Text Input", placeholder: "Type something...") {
            on change(v): setInput(v)
          }

          Input(type: "text", label: "With Value", value: "Hello World", placeholder: "Prefilled") {}

          Input(type: "text", label: "Error State", value: "bad input", error: true) {}

          DatePicker(label: "Pick a Date", placeholder: "Choose date...") {
            on change(d): setDate(d)
          }

          Select(
            label: "Dropdown",
            options: [
              {value: "react", label: "React"},
              {value: "vue", label: "Vue"},
              {value: "angular", label: "Angular"},
              {value: "svelte", label: "Svelte"}
            ],
            value: selectValue,
            placeholder: "Choose framework..."
          ) {
            on change(v): setSelect(v)
          }
        }

        // Right: checkboxes + toggles
        block {
          layout: vertical, gap: spacing.4

          text("Checkboxes") { style: type.label-md, color: semantic.text-secondary }
          Checkbox(label: "Accept terms", checked: checkboxChecked) {
            on change(v): setCheckbox(v)
          }
          Checkbox(label: "Subscribe to newsletter", checked: true) {}
          Checkbox(label: "Disabled option", disabled: true) {}

          text("Toggles") { style: type.label-md, color: semantic.text-secondary }
          Toggle(label: "Dark mode", checked: toggleChecked) {
            on change(v): setToggle(v)
          }
          Toggle(label: "Notifications", checked: true) {}
          Toggle(label: "Disabled toggle", disabled: true) {}
        }
      }
    }
  }

  // ===== Progress & Badges =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Progress & Badges") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: vertical, gap: spacing.3

        block {
          layout: horizontal, gap: spacing.3, align: center
          text("65%") { style: type.label-sm, color: semantic.text-secondary }
          block {
            grow: true
            Progress(value: progressValue, label: "Upload progress")
          }
        }

        block {
          layout: horizontal, gap: spacing.3, align: center
          text("40%") { style: type.label-sm, color: semantic.text-secondary }
          block {
            grow: true
            Progress(value: progressHalf, label: "Secondary progress")
          }
        }
      }

      block {
        layout: horizontal, gap: spacing.2, align: center
        Badge(text: "Info", variant: "info")
        Badge(text: "Success", variant: "success")
        Badge(text: "Warning", variant: "warning")
        Badge(text: "Error", variant: "error")
        Badge(text: "Neutral", variant: "neutral")
      }
    }
  }

  // ===== Tabs =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Tabs") { style: type.heading-sm, color: semantic.text-primary }

      Tabs(
        tabs: [
          {id: "overview", label: "Overview"},
          {id: "analytics", label: "Analytics"},
          {id: "settings", label: "Settings"},
          {id: "disabled", label: "Disabled", disabled: true}
        ],
        activeTab: activeTab
      ) {
        on change(id): setTab(id)
      }
    }
  }

  // ===== Stepper =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Stepper / Workflow") { style: type.heading-sm, color: semantic.text-primary }

      Stepper(
        steps: [
          {id: "1", label: "Account"},
          {id: "2", label: "Profile"},
          {id: "3", label: "Review"},
          {id: "4", label: "Complete"}
        ],
        activeStep: stepperStep
      )

      block {
        layout: horizontal, gap: spacing.3
        Button(label: "Previous", variant: "secondary") {
          on click: prevStep()
        }
        Button(label: "Next Step", variant: "primary") {
          on click: nextStep()
        }
      }
    }
  }

  // ===== Typography =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.3

      text("Typography") { style: type.heading-sm, color: semantic.text-primary }

      text("Display Large") { style: type.display-lg, color: semantic.text-primary }
      text("Heading Large") { style: type.heading-lg, color: semantic.text-primary }
      text("Heading Medium") { style: type.heading-md, color: semantic.text-primary }
      text("Heading Small") { style: type.heading-sm, color: semantic.text-primary }
      text("Body text — The quick brown fox jumps over the lazy dog. This is regular paragraph text that demonstrates the body font at its default size and weight.") {
        style: type.body-md
        color: semantic.text-secondary
      }
      text("Label Medium") { style: type.label-md, color: semantic.text-primary }
      text("Caption — supplementary information") { style: type.caption, color: semantic.text-tertiary }
    }
  }

  // ===== Alerts =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.3

      text("Alerts") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: horizontal, gap: spacing.4

        block {
          grow: true
          layout: vertical, gap: spacing.3
          text("Built-in (TS)") { style: type.label-sm, color: semantic.text-tertiary }
          Alert(severity: "success", message: "Operation completed.", title: "Success")
          Alert(severity: "error", message: "Something went wrong.", title: "Error")
          Alert(severity: "warning", message: "Cannot be undone.", title: "Warning")
          Alert(severity: "info", message: "New features available.", title: "Info")
        }

        block {
          grow: true
          layout: vertical, gap: spacing.3
          text("Spec Component") { style: type.label-sm, color: semantic.text-tertiary }
          Alert2(severity: "success", message: "Operation completed.", title: "Success")
          Alert2(severity: "error", message: "Something went wrong.", title: "Error")
          Alert2(severity: "warning", message: "Cannot be undone.", title: "Warning")
          Alert2(severity: "info", message: "New features available.", title: "Info")
        }
      }
    }
  }
}
