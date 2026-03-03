component Select2(options: array, value: string = "", placeholder: string = "Select...", searchable: boolean = false, disabled: boolean = false, label: string = "") {
  @state {
    open: false
    query: ""
    highlightIndex: 0
  }

  @computed {
    filteredOptions: searchable && query != "" ? options.filter(o => o.label.toLowerCase().includes(query.toLowerCase())) : options
    selectedOption: options.find(o => o.value == value)
    displayText: selectedOption != null ? selectedOption.label : placeholder
    hasOptions: filteredOptions.length > 0
  }

  @actions {
    toggleOpen() {
      if disabled == false {
        open = open == false
        query = ""
        highlightIndex = 0
      }
    }
    closeDropdown() {
      open = false
      query = ""
    }
    selectOption(val) {
      emit("change", val)
      open = false
      query = ""
    }
    setQuery(v) {
      query = v
      highlightIndex = 0
    }
  }

  block {
    layout: vertical, gap: spacing.1
    position: "relative"

    // Label
    block {
      visibility: label != ""
      text(label) { style: type.label-sm, color: semantic.text-secondary }
    }

    // Trigger button
    block {
      layout: horizontal, justify: between, align: center
      padding: spacing.2
      min-height: 36px
      background: semantic.surface
      border: borders.default
      border-radius: radius.md
      cursor: disabled ? "default" : "pointer"
      opacity: disabled ? 0.5 : 1
      on hover { background: disabled ? semantic.surface : semantic.surface-raised }
      on click: toggleOpen()

      text(displayText) {
        style: type.body-md
        color: selectedOption != null ? semantic.text-primary : semantic.text-tertiary
      }
      text("\u25BE") { style: type.caption, color: semantic.text-tertiary }
    }

    // Backdrop
    block {
      visibility: open == true
      position: "fixed"
      top: 0px
      left: 0px
      right: 0px
      bottom: 0px
      z-index: 999
      on click: closeDropdown()
    }

    // Dropdown panel
    block {
      visibility: open == true
      position: "absolute"
      top: 100%
      left: 0px
      right: 0px
      z-index: 1000
      margin: spacing.1
      max-height: 240px
      overflow: auto
      background: semantic.surface
      border: borders.default
      border-radius: radius.md
      shadow: elevation.floating
      layout: vertical

      // Search input
      block {
        visibility: searchable
        padding: spacing.2
        border-bottom: borders.default
        TextInput(placeholder: "Search...", value: query) {
          on change(v): setQuery(v)
        }
      }

      // Options list
      block {
        visibility: hasOptions
        layout: vertical

        each filteredOptions as option, idx {
          block {
            padding: spacing.2
            cursor: "pointer"
            background: option.value == value ? semantic.surface-raised : "transparent"
            on hover { background: semantic.surface-raised }
            on click: selectOption(option.value)

            text(option.label) {
              style: type.body-md
              color: option.value == value ? semantic.interactive : semantic.text-primary
            }
          }
        }
      }

      // Empty state
      block {
        visibility: hasOptions == false
        padding: spacing.3
        layout: horizontal, justify: center
        text("No options") { style: type.body-md, color: semantic.text-tertiary }
      }
    }
  }
}
