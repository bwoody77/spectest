// LayoutsDemo — Showcases the 5 curated layout packages from the spec-registry.
// Previews are built inline to avoid dev-server component resolution issues
// with multi-level @import chains. The actual layout packages live in
// spec-registry/layouts/ and are documented in docs/layouts.md.

surface LayoutsDemo {
  @state {
    activeLayout: "auth-page"
    settingsSection: "profile"
    dashNav: "home"
  }

  @computed {
    showAuth: activeLayout == "auth-page"
    showDashboard: activeLayout == "dashboard"
    showLanding: activeLayout == "landing"
    showSettings: activeLayout == "settings-page"
    showSplit: activeLayout == "split-view"
  }

  @actions {
    setLayout(id) { activeLayout = id }
    setSettingsSection(id) { settingsSection = id }
    setDashNav(id) { dashNav = id }
  }

  layout: vertical, gap: spacing.5

  // Header
  block {
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "layout", size: icon.md, color: semantic.interactive)
    text("Layout Packages") { style: type.heading-lg, letter-spacing: "-0.02em" }
  }
  text("Curated page-level layouts from the spec-registry. Each layout composes existing components and works with all themes via design tokens.") {
    style: type.body-md
    color: semantic.text-secondary
  }

  // Layout selector tabs
  block {
    layout: horizontal, gap: spacing.2
    overflow: auto

    each [
      {id: "auth-page", label: "Auth Page"},
      {id: "dashboard", label: "Dashboard"},
      {id: "landing", label: "Landing"},
      {id: "settings-page", label: "Settings Page"},
      {id: "split-view", label: "Split View"}
    ] as tab {
      block {
        padding-x: spacing.3
        padding-y: spacing.2
        border-radius: radius.md
        cursor: "pointer"
        background: activeLayout == tab.id ? semantic.interactive : semantic.surface-raised
        border: activeLayout == tab.id ? "none" : borders.default
        on hover { background: activeLayout == tab.id ? semantic.interactive-hover : semantic.surface-hover }
        on click: setLayout(tab.id)

        text(tab.label) {
          style: type.body-sm
          color: activeLayout == tab.id ? semantic.on-interactive : semantic.text-primary
          weight: 500
        }
      }
    }
  }

  // Preview container
  block {
    border: borders.default
    border-radius: radius.lg
    overflow: hidden
    height: 520px
    background: semantic.background

    // ---------------------------------------------------------------
    // Auth Page — centered card with logo, form, and footer
    // ---------------------------------------------------------------
    block {
      visibility: showAuth
      height: 100%
      overflow: auto
      width: 100%
      background: semantic.background
      layout: vertical, align: center, justify: center
      padding: spacing.5

      block {
        width: 100%
        max-width: 420px
        background: semantic.surface
        border: borders.default
        border-radius: radius.lg
        shadow: elevation.layered
        padding: spacing.6
        layout: vertical, gap: spacing.5, align: center

        // Logo
        block {
          width: 48px
          height: 48px
          border-radius: radius.lg
          background: semantic.interactive
          layout: horizontal, align: center, justify: center
          Icon(name: "lock", size: 24, color: semantic.on-interactive)
        }

        // Title
        block {
          layout: vertical, gap: spacing.1, align: center
          text("Sign In") { style: type.heading-lg, color: semantic.text-primary, letter-spacing: "-0.02em" }
          text("Welcome back! Enter your credentials.") { style: type.body-md, color: semantic.text-secondary }
        }

        // Form
        block {
          width: 100%
          layout: vertical, gap: spacing.3
          TextInput(type: "text", label: "Email", value: "", placeholder: "you@example.com")
          TextInput(type: "text", label: "Password", value: "", placeholder: "Enter password")
          Button(label: "Sign In", variant: "primary")
        }

        // Footer
        block {
          width: 100%
          padding-top: spacing.3
          border-top: borders.default
          layout: horizontal, gap: spacing.2, justify: center, align: center
          text("Forgot password?") { style: type.body-sm, color: semantic.interactive, cursor: "pointer" }
          text("\u00B7") { color: semantic.text-tertiary }
          text("Create account") { style: type.body-sm, color: semantic.interactive, cursor: "pointer" }
        }
      }
    }

    // ---------------------------------------------------------------
    // Dashboard — sidebar + header + content area
    // ---------------------------------------------------------------
    block {
      visibility: showDashboard
      height: 100%
      overflow: hidden
      layout: vertical
      background: semantic.background

      // Header
      block {
        padding-y: 8px
        padding-x: 16px
        background: semantic.surface
        border-bottom: borders.default
        shadow: elevation.raised
        layout: horizontal, gap: spacing.4, align: center, justify: between

        block {
          layout: horizontal, gap: spacing.3, align: center
          Icon(name: "home", size: icon.lg, color: semantic.interactive)
          text("Acme App") { style: type.heading-lg, color: semantic.text-primary, letter-spacing: "-0.02em" }
        }

        Button(label: "Notifications", variant: "ghost")
      }

      // Body: sidebar + content
      block {
        grow: true
        layout: horizontal
        overflow: hidden

        // Sidebar
        block {
          width: 200px
          min-width: 200px
          height: 100%
          background: semantic.surface
          border-right: borders.default
          padding: spacing.2
          layout: vertical, gap: spacing.1
          overflow: auto

          text("MAIN") { style: type.caption, color: semantic.text-tertiary, text-transform: uppercase, letter-spacing: "0.05em" }

          each [
            {id: "home", label: "Home", icon: "home"},
            {id: "analytics", label: "Analytics", icon: "bar-chart"},
            {id: "users", label: "Users", icon: "user"}
          ] as item {
            block {
              layout: horizontal, gap: spacing.2, align: center
              padding: spacing.2
              border-radius: radius.md
              cursor: "pointer"
              background: item.id == dashNav ? semantic.surface-raised : "transparent"
              on hover { background: semantic.surface-raised }
              on click: setDashNav(item.id)
              Icon(name: item.icon, size: 18, color: item.id == dashNav ? semantic.interactive : semantic.text-secondary)
              text(item.label) { style: type.body-md, color: item.id == dashNav ? semantic.text-primary : semantic.text-secondary }
            }
          }

          block { height: spacing.3 }
          text("SYSTEM") { style: type.caption, color: semantic.text-tertiary, text-transform: uppercase, letter-spacing: "0.05em" }
          block {
            layout: horizontal, gap: spacing.2, align: center
            padding: spacing.2
            border-radius: radius.md
            cursor: "pointer"
            on hover { background: semantic.surface-raised }
            Icon(name: "settings", size: 18, color: semantic.text-secondary)
            text("Settings") { style: type.body-md, color: semantic.text-secondary }
          }
        }

        // Content
        block {
          grow: true
          padding: spacing.5
          background: semantic.surface
          overflow: auto
          layout: vertical, gap: spacing.4

          text("Dashboard Home") { style: type.heading-md, color: semantic.text-primary }
          text("This is the main content area. The sidebar handles navigation.") { style: type.body-md, color: semantic.text-secondary }

          block {
            layout: grid, columns: responsive("1fr", md: "1fr 1fr 1fr"), gap: spacing.4
            each [{label: "Users", value: "1,284"}, {label: "Revenue", value: "$42.5k"}, {label: "Orders", value: "856"}] as stat {
              Card() {
                block {
                  padding: spacing.4
                  layout: vertical, gap: spacing.1
                  text(stat.label) { style: type.body-sm, color: semantic.text-secondary }
                  text(stat.value) { style: type.heading-lg, color: semantic.text-primary }
                }
              }
            }
          }
        }
      }
    }

    // ---------------------------------------------------------------
    // Landing — hero + sections + footer
    // ---------------------------------------------------------------
    block {
      visibility: showLanding
      height: 100%
      overflow: auto
      layout: vertical
      background: semantic.background

      // Nav bar
      block {
        width: 100%
        padding-y: spacing.3
        padding-x: spacing.5
        background: semantic.surface
        border-bottom: borders.default
        layout: horizontal, align: center, justify: between

        text("SpecLang") { style: type.heading-sm, color: semantic.text-primary }
        block {
          layout: horizontal, gap: spacing.2
          Button(label: "Docs", variant: "ghost")
          Button(label: "Get Started", variant: "primary")
        }
      }

      // Hero
      block {
        width: 100%
        padding-y: spacing.8
        padding-x: spacing.5
        background: semantic.surface
        layout: vertical, gap: spacing.5, align: center

        block {
          max-width: 700px
          layout: vertical, gap: spacing.3, align: center
          text("Build UIs with Spec") { style: type.heading-xl, color: semantic.text-primary, letter-spacing: "-0.03em" }
          text("A declarative language that compiles to minimal, dependency-free JavaScript.") { style: type.body-lg, color: semantic.text-secondary }
        }

        block {
          layout: horizontal, gap: spacing.3
          Button(label: "Get Started", variant: "primary")
          Button(label: "View on GitHub", variant: "secondary")
        }
      }

      // Features section
      block {
        width: 100%
        padding-y: spacing.7
        padding-x: spacing.5
        layout: vertical, gap: spacing.5, align: center

        block {
          layout: vertical, gap: spacing.2, align: center
          text("Features") { style: type.heading-lg, color: semantic.text-primary, letter-spacing: "-0.02em" }
          text("Everything you need to build fast.") { style: type.body-lg, color: semantic.text-secondary }
        }

        block {
          width: 100%
          max-width: 900px
          layout: grid, columns: responsive("1fr", md: "1fr 1fr 1fr"), gap: spacing.4

          each [
            {title: "Declarative", desc: "Write what you want, not how to render it."},
            {title: "Tiny Output", desc: "~2 KB runtime. Zero dependencies."},
            {title: "Theme-able", desc: "Design tokens power every component."}
          ] as feat {
            Card() {
              block {
                padding: spacing.5
                layout: vertical, gap: spacing.2
                text(feat.title) { style: type.heading-sm, color: semantic.text-primary }
                text(feat.desc) { style: type.body-md, color: semantic.text-secondary }
              }
            }
          }
        }
      }

      // Footer
      block {
        width: 100%
        padding-y: spacing.5
        padding-x: spacing.5
        background: semantic.surface
        border-top: borders.default
        layout: horizontal, justify: between, align: center

        text("\u00A9 2026 Spec Project") { style: type.body-sm, color: semantic.text-tertiary }
        block {
          layout: horizontal, gap: spacing.3
          text("Docs") { style: type.body-sm, color: semantic.text-secondary }
          text("GitHub") { style: type.body-sm, color: semantic.text-secondary }
          text("Community") { style: type.body-sm, color: semantic.text-secondary }
        }
      }
    }

    // ---------------------------------------------------------------
    // Settings Page — left nav + right content
    // ---------------------------------------------------------------
    block {
      visibility: showSettings
      height: 100%
      overflow: auto
      padding: spacing.5
      layout: vertical, gap: spacing.5

      // Title
      block {
        layout: horizontal, gap: spacing.3, align: center
        Icon(name: "settings", size: icon.md, color: semantic.interactive)
        text("Settings") { style: type.heading-lg, color: semantic.text-primary, letter-spacing: "-0.02em" }
      }

      // Two-column
      block {
        layout: horizontal, gap: spacing.5
        grow: true

        // Left nav
        block {
          width: 200px
          min-width: 200px
          background: semantic.surface-raised
          border: borders.default
          border-radius: radius.lg
          padding: spacing.2
          layout: vertical, gap: spacing.1

          each [
            {id: "profile", label: "Profile", icon: "user"},
            {id: "notifications", label: "Notifications", icon: "bell"},
            {id: "security", label: "Security", icon: "lock"},
            {id: "billing", label: "Billing", icon: "credit-card"}
          ] as sec {
            block {
              layout: horizontal, gap: spacing.3, align: center
              padding: spacing.3
              border-radius: radius.md
              cursor: "pointer"
              background: sec.id == settingsSection ? semantic.surface : "transparent"
              shadow: sec.id == settingsSection ? elevation.raised : elevation.flat
              on hover { background: semantic.surface-hover }
              on click: setSettingsSection(sec.id)
              Icon(name: sec.icon, size: 18, color: sec.id == settingsSection ? semantic.interactive : semantic.text-secondary)
              text(sec.label) { style: type.body-md, color: sec.id == settingsSection ? semantic.text-primary : semantic.text-secondary }
            }
          }
        }

        // Right content
        block {
          grow: true
          layout: vertical, gap: spacing.4

          // Profile
          block {
            visibility: settingsSection == "profile"
            Card() {
              block {
                padding: spacing.5
                layout: vertical, gap: spacing.4
                text("Profile") { style: type.heading-md, color: semantic.text-primary }
                TextInput(type: "text", label: "Display Name", value: "Jane Doe", placeholder: "Your name")
                TextInput(type: "text", label: "Email", value: "jane@example.com", placeholder: "Email")
              }
            }
          }

          // Notifications
          block {
            visibility: settingsSection == "notifications"
            Card() {
              block {
                padding: spacing.5
                layout: vertical, gap: spacing.4
                text("Notifications") { style: type.heading-md, color: semantic.text-primary }
                Toggle(checked: true, label: "Email notifications")
                Toggle(checked: false, label: "Push notifications")
              }
            }
          }

          // Security
          block {
            visibility: settingsSection == "security"
            Card() {
              block {
                padding: spacing.5
                layout: vertical, gap: spacing.4
                text("Security") { style: type.heading-md, color: semantic.text-primary }
                text("Two-factor authentication is enabled.") { style: type.body-md, color: semantic.text-secondary }
                Button(label: "Change Password", variant: "secondary")
              }
            }
          }

          // Billing
          block {
            visibility: settingsSection == "billing"
            Card() {
              block {
                padding: spacing.5
                layout: vertical, gap: spacing.3
                text("Billing") { style: type.heading-md, color: semantic.text-primary }
                text("Current plan: Pro") { style: type.body-md, color: semantic.text-secondary }
                Button(label: "Manage Subscription", variant: "primary")
              }
            }
          }
        }
      }
    }

    // ---------------------------------------------------------------
    // Split View — two panels with divider
    // ---------------------------------------------------------------
    block {
      visibility: showSplit
      height: 100%
      overflow: hidden
      layout: horizontal

      // Left panel
      block {
        width: 240px
        min-width: 240px
        height: 100%
        overflow: auto
        background: semantic.surface
        padding: spacing.4
        layout: vertical, gap: spacing.3

        text("Files") { style: type.heading-sm, color: semantic.text-primary }

        each [
          {name: "app.spec"},
          {name: "settings.spec"},
          {name: "theme.spec"},
          {name: "utils.spec"}
        ] as file {
          block {
            layout: horizontal, gap: spacing.2, align: center
            padding: spacing.2
            border-radius: radius.md
            cursor: "pointer"
            on hover { background: semantic.surface-raised }
            Icon(name: "file", size: 16, color: semantic.text-secondary)
            text(file.name) { style: type.body-sm, color: semantic.text-primary }
          }
        }
      }

      // Divider
      block {
        width: 6px
        min-width: 6px
        height: 100%
        background: semantic.border
        cursor: "col-resize"
        layout: horizontal, align: center, justify: center
        on hover { background: semantic.interactive }
        transition: "background 100ms ease"

        block {
          width: 2px
          height: 24px
          border-radius: 1px
          background: semantic.text-tertiary
          opacity: 0.5
        }
      }

      // Right panel
      block {
        grow: true
        height: 100%
        overflow: auto
        background: semantic.surface
        padding: spacing.5
        layout: vertical, gap: spacing.3

        text("Editor") { style: type.heading-sm, color: semantic.text-primary }
        text("Select a file from the left panel to begin editing.") { style: type.body-md, color: semantic.text-secondary }

        block {
          padding: spacing.4
          background: semantic.surface-raised
          border-radius: radius.md
          border: borders.default

          text('surface App { ... }') {
            style: type.body-sm
            color: semantic.text-primary
          }
        }
      }
    }
  }
}
