import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class TeamDirectoryViewModel {
  var search: Any = ""
  var roleFilter: Any = "all"
  var userList: Any { (!specIsNil(users) ? users : [] as [Any]) }
  var filteredUsers: Any { (specEq(roleFilter, "all") ? userList : specFilter(userList, { (u: Any) -> Bool in return specEq(specGet(u, "role"), roleFilter) })) }
  var searchResults: Any { (specEq(search, "") ? filteredUsers : specFilter(filteredUsers, { (u: Any) -> Bool in return specIncludes(specToLowerCase(specGet(u, "name")), specToLowerCase(search)) })) }
  var userCount: Any { "\(specString(specLength(searchResults))) members" }
  var hasNoUsers: Any { specEq(specLength(searchResults), 0) }
  let usersSource = DataSource(endpoint: "http://localhost:4500/api/users", method: "GET")
  var users: Any? { usersSource.data }
  var usersLoading: Bool { usersSource.loading }
  var usersError: String? { usersSource.error }
  var usersErrorBody: Any? { usersSource.errorBody }
  func setSearch(_ v: Any) {
    search = v
  }
  func setRoleFilter(_ v: Any) {
    roleFilter = v
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
  func loadSources() async {
    await usersSource.fetch()
  }
}

struct TeamDirectoryView: View {
  @State private var vm = TeamDirectoryViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = TeamDirectoryViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Image(systemName: specIconName(specString("user")))
          .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Team Directory"))
          .font(.largeTitle)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
      }

      VStack(alignment: .leading) {
        HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Search")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
            SpecTextField(specString("Search members..."), text: Binding(get: { vm.search as? String ?? "" }, set: { newValue in vm.search = newValue; let v: Any = newValue; vm.search = v }))
            .textFieldStyle(.roundedBorder)
            .textContentType(.none)
            .autocorrectionDisabled()
            .specAccessibilityLabel(specFieldName("", "Search"))
          }
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Role")).font(.subheadline).foregroundStyle(.secondary)
            Menu {
              if specArr([["value": "all" as Any, "label": "All Roles" as Any] as [String: Any], ["value": "admin" as Any, "label": "Admin" as Any] as [String: Any], ["value": "dev" as Any, "label": "Developer" as Any] as [String: Any], ["value": "design" as Any, "label": "Designer" as Any] as [String: Any]] as [Any]).contains { !specString(specGet($0, "sub")).isEmpty } {
                ForEach(Array(specArr([["value": "all" as Any, "label": "All Roles" as Any] as [String: Any], ["value": "admin" as Any, "label": "Admin" as Any] as [String: Any], ["value": "dev" as Any, "label": "Developer" as Any] as [String: Any], ["value": "design" as Any, "label": "Designer" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                  let optValue = specString(specGet(opt, "value"))
                  let optSub = specString(specGet(opt, "sub"))
                  Toggle(isOn: Binding(get: { specString(vm.roleFilter) == optValue }, set: { on in if on { Binding(get: { specString(vm.roleFilter) }, set: { newValue in vm.roleFilter = newValue; let v: Any = newValue; vm.roleFilter = v }).wrappedValue = optValue } })) {
                    Text(specString(specGet(opt, "label")))
                    if !optSub.isEmpty { Text(optSub) }
                  }
                }
              } else {
              Picker(specString("Role"), selection: Binding(get: { specString(vm.roleFilter) }, set: { newValue in vm.roleFilter = newValue; let v: Any = newValue; vm.roleFilter = v })) {
                ForEach(Array(specArr([["value": "all" as Any, "label": "All Roles" as Any] as [String: Any], ["value": "admin" as Any, "label": "Admin" as Any] as [String: Any], ["value": "dev" as Any, "label": "Developer" as Any] as [String: Any], ["value": "design" as Any, "label": "Designer" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                  Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                }
              }
              }
            } label: {
              HStack {
                Text(verbatim: specSelectLabel([["value": "all" as Any, "label": "All Roles" as Any] as [String: Any], ["value": "admin" as Any, "label": "Admin" as Any] as [String: Any], ["value": "dev" as Any, "label": "Developer" as Any] as [String: Any], ["value": "design" as Any, "label": "Designer" as Any] as [String: Any]] as [Any], specString(vm.roleFilter), "").text).foregroundStyle(specSelectLabel([["value": "all" as Any, "label": "All Roles" as Any] as [String: Any], ["value": "admin" as Any, "label": "Admin" as Any] as [String: Any], ["value": "dev" as Any, "label": "Developer" as Any] as [String: Any], ["value": "design" as Any, "label": "Designer" as Any] as [String: Any]] as [Any], specString(vm.roleFilter), "").isPlaceholder ? .secondary : .primary)
                Spacer()
                Image(systemName: "chevron.up.chevron.down").foregroundStyle(.secondary).font(.caption)
              }
              .padding(.horizontal, 12).padding(.vertical, 8)
              .background(Color(.systemBackground))
              .clipShape(RoundedRectangle(cornerRadius: 8))
              .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
            }
          }
          Text(specString(vm.userCount))
            .font(.caption.weight(.medium))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .foregroundStyle(specBadgeForeground(specString("neutral")))
            .background(specBadgeBackground(specString("neutral")), in: Capsule())
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      if (vm.usersLoading) as? Bool ?? false {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
        if (vm.usersLoading) as? Bool ?? false {
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("180px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("180px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("180px"))
            .overlay(ProgressView())
        }
      }

      }
      if (vm.usersError) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
        if (vm.usersError) as? Bool ?? false {
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: specAlertIcon(specString("error")))
              .foregroundStyle(specAlertColor(specString("error")))
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Failed to load team directory")).font(.subheadline.weight(.semibold))
              Text(specString("Could not retrieve team member data.")).font(.subheadline)
            }
            Spacer(minLength: 0)
          }
          .padding(12)
          .background(specAlertColor(specString("error")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
      }

      }
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
        ForEach(Array(specArr(vm.searchResults).enumerated()), id: \.offset) { idx, user in
          VStack(alignment: .leading) {
            VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              UserAvatarView(bgColor: ThemeManager.shared.rawToken("interactive"), name: specGet(user, "name"))
              VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                Text(verbatim: specString(specGet(user, "name")))
                  .font(.body.weight(.semibold))
                Text(specString(specGet(user, "role")))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("neutral")))
                  .background(specBadgeBackground(specString("neutral")), in: Capsule())
                Text(verbatim: specString(specGet(user, "email")))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }

              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Button(action: {  }) {
                  Text(specString("Message"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(ThemeManager.shared.color("interactive"))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                }
                Button(action: {  }) {
                  Text(specString("Profile"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(ThemeManager.shared.color("interactive"))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
              }

            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
            .frame(maxWidth: .infinity, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-lg"))))
            .hoverEffect(.highlight)
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
      }

      if (vm.hasNoUsers) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
        if (vm.hasNoUsers) as? Bool ?? false {
          ContentUnavailableView(specString("No Team Members Found"), systemImage: "tray", description: Text(specString("No team members match your search criteria.")))
            .frame(height: 200)
        }
      }

      }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .onAppear { vm.onDispatch = onDispatch }
  }
}
