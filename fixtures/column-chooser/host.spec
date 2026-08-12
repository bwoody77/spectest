// Real-layout fixture for the ColumnChooser (One Grid P3).
//
// Mounted by tests/e2e/column-chooser.spec.ts against a `--standalone` bundle,
// so it needs no app shell, no router and no API. Six 150px columns inside a
// 1100px block give the drags real, predictable geometry — the component suite
// runs in happy-dom, where getBoundingClientRect() is all zeros, so the drop
// slot's height and the group block's travel are invisible to it.
//
// The shape is deliberate:
//   · `c` starts HIDDEN, so the P1 order contract can be exercised — a header
//     drag has to emit an order that still carries a key it cannot see.
//   · `g1`/`g2` share group "Q", so the group can be dragged as a block both
//     from the chooser's list and from its label in the grid header.
//   · every column is `sortable: true`, because click-to-sort is what a header
//     cell does WITHOUT the drag wire and is therefore the control the
//     click-vs-drag threshold is measured against.
//
// Both emitted events render into testids: the grid can reorder its own header
// without ever telling the caller, and only an assertion on what was EMITTED
// tells the two apart.

surface ChooserHost {
  @state {
    order: []
    hidden: ["c"]
    lastEmitted: []
    lastHidden: []
  }

  block {
    width: 1100px

    DataGrid(
      columns: [
        { key: "a", label: "Alpha", header: "Alpha", width: 150, sortable: true },
        { key: "b", label: "Bravo", header: "Bravo", width: 150, sortable: true },
        { key: "c", label: "Charlie", header: "Charlie", width: 150, sortable: true },
        { key: "g1", label: "Gamma one", header: "G1", width: 150, sortable: true, group: "Q" },
        { key: "g2", label: "Gamma two", header: "G2", width: 150, sortable: true, group: "Q" },
        { key: "z", label: "Zulu", header: "Zulu", width: 150, sortable: true }
      ],
      rows: [{ id: 1, a: "a1", b: "b1", c: "c1", g1: "g11", g2: "g21", z: "z1" }],
      reorderableColumns: true,
      configurableColumns: true,
      columnOrder: order,
      hiddenColumns: hidden
    ) {
      // The handlers MUST live inside the component's braces. Written on an
      // indented line after the closing paren they compile to a DOM listener
      // that nothing ever dispatches — `emit()` lowers to a prop call, not a
      // CustomEvent — and the grid still updates itself, so only an assertion
      // on what was emitted catches it.
      on columnOrderChange(keys): {
        order = keys
        lastEmitted = keys
      }
      on columnVisibilityChange(keys): {
        hidden = keys
        lastHidden = keys
      }
    }

    block {
      data-testid: "emitted"
      text(lastEmitted |> join(","))
    }
    block {
      data-testid: "hidden-emitted"
      text(lastHidden |> join(","))
    }
  }
}
