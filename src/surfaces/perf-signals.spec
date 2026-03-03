// PerfSignals — Signal throughput performance test
// Tests: high-frequency signal updates, multi-signal fan-out, reactive DOM binding under load

surface PerfSignals() {
  @state {
    // Single signal test
    counter: 0
    targetFrequency: 100
    actualFrequency: 0
    totalUpdates: 0
    elapsed: 0
    running: false
    intervalId: null
    measureIntervalId: null
    startTime: 0
    measureStartCount: 0
    progressValue: 0

    // Multi-signal test
    signalA: 0
    signalB: 0
    signalC: 0
    multiRunning: false
    multiIntervalId: null
    multiMeasureId: null
    multiFrequency: 0
    multiTotal: 0
    multiStartCount: 0
  }

  @computed {
    counterLabel: "" + counter
    frequencyLabel: actualFrequency + " updates/sec"
    totalLabel: "" + totalUpdates
    elapsedLabel: elapsed.toFixed(1) + "s"
    targetLabel: targetFrequency + " Hz"
    progressPercent: progressValue % 100

    signalALabel: "" + signalA
    signalBLabel: "" + signalB
    signalCLabel: "" + signalC
    signalCComputed: Math.round(Math.sin(signalA / 10) * 50 + 50)
    signalCComputedLabel: "" + signalCComputed
    multiFreqLabel: multiFrequency + " updates/sec"
    multiTotalLabel: "" + multiTotal

    statusBadge: running ? "Running" : "Stopped"
    multiStatusBadge: multiRunning ? "Running" : "Stopped"
  }

  @actions {
    setTargetFrequency(hz) {
      targetFrequency = hz
    }

    startTest() {
      if (running) { return }
      running = true
      counter = 0
      totalUpdates = 0
      actualFrequency = 0
      elapsed = 0
      progressValue = 0
      startTime = performance.now()
      measureStartCount = 0

      let interval = Math.floor(1000 / targetFrequency)
      intervalId = setInterval(() => {
        counter = counter + 1
        totalUpdates = totalUpdates + 1
        progressValue = progressValue + 1
        elapsed = (performance.now() - startTime) / 1000
      }, interval)

      measureIntervalId = setInterval(() => {
        actualFrequency = counter - measureStartCount
        measureStartCount = counter
      }, 1000)
    }

    stopTest() {
      running = false
      if (intervalId != null) { clearInterval(intervalId) }
      if (measureIntervalId != null) { clearInterval(measureIntervalId) }
      intervalId = null
      measureIntervalId = null
    }

    resetTest() {
      if (running) {
        if (intervalId != null) { clearInterval(intervalId) }
        if (measureIntervalId != null) { clearInterval(measureIntervalId) }
        intervalId = null
        measureIntervalId = null
        running = false
      }
      counter = 0
      totalUpdates = 0
      actualFrequency = 0
      elapsed = 0
      progressValue = 0
    }

    startMultiTest() {
      if (multiRunning) { return }
      multiRunning = true
      signalA = 0
      signalB = 0
      signalC = 0
      multiTotal = 0
      multiFrequency = 0
      multiStartCount = 0

      multiIntervalId = setInterval(() => {
        signalA = signalA + 1
        signalB = signalB + 3
        signalC = Math.round(Math.sin(signalA / 10) * 50 + 50)
        multiTotal = multiTotal + 3
      }, 10)

      multiMeasureId = setInterval(() => {
        multiFrequency = multiTotal - multiStartCount
        multiStartCount = multiTotal
      }, 1000)
    }

    stopMultiTest() {
      multiRunning = false
      if (multiIntervalId != null) { clearInterval(multiIntervalId) }
      if (multiMeasureId != null) { clearInterval(multiMeasureId) }
      multiIntervalId = null
      multiMeasureId = null
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
      Icon(name: "activity", size: icon.lg, color: semantic.interactive)
      text("Signal Performance") {
        style: type.heading-lg
        color: semantic.text-primary
        letter-spacing: "-0.02em"
      }
    }

    text("High-frequency signal update throughput testing") {
      style: type.body-sm
      color: semantic.text-secondary
    }
  }

  // === Single Signal Test ===
  block {
    layout: vertical, gap: spacing.4
    padding: spacing.5
    background: semantic.surface-raised
    border-radius: radius.md
    shadow: elevation.raised

    block {
      layout: horizontal, gap: spacing.3, align: center
      text("Single Signal Throughput") { style: type.heading-md, color: semantic.text-primary }
      Badge(text: statusBadge, variant: "neutral")
    }

    // Metrics row
    block {
      layout: grid, columns: "1fr 1fr 1fr 1fr 1fr", gap: spacing.3

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.1
          text("Target") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
          text(targetLabel) { style: type.heading-sm, color: semantic.text-primary }
        }
      }

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.1
          text("Actual") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
          text(frequencyLabel) { style: type.heading-sm, color: semantic.interactive }
        }
      }

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.1
          text("Counter") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
          text(counterLabel) { style: type.heading-sm, color: semantic.text-primary }
        }
      }

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.1
          text("Total") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
          text(totalLabel) { style: type.heading-sm, color: semantic.text-primary }
        }
      }

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.1
          text("Elapsed") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
          text(elapsedLabel) { style: type.heading-sm, color: semantic.text-primary }
        }
      }
    }

    // Progress bar driven by signal
    block {
      layout: vertical, gap: spacing.2
      text("Signal-driven progress (cycles 0–100)") { style: type.label-sm, color: semantic.text-secondary }
      Progress(value: progressPercent)
    }

    // Frequency selector
    block {
      layout: horizontal, gap: spacing.3, align: center

      text("Frequency:") { style: type.label-sm, color: semantic.text-secondary }
      Button(label: "100 Hz", variant: "secondary") { on click: setTargetFrequency(100) }
      Button(label: "200 Hz", variant: "secondary") { on click: setTargetFrequency(200) }
      Button(label: "500 Hz", variant: "secondary") { on click: setTargetFrequency(500) }
      Button(label: "1000 Hz", variant: "secondary") { on click: setTargetFrequency(1000) }

      block {
        width: 1px
        height: 24px
        background: semantic.border
      }

      Button(label: "Start", variant: "primary") { on click: startTest() }
      Button(label: "Stop", variant: "secondary") { on click: stopTest() }
      Button(label: "Reset", variant: "secondary") { on click: resetTest() }
    }
  }

  // === Multi-Signal Test ===
  block {
    layout: vertical, gap: spacing.4
    padding: spacing.5
    background: semantic.surface-raised
    border-radius: radius.md
    shadow: elevation.raised

    block {
      layout: horizontal, gap: spacing.3, align: center
      text("Multi-Signal Fan-Out") { style: type.heading-md, color: semantic.text-primary }
      Badge(text: multiStatusBadge, variant: "neutral")
    }

    text("Three independent signals updated at 100 Hz in a single interval — tests synchronous subscriber fan-out") {
      style: type.body-sm
      color: semantic.text-secondary
    }

    // Multi-signal metrics
    block {
      layout: grid, columns: "1fr 1fr 1fr 1fr 1fr", gap: spacing.3

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.1
          text("Signal A (linear)") { style: type.label-sm, color: semantic.text-secondary }
          text(signalALabel) { style: type.heading-sm, color: semantic.text-primary }
        }
      }

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.1
          text("Signal B (×3)") { style: type.label-sm, color: semantic.text-secondary }
          text(signalBLabel) { style: type.heading-sm, color: semantic.text-primary }
        }
      }

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.1
          text("Signal C (sine)") { style: type.label-sm, color: semantic.text-secondary }
          text(signalCComputedLabel) { style: type.heading-sm, color: semantic.interactive }
        }
      }

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.1
          text("Throughput") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
          text(multiFreqLabel) { style: type.heading-sm, color: semantic.interactive }
        }
      }

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.1
          text("Total Updates") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
          text(multiTotalLabel) { style: type.heading-sm, color: semantic.text-primary }
        }
      }
    }

    // Sine wave progress visualization
    block {
      layout: vertical, gap: spacing.2
      text("Sine wave oscillation (Signal C drives progress)") { style: type.label-sm, color: semantic.text-secondary }
      Progress(value: signalCComputed)
    }

    // Controls
    block {
      layout: horizontal, gap: spacing.3, align: center
      Button(label: "Start Multi-Signal", variant: "primary") { on click: startMultiTest() }
      Button(label: "Stop", variant: "secondary") { on click: stopMultiTest() }
    }
  }

  // Info panel
  block {
    padding: spacing.4
    background: semantic.surface
    border-radius: radius.md
    layout: vertical, gap: spacing.2

    text("How It Works") { style: type.heading-sm, color: semantic.text-primary }
    text("• signal.set() is synchronous — each call immediately notifies all subscribers") { style: type.body-sm, color: semantic.text-secondary }
    text("• DOM writes are batched at ~60fps via requestAnimationFrame, so visual updates cap at monitor refresh rate") { style: type.body-sm, color: semantic.text-secondary }
    text("• The gap between signal frequency and visual FPS demonstrates the batching efficiency") { style: type.body-sm, color: semantic.text-secondary }
    text("• Multi-signal test sets 3 signals in sequence per tick — each .set() fires independent subscriber chains") { style: type.body-sm, color: semantic.text-secondary }
  }
}
