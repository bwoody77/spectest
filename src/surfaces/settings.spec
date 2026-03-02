// SettingsPanel — Enhanced for Gate #22
// Uses: Accordion (Issue #17), Card (Issue #17), Alert (Issue #19),
//   responsive layout (Issue #58), hover states (Issue #53), text styling (Issue #55)

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

  block {
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "settings", size: icon.md, color: semantic.interactive)
    text("Settings") { style: type.heading-lg, letter-spacing: "-0.01em" }
  }
  text(settingsSummary) { style: type.body-sm, color: semantic.text-secondary }

  // Success Alert (Issue #19)
  block {
    visibility: savedVisible
    Alert(severity: "success", message: "Your preferences have been updated.", title: "Settings saved!", dismissible: true) {
      on dismiss: dismissSaved()
    }
  }

  // Settings sections using Card components (Issue #17)

  // Profile section
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      block {
        layout: horizontal, gap: spacing.2, align: center
        Icon(name: "user", size: icon.sm, color: semantic.interactive)
        text("Profile") { style: type.heading-md, letter-spacing: "-0.01em" }
      }

      block {
        layout: grid, columns: responsive("1fr", md: "1fr 1fr"), gap: spacing.4

        block {
          layout: vertical, gap: spacing.1
          Input(type: "text", label: "Display Name", value: displayName, placeholder: "Your name") {
            on change(v): { displayName = v }
          }
          block {
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
            visibility: hasEmailError
            text(emailError) { style: type.body-sm, color: palette.danger.500 }
          }
        }
      }

      Input(type: "textarea", label: "Bio", value: bio, placeholder: "Tell us about yourself...") {
        on change(v): { bio = v }
      }
    }
  }

  // Localization section
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      block {
        layout: horizontal, gap: spacing.2, align: center
        Icon(name: "globe", size: icon.sm, color: semantic.interactive)
        text("Localization") { style: type.heading-md, letter-spacing: "-0.01em" }
      }

      block {
        layout: grid, columns: responsive("1fr", md: "1fr 1fr 1fr"), gap: spacing.4

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
  }

  // Notification preferences section
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      block {
        layout: horizontal, gap: spacing.2, align: center
        Icon(name: "bell", size: icon.sm, color: semantic.interactive)
        text("Notifications") { style: type.heading-md, letter-spacing: "-0.01em" }
      }

      block {
        layout: vertical, gap: spacing.3
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
    }
  }

  // Display preferences section
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4

      block {
        layout: horizontal, gap: spacing.2, align: center
        Icon(name: "monitor", size: icon.sm, color: semantic.interactive)
        text("Display") { style: type.heading-md, letter-spacing: "-0.01em" }
      }

      block {
        layout: vertical, gap: spacing.3
        Toggle(checked: autoSave, label: "Auto-save changes") {
          on change(v): { autoSave = v }
        }
        Toggle(checked: compactMode, label: "Compact mode") {
          on change(v): { compactMode = v }
        }
        Toggle(checked: showAvatars, label: "Show avatars") {
          on change(v): { showAvatars = v }
        }
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
  }

  // Save button
  block {
    layout: responsive(vertical, md: horizontal), gap: spacing.3
    Button(label: "Save Settings", variant: "primary") {
      on click: saveSettings()
    }
    Button(label: "Reset", variant: "ghost")
  }
}
