// SpecRuntime.swift — Minimal helpers for Spec-compiled pure functions.
// Drop this file into your Xcode project alongside the generated Swift code.
// These bridge Spec's dynamically-typed fn model to Swift's type system.

import Foundation
import SwiftUI
import SpecRuntime

// MARK: - Theme Picker

struct SpecThemePickerView: View {
    var body: some View {
        LazyVStack(spacing: 8) {
            ForEach(SpecThemeRegistry.allThemeNames, id: \.self) { name in
                SpecThemeRow(name: name, isActive: name == ThemeManager.shared.activeTheme)
            }
        }
    }
}

private struct SpecThemeRow: View {
    let name: String
    let isActive: Bool
    private var tokens: [String: String] { SpecThemeRegistry.tokens(for: name) }

    var body: some View {
        Button {
            ThemeManager.shared.applyThemeByName(name)
        } label: {
            HStack(spacing: 12) {
                HStack(spacing: 3) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(hex: tokens["semantic.surface"] ?? "#f7f7f8"))
                        .frame(width: 20, height: 28)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(hex: tokens["semantic.interactive"] ?? "#3b82f6"))
                        .frame(width: 20, height: 28)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(hex: tokens["semantic.text-primary"] ?? "#202732"))
                        .frame(width: 20, height: 28)
                }
                .padding(4)
                .background(Color(hex: tokens["semantic.background"] ?? "#f7f7f8"), in: RoundedRectangle(cornerRadius: 6))

                VStack(alignment: .leading, spacing: 2) {
                    Text(name.capitalized.replacingOccurrences(of: "-", with: " "))
                        .font(.body.weight(.medium))
                        .foregroundStyle(.primary)
                    if isActive {
                        Text("Active").font(.caption).foregroundStyle(.blue)
                    }
                }
                Spacer()
                if isActive {
                    Image(systemName: "checkmark.circle.fill").foregroundStyle(.blue).font(.title3)
                }
            }
            .padding(12)
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Chart (Swift Charts)

import Charts

/// Wraps Swift Charts to render line, bar, area, pie, and donut charts from Spec data.
struct SpecChartView: View {
    let type: String
    let data: Any
    let xKey: String
    let yKey: String
    let labelKey: String
    let valueKey: String
    let series: Any
    let color: String
    let colors: Any
    let title: String
    let height: CGFloat
    let showGrid: Bool
    let showValues: Bool
    let showLegend: Bool

    private var rows: [[String: Any]] { data as? [[String: Any]] ?? [] }
    private var colorList: [String] {
        if let arr = colors as? [Any] { return arr.compactMap { $0 as? String } }
        return []
    }
    private static let defaultColors: [Color] = [.indigo, .green, .orange, .red, .blue, .purple, .pink, .teal, .yellow, .mint]
    private func chartColor(_ index: Int) -> Color {
        if index < colorList.count, let hex = colorList[index] as String? { return Color(hex: hex) }
        if !color.isEmpty && index == 0 { return Color(hex: color) }
        return Self.defaultColors[index % Self.defaultColors.count]
    }

