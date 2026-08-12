// Real-layout fixture for DataGrid column drag-to-reorder.
//
// Mounted by tests/e2e/grid-column-reorder.spec.ts against a `--standalone`
// bundle, so it needs no app shell, no router and no API. Four equal 150px
// columns inside a 900px block give the drag real, predictable geometry —
// the component suite runs in happy-dom, where getBoundingClientRect() is
// all zeros and the gap math can never be exercised.
//
// `lastEmitted` is rendered into a testid so the test can assert what the
// grid EMITTED, not just what it re-rendered. The two are different claims:
// the grid could reorder its own header without ever telling the caller.
//
// Every column is `sortable: true` on purpose. Click-to-sort is what a header
// cell does WITHOUT the drag wire, so it is the control the click-vs-drag
// threshold is measured against: a click must still sort, and a completed drag
// must not (the wire swallows the trailing click). With unsortable columns a
// click is a no-op and both halves of that pass vacuously.

surface ReorderHost {
  @state {
    order: []
    lastEmitted: []
  }

  block {
    width: 900px

    DataGrid(
      columns: [
        { key: "a", header: "Alpha", width: 150, sortable: true },
        { key: "b", header: "Bravo", width: 150, sortable: true },
        { key: "c", header: "Charlie", width: 150, sortable: true },
        { key: "d", header: "Delta", width: 150, sortable: true }
      ],
      rows: [{ id: 1, a: "a1", b: "b1", c: "c1", d: "d1" }],
      reorderableColumns: true,
      columnOrder: order
    ) {
      // The handler MUST live inside the component's braces. Written on an
      // indented line after the closing paren instead — the form the language
      // reference shows for DataGrid's `selectionChange` — it compiles to
      // `parentEl.addEventListener("columnorderchange", …)`, a DOM listener
      // that nothing ever dispatches: `emit()` in a `component` lowers to
      // `props.onColumnOrderChange?.(…)`, not a CustomEvent. It fails silently,
      // and the grid still reorders its own header, so only an assertion on
      // what was EMITTED catches it.
      on columnOrderChange(keys): {
        order = keys
        lastEmitted = keys
      }
    }

    // Read by the test rather than scraping the DOM twice.
    block {
      data-testid: "emitted"
      text(lastEmitted |> join(","))
    }
  }
}

// A second host with a grouped run (b + c share group "Q"), for the
// segment-constraint test. Declared here rather than mounted with raw props
// so the group actually goes through the .spec's segment machinery.
surface GroupedReorderHost {
  @state {
    order: []
    lastEmitted: []
  }

  block {
    width: 900px

    DataGrid(
      columns: [
        { key: "a", header: "Alpha", width: 150, sortable: true },
        { key: "b", header: "Bravo", width: 150, sortable: true, group: "Q" },
        { key: "c", header: "Charlie", width: 150, sortable: true, group: "Q" },
        { key: "d", header: "Delta", width: 150, sortable: true }
      ],
      rows: [{ id: 1, a: "a1", b: "b1", c: "c1", d: "d1" }],
      reorderableColumns: true,
      columnOrder: order
    ) {
      on columnOrderChange(keys): {
        order = keys
        lastEmitted = keys
      }
    }

    block {
      data-testid: "emitted"
      text(lastEmitted |> join(","))
    }
  }
}
