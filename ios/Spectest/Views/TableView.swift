import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class TableViewModel {
  var columns: Any? = nil
  var rows: Any? = nil
  var striped: Any = false
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
  var _specSlots: [String: Any] = [:]
}

struct TableView: View {
  @State private var vm = TableViewModel()
  var columns: Any? = nil
  var rows: Any? = nil
  var striped: Any = false
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  var specSlot_cell: AnyView? = nil
  init(columns: Any? = nil, rows: Any? = nil, striped: Any = false, onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil, specSlot_cell: AnyView? = nil) { let _m = TableViewModel(); _m.columns = columns; _m.rows = rows; _m.striped = striped; _m.onDispatch = onDispatch; var _sl: [String: Any] = [:]; if let v = specSlot_cell { _sl["cell"] = v as Any }; _m._specSlots = _sl; self._vm = State(initialValue: _m); self.columns = columns; self.rows = rows; self.striped = striped; self.onDispatch = onDispatch; self.specSlot_cell = specSlot_cell }
  private var _specParamKey: String { specChangeKey(columns) + "\u{1}" + specChangeKey(rows) + "\u{1}" + specChangeKey(striped) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      ScrollView(.vertical, showsIndicators: true) {
      VStack(alignment: .leading, spacing: 0) {
        HStack(alignment: .center, spacing: 0) {
          ForEach(Array(specArr(vm.columns).enumerated()), id: \.offset) { _idx, col in
            VStack(alignment: .leading, spacing: 0) {
              Text(verbatim: specString(specGet(col, "header")))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-strong-fontWeight")))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                .textCase(.uppercase)
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
            .frame(minWidth: CGFloat(120), alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .specFlexGrow(1)
          }
        }
        .padding(.bottom, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ThemeManager.shared.color("surface-raised"))
        .specBorderSides(nil, top: nil, right: nil, bottom: ThemeManager.shared.rawToken("borders-default"), left: nil, radius: CGFloat(0))
        ForEach(Array(specArr(vm.rows).enumerated()), id: \.offset) { rowIndex, row in
          HStack(alignment: .center, spacing: 0) {
            ForEach(Array(specArr(vm.columns).enumerated()), id: \.offset) { _idx, col in
              VStack(alignment: .leading, spacing: 0) {
                (specSlot_cell ?? AnyView(EmptyView()))
                Text(verbatim: specString(specGet(row, specGet(col, "key"))))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .frame(minWidth: CGFloat(120), alignment: .leading)
              .frame(maxWidth: .infinity, alignment: .leading)
              .specFlexGrow(1)
            }
          }
          .padding(.bottom, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(({ () -> Color in switch specString(vm.striped) {
case specString(true): return ({ () -> Color in switch specString((specDouble(rowIndex) .truncatingRemainder(dividingBy: specDouble(2)))) {
case specString(0): return Color.clear
default: return ThemeManager.shared.color("surface-raised")
} })()
default: return Color.clear
} })())
          .specBorderSides(nil, top: nil, right: nil, bottom: ThemeManager.shared.rawToken("borders-default"), left: nil, radius: CGFloat(0))
          .hoverEffect(.highlight)
        }
      }
      }
      .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
      .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: ThemeManager.shared.radius("md"))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.columns = columns
      vm.rows = rows
      vm.striped = striped
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.columns, columns) { vm.columns = columns }; if !specSame(vm.rows, rows) { vm.rows = rows }; if !specSame(vm.striped, striped) { vm.striped = striped } }
    .task(id: specPropsKey([columns, rows, striped])) { if !specSame(vm.columns, columns) { vm.columns = columns }; if !specSame(vm.rows, rows) { vm.rows = rows }; if !specSame(vm.striped, striped) { vm.striped = striped } }
  }
}
