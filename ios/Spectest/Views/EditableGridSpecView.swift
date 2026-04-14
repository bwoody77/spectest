import SwiftUI
import SpecRuntime

@Observable
final class EditableGridSpecViewModel {
  var activation: Any = "enter"
  var columns: Any? = nil
  var height: Any = ""
  var rowIdField: Any = "id"
  var rows: Any? = nil
  var saveMode: Any = "batch"
  var selected: Any = [] as [Any]
  var selection: Any = "none"
  var sort: Any = [] as [Any]
  var striped: Any = false
  var undoDepth: Any = 50
  var sortState: Any? = nil as Any? as Any
  var selectedSet: Any? = nil as Any? as Any
  var filters: Any = [] as [Any]
  var focusedRow: Any = 0
  var focusedCol: Any = 0
  var activeRow: Any = 0
  var activeCol: Any = 0
  var editing: Any = false
  var editValue: Any = ""
  var dirtyCells: Any = [] as [Any]
  var editedValues: Any = [] as [Any]
  var focusTrigger: Any = false
  var justCommitted: Any = false
  var undoStack: Any = [] as [Any]
  var redoStack: Any = [] as [Any]
  var validationErrors: Any = [] as [Any]
  init() {
    sortState = sort
    selectedSet = selected
  }
  var visibleColumns: Any { specFilter(columns, { (c: Any) -> Bool in return specNeq(specGet(c, "visible"), false) }) }
  var processedRows: Any { rows }
  var hasFilters: Any { specSome(columns, { (c: Any) -> Bool in return specEq(specGet(c, "filterable"), true) }) }
  var allSelected: Any { (specEq(specLength(selectedSet), specLength(processedRows)) && (specDouble(specLength(processedRows)) > specDouble(0))) }
  var activeRowData: Any { specGet(processedRows, activeRow) }
  var activeColDef: Any { specGet(visibleColumns, activeCol) }
  var cellKey: Any { ((activeRowData != nil && activeColDef != nil) ? specAdd(specAdd(specGet(activeRowData, rowIdField), "::"), specGet(activeColDef, "key")) : "") }
  var hasDirty: Any { (specDouble(specLength(dirtyCells)) > specDouble(0)) }
  var canUndo: Any { (specDouble(specLength(undoStack)) > specDouble(0)) }
  var canRedo: Any { (specDouble(specLength(redoStack)) > specDouble(0)) }
  var hasErrors: Any { (specDouble(specLength(validationErrors)) > specDouble(0)) }
  var changeset: Any { buildChangesetFromEdits(editedValues, dirtyCells, processedRows, rowIdField) }
  var isSelectEditing: Any { ((specEq(editing, true) && activeColDef != nil) && specEq(specGet(activeColDef, "type"), "select")) }
  var selectOptions: Any { (((isSelectEditing) as? Bool ?? false && specGet(activeColDef, "options") != nil) ? specGet(activeColDef, "options") : [] as [Any]) }
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
    if (specDouble(activeRow) > specDouble(0)) {
      checkRowBlur(activeRow)
      editing = false
      justCommitted = false
      activeRow = (specDouble(activeRow) - specDouble(1))
      focusTrigger = false
    }
  }
  func moveDown() {
    if (specDouble(activeRow) < specDouble((specDouble(specLength(processedRows)) - specDouble(1)))) {
      checkRowBlur(activeRow)
      editing = false
      justCommitted = false
      activeRow = specAdd(activeRow, 1)
      focusTrigger = false
    }
  }
  func moveLeft() {
    if (specDouble(activeCol) > specDouble(0)) {
      editing = false
      justCommitted = false
      activeCol = (specDouble(activeCol) - specDouble(1))
      focusTrigger = false
    }
  }
  func moveRight() {
    if (specDouble(activeCol) < specDouble((specDouble(specLength(visibleColumns)) - specDouble(1)))) {
      editing = false
      justCommitted = false
      activeCol = specAdd(activeCol, 1)
      focusTrigger = false
    }
  }
  func selectFocused() {
    selectRow(focusedRow)
  }
  func toggleSort(_ colKey: Any) {
    sortState = toggleSortState(sortState, colKey)
    /* event callback */
  }
  func activateEdit() {
    if (activeRowData != nil && activeColDef != nil) {
      var ck = specAdd(specAdd(specGet(activeRowData, rowIdField), "::"), specGet(activeColDef, "key"))
      var prev = specFirst(editedValues, { (e: Any) -> Bool in return specEq(specGet(e, "key"), ck) })
      editValue = (prev != nil ? specGet(prev, "value") : (specGet(activeRowData, specGet(activeColDef, "key")) != nil ? specAdd(specGet(activeRowData, specGet(activeColDef, "key")), "") : ""))
      editing = true
      focusTrigger = true
    }
  }
  func setEditValue(_ v: Any) {
    editValue = v
  }
  func selectOption(_ val: Any) {
    editValue = val
    commitEdit()
  }
  func commitEdit() {
    if ((specEq(editing, true) && activeRowData != nil) && activeColDef != nil) {
      var ck = specAdd(specAdd(specGet(activeRowData, rowIdField), "::"), specGet(activeColDef, "key"))
      var originalValue = specGet(activeRowData, specGet(activeColDef, "key"))
      var originalStr = (originalValue != nil ? specAdd(originalValue, "") : "")
      var prev = specFirst(editedValues, { (e: Any) -> Bool in return specEq(specGet(e, "key"), ck) })
      var currentValue = (prev != nil ? specGet(prev, "value") : originalStr)
      if specNeq(currentValue, editValue) {
        undoStack = pushUndoEntry(undoStack, ["changes": [["key": ck as Any, "oldValue": currentValue as Any, "newValue": editValue as Any] as [String: Any]] as [Any] as Any] as [String: Any], undoDepth)
        redoStack = [] as [Any]
        if specEq(originalStr, editValue) {
          dirtyCells = specFilter(dirtyCells, { (k: Any) -> Bool in return specNeq(k, ck) })
          editedValues = specFilter(editedValues, { (e: Any) -> Bool in return specNeq(specGet(e, "key"), ck) })
        } else {
          if specEq(specIncludes(dirtyCells, ck), false) {
            dirtyCells = specConcat(dirtyCells, [ck] as [Any])
          }
          editedValues = specConcat(specFilter(editedValues, { (e: Any) -> Bool in return specNeq(specGet(e, "key"), ck) }), [["key": ck as Any, "value": editValue as Any] as [String: Any]] as [Any])
        }
        var err = validateCell(editValue, activeColDef)
        if err != nil {
          validationErrors = specConcat(specFilter(validationErrors, { (e: Any) -> Bool in return specNeq(specGet(e, "key"), ck) }), [["key": ck as Any, "message": err as Any] as [String: Any]] as [Any])
        } else {
          validationErrors = specFilter(validationErrors, { (e: Any) -> Bool in return specNeq(specGet(e, "key"), ck) })
        }
        /* event callback */
        if specEq(saveMode, "auto") {
          /* event callback */
        }
      }
      editing = false
      justCommitted = true
      focusTrigger = false
    }
  }
  func cancelEdit() {
    editing = false
    justCommitted = true
    focusTrigger = false
  }
  func commitAndMoveDown() {
    commitEdit()
    moveDown()
  }
  func commitAndMoveRight() {
    commitEdit()
    moveRight()
  }
  func doUndo() {
    if (specDouble(specLength(undoStack)) > specDouble(0)) {
      var entry = specGet(undoStack, (specDouble(specLength(undoStack)) - specDouble(1)))
      undoStack = specSlice(undoStack, 0, (specDouble(specLength(undoStack)) - specDouble(1)))
      var result = applyUndoChanges("undo", specGet(entry, "changes"), editedValues, dirtyCells, processedRows, rowIdField)
      editedValues = specGet(result, "editedValues")
      dirtyCells = specGet(result, "dirtyCells")
      redoStack = specConcat(redoStack, [entry] as [Any])
    }
  }
  func doRedo() {
    if (specDouble(specLength(redoStack)) > specDouble(0)) {
      var entry = specGet(redoStack, (specDouble(specLength(redoStack)) - specDouble(1)))
      redoStack = specSlice(redoStack, 0, (specDouble(specLength(redoStack)) - specDouble(1)))
      var result = applyUndoChanges("redo", specGet(entry, "changes"), editedValues, dirtyCells, processedRows, rowIdField)
      editedValues = specGet(result, "editedValues")
      dirtyCells = specGet(result, "dirtyCells")
      undoStack = specConcat(undoStack, [entry] as [Any])
    }
  }
  func copyCell() {
    if (activeRowData != nil && activeColDef != nil) {
      var val = getCellDisplayValue(activeRow, activeCol, visibleColumns, processedRows, rowIdField, editedValues)
      // unsupported: clipboard-write
    }
  }
  func pasteClipboard() async {
    var text = await /* runtime: _readClipboard */  Optional<Any>.none as Any
    var result = computePaste(text, activeRow, activeCol, visibleColumns, processedRows, rowIdField, editedValues, dirtyCells)
    editedValues = specGet(result, "editedValues")
    dirtyCells = specGet(result, "dirtyCells")
    if (specDouble(specLength(specGet(result, "undoChanges"))) > specDouble(0)) {
      undoStack = pushUndoEntry(undoStack, ["changes": specGet(result, "undoChanges") as Any] as [String: Any], undoDepth)
      redoStack = [] as [Any]
    }
  }
  func fillDown() {
    var result = computeFillDown(activeRow, activeCol, visibleColumns, processedRows, rowIdField, editedValues, dirtyCells)
    editedValues = specGet(result, "editedValues")
    dirtyCells = specGet(result, "dirtyCells")
    if (specDouble(specLength(specGet(result, "undoChanges"))) > specDouble(0)) {
      undoStack = pushUndoEntry(undoStack, ["changes": specGet(result, "undoChanges") as Any] as [String: Any], undoDepth)
      redoStack = [] as [Any]
    }
  }
  func checkRowBlur(_ prevRowIdx: Any) {
    if ((specEq(saveMode, "row-blur") && (specDouble(prevRowIdx) >= specDouble(0))) && (specDouble(prevRowIdx) < specDouble(specLength(processedRows)))) {
      var rowData = specGet(processedRows, prevRowIdx)
      if rowData != nil {
        var rowId = specAdd(specGet(rowData, rowIdField), "")
        var changes = getRowChanges(rowId, editedValues)
        if changes != nil {
          /* event callback */
        }
      }
    }
  }
  func clickCell(_ rowIdx: Any, _ colIdx: Any) {
    if ((specNeq(activeRow, rowIdx) || specNeq(activeCol, colIdx)) || specEq(editing, false)) {
      if specEq(editing, true) {
        commitEdit()
      }
      checkRowBlur(activeRow)
      justCommitted = false
      activeRow = rowIdx
      activeCol = colIdx
      if specEq(activation, "click") {
        activateEdit()
      }
    }
  }
  func dblClickCell(_ rowIdx: Any, _ colIdx: Any) {
    if ((specNeq(activeRow, rowIdx) || specNeq(activeCol, colIdx)) || specEq(editing, false)) {
      if specEq(editing, true) {
        commitEdit()
      }
      checkRowBlur(activeRow)
      justCommitted = false
      activeRow = rowIdx
      activeCol = colIdx
      if specEq(activation, "dblclick") {
        activateEdit()
      }
    }
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct EditableGridSpecView: View {
  @State private var vm = EditableGridSpecViewModel()
  var activation: Any = "enter"
  var columns: Any? = nil
  var height: Any = ""
  var rowIdField: Any = "id"
  var rows: Any? = nil
  var saveMode: Any = "batch"
  var selected: Any = [] as [Any]
  var selection: Any = "none"
  var sort: Any = [] as [Any]
  var striped: Any = false
  var undoDepth: Any = 50
  init(activation: Any = "enter", columns: Any? = nil, height: Any = "", rowIdField: Any = "id", rows: Any? = nil, saveMode: Any = "batch", selected: Any = [] as [Any], selection: Any = "none", sort: Any = [] as [Any], striped: Any = false, undoDepth: Any = 50) { self._vm = State(initialValue: EditableGridSpecViewModel()); self.activation = activation; self.columns = columns; self.height = height; self.rowIdField = rowIdField; self.rows = rows; self.saveMode = saveMode; self.selected = selected; self.selection = selection; self.sort = sort; self.striped = striped; self.undoDepth = undoDepth }
  var body: some View {
    VStack() {
      VStack() {
        VStack() {
          ScrollView(.horizontal, showsIndicators: true) {
          VStack() {
            HStack(alignment: .center, ) {
              ForEach(Array(specArr(vm.visibleColumns).enumerated()), id: \.offset) { _idx, col in
                Button(action: { if (specGet(col, "sortable")) as? Bool ?? false { vm.toggleSort(specGet(col, "key")) } }) {
                HStack(alignment: .center, spacing: CGFloat(4)) {
                  Text(verbatim: ({ () -> String in
          let _h0: Any? = specGet(col, "header")
          if _h0 != nil { return specString(specGet(col, "header")) }
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
                    .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
                }
                .padding(CGFloat(8))
                .frame(minHeight: CGFloat(0))
                .frame(minWidth: CGFloat(0))
                .frame(minWidth: CGFloat(100))
                .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
              }
            }
            .background(ThemeManager.shared.color("semantic.surface"))
            .background(ThemeManager.shared.color("semantic.surface"))
            ForEach(Array(specArr(vm.processedRows).enumerated()), id: \.offset) { rowIdx, row in
              HStack(alignment: .center, ) {
                ForEach(Array(specArr(vm.visibleColumns).enumerated()), id: \.offset) { colIdx, col in
                  SpecEditableCell(vm: vm, row: row, col: col, rowIdx: rowIdx, colIdx: colIdx)
                }
              }
              .background(Color(hex: (specIncludes(vm.selectedSet, rowIdx) ? "#ffffff" : "transparent") as? String ?? "transparent"))
              .background(Color(hex: (specIncludes(vm.selectedSet, rowIdx) ? "#ffffff" : "transparent") as? String ?? "transparent"))
            }
            HStack(alignment: .center, ) {
              if specEq(specLength(vm.processedRows), 0) {
                Text(verbatim: specString("No rows"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
              }
            }
            .padding(CGFloat(24))
          }
          }
          .frame(maxHeight: .infinity)
        }
        .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .frame(maxHeight: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      }
      .specFrameHeight(specPx((specNeq(vm.height, "") ? vm.height : "auto")))
      .overlay {
        if (vm.isSelectEditing) as? Bool ?? false {
          ZStack {
            Color.black.opacity(0.15)
              .ignoresSafeArea()
              .onTapGesture { vm.cancelEdit() }
            if (vm.isSelectEditing) as? Bool ?? false {
              ScrollView(.horizontal, showsIndicators: true) {
              VStack() {
                ForEach(Array(specArr(vm.selectOptions).enumerated()), id: \.offset) { _idx, opt in
                  Button(action: { vm.selectOption(specGet(opt, "value")) }) {
                  VStack() {
                    Text(verbatim: specString(specGet(opt, "label")))
                      .font(.body.bold())
                      .foregroundStyle(Color(hex: (specEq(specGet(opt, "value"), vm.editValue) ? "#f7f7f8" : "#202732") as? String ?? "transparent"))
                  }
                  .padding(CGFloat(8))
                  .padding(.leading, CGFloat(12))
                  .padding(.trailing, CGFloat(12))
                  .background(Color(hex: (specEq(specGet(opt, "value"), vm.editValue) ? "#1677ff" : "transparent") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                  }
                  .buttonStyle(.plain)
                }
              }
              }
              .padding(CGFloat(4))
              .frame(minWidth: CGFloat(180))
              .frame(maxHeight: CGFloat(200))
              .background(ThemeManager.shared.color("semantic.surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            }
          }
        }
      }
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.columns, columns) { vm.columns = columns }; if !specEq(vm.rows, rows) { vm.rows = rows }; if !specEq(vm.selection, selection) { vm.selection = selection }; if !specEq(vm.selected, selected) { vm.selected = selected }; if !specEq(vm.sort, sort) { vm.sort = sort }; if !specEq(vm.height, height) { vm.height = height }; if !specEq(vm.striped, striped) { vm.striped = striped }; if !specEq(vm.rowIdField, rowIdField) { vm.rowIdField = rowIdField }; if !specEq(vm.activation, activation) { vm.activation = activation }; if !specEq(vm.saveMode, saveMode) { vm.saveMode = saveMode }; if !specEq(vm.undoDepth, undoDepth) { vm.undoDepth = undoDepth } }
    .task(id: specPropsKey([columns, rows, selection, selected, sort, height, striped, rowIdField, activation, saveMode, undoDepth])) { if !specEq(vm.columns, columns) { vm.columns = columns }; if !specEq(vm.rows, rows) { vm.rows = rows }; if !specEq(vm.selection, selection) { vm.selection = selection }; if !specEq(vm.selected, selected) { vm.selected = selected }; if !specEq(vm.sort, sort) { vm.sort = sort }; if !specEq(vm.height, height) { vm.height = height }; if !specEq(vm.striped, striped) { vm.striped = striped }; if !specEq(vm.rowIdField, rowIdField) { vm.rowIdField = rowIdField }; if !specEq(vm.activation, activation) { vm.activation = activation }; if !specEq(vm.saveMode, saveMode) { vm.saveMode = saveMode }; if !specEq(vm.undoDepth, undoDepth) { vm.undoDepth = undoDepth } }
  }
}

/// A single cell in the editable grid, extracted to its own View so the
/// Swift type-checker doesn't choke on the deeply nested ForEach body.
struct SpecEditableCell: View {
    @Bindable var vm: EditableGridSpecViewModel
    let row: Any
    let col: Any
    let rowIdx: Int
    let colIdx: Int

    private var isActive: Bool {
        specEq(rowIdx, vm.activeRow) && specEq(colIdx, vm.activeCol)
    }
    private var isEditing: Bool {
        isActive && specEq(vm.editing, true)
    }
    private var isSelectCol: Bool {
        specEq(specGet(col, "type"), "select")
    }
    private var cellKey: String {
        specString(specAdd(specAdd(specGet(row, vm.rowIdField), "::"), specGet(col, "key")))
    }
    private var displayValue: String {
        let edited = specFirst(vm.editedValues, { (e: Any) -> Bool in
            return specEq(specGet(e, "key"), cellKey)
        })
        if edited != nil {
            return specString(specGet(edited, "value"))
        }
        let raw = specGet(row, specGet(col, "key"))
        if raw != nil { return specString(raw) }
        return ""
    }

    var body: some View {
        Button(action: { vm.clickCell(rowIdx, colIdx) }) {
            VStack {
                if isEditing && isSelectCol {
                    Text(verbatim: specString(vm.editValue))
                        .font(.callout.bold())
                        .foregroundStyle(.blue)
                } else {
                    Text(verbatim: displayValue)
                        .font(.callout)
                        .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }
            }
            .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
            .padding(.horizontal, 8).padding(.vertical, 4)
            .background(
                specIncludes(vm.dirtyCells, cellKey)
                    ? Color.orange.opacity(0.08)
                    : Color.clear
            )
        }
        .buttonStyle(.plain)
        .frame(minWidth: 100)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(isActive ? (isEditing ? Color.blue : Color.blue.opacity(0.4)) : Color.clear,
                        lineWidth: isEditing ? 2 : 1)
        )
        .overlay {
            if isEditing && !isSelectCol {
                TextField("", text: Binding(
                    get: { vm.editValue as? String ?? "" },
                    set: { vm.editValue = $0 }
                ))
                .textFieldStyle(.roundedBorder)
                .padding(2)
                .onSubmit { vm.commitEdit() }
            }
        }
        .popover(isPresented: Binding(
            get: { isEditing && isSelectCol },
            set: { if !$0 { vm.cancelEdit() } }
        )) {
            SpecSelectPopover(
                options: specArr(vm.selectOptions).map { item -> Any in
                    if item is [String: Any] { return item }
                    let s = specString(item)
                    return ["label": s as Any, "value": s as Any] as [String: Any]
                },
                currentValue: vm.editValue,
                onSelect: { vm.selectOption($0) }
            )
        }
    }
}

/// Popover content for select-type columns.
struct SpecSelectPopover: View {
    let options: [Any]
    let currentValue: Any?
    let onSelect: (Any?) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(options.enumerated()), id: \.offset) { _, opt in
                    let isSelected = specEq(specGet(opt, "value"), currentValue)
                    Button {
                        onSelect(specGet(opt, "value"))
                    } label: {
                        HStack {
                            Text(verbatim: specString(specGet(opt, "label")))
                                .foregroundStyle(isSelected ? Color.white : Color.primary)
                            Spacer()
                            if isSelected {
                                Image(systemName: "checkmark").foregroundStyle(Color.white)
                            }
                        }
                        .padding(.horizontal, 16).padding(.vertical, 10)
                        .background(isSelected ? Color.blue : Color.clear)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .frame(minWidth: 200, maxHeight: 300)
        .presentationCompactAdaptation(.popover)
    }
}
