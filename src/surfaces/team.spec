// TeamDirectory — Enhanced for Gate #22
// Uses: Card (Issue #17), EmptyState (Issue #17), Badge (Issue #17),
//   responsive grid (Issue #58), hover states (Issue #53), transitions (Issue #52),
//   shadows (Issue #54), transforms (Issue #54), Skeleton (Issue #19)

surface TeamDirectory {
  @source {
    users: UsersAPI
  }

  @state {
    search: ""
    roleFilter: "all"
  }

  @computed {
    userList: users != null ? users : []
    filteredUsers: roleFilter == "all" ? userList : userList.filter(u => u.role == roleFilter)
    searchResults: search == "" ? filteredUsers : filteredUsers.filter(u => u.name.toLowerCase().includes(search.toLowerCase()))
    userCount: "{searchResults.length} members"
    hasNoUsers: searchResults.length == 0
  }

  @actions {
    setSearch(v) { search = v }
    setRoleFilter(v) { roleFilter = v }
  }

  layout: vertical, gap: spacing.5

  block {
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "user", size: icon.md, color: semantic.interactive)
    text("Team Directory") { style: type.heading-lg, letter-spacing: "-0.01em" }
  }

  // Search & filter bar
  Card() {
    block {
      padding: spacing.4
      layout: responsive(vertical, md: horizontal), gap: spacing.3, align: center

      Input(type: "search", label: "Search", value: search, placeholder: "Search members...") {
        on change(v): { search = v }
      }

      Select(
        options: [
          {value: "all", label: "All Roles"},
          {value: "admin", label: "Admin"},
          {value: "dev", label: "Developer"},
          {value: "design", label: "Designer"}
        ],
        value: roleFilter,
        label: "Role"
      ) {
        on change(v): { roleFilter = v }
      }

      Badge(text: userCount, variant: "neutral")
    }
  }

  // Skeleton loading (Issue #19)
  block {
    visibility: usersLoading
    layout: grid, columns: responsive("1fr", md: "1fr 1fr", lg: "1fr 1fr 1fr"), gap: spacing.4
    Skeleton(height: "180px", width: "100%")
    Skeleton(height: "180px", width: "100%")
    Skeleton(height: "180px", width: "100%")
  }

  // Error
  block {
    visibility: usersError
    Alert(severity: "error", message: "Could not retrieve team member data.", title: "Failed to load team directory")
  }

  // User cards with responsive grid (Issue #58) and hover states (Issue #53)
  block {
    layout: grid, columns: responsive("1fr", md: "1fr 1fr", lg: "1fr 1fr 1fr"), gap: spacing.4

    each searchResults as user, idx {
      Card() {
        block {
          padding: spacing.5
          border-radius: radius.lg
          transition: transition.card-lift
          cursor: "pointer"
          layout: vertical, gap: spacing.4, align: center

          on hover {
            transform: transform.lift-lg
            shadow: elevation.floating
          }

          UserAvatar(user.name, semantic.interactive)

          block {
            layout: vertical, gap: spacing.1, align: center
            text(user.name) { style: type.body-md, weight: 600 }
            Badge(text: user.role, variant: "neutral")
            text(user.email) { style: type.body-sm, color: semantic.text-secondary }
          }

          block {
            layout: horizontal, gap: spacing.2
            Button(label: "Message", variant: "secondary")
            Button(label: "Profile", variant: "ghost")
          }
        }
      }
    }
  }

  // Empty state (Issue #17)
  block {
    visibility: hasNoUsers
    EmptyState(
      message: "No Team Members Found",
      description: "No team members match your search criteria."
    )
  }
}
