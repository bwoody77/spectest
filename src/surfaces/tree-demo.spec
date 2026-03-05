// TreeDemo — Issue #17 Data Display: Tree view with hierarchical categories
// Also showcases: Issue #49 (sizing, overflow), #50 (positioned layout),
//   #53 (hover/focus states), #54 (shadows), #55 (text styling), #56 (individual borders)

surface TreeDemo() {
  @state {
    selectedNode: null
    searchQuery: ""
  }

  @source {
    categories: CategoriesAPI
  }

  @computed {
    categoryList: categories != null ? categories : []
    hasSelection: selectedNode != null
    selectedLabel: selectedNode != null ? selectedNode.label : "No selection"
    selectedId: selectedNode != null ? selectedNode.id : ""

    treeMinHeight: "400px"
    treeCols: "280px 1fr"
  }

  @actions {
    selectNode(node) { selectedNode = node }
    setSearch(v) { searchQuery = v }
  }

  layout: vertical, gap: spacing.5

  // Header with gradient
  block {
    padding: spacing.5
    background: gradient.header-accent
    border-radius: radius.md
    border-bottom: borders.section-accent
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "list", size: icon.lg, color: semantic.interactive)
    text("Category Browser") {
      style: type.heading-lg
      color: semantic.text-primary
      letter-spacing: "-0.02em"
    }
  }

  // Skeleton loading
  block {
    visibility: categoriesLoading
    layout: vertical, gap: spacing.2
    Skeleton(height: "32px", width: "60%")
    Skeleton(height: "24px", width: "80%")
    Skeleton(height: "24px", width: "70%")
    Skeleton(height: "24px", width: "75%")
    Skeleton(height: "32px", width: "60%")
    Skeleton(height: "24px", width: "80%")
  }

  // Error
  block {
    visibility: categoriesError
    Alert(severity: "error", message: "Could not load the category tree.", title: "Failed to load categories")
  }

  // Split layout: tree on left, detail on right
  block {
    visibility: !categoriesLoading
    layout: horizontal, gap: spacing.5
    min-height: treeMinHeight

    // Left panel: Tree
    block {
      background: semantic.surface-raised
      border-radius: radius.md
      border-right: borders.default
      shadow: elevation.raised
      overflow: "auto"
      padding: spacing.3
      layout: vertical, gap: spacing.3

      // Search input
      TextInput(type: "search", label: "Filter categories", value: searchQuery, placeholder: "Search...") {
        on change(v): { searchQuery = v }
      }

      // Tree component
      Tree(
        nodes: categoryList,
        expanded: [],
        selection: "single"
      ) {
        on selectionChange(ids): { selectNode(ids) }
      }
    }

    // Right panel: Selected node detail
    block {
      background: semantic.surface-raised
      border-radius: radius.md
      shadow: elevation.raised
      padding: spacing.5
      layout: vertical, gap: spacing.4

      // Empty state when nothing selected
      block {
        visibility: !hasSelection
        EmptyState(
          message: "No Category Selected",
          description: "Select a category from the tree to view its details."
        )
      }

      // Selected node detail
      block {
        visibility: hasSelection
        layout: vertical, gap: spacing.4

        text(selectedLabel) {
          style: type.heading-lg
          color: semantic.text-primary
          letter-spacing: "-0.01em"
        }

        // Detail card with individual borders
        block {
          padding: spacing.4
          background: semantic.surface
          border-radius: radius.md
          border-left: borders.accent-interactive
          layout: vertical, gap: spacing.3

          block {
            layout: horizontal, gap: spacing.2, align: center
            text("ID:") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
            text(selectedId) { style: type.mono-md, color: semantic.text-primary }
          }

          block {
            layout: horizontal, gap: spacing.2, align: center
            text("Name:") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
            text(selectedLabel) { style: type.body-md, weight: 600, color: semantic.text-primary }
          }
        }

        // Action buttons
        block {
          layout: horizontal, gap: spacing.3
          Button(label: "Add Subcategory", variant: "primary")
          Button(label: "Edit Category", variant: "secondary")
          Button(label: "Delete", variant: "destructive")
        }
      }
    }
  }
}
