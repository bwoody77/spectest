import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class TreeDemoViewModel {
  var selectedNode: Any? = Optional<Any>.none as Any
  var searchQuery: Any = ""
  var categoryList: Any { (!specIsNil(categories) ? categories : [] as [Any]) }
  var hasSelection: Any { !specIsNil(selectedNode) }
  var selectedLabel: Any { (!specIsNil(selectedNode) ? specGet(selectedNode, "label") : "No selection") }
  var selectedId: Any { (!specIsNil(selectedNode) ? specGet(selectedNode, "id") : "") }
  var treeMinHeight: Any { "400px" }
  var treeCols: Any { "280px 1fr" }
  let categoriesSource = DataSource(endpoint: "http://localhost:4500/api/categories", method: "GET")
  var categories: Any? { categoriesSource.data }
  var categoriesLoading: Bool { categoriesSource.loading }
  var categoriesError: String? { categoriesSource.error }
  var categoriesErrorBody: Any? { categoriesSource.errorBody }
  func selectNode(_ node: Any) {
    selectedNode = node
  }
  func setSearch(_ v: Any) {
    searchQuery = v
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
  func loadSources() async {
    await categoriesSource.fetch()
  }
}

struct TreeDemoView: View {
  @State private var vm = TreeDemoViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = TreeDemoViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Image(systemName: specIconName(specString("list")))
          .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-lg"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Category Browser"))
          .font(.largeTitle)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
      }
      .padding(.bottom, specBorderWidth(ThemeManager.shared.rawToken("borders-section-accent")))
      .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
      .frame(maxWidth: .infinity, alignment: .center)
      .background(ThemeManager.shared.color("gradient-header-accent"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .specBorderSides(nil, top: nil, right: nil, bottom: ThemeManager.shared.rawToken("borders-section-accent"), left: nil, radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      if (vm.categoriesLoading) as? Bool ?? false {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
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

      }
      if (vm.categoriesError) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
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

      }
      if ((!((vm.categoriesLoading) as? Bool ?? false))) as? Bool ?? false {
        _specArm1
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
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
            Text(verbatim: specString(vm.selectedLabel))
              .font(.largeTitle)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Text(verbatim: specString("ID:"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  .textCase(.uppercase)
                Text(verbatim: specString(vm.selectedId))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-mono-md-fontWeight")))
                  .monospacedDigit()
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }

              HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Text(verbatim: specString("Name:"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  .textCase(.uppercase)
                Text(verbatim: specString(vm.selectedLabel))
                  .font(.body.weight(.semibold))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }

            }
            .padding(.leading, specBorderWidth(ThemeManager.shared.rawToken("borders-accent-interactive")))
            .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .specBorderSides(nil, top: nil, right: nil, bottom: nil, left: ThemeManager.shared.rawToken("borders-accent-interactive"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
              Button(action: {  }) {
                Text(specString("Add Subcategory"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.semibold))
                  .foregroundStyle(.white)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(ThemeManager.shared.color("interactive"), in: RoundedRectangle(cornerRadius: 8))
              }
              Button(action: {  }) {
                Text(specString("Edit Category"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.medium))
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
              }
              Button(action: {  }) {
                Text(specString("Delete"))
                  .lineLimit(1)
                  .fixedSize(horizontal: true, vertical: false)
                  .font(.subheadline.weight(.semibold))
                  .foregroundStyle(.white)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 8)
                  .background(ThemeManager.shared.color("destructive"), in: RoundedRectangle(cornerRadius: 8))
              }
            }

          }

    })
  }

  private var _specArm1: AnyView {
    AnyView(Group {
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
        ScrollView(.vertical, showsIndicators: true) {
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          VStack(alignment: .leading, spacing: 4) {
            Text(specString("Filter categories")).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
            SpecTextField(specString("Search..."), text: Binding(get: { vm.searchQuery as? String ?? "" }, set: { newValue in vm.searchQuery = newValue; let v: Any = newValue; vm.searchQuery = v }))
            .textFieldStyle(.roundedBorder)
            .textContentType(.none)
            .autocorrectionDisabled()
            .specAccessibilityLabel(specFieldName("", "Filter categories"))
          }
          TreeView(expanded: [] as [Any], nodes: vm.categoryList, selection: "single", onDispatch: { specEvent, specPayload in
            _ = specPayload
            switch specString(specEvent) {
            case "selectionChange":
              let specArgs = specArr(specPayload)
              let ids: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
              vm.selectNode(ids)
            default: break
            }
          })
        }
        }
        .padding(.trailing, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
        .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderSides(nil, top: nil, right: ThemeManager.shared.rawToken("borders-default"), bottom: nil, left: nil, radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          if ((!((vm.hasSelection) as? Bool ?? false))) as? Bool ?? false {
          VStack(alignment: .leading, spacing: 0) {
            if ((!((vm.hasSelection) as? Bool ?? false))) as? Bool ?? false {
              ContentUnavailableView(specString("No Category Selected"), systemImage: "tray", description: Text(specString("Select a category from the tree to view its details.")))
                .frame(height: 200)
            }
          }

          }
          if (vm.hasSelection) as? Bool ?? false {
            _specArm0
          }
        }
        .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
        .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      }
      .frame(minHeight: specPx(vm.treeMinHeight), alignment: .top)
    })
  }
}
