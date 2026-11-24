import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class FeatureTestViewModel {
  var activeTab: Any = "p1"
  var matchValue: Any = "A"
  var counter: Any = 0
  var isP1: Any { specEq(activeTab, "p1") }
  var isP2: Any { specEq(activeTab, "p2") }
  var isP3: Any { specEq(activeTab, "p3") }
  var isP4: Any { specEq(activeTab, "p4") }
  var isP6: Any { specEq(activeTab, "p6") }
  var isP7: Any { specEq(activeTab, "p7") }
  var isP8: Any { specEq(activeTab, "p8") }
  var matchResult: Any { ({ () -> Any in switch specString(matchValue) {
case specString("A"): return "Arm 'A' matched — the match expression chose this literal arm."
case specString("B"): return "Arm 'B' matched — second arm works."
case specString("C"): return "Arm 'C' matched — third arm works."
default: return "Wildcard arm matched — no literal arm for this value."
} })() }
  var counterLabel: Any { ({ () -> Any in switch specString(counter) {
case specString(0): return "zero"
case specString(1): return "one"
case specString(2): return "two"
case specString(3): return "three"
default: return "many"
} })() }
  func setTab(_ t: Any) {
    activeTab = t
  }
  func setMatch(_ v: Any) {
    matchValue = v
  }
  func increment() {
    counter = specAdd(counter, 1)
  }
  func resetCounter() {
    counter = 0
  }
  func noOp(_ items: Any) {
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct FeatureTestView: View {
  @State private var vm = FeatureTestViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = FeatureTestViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
      Text(verbatim: specString("Feature Test — P1 through P8"))
        .font(.largeTitle)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-primary"))
      Text(verbatim: specString("Verify each completed priority. Use the tabs to navigate between features. P5 (SSR) was deferred."))
        .font(.body)
        .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
        .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
        Button(action: { specClick { vm.setTab("p1") } }) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("P1 · Slots"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(((vm.isP1) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(.vertical, CGFloat(6))
        .padding(.horizontal, CGFloat(12))
        .background(((vm.isP1) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        Button(action: { specClick { vm.setTab("p2") } }) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("P2 · Router"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(((vm.isP2) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(.vertical, CGFloat(6))
        .padding(.horizontal, CGFloat(12))
        .background(((vm.isP2) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        Button(action: { specClick { vm.setTab("p3") } }) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("P3 · Icons"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(((vm.isP3) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(.vertical, CGFloat(6))
        .padding(.horizontal, CGFloat(12))
        .background(((vm.isP3) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        Button(action: { specClick { vm.setTab("p4") } }) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("P4 · Charts"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(((vm.isP4) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(.vertical, CGFloat(6))
        .padding(.horizontal, CGFloat(12))
        .background(((vm.isP4) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        Button(action: { specClick { vm.setTab("p6") } }) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("P6 · @form"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(((vm.isP6) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(.vertical, CGFloat(6))
        .padding(.horizontal, CGFloat(12))
        .background(((vm.isP6) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        Button(action: { specClick { vm.setTab("p7") } }) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("P7 · Drag"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(((vm.isP7) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(.vertical, CGFloat(6))
        .padding(.horizontal, CGFloat(12))
        .background(((vm.isP7) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        Button(action: { specClick { vm.setTab("p8") } }) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("P8 · match"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(((vm.isP8) as? Bool ?? false ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
        }
        .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(.vertical, CGFloat(6))
        .padding(.horizontal, CGFloat(12))
        .background(((vm.isP8) as? Bool ?? false ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
      }

      if (vm.isP1) as? Bool ?? false {
        _specArm0
      }
      if (vm.isP2) as? Bool ?? false {
        _specArm1
      }
      if (vm.isP3) as? Bool ?? false {
        _specArm2
      }
      if (vm.isP4) as? Bool ?? false {
        _specArm3
      }
      if (vm.isP6) as? Bool ?? false {
        _specArm4
      }
      if (vm.isP7) as? Bool ?? false {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
        if (vm.isP7) as? Bool ?? false {
          Text(verbatim: specString("P7 — Drag & Drop (Sortable, KanbanBoard)"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          Text(verbatim: specString("HTML5 Drag and Drop — reorderable lists and multi-column kanban boards. Zero external dependencies."))
            .font(.body)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          Text(verbatim: specString("Drag these rows to reorder:"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          SortableView(badgeColors: ["Done": "#dcfce7" as Any, "Deferred": "#fef9c3" as Any] as [String: Any], badgeKey: "priority", gap: "6px", items: [["id": "1" as Any, "name": "P1 — Component Declarations" as Any, "priority": "Done" as Any] as [String: Any], ["id": "2" as Any, "name": "P2 — Client-Side Routing" as Any, "priority": "Done" as Any] as [String: Any], ["id": "3" as Any, "name": "P3 — Icon System" as Any, "priority": "Done" as Any] as [String: Any], ["id": "4" as Any, "name": "P4 — Chart Component" as Any, "priority": "Done" as Any] as [String: Any], ["id": "5" as Any, "name": "P5 — Server-Side Rendering" as Any, "priority": "Deferred" as Any] as [String: Any], ["id": "6" as Any, "name": "P6 — Form Validation (@form)" as Any, "priority": "Done" as Any] as [String: Any], ["id": "7" as Any, "name": "P7 — Drag & Drop" as Any, "priority": "Done" as Any] as [String: Any], ["id": "8" as Any, "name": "P8 — match statement" as Any, "priority": "Done" as Any] as [String: Any]] as [Any], labelKey: "name")
          VStack(alignment: .leading, spacing: 0) {
            Text(verbatim: specString("Navigate to Components > Drag & Drop for the full demo including KanbanBoard with WIP limits and cross-column drag."))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(Color(hex: "#166534"))
          }
          .padding(specBorderWidth("1px solid #bbf7d0"))
          .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderAll("1px solid #bbf7d0", radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        }
      }

      }
      if (vm.isP8) as? Bool ?? false {
        _specArm5
      }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }

  private var _specArm0: AnyView {
    AnyView(Group {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
        Text(verbatim: specString("P1 — Component Declarations"))
          .font(.title2)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Text(verbatim: specString("@children — default slot"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          InfoBoxView(title: "Custom Title (prop)", specChildren: AnyView(Group {
              Text(verbatim: specString("This content was passed from the call site and rendered at @children."))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
            }))
          InfoBoxView(specChildren: AnyView(Group {
              Text(verbatim: specString("Default title used — 'title' param defaulted to \"Info Box\"."))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
            }))
        }

        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Text(verbatim: specString("@slot(\"name\") — named slots"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          SplitRowView(specSlot_left: AnyView(VStack(alignment: .leading, spacing: 0) {
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                Text(verbatim: specString("Left slot"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(Color(hex: "#7c3aed"))
                Text(verbatim: specString("Content from slot(\"left\") { } at call site."))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(Color(hex: "#7c3aed"))
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .frame(maxWidth: .infinity, alignment: .leading)
              .background(Color(hex: "#ede9fe"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
            }), specSlot_right: AnyView(VStack(alignment: .leading, spacing: 0) {
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
                Text(verbatim: specString("Right slot"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(Color(hex: "#166534"))
                Text(verbatim: specString("Content from slot(\"right\") { } at call site."))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                  .foregroundStyle(Color(hex: "#166534"))
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .frame(maxWidth: .infinity, alignment: .leading)
              .background(Color(hex: "#dcfce7"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-sm"))))
            }))
        }

        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Text(verbatim: specString("@watch — prop change watcher"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          Text(verbatim: specString("CountDisplay watches its 'value' prop and tracks how many times it changed."))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
            CountDisplayView(value: vm.counter)
            HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Button(action: { specClick { vm.increment() } }) {
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("Increment (\(specString(vm.counter)))"))
                  .foregroundStyle(Color(hex: "#fff"))
              }
              .padding(.vertical, CGFloat(8))
              .padding(.horizontal, CGFloat(16))
              .background(ThemeManager.shared.color("primary"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
              Button(action: { specClick { vm.resetCounter() } }) {
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString("Reset"))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }
              .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
              .padding(.vertical, CGFloat(8))
              .padding(.horizontal, CGFloat(16))
              .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
            }

          }

        }

      }

    })
  }

  private var _specArm1: AnyView {
    AnyView(Group {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
        Text(verbatim: specString("P2 — Client-Side Routing (@router)"))
          .font(.title2)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Text(verbatim: specString("The @router block generates _routePath, _routeParams, and navigate() for path-based routing without a page reload."))
          .font(.body)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
          Text(verbatim: specString("Generated by @router:"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          Text(verbatim: specString("_routePath — current URL pathname (string signal)"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          Text(verbatim: specString("_routeParams — object with :param values extracted from the URL"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          Text(verbatim: specString("navigate(path) — action: calls history.pushState + updates signals"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          Text(verbatim: specString("Back/forward handled via popstate listener (auto-generated)"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        }
        .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("Navigate to Components > Routing in the sidebar for the full interactive demo with sidebar navigation, user detail routes, and 404 fallback."))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(Color(hex: "#166534"))
        }
        .padding(specBorderWidth("1px solid #bbf7d0"))
        .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll("1px solid #bbf7d0", radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      }

    })
  }

  private var _specArm2: AnyView {
    AnyView(Group {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
        Text(verbatim: specString("P3 — Icon System"))
          .font(.title2)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Text(verbatim: specString("The Icon component renders SVG icons by name. The @icons declaration enables namespaced external icon providers."))
          .font(.body)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Text(verbatim: specString("Icon component — name, size, color props:"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-5"))) {
            VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Image(systemName: specIconName(specString("home")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(ThemeManager.shared.color("primary"))
              Text(verbatim: specString("home"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

            VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Image(systemName: specIconName(specString("settings")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#f59e0b"))
              Text(verbatim: specString("settings"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

            VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Image(systemName: specIconName(specString("user")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#10b981"))
              Text(verbatim: specString("user"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

            VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Image(systemName: specIconName(specString("bell")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#ef4444"))
              Text(verbatim: specString("bell"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

            VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Image(systemName: specIconName(specString("star")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#6366f1"))
              Text(verbatim: specString("star"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

            VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
              Image(systemName: specIconName(specString("zap")))
                .font(.system(size: specPx(32)))
                .foregroundStyle(Color(hex: "#f59e0b"))
              Text(verbatim: specString("zap"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }

          }

          Text(verbatim: specString("Size variants (16 / 24 / 32 / 48 px):"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
            Image(systemName: specIconName(specString("check-circle")))
              .font(.system(size: specPx(16)))
              .foregroundStyle(Color(hex: "#10b981"))
            Image(systemName: specIconName(specString("check-circle")))
              .font(.system(size: specPx(24)))
              .foregroundStyle(Color(hex: "#10b981"))
            Image(systemName: specIconName(specString("check-circle")))
              .font(.system(size: specPx(32)))
              .foregroundStyle(Color(hex: "#10b981"))
            Image(systemName: specIconName(specString("check-circle")))
              .font(.system(size: specPx(48)))
              .foregroundStyle(Color(hex: "#10b981"))
          }

          Text(verbatim: specString("@icons declaration (namespaced providers):"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            Text(verbatim: specString("@icons { lucide: '@spec/icons-lucide' (default) }"))
              .font(.body)
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("// Usage: Icon(name: \"lucide:arrow-right\")"))
              .font(.body)
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
          .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
          .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        }

      }

    })
  }

  private var _specArm3: AnyView {
    AnyView(Group {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
        if (vm.isP4) as? Bool ?? false {
          Text(verbatim: specString("P4 — Data Visualization (Chart)"))
            .font(.title2)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          Text(verbatim: specString("Built-in SVG charts — line, bar, area, pie, donut. Zero external dependencies. Responsive via ResizeObserver."))
            .font(.body)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          SpecChartView(
            type: specString("bar"), data: [["label": "P1" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P2" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P3" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P4" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P5" as Any, "done": 0 as Any, "skipped": 1 as Any] as [String: Any], ["label": "P6" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P7" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any], ["label": "P8" as Any, "done": 1 as Any, "skipped": 0 as Any] as [String: Any]] as [Any],
            xKey: specString("label"), yKey: specString("y"),
            labelKey: specString("label"), valueKey: specString("value"),
            series: [["key": "done" as Any, "label": "Done" as Any, "color": "#10b981" as Any] as [String: Any], ["key": "skipped" as Any, "label": "Deferred" as Any, "color": "#f59e0b" as Any] as [String: Any]] as [Any], color: specString(""), colors: [] as [Any],
            title: specString(""), height: specPx("200px"),
            showGrid: true as? Bool ?? true,
            showValues: true as? Bool ?? false,
            showLegend: true as? Bool ?? true,
            yMin: nil, yMax: nil,
            connectNulls: false as? Bool ?? false,
            colorKey: specString(""),
            formatX: specString(""), formatY: specString("")
          )
          Text(verbatim: specString("Supported types: line · bar · area · pie · donut"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          VStack(alignment: .leading, spacing: 0) {
            Text(verbatim: specString("Navigate to Components > Charts in the sidebar for the full interactive demo with all five chart types."))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(Color(hex: "#166534"))
          }
          .padding(specBorderWidth("1px solid #bbf7d0"))
          .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderAll("1px solid #bbf7d0", radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        }
      }

    })
  }

  private var _specArm4: AnyView {
    AnyView(Group {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
        Text(verbatim: specString("P6 — Form Validation (@form)"))
          .font(.title2)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Text(verbatim: specString("The @form block generates field-level validation signals and actions with zero boilerplate."))
          .font(.body)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        HStack(alignment: .top, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
            Text(verbatim: specString("Per-field signals (e.g. for field 'email'):"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("_fld_email_touched — bool, true after blur or submit attempt"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            Text(verbatim: specString("_fld_email_error — null | error string (first failing validator)"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
          .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
          .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .specFlexGrow(1)
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
            Text(verbatim: specString("Surface-wide signals and actions:"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("_form_valid — true when all fields pass"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            Text(verbatim: specString("_form_dirty — true when any field changed from initial"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            Text(verbatim: specString("_form_submit_attempted — set by _submitForm()"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            Text(verbatim: specString("_touchField(name), _submitForm(), _resetForm(), _formData()"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
          .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
          .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .specFlexGrow(1)
        }

        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
          Text(verbatim: specString("Built-in validators:"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          Text(verbatim: specString("required · email · min-length(n) · max-length(n) · min(n) · max(n) · pattern(\"regex\")"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        }
        .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("Navigate to Components > Form Validation for the full interactive demo with live error display and form state inspector."))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(Color(hex: "#166534"))
        }
        .padding(specBorderWidth("1px solid #bbf7d0"))
        .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#f0fdf4"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderAll("1px solid #bbf7d0", radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      }

    })
  }

  private var _specArm5: AnyView {
    AnyView(Group {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
        Text(verbatim: specString("P8 — match Statement"))
          .font(.title2)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Text(verbatim: specString("match works both as an expression (returns a value) and as a surface-level construct (lazily mounts one component arm)."))
          .font(.body)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Text(verbatim: specString("match as expression — select an option:"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
            Button(action: { specClick { vm.setMatch("A") } }) {
            VStack(alignment: .leading, spacing: 0) {
              Text(verbatim: specString("A"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle((specEq(vm.matchValue, "A") ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
            }
            .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
            .padding(.vertical, CGFloat(6))
            .padding(.horizontal, CGFloat(14))
            .background((specEq(vm.matchValue, "A") ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
              .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            Button(action: { specClick { vm.setMatch("B") } }) {
            VStack(alignment: .leading, spacing: 0) {
              Text(verbatim: specString("B"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle((specEq(vm.matchValue, "B") ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
            }
            .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
            .padding(.vertical, CGFloat(6))
            .padding(.horizontal, CGFloat(14))
            .background((specEq(vm.matchValue, "B") ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
              .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            Button(action: { specClick { vm.setMatch("C") } }) {
            VStack(alignment: .leading, spacing: 0) {
              Text(verbatim: specString("C"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle((specEq(vm.matchValue, "C") ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
            }
            .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
            .padding(.vertical, CGFloat(6))
            .padding(.horizontal, CGFloat(14))
            .background((specEq(vm.matchValue, "C") ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
              .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            Button(action: { specClick { vm.setMatch("D") } }) {
            VStack(alignment: .leading, spacing: 0) {
              Text(verbatim: specString("D"))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
                .foregroundStyle((specEq(vm.matchValue, "D") ? Color(hex: "#fff") : ThemeManager.shared.color("text-primary")))
            }
            .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
            .padding(.vertical, CGFloat(6))
            .padding(.horizontal, CGFloat(14))
            .background((specEq(vm.matchValue, "D") ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("surface-raised")), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
              .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
          }

          VStack(alignment: .leading, spacing: 0) {
            Text(verbatim: specString(vm.matchResult))
              .font(.body)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
              .foregroundStyle(Color(hex: "#5b21b6"))
          }
          .padding(specBorderWidth("1px solid #c4b5fd"))
          .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(Color(hex: "#ede9fe"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderAll("1px solid #c4b5fd", radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        }

        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Text(verbatim: specString("match with number arms and wildcard:"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          Text(verbatim: specString("counter matched to a label: \(specString(vm.counterLabel)) (counter = \(specString(vm.counter)))"))
            .font(.body)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
            Button(action: { specClick { vm.increment() } }) {
            VStack(alignment: .leading, spacing: 0) {
              Text(verbatim: specString("Count up"))
                .foregroundStyle(Color(hex: "#fff"))
            }
            .padding(.vertical, CGFloat(8))
            .padding(.horizontal, CGFloat(16))
            .background(ThemeManager.shared.color("primary"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
              .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            Button(action: { specClick { vm.resetCounter() } }) {
            VStack(alignment: .leading, spacing: 0) {
              Text(verbatim: specString("Reset to 0"))
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
            }
            .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
            .padding(.vertical, CGFloat(8))
            .padding(.horizontal, CGFloat(16))
            .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
            .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
              .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
          }

        }

        VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
          Text(verbatim: specString("match as surface-level construct:"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          Text(verbatim: specString("Used throughout app.spec — viewTitle and breadcrumbSection are both match expressions over 'view'."))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            Text(verbatim: specString("viewTitle: match view {"))
              .font(.body)
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("  \"dashboard\" -> \"Dashboard\","))
              .font(.body)
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("  \"charts\"    -> \"Charts\","))
              .font(.body)
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("  _ -> \"Admin\""))
              .font(.body)
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("}"))
              .font(.body)
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
          }
          .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
          .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        }

      }

    })
  }
}
