import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class EditableGridDemoViewModel {
  var hasChanges: Any = false
  var saveProgress: Any = 0
  var saving: Any = false
  var saved: Any = false
  var lastSaveEvent: Any = ""
  var productList: Any { (!specIsNil(products) ? products : [] as [Any]) }
  var productCount: Any { "\(specString(specLength(productList))) products" }
  var canSave: Any { ((hasChanges) as? Bool ?? false && ((!((saving) as? Bool ?? false))) as? Bool ?? false) }
  var showSaved: Any { saved }
  let productsSource = DataSource(endpoint: "http://localhost:4500/api/products", method: "GET")
  var products: Any? { productsSource.data }
  var productsLoading: Bool { productsSource.loading }
  var productsError: String? { productsSource.error }
  var productsErrorBody: Any? { productsSource.errorBody }
  func markDirty() {
    hasChanges = true
  }
  func saveChanges() async {
    saving = true
    saveProgress = 50
    await __specFetch("http://localhost:4500/api/products/1", ["method": "PUT" as Any, "body": JSON.stringify([String: Any]()) as Any] as [String: Any])
    saveProgress = 100
    saving = false
    hasChanges = false
    saved = true
  }
  func dismissSaved() {
    saved = false
  }
  func onCellSave(_ rowId: Any, _ field: Any, _ value: Any) {
    lastSaveEvent = "Auto-saved: \(specString(field)) = \(specString(value)) (row \(specString(rowId)))"
    hasChanges = false
  }
  func onRowSave(_ rowId: Any, _ changes: Any) {
    lastSaveEvent = "Row \(specString(rowId)) saved"
    hasChanges = false
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
  func loadSources() async {
    await productsSource.fetch()
  }
}

struct EditableGridDemoView: View {
  @State private var vm = EditableGridDemoViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = EditableGridDemoViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            Image(systemName: specIconName(specString("edit")))
              .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-lg"))))
              .foregroundStyle(ThemeManager.shared.color("interactive"))
            Text(verbatim: specString("Editable Inventory"))
              .font(.largeTitle)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
          }

          Spacer(minLength: 0)
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            if (vm.saving) as? Bool ?? false {
            VStack(alignment: .leading, spacing: 0) {
              if (vm.saving) as? Bool ?? false {
                ProgressView(value: (vm.saveProgress as? Double ?? 0) / 100.0)
                  .tint(.accentColor)
              }
            }

            }
            Button(action: { specClick { Task { @MainActor in await vm.saveChanges() } } }) {
              Text(specString("Save All Changes"))
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
            }
            .disabled((!((vm.canSave) as? Bool ?? false)) as? Bool ?? false)
            .opacity(((!((vm.canSave) as? Bool ?? false)) as? Bool ?? false) ? 0.5 : 1)
          }

        }
        .frame(maxWidth: .infinity)

        if (vm.hasChanges) as? Bool ?? false {
        VStack(alignment: .leading, spacing: 0) {
          if (vm.hasChanges) as? Bool ?? false {
            HStack(alignment: .top, spacing: 12) {
              Image(systemName: specAlertIcon(specString("info")))
                .foregroundStyle(specAlertColor(specString("info")))
              VStack(alignment: .leading, spacing: 4) {
                Text(specString("Unsaved changes")).font(.subheadline.weight(.semibold))
                Text(specString("You have modified cells. Click Save to persist.")).font(.subheadline)
              }
              Spacer(minLength: 0)
            }
            .padding(12)
            .background(specAlertColor(specString("info")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
          }
        }

        }
      }
      .padding(.bottom, specBorderWidth(ThemeManager.shared.rawToken("borders-section-accent")))
      .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(ThemeManager.shared.color("gradient-header-accent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .specBorderSides(nil, top: nil, right: nil, bottom: ThemeManager.shared.rawToken("borders-section-accent"), left: nil, radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      if (vm.showSaved) as? Bool ?? false {
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        if (vm.showSaved) as? Bool ?? false {
          Image(systemName: specIconName(specString("check")))
            .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-md"))))
            .foregroundStyle(ThemeManager.shared.color("success"))
          Text(verbatim: specString("Changes saved successfully!"))
            .font(.body)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("success-text"))
          Button(action: { specClick { Task { @MainActor in await vm.dismissSaved() } } }) {
            Text(specString("Dismiss"))
              .lineLimit(1)
              .fixedSize(horizontal: true, vertical: false)
              .font(.subheadline.weight(.medium))
              .foregroundStyle(ThemeManager.shared.color("interactive"))
              .padding(.horizontal, 16)
              .padding(.vertical, 8)
          }
        }
      }
      .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-success")))
      .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
      .frame(maxWidth: .infinity, alignment: .center)
      .background(ThemeManager.shared.color("success-light"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .specBorderAll(ThemeManager.shared.rawToken("borders-success"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      }
      if (vm.productsLoading) as? Bool ?? false {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        if (vm.productsLoading) as? Bool ?? false {
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("40px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("400px"))
            .overlay(ProgressView())
        }
      }

      }
      if ((!((vm.productsLoading) as? Bool ?? false))) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
        if ((!((vm.productsLoading) as? Bool ?? false))) as? Bool ?? false {
          EditableGridView(activation: "click", columns: [["key": "id" as Any, "label": "ID" as Any, "width": "60px" as Any, "editable": false as Any] as [String: Any], ["key": "name" as Any, "label": "Product Name" as Any, "editable": true as Any, "type": "text" as Any, "required": true as Any] as [String: Any], ["key": "category" as Any, "label": "Category" as Any, "editable": true as Any, "type": "select" as Any, "options": ["Electronics", "Audio", "Furniture", "Accessories"] as [Any] as Any] as [String: Any], ["key": "price" as Any, "label": "Price" as Any, "editable": true as Any, "type": "number" as Any, "format": "currency" as Any] as [String: Any], ["key": "stock" as Any, "label": "Stock" as Any, "editable": true as Any, "type": "number" as Any, "min": 0 as Any] as [String: Any], ["key": "status" as Any, "label": "Status" as Any, "editable": true as Any, "type": "select" as Any, "options": ["active", "out-of-stock", "discontinued"] as [Any] as Any] as [String: Any], ["key": "rating" as Any, "label": "Rating" as Any, "editable": true as Any, "type": "number" as Any, "min": 0 as Any, "max": 5 as Any, "step": 0.1 as Any] as [String: Any], ["key": "sku" as Any, "label": "SKU" as Any, "editable": false as Any] as [String: Any]] as [Any], rows: vm.productList, saveMode: "batch", undoDepth: 50, onDispatch: { specEvent, specPayload in
            _ = specPayload
            switch specString(specEvent) {
            case "cellEdit":
              let specArgs = specArr(specPayload)
              let e: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
              vm.markDirty()
            case "cellSave":
              let specArgs = specArr(specPayload)
              let e: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
              vm.onCellSave(specGet(e, "rowId"), specGet(e, "field"), specGet(e, "value"))
            case "rowSave":
              let specArgs = specArr(specPayload)
              let e: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
              vm.onRowSave(specGet(e, "rowId"), specGet(e, "changes"))
            default: break
            }
          })
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      .hoverEffect(.highlight)
      }
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Text(verbatim: specString("Editing Instructions"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Image(systemName: specIconName(specString("edit")))
                .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-xs"))))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Text(verbatim: specString("Click any editable cell to start editing"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Image(systemName: specIconName(specString("arrow-right")))
                .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-xs"))))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Text(verbatim: specString("Use Tab/Arrow keys to navigate between cells"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Image(systemName: specIconName(specString("check")))
                .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-xs"))))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Text(verbatim: specString("Modified cells show a yellow indicator"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Image(systemName: specIconName(specString("arrow-left")))
                .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-xs"))))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Text(verbatim: specString("Ctrl+Z to undo, Ctrl+Y to redo"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Image(systemName: specIconName(specString("clipboard")))
                .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-xs"))))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Text(verbatim: specString("Ctrl+C to copy, Ctrl+V to paste, Ctrl+D to fill down"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

          }

        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .onAppear { vm.onDispatch = onDispatch }
  }
}
