// DataGridDemo — Issue #17 Data Display: DataGrid with sorting, filtering, pagination
// Also showcases: Issue #49 (sizing, cursor), #52 (transitions), #53 (hover states),
//   #54 (shadows), #55 (text styling), #56 (individual borders)

surface DataGridDemo() {
  @state {
    selectedProduct: null
    drawerOpen: false
    page: 1
    pageSize: 10
  }

  @source {
    products: ProductsAPI
  }

  @computed {
    productList: products != null ? products : []
    pagedProducts: productList.slice((page - 1) * pageSize, page * pageSize)
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
  }

  @actions {
    selectProduct(p) {
      selectedProduct = p
      drawerOpen = true
    }
    closeDrawer() {
      drawerOpen = false
    }
    setPage(p) { page = p }
    setPageSize(s) {
      pageSize = s
      page = 1
    }
  }

  layout: vertical, gap: spacing.5

  // Header with gradient background
  block {
    padding: spacing.5
    background: gradient.header-accent
    border-radius: radius.md
    border-bottom: borders.section-accent
    layout: vertical, gap: spacing.3

    block {
      layout: horizontal, gap: spacing.3, align: center
      Icon(name: "layout", size: icon.lg, color: semantic.interactive)
      text("Product Catalog") {
        style: type.heading-lg
        color: semantic.text-primary
        letter-spacing: "-0.02em"
      }
    }

    text(productCount) { style: type.body-sm, color: semantic.text-secondary }
  }

  // Skeleton loading state
  block {
    visibility: productsLoading
    layout: vertical, gap: spacing.3
    Skeleton(height: "40px", width: "100%")
    Skeleton(height: "300px", width: "100%")
  }

  // Error state with Alert
  block {
    visibility: productsError
    Alert(severity: "error", message: "The product catalog could not be loaded.", title: "Failed to load products")
  }

  // DataGrid — sorting, filtering, row selection
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

    DataGrid(
      rows: pagedProducts,
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

  // Pagination
  block {
    visibility: !productsLoading
    layout: horizontal, justify: center
    padding: spacing.3
    Pagination(
      total: productList.length,
      pageSize: pageSize,
      page: page,
      showTotal: true,
      pageSizes: [5, 10, 20]
    ) {
      on change(p): { setPage(p) }
      on pageSizeChange(s): { setPageSize(s) }
    }
  }

  // Product detail Drawer
  Drawer(open: drawerOpen, side: "right") {
    on close: closeDrawer()

    block {
      layout: vertical, gap: spacing.4
      padding: spacing.4

      // Product name with text styling
      text(selectedName) {
        style: type.heading-lg
        color: semantic.text-primary
        letter-spacing: "-0.01em"
      }

      // Stock warning Alert
      block {
        visibility: stockWarning
        Alert(severity: "warning", message: "This product has fewer than 10 units remaining.", title: "Low Stock")
      }

      // Detail cards using CSS Grid
      block {
        layout: grid, columns: "1fr 1fr", gap: spacing.3

        // Category card
        Card() {
          block {
            padding: spacing.3
            layout: vertical, gap: spacing.1
            text("Category") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
            text(selectedCategory) { style: type.body-md, weight: 600, color: semantic.text-primary }
          }
        }

        // Price card
        Card() {
          block {
            padding: spacing.3
            layout: vertical, gap: spacing.1
            text("Price") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
            text(selectedPrice) { style: type.heading-md, color: semantic.interactive }
          }
        }

        // Stock card
        Card() {
          block {
            padding: spacing.3
            layout: vertical, gap: spacing.1
            text("Stock") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
            Stat(value: "{selectedStock}", label: "units")
          }
        }

        // Rating card
        Card() {
          block {
            padding: spacing.3
            layout: vertical, gap: spacing.1
            text("Rating") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
            text(selectedRating) { style: type.body-md, weight: 600, color: semantic.text-primary }
          }
        }
      }

      // SKU and Status
      block {
        padding: spacing.3
        background: semantic.surface
        border-radius: radius.md
        layout: horizontal, gap: spacing.4, align: center
        block {
          layout: vertical, gap: spacing.1
          text("SKU") { style: type.label-sm, color: semantic.text-secondary }
          text(selectedSku) { style: type.mono-md, color: semantic.text-primary }
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