    private var seriesList: [(key: String, label: String, color: Color)] {
        if let arr = series as? [[String: Any]], !arr.isEmpty {
            return arr.enumerated().map { i, s in
                (key: s["key"] as? String ?? "y",
                 label: s["label"] as? String ?? s["key"] as? String ?? "Series \(i)",
                 color: (s["color"] as? String).map { Color(hex: $0) } ?? chartColor(i))
            }
        }
        return [(key: yKey, label: yKey, color: chartColor(0))]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !title.isEmpty {
                Text(title).font(.headline)
            }
            Group {
                switch type {
                case "pie", "donut":
                    pieChart
                default:
                    cartesianChart
                }
            }
            .frame(height: height > 0 ? height : 300)

            if showLegend && (type == "pie" || type == "donut" || seriesList.count > 1) {
                legendBar
            }
        }
    }

    // MARK: - Cartesian (line, bar, area)

    @ViewBuilder
    private var cartesianChart: some View {
        Chart {
            ForEach(Array(rows.enumerated()), id: \.offset) { idx, row in
                let xVal = specString(row[xKey])
                ForEach(Array(seriesList.enumerated()), id: \.offset) { sIdx, s in
                    let yVal = (row[s.key] as? Double) ?? (row[s.key] as? Int).map(Double.init) ?? 0
                    switch type {
                    case "bar":
                        BarMark(x: .value(xKey, xVal), y: .value(s.label, yVal))
                            .foregroundStyle(s.color)
                            .position(by: .value("Series", s.label))
                    case "area":
                        AreaMark(x: .value(xKey, xVal), y: .value(s.label, yVal))
                            .foregroundStyle(s.color.opacity(0.3))
                        LineMark(x: .value(xKey, xVal), y: .value(s.label, yVal))
                            .foregroundStyle(s.color)
                    default: // line
                        LineMark(x: .value(xKey, xVal), y: .value(s.label, yVal))
                            .foregroundStyle(s.color)
                            .symbol(Circle())
                    }
                    if showValues {
                        PointMark(x: .value(xKey, xVal), y: .value(s.label, yVal))
                            .annotation(position: .top) {
                                Text(specString(yVal)).font(.caption2).foregroundStyle(.secondary)
                            }
                    }
                }
            }
        }
        .chartXAxis { AxisMarks(values: .automatic) { _ in AxisValueLabel(); if showGrid { AxisGridLine() } } }
        .chartYAxis { AxisMarks { _ in AxisValueLabel(); if showGrid { AxisGridLine() } } }
    }

    // MARK: - Pie / Donut

    @ViewBuilder
    private var pieChart: some View {
        Chart {
            ForEach(Array(rows.enumerated()), id: \.offset) { idx, row in
                let label = specString(row[labelKey])
                let value = (row[valueKey] as? Double) ?? (row[valueKey] as? Int).map(Double.init) ?? 0
                SectorMark(angle: .value(label, value), innerRadius: type == "donut" ? .ratio(0.5) : .ratio(0), angularInset: 1.5)
                    .foregroundStyle(chartColor(idx))
                    .annotation(position: .overlay) {
                        if showValues {
                            Text(specString(value)).font(.caption2.bold()).foregroundStyle(.white)
                        }
                    }
            }
        }
    }

    // MARK: - Legend

    @ViewBuilder
    private var legendBar: some View {
        let items: [(label: String, color: Color)] = {
            if type == "pie" || type == "donut" {
                return rows.enumerated().map { i, row in (specString(row[labelKey]), chartColor(i)) }
            }
            return seriesList.map { ($0.label, $0.color) }
        }()
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 4) {
            ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                HStack(spacing: 4) {
                    Circle().fill(item.color).frame(width: 8, height: 8)
                    Text(item.label).font(.caption).foregroundStyle(.secondary)
                }
            }
        }
    }
}

// MARK: - Badge & Alert helpers

func specBadgeForeground(_ variant: String) -> Color {
    switch variant {
    case "success": return .green
    case "warning": return .orange
    case "error": return .red
    case "info": return .blue
    default: return .secondary
    }
}

func specBadgeBackground(_ variant: String) -> Color {
    switch variant {
    case "success": return .green.opacity(0.12)
    case "warning": return .orange.opacity(0.12)
    case "error": return .red.opacity(0.12)
    case "info": return .blue.opacity(0.12)
    default: return Color(.tertiarySystemFill)
    }
}

func specAlertIcon(_ severity: String) -> String {
    switch severity {
    case "error": return "exclamationmark.triangle.fill"
    case "warning": return "exclamationmark.circle.fill"
    case "success": return "checkmark.circle.fill"
    default: return "info.circle.fill"
    }
}

func specAlertColor(_ severity: String) -> Color {
    switch severity {
    case "error": return .red
    case "warning": return .orange
    case "success": return .green
    default: return .blue
    }
}

// MARK: - Native Status/Priority Pills

// MARK: - Icon Mapping (Lucide → SF Symbols)

