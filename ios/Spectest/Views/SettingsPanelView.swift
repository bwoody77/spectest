import SwiftUI
import SpecRuntime

@Observable
final class SettingsPanelViewModel {
  var displayName: Any = "Admin User"
  var email: Any = "admin@example.com"
  var language: Any = "en"
  var timezone: Any = "utc"
  var emailNotifications: Any = true
  var pushNotifications: Any = false
  var weeklyDigest: Any = true
  var autoSave: Any = true
  var compactMode: Any = false
  var showAvatars: Any = true
  var itemsPerPage: Any = "25"
  var dateFormat: Any = "iso"
  var saved: Any = false
  var bio: Any = ""
  var nameError: Any { (specEq(displayName, "") ? "Display name is required" : "") }
  var emailError: Any { (specEq(email, "") ? "Email is required" : "") }
  var hasNameError: Any { specNeq(nameError, "") }
  var hasEmailError: Any { specNeq(emailError, "") }
  var isValid: Any { (specEq(nameError, "") && specEq(emailError, "")) }
  var savedVisible: Any { saved }
  var settingsSummary: Any { "Logged in as \(specString(displayName)) (\(specString(email)))" }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  func setDisplayName(_ v: Any) {
    displayName = v
  }
  func setEmail(_ v: Any) {
    email = v
  }
  func setLanguage(_ v: Any) {
    language = v
  }
  func setTimezone(_ v: Any) {
    timezone = v
  }
  func setEmailNotifications(_ v: Any) {
    emailNotifications = v
  }
  func setPushNotifications(_ v: Any) {
    pushNotifications = v
  }
  func setWeeklyDigest(_ v: Any) {
    weeklyDigest = v
  }
  func setAutoSave(_ v: Any) {
    autoSave = v
  }
  func setCompactMode(_ v: Any) {
    compactMode = v
  }
  func setShowAvatars(_ v: Any) {
    showAvatars = v
  }
  func setItemsPerPage(_ v: Any) {
    itemsPerPage = v
  }
  func setDateFormat(_ v: Any) {
    dateFormat = v
  }
  func setBio(_ v: Any) {
    bio = v
  }
  func saveSettings() {
    if (isValid) as? Bool ?? false {
      saved = true
    }
  }
  func dismissSaved() {
    saved = false
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct SettingsPanelView: View {
  @State private var vm = SettingsPanelViewModel()
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-5")) {
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        Image(systemName: specIconName(specString("settings")))
          .font(.system(size: specPx(ThemeManager.shared.resolve("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Settings"))
          .font(.title2.bold())
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)

      Text(verbatim: specString(vm.settingsSummary))
        .font(.callout.bold())
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      VStack() {
        if (vm.savedVisible) as? Bool ?? false {
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: specAlertIcon(specString("success")))
              .foregroundStyle(specAlertColor(specString("success")))
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Settings saved!")).font(.subheadline.weight(.semibold))
              Text(specString("Your preferences have been updated.")).font(.subheadline)
            }
            Spacer(minLength: 0)
            Button(action: {}) { Image(systemName: "xmark").foregroundStyle(.secondary) }
          }
          .padding(12)
          .background(specAlertColor(specString("success")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
      }

      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
            Image(systemName: specIconName(specString("user")))
              .font(.system(size: specPx(ThemeManager.shared.resolve("icon-sm"))))
              .foregroundStyle(ThemeManager.shared.color("interactive"))
            Text(verbatim: specString("Profile"))
              .font(.title3.bold())
            Spacer(minLength: 0)
          }
          .frame(maxWidth: .infinity)

          LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: ThemeManager.shared.size("spacing-4")) {
            VStack(spacing: ThemeManager.shared.size("spacing-1")) {
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("Display Name")).font(.subheadline).foregroundStyle(.secondary)
                TextField(specString("Your name"), text: Binding(get: { vm.displayName as? String ?? "" }, set: { vm.displayName = $0 }))
                .textFieldStyle(.roundedBorder)
              }
              VStack() {
                if (vm.hasNameError) as? Bool ?? false {
                  Text(verbatim: specString(vm.nameError))
                    .font(.callout.bold())
                    .foregroundStyle(Color(hex: "#db2424"))
                }
              }

            }

