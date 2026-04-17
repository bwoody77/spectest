import SwiftUI
import SpecRuntime

@Observable
final class EditableGridDemoViewModel {
  var hasChanges: Any = false
  var saveProgress: Any = 0
  var saving: Any = false
  var saved: Any = false
  var lastSaveEvent: Any = ""
  var productList: Any { (products != nil ? products : [] as [Any]) }
  var productCount: Any { "\(specString(specLength(productList))) products" }
  var canSave: Any { ((hasChanges) as? Bool ?? false && ((!((saving) as? Bool ?? false))) as? Bool ?? false) }
  var showSaved: Any { saved }
  let productsSource = DataSource(endpoint: "http://localhost:4000/api/products", method: "GET")
  var products: Any? { productsSource.data }
  var productsLoading: Bool { productsSource.loading }
  var productsError: String? { productsSource.error }
  func markDirty() {
    hasChanges = true
  }
  func saveChanges() async {
    saving = true
    saveProgress = 50
    await fetch("http://localhost:4000/api/products/1", ["method": "PUT" as Any, "body": JSON.stringify([String: Any]()) as Any] as [String: Any])
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
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func loadSources() async {
    await productsSource.fetch()
  }
}

struct EditableGridDemoView: View {
  @State private var vm = EditableGridDemoViewModel()
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-5")) {
      VStack(spacing: ThemeManager.shared.size("spacing-3")) {
        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
            Image(systemName: specIconName(specString("edit")))
              .font(.system(size: specPx(ThemeManager.shared.resolve("icon-lg"))))
              .foregroundStyle(ThemeManager.shared.color("interactive"))
            Text(verbatim: specString("Editable Inventory"))
              .font(.title2.bold())
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Spacer(minLength: 0)
          }
          .frame(maxWidth: .infinity)

          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
            VStack() {
              if (vm.saving) as? Bool ?? false {
                ProgressView(value: (vm.saveProgress as? Double ?? 0) / 100.0)
                  .tint(.accentColor)
              }
            }

            Spacer(minLength: 0)
            Button(action: { Task { @MainActor in await vm.saveChanges() } }) {
              Text(specString("Save All Changes"))
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.blue, in: RoundedRectangle(cornerRadius: 8))
            }
            .disabled((!((vm.canSave) as? Bool ?? false)) as? Bool ?? false)
          }
          .frame(maxWidth: .infinity)

        }

        VStack() {
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
      .padding(ThemeManager.shared.size("spacing-5"))
      .background(ThemeManager.shared.color("gradient-header-accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        if (vm.showSaved) as? Bool ?? false {
          Image(systemName: specIconName(specString("check")))
            .font(.system(size: specPx(ThemeManager.shared.resolve("icon-md"))))
            .foregroundStyle(ThemeManager.shared.color("success"))
          Text(verbatim: specString("Changes saved successfully!"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("success-text"))
          Button(action: { Task { @MainActor in await vm.dismissSaved() } }) {
            Text(specString("Dismiss"))
              .font(.subheadline.weight(.medium))
              .foregroundStyle(.blue)
              .padding(.horizontal, 16)
              .padding(.vertical, 8)
          }
        }
      }
      .padding(ThemeManager.shared.size("spacing-3"))
      .background(ThemeManager.shared.color("success-light"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      VStack(spacing: ThemeManager.shared.size("spacing-3")) {
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

      VStack() {
        if ((!((vm.productsLoading) as? Bool ?? false))) as? Bool ?? false {
          EditableGridSpecView(activation: "click", columns: [["key": "id" as Any, "label": "ID" as Any, "width": "60px" as Any, "editable": false as Any] as [String: Any], ["key": "name" as Any, "label": "Product Name" as Any, "editable": true as Any, "type": "text" as Any, "required": true as Any] as [String: Any], ["key": "category" as Any, "label": "Category" as Any, "editable": true as Any, "type": "select" as Any, "options": ["Electronics", "Audio", "Furniture", "Accessories"] as [Any] as Any] as [String: Any], ["key": "price" as Any, "label": "Price" as Any, "editable": true as Any, "type": "number" as Any, "format": "currency" as Any] as [String: Any], ["key": "stock" as Any, "label": "Stock" as Any, "editable": true as Any, "type": "number" as Any, "min": 0 as Any] as [String: Any], ["key": "status" as Any, "label": "Status" as Any, "editable": true as Any, "type": "select" as Any, "options": ["active", "out-of-stock", "discontinued"] as [Any] as Any] as [String: Any], ["key": "rating" as Any, "label": "Rating" as Any, "editable": true as Any, "type": "number" as Any, "min": 0 as Any, "max": 5 as Any, "step": 0.1 as Any] as [String: Any], ["key": "sku" as Any, "label": "SKU" as Any, "editable": false as Any] as [String: Any]] as [Any], rows: vm.productList, saveMode: "batch", undoDepth: 50)
        }
      }
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      .hoverEffect(.highlight)
      VStack(alignment: .leading) {
        VStack(spacing: ThemeManager.shared.size("spacing-3")) {
          Text(verbatim: specString("Editing Instructions"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          VStack(spacing: ThemeManager.shared.size("spacing-2")) {
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
              Image(systemName: specIconName(specString("edit")))
                .font(.system(size: specPx(ThemeManager.shared.resolve("icon-xs"))))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Text(verbatim: specString("Click any editable cell to start editing"))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)

            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
              Image(systemName: specIconName(specString("arrow-right")))
                .font(.system(size: specPx(ThemeManager.shared.resolve("icon-xs"))))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Text(verbatim: specString("Use Tab/Arrow keys to navigate between cells"))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)

            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
              Image(systemName: specIconName(specString("check")))
                .font(.system(size: specPx(ThemeManager.shared.resolve("icon-xs"))))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Text(verbatim: specString("Modified cells show a yellow indicator"))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)

            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
              Image(systemName: specIconName(specString("arrow-left")))
                .font(.system(size: specPx(ThemeManager.shared.resolve("icon-xs"))))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Text(verbatim: specString("Ctrl+Z to undo, Ctrl+Y to redo"))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)

            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
              Image(systemName: specIconName(specString("clipboard")))
                .font(.system(size: specPx(ThemeManager.shared.resolve("icon-xs"))))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Text(verbatim: specString("Ctrl+C to copy, Ctrl+V to paste, Ctrl+D to fill down"))
                .font(.callout.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)

          }

        }
        .padding(ThemeManager.shared.size("spacing-4"))
      }
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