/// Maps Lucide icon names (used in Spec) to SF Symbols equivalents.
func specIconName(_ lucide: String) -> String {
    let map: [String: String] = [
        // Navigation & Actions
        "home": "house.fill",
        "arrow-left": "chevron.left",
        "arrow-right": "chevron.right",
        "plus": "plus",
        "edit": "pencil",
        "check": "checkmark",
        "check-circle": "checkmark.circle.fill",
        "circle": "circle",
        "x": "xmark",
        "menu": "line.3.horizontal",
        "search": "magnifyingglass",

        // Content
        "list": "list.bullet",
        "clipboard": "doc.on.clipboard",
        "layout": "rectangle.grid.2x2",
        "eye": "eye.fill",
        "star": "star.fill",
        "user": "person.fill",
        "globe": "globe",
        "info": "info.circle.fill",
        "settings": "gearshape.fill",
        "monitor": "desktopcomputer",

        // Status & Feedback
        "alert-triangle": "exclamationmark.triangle.fill",
        "bell": "bell.fill",
        "loader": "arrow.triangle.2.circlepath",
        "clock": "clock.fill",
        "zap": "bolt.fill",
        "activity": "waveform.path.ecg",

        // Charts & Data
        "bar-chart": "chart.bar.fill",
        "palette": "paintpalette.fill",
    ]
    return map[lucide] ?? lucide
}

struct SpecStatusPill: View {
    let status: String
    private var label: String {
        switch status {
        case "done": return "Done"
        case "in-progress": return "In Progress"
        case "todo": return "Todo"
        default: return status.capitalized
        }
    }
    private var color: Color {
        switch status {
        case "done": return .green
        case "in-progress": return .orange
        default: return .gray
        }
    }
    var body: some View {
        Text(label)
            .font(.caption2.bold())
            .foregroundStyle(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(color.opacity(0.12), in: Capsule())
    }
}

struct SpecStatCard: View {
    let title: String
    let value: Any?
    var total: Any? = nil
    let color: Color
    let icon: String
    var gradientFrom: Color = Color.blue.opacity(0.1)
    var gradientTo: Color = Color.blue.opacity(0.2)

    private var count: Int {
        if let d = value as? Double { return Int(d) }
        if let i = value as? Int { return i }
        return 0
    }
    private var totalCount: Int? {
        guard let t = total else { return nil }
        if let d = t as? Double { return Int(d) }
        if let i = t as? Int { return i }
        return nil
    }
    private var percentage: String? {
        guard let t = totalCount, t > 0 else { return nil }
        return "\(count * 100 / t)%"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(color)
                Spacer()
                if let pct = percentage {
                    Text(pct)
                        .font(.caption.bold())
                        .foregroundStyle(color)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(color.opacity(0.12), in: Capsule())
                }
            }
            Text("\(count)")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)
            HStack(spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                if let tc = totalCount, tc > 0 {
                    ProgressView(value: Double(count) / Double(tc))
                        .tint(color)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                colors: [gradientFrom, gradientTo],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            in: RoundedRectangle(cornerRadius: 16)
        )
    }
}

struct SpecPriorityPill: View {
    let priority: String
    private var color: Color {
        switch priority {
        case "critical": return .red
        case "high": return .red.opacity(0.8)
        case "medium": return .orange
        default: return .gray
        }
    }
    var body: some View {
        Text(priority.capitalized)
            .font(.caption2)
            .foregroundStyle(color)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(color.opacity(0.08), in: Capsule())
    }
}

// MARK: - Extern stubs (JS functions not yet available in iOS)

/// Stub for @extern functions that reference JavaScript modules.
/// These are no-ops in the iOS target until native implementations exist.
func applyPrimaryColor(_ args: Any...) {}
func applySurfaceColors(_ args: Any...) {}
func applyTextColors(_ args: Any...) {}
func applyRadiusPreset(_ args: Any...) {}
func applyFontFamily(_ args: Any...) {}
func applyMotionPreset(_ args: Any...) {}
func applyElevationPreset(_ args: Any...) {}
func getSurfaceTint(_ args: Any...) -> Any { return "#f5f5f5" }
func getTextSuggestion(_ args: Any...) -> Any { return "#333333" }
func startBuilderPreview(_ args: Any...) {}
func cancelBuilderPreview(_ args: Any...) {}
func saveBuilderAsTheme(_ args: Any...) {}
func strangerThingsTransition(_ args: Any...) {}
func switchLocale(_ args: Any...) {}

