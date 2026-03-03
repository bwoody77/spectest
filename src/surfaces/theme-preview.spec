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
    accordionMultiple: false
    activeTab: "overview"
    stepperStep: 1
    pickedDate: null
    modalOpen: false
    drawerOpen: false
    confirmOpen: false
    confirmDestructiveOpen: false
    breadcrumbMax: 0
    passwordValue: ""
    emailValue: ""
    searchValue: ""
    numberValue: ""
    textareaValue: ""
    prefixValue: ""
    paginationPage: 1
    sliderValue: 50
    select2Value: ""
    cmdPaletteOpen: false
    sidebarItem: "dashboard"
    sidebarCollapsed: false
    stepper2Step: 0
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
    setAccordionMultiple(v) { accordionMultiple = v }
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
    setBreadcrumbMax(n) { breadcrumbMax = n }
    setPassword(v) { passwordValue = v }
    setEmail(v) { emailValue = v }
    setSearch(v) { searchValue = v }
    setNumber(v) { numberValue = v }
    setTextarea(v) { textareaValue = v }
    setPrefix(v) { prefixValue = v }
    setPaginationPage(p) { paginationPage = p }
    setSliderValue(v) { sliderValue = v }
    setSelect2(v) { select2Value = v }
    openCmdPalette() { cmdPaletteOpen = true }
    closeCmdPalette() { cmdPaletteOpen = false }
    selectCmd(id) { cmdPaletteOpen = false }
    setSidebarItem(id) { sidebarItem = id }
    setSidebarCollapsed(v) { sidebarCollapsed = v }
    setStepper2Step(n) { stepper2Step = n }
    nextStepper2() { stepper2Step = stepper2Step < 3 ? stepper2Step + 1 : 0 }
    prevStepper2() { stepper2Step = stepper2Step > 0 ? stepper2Step - 1 : 0 }
  }

  layout: vertical, gap: spacing.5

  // Title
  text("Component Showcase") { style: type.heading-lg, color: semantic.text-primary }
  text("Switch themes above to compare how each one styles these components.") {
    style: type.body-md
    color: semantic.text-secondary
  }

  // =====================================================================
  // Spec Component Showcases
  // =====================================================================

  // ===== Text =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Text") { style: type.heading-sm, color: semantic.text-primary }
      block {
        layout: vertical, gap: spacing.3
        Text(content: "Heading Large", variant: "heading-lg")
        Text(content: "Body text paragraph", variant: "body-md")
        Text(content: "Small label", variant: "label-sm")
        Text(content: "Caption text", variant: "caption")
      }
    }
  }

  // ===== Stack =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Stack") { style: type.heading-sm, color: semantic.text-primary }
      Stack(direction: "horizontal") {
        Badge(text: "A", variant: "info")
        Badge(text: "B", variant: "success")
        Badge(text: "C", variant: "warning")
      }
    }
  }

  // ===== Pagination =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Pagination") { style: type.heading-sm, color: semantic.text-primary }
      Pagination(total: 100, pageSize: 10, page: paginationPage) {
        on change(p): setPaginationPage(p)
      }
    }
  }

  // ===== TimePicker =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("TimePicker") { style: type.heading-sm, color: semantic.text-primary }
      TimePicker(label: "Meeting Time", format: "12")
    }
  }

  // ===== Stepper =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Stepper") { style: type.heading-sm, color: semantic.text-primary }
      Stepper(
        steps: [
          {label: "Account"},
          {label: "Profile"},
          {label: "Review"},
          {label: "Complete"}
        ],
        activeStep: stepper2Step
      )
      block {
        layout: horizontal, gap: spacing.3
        Button(label: "Previous", variant: "secondary") {
          on click: prevStepper2()
        }
        Button(label: "Next Step", variant: "primary") {
          on click: nextStepper2()
        }
      }
    }
  }

  // ===== Slider =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Slider") { style: type.heading-sm, color: semantic.text-primary }
      Slider(label: "Volume", min: 0, max: 100, value: sliderValue) {
        on change(v): setSliderValue(v)
      }
    }
  }

  // ===== Select =====
  // Using inline card styling with overflow:visible so dropdown popups aren't clipped
  block {
    background: semantic.surface-raised
    border: borders.default
    border-radius: radius.md
    shadow: elevation.raised
    overflow: visible

    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4
      overflow: visible

      text("Select") { style: type.heading-sm, color: semantic.text-primary }
      Select(
        label: "Framework",
        options: [
          {value: "react", label: "React"},
          {value: "vue", label: "Vue"},
          {value: "angular", label: "Angular"},
          {value: "svelte", label: "Svelte"}
        ],
        value: select2Value,
        placeholder: "Choose..."
      ) {
        on change(v): setSelect2(v)
      }
    }
  }

  // ===== Tooltip =====
  // Using inline card styling with overflow:visible so tooltip popups aren't clipped
  block {
    background: semantic.surface-raised
    border: borders.default
    border-radius: radius.md
    shadow: elevation.raised
    overflow: visible

    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Tooltip") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: horizontal, gap: spacing.4
        overflow: visible

        Tooltip(text: "Top tooltip") {
          Button(label: "Top", variant: "secondary")
        }
        Tooltip(text: "Bottom tooltip", placement: "bottom") {
          Button(label: "Bottom", variant: "secondary")
        }
        Tooltip(text: "Left tooltip", placement: "left") {
          Button(label: "Left", variant: "secondary")
        }
        Tooltip(text: "Right tooltip", placement: "right") {
          Button(label: "Right", variant: "secondary")
        }
      }
    }
  }

  // ===== Popover =====
  // Using inline card styling with overflow:visible so popover panels aren't clipped
  block {
    background: semantic.surface-raised
    border: borders.default
    border-radius: radius.md
    shadow: elevation.raised
    overflow: visible

    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Popover") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: horizontal, gap: spacing.4
        overflow: visible

        Popover() {
          slot("trigger") {
            Button(label: "Bottom (default)", variant: "secondary")
          }
          slot("content") {
            block {
              layout: vertical, gap: spacing.2
              text("Popover Content") { style: type.label-md, color: semantic.text-primary }
              text("Click the trigger to open. Click outside to close.") {
                style: type.body-md
                color: semantic.text-secondary
              }
            }
          }
        }

        Popover(placement: "right") {
          slot("trigger") {
            Button(label: "Right", variant: "secondary")
          }
          slot("content") {
            block {
              layout: vertical, gap: spacing.2
              text("Right Popover") { style: type.label-md, color: semantic.text-primary }
              text("Positioned to the right of the trigger.") {
                style: type.body-md
                color: semantic.text-secondary
              }
            }
          }
        }
      }
    }
  }

  // ===== Command Palette =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Command Palette") { style: type.heading-sm, color: semantic.text-primary }
      Button(label: "Open Command Palette", variant: "secondary") {
        on click: openCmdPalette()
      }
      CommandPalette(
        commands: [
          {id: "new", label: "New File", shortcut: "Ctrl+N"},
          {id: "open", label: "Open File", shortcut: "Ctrl+O"},
          {id: "save", label: "Save", shortcut: "Ctrl+S"},
          {id: "settings", label: "Open Settings", description: "Configure preferences"},
          {id: "theme", label: "Change Theme", description: "Switch color theme"}
        ],
        open: cmdPaletteOpen
      ) {
        on select(id): selectCmd(id)
        on close: closeCmdPalette()
      }
    }
  }

  // ===== Sidebar =====
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      text("Sidebar") { style: type.heading-sm, color: semantic.text-primary }
      block {
        height: 300px
        border: borders.default
        border-radius: radius.md
        overflow: hidden
        Sidebar(
          sections: [
            {title: "Main", items: [
              {id: "dashboard", label: "Dashboard", icon: "home"},
              {id: "analytics", label: "Analytics", icon: "star"},
              {id: "settings", label: "Settings", icon: "settings"}
            ]},
            {title: "Account", items: [
              {id: "profile", label: "Profile", icon: "user"},
              {id: "logout", label: "Logout", icon: "arrowRight"}
            ]}
          ],
          activeItem: sidebarItem,
          collapsed: sidebarCollapsed
        ) {
          on select(id): setSidebarItem(id)
          on collapse(v): setSidebarCollapsed(v)
        }
      }
    }
  }

  // Two-column masonry layout at larger breakpoints
  block {
    layout: responsive(vertical, lg: horizontal), gap: spacing.5

    // ===== Left column =====
    block {
      layout: vertical, gap: spacing.5
      grow: true

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

      // ===== Table =====
      Card() {
        block {
          padding: spacing.5
          layout: vertical, gap: spacing.4

          text("Table") { style: type.heading-sm, color: semantic.text-primary }

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
            ],
            striped: true
          )
        }
      }

      // ===== Accordion =====
      Card() {
        block {
          padding: spacing.5
          layout: vertical, gap: spacing.4

          block {
            layout: horizontal, justify: between, align: center
            text("Accordion (Spec Component)") { style: type.heading-sm, color: semantic.text-primary }
            Toggle(label: "Allow multiple", checked: accordionMultiple) {
              on change(v): setAccordionMultiple(v)
            }
          }

          Accordion(items: [
            {id: "1", title: "What is Spec?", content: "Spec is a declarative UI language that compiles to efficient JavaScript."},
            {id: "2", title: "How does theming work?", content: "Themes use semantic tokens that map to your visual system palette."},
            {id: "3", title: "Is it production ready?", content: "Spec is under active development with growing component coverage."}
          ], multiple: accordionMultiple)
        }
      }

      // ===== Breadcrumb =====
      Card() {
        block {
          padding: spacing.5
          layout: vertical, gap: spacing.4

          text("Breadcrumb") { style: type.heading-sm, color: semantic.text-primary }

          // maxVisible control
          block {
            layout: horizontal, gap: spacing.2, align: center
            text("maxVisible:") { style: type.label-sm, color: semantic.text-secondary }
            Button(label: "0 (off)", variant: breadcrumbMax == 0 ? "primary" : "ghost") {
              on click: setBreadcrumbMax(0)
            }
            Button(label: "2", variant: breadcrumbMax == 2 ? "primary" : "ghost") {
              on click: setBreadcrumbMax(2)
            }
            Button(label: "3", variant: breadcrumbMax == 3 ? "primary" : "ghost") {
              on click: setBreadcrumbMax(3)
            }
            Button(label: "4", variant: breadcrumbMax == 4 ? "primary" : "ghost") {
              on click: setBreadcrumbMax(4)
            }
            Button(label: "5", variant: breadcrumbMax == 5 ? "primary" : "ghost") {
              on click: setBreadcrumbMax(5)
            }
          }

          // Short breadcrumb
          block {
            layout: vertical, gap: spacing.2
            text("Short path (4 items)") { style: type.label-sm, color: semantic.text-tertiary }
            Breadcrumb(maxVisible: breadcrumbMax, items: [
              {id: "home", label: "Home"},
              {id: "products", label: "Products"},
              {id: "electronics", label: "Electronics"},
              {id: "phones", label: "Phones"}
            ])
          }

          // Long breadcrumb
          block {
            layout: vertical, gap: spacing.2
            text("Long path (6 items)") { style: type.label-sm, color: semantic.text-tertiary }
            Breadcrumb(maxVisible: breadcrumbMax, items: [
              {id: "home", label: "Home"},
              {id: "admin", label: "Administrative Dashboard"},
              {id: "region", label: "North America"},
              {id: "sales", label: "Regional Sales"},
              {id: "q4", label: "Q4 2025 Results"},
              {id: "detail", label: "Monthly Breakdown"}
            ])
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

    }

    // ===== Right column =====
    block {
      layout: vertical, gap: spacing.5
      grow: true

      // ===== Progress =====
      Card() {
        block {
          padding: spacing.5
          layout: vertical, gap: spacing.4

          text("Progress") { style: type.heading-sm, color: semantic.text-primary }

          block {
            layout: vertical, gap: spacing.3
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

      // ===== Timeline =====
      Card() {
        block {
          padding: spacing.5
          layout: vertical, gap: spacing.4

          text("Timeline") { style: type.heading-sm, color: semantic.text-primary }

          Timeline(items: [
            {id: "1", title: "Order placed", description: "Order #1234 confirmed", date: "Jan 15", status: "completed"},
            {id: "2", title: "Processing", description: "Payment verified", date: "Jan 16", status: "completed"},
            {id: "3", title: "Shipped", description: "In transit via FedEx", date: "Jan 17", status: "active"},
            {id: "4", title: "Delivered", description: "Estimated Jan 20", date: "", status: "pending"}
          ])
        }
      }

      // ===== Form Controls =====
      Card() {
        block {
          padding: spacing.5
          layout: vertical, gap: spacing.4

          text("Form Controls") { style: type.heading-sm, color: semantic.text-primary }

          block {
            layout: vertical, gap: spacing.3

            TextInput(type: "text", label: "Text Input", placeholder: "Type something...", value: inputValue) {
              on change(v): setInput(v)
            }

            TextInput(type: "password", label: "Password", placeholder: "Enter password...", value: passwordValue) {
              on change(v): setPassword(v)
            }

            TextInput(type: "email", label: "Email", placeholder: "you@example.com", value: emailValue) {
              on change(v): setEmail(v)
            }

            TextInput(type: "search", label: "Search", placeholder: "Search...", value: searchValue) {
              on change(v): setSearch(v)
            }

            TextInput(type: "number", label: "Number", placeholder: "0", value: numberValue) {
              on change(v): setNumber(v)
            }

            TextInput(type: "textarea", label: "Message", placeholder: "Write here...", value: textareaValue) {
              on change(v): setTextarea(v)
            }

            TextInput(label: "Amount", prefix: "$", suffix: "USD", value: prefixValue) {
              on change(v): setPrefix(v)
            }

            TextInput(label: "Username", value: "taken", error: true, errorMessage: "Already taken")

            TextInput(label: "Disabled", value: "Read only", disabled: true)

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

      // ===== Stat =====
      Card() {
        block {
          padding: spacing.5
          layout: vertical, gap: spacing.4

          text("Stat") { style: type.heading-sm, color: semantic.text-primary }

          block {
            layout: vertical, gap: spacing.3

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
              Stat(label: "Revenue", value: "$12,345", trend: "up", trendValue: "+12%")
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
              Stat(label: "Users", value: "1,234", trend: "down", trendValue: "-3%")
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
              Stat(label: "Sessions", value: "5,678", trend: "neutral", trendValue: "No change")
            }
          }
        }
      }

      // ===== Image =====
      Card() {
        block {
          padding: spacing.5
          layout: vertical, gap: spacing.4

          text("Image") { style: type.heading-sm, color: semantic.text-primary }

          block {
            layout: vertical, gap: spacing.4

            block {
              layout: vertical, gap: spacing.2
              text("Normal") { style: type.label-sm, color: semantic.text-tertiary }
              Image(src: "https://picsum.photos/300/200", alt: "Photo", aspectRatio: "3/2")
            }

            block {
              layout: vertical, gap: spacing.2
              text("Fallback") { style: type.label-sm, color: semantic.text-tertiary }
              Image(src: "https://invalid.example.com/x.jpg", alt: "Fallback", fallbackSrc: "https://picsum.photos/300/200?r=2", aspectRatio: "3/2")
            }

            block {
              layout: vertical, gap: spacing.2
              text("Lazy") { style: type.label-sm, color: semantic.text-tertiary }
              Image(src: "https://picsum.photos/300/200?r=3", alt: "Lazy", lazy: true, aspectRatio: "3/2")
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
  }
}
