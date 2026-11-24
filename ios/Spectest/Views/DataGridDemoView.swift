import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class DataGridDemoViewModel {
  var selectedProduct: Any? = Optional<Any>.none as Any
  var drawerOpen: Any = false
  var page: Any = 1
  var pageSize: Any = 10
  var productList: Any { (!specIsNil(products) ? products : [] as [Any]) }
  var pagedProducts: Any { specSlice(productList, (specDouble((specDouble(page) - specDouble(1))) * specDouble(pageSize)), (specDouble(page) * specDouble(pageSize))) }
  var productCount: Any { "\(specString(specLength(productList))) products" }
  var hasSelection: Any { !specIsNil(selectedProduct) }
  var selectedName: Any { (!specIsNil(selectedProduct) ? specGet(selectedProduct, "name") : "") }
  var selectedCategory: Any { (!specIsNil(selectedProduct) ? specGet(selectedProduct, "category") : "") }
  var selectedPrice: Any { (!specIsNil(selectedProduct) ? specAdd("$", specGet(selectedProduct, "price")) : "") }
  var selectedStock: Any { (!specIsNil(selectedProduct) ? specGet(selectedProduct, "stock") : 0) }
  var selectedRating: Any { (!specIsNil(selectedProduct) ? specAdd(specGet(selectedProduct, "rating"), " / 5") : "") }
  var selectedSku: Any { (!specIsNil(selectedProduct) ? specGet(selectedProduct, "sku") : "") }
  var selectedStatus: Any { (!specIsNil(selectedProduct) ? specGet(selectedProduct, "status") : "") }
  var stockWarning: Any { (!specIsNil(selectedProduct) ? specLt(specGet(selectedProduct, "stock"), 10) : false) }
  let productsSource = DataSource(endpoint: "http://localhost:4500/api/products", method: "GET")
  var products: Any? { productsSource.data }
  var productsLoading: Bool { productsSource.loading }
  var productsError: String? { productsSource.error }
  var productsErrorBody: Any? { productsSource.errorBody }
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
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
  func loadSources() async {
    await productsSource.fetch()
  }
}