/// Get current device locale (mirrors JS navigator.language).
func getCurrentLocale() -> Any {
    return Locale.current.language.languageCode?.identifier ?? "en"
}

/// Safely convert Any/Optional to a display string, unwrapping optionals.
func specString(_ val: Any?) -> String {
    guard let v = val else { return "" }
    if let s = v as? String { return s }
    if let d = v as? Double {
        return d == d.rounded() ? String(Int(d)) : String(d)
    }
    if let b = v as? Bool { return b ? "true" : "false" }
    // Unwrap nested optionals
    let mirror = Mirror(reflecting: v)
    if mirror.displayStyle == .optional {
        if let child = mirror.children.first { return specString(child.value) }
        return ""
    }
    return String(describing: v)
}

/// Convert a px-string (e.g. "240px", "16", "3.5px") or numeric value to CGFloat.
/// Handles Any values that may be String, Double, or Int at runtime.
func specPx(_ val: Any) -> CGFloat {
    if let d = val as? Double { return CGFloat(d) }
    if let i = val as? Int { return CGFloat(i) }
    if let s = val as? String {
        // Strip "px" suffix if present, then parse
        let trimmed = s.hasSuffix("px") ? String(s.dropLast(2)) : s
        if let d = Double(trimmed) { return CGFloat(d) }
    }
    return CGFloat(0)
}

/// Safely convert Any to Double — handles Int, Double, String, and Optional.
func specDouble(_ val: Any?) -> Double {
    guard let v = val else { return 0 }
    if let d = v as? Double { return d }
    if let i = v as? Int { return Double(i) }
    if let s = v as? String, let d = Double(s) { return d }
    // Unwrap nested Optional
    let mirror = Mirror(reflecting: v)
    if mirror.displayStyle == .optional, let child = mirror.children.first {
        return specDouble(child.value)
    }
    return 0
}

/// Create a regex pattern (returns the pattern string for use with specRegexTest).
func specRegex(_ pattern: Any) -> Any {
    return specString(pattern)
}

/// Test if a string matches a regex pattern. regex.test(value) in JS.
func specRegexTest(_ pattern: Any, _ value: Any) -> Bool {
    let pat = specString(pattern)
    let str = specString(value)
    guard let regex = try? NSRegularExpression(pattern: pat) else { return false }
    let range = NSRange(str.startIndex..., in: str)
    return regex.firstMatch(in: str, range: range) != nil
}

/// Dynamic addition: supports String concatenation and numeric addition.
func specAdd(_ a: Any, _ b: Any) -> Any {
    if let sa = a as? String { return sa + String(describing: b) }
    if let sb = b as? String { return String(describing: a) + sb }
    if let na = a as? Double, let nb = b as? Double { return na + nb }
    return String(describing: a) + String(describing: b)
}

/// Length of a string or array.
func specLength(_ val: Any) -> Double {
    if let s = val as? String { return Double(s.count) }
    if let a = val as? [Any] { return Double(a.count) }
    return 0.0
}

/// Substring extraction (0-based indices).
func specSlice(_ val: Any, _ start: Any, _ end: Any? = nil) -> Any {
    // Safe conversion to Int
    func toInt(_ v: Any) -> Int {
        if let d = v as? Double { return Int(d) }
        if let i = v as? Int { return i }
        if let s = v as? String, let d = Double(s) { return Int(d) }
        return 0
    }

    guard let s = val as? String else {
        if let a = val as? [Any] {
            let si = toInt(start)
            let ei = end.map { toInt($0) } ?? a.count
            return Array(a[max(0, min(a.count, si))..<max(0, min(a.count, ei))])
        }
        return ""
    }
    let si = s.index(s.startIndex, offsetBy: max(0, min(s.count, toInt(start))))
    let ei: String.Index
    if let e = end {
        ei = s.index(s.startIndex, offsetBy: max(0, min(s.count, toInt(e))))
    } else {
        ei = s.endIndex
    }
    return String(s[si..<ei])
}

