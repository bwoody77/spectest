// @speckeep — hand-tuned helper views for EditableGridSpec
import SwiftUI
import SpecRuntime

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
