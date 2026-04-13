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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
  func loadSources() async {
    await usersSource.fetch()
  }
}

struct TeamDirectoryView: View {
  @State private var vm = TeamDirectoryViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      HStack(alignment: .center, spacing: CGFloat(12)) {
        Image(systemName: specIconName(specString("user")))
          .font(.system(size: specPx("20px")))
          .foregroundStyle(Color(hex: "#1677ff" as? String ?? "transparent"))
        Text(verbatim: specString("Team Directory"))
          .font(.title2.bold())
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)

      VStack(alignment: .leading) {
        HStack(alignment: .center, spacing: CGFloat(12)) {
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Search")).font(.subheadline).foregroundStyle(.secondary)
            TextField(specString("Search members..."), text: Binding(get: { vm.search as? String ?? "" }, set: { vm.search = $0 }))
            .textFieldStyle(.roundedBorder)
            .textContentType(.none)
            .autocorrectionDisabled()
          }
          Picker(specString("Role"), selection: Binding(get: { specString(vm.roleFilter) }, set: { vm.roleFilter = $0 })) {
            ForEach(Array(([["value": "all" as Any, "label": "All Roles" as Any] as [String: Any], ["value": "admin" as Any, "label": "Admin" as Any] as [String: Any], ["value": "dev" as Any, "label": "Developer" as Any] as [String: Any], ["value": "design" as Any, "label": "Designer" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _, opt in
              Text(specString((opt as? [String: Any])?["label"])).tag(specString((opt as? [String: Any])?["value"]))
            }
          }
          .pickerStyle(.menu)
          Text(specString(vm.userCount))
            .font(.caption.weight(.medium))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .foregroundStyle(specBadgeForeground(specString("neutral")))
            .background(specBadgeBackground(specString("neutral")), in: Capsule())
        }
        .padding(CGFloat(16))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: CGFloat(16)) {
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

      LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: CGFloat(16)) {
        ForEach(Array(specArr(vm.searchResults).enumerated()), id: \.offset) { idx, user in
          VStack(alignment: .leading) {
            VStack(spacing: CGFloat(16)) {
              UserAvatarView(bgColor: "#1677ff", name: specGet(user, "name"))
              VStack(spacing: CGFloat(4)) {
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
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }

              HStack(alignment: .center, spacing: CGFloat(8)) {
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
            .padding(CGFloat(20))
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
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
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
