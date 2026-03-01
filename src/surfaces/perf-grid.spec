// PerfGrid — DataGrid 10K row performance test
// Tests: virtual scrolling, sort timing, server-loaded data, FPS measurement

source BulkProductsAPI {
  endpoint: "http://localhost:4000/api/products/bulk?count=10000"
  method: GET
  cache: 0
}

surface PerfGrid() {
  @state {
    rowCount: 10000
    rows: []
    sortTime: 0
    loadTime: 0
    isLoaded: false
    frameCount: 0
    fps: 0
    fpsRunning: false
    fpsIntervalId: null
    lastFrameTime: 0
    rafId: null
  }

  @source {
    bulkProducts: BulkProductsAPI
  }

  @computed {
    displayRows: isLoaded ? rows : (bulkProducts != null ? bulkProducts : [])
    currentRowCount: displayRows.length
    rowCountLabel: currentRowCount + " rows"
    sortTimeLabel: sortTime > 0 ? sortTime.toFixed(1) + " ms" : "—"
    loadTimeLabel: loadTime > 0 ? loadTime.toFixed(0) + " ms" : "—"
    fpsLabel: fps > 0 ? fps + " fps" : "—"
  }

  @actions {
    loadFromServer(count) {
      let t0 = performance.now()
      await fetch("http://localhost:4000/api/products/bulk?count=" + count + "&delay=0")
        .then(r => r.json())
        .then(data => {
          rows = data
          isLoaded = true
          loadTime = performance.now() - t0
        })
    }

    setRowCount(n) {
      rowCount = n
    }

    startFps() {
      if (fpsRunning) { return }
      fpsRunning = true
      frameCount = 0
      lastFrameTime = performance.now()

      let countFrames = () => {
        frameCount = frameCount + 1
        if (fpsRunning) {
          rafId = requestAnimationFrame(countFrames)
        }
      }
      rafId = requestAnimationFrame(countFrames)

      fpsIntervalId = setInterval(() => {
        let now = performance.now()
        let elapsed = (now - lastFrameTime) / 1000
        fps = Math.round(frameCount / elapsed)
        frameCount = 0
        lastFrameTime = now
      }, 1000)
    }

    stopFps() {
      fpsRunning = false
      if (rafId != null) { cancelAnimationFrame(rafId) }
      if (fpsIntervalId != null) { clearInterval(fpsIntervalId) }
      rafId = null
      fpsIntervalId = null
    }
  }

  layout: vertical, gap: spacing.5

  // Header
  block {
    padding: spacing.5
    background: gradient.header-accent
    border-radius: radius.md
    layout: vertical, gap: spacing.3

    block {
      layout: horizontal, gap: spacing.3, align: center
      Icon(name: "zap", size: icon.lg, color: semantic.interactive)
      text("Grid Performance") {
        style: type.heading-lg
        color: semantic.text-primary
        letter-spacing: "-0.02em"
      }
    }

    text("Virtual scrolling and sort performance with large datasets") {
      style: type.body-sm
      color: semantic.text-secondary
    }
  }

  // Metrics cards
  block {
    layout: grid, columns: "1fr 1fr 1fr 1fr", gap: spacing.3

    Card() {
      block {
        padding: spacing.4
        layout: vertical, gap: spacing.1
        text("Rows") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
        text(rowCountLabel) { style: type.heading-md, color: semantic.text-primary }
      }
    }

    Card() {
      block {
        padding: spacing.4
        layout: vertical, gap: spacing.1
        text("Sort Time") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
        text(sortTimeLabel) { style: type.heading-md, color: semantic.interactive }
      }
    }

    Card() {
      block {
        padding: spacing.4
        layout: vertical, gap: spacing.1
        text("Load Time") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
        text(loadTimeLabel) { style: type.heading-md, color: semantic.text-primary }
      }
    }

    Card() {
      block {
        padding: spacing.4
        layout: vertical, gap: spacing.1
        text("Frame Rate") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
        text(fpsLabel) { style: type.heading-md, color: semantic.text-primary }
      }
    }
  }

  // Controls
  block {
    layout: horizontal, gap: spacing.3, align: center
    background: semantic.surface-raised
    padding: spacing.3
    border-radius: radius.md

    text("Row count:") { style: type.label-sm, color: semantic.text-secondary }
    Button(label: "1K", variant: "secondary") { on click: setRowCount(1000) }
    Button(label: "5K", variant: "secondary") { on click: setRowCount(5000) }
    Button(label: "10K", variant: "secondary") { on click: setRowCount(10000) }
    Button(label: "50K", variant: "secondary") { on click: setRowCount(50000) }

    block {
      width: 1px
      height: 24px
      background: semantic.border
    }

    Button(label: "Load Data", variant: "primary") {
      on click: loadFromServer(rowCount)
    }

    block {
      width: 1px
      height: 24px
      background: semantic.border
    }

    Button(label: "Start FPS", variant: "secondary") { on click: startFps() }
    Button(label: "Stop FPS", variant: "secondary") { on click: stopFps() }
  }

  // Tip
  block {
    layout: horizontal, gap: spacing.2, align: center
    padding: spacing.2
    text("Tip: start FPS counter, then scroll the grid to measure frame rate") {
      style: type.body-sm
      color: semantic.text-secondary
    }
  }

  // DataGrid with virtual scrolling
  block {
    background: semantic.surface-raised
    border-radius: radius.md
    shadow: elevation.raised
    overflow: "hidden"

    DataGrid(
      rows: displayRows,
      columns: [
        { key: "id", label: "ID", width: "80px", sortable: true },
        { key: "name", label: "Product Name", sortable: true, filterable: true },
        { key: "category", label: "Category", sortable: true, filterable: true },
        { key: "price", label: "Price", sortable: true, format: "currency" },
        { key: "stock", label: "Stock", sortable: true },
        { key: "status", label: "Status", sortable: true, filterable: true },
        { key: "rating", label: "Rating", sortable: true },
        { key: "sku", label: "SKU" }
      ],
      virtual: true,
      rowHeight: 40,
      height: "500px",
      selection: "single"
    ) {
      on sort(e): {
        sortTime = e.elapsed
      }
    }
  }

  // Info panel
  block {
    padding: spacing.4
    background: semantic.surface
    border-radius: radius.md
    layout: vertical, gap: spacing.2

    text("Performance Notes") { style: type.heading-sm, color: semantic.text-primary }
    text("• Virtual scrolling renders only visible rows (~12-15 at a time regardless of dataset size)") { style: type.body-sm, color: semantic.text-secondary }
    text("• Sort is performed client-side on the full dataset — time includes Array.sort() + signal update + DOM reconciliation") { style: type.body-sm, color: semantic.text-secondary }
    text("• Data is generated server-side — load time includes network transfer + JSON parsing") { style: type.body-sm, color: semantic.text-secondary }
    text("• FPS counter uses requestAnimationFrame to measure actual paint frequency during scroll") { style: type.body-sm, color: semantic.text-secondary }
  }
}
