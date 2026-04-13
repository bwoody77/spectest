import SwiftUI
import SpecRuntime

@Observable
final class TreeDemoViewModel {
  var selectedNode: Any? = nil
  var searchQuery: Any = ""
  var categoryList: Any { (categories != nil ? categories : [] as [Any]) }
  var hasSelection: Any { selectedNode != nil }
  var selectedLabel: Any { (selectedNode != nil ? specGet(selectedNode, "label") : "No selection") }
  var selectedId: Any { (selectedNode != nil ? specGet(selectedNode, "id") : "") }
  var treeMinHeight: Any { "400px" }
  var treeCols: Any { "280px 1fr" }
  let categoriesSource = DataSource(endpoint: "http://localhost:4000/api/categories", method: "GET")
  var categories: Any? { categoriesSource.data }
  var categoriesLoading: Bool { categoriesSource.loading }
  var categoriesError: String? { categoriesSource.error }
  func selectNode(_ node: Any) {
    selectedNode = node
  }
  func setSearch(_ v: Any) {
    searchQuery = v
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
  func loadSources() async {
    await categoriesSource.fetch()
  }
}

struct TreeDemoView: View {
  @State private var vm = TreeDemoViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      HStack(alignment: .center, spacing: CGFloat(12)) {
        Image(systemName: specIconName(specString("list")))
          .font(.system(size: specPx("24px")))
          .foregroundStyle(Color(hex: "#1677ff" as? String ?? "transparent"))
        Text(verbatim: specString("Category Browser"))
          .font(.title2.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)
      .padding(CGFloat(20))
      .background(LinearGradient(colors: [Color(hex: "#1677ff15"), Color(hex: "#1677ff05")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      VStack(spacing: CGFloat(8)) {
        if (vm.categoriesLoading) as? Bool ?? false {
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("32px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("24px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("24px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("24px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("32px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("24px"))
            .overlay(ProgressView())
        }
      }

      VStack() {
        if (vm.categoriesError) as? Bool ?? false {
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: specAlertIcon(specString("error")))
              .foregroundStyle(specAlertColor(specString("error")))
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Failed to load categories")).font(.subheadline.weight(.semibold))
              Text(specString("Could not load the category tree.")).font(.subheadline)
            }
            Spacer(minLength: 0)
          }
          .padding(12)
          .background(specAlertColor(specString("error")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
      }

      HStack(alignment: .center, spacing: CGFloat(20)) {
        if ((!((vm.categoriesLoading) as? Bool ?? false))) as? Bool ?? false {
          ScrollView(.horizontal, showsIndicators: true) {
          VStack(spacing: CGFloat(12)) {
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Filter categories")).font(.subheadline).foregroundStyle(.secondary)
              TextField(specString("Search..."), text: Binding(get: { vm.searchQuery as? String ?? "" }, set: { vm.searchQuery = $0 }))
              .textFieldStyle(.roundedBorder)
              .textContentType(.none)
              .autocorrectionDisabled()
            }
            TreeView(expanded: [] as [Any], nodes: vm.categoryList, selection: "single")
          }
          }
          .padding(CGFloat(12))
          .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }
        VStack(spacing: CGFloat(16)) {
          VStack() {
            if ((!((vm.hasSelection) as? Bool ?? false))) as? Bool ?? false {
              ContentUnavailableView(specString("No Category Selected"), systemImage: "tray", description: Text(specString("Select a category from the tree to view its details.")))
                .frame(height: 200)
            }
          }

          VStack(spacing: CGFloat(16)) {
            if (vm.hasSelection) as? Bool ?? false {
              Text(verbatim: specString(vm.selectedLabel))
                .font(.title2.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            }
            VStack(spacing: CGFloat(12)) {
              HStack(alignment: .center, spacing: CGFloat(8)) {
                Text(verbatim: specString("ID:"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                Text(verbatim: specString(vm.selectedId))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              }

              HStack(alignment: .center, spacing: CGFloat(8)) {
                Text(verbatim: specString("Name:"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                Text(verbatim: specString(vm.selectedLabel))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              }

            }
            .padding(CGFloat(16))
            .background(ThemeManager.shared.color("semantic.surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            HStack(alignment: .center, spacing: CGFloat(12)) {
              Button(action: {  }) {
                Text(specString("Add Subcategory"))
                  .font(.subheadline.weight(.semibold))
                  .foregroundStyle(.white)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(.blue, in: RoundedRectangle(cornerRadius: 8))
              }
              Button(action: {  }) {
                Text(specString("Edit Category"))
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(.blue)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
              Button(action: {  }) {
                Text(specString("Delete"))
                  .font(.subheadline.weight(.semibold))
                  .foregroundStyle(specString("destructive") == "primary" ? .white : .blue)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(specString("destructive") == "primary" ? AnyShapeStyle(.blue) : AnyShapeStyle(Color(.tertiarySystemFill)), in: RoundedRectangle(cornerRadius: 8))
              }
            }

          }

        }
        .padding(CGFloat(20))
        .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      }
      .frame(minHeight: specPx(vm.treeMinHeight))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
