import SwiftUI
import SpecRuntime

@Observable
final class DataGridDemoViewModel {
  var selectedProduct: Any? = nil
  var drawerOpen: Any = false
  var page: Any = 1
  var pageSize: Any = 10
  var productList: Any { (products != nil ? products : [] as [Any]) }
  var pagedProducts: Any { specSlice(productList, (specDouble((specDouble(page) - specDouble(1))) * specDouble(pageSize)), (specDouble(page) * specDouble(pageSize))) }
  var productCount: Any { "\(specString(specLength(productList))) products" }
  var hasSelection: Any { selectedProduct != nil }
  var selectedName: Any { (selectedProduct != nil ? specGet(selectedProduct, "name") : "") }
  var selectedCategory: Any { (selectedProduct != nil ? specGet(selectedProduct, "category") : "") }
  var selectedPrice: Any { (selectedProduct != nil ? specAdd("$", specGet(selectedProduct, "price")) : "") }
  var selectedStock: Any { (selectedProduct != nil ? specGet(selectedProduct, "stock") : 0) }
  var selectedRating: Any { (selectedProduct != nil ? specAdd(specGet(selectedProduct, "rating"), " / 5") : "") }
  var selectedSku: Any { (selectedProduct != nil ? specGet(selectedProduct, "sku") : "") }
  var selectedStatus: Any { (selectedProduct != nil ? specGet(selectedProduct, "status") : "") }
  var stockWarning: Any { (selectedProduct != nil ? (specDouble(specGet(selectedProduct, "stock")) < specDouble(10)) : false) }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  let productsSource = DataSource(endpoint: "http://localhost:4000/api/products", method: "GET")
  var products: Any? { productsSource.data }
  var productsLoading: Bool { productsSource.loading }
  var productsError: String? { productsSource.error }
  func selectProduct(_ p: Any) {
    selectedProduct = p
    drawerOpen = true
  }
  func closeDrawer() {
    drawerOpen = false
  }
  func setPage(_ p: Any) {
    page = p
  }
  func setPageSize(_ s: Any) {
    pageSize = s
    page = 1
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func loadSources() async {
    await productsSource.fetch()
  }
}

struct DataGridDemoView: View {
  @State private var vm = DataGridDemoViewModel()
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-5")) {
      VStack(spacing: ThemeManager.shared.size("spacing-3")) {
        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
          Image(systemName: specIconName(specString("layout")))
            .font(.system(size: specPx(ThemeManager.shared.resolve("icon-lg"))))
            .foregroundStyle(ThemeManager.shared.color("interactive"))
          Text(verbatim: specString("Product Catalog"))
            .font(.title2.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)

        Text(verbatim: specString(vm.productCount))
          .font(.callout.bold())
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      }
      .padding(ThemeManager.shared.size("spacing-5"))
      .background(ThemeManager.shared.color("gradient-header-accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      VStack(spacing: ThemeManager.shared.size("spacing-3")) {
        if (vm.productsLoading) as? Bool ?? false {
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("40px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("300px"))
            .overlay(ProgressView())
        }
      }

      VStack() {
        if (vm.productsError) as? Bool ?? false {
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: specAlertIcon(specString("error")))
              .foregroundStyle(specAlertColor(specString("error")))
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Failed to load products")).font(.subheadline.weight(.semibold))
              Text(specString("The product catalog could not be loaded.")).font(.subheadline)
            }
            Spacer(minLength: 0)
          }
          .padding(12)
          .background(specAlertColor(specString("error")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
      }

      VStack() {
        if ((!((vm.productsLoading) as? Bool ?? false))) as? Bool ?? false {
          Group {
            let _rows = SpecRow.wrap(vm.pagedProducts, idField: specString("id"))
            if UIDevice.current.userInterfaceIdiom == .pad {
              Table(_rows) {
                TableColumn("ID") { row in
                  Text(verbatim: specString(row["id"]))
                }
                .width(min: 40, ideal: 60, max: 120)
                TableColumn("Product Name") { row in
                  Text(verbatim: specString(row["name"]))
                }
                TableColumn("Category") { row in
                  Text(verbatim: specString(row["category"]))
                }
                TableColumn("Price") { row in
                  Text(verbatim: specString(row["price"]))
                    .monospacedDigit()
                }
                TableColumn("Stock") { row in
                  Text(verbatim: specString(row["stock"]))
                }
                TableColumn("Status") { row in
                  Text(verbatim: specString(row["status"]))
                }
                TableColumn("Rating") { row in
                  Text(verbatim: specString(row["rating"]))
                }
                TableColumn("SKU") { row in
                  Text(verbatim: specString(row["sku"]))
                }
              }
            } else {
              ScrollView(.horizontal, showsIndicators: true) {
                VStack(spacing: 0) {
                  HStack(spacing: 0) {
                    Text(verbatim: "ID")
                      .font(.caption.weight(.semibold))
                      .foregroundStyle(.secondary)
                      .frame(width: 60, alignment: .leading)
                      .padding(.vertical, 8).padding(.horizontal, 6)
                    Text(verbatim: "Product Name")
                      .font(.caption.weight(.semibold))
                      .foregroundStyle(.secondary)
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .padding(.vertical, 8).padding(.horizontal, 6)
                    Text(verbatim: "Category")
                      .font(.caption.weight(.semibold))
                      .foregroundStyle(.secondary)
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .padding(.vertical, 8).padding(.horizontal, 6)
                    Text(verbatim: "Price")
                      .font(.caption.weight(.semibold))
                      .foregroundStyle(.secondary)
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .padding(.vertical, 8).padding(.horizontal, 6)
                    Text(verbatim: "Stock")
                      .font(.caption.weight(.semibold))
                      .foregroundStyle(.secondary)
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .padding(.vertical, 8).padding(.horizontal, 6)
                    Text(verbatim: "Status")
                      .font(.caption.weight(.semibold))
                      .foregroundStyle(.secondary)
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .padding(.vertical, 8).padding(.horizontal, 6)
                    Text(verbatim: "Rating")
                      .font(.caption.weight(.semibold))
                      .foregroundStyle(.secondary)
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .padding(.vertical, 8).padding(.horizontal, 6)
                    Text(verbatim: "SKU")
                      .font(.caption.weight(.semibold))
                      .foregroundStyle(.secondary)
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .padding(.vertical, 8).padding(.horizontal, 6)
                  }
                  .background(Color(.tertiarySystemGroupedBackground))
                  Divider()
                  ForEach(_rows) { row in
                    HStack(spacing: 0) {
                      Text(verbatim: specString(row["id"]))
                        .font(.subheadline)
                        .frame(width: 60, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                      Text(verbatim: specString(row["name"]))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                      Text(verbatim: specString(row["category"]))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                      Text(verbatim: specString(row["price"]))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                      Text(verbatim: specString(row["stock"]))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                      Text(verbatim: specString(row["status"]))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                      Text(verbatim: specString(row["rating"]))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                      Text(verbatim: specString(row["sku"]))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                    }
                    .onTapGesture { vm.selectProduct(row.data as Any) }
                    Divider()
                  }
                }
              }
            }
          }
          .background(Color(.systemBackground))
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator).opacity(0.3)))
        }
      }
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      .hoverEffect(.highlight)
      HStack(alignment: .center) {
        if ((!((vm.productsLoading) as? Bool ?? false))) as? Bool ?? false {
          HStack(spacing: 8) {
            Button(action: { vm.page = (vm.page as? Int ?? 1) - 1 }) {
              Image(systemName: "chevron.left")
            }
            .disabled((vm.page as? Int ?? 1) <= 1)
            Text("\(specString(vm.page)) / \(specString(specLength(vm.productList)))")
              .font(.subheadline).monospacedDigit()
            Button(action: { vm.page = (vm.page as? Int ?? 1) + 1 }) {
              Image(systemName: "chevron.right")
            }
            .disabled((vm.page as? Int ?? 1) >= (specLength(vm.productList) as? Int ?? 1))
          }
        }
      }
      .padding(ThemeManager.shared.size("spacing-3"))
      EmptyView().sheet(isPresented: Binding(get: { vm.drawerOpen as? Bool ?? false }, set: { vm.drawerOpen = $0 })) {
        VStack {
          VStack(spacing: ThemeManager.shared.size("spacing-4")) {
            Text(verbatim: specString(vm.selectedName))
              .font(.title2.bold())
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            VStack() {
              if (vm.stockWarning) as? Bool ?? false {
                HStack(alignment: .top, spacing: 12) {
                  Image(systemName: specAlertIcon(specString("warning")))
                    .foregroundStyle(specAlertColor(specString("warning")))
                  VStack(alignment: .leading, spacing: 4) {
                    Text(specString("Low Stock")).font(.subheadline.weight(.semibold))
                    Text(specString("This product has fewer than 10 units remaining.")).font(.subheadline)
                  }
                  Spacer(minLength: 0)
                }
                .padding(12)
                .background(specAlertColor(specString("warning")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
              }
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: ThemeManager.shared.size("spacing-3")) {
              VStack(alignment: .leading) {
                VStack(spacing: ThemeManager.shared.size("spacing-1")) {
                  Text(verbatim: specString("Category"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  Text(verbatim: specString(vm.selectedCategory))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                }
                .padding(ThemeManager.shared.size("spacing-3"))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
              VStack(alignment: .leading) {
                VStack(spacing: ThemeManager.shared.size("spacing-1")) {
                  Text(verbatim: specString("Price"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  Text(verbatim: specString(vm.selectedPrice))
                    .font(.title3.bold())
                    .foregroundStyle(ThemeManager.shared.color("interactive"))
                }
                .padding(ThemeManager.shared.size("spacing-3"))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
              VStack(alignment: .leading) {
                VStack(spacing: ThemeManager.shared.size("spacing-1")) {
                  Text(verbatim: specString("Stock"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  VStack(alignment: .leading, spacing: 4) {
                    Text(specString("\(specString(vm.selectedStock))")).font(.system(size: 32, weight: .bold, design: .rounded))
                    Text(specString("units")).font(.subheadline).foregroundStyle(.secondary)
                  }
                }
                .padding(ThemeManager.shared.size("spacing-3"))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
              VStack(alignment: .leading) {
                VStack(spacing: ThemeManager.shared.size("spacing-1")) {
                  Text(verbatim: specString("Rating"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  Text(verbatim: specString(vm.selectedRating))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                }
                .padding(ThemeManager.shared.size("spacing-3"))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }

            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-4")) {
              VStack(spacing: ThemeManager.shared.size("spacing-1")) {
                Text(verbatim: specString("SKU"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Text(verbatim: specString(vm.selectedSku))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }

              Spacer(minLength: 0)
              Text(specString(vm.selectedStatus))
                .font(.caption.weight(.medium))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .foregroundStyle(specBadgeForeground(specString("neutral")))
                .background(specBadgeBackground(specString("neutral")), in: Capsule())
            }
            .frame(maxWidth: .infinity)
            .padding(ThemeManager.shared.size("spacing-3"))
            .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
              Button(action: { Task { @MainActor in await vm.closeDrawer() } }) {
                Text(specString("Edit Product"))
                  .font(.subheadline.weight(.semibold))
                  .foregroundStyle(.white)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(.blue, in: RoundedRectangle(cornerRadius: 8))
              }
              Button(action: { Task { @MainActor in await vm.closeDrawer() } }) {
                Text(specString("Close"))
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(.blue)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
            }

          }
          .padding(ThemeManager.shared.size("spacing-4"))
        }
        .presentationDetents([.medium, .large])
      }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
