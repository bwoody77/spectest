// EditableGridDemo — Issue #20 EditableGrid: inline cell editing, validation, dirty tracking
// Also showcases: Issue #19 (Toast, Alert, Progress), #53 (hover), #54 (shadows)

surface EditableGridDemo(themePreset) {
  @state {
    hasChanges: false
    saveProgress: 0
    saving: false
    saved: false
  }

  @source {
    products: ProductsAPI
  }

  @computed {
    productList: products != null ? products : []
    productCount: "{productList.length} products"
    canSave: hasChanges && !saving
    showSaved: saved

    cardBg: match themePreset { "enterprise" -> "#ffffff", "social" -> "#ffffff", "minimal" -> "#ffffff", "playful" -> "#ffffff", _ -> "#ffffff" }
    accentColor: match themePreset { "enterprise" -> "#3b82f6", "social" -> "#8b5cf6", "minimal" -> "#0f172a", "playful" -> "#f97316", _ -> "#3b82f6" }
    textPrimary: match themePreset { "enterprise" -> "#1e293b", "social" -> "#581c87", "minimal" -> "#0f172a", "playful" -> "#7c2d12", _ -> "#1e293b" }
    textMuted: match themePreset { "enterprise" -> "#475569", "social" -> "#7c3aed", "minimal" -> "#6b7280", "playful" -> "#ea580c", _ -> "#475569" }
    cardRadius: match themePreset { "enterprise" -> "4px", "social" -> "16px", "minimal" -> "0px", "playful" -> "12px", _ -> "8px" }
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
  }

  layout: vertical, gap: spacing.5

  // Header with gradient (Issue #54)
  block {
    padding: spacing.5
    background: "linear-gradient(135deg, {accentColor}15, {accentColor}05)"
    border-radius: cardRadius
    border-bottom: "2px solid {accentColor}30"
    layout: vertical, gap: spacing.3

    block {
      layout: horizontal, gap: spacing.3, align: center, justify: between
      block {
        layout: horizontal, gap: spacing.3, align: center
        Icon(name: "edit", size: "24px", color: accentColor)
        text("Editable Inventory") {
          style: type.heading-lg
          color: textPrimary
          letter-spacing: "-0.02em"
        }
      }

      block {
        layout: horizontal, gap: spacing.3, align: center

        // Save progress (Issue #19)
        block {
          visibility: saving
          Progress(value: saveProgress, label: "Saving...")
        }

        Button(label: "Save All Changes", variant: "primary", disabled: !canSave) {
          on click: saveChanges()
        }
      }
    }

    // Dirty changes alert (Issue #19)
    block {
      visibility: hasChanges
      Alert(severity: "info", message: "You have modified cells. Click Save to persist.", title: "Unsaved changes")
    }
  }

  // Save success toast (Issue #19)
  block {
    visibility: showSaved
    padding: spacing.3
    background: "#ecfdf5"
    border: "1px solid #a7f3d0"
    border-radius: cardRadius
    shadow: elevation.raised
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "check", size: "20px", color: "#10b981")
    text("Changes saved successfully!") { style: type.body-md, color: "#065f46" }
    Button(label: "Dismiss", variant: "ghost") {
      on click: dismissSaved()
    }
  }

  // Skeleton loading (Issue #19)
  block {
    visibility: productsLoading
    layout: vertical, gap: spacing.3
    Skeleton(height: "40px", width: "100%")
    Skeleton(height: "400px", width: "100%")
  }

  // EditableGrid (Issue #20)
  block {
    visibility: !productsLoading
    background: cardBg
    border-radius: cardRadius
    shadow: elevation.raised
    overflow: "hidden"
    transition: "shadow 300ms ease"

    on hover {
      shadow: elevation.layered
    }

    EditableGrid(
      rows: productList,
      columns: [
        { key: "id", label: "ID", width: "60px", editable: false },
        { key: "name", label: "Product Name", editable: true, type: "text" },
        { key: "category", label: "Category", editable: true, type: "select", options: ["Electronics", "Audio", "Furniture", "Accessories"] },
        { key: "price", label: "Price", editable: true, type: "number", format: "currency" },
        { key: "stock", label: "Stock", editable: true, type: "number", min: 0 },
        { key: "status", label: "Status", editable: true, type: "select", options: ["active", "out-of-stock", "discontinued"] },
        { key: "rating", label: "Rating", editable: true, type: "number", min: 0, max: 5, step: 0.1 },
        { key: "sku", label: "SKU", editable: false }
      ],
      saveMode: "batch",
      undoDepth: 50
    ) {
      on cellChange(change): { markDirty() }
    }
  }

  // Instructions card (Issue #17 Card)
  Card() {
    block {
      padding: spacing.4
      layout: vertical, gap: spacing.3

      text("Editing Instructions") { style: type.heading-sm, color: textPrimary }

      block {
        layout: vertical, gap: spacing.2
        block {
          layout: horizontal, gap: spacing.2, align: center
          Icon(name: "edit", size: "16px", color: textMuted)
          text("Click any editable cell to start editing") { style: type.body-sm, color: textMuted }
        }
        block {
          layout: horizontal, gap: spacing.2, align: center
          Icon(name: "arrow-right", size: "16px", color: textMuted)
          text("Use Tab/Arrow keys to navigate between cells") { style: type.body-sm, color: textMuted }
        }
        block {
          layout: horizontal, gap: spacing.2, align: center
          Icon(name: "check", size: "16px", color: textMuted)
          text("Modified cells show a blue indicator") { style: type.body-sm, color: textMuted }
        }
        block {
          layout: horizontal, gap: spacing.2, align: center
          Icon(name: "arrow-left", size: "16px", color: textMuted)
          text("Ctrl+Z to undo, Ctrl+Y to redo") { style: type.body-sm, color: textMuted }
        }
      }
    }
  }
}
