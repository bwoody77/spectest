// RoutingDemo — demonstrates @router for client-side path-based routing.
//
// @router maps URL patterns to surface/component names. The compiler
// automatically generates:
//   _routePath    — signal: current pathname (synced to browser URL)
//   _routeParams  — signal: extracted route parameters object
//   navigate(path) — action: pushState + update _routePath/_routeParams
//
// Route patterns support :param segments, e.g. '/users/:id'.
// The browser back/forward buttons are handled automatically.
//
// Usage:
//   @router {
//     '/' -> Home
//     '/users/:id' -> UserDetail(id: _routeParams.id)
//     '/settings' -> Settings
//   }
//
// Then use navigate(path) in actions to change routes.
// Use _routePath to show active state in navigation links.

// Simulated "sub-surfaces" for the router demo
component RouterHome() {
  block {
    padding: spacing.5
    layout: vertical, gap: spacing.3
    text("Home Page") { style: type.heading-sm, color: semantic.text-primary }
    text("This is the root route ('/'). Navigate using the links in the sidebar.") {
      style: type.body-md
      color: semantic.text-secondary
    }
  }
}

component RouterAbout() {
  block {
    padding: spacing.5
    layout: vertical, gap: spacing.3
    text("About") { style: type.heading-sm, color: semantic.text-primary }
    text("This is the '/about' route. The browser URL changed when you clicked the link.") {
      style: type.body-md
      color: semantic.text-secondary
    }
    text("Your browser's back button will return to the previous route.") {
      style: type.body-sm
      color: semantic.text-secondary
    }
  }
}

component RouterUser(userId: string) {
  block {
    padding: spacing.5
    layout: vertical, gap: spacing.3
    text("User Profile") { style: type.heading-sm, color: semantic.text-primary }
    text("Route: /users/{userId}") { style: type.body-md, color: semantic.text-secondary }
    text("The ':id' segment from the URL pattern is extracted into _routeParams.id and passed as a prop.") {
      style: type.body-sm
      color: semantic.text-secondary
    }
    block {
      padding: spacing.4
      background: semantic.surface-raised
      border-radius: radius.md
      border: borders.default
      layout: horizontal, gap: spacing.3, align: "center"
      block {
        width: 40px
        height: 40px
        border-radius: "50%"
        background: semantic.primary
        layout: horizontal, justify: "center", align: "center"
        text(userId ? userId[0] : "?") { style: type.heading-sm, color: "#fff" }
      }
      block {
        layout: vertical, gap: spacing.1
        text("User #{userId}") { style: type.body-md, color: semantic.text-primary }
        text("user{userId}@example.com") { style: type.body-sm, color: semantic.text-secondary }
      }
    }
  }
}

component RouterNotFound() {
  block {
    padding: spacing.5
    layout: vertical, gap: spacing.3
    text("404 — Not Found") { style: type.heading-sm, color: "#dc2626" }
    text("No route matched the current path. This is the wildcard fallback.") {
      style: type.body-md
      color: semantic.text-secondary
    }
  }
}

surface RoutingDemo() {
  @router {
    '/' -> RouterHome
    '/about' -> RouterAbout
    '/users/:id' -> RouterUser(userId: _routeParams.id)
  }

  layout: horizontal, gap: 0

  // Sidebar navigation
  block {
    width: 200px
    min-height: 300px
    background: semantic.surface-raised
    border: "1px solid #e5e7eb 1px 0 0 0"
    padding: spacing.3
    layout: vertical, gap: spacing.1

    text("Navigation") { style: type.label-sm, color: semantic.text-tertiary }

    block {
      padding: "8px 12px"
      border-radius: radius.md
      cursor: "pointer"
      background: _routePath == "/" ? semantic.primary + "22" : "transparent"
      border-left: _routePath == "/" ? "3px solid " + semantic.primary : "3px solid transparent"
      on click: navigate("/")
      text("Home") {
        style: type.body-sm
        color: _routePath == "/" ? semantic.primary : semantic.text-primary
      }
    }

    block {
      padding: "8px 12px"
      border-radius: radius.md
      cursor: "pointer"
      background: _routePath == "/about" ? semantic.primary + "22" : "transparent"
      border-left: _routePath == "/about" ? "3px solid " + semantic.primary : "3px solid transparent"
      on click: navigate("/about")
      text("About") {
        style: type.body-sm
        color: _routePath == "/about" ? semantic.primary : semantic.text-primary
      }
    }

    text("Users") { style: type.label-sm, color: semantic.text-tertiary }

    each [{id: "1"}, {id: "2"}, {id: "3"}] as user {
      block {
        padding: "8px 12px"
        border-radius: radius.md
        cursor: "pointer"
        background: _routePath == "/users/" + user.id ? semantic.primary + "22" : "transparent"
        border-left: _routePath == "/users/" + user.id ? "3px solid " + semantic.primary : "3px solid transparent"
        on click: navigate("/users/" + user.id)
        text("User #{user.id}") {
          style: type.body-sm
          color: _routePath == "/users/" + user.id ? semantic.primary : semantic.text-primary
        }
      }
    }

    block {
      padding: "8px 12px"
      border-radius: radius.md
      cursor: "pointer"
      background: _routePath == "/nowhere" ? semantic.primary + "22" : "transparent"
      on click: navigate("/nowhere")
      text("Unknown route →") {
        style: type.body-sm
        color: "#dc2626"
      }
    }
  }

  // Route outlet — rendered by @router
  block {
    grow: true
    background: semantic.surface

    // @router renders matching surface here via lazy-mount
    block {
      visibility: _routePath == "/"
      RouterHome()
    }
    block {
      visibility: _routePath == "/about"
      RouterAbout()
    }
    block {
      visibility: _routePath != "/" && _routePath != "/about" && _routeParams.id != null
      RouterUser(userId: _routeParams.id)
    }
    block {
      visibility: _routePath != "/" && _routePath != "/about" && _routeParams.id == null
      RouterNotFound()
    }
  }
}
