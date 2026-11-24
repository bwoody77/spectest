import SwiftUI
import SpecRuntime

@Observable
@MainActor
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
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct SettingsPanelView: View {
  @State private var vm = SettingsPanelViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = SettingsPanelViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Image(systemName: specIconName(specString("settings")))
          .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Settings"))
          .font(.largeTitle)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
      }

      Text(verbatim: specString(vm.settingsSummary))
        .font(.footnote)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      if (vm.savedVisible) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
        if (vm.savedVisible) as? Bool ?? false {
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: specAlertIcon(specString("success")))
              .foregroundStyle(specAlertColor(specString("success")))
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Settings saved!")).font(.subheadline.weight(.semibold))
              Text(specString("Your preferences have been updated.")).font(.subheadline)
            }
            Spacer(minLength: 0)
            Button(action: { vm.dismissSaved() }) { Image(systemName: "xmark").foregroundStyle(.secondary) }.accessibilityLabel("Dismiss")
          }
          .padding(12)
          .background(specAlertColor(specString("success")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
      }

      }
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
            Image(systemName: specIconName(specString("user")))
              .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-sm"))))
              .foregroundStyle(ThemeManager.shared.color("interactive"))
            Text(verbatim: specString("Profile"))
              .font(.title)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
          }

          LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("Display Name")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                SpecTextField(specString("Your name"), text: Binding(get: { vm.displayName as? String ?? "" }, set: { newValue in vm.displayName = newValue; let v: Any = newValue; vm.displayName = v }))
                .textFieldStyle(.roundedBorder)
                .specAccessibilityLabel(specFieldName("", "Display Name"))
              }
              if (vm.hasNameError) as? Bool ?? false {
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString(vm.nameError))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(Color(hex: "#db2424"))
              }

              }
            }

            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("Email")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                SpecTextField(specString("Your email"), text: Binding(get: { vm.email as? String ?? "" }, set: { newValue in vm.email = newValue; let v: Any = newValue; vm.email = v }))
                .textFieldStyle(.roundedBorder)
                .specAccessibilityLabel(specFieldName("", "Email"))
              }
              if (vm.hasEmailError) as? Bool ?? false {
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString(vm.emailError))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(Color(hex: "#db2424"))
              }

              }
            }

          }

          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Bio")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
            SpecTextEditor(text: Binding(get: { vm.bio as? String ?? "" }, set: { newValue in vm.bio = newValue; let v: Any = newValue; vm.bio = v }))
            .frame(minHeight: 88)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
            .specAccessibilityLabel(specFieldName("", "Bio"))
          }
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
            Image(systemName: specIconName(specString("globe")))
              .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-sm"))))
              .foregroundStyle(ThemeManager.shared.color("interactive"))
            Text(verbatim: specString("Localization"))
              .font(.title)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
          }

          LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Language")).font(.subheadline).foregroundStyle(.secondary)
              Menu {
                if specArr([["value": "en" as Any, "label": "English" as Any] as [String: Any], ["value": "es" as Any, "label": "Spanish" as Any] as [String: Any], ["value": "fr" as Any, "label": "French" as Any] as [String: Any], ["value": "de" as Any, "label": "German" as Any] as [String: Any], ["value": "ja" as Any, "label": "Japanese" as Any] as [String: Any]] as [Any]).contains { !specString(specGet($0, "sub")).isEmpty } {
                  ForEach(Array(specArr([["value": "en" as Any, "label": "English" as Any] as [String: Any], ["value": "es" as Any, "label": "Spanish" as Any] as [String: Any], ["value": "fr" as Any, "label": "French" as Any] as [String: Any], ["value": "de" as Any, "label": "German" as Any] as [String: Any], ["value": "ja" as Any, "label": "Japanese" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                    let optValue = specString(specGet(opt, "value"))
                    let optSub = specString(specGet(opt, "sub"))
                    Toggle(isOn: Binding(get: { specString(vm.language) == optValue }, set: { on in if on { Binding(get: { specString(vm.language) }, set: { newValue in vm.language = newValue; let v: Any = newValue; vm.language = v }).wrappedValue = optValue } })) {
                      Text(specString(specGet(opt, "label")))
                      if !optSub.isEmpty { Text(optSub) }
                    }
                  }
                } else {
                Picker(specString("Language"), selection: Binding(get: { specString(vm.language) }, set: { newValue in vm.language = newValue; let v: Any = newValue; vm.language = v })) {
                  ForEach(Array(specArr([["value": "en" as Any, "label": "English" as Any] as [String: Any], ["value": "es" as Any, "label": "Spanish" as Any] as [String: Any], ["value": "fr" as Any, "label": "French" as Any] as [String: Any], ["value": "de" as Any, "label": "German" as Any] as [String: Any], ["value": "ja" as Any, "label": "Japanese" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                    Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                  }
                }
                }
              } label: {
                HStack {
                  Text(verbatim: specSelectLabel([["value": "en" as Any, "label": "English" as Any] as [String: Any], ["value": "es" as Any, "label": "Spanish" as Any] as [String: Any], ["value": "fr" as Any, "label": "French" as Any] as [String: Any], ["value": "de" as Any, "label": "German" as Any] as [String: Any], ["value": "ja" as Any, "label": "Japanese" as Any] as [String: Any]] as [Any], specString(vm.language), "").text).foregroundStyle(specSelectLabel([["value": "en" as Any, "label": "English" as Any] as [String: Any], ["value": "es" as Any, "label": "Spanish" as Any] as [String: Any], ["value": "fr" as Any, "label": "French" as Any] as [String: Any], ["value": "de" as Any, "label": "German" as Any] as [String: Any], ["value": "ja" as Any, "label": "Japanese" as Any] as [String: Any]] as [Any], specString(vm.language), "").isPlaceholder ? .secondary : .primary)
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
                if specArr([["value": "utc" as Any, "label": "UTC" as Any] as [String: Any], ["value": "est" as Any, "label": "US Eastern" as Any] as [String: Any], ["value": "pst" as Any, "label": "US Pacific" as Any] as [String: Any], ["value": "cet" as Any, "label": "Central European" as Any] as [String: Any], ["value": "jst" as Any, "label": "Japan Standard" as Any] as [String: Any]] as [Any]).contains { !specString(specGet($0, "sub")).isEmpty } {
                  ForEach(Array(specArr([["value": "utc" as Any, "label": "UTC" as Any] as [String: Any], ["value": "est" as Any, "label": "US Eastern" as Any] as [String: Any], ["value": "pst" as Any, "label": "US Pacific" as Any] as [String: Any], ["value": "cet" as Any, "label": "Central European" as Any] as [String: Any], ["value": "jst" as Any, "label": "Japan Standard" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                    let optValue = specString(specGet(opt, "value"))
                    let optSub = specString(specGet(opt, "sub"))
                    Toggle(isOn: Binding(get: { specString(vm.timezone) == optValue }, set: { on in if on { Binding(get: { specString(vm.timezone) }, set: { newValue in vm.timezone = newValue; let v: Any = newValue; vm.timezone = v }).wrappedValue = optValue } })) {
                      Text(specString(specGet(opt, "label")))
                      if !optSub.isEmpty { Text(optSub) }
                    }
                  }
                } else {
                Picker(specString("Timezone"), selection: Binding(get: { specString(vm.timezone) }, set: { newValue in vm.timezone = newValue; let v: Any = newValue; vm.timezone = v })) {
                  ForEach(Array(specArr([["value": "utc" as Any, "label": "UTC" as Any] as [String: Any], ["value": "est" as Any, "label": "US Eastern" as Any] as [String: Any], ["value": "pst" as Any, "label": "US Pacific" as Any] as [String: Any], ["value": "cet" as Any, "label": "Central European" as Any] as [String: Any], ["value": "jst" as Any, "label": "Japan Standard" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                    Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                  }
                }
                }
              } label: {
                HStack {
                  Text(verbatim: specSelectLabel([["value": "utc" as Any, "label": "UTC" as Any] as [String: Any], ["value": "est" as Any, "label": "US Eastern" as Any] as [String: Any], ["value": "pst" as Any, "label": "US Pacific" as Any] as [String: Any], ["value": "cet" as Any, "label": "Central European" as Any] as [String: Any], ["value": "jst" as Any, "label": "Japan Standard" as Any] as [String: Any]] as [Any], specString(vm.timezone), "").text).foregroundStyle(specSelectLabel([["value": "utc" as Any, "label": "UTC" as Any] as [String: Any], ["value": "est" as Any, "label": "US Eastern" as Any] as [String: Any], ["value": "pst" as Any, "label": "US Pacific" as Any] as [String: Any], ["value": "cet" as Any, "label": "Central European" as Any] as [String: Any], ["value": "jst" as Any, "label": "Japan Standard" as Any] as [String: Any]] as [Any], specString(vm.timezone), "").isPlaceholder ? .secondary : .primary)
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
                if specArr([["value": "iso" as Any, "label": "YYYY-MM-DD" as Any] as [String: Any], ["value": "us" as Any, "label": "MM/DD/YYYY" as Any] as [String: Any], ["value": "eu" as Any, "label": "DD/MM/YYYY" as Any] as [String: Any]] as [Any]).contains { !specString(specGet($0, "sub")).isEmpty } {
                  ForEach(Array(specArr([["value": "iso" as Any, "label": "YYYY-MM-DD" as Any] as [String: Any], ["value": "us" as Any, "label": "MM/DD/YYYY" as Any] as [String: Any], ["value": "eu" as Any, "label": "DD/MM/YYYY" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                    let optValue = specString(specGet(opt, "value"))
                    let optSub = specString(specGet(opt, "sub"))
                    Toggle(isOn: Binding(get: { specString(vm.dateFormat) == optValue }, set: { on in if on { Binding(get: { specString(vm.dateFormat) }, set: { newValue in vm.dateFormat = newValue; let v: Any = newValue; vm.dateFormat = v }).wrappedValue = optValue } })) {
                      Text(specString(specGet(opt, "label")))
                      if !optSub.isEmpty { Text(optSub) }
                    }
                  }
                } else {
                Picker(specString("Date Format"), selection: Binding(get: { specString(vm.dateFormat) }, set: { newValue in vm.dateFormat = newValue; let v: Any = newValue; vm.dateFormat = v })) {
                  ForEach(Array(specArr([["value": "iso" as Any, "label": "YYYY-MM-DD" as Any] as [String: Any], ["value": "us" as Any, "label": "MM/DD/YYYY" as Any] as [String: Any], ["value": "eu" as Any, "label": "DD/MM/YYYY" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                    Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                  }
                }
                }
              } label: {
                HStack {
                  Text(verbatim: specSelectLabel([["value": "iso" as Any, "label": "YYYY-MM-DD" as Any] as [String: Any], ["value": "us" as Any, "label": "MM/DD/YYYY" as Any] as [String: Any], ["value": "eu" as Any, "label": "DD/MM/YYYY" as Any] as [String: Any]] as [Any], specString(vm.dateFormat), "").text).foregroundStyle(specSelectLabel([["value": "iso" as Any, "label": "YYYY-MM-DD" as Any] as [String: Any], ["value": "us" as Any, "label": "MM/DD/YYYY" as Any] as [String: Any], ["value": "eu" as Any, "label": "DD/MM/YYYY" as Any] as [String: Any]] as [Any], specString(vm.dateFormat), "").isPlaceholder ? .secondary : .primary)
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
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
            Image(systemName: specIconName(specString("bell")))
              .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-sm"))))
              .foregroundStyle(ThemeManager.shared.color("interactive"))
            Text(verbatim: specString("Notifications"))
              .font(.title)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
          }

          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            Toggle(specString("Email notifications"), isOn: Binding(get: { specTruthy(vm.emailNotifications) }, set: { newValue in let v: Any = newValue; vm.emailNotifications = v }))
            Toggle(specString("Push notifications"), isOn: Binding(get: { specTruthy(vm.pushNotifications) }, set: { newValue in let v: Any = newValue; vm.pushNotifications = v }))
            Toggle(specString("Weekly digest email"), isOn: Binding(get: { specTruthy(vm.weeklyDigest) }, set: { newValue in let v: Any = newValue; vm.weeklyDigest = v }))
          }

        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
            Image(systemName: specIconName(specString("monitor")))
              .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-sm"))))
              .foregroundStyle(ThemeManager.shared.color("interactive"))
            Text(verbatim: specString("Display"))
              .font(.title)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
          }

          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            Toggle(specString("Auto-save changes"), isOn: Binding(get: { specTruthy(vm.autoSave) }, set: { newValue in let v: Any = newValue; vm.autoSave = v }))
            Toggle(specString("Compact mode"), isOn: Binding(get: { specTruthy(vm.compactMode) }, set: { newValue in let v: Any = newValue; vm.compactMode = v }))
            Toggle(specString("Show avatars"), isOn: Binding(get: { specTruthy(vm.showAvatars) }, set: { newValue in let v: Any = newValue; vm.showAvatars = v }))
          }

          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Items per page")).font(.subheadline).foregroundStyle(.secondary)
            Menu {
              if specArr([["value": "10" as Any, "label": "10 per page" as Any] as [String: Any], ["value": "25" as Any, "label": "25 per page" as Any] as [String: Any], ["value": "50" as Any, "label": "50 per page" as Any] as [String: Any], ["value": "100" as Any, "label": "100 per page" as Any] as [String: Any]] as [Any]).contains { !specString(specGet($0, "sub")).isEmpty } {
                ForEach(Array(specArr([["value": "10" as Any, "label": "10 per page" as Any] as [String: Any], ["value": "25" as Any, "label": "25 per page" as Any] as [String: Any], ["value": "50" as Any, "label": "50 per page" as Any] as [String: Any], ["value": "100" as Any, "label": "100 per page" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                  let optValue = specString(specGet(opt, "value"))
                  let optSub = specString(specGet(opt, "sub"))
                  Toggle(isOn: Binding(get: { specString(vm.itemsPerPage) == optValue }, set: { on in if on { Binding(get: { specString(vm.itemsPerPage) }, set: { newValue in vm.itemsPerPage = newValue; let v: Any = newValue; vm.itemsPerPage = v }).wrappedValue = optValue } })) {
                    Text(specString(specGet(opt, "label")))
                    if !optSub.isEmpty { Text(optSub) }
                  }
                }
              } else {
              Picker(specString("Items per page"), selection: Binding(get: { specString(vm.itemsPerPage) }, set: { newValue in vm.itemsPerPage = newValue; let v: Any = newValue; vm.itemsPerPage = v })) {
                ForEach(Array(specArr([["value": "10" as Any, "label": "10 per page" as Any] as [String: Any], ["value": "25" as Any, "label": "25 per page" as Any] as [String: Any], ["value": "50" as Any, "label": "50 per page" as Any] as [String: Any], ["value": "100" as Any, "label": "100 per page" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                  Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                }
              }
              }
            } label: {
              HStack {
                Text(verbatim: specSelectLabel([["value": "10" as Any, "label": "10 per page" as Any] as [String: Any], ["value": "25" as Any, "label": "25 per page" as Any] as [String: Any], ["value": "50" as Any, "label": "50 per page" as Any] as [String: Any], ["value": "100" as Any, "label": "100 per page" as Any] as [String: Any]] as [Any], specString(vm.itemsPerPage), "").text).foregroundStyle(specSelectLabel([["value": "10" as Any, "label": "10 per page" as Any] as [String: Any], ["value": "25" as Any, "label": "25 per page" as Any] as [String: Any], ["value": "50" as Any, "label": "50 per page" as Any] as [String: Any], ["value": "100" as Any, "label": "100 per page" as Any] as [String: Any]] as [Any], specString(vm.itemsPerPage), "").isPlaceholder ? .secondary : .primary)
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
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Button(action: { specClick { Task { @MainActor in await vm.saveSettings() } } }) {
          Text(specString("Save Settings"))
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: false)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
        }
        Button(action: {  }) {
          Text(specString("Reset"))
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: false)
            .font(.subheadline.weight(.medium))
            .foregroundStyle(ThemeManager.shared.color("interactive"))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }
}
