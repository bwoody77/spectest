// SettingsPanel — lots of form controls for settings

surface SettingsPanel {
  @state {
    displayName: "Admin User"
    email: "admin@example.com"
    language: "en"
    timezone: "utc"
    emailNotifications: true
    pushNotifications: false
    weeklyDigest: true
    autoSave: true
    compactMode: false
    showAvatars: true
    itemsPerPage: "25"
    dateFormat: "iso"
    saved: false
    bio: ""
  }

  @computed {
    nameError: displayName == "" ? "Display name is required" : ""
    emailError: email == "" ? "Email is required" : ""
    hasNameError: nameError != ""
    hasEmailError: emailError != ""
    isValid: nameError == "" && emailError == ""
    savedVisible: saved
    settingsSummary: "Logged in as {displayName} ({email})"
  }

  @actions {
    setDisplayName(v) { displayName = v }
    setEmail(v) { email = v }
    setLanguage(v) { language = v }
    setTimezone(v) { timezone = v }
    setEmailNotifications(v) { emailNotifications = v }
    setPushNotifications(v) { pushNotifications = v }
    setWeeklyDigest(v) { weeklyDigest = v }
    setAutoSave(v) { autoSave = v }
    setCompactMode(v) { compactMode = v }
    setShowAvatars(v) { showAvatars = v }
    setItemsPerPage(v) { itemsPerPage = v }
    setDateFormat(v) { dateFormat = v }
    setBio(v) { bio = v }
    saveSettings() {
      if isValid {
        saved = true
      }
    }
    dismissSaved() { saved = false }
  }

  layout: vertical, gap: spacing.5

  text("Settings") { style: type.heading-lg }
  text(settingsSummary) { style: type.body-sm, color: semantic.text-secondary }

  // Success banner
  block {
    aria-live: "polite"
    visibility: savedVisible
    padding: spacing.3
    background: "#ecfdf5"
    border: "1px solid #bbf7d0"
    border-radius: radius.md
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "check", size: "20px", color: "#10b981")
    text("Settings saved successfully!") { style: type.body-md, color: palette.success.500 }
    Button(label: "Dismiss", variant: "ghost") {
      on click: dismissSaved()
    }
  }

  // Profile section
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: vertical, gap: spacing.4

    text("Profile") { style: type.heading-md }

    block {
      layout: horizontal, gap: spacing.4

      block {
        layout: vertical, gap: spacing.1
        Input(type: "text", label: "Display Name", value: displayName, placeholder: "Your name") {
          on change(v): { displayName = v }
        }
        block {
          aria-live: "polite"
          visibility: hasNameError
          text(nameError) { style: type.body-sm, color: palette.danger.500 }
        }
      }

      block {
        layout: vertical, gap: spacing.1
        Input(type: "text", label: "Email", value: email, placeholder: "Your email") {
          on change(v): { email = v }
        }
        block {
          aria-live: "polite"
          visibility: hasEmailError
          text(emailError) { style: type.body-sm, color: palette.danger.500 }
        }
      }
    }

    Input(type: "textarea", label: "Bio", value: bio, placeholder: "Tell us about yourself...") {
      on change(v): { bio = v }
    }
  }

  // Localization section
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: vertical, gap: spacing.4

    text("Localization") { style: type.heading-md }

    block {
      layout: horizontal, gap: spacing.4

      Select(
        options: [
          {value: "en", label: "English"},
          {value: "es", label: "Spanish"},
          {value: "fr", label: "French"},
          {value: "de", label: "German"},
          {value: "ja", label: "Japanese"}
        ],
        value: language,
        label: "Language"
      ) {
        on change(v): { language = v }
      }

      Select(
        options: [
          {value: "utc", label: "UTC"},
          {value: "est", label: "US Eastern"},
          {value: "pst", label: "US Pacific"},
          {value: "cet", label: "Central European"},
          {value: "jst", label: "Japan Standard"}
        ],
        value: timezone,
        label: "Timezone"
      ) {
        on change(v): { timezone = v }
      }

      Select(
        options: [
          {value: "iso", label: "YYYY-MM-DD"},
          {value: "us", label: "MM/DD/YYYY"},
          {value: "eu", label: "DD/MM/YYYY"}
        ],
        value: dateFormat,
        label: "Date Format"
      ) {
        on change(v): { dateFormat = v }
      }
    }
  }

  // Notification preferences
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: vertical, gap: spacing.4

    text("Notifications") { style: type.heading-md }

    Toggle(checked: emailNotifications, label: "Email notifications") {
      on change(v): { emailNotifications = v }
    }
    Toggle(checked: pushNotifications, label: "Push notifications") {
      on change(v): { pushNotifications = v }
    }
    Toggle(checked: weeklyDigest, label: "Weekly digest email") {
      on change(v): { weeklyDigest = v }
    }
  }

  // Display preferences
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: vertical, gap: spacing.4

    text("Display") { style: type.heading-md }

    Toggle(checked: autoSave, label: "Auto-save changes") {
      on change(v): { autoSave = v }
    }
    Toggle(checked: compactMode, label: "Compact mode") {
      on change(v): { compactMode = v }
    }
    Toggle(checked: showAvatars, label: "Show avatars") {
      on change(v): { showAvatars = v }
    }

    Select(
      options: [
        {value: "10", label: "10 per page"},
        {value: "25", label: "25 per page"},
        {value: "50", label: "50 per page"},
        {value: "100", label: "100 per page"}
      ],
      value: itemsPerPage,
      label: "Items per page"
    ) {
      on change(v): { itemsPerPage = v }
    }
  }

  // Save button
  block {
    layout: horizontal, gap: spacing.3
    Button(label: "Save Settings", variant: "primary") {
      on click: saveSettings()
    }
    Button(label: "Reset", variant: "ghost")
  }
}