/// Index of needle in haystack (String or Array). Returns -1 if not found.
func specIndexOf(_ haystack: Any, _ needle: Any) -> Double {
    if let s = haystack as? String, let n = needle as? String {
        guard let range = s.range(of: n) else { return -1.0 }
        return Double(s.distance(from: s.startIndex, to: range.lowerBound))
    }
    return -1.0
}

/// Check if string/array contains a value.
func specIncludes(_ haystack: Any, _ needle: Any) -> Bool {
    if let s = haystack as? String, let n = needle as? String {
        return s.contains(n)
    }
    if let a = haystack as? [Any], let n = needle as? String {
        return a.contains { String(describing: $0) == n }
    }
    return false
}

/// Left-pad a string.
func specPadStart(_ val: Any, _ targetLen: Any, _ padChar: Any) -> Any {
    let s = val as! String
    let len = Int(targetLen as! Double)
    let pad = padChar as! String
    if s.count >= len { return s }
    let needed = len - s.count
    let padding = String(repeating: pad, count: needed)
    return String(padding.prefix(needed)) + s
}

/// Character at index.
func specCharAt(_ val: Any, _ idx: Any) -> Any {
    let s = val as! String
    let i = Int(idx as! Double)
    guard i >= 0, i < s.count else { return "" }
    return String(s[s.index(s.startIndex, offsetBy: i)])
}

/// Runtime type check (mirrors JS typeof).
func specTypeOf(_ val: Any) -> String {
    if val is String { return "string" }
    if val is Double || val is Int { return "number" }
    if val is Bool { return "boolean" }
    if val is [Any] { return "object" }  // JS: typeof [] === "object"
    if val is [String: Any] { return "object" }
    if val is NSNull || val as AnyObject === NSNull() { return "object" }
    return "undefined"
}

// MARK: - DataGrid (List-based dynamic data grid)

/// Renders a data grid with dynamic columns using a List with header row.
/// Since SwiftUI `Table` requires statically-defined `TableColumn` entries,
/// this uses a List with HStack rows to support dynamic column definitions.
struct SpecDataGridView: View {
    let columns: Any
    let rows: Any
    let selection: String
    let height: CGFloat

    private var columnDefs: [[String: Any]] {
        columns as? [[String: Any]] ?? []
    }
    private var rowData: [[String: Any]] {
        if let typedRows = rows as? [[String: Any]] { return typedRows }
        // Handle [Any] where each element needs individual casting
        if let anyRows = rows as? [Any] {
            return anyRows.compactMap { $0 as? [String: Any] }
        }
        return []
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header row
            if !columnDefs.isEmpty {
                HStack(spacing: 0) {
                    ForEach(Array(columnDefs.enumerated()), id: \.offset) { _, col in
                        let label = specString((col["header"] as Any?) ?? (col["label"] as Any?) ?? (col["key"] as Any?))
                        let w = (col["width"] as? Double).map { CGFloat($0) }
                        Text(label)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: w ?? .infinity, alignment: .leading)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 6)
                    }
                }
                .background(Color(.tertiarySystemGroupedBackground))
            }

            Divider()

            // Debug: show row count
            if rowData.isEmpty {
                Text("No data (\(specString(rows)) — cols: \(columnDefs.count))")
                    .font(.caption).foregroundStyle(.red).padding(4)
            }

            // Data rows
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(Array(rowData.enumerated()), id: \.offset) { rowIdx, row in
                        HStack(spacing: 0) {
                            ForEach(Array(columnDefs.enumerated()), id: \.offset) { _, col in
                                let key = specString(col["key"])
                                let w = (col["width"] as? Double).map { CGFloat($0) }
                                Text(specString(row[key]))
                                    .font(.subheadline)
                                    .frame(maxWidth: w ?? .infinity, alignment: .leading)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 6)
                            }
                        }
                        Divider()
                    }
                }
            }
        }
        .frame(height: height > 0 ? height : 400)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator).opacity(0.3)))
    }
}
