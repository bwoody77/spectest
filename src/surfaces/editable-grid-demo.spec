// EditableGridDemo — Issue #20 EditableGrid: inline cell editing, validation, dirty tracking
// Also showcases: Issue #19 (Toast, Alert, Progress), #53 (hover), #54 (shadows)

surface EditableGridDemo() {
  @state {
    hasChanges: false
    saveProgress: 0
    saving: false
    saved: false
    lastSaveEvent: ""
  }

  @source {
    products: ProductsAPI
  }

  @computed {
    productList: products != null ? products : []
    productCount: "{productList.length} products"
    canSave: hasChanges && !saving
    showSaved: saved
  }

  @actions {
    markDirty() { hasChanges = true }
    saveChanges() {
      saving = true
      saveProgress = 50
      await fetch("http://localhost:4000/api/products/1", {method: "PUT", body: JSON.stringify({})})
      saveProgress = 100
      saving = false
      hasChanges = false
      saved = true
    }
    dismissSaved() { saved = false }
    onCellSave(rowId, field, value) {
      lastSaveEvent = "Auto-saved: {field} = {value} (row {rowId})"
      hasChanges = false
    }
    onRowSave(rowId, changes) {
      lastSaveEvent = "Row {rowId} saved"
      hasChanges = false
    }
  }

  layout: vertical, gap: spacing.5

  // Header with gradient
  block {
    padding: spacing.5
    background: gradient.header-accent
    border-radius: radius.md
    border-bottom: borders.section-accent
    layout: vertical, gap: spacing.3

    block {
      layout: horizontal, gap: spacing.3, align: center, justify: between
      block {
        layout: horizontal, gap: spacing.3, align: center
        Icon(name: "edit", size: icon.lg, color: semantic.interactive)
        text("Editable Inventory") {
          style: type.heading-lg
          color: semantic.text-primary
          letter-spacing: "-0.02em"
        }
      }

      block {
        layout: horizontal, gap: spacing.3, align: center

        // Save progress
        block {
          visibility: saving
          Progress(value: saveProgress, label: "Saving...")
        }

        Button(label: "Save All Changes", variant: "primary", disabled: !canSave) {
          on click: saveChanges()
        }
      }
    }

    // Dirty changes alert
    block {
      visibility: hasChanges
      Alert(severity: "info", message: "You have modified cells. Click Save to persist.", title: "Unsaved changes")
    }
  }

  // Save success toast
  block {
    visibility: showSaved
    padding: spacing.3
    background: semantic.success-light
    border: borders.success
    border-radius: radius.md
    shadow: elevation.raised
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "check", size: icon.md, color: semantic.success)
    text("Changes saved successfully!") { style: type.body-md, color: semantic.success-text }
    Button(label: "Dismiss", variant: "ghost") {
      on click: dismissSaved()
    }
  }

  // Skeleton loading
  block {
    visibility: productsLoading
    layout: vertical, gap: spacing.3
    Skeleton(height: "40px", width: "100%")
    Skeleton(height: "400px", width: "100%")
  }

  // EditableGridSpec
  block {
    visibility: !productsLoading
    background: semantic.surface-raised
    border-radius: radius.md
    shadow: elevation.raised
    overflow: "hidden"
    transition: transition.shadow-slower

    on hover {
      shadow: elevation.layered
    }

    EditableGridSpec(
      rows: productList,
      columns: [
        { key: "id", label: "ID", width: "60px", editable: false },
        { key: "name", label: "Product Name", editable: true, type: "text", required: true },
        { key: "category", label: "Category", editable: true, type: "select", options: ["Electronics", "Audio", "Furniture", "Accessories"] },
        { key: "price", label: "Price", editable: true, type: "number", format: "currency" },
        { key: "stock", label: "Stock", editable: true, type: "number", min: 0 },
        { key: "status", label: "Status", editable: true, type: "select", options: ["active", "out-of-stock", "discontinued"] },
        { key: "rating", label: "Rating", editable: true, type: "number", min: 0, max: 5, step: 0.1 },
        { key: "sku", label: "SKU", editable: false }
      ],
      saveMode: "batch",
      undoDepth: 50,
      activation: "click"
    ) {
      on cellEdit(e): { markDirty() }
      on cellSave(e): { onCellSave(e.rowId, e.field, e.value) }
      on rowSave(e): { onRowSave(e.rowId, e.changes) }
    }
  }

  // Instructions card
  Card() {
    block {
      padding: spacing.4
      layout: vertical, gap: spacing.3

      text("Editing Instructions") { style: type.heading-sm, color: semantic.text-primary }

      block {
        layout: vertical, gap: spacing.2
        block {
          layout: horizontal, gap: spacing.2, align: center
          Icon(name: "edit", size: icon.xs, color: semantic.text-secondary)
          text("Click any editable cell to start editing") { style: type.body-sm, color: semantic.text-secondary }
        }
        block {
          layout: horizontal, gap: spacing.2, align: center
          Icon(name: "arrow-right", size: icon.xs, color: semantic.text-secondary)
          text("Use Tab/Arrow keys to navigate between cells") { style: type.body-sm, color: semantic.text-secondary }
        }
        block {
          layout: horizontal, gap: spacing.2, align: center
          Icon(name: "check", size: icon.xs, color: semantic.text-secondary)
          text("Modified cells show a yellow indicator") { style: type.body-sm, color: semantic.text-secondary }
        }
        block {
          layout: horizontal, gap: spacing.2, align: center
          Icon(name: "arrow-left", size: icon.xs, color: semantic.text-secondary)
          text("Ctrl+Z to undo, Ctrl+Y to redo") { style: type.body-sm, color: semantic.text-secondary }
        }
        block {
          layout: horizontal, gap: spacing.2, align: center
          Icon(name: "clipboard", size: icon.xs, color: semantic.text-secondary)
          text("Ctrl+C to copy, Ctrl+V to paste, Ctrl+D to fill down") { style: type.body-sm, color: semantic.text-secondary }
        }
      }
    }
  }
}
