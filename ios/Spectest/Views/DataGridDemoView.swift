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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
  func loadSources() async {
    await productsSource.fetch()
  }
}

struct DataGridDemoView: View {
  @State private var vm = DataGridDemoViewModel()
  var body: some View {
    VStack(spacing: CGFloat(20)) {
      VStack(spacing: CGFloat(12)) {
        HStack(alignment: .center, spacing: CGFloat(12)) {
          Image(systemName: specIconName(specString("layout")))
            .font(.system(size: specPx("24px")))
            .foregroundStyle(Color(hex: "#1677ff" as? String ?? "transparent"))
          Text(verbatim: specString("Product Catalog"))
            .font(.title2.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)

        Text(verbatim: specString(vm.productCount))
          .font(.callout.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
      }
      .padding(CGFloat(20))
      .background(LinearGradient(colors: [Color(hex: "#1677ff15"), Color(hex: "#1677ff05")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      VStack(spacing: CGFloat(12)) {
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
      .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      HStack(alignment: .center, ) {
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
      .padding(CGFloat(12))
      EmptyView().sheet(isPresented: Binding(get: { vm.drawerOpen as? Bool ?? false }, set: { vm.drawerOpen = $0 })) {
        VStack {
          VStack(spacing: CGFloat(16)) {
            Text(verbatim: specString(vm.selectedName))
              .font(.title2.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
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

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: CGFloat(12)) {
              VStack(alignment: .leading) {
                VStack(spacing: CGFloat(4)) {
                  Text(verbatim: specString("Category"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  Text(verbatim: specString(vm.selectedCategory))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }
                .padding(CGFloat(12))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
              VStack(alignment: .leading) {
                VStack(spacing: CGFloat(4)) {
                  Text(verbatim: specString("Price"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  Text(verbatim: specString(vm.selectedPrice))
                    .font(.title3.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
                }
                .padding(CGFloat(12))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
              VStack(alignment: .leading) {
                VStack(spacing: CGFloat(4)) {
                  Text(verbatim: specString("Stock"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  VStack(alignment: .leading, spacing: 4) {
                    Text(specString("\(specString(vm.selectedStock))")).font(.system(size: 32, weight: .bold, design: .rounded))
                    Text(specString("units")).font(.subheadline).foregroundStyle(.secondary)
                  }
                }
                .padding(CGFloat(12))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
              VStack(alignment: .leading) {
                VStack(spacing: CGFloat(4)) {
                  Text(verbatim: specString("Rating"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                  Text(verbatim: specString(vm.selectedRating))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }
                .padding(CGFloat(12))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }

            HStack(alignment: .center, spacing: CGFloat(16)) {
              VStack(spacing: CGFloat(4)) {
                Text(verbatim: specString("SKU"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                Text(verbatim: specString(vm.selectedSku))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
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
            .padding(CGFloat(12))
            .background(ThemeManager.shared.color("semantic.surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            HStack(alignment: .center, spacing: CGFloat(12)) {
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
          .padding(CGFloat(16))
        }
        .presentationDetents([.medium, .large])
      }
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
