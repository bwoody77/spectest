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
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
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
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func loadSources() async {
    await categoriesSource.fetch()
  }
}

struct TreeDemoView: View {
  @State private var vm = TreeDemoViewModel()
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-5")) {
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        Image(systemName: specIconName(specString("list")))
          .font(.system(size: specPx(ThemeManager.shared.resolve("icon-lg"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Category Browser"))
          .font(.title2.bold())
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)
      .padding(ThemeManager.shared.size("spacing-5"))
      .background(ThemeManager.shared.color("gradient-header-accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      VStack(spacing: ThemeManager.shared.size("spacing-2")) {
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

      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-5")) {
        if ((!((vm.categoriesLoading) as? Bool ?? false))) as? Bool ?? false {
          ScrollView(.horizontal, showsIndicators: true) {
          VStack(spacing: ThemeManager.shared.size("spacing-3")) {
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
          .padding(ThemeManager.shared.size("spacing-3"))
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
        }
        VStack(spacing: ThemeManager.shared.size("spacing-4")) {
          VStack() {
            if ((!((vm.hasSelection) as? Bool ?? false))) as? Bool ?? false {
              ContentUnavailableView(specString("No Category Selected"), systemImage: "tray", description: Text(specString("Select a category from the tree to view its details.")))
                .frame(height: 200)
            }
          }

          VStack(spacing: ThemeManager.shared.size("spacing-4")) {
            if (vm.hasSelection) as? Bool ?? false {
              Text(verbatim: specString(vm.selectedLabel))
                .font(.title2.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
            }
            VStack(spacing: ThemeManager.shared.size("spacing-3")) {
              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                Text(verbatim: specString("ID:"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Text(verbatim: specString(vm.selectedId))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }

              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                Text(verbatim: specString("Name:"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Text(verbatim: specString(vm.selectedLabel))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }

            }
            .padding(ThemeManager.shared.size("spacing-4"))
            .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
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
        .padding(ThemeManager.shared.size("spacing-5"))
        .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      }
      .frame(minHeight: specPx(vm.treeMinHeight))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
