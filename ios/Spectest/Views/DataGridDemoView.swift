import SwiftUI
import SpecRuntime

@Observable
final class DataGridDemoViewModel {
  var selectedProduct: Any? = nil
  var drawerOpen: Any = false
  var page: Any = 1
  var pageSize: Any = 10
  var productList: Any { (products != nil ? products : [] as [Any]) }
  var pagedProducts: Any { specSlice(productList, ((((page as? Double ?? 0) - (1 as? Double ?? 0)) as? Double ?? 0) * (pageSize as? Double ?? 0)), ((page as? Double ?? 0) * (pageSize as? Double ?? 0))) }
  var productCount: Any { "\(specString(specLength(productList))) products" }
  var hasSelection: Any { selectedProduct != nil }
  var selectedName: Any { (selectedProduct != nil ? (selectedProduct as? [String: Any])?["name"] : "") }
  var selectedCategory: Any { (selectedProduct != nil ? (selectedProduct as? [String: Any])?["category"] : "") }
  var selectedPrice: Any { (selectedProduct != nil ? specAdd("$", (selectedProduct as? [String: Any])?["price"]) : "") }
  var selectedStock: Any { (selectedProduct != nil ? (selectedProduct as? [String: Any])?["stock"] : 0) }
  var selectedRating: Any { (selectedProduct != nil ? specAdd((selectedProduct as? [String: Any])?["rating"], " / 5") : "") }
  var selectedSku: Any { (selectedProduct != nil ? (selectedProduct as? [String: Any])?["sku"] : "") }
  var selectedStatus: Any { (selectedProduct != nil ? (selectedProduct as? [String: Any])?["status"] : "") }
  var stockWarning: Any { (selectedProduct != nil ? (((selectedProduct as? [String: Any])?["stock"] as? Double ?? 0) < (10 as? Double ?? 0)) : false) }
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
            .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
          Text(specString("Product Catalog"))
            .font(.title2.bold())
            .foregroundStyle(.primary)
          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)

        Text(specString(vm.productCount))
          .font(.callout.bold())
          .foregroundStyle(.secondary)
      }
      .padding(CGFloat(20))
      .background(LinearGradient(colors: [Color(hex: "#1677ff15"), Color(hex: "#1677ff05")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: CGFloat(8)))
      VStack(spacing: CGFloat(12)) {
        if vm.productsLoading as? Bool ?? false {
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
        if vm.productsError as? Bool ?? false {
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
        if !(vm.productsLoading as? Bool ?? false) {
          DataGridView(columns: [["key": "id" as Any, "label": "ID" as Any, "width": "60px" as Any, "sortable": true as Any] as [String: Any], ["key": "name" as Any, "label": "Product Name" as Any, "sortable": true as Any, "filterable": true as Any] as [String: Any], ["key": "category" as Any, "label": "Category" as Any, "sortable": true as Any, "filterable": true as Any] as [String: Any], ["key": "price" as Any, "label": "Price" as Any, "sortable": true as Any, "format": "currency" as Any] as [String: Any], ["key": "stock" as Any, "label": "Stock" as Any, "sortable": true as Any] as [String: Any], ["key": "status" as Any, "label": "Status" as Any, "sortable": true as Any, "filterable": true as Any] as [String: Any], ["key": "rating" as Any, "label": "Rating" as Any, "sortable": true as Any] as [String: Any], ["key": "sku" as Any, "label": "SKU" as Any] as [String: Any]] as [Any], rows: vm.pagedProducts, selection: "single")
        }
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(8)))
      HStack(alignment: .center, ) {
        if !(vm.productsLoading as? Bool ?? false) {
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
            Text(specString(vm.selectedName))
              .font(.title2.bold())
              .foregroundStyle(.primary)
            VStack() {
              if vm.stockWarning as? Bool ?? false {
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
                  Text(specString("Category"))
                    .font(.body.bold())
                    .foregroundStyle(.secondary)
                  Text(specString(vm.selectedCategory))
                    .font(.body.bold())
                    .foregroundStyle(.primary)
                }
                .padding(CGFloat(12))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
              VStack(alignment: .leading) {
                VStack(spacing: CGFloat(4)) {
                  Text(specString("Price"))
                    .font(.body.bold())
                    .foregroundStyle(.secondary)
                  Text(specString(vm.selectedPrice))
                    .font(.title3.bold())
                    .foregroundStyle(Color.blue)
                }
                .padding(CGFloat(12))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
              VStack(alignment: .leading) {
                VStack(spacing: CGFloat(4)) {
                  Text(specString("Stock"))
                    .font(.body.bold())
                    .foregroundStyle(.secondary)
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
                  Text(specString("Rating"))
                    .font(.body.bold())
                    .foregroundStyle(.secondary)
                  Text(specString(vm.selectedRating))
                    .font(.body.bold())
                    .foregroundStyle(.primary)
                }
                .padding(CGFloat(12))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }

            HStack(alignment: .center, spacing: CGFloat(16)) {
              VStack(spacing: CGFloat(4)) {
                Text(specString("SKU"))
                  .font(.body.bold())
                  .foregroundStyle(.secondary)
                Text(specString(vm.selectedSku))
                  .font(.body.bold())
                  .foregroundStyle(.primary)
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
            .background(Color(.systemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(8)))
            HStack(alignment: .center, spacing: CGFloat(12)) {
              Button(action: { Task { await vm.closeDrawer() } }) {
                Text(specString("Edit Product"))
                  .font(.subheadline.weight(.semibold))
                  .foregroundStyle(.white)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(.blue, in: RoundedRectangle(cornerRadius: 8))
              }
              Button(action: { Task { await vm.closeDrawer() } }) {
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
    .foregroundStyle(.primary)
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