            VStack(spacing: ThemeManager.shared.size("spacing-1")) {
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("Email")).font(.subheadline).foregroundStyle(.secondary)
                TextField(specString("Your email"), text: Binding(get: { vm.email as? String ?? "" }, set: { vm.email = $0 }))
                .textFieldStyle(.roundedBorder)
              }
              VStack() {
                if (vm.hasEmailError) as? Bool ?? false {
                  Text(verbatim: specString(vm.emailError))
                    .font(.callout.bold())
                    .foregroundStyle(Color(hex: "#db2424"))
                }
              }

            }

          }

          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Bio")).font(.subheadline).foregroundStyle(.secondary)
            TextField(specString("Tell us about yourself..."), text: Binding(get: { vm.bio as? String ?? "" }, set: { vm.bio = $0 }))
            .textFieldStyle(.roundedBorder)
          }
        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
            Image(systemName: specIconName(specString("globe")))
              .font(.system(size: specPx(ThemeManager.shared.resolve("icon-sm"))))
              .foregroundStyle(ThemeManager.shared.color("interactive"))
            Text(verbatim: specString("Localization"))
              .font(.title3.bold())
            Spacer(minLength: 0)
          }
          .frame(maxWidth: .infinity)

          LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: ThemeManager.shared.size("spacing-4")) {
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Language")).font(.subheadline).foregroundStyle(.secondary)
              Menu {
                Picker(specString("Language"), selection: Binding(get: { specString(vm.language) }, set: { vm.language = $0 })) {
                  ForEach(Array(specArr([["value": "en" as Any, "label": "English" as Any] as [String: Any], ["value": "es" as Any, "label": "Spanish" as Any] as [String: Any], ["value": "fr" as Any, "label": "French" as Any] as [String: Any], ["value": "de" as Any, "label": "German" as Any] as [String: Any], ["value": "ja" as Any, "label": "Japanese" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                    Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                  }
                }
              } label: {
                HStack {
                  Text(verbatim: specString(vm.language)).foregroundStyle(.primary)
                  Spacer()
                  Image(systemName: "chevron.up.chevron.down").foregroundStyle(.secondary).font(.caption)
                }
                .padding(.horizontal, 12).padding(.vertical, 8)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
              }
            }
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Timezone")).font(.subheadline).foregroundStyle(.secondary)
              Menu {
                Picker(specString("Timezone"), selection: Binding(get: { specString(vm.timezone) }, set: { vm.timezone = $0 })) {
                  ForEach(Array(specArr([["value": "utc" as Any, "label": "UTC" as Any] as [String: Any], ["value": "est" as Any, "label": "US Eastern" as Any] as [String: Any], ["value": "pst" as Any, "label": "US Pacific" as Any] as [String: Any], ["value": "cet" as Any, "label": "Central European" as Any] as [String: Any], ["value": "jst" as Any, "label": "Japan Standard" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                    Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                  }
                }
              } label: {
                HStack {
                  Text(verbatim: specString(vm.timezone)).foregroundStyle(.primary)
                  Spacer()
                  Image(systemName: "chevron.up.chevron.down").foregroundStyle(.secondary).font(.caption)
                }
                .padding(.horizontal, 12).padding(.vertical, 8)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
              }
            }
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Date Format")).font(.subheadline).foregroundStyle(.secondary)
              Menu {
                Picker(specString("Date Format"), selection: Binding(get: { specString(vm.dateFormat) }, set: { vm.dateFormat = $0 })) {
                  ForEach(Array(specArr([["value": "iso" as Any, "label": "YYYY-MM-DD" as Any] as [String: Any], ["value": "us" as Any, "label": "MM/DD/YYYY" as Any] as [String: Any], ["value": "eu" as Any, "label": "DD/MM/YYYY" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                    Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                  }
                }
              } label: {
                HStack {
                  Text(verbatim: specString(vm.dateFormat)).foregroundStyle(.primary)
                  Spacer()
                  Image(systemName: "chevron.up.chevron.down").foregroundStyle(.secondary).font(.caption)
                }
                .padding(.horizontal, 12).padding(.vertical, 8)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
              }
            }
          }

        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
            Image(systemName: specIconName(specString("bell")))
              .font(.system(size: specPx(ThemeManager.shared.resolve("icon-sm"))))
              .foregroundStyle(ThemeManager.shared.color("interactive"))
            Text(verbatim: specString("Notifications"))
              .font(.title3.bold())
            Spacer(minLength: 0)
          }
          .frame(maxWidth: .infinity)

          VStack(spacing: ThemeManager.shared.size("spacing-3")) {
            Toggle(specString("Email notifications"), isOn: Binding(get: { vm.emailNotifications as? Bool ?? false }, set: { vm.emailNotifications = $0 }))
            Toggle(specString("Push notifications"), isOn: Binding(get: { vm.pushNotifications as? Bool ?? false }, set: { vm.pushNotifications = $0 }))
            Toggle(specString("Weekly digest email"), isOn: Binding(get: { vm.weeklyDigest as? Bool ?? false }, set: { vm.weeklyDigest = $0 }))
          }

        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
            Image(systemName: specIconName(specString("monitor")))
              .font(.system(size: specPx(ThemeManager.shared.resolve("icon-sm"))))
              .foregroundStyle(ThemeManager.shared.color("interactive"))
            Text(verbatim: specString("Display"))
              .font(.title3.bold())
            Spacer(minLength: 0)
          }
          .frame(maxWidth: .infinity)

          VStack(spacing: ThemeManager.shared.size("spacing-3")) {
            Toggle(specString("Auto-save changes"), isOn: Binding(get: { vm.autoSave as? Bool ?? false }, set: { vm.autoSave = $0 }))
            Toggle(specString("Compact mode"), isOn: Binding(get: { vm.compactMode as? Bool ?? false }, set: { vm.compactMode = $0 }))
            Toggle(specString("Show avatars"), isOn: Binding(get: { vm.showAvatars as? Bool ?? false }, set: { vm.showAvatars = $0 }))
          }

          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Items per page")).font(.subheadline).foregroundStyle(.secondary)
            Menu {
              Picker(specString("Items per page"), selection: Binding(get: { specString(vm.itemsPerPage) }, set: { vm.itemsPerPage = $0 })) {
                ForEach(Array(specArr([["value": "10" as Any, "label": "10 per page" as Any] as [String: Any], ["value": "25" as Any, "label": "25 per page" as Any] as [String: Any], ["value": "50" as Any, "label": "50 per page" as Any] as [String: Any], ["value": "100" as Any, "label": "100 per page" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                  Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                }
              }
            } label: {
              HStack {
                Text(verbatim: specString(vm.itemsPerPage)).foregroundStyle(.primary)
                Spacer()
                Image(systemName: "chevron.up.chevron.down").foregroundStyle(.secondary).font(.caption)
              }
              .padding(.horizontal, 12).padding(.vertical, 8)
              .background(Color(.systemBackground))
              .clipShape(RoundedRectangle(cornerRadius: 8))
              .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
            }
          }
        }
        .padding(ThemeManager.shared.size("spacing-5"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        Button(action: { Task { @MainActor in await vm.saveSettings() } }) {
          Text(specString("Save Settings"))
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.blue, in: RoundedRectangle(cornerRadius: 8))
        }
        Button(action: {  }) {
          Text(specString("Reset"))
            .font(.subheadline.weight(.medium))
            .foregroundStyle(.blue)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
