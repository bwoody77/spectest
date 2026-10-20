import SwiftUI
import SpecRuntime

@Observable
final class DataGridSpecViewModel {
  var columns: Any? = nil
  var height: Any = ""
  var rows: Any? = nil
  var selected: Any = [] as [Any]
  var selection: Any = "none"
  var sort: Any = [] as [Any]
  var striped: Any = false
  var sortState: Any? = nil as Any? as Any
  var selectedSet: Any? = nil as Any? as Any
  var filters: Any = [] as [Any]
  var focusedRow: Any = 0
  var focusedCol: Any = 0
  init() {
    sortState = sort
    selectedSet = selected
  }
  var visibleColumns: Any { specFilter(columns, { (c: Any) -> Bool in return specNeq(specGet(c, "visible"), false) }) }
  var processedRows: Any { applySortAndFilter(rows, sortState, filters) }
  var hasFilters: Any { specSome(columns, { (c: Any) -> Bool in return specEq(specGet(c, "filterable"), true) }) }
  var allSelected: Any { (specEq(specLength(selectedSet), specLength(processedRows)) && (specDouble(specLength(processedRows)) > specDouble(0))) }
  func toggleSortCol(_ colKey: Any) {
    sortState = toggleSortState(sortState, colKey)
    /* event callback */
  }
  func setFilter(_ colKey: Any, _ value: Any) {
    var existing = specFirst(filters, { (f: Any) -> Bool in return specEq(specGet(f, "key"), colKey) })
    if existing != nil {
      if specEq(value, "") {
        filters = specFilter(filters, { (f: Any) -> Bool in return specNeq(specGet(f, "key"), colKey) })
      } else {
        filters = specMap(filters, { (f: Any) -> Any in return (specEq(specGet(f, "key"), colKey) ? ["key": colKey as Any, "value": value as Any] as [String: Any] : f) })
      }
    } else {
      if specNeq(value, "") {
        filters = specConcat(filters, [["key": colKey as Any, "value": value as Any] as [String: Any]] as [Any])
      }
    }
    /* event callback */
  }
  func selectRow(_ idx: Any) {
    if specEq(selection, "single") {
      selectedSet = [idx] as [Any]
      /* event callback */
    } else {
      if specEq(selection, "multi") {
        if specIncludes(selectedSet, idx) {
          selectedSet = specFilter(selectedSet, { (i: Any) -> Bool in return specNeq(i, idx) })
        } else {
          selectedSet = specConcat(selectedSet, [idx] as [Any])
        }
        /* event callback */
      }
    }
  }
  func selectAllRows() {
    selectedSet = specMapIndexed(processedRows, { (row: Any, i: Int) -> Any in return i })
    /* event callback */
  }
  func clearSelection() {
    selectedSet = [] as [Any]
    /* event callback */
  }
  func clickRow(_ row: Any, _ idx: Any) {
    selectRow(idx)
    /* event callback */
  }
  func moveUp() {
    if (specDouble(focusedRow) > specDouble(0)) {
      focusedRow = (specDouble(focusedRow) - specDouble(1))
    }
  }
  func moveDown() {
    if (specDouble(focusedRow) < specDouble((specDouble(specLength(processedRows)) - specDouble(1)))) {
      focusedRow = specAdd(focusedRow, 1)
    }
  }
  func moveLeft() {
    if (specDouble(focusedCol) > specDouble(0)) {
      focusedCol = (specDouble(focusedCol) - specDouble(1))
    }
  }
  func moveRight() {
    if (specDouble(focusedCol) < specDouble((specDouble(specLength(visibleColumns)) - specDouble(1)))) {
      focusedCol = specAdd(focusedCol, 1)
    }
  }
  func selectFocused() {
    selectRow(focusedRow)
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct DataGridSpecView: View {
  @State private var vm = DataGridSpecViewModel()
  var columns: Any? = nil
  var height: Any = ""
  var rows: Any? = nil
  var selected: Any = [] as [Any]
  var selection: Any = "none"
  var sort: Any = [] as [Any]
  var striped: Any = false
  init(columns: Any? = nil, height: Any = "", rows: Any? = nil, selected: Any = [] as [Any], selection: Any = "none", sort: Any = [] as [Any], striped: Any = false) { self._vm = State(initialValue: DataGridSpecViewModel()); self.columns = columns; self.height = height; self.rows = rows; self.selected = selected; self.selection = selection; self.sort = sort; self.striped = striped }
  var body: some View {
    VStack() {
      VStack() {
        ScrollView(.horizontal, showsIndicators: true) {
        VStack() {
          HStack(alignment: .center) {
            HStack(alignment: .center) {
              if specEq(vm.selection, "multi") {
                Toggle(specString(""), isOn: .constant(vm.allSelected as? Bool ?? false))
                  .toggleStyle(.automatic)
              }
            }
            .padding(ThemeManager.shared.size("spacing-2"))
            .frame(width: CGFloat(40))
            ForEach(Array(specArr(vm.visibleColumns).enumerated()), id: \.offset) { _idx, col in
              Button(action: { if (specGet(col, "sortable")) as? Bool ?? false { vm.toggleSortCol(specGet(col, "key")) } }) {
              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-1")) {
                Text(verbatim: ({ () -> String in
          let _h0: Any? = specGet(col, "header")
          if _h0 != nil { return specString(specGet(col, "header")) }
          let _h1: Any? = specGet(col, "label")
          if _h1 != nil { return specString(specGet(col, "label")) }
          return specString(specGet(col, "key"))
        })())
                  .font(.body.bold())
                Text(verbatim: ({ () -> String in
          let _h0: Any? = specFirst(vm.sortState, { (s: Any) -> Bool in return specEq(specGet(s, "key"), specGet(col, "key")) })
          if _h0 != nil {
            let _h1: String = specString(specGet(specFirst(vm.sortState, { (s: Any) -> Bool in return specEq(specGet(s, "key"), specGet(col, "key")) }), "direction"))
            let _h2: String = specString("asc")
            if _h1 == _h2 { return specString("u2191") }
            return specString("u2193")
          }
          return specString("")
        })())
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
              }
              .padding(ThemeManager.shared.size("spacing-2"))
              .frame(minWidth: CGFloat(100))
              .frame(maxWidth: .infinity)
              }
              .buttonStyle(.plain)
            }
          }
          .background(ThemeManager.shared.color("surface-raised"))
          .background(ThemeManager.shared.color("surface-raised"))
          HStack(alignment: .center) {
            if (vm.hasFilters) as? Bool ?? false {
              VStack() {
                if specEq(vm.selection, "multi") {
                }
              }
              .frame(width: CGFloat(40))
            }
            ForEach(Array(specArr(vm.visibleColumns).enumerated()), id: \.offset) { _idx, col in
              VStack() {
                VStack() {
                  if specEq(specGet(col, "filterable"), true) {
                    TextField("", text: Binding(get: { vm.filters as? String ?? "" }, set: { vm.filters = $0 }))
                      .textFieldStyle(.roundedBorder)
                  }
                }

              }
              .padding(ThemeManager.shared.size("spacing-1"))
              .frame(minWidth: CGFloat(100))
              .frame(maxWidth: .infinity)
            }
          }
          .background(ThemeManager.shared.color("surface"))
          .background(ThemeManager.shared.color("surface"))
          ForEach(Array(specArr(vm.processedRows).enumerated()), id: \.offset) { rowIdx, row in
            Button(action: { vm.clickRow(row, rowIdx) }) {
            HStack(alignment: .center) {
              HStack(alignment: .center) {
                if specEq(vm.selection, "multi") {
                  Toggle(specString(""), isOn: .constant(false))
                    .toggleStyle(.automatic)
                }
              }
              .padding(ThemeManager.shared.size("spacing-2"))
              .frame(width: CGFloat(40))
              ForEach(Array(specArr(vm.visibleColumns).enumerated()), id: \.offset) { colIdx, col in
                VStack() {
                  // slot
                  Text(verbatim: ({ () -> String in
          let _h0: Any? = specGet(row, specGet(col, "key"))
          if _h0 != nil { return specString(specAdd(specGet(row, specGet(col, "key")), "")) }
          return specString("")
        })())
                    .font(.callout.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                }
                .padding(ThemeManager.shared.size("spacing-2"))
                .background(((specEq(vm.focusedRow, rowIdx) && specEq(vm.focusedCol, colIdx)) ? Color(hex: "rgba(59,130,246,0.08)" as? String ?? "transparent") : Color.clear))
                .frame(minWidth: CGFloat(100))
                .background(((specEq(vm.focusedRow, rowIdx) && specEq(vm.focusedCol, colIdx)) ? Color(hex: "rgba(59,130,246,0.08)" as? String ?? "transparent") : Color.clear))
                .frame(maxWidth: .infinity)
              }
            }
            .background((specIncludes(vm.selectedSet, rowIdx) ? ThemeManager.shared.color("surface-raised") : (((vm.striped) as? Bool ?? false && specEq((specDouble(rowIdx) .truncatingRemainder(dividingBy: specDouble(2))), 1)) ? ThemeManager.shared.color("surface") : Color.clear)))
            .background((specIncludes(vm.selectedSet, rowIdx) ? ThemeManager.shared.color("surface-raised") : (((vm.striped) as? Bool ?? false && specEq((specDouble(rowIdx) .truncatingRemainder(dividingBy: specDouble(2))), 1)) ? ThemeManager.shared.color("surface") : Color.clear)))
            .hoverEffect(.highlight)
            }
            .buttonStyle(.plain)
          }
          HStack(alignment: .center) {
            if specEq(specLength(vm.processedRows), 0) {
              Text(verbatim: specString("No rows"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            }
          }
          .padding(ThemeManager.shared.size("spacing-6"))
        }
        }
        .frame(maxHeight: .infinity)
      }
      .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      .focusable()
      .onKeyPress(.downArrow) { Task { @MainActor in await vm.moveDown() }; return .handled }
      .onKeyPress(.upArrow) { Task { @MainActor in await vm.moveUp() }; return .handled }
      .onKeyPress(.rightArrow) { Task { @MainActor in await vm.moveRight() }; return .handled }
      .onKeyPress(.leftArrow) { Task { @MainActor in await vm.moveLeft() }; return .handled }
      .onKeyPress(.init(" ")) { Task { @MainActor in await vm.selectFocused() }; return .handled }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.columns, columns) { vm.columns = columns }; if !specEq(vm.rows, rows) { vm.rows = rows }; if !specEq(vm.selection, selection) { vm.selection = selection }; if !specEq(vm.selected, selected) { vm.selected = selected }; if !specEq(vm.sort, sort) { vm.sort = sort }; if !specEq(vm.height, height) { vm.height = height }; if !specEq(vm.striped, striped) { vm.striped = striped } }
    .task(id: specPropsKey([columns, rows, selection, selected, sort, height, striped])) { if !specEq(vm.columns, columns) { vm.columns = columns }; if !specEq(vm.rows, rows) { vm.rows = rows }; if !specEq(vm.selection, selection) { vm.selection = selection }; if !specEq(vm.selected, selected) { vm.selected = selected }; if !specEq(vm.sort, sort) { vm.sort = sort }; if !specEq(vm.height, height) { vm.height = height }; if !specEq(vm.striped, striped) { vm.striped = striped } }
  }
}
