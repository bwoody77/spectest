// TeamDirectory — user cards from UsersAPI, avatars, roles

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
    filteredUsers: roleFilter == "all" ? userList : userList.filter(u -> u.role == roleFilter)
    searchResults: filteredUsers
    userCount: "{searchResults.length} members"
    hasNoUsers: searchResults.length == 0
  }

  @actions {
    setSearch(v) { search = v }
    setRoleFilter(v) { roleFilter = v }
  }

  layout: vertical, gap: spacing.5

  text("Team Directory") { style: type.heading-lg }

  // Search & filter bar
  block {
    padding: spacing.3
    background: palette.neutral.50
    border-radius: radius.md
    layout: horizontal, gap: spacing.3, align: center

    Input(type: "text", label: "Search", value: search, placeholder: "Search members...") {
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

    text(userCount) { style: type.body-sm, color: semantic.text-secondary }
  }

  // Loading
  block {
    aria-live: "polite"
    visibility: usersLoading
    padding: spacing.4
    background: "#f0f9ff"
    border-radius: radius.md
    text("Loading team members...") { style: type.body-sm, color: semantic.text-secondary }
  }

  // Error
  block {
    aria-live: "assertive"
    visibility: usersError
    padding: spacing.3
    background: "#fef2f2"
    border: "1px solid #fecaca"
    border-radius: radius.md
    text("Failed to load team directory.") { style: type.body-sm, color: palette.danger.500 }
  }

  // User cards
  block {
    layout: horizontal, gap: spacing.4

    each searchResults as user, idx {
      block {
        padding: spacing.4
        background: "#ffffff"
        border: "1px solid #e2e8f0"
        border-radius: radius.lg
        layout: vertical, gap: spacing.3, align: center

        UserAvatar(user.name, "#6366f1")

        block {
          layout: vertical, gap: spacing.1, align: center
          text(user.name) { style: type.body-md, weight: 600 }
          text(user.role) { style: type.label-sm, color: semantic.text-secondary }
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

  // Empty state
  block {
    aria-live: "polite"
    visibility: hasNoUsers
    padding: spacing.4
    background: palette.neutral.50
    border-radius: radius.md
    layout: vertical, gap: spacing.2, align: center
    Icon(name: "users", size: "24px", color: "#64748b")
    text("No team members match your criteria.") { style: type.body-sm, color: semantic.text-secondary }
  }
}
