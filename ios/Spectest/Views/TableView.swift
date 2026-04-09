import SwiftUI
import SpecRuntime

@Observable
final class TableViewModel {
  var columns: Any? = nil
  var rows: Any? = nil
  var striped: Any = false
}

struct TableView: View {
  @State private var vm = TableViewModel()
  var columns: Any? = nil
  var rows: Any? = nil
  var striped: Any = false
  init(columns: Any? = nil, rows: Any? = nil, striped: Any = false) { self._vm = State(initialValue: TableViewModel()); self.columns = columns; self.rows = rows; self.striped = striped }
  var body: some View {
    VStack() {
      VStack() {
        HStack(alignment: .center, ) {
          ForEach(Array((vm.columns as? [Any] ?? []).enumerated()), id: \.offset) { _idx, col in
            VStack() {
              Text(specString((col as? [String: Any])?["header"]))
                .font(.body.bold())
                .foregroundStyle(.secondary)
            }
            .padding(CGFloat(12))
            .frame(minHeight: CGFloat(0))
            .frame(minWidth: CGFloat(0))
            .frame(minWidth: CGFloat(120))
            .frame(maxWidth: .infinity)
          }
        }
        .background(Color(.secondarySystemGroupedBackground))
        .background(Color(.secondarySystemGroupedBackground))
        ForEach(Array((vm.rows as? [Any] ?? []).enumerated()), id: \.offset) { rowIndex, row in
          HStack(alignment: .center, ) {
            ForEach(Array((vm.columns as? [Any] ?? []).enumerated()), id: \.offset) { _idx, col in
              VStack() {
                // slot
                Text(specString((row as? [Any])?[(col as? [String: Any])?["key"] as? Int ?? 0]))
                  .font(.body.bold())
                  .foregroundStyle(.primary)
              }
              .padding(CGFloat(12))
              .frame(minHeight: CGFloat(0))
              .frame(minWidth: CGFloat(0))
              .frame(minWidth: CGFloat(120))
              .frame(maxWidth: .infinity)
            }
          }
          .background(Color(hex: ({ () -> Any in switch specString(vm.striped) {
case specString(true): return ({ () -> Any in switch specString(((rowIndex as? Double ?? 0) .truncatingRemainder(dividingBy: (2 as? Double ?? 0)))) {
case specString(0): return "transparent"
default: return "#ffffff"
} })()
default: return "transparent"
} })() as? String ?? "#000"))
          .background(Color(hex: ({ () -> Any in switch specString(vm.striped) {
case specString(true): return ({ () -> Any in switch specString(((rowIndex as? Double ?? 0) .truncatingRemainder(dividingBy: (2 as? Double ?? 0)))) {
case specString(0): return "transparent"
default: return "#ffffff"
} })()
default: return "transparent"
} })() as? String ?? "#000"))
        }
      }
      .clipShape(RoundedRectangle(cornerRadius: CGFloat(8)))
      .clipShape(RoundedRectangle(cornerRadius: CGFloat(8)))
      .scrollIndicators(.visible)
    }
    .foregroundStyle(.primary)
    .onAppear { vm.columns = columns; vm.rows = rows; vm.striped = striped }
  }
}
