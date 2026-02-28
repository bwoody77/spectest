// DataGridDemo — Issue #17 Data Display: DataGrid with sorting, filtering, pagination
// Also showcases: Issue #49 (sizing, cursor), #52 (transitions), #53 (hover states),
//   #54 (shadows), #55 (text styling), #56 (individual borders)

surface DataGridDemo(themePreset) {
  @state {
    selectedProduct: null
    drawerOpen: false
  }

  @source {
    products: ProductsAPI
  }

  @computed {
    productList: products != null ? products : []
    productCount: "{productList.length} products"
    hasSelection: selectedProduct != null
    selectedName: selectedProduct != null ? selectedProduct.name : ""
    selectedCategory: selectedProduct != null ? selectedProduct.category : ""
    selectedPrice: selectedProduct != null ? "$" + selectedProduct.price : ""
    selectedStock: selectedProduct != null ? selectedProduct.stock : 0
    selectedRating: selectedProduct != null ? selectedProduct.rating + " / 5" : ""
    selectedSku: selectedProduct != null ? selectedProduct.sku : ""
    selectedStatus: selectedProduct != null ? selectedProduct.status : ""
    stockWarning: selectedProduct != null ? selectedProduct.stock < 10 : false

    surfaceBg: match themePreset { "enterprise" -> "#f8fafc", "social" -> "#faf5ff", "minimal" -> "#fafafa", "playful" -> "#fffbf5", _ -> "#f8fafc" }
    cardBg: match themePreset { "enterprise" -> "#ffffff", "social" -> "#ffffff", "minimal" -> "#ffffff", "playful" -> "#ffffff", _ -> "#ffffff" }
    accentColor: match themePreset { "enterprise" -> "#3b82f6", "social" -> "#8b5cf6", "minimal" -> "#0f172a", "playful" -> "#f97316", _ -> "#3b82f6" }
    textPrimary: match themePreset { "enterprise" -> "#1e293b", "social" -> "#581c87", "minimal" -> "#0f172a", "playful" -> "#7c2d12", _ -> "#1e293b" }
    textMuted: match themePreset { "enterprise" -> "#475569", "social" -> "#7c3aed", "minimal" -> "#6b7280", "playful" -> "#ea580c", _ -> "#475569" }
    cardRadius: match themePreset { "enterprise" -> "4px", "social" -> "16px", "minimal" -> "0px", "playful" -> "12px", _ -> "8px" }
  }

  @actions {
    selectProduct(p) {
      selectedProduct = p
      drawerOpen = true
    }
    closeDrawer() {
      drawerOpen = false
    }
  }

  layout: vertical, gap: spacing.5

  // Header with gradient background (Issue #54)
  block {
    padding: spacing.5
    background: "linear-gradient(135deg, {accentColor}15, {accentColor}05)"
    border-radius: cardRadius
    border-bottom: "2px solid {accentColor}30"
    layout: vertical, gap: spacing.3

    block {
      layout: horizontal, gap: spacing.3, align: center
      Icon(name: "layout", size: "24px", color: accentColor)
      text("Product Catalog") {
        style: type.heading-lg
        color: textPrimary
        letter-spacing: "-0.02em"
      }
    }

    text(productCount) { style: type.body-sm, color: textMuted }
  }

  // Skeleton loading state (Issue #19)
  block {
    visibility: productsLoading
    layout: vertical, gap: spacing.3
    Skeleton(height: "40px", width: "100%")
    Skeleton(height: "300px", width: "100%")
  }

  // Error state with Alert (Issue #19)
  block {
    visibility: productsError
    Alert(severity: "error", message: "The product catalog could not be loaded.", title: "Failed to load products")
  }

  // DataGrid (Issue #17) — sorting, filtering, row selection
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

    DataGrid(
      rows: productList,
      columns: [
        { key: "id", label: "ID", width: "60px", sortable: true },
        { key: "name", label: "Product Name", sortable: true, filterable: true },
        { key: "category", label: "Category", sortable: true, filterable: true },
        { key: "price", label: "Price", sortable: true, format: "currency" },
        { key: "stock", label: "Stock", sortable: true },
        { key: "status", label: "Status", sortable: true, filterable: true },
        { key: "rating", label: "Rating", sortable: true },
        { key: "sku", label: "SKU" }
      ],
      selection: "single"
    ) {
      on rowClick(row): { selectProduct(row) }
    }
  }

  // Pagination (Issue #18)
  block {
    visibility: !productsLoading
    layout: horizontal, justify: center
    padding: spacing.3
    Pagination(
      total: productList.length,
      pageSize: 10,
      showTotal: true,
      pageSizes: [5, 10, 20]
    )
  }

  // Product detail Drawer (Issue #17 Card, Issue #19 Alert, Issue #57 backdrop-blur)
  Drawer(open: drawerOpen, side: "right") {
    on close: closeDrawer()

    block {
      layout: vertical, gap: spacing.4
      padding: spacing.4

      // Product name with text styling (Issue #55)
      text(selectedName) {
        style: type.heading-lg
        color: textPrimary
        letter-spacing: "-0.01em"
      }

      // Stock warning Alert (Issue #19)
      block {
        visibility: stockWarning
        Alert(severity: "warning", message: "This product has fewer than 10 units remaining.", title: "Low Stock")
      }

      // Detail cards using CSS Grid (Issue #51)
      block {
        layout: grid, columns: "1fr 1fr", gap: spacing.3

        // Category card
        Card() {
          block {
            padding: spacing.3
            layout: vertical, gap: spacing.1
            text("Category") { style: type.label-sm, color: textMuted, text-transform: "uppercase", letter-spacing: "0.05em" }
            text(selectedCategory) { style: type.body-md, weight: 600, color: textPrimary }
          }
        }

        // Price card
        Card() {
          block {
            padding: spacing.3
            layout: vertical, gap: spacing.1
            text("Price") { style: type.label-sm, color: textMuted, text-transform: "uppercase", letter-spacing: "0.05em" }
            text(selectedPrice) { style: type.heading-md, color: accentColor }
          }
        }

        // Stock card
        Card() {
          block {
            padding: spacing.3
            layout: vertical, gap: spacing.1
            text("Stock") { style: type.label-sm, color: textMuted, text-transform: "uppercase", letter-spacing: "0.05em" }
            Stat(value: "{selectedStock}", label: "units")
          }
        }

        // Rating card
        Card() {
          block {
            padding: spacing.3
            layout: vertical, gap: spacing.1
            text("Rating") { style: type.label-sm, color: textMuted, text-transform: "uppercase", letter-spacing: "0.05em" }
            text(selectedRating) { style: type.body-md, weight: 600, color: textPrimary }
          }
        }
      }

      // SKU and Status
      block {
        padding: spacing.3
        background: surfaceBg
        border-radius: cardRadius
        layout: horizontal, gap: spacing.4, align: center
        block {
          layout: vertical, gap: spacing.1
          text("SKU") { style: type.label-sm, color: textMuted }
          text(selectedSku) { style: type.mono-md, color: textPrimary }
        }
        Badge(text: selectedStatus, variant: "neutral")
      }

      // Actions
      block {
        layout: horizontal, gap: spacing.3
        Button(label: "Edit Product", variant: "primary") {
          on click: closeDrawer()
        }
        Button(label: "Close", variant: "secondary") {
          on click: closeDrawer()
        }
      }
    }
  }
}