struct DataGridDemoView: View {
  @State private var vm = DataGridDemoViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = DataGridDemoViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Image(systemName: specIconName(specString("layout")))
            .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-lg"))))
            .foregroundStyle(ThemeManager.shared.color("interactive"))
          Text(verbatim: specString("Product Catalog"))
            .font(.largeTitle)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
        }

        Text(verbatim: specString(vm.productCount))
          .font(.footnote)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      }
      .padding(.bottom, specBorderWidth(ThemeManager.shared.rawToken("borders-section-accent")))
      .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(ThemeManager.shared.color("gradient-header-accent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .specBorderSides(nil, top: nil, right: nil, bottom: ThemeManager.shared.rawToken("borders-section-accent"), left: nil, radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      if (vm.productsLoading) as? Bool ?? false {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
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

      }
      if (vm.productsError) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
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

      }
      if ((!((vm.productsLoading) as? Bool ?? false))) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
        if ((!((vm.productsLoading) as? Bool ?? false))) as? Bool ?? false {
          _specArm0
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      .hoverEffect(.highlight)
      }
      if ((!((vm.productsLoading) as? Bool ?? false))) as? Bool ?? false {
      HStack(alignment: .center, spacing: 0) {
        Spacer(minLength: 0)
        if ((!((vm.productsLoading) as? Bool ?? false))) as? Bool ?? false {
          HStack(spacing: 8) {
            Button(action: { let specCur = specPageClamp(vm.page, specPageCount(specLength(vm.productList), vm.pageSize)); if specCur > 1 { let specNewPage = specCur - 1; let p: Any = specNewPage; vm.setPage(p) } }) {
              Image(systemName: "chevron.left")
            }
            .disabled(specPageClamp(vm.page, specPageCount(specLength(vm.productList), vm.pageSize)) <= 1)
            Text("\(specPageClamp(vm.page, specPageCount(specLength(vm.productList), vm.pageSize))) / \(specPageCount(specLength(vm.productList), vm.pageSize))")
              .font(.subheadline).monospacedDigit()
            Button(action: { let specCur = specPageClamp(vm.page, specPageCount(specLength(vm.productList), vm.pageSize)); if specCur < specPageCount(specLength(vm.productList), vm.pageSize) { let specNewPage = specCur + 1; let p: Any = specNewPage; vm.setPage(p) } }) {
              Image(systemName: "chevron.right")
            }
            .disabled(specPageClamp(vm.page, specPageCount(specLength(vm.productList), vm.pageSize)) >= specPageCount(specLength(vm.productList), vm.pageSize))
          }
        }
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)
      .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
      }
      Color.clear.frame(width: 0, height: 0).sheet(isPresented: Binding(get: { vm.drawerOpen as? Bool ?? false }, set: { shown in vm.drawerOpen = shown; if !shown { vm.closeDrawer() } })) {
        VStack {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
            Text(verbatim: specString(vm.selectedName))
              .font(.largeTitle)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            if (vm.stockWarning) as? Bool ?? false {
            VStack(alignment: .leading, spacing: 0) {
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

            }
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                  Text(verbatim: specString("Category"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                    .textCase(.uppercase)
                  Text(verbatim: specString(vm.selectedCategory))
                    .font(.body.weight(.semibold))
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                }
                .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
              VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                  Text(verbatim: specString("Price"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                    .textCase(.uppercase)
                  Text(verbatim: specString(vm.selectedPrice))
                    .font(.title)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("interactive"))
                }
                .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
              VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                  Text(verbatim: specString("Stock"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                    .textCase(.uppercase)
                  VStack(alignment: .center, spacing: 2) {
                    Text(specString("units")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
                    Text(specString("\(specString(vm.selectedStock))")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
                    if specString("") != "" {
                      let _tc: Color = specString("") == "up" ? Color(hex: "#22c55e") : (specString("") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
                      HStack(spacing: 4) {
                        Text(specString("") == "up" ? "↑" : (specString("") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
                        if specString("") != "" { Text(specString("")).font(.footnote).foregroundStyle(_tc) }
                      }
                    }
                    if specString("") != "" {
                      Text(specString("")).font(.footnote).foregroundStyle(ThemeManager.shared.color("text-tertiary")).multilineTextAlignment(.center)
                    }
                  }
                  .frame(maxWidth: .infinity)
                }
                .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
              VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                  Text(verbatim: specString("Rating"))
                    .font(.footnote)
                    .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                    .textCase(.uppercase)
                  Text(verbatim: specString(vm.selectedRating))
                    .font(.body.weight(.semibold))
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                }
                .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              }
              .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }

            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                Text(verbatim: specString("SKU"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Text(verbatim: specString(vm.selectedSku))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-mono-md-fontWeight")))
                  .monospacedDigit()
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }

              Text(specString(vm.selectedStatus))
                .font(.caption.weight(.medium))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .foregroundStyle(specBadgeForeground(specString("neutral")))
                .background(specBadgeBackground(specString("neutral")), in: Capsule())
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
            .frame(maxWidth: .infinity, alignment: .center)
            .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              Button(action: { specClick { Task { @MainActor in await vm.closeDrawer() } } }) {
                Text(specString("Edit Product"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.semibold))
                  .foregroundStyle(.white)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
              }
              Button(action: { specClick { Task { @MainActor in await vm.closeDrawer() } } }) {
                Text(specString("Close"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
            }

          }
          .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
        }
        .presentationDetents([.medium, .large])
      }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .onAppear { vm.onDispatch = onDispatch }
  }

  private var _specArm0: AnyView {
    AnyView(Group {
          Group {
            let _rows = SpecRow.wrap(vm.pagedProducts, idField: specString("id"))
            if UIDevice.current.userInterfaceIdiom == .pad {
              Table(_rows, selection: Binding<SpecRow.ID?>(get: { nil }, set: { specId in
                guard let specId, let specRow = _rows.first(where: { $0.id == specId }) else { return }
                specClick { let row: Any = specRow.data as Any; vm.selectProduct(row) }
              })) {
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
                  ForEach(_rows) { specRow in
                    HStack(spacing: 0) {
                      Text(verbatim: specString(specRow["id"]))
                        .font(.subheadline)
                        .frame(width: 60, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                      Text(verbatim: specString(specRow["name"]))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                      Text(verbatim: specString(specRow["category"]))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                      Text(verbatim: specString(specRow["price"]))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                      Text(verbatim: specString(specRow["stock"]))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                      Text(verbatim: specString(specRow["status"]))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                      Text(verbatim: specString(specRow["rating"]))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                      Text(verbatim: specString(specRow["sku"]))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8).padding(.horizontal, 6)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture { specClick { let row: Any = specRow.data as Any; vm.selectProduct(row) } }
                    Divider()
                  }
                }
              }
            }
          }
          .background(Color(.systemBackground))
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator).opacity(0.3)))
    })
  }
}
