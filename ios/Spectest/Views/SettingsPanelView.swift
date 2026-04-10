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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct SettingsPanelView: View {
  @State private var vm = SettingsPanelViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      HStack(alignment: .center, spacing: CGFloat(12)) {
        Image(systemName: specIconName(specString("settings")))
          .font(.system(size: specPx("20px")))
          .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
        Text(verbatim: specString("Settings"))
          .font(.title2.bold())
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)

      Text(verbatim: specString(vm.settingsSummary))
        .font(.callout.bold())
        .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
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
        VStack(spacing: CGFloat(16)) {
          HStack(alignment: .center, spacing: CGFloat(8)) {
            Image(systemName: specIconName(specString("user")))
              .font(.system(size: specPx("18px")))
              .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
            Text(verbatim: specString("Profile"))
              .font(.title3.bold())
            Spacer(minLength: 0)
          }
          .frame(maxWidth: .infinity)

          LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: CGFloat(16)) {
            VStack(spacing: CGFloat(4)) {
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("Display Name")).font(.subheadline).foregroundStyle(.secondary)
                TextField(specString("Your name"), text: Binding(get: { vm.displayName as? String ?? "" }, set: { vm.displayName = $0 }))
              }
              VStack() {
                if (vm.hasNameError) as? Bool ?? false {
                  Text(verbatim: specString(vm.nameError))
                    .font(.callout.bold())
                    .foregroundStyle(Color(hex: "#db2424"))
                }
              }

            }

            VStack(spacing: CGFloat(4)) {
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("Email")).font(.subheadline).foregroundStyle(.secondary)
                TextField(specString("Your email"), text: Binding(get: { vm.email as? String ?? "" }, set: { vm.email = $0 }))
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
          }
        }
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          HStack(alignment: .center, spacing: CGFloat(8)) {
            Image(systemName: specIconName(specString("globe")))
              .font(.system(size: specPx("18px")))
              .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
            Text(verbatim: specString("Localization"))
              .font(.title3.bold())
            Spacer(minLength: 0)
          }
          .frame(maxWidth: .infinity)

          LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: CGFloat(16)) {
            Picker(specString("Language"), selection: Binding(get: { specString(vm.language) }, set: { vm.language = $0 })) {
              ForEach(Array(([["value": "en" as Any, "label": "English" as Any] as [String: Any], ["value": "es" as Any, "label": "Spanish" as Any] as [String: Any], ["value": "fr" as Any, "label": "French" as Any] as [String: Any], ["value": "de" as Any, "label": "German" as Any] as [String: Any], ["value": "ja" as Any, "label": "Japanese" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
                Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
              }
            }
            .pickerStyle(.menu)
            Picker(specString("Timezone"), selection: Binding(get: { specString(vm.timezone) }, set: { vm.timezone = $0 })) {
              ForEach(Array(([["value": "utc" as Any, "label": "UTC" as Any] as [String: Any], ["value": "est" as Any, "label": "US Eastern" as Any] as [String: Any], ["value": "pst" as Any, "label": "US Pacific" as Any] as [String: Any], ["value": "cet" as Any, "label": "Central European" as Any] as [String: Any], ["value": "jst" as Any, "label": "Japan Standard" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
                Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
              }
            }
            .pickerStyle(.menu)
            Picker(specString("Date Format"), selection: Binding(get: { specString(vm.dateFormat) }, set: { vm.dateFormat = $0 })) {
              ForEach(Array(([["value": "iso" as Any, "label": "YYYY-MM-DD" as Any] as [String: Any], ["value": "us" as Any, "label": "MM/DD/YYYY" as Any] as [String: Any], ["value": "eu" as Any, "label": "DD/MM/YYYY" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
                Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
              }
            }
            .pickerStyle(.menu)
          }

        }
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          HStack(alignment: .center, spacing: CGFloat(8)) {
            Image(systemName: specIconName(specString("bell")))
              .font(.system(size: specPx("18px")))
              .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
            Text(verbatim: specString("Notifications"))
              .font(.title3.bold())
            Spacer(minLength: 0)
          }
          .frame(maxWidth: .infinity)

          VStack(spacing: CGFloat(12)) {
            Toggle(specString("Email notifications"), isOn: Binding(get: { vm.emailNotifications as? Bool ?? false }, set: { vm.emailNotifications = $0 }))
            Toggle(specString("Push notifications"), isOn: Binding(get: { vm.pushNotifications as? Bool ?? false }, set: { vm.pushNotifications = $0 }))
            Toggle(specString("Weekly digest email"), isOn: Binding(get: { vm.weeklyDigest as? Bool ?? false }, set: { vm.weeklyDigest = $0 }))
          }

        }
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(spacing: CGFloat(16)) {
          HStack(alignment: .center, spacing: CGFloat(8)) {
            Image(systemName: specIconName(specString("monitor")))
              .font(.system(size: specPx("18px")))
              .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
            Text(verbatim: specString("Display"))
              .font(.title3.bold())
            Spacer(minLength: 0)
          }
          .frame(maxWidth: .infinity)

          VStack(spacing: CGFloat(12)) {
            Toggle(specString("Auto-save changes"), isOn: Binding(get: { vm.autoSave as? Bool ?? false }, set: { vm.autoSave = $0 }))
            Toggle(specString("Compact mode"), isOn: Binding(get: { vm.compactMode as? Bool ?? false }, set: { vm.compactMode = $0 }))
            Toggle(specString("Show avatars"), isOn: Binding(get: { vm.showAvatars as? Bool ?? false }, set: { vm.showAvatars = $0 }))
          }

          Picker(specString("Items per page"), selection: Binding(get: { specString(vm.itemsPerPage) }, set: { vm.itemsPerPage = $0 })) {
            ForEach(Array(([["value": "10" as Any, "label": "10 per page" as Any] as [String: Any], ["value": "25" as Any, "label": "25 per page" as Any] as [String: Any], ["value": "50" as Any, "label": "50 per page" as Any] as [String: Any], ["value": "100" as Any, "label": "100 per page" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
              Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
            }
          }
          .pickerStyle(.menu)
        }
        .padding(CGFloat(20))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      HStack(alignment: .center, spacing: CGFloat(12)) {
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
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
