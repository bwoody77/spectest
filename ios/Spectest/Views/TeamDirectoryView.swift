import SwiftUI
import SpecRuntime

@Observable
final class TeamDirectoryViewModel {
  var search: Any = ""
  var roleFilter: Any = "all"
  var userList: Any { (users != nil ? users : [] as [Any]) }
  var filteredUsers: Any { (specEq(roleFilter, "all") ? userList : specFilter(userList, { (u: Any) -> Bool in return specEq(specGet(u, "role"), roleFilter) })) }
  var searchResults: Any { (specEq(search, "") ? filteredUsers : specFilter(filteredUsers, { (u: Any) -> Bool in return specIncludes((specGet(u, "name") as? String ?? "").lowercased(), (search as? String ?? "").lowercased()) })) }
  var userCount: Any { "\(specString(specLength(searchResults))) members" }
  var hasNoUsers: Any { specEq(specLength(searchResults), 0) }
  let usersSource = DataSource(endpoint: "http://localhost:4000/api/users", method: "GET")
  var users: Any? { usersSource.data }
  var usersLoading: Bool { usersSource.loading }
  var usersError: String? { usersSource.error }
  func setSearch(_ v: Any) {
    search = v
  }
  func setRoleFilter(_ v: Any) {
    roleFilter = v
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func loadSources() async {
    await usersSource.fetch()
  }
}

struct TeamDirectoryView: View {
  @State private var vm = TeamDirectoryViewModel()
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-5")) {
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        Image(systemName: specIconName(specString("user")))
          .font(.system(size: specPx(ThemeManager.shared.resolve("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Team Directory"))
          .font(.title2.bold())
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)

      VStack(alignment: .leading) {
        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Search")).font(.subheadline).foregroundStyle(.secondary)
            TextField(specString("Search members..."), text: Binding(get: { vm.search as? String ?? "" }, set: { vm.search = $0 }))
            .textFieldStyle(.roundedBorder)
            .textContentType(.none)
            .autocorrectionDisabled()
          }
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Role")).font(.subheadline).foregroundStyle(.secondary)
            Menu {
              Picker(specString("Role"), selection: Binding(get: { specString(vm.roleFilter) }, set: { vm.roleFilter = $0 })) {
                ForEach(Array(specArr([["value": "all" as Any, "label": "All Roles" as Any] as [String: Any], ["value": "admin" as Any, "label": "Admin" as Any] as [String: Any], ["value": "dev" as Any, "label": "Developer" as Any] as [String: Any], ["value": "design" as Any, "label": "Designer" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _, opt in
                  Text(specString(specGet(opt, "label"))).tag(specString(specGet(opt, "value")))
                }
              }
            } label: {
              HStack {
                Text(verbatim: specString(vm.roleFilter)).foregroundStyle(.primary)
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
        .padding(ThemeManager.shared.size("spacing-4"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: ThemeManager.shared.size("spacing-4")) {
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

      VStack() {
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

      LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: ThemeManager.shared.size("spacing-4")) {
        ForEach(Array(specArr(vm.searchResults).enumerated()), id: \.offset) { idx, user in
          VStack(alignment: .leading) {
            VStack(spacing: ThemeManager.shared.size("spacing-4")) {
              UserAvatarView(bgColor: ThemeManager.shared.resolve("interactive"), name: specGet(user, "name"))
              VStack(spacing: ThemeManager.shared.size("spacing-1")) {
                Text(verbatim: specString(specGet(user, "name")))
                  .font(.body.bold())
                Text(specString(specGet(user, "role")))
                  .font(.caption.weight(.medium))
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .foregroundStyle(specBadgeForeground(specString("neutral")))
                  .background(specBadgeBackground(specString("neutral")), in: Capsule())
                Text(verbatim: specString(specGet(user, "email")))
                  .font(.callout.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }

              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                Button(action: {  }) {
                  Text(specString("Message"))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                }
                Button(action: {  }) {
                  Text(specString("Profile"))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
              }

            }
            .padding(ThemeManager.shared.size("spacing-5"))
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
            .hoverEffect(.highlight)
          }
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
      }

      VStack() {
        if (vm.hasNoUsers) as? Bool ?? false {
          ContentUnavailableView(specString("No Team Members Found"), systemImage: "tray", description: Text(specString("No team members match your search criteria.")))
            .frame(height: 200)
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
