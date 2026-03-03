// ThemePreview — Component showcase for comparing theme styles
// Shows: buttons, inputs, selects, checkboxes, toggles, progress, badges, tabs, stepper, typography

surface ThemePreview() {
  @state {
    inputValue: ""
    selectValue: ""
    checkboxChecked: false
    toggleChecked: false
    checkboxNewsletter: true
    toggleNotifications: true
    radioValue: "option1"
    activeTab: "overview"
    stepperStep: 1
    pickedDate: null
    modalOpen: false
    drawerOpen: false
    confirmOpen: false
    confirmDestructiveOpen: false
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
    setCheckboxNewsletter(v) { checkboxNewsletter = v }
    setToggleNotifications(v) { toggleNotifications = v }
    setRadio(v) { radioValue = v }
    setTab(id) { activeTab = id }
    nextStep() { stepperStep = stepperStep < 4 ? stepperStep + 1 : 1 }
    prevStep() { stepperStep = stepperStep > 1 ? stepperStep - 1 : 1 }
    setDate(d) { pickedDate = d }
    openModal() { modalOpen = true }
    closeModal() { modalOpen = false }
    openDrawer() { drawerOpen = true }
    closeDrawer() { drawerOpen = false }
    openConfirm() { confirmOpen = true }
    closeConfirm() { confirmOpen = false }
    openConfirmDestructive() { confirmDestructiveOpen = true }
    closeConfirmDestructive() { confirmDestructiveOpen = false }
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
        layout: vertical, gap: spacing.3
        block {
          layout: responsive(vertical, md: horizontal), gap: spacing.3, align: center
          Button(label: "Primary", variant: "primary")
          Button(label: "Secondary", variant: "secondary")
          Button(label: "Ghost", variant: "ghost")
          Button(label: "Destructive", variant: "destructive")
        }
        block {
          layout: responsive(vertical, md: horizontal), gap: spacing.3, align: center
          Button(label: "Disabled", variant: "primary", disabled: true)
          Button(label: "Loading", variant: "primary", loading: true)
        }
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
          Checkbox(label: "Subscribe to newsletter", checked: checkboxNewsletter) {
            on change(v): setCheckboxNewsletter(v)
          }
          Checkbox(label: "Disabled option", disabled: true)

          text("Toggles") { style: type.label-md, color: semantic.text-secondary }
          Toggle(label: "Dark mode", checked: toggleChecked) {
            on change(v): setToggle(v)
          }
          Toggle(label: "Notifications", checked: toggleNotifications) {
            on change(v): setToggleNotifications(v)
          }
          Toggle(label: "Disabled toggle", disabled: true)

          text("Radio Buttons") { style: type.label-md, color: semantic.text-secondary }
          Radio(label: "Option 1", value: "option1", checked: radioValue == "option1") {
            on change(v): setRadio(v)
          }
          Radio(label: "Option 2", value: "option2", checked: radioValue == "option2") {
            on change(v): setRadio(v)
          }
          Radio(label: "Option 3", value: "option3", checked: radioValue == "option3") {
            on change(v): setRadio(v)
          }
          Radio(label: "Disabled", value: "disabled", disabled: true)
        }
      }
    }
  }

  // ===== Progress =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Progress") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: grid, columns: responsive("1fr", md: "1fr 1fr"), gap: spacing.4

        block {
          layout: vertical, gap: spacing.3
          text("Built-in (TS)") { style: type.label-sm, color: semantic.text-tertiary }
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
          layout: vertical, gap: spacing.3
          text("Spec Component") { style: type.label-sm, color: semantic.text-tertiary }
          block {
            layout: horizontal, gap: spacing.3, align: center
            text("65%") { style: type.label-sm, color: semantic.text-secondary }
            block {
              grow: true
              Progress(value: progressValue)
            }
          }
          block {
            layout: horizontal, gap: spacing.3, align: center
            text("40%") { style: type.label-sm, color: semantic.text-secondary }
            block {
              grow: true
              Progress(value: progressHalf)
            }
          }
        }
      }
    }
  }

  // ===== Badges =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Badges") { style: type.heading-sm, color: semantic.text-primary }

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

      Alert(severity: "success", message: "Operation completed.", title: "Success")
      Alert(severity: "error", message: "Something went wrong.", title: "Error")
      Alert(severity: "warning", message: "Cannot be undone.", title: "Warning")
      Alert(severity: "info", message: "New features available.", title: "Info")
    }
  }

  // ===== Skeleton =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Skeleton") { style: type.heading-sm, color: semantic.text-primary }
      Skeleton()
    }
  }

  // ===== Empty State =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Empty State") { style: type.heading-sm, color: semantic.text-primary }
      EmptyState(message: "No items found", description: "Try adjusting your filters or create a new item.")
    }
  }

  // ===== Card Container =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Card Container") { style: type.heading-sm, color: semantic.text-primary }
      Card() {
        block {
          padding: spacing.4
          layout: vertical, gap: spacing.2
          text("Card Title") { style: type.heading-sm, color: semantic.text-primary }
          text("This is a Card component used as a container.") {
            style: type.body-md
            color: semantic.text-secondary
          }
        }
      }
    }
  }

  // ===== Stat =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Stat") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: grid, columns: responsive("1fr", md: "1fr 1fr"), gap: spacing.4

        block {
          layout: vertical, gap: spacing.3
          text("Built-in (TS)") { style: type.label-sm, color: semantic.text-tertiary }
          block {
            padding: spacing.4
            background: gradient.stat-primary
            border-radius: radius.lg
            layout: vertical, gap: spacing.2, align: center
            transition: transition.card-lift
            on hover {
              transform: transform.lift-md
              shadow: elevation.floating
            }
            Icon(name: "star", size: icon.lg, color: semantic.interactive)
            Stat(label: "Revenue", value: "$12,345", trend: "up", trendText: "+12%")
          }
          block {
            padding: spacing.4
            background: gradient.stat-success
            border-radius: radius.lg
            layout: vertical, gap: spacing.2, align: center
            transition: transition.card-lift
            on hover {
              transform: transform.lift-md
              shadow: elevation.floating
            }
            Icon(name: "user", size: icon.lg, color: semantic.success)
            Stat(label: "Users", value: "1,234", trend: "down", trendText: "-3%")
          }
          block {
            padding: spacing.4
            background: gradient.stat-warning
            border-radius: radius.lg
            layout: vertical, gap: spacing.2, align: center
            transition: transition.card-lift
            on hover {
              transform: transform.lift-md
              shadow: elevation.floating
            }
            Icon(name: "loader", size: icon.lg, color: semantic.warning)
            Stat(label: "Sessions", value: "5,678", trend: "neutral", trendText: "No change")
          }
        }

        block {
          layout: vertical, gap: spacing.3
          text("Spec Component") { style: type.label-sm, color: semantic.text-tertiary }
          block {
            background: gradient.stat-primary
            border-radius: radius.lg
            layout: vertical, gap: spacing.2, align: center
            transition: transition.card-lift
            on hover {
              transform: transform.lift-md
              shadow: elevation.floating
            }
            Icon(name: "star", size: icon.lg, color: semantic.interactive)
            Stat2(label: "Revenue", value: "$12,345", trend: "up", trendValue: "+12%")
          }
          block {
            background: gradient.stat-success
            border-radius: radius.lg
            layout: vertical, gap: spacing.2, align: center
            transition: transition.card-lift
            on hover {
              transform: transform.lift-md
              shadow: elevation.floating
            }
            Icon(name: "user", size: icon.lg, color: semantic.success)
            Stat2(label: "Users", value: "1,234", trend: "down", trendValue: "-3%")
          }
          block {
            background: gradient.stat-warning
            border-radius: radius.lg
            layout: vertical, gap: spacing.2, align: center
            transition: transition.card-lift
            on hover {
              transform: transform.lift-md
              shadow: elevation.floating
            }
            Icon(name: "loader", size: icon.lg, color: semantic.warning)
            Stat2(label: "Sessions", value: "5,678", trend: "neutral", trendValue: "No change")
          }
        }
      }
    }
  }

  // ===== Breadcrumb =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Breadcrumb") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: grid, columns: responsive("1fr", md: "1fr 1fr"), gap: spacing.4

        block {
          layout: vertical, gap: spacing.3
          text("Built-in (TS)") { style: type.label-sm, color: semantic.text-tertiary }
          Breadcrumb(items: [
            {id: "home", label: "Home"},
            {id: "products", label: "Products"},
            {id: "electronics", label: "Electronics"},
            {id: "phones", label: "Phones"}
          ])
        }

        block {
          layout: vertical, gap: spacing.3
          text("Spec Component") { style: type.label-sm, color: semantic.text-tertiary }
          Breadcrumb(items: [
            {id: "home", label: "Home"},
            {id: "products", label: "Products"},
            {id: "electronics", label: "Electronics"},
            {id: "phones", label: "Phones"}
          ])
        }
      }
    }
  }

  // ===== Timeline =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Timeline") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: grid, columns: responsive("1fr", md: "1fr 1fr"), gap: spacing.4

        block {
          layout: vertical, gap: spacing.3
          text("Built-in (TS)") { style: type.label-sm, color: semantic.text-tertiary }
          Timeline(items: [
            {id: "1", title: "Order placed", description: "Order #1234 confirmed", date: "Jan 15", status: "completed"},
            {id: "2", title: "Processing", description: "Payment verified", date: "Jan 16", status: "completed"},
            {id: "3", title: "Shipped", description: "In transit via FedEx", date: "Jan 17", status: "active"},
            {id: "4", title: "Delivered", description: "Estimated Jan 20", date: "", status: "pending"}
          ])
        }

        block {
          layout: vertical, gap: spacing.3
          text("Spec Component") { style: type.label-sm, color: semantic.text-tertiary }
          Timeline2(items: [
            {id: "1", title: "Order placed", description: "Order #1234 confirmed", date: "Jan 15", status: "completed"},
            {id: "2", title: "Processing", description: "Payment verified", date: "Jan 16", status: "completed"},
            {id: "3", title: "Shipped", description: "In transit via FedEx", date: "Jan 17", status: "active"},
            {id: "4", title: "Delivered", description: "Estimated Jan 20", date: "", status: "pending"}
          ])
        }
      }
    }
  }

  // ===== Table =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Table") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: grid, columns: responsive("1fr", md: "1fr 1fr"), gap: spacing.4

        block {
          layout: vertical, gap: spacing.3
          text("Built-in (TS)") { style: type.label-sm, color: semantic.text-tertiary }
          Table(
            columns: [
              {key: "name", header: "Name"},
              {key: "role", header: "Role"},
              {key: "status", header: "Status"}
            ],
            rows: [
              {name: "Alice", role: "Engineer", status: "Active"},
              {name: "Bob", role: "Designer", status: "Away"},
              {name: "Carol", role: "Manager", status: "Active"}
            ]
          )
        }

        block {
          layout: vertical, gap: spacing.3
          text("Spec Component") { style: type.label-sm, color: semantic.text-tertiary }
          Table2(
            columns: [
              {key: "name", header: "Name"},
              {key: "role", header: "Role"},
              {key: "status", header: "Status"}
            ],
            rows: [
              {name: "Alice", role: "Engineer", status: "Active"},
              {name: "Bob", role: "Designer", status: "Away"},
              {name: "Carol", role: "Manager", status: "Active"}
            ],
            striped: true
          )
        }
      }
    }
  }

  // ===== Accordion =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Accordion (Spec Component)") { style: type.heading-sm, color: semantic.text-primary }

      Accordion(items: [
        {id: "1", title: "What is Spec?", content: "Spec is a declarative UI language that compiles to efficient JavaScript."},
        {id: "2", title: "How does theming work?", content: "Themes use semantic tokens that map to your visual system palette."},
        {id: "3", title: "Is it production ready?", content: "Spec is under active development with growing component coverage."}
      ])
    }
  }

  // ===== Tabs (Spec) =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Tabs (Spec Component)") { style: type.heading-sm, color: semantic.text-primary }

      Tabs2(
        tabs: [
          {id: "overview", label: "Overview"},
          {id: "analytics", label: "Analytics"},
          {id: "settings", label: "Settings"}
        ],
        activeTab: activeTab
      ) {
        on change(id): setTab(id)
      }
    }
  }

  // ===== Tooltip (Spec) =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Tooltip (Spec Component)") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: horizontal, gap: spacing.4

        Tooltip2(text: "This is a tooltip!") {
          block {
            padding: spacing.2
            background: semantic.surface-raised
            border-radius: 4px
            cursor: "pointer"
            text("Hover me (top)") { style: type.label-md, color: semantic.interactive }
          }
        }

        Tooltip2(text: "Bottom placement", placement: "bottom") {
          block {
            padding: spacing.2
            background: semantic.surface-raised
            border-radius: 4px
            cursor: "pointer"
            text("Hover me (bottom)") { style: type.label-md, color: semantic.interactive }
          }
        }
      }
    }
  }

  // ===== Toast (Spec) =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.3

      text("Toast (Spec Component)") { style: type.heading-sm, color: semantic.text-primary }

      Toast2(message: "Operation completed successfully!", severity: "success")
      Toast2(message: "Something went wrong. Please try again.", severity: "error")
      Toast2(message: "This action cannot be undone.", severity: "warning")
      Toast2(message: "New features are available.", severity: "info")
    }
  }

  // ===== Popover (Spec) =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Popover (Spec Component)") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: horizontal, gap: spacing.4

        Popover2() {
          slot("trigger") {
            Button(label: "Click me", variant: "secondary")
          }
          slot("content") {
            block {
              layout: vertical, gap: spacing.2
              text("Popover Content") { style: type.label-md, color: semantic.text-primary }
              text("This is a popover panel with some content.") {
                style: type.body-md
                color: semantic.text-secondary
              }
            }
          }
        }
      }
    }
  }

  // ===== Modal (Spec) =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Modal (Spec Component)") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: horizontal, gap: spacing.3

        Button(label: "Open Modal", variant: "primary") {
          on click: openModal()
        }
      }

      Modal(open: modalOpen, title: "Example Modal", width: "500px") {
        on close: closeModal()

        block {
          layout: vertical, gap: spacing.3
          text("This is a modal dialog built entirely in Spec.") {
            style: type.body-md
            color: semantic.text-secondary
          }
          text("It supports focus trapping, scroll locking, and backdrop click to close.") {
            style: type.body-md
            color: semantic.text-secondary
          }
        }
      }
    }
  }

  // ===== Drawer (Spec) =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Drawer (Spec Component)") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: horizontal, gap: spacing.3

        Button(label: "Open Drawer", variant: "secondary") {
          on click: openDrawer()
        }
      }

      Drawer(open: drawerOpen, title: "Navigation") {
        on close: closeDrawer()

        block {
          layout: vertical, gap: spacing.2

          text("Dashboard") { style: type.body-md, color: semantic.text-primary }
          text("Settings") { style: type.body-md, color: semantic.text-primary }
          text("Profile") { style: type.body-md, color: semantic.text-primary }
          text("Help") { style: type.body-md, color: semantic.text-secondary }
        }
      }
    }
  }

  // ===== ConfirmDialog (Spec) =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Confirm Dialog (Spec Component)") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: horizontal, gap: spacing.3

        Button(label: "Confirm Action", variant: "primary") {
          on click: openConfirm()
        }
        Button(label: "Delete Item", variant: "destructive") {
          on click: openConfirmDestructive()
        }
      }

      ConfirmDialog(open: confirmOpen, title: "Save Changes?", message: "Would you like to save your changes before leaving?", confirmLabel: "Save", cancelLabel: "Discard") {
        on confirm: closeConfirm()
        on cancel: closeConfirm()
      }

      ConfirmDialog(open: confirmDestructiveOpen, title: "Delete Item", message: "This action cannot be undone. Are you sure you want to delete this item?", confirmLabel: "Delete", cancelLabel: "Keep", destructive: true) {
        on confirm: closeConfirmDestructive()
        on cancel: closeConfirmDestructive()
      }
    }
  }
}
