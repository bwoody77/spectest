surface MobileDemo(api) {
  @state {
    activeTab: "home"
    sheetOpen: false
    actionSheetOpen: false
    snackbarOpen: false
    items: [
      { id: "1", title: "Welcome to Mobile", subtitle: "Swipe, scroll, and tap" },
      { id: "2", title: "Gesture Support", subtitle: "Swipe left/right, drag, long-press" },
      { id: "3", title: "Bottom Sheet", subtitle: "Tap to open the bottom sheet" },
      { id: "4", title: "Safe Areas", subtitle: "Proper insets on all devices" },
      { id: "5", title: "Scroll Snapping", subtitle: "Smooth carousel experience" }
    ]
    loadingMore: false
    hasMoreItems: true
  }

  @actions {
    onTabChange(tabId) {
      activeTab = tabId
    }
    openSheet() {
      sheetOpen = true
    }
    closeSheet() {
      sheetOpen = false
    }
    openActionSheet() {
      actionSheetOpen = true
    }
    closeActionSheet() {
      actionSheetOpen = false
    }
    showSnackbar() {
      snackbarOpen = true
    }
    closeSnackbar() {
      snackbarOpen = false
    }
    loadMore() {
      loadingMore = true
    }
    handleSwipeLeft() {
      showSnackbar()
    }
    handleSwipeRight() {
      openSheet()
    }
  }

  block {
    width: 100%
    min-height: 100vh
    background: semantic.surface
    layout: vertical

    // Header
    block {
      padding: spacing.4
      padding-top: env(safe-area-inset-top)
      background: semantic.surface
      border-bottom: borders.default

      text("Mobile Demo") {
        style: type.heading-lg
        color: semantic.text-primary
      }
      text("Gesture events, bottom sheet, safe areas") {
        style: type.body-sm
        color: semantic.text-secondary
      }
    }

    // Content
    block {
      grow: true
      padding: spacing.4
      padding-bottom: 80px
      overflow: "auto"
      scroll-boundary: "contain"
      layout: vertical, gap: 16px

      // Swipe demo
      block {
        padding: spacing.5
        background: semantic.surface-raised
        border-radius: radius.lg
        layout: vertical, gap: 8px
        user-select: "none"
        on swipe-left: handleSwipeLeft()
        on swipe-right: handleSwipeRight()

        text("Swipe Zone") {
          style: type.heading-sm
          color: semantic.text-primary
        }
        text("Swipe left for snackbar, right for bottom sheet") {
          style: type.body-sm
          color: semantic.text-secondary
        }
      }

      // Scroll snap demo
      block {
        layout: vertical, gap: 8px

        text("Scroll Snap Carousel") {
          style: type.heading-sm
          color: semantic.text-primary
        }

        block {
          layout: horizontal, gap: 16px
          overflow: "auto"
          scroll-snap: "x"
          scroll-boundary: "contain"

          each items as item {
            block {
              min-width: 280px
              padding: spacing.5
              background: semantic.accent
              border-radius: radius.lg
              snap-align: "center"

              text(item.title) {
                style: type.heading-sm
                color: "white"
              }
              text(item.subtitle) {
                style: type.body-sm
                color: "rgba(255, 255, 255, 0.8)"
              }
            }
          }
        }
      }

      // Action buttons
      block {
        layout: vertical, gap: 8px

        text("Components") {
          style: type.heading-sm
          color: semantic.text-primary
        }

        block {
          layout: horizontal, gap: 8px

          block {
            padding-x: spacing.4
            padding-y: spacing.2
            background: semantic.accent
            border-radius: radius.md
            cursor: "pointer"
            on click: openSheet()
            text("Bottom Sheet") {
              color: "white"
              style: type.label
            }
          }

          block {
            padding-x: spacing.4
            padding-y: spacing.2
            background: semantic.accent
            border-radius: radius.md
            cursor: "pointer"
            on click: openActionSheet()
            text("Action Sheet") {
              color: "white"
              style: type.label
            }
          }

          block {
            padding-x: spacing.4
            padding-y: spacing.2
            background: semantic.accent
            border-radius: radius.md
            cursor: "pointer"
            on click: showSnackbar()
            text("Snackbar") {
              color: "white"
              style: type.label
            }
          }
        }
      }

      // Long press demo
      block {
        padding: spacing.5
        background: semantic.surface-raised
        border-radius: radius.lg
        layout: vertical, gap: 8px
        on long-press: openActionSheet()

        text("Long Press") {
          style: type.heading-sm
          color: semantic.text-primary
        }
        text("Long press this card to open the action sheet") {
          style: type.body-sm
          color: semantic.text-secondary
        }
      }

      // Visibility demo
      block {
        padding: spacing.5
        background: semantic.surface-raised
        border-radius: radius.lg
        on visible: showSnackbar()

        text("Visibility Trigger") {
          style: type.heading-sm
          color: semantic.text-primary
        }
        text("Snackbar shown when this card scrolled into view") {
          style: type.body-sm
          color: semantic.text-secondary
        }
      }
    }

    // Bottom tab bar
    BottomTabBar(
      tabs: [
        { id: "home", label: "Home", icon: "home" },
        { id: "search", label: "Search", icon: "search" },
        { id: "settings", label: "Settings", icon: "settings" },
        { id: "user", label: "Profile", icon: "user" }
      ],
      activeTab: activeTab
    ) {
      on tabChange(tabId): onTabChange(tabId)
    }

    // Bottom sheet
    BottomSheet(open: sheetOpen) {
      on close: closeSheet()

      block {
        padding: spacing.5
        layout: vertical, gap: 12px

        text("Bottom Sheet") {
          style: type.heading-md
          color: semantic.text-primary
        }
        text("This sheet slides up from the bottom. You can drag the handle to resize or dismiss it.") {
          style: type.body
          color: semantic.text-secondary
        }
      }
    }

    // Action sheet
    ActionSheet(
      open: actionSheetOpen,
      title: "Choose an action",
      actions: [
        { id: "share", label: "Share" },
        { id: "copy", label: "Copy Link" },
        { id: "edit", label: "Edit" },
        { id: "delete", label: "Delete", destructive: true }
      ]
    ) {
      on close: closeActionSheet()
      on select(actionId): closeActionSheet()
    }

    // Snackbar
    Snackbar(
      open: snackbarOpen,
      message: "Action completed successfully",
      actionLabel: "Undo"
    ) {
      on close: closeSnackbar()
      on action: closeSnackbar()
    }

    // FAB
    FAB(icon: "plus") {
      on click: openSheet()
    }
  }
}
