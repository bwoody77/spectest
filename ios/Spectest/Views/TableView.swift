import SwiftUI
import SpecRuntime

@Observable
final class TableViewModel {
  var columns: Any? = nil
  var rows: Any? = nil
  var striped: Any = false
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct TableView: View {
  @State private var vm = TableViewModel()
  var columns: Any? = nil
  var rows: Any? = nil
  var striped: Any = false
  init(columns: Any? = nil, rows: Any? = nil, striped: Any = false) { self._vm = State(initialValue: TableViewModel()); self.columns = columns; self.rows = rows; self.striped = striped }
  var body: some View {
    VStack() {
      ScrollView(.horizontal, showsIndicators: true) {
      VStack() {
        HStack(alignment: .center, ) {
          ForEach(Array(specArr(vm.columns).enumerated()), id: \.offset) { _idx, col in
            VStack() {
              Text(verbatim: specString(specGet(col, "header")))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }
            .padding(CGFloat(12))
            .frame(minWidth: CGFloat(120))
            .frame(maxWidth: .infinity)
          }
        }
        .background(ThemeManager.shared.color("semantic.background"))
        .background(ThemeManager.shared.color("semantic.background"))
        ForEach(Array(specArr(vm.rows).enumerated()), id: \.offset) { rowIndex, row in
          HStack(alignment: .center, ) {
            ForEach(Array(specArr(vm.columns).enumerated()), id: \.offset) { _idx, col in
              VStack() {
                // slot
                Text(verbatim: specString(specGet(row, specGet(col, "key"))))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              }
              .padding(CGFloat(12))
              .frame(minWidth: CGFloat(120))
              .frame(maxWidth: .infinity)
            }
          }
          .background(Color(hex: ({ () -> Any in switch specString(vm.striped) {
case specString(true): return ({ () -> Any in switch specString((specDouble(rowIndex) .truncatingRemainder(dividingBy: specDouble(2)))) {
case specString(0): return "transparent"
default: return "#ffffff"
} })()
default: return "transparent"
} })() as? String ?? "transparent"))
          .background(Color(hex: ({ () -> Any in switch specString(vm.striped) {
case specString(true): return ({ () -> Any in switch specString((specDouble(rowIndex) .truncatingRemainder(dividingBy: specDouble(2)))) {
case specString(0): return "transparent"
default: return "#ffffff"
} })()
default: return "transparent"
} })() as? String ?? "transparent"))
          .hoverEffect(.highlight)
        }
      }
      }
      .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.columns, columns) { vm.columns = columns }; if !specEq(vm.rows, rows) { vm.rows = rows }; if !specEq(vm.striped, striped) { vm.striped = striped } }
    .task(id: specPropsKey([columns, rows, striped])) { if !specEq(vm.columns, columns) { vm.columns = columns }; if !specEq(vm.rows, rows) { vm.rows = rows }; if !specEq(vm.striped, striped) { vm.striped = striped } }
  }
}
