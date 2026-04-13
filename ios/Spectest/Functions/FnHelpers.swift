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
    let yMin: Double?
    let yMax: Double?
    let connectNulls: Bool
    let colorKey: String
    let formatX: String
    let formatY: String

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

    private var seriesList: [(key: String, label: String, color: Color, dashed: Bool)] {
        if let arr = series as? [[String: Any]], !arr.isEmpty {
            return arr.enumerated().map { i, s in
                (key: s["key"] as? String ?? "y",
                 label: s["label"] as? String ?? s["key"] as? String ?? "Series \(i)",
                 color: (s["color"] as? String).map { Color(hex: $0) } ?? chartColor(i),
                 dashed: (s["dashed"] as? Bool) ?? false)
            }
        }
        return [(key: yKey, label: yKey, color: chartColor(0), dashed: false)]
    }

    /// Apply a printf-style format specifier to a number. Empty spec → default string.
    private func applyFormat(_ spec: String, _ value: Double) -> String {
        if spec.isEmpty { return specString(value) }
        return String(format: spec, value)
    }

    /// Read a numeric value from a row, returning nil if missing or NaN.
    private func readY(_ row: [String: Any], _ key: String) -> Double? {
        if let d = row[key] as? Double { return d.isNaN ? nil : d }
        if let i = row[key] as? Int { return Double(i) }
        return nil
    }

    /// Read bar color — per-bar via colorKey, falling back to series color.
    private func barColor(_ row: [String: Any], _ seriesColor: Color) -> Color {
        if !colorKey.isEmpty, let hex = row[colorKey] as? String {
            return Color(hex: hex)
        }
        return seriesColor
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

    /// Compute the effective Y domain. When yMin/yMax are unset, we derive
    /// from data (mimicking Swift Charts' automatic scaling but allowing
    /// override when the user specifies bounds).
    private var effectiveYDomain: ClosedRange<Double> {
        var allY: [Double] = []
        for row in rows {
            for s in seriesList {
                if let v = readY(row, s.key) { allY.append(v) }
            }
        }
        let dataMin = allY.min() ?? 0
        let dataMax = allY.max() ?? 1
        let lo = yMin ?? min(dataMin, 0)
        let hi = yMax ?? max(dataMax, 0)
        return lo...(hi > lo ? hi : lo + 1)
    }

    /// True when the user explicitly set yMin or yMax; suppresses auto-scale.
    private var hasExplicitYDomain: Bool { yMin != nil || yMax != nil }

    @ViewBuilder
    private var cartesianChart: some View {
        Chart {
            ForEach(Array(rows.enumerated()), id: \.offset) { idx, row in
                let xVal = specString(row[xKey])
                ForEach(Array(seriesList.enumerated()), id: \.offset) { sIdx, s in
                    // Read value; skip null points (Swift Charts naturally creates gaps)
                    if let yVal = readY(row, s.key) {
                        switch type {
                        case "bar":
                            BarMark(x: .value(xKey, xVal), y: .value(s.label, yVal))
                                .foregroundStyle(barColor(row, s.color))
                                .position(by: .value("Series", s.label))
                        case "area":
                            AreaMark(x: .value(xKey, xVal), y: .value(s.label, yVal))
                                .foregroundStyle(s.color.opacity(0.3))
                            LineMark(x: .value(xKey, xVal), y: .value(s.label, yVal))
                                .foregroundStyle(s.color)
                                .lineStyle(s.dashed ? StrokeStyle(lineWidth: 2, dash: [5, 5]) : StrokeStyle(lineWidth: 2))
                        default: // line
                            LineMark(x: .value(xKey, xVal), y: .value(s.label, yVal))
                                .foregroundStyle(s.color)
                                .lineStyle(s.dashed ? StrokeStyle(lineWidth: 2, dash: [5, 5]) : StrokeStyle(lineWidth: 2))
                                .symbol(Circle())
                        }
                        if showValues {
                            PointMark(x: .value(xKey, xVal), y: .value(s.label, yVal))
                                .annotation(position: .top) {
                                    Text(applyFormat(formatY, yVal)).font(.caption2).foregroundStyle(.secondary)
                                }
                        }
                    }
                }
            }
        }
        .chartXAxis {
            AxisMarks(values: .automatic) { value in
                if !formatX.isEmpty, let s = value.as(String.self) {
                    AxisValueLabel { Text(s) }
                } else {
                    AxisValueLabel()
                }
                if showGrid { AxisGridLine() }
            }
        }
        .chartYAxis {
            AxisMarks { value in
                if !formatY.isEmpty, let d = value.as(Double.self) {
                    AxisValueLabel { Text(applyFormat(formatY, d)) }
                } else {
                    AxisValueLabel()
                }
                if showGrid { AxisGridLine() }
            }
        }
        .modifier(SpecChartYScaleModifier(domain: hasExplicitYDomain ? effectiveYDomain : nil))
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

/// Conditionally apply chartYScale domain. When domain is nil, the view
/// passes through unchanged (Swift Charts uses automatic scaling).
struct SpecChartYScaleModifier: ViewModifier {
    let domain: ClosedRange<Double>?

    func body(content: Content) -> some View {
        if let d = domain {
            content.chartYScale(domain: d)
        } else {
            content
        }
    }
}

// MARK: - Color(hex:) helper — used by vector primitives and native components

extension Color {
    init(hex: String) {
        let h = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
        if h == "transparent" || h == "none" || h.isEmpty { self = .clear; return }
        var rgb: UInt64 = 0
        Scanner(string: h).scanHexInt64(&rgb)
        let r, g, b: Double
        if h.count == 6 {
            r = Double((rgb >> 16) & 0xFF) / 255.0
            g = Double((rgb >> 8) & 0xFF) / 255.0
            b = Double(rgb & 0xFF) / 255.0
        } else if h.count == 3 {
            r = Double((rgb >> 8) & 0xF) / 15.0
            g = Double((rgb >> 4) & 0xF) / 15.0
            b = Double(rgb & 0xF) / 15.0
        } else {
            r = 0; g = 0; b = 0
        }
        self = Color(red: r, green: g, blue: b)
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

// MARK: - HTTP / JSON

/// Async HTTP fetch — bridges spec's `fetch(url, options)` to URLSession.
/// Returns the decoded JSON body as Any (or nil on error).
@discardableResult
func fetch(_ url: Any, _ options: Any? = nil) async -> Any? {
    guard let urlStr = url as? String, let u = URL(string: urlStr) else { return nil }
    var req = URLRequest(url: u)
    if let opts = options as? [String: Any] {
        if let m = opts["method"] as? String { req.httpMethod = m }
        if let body = opts["body"] {
            if let s = body as? String { req.httpBody = s.data(using: .utf8) }
            else if let d = try? JSONSerialization.data(withJSONObject: body) { req.httpBody = d }
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if let headers = opts["headers"] as? [String: Any] {
            for (k, v) in headers { req.setValue(specString(v), forHTTPHeaderField: k) }
        }
    }
    do {
        let (data, _) = try await URLSession.shared.data(for: req)
        if data.isEmpty { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
    } catch {
        return nil
    }
}

/// Bridges JS `JSON.stringify()` and `JSON.parse()`.
enum JSON {
    static func stringify(_ value: Any?) -> String {
        guard let v = value else { return "null" }
        if let data = try? JSONSerialization.data(withJSONObject: v, options: [.fragmentsAllowed]),
           let s = String(data: data, encoding: .utf8) {
            return s
        }
        return "null"
    }
    static func parse(_ text: Any?) -> Any? {
        guard let s = specString(text).data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: s, options: [.fragmentsAllowed])
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

/// Length of a string or array (unwraps Optional<Any> first).
func specLength(_ val: Any?) -> Double {
    guard let v = _unwrapOptional(val) else { return 0 }
    if let s = v as? String { return Double(s.count) }
    if let a = v as? [Any] { return Double(a.count) }
    if let a = v as? [[String: Any]] { return Double(a.count) }
    if let d = v as? [String: Any] { return Double(d.count) }
    return 0.0
}

/// String equality on dynamic Any values — equivalent to
/// `specString(a) == specString(b)` but as a single typed call.
func specEq(_ a: Any?, _ b: Any?) -> Bool {
    return specString(a) == specString(b)
}

func specNeq(_ a: Any?, _ b: Any?) -> Bool {
    return specString(a) != specString(b)
}

/// Unwrap nested Optional<Any> wrappers so `as? [Any]` can succeed against
/// values that arrive through `Any?` pipelines (e.g. ViewModel state).
private func _unwrapOptional(_ val: Any?) -> Any? {
    guard let v = val else { return nil }
    var current: Any = v
    while true {
        let mirror = Mirror(reflecting: current)
        if mirror.displayStyle != .optional { return current }
        guard let child = mirror.children.first else { return nil }
        current = child.value
    }
}

/// Stable hashable key for a tuple of Any-typed View params, so SwiftUI's
/// `.task(id:)` can re-fire when any prop changes. Uses String(describing:)
/// because Any isn't Hashable on its own.
func specPropsKey(_ values: [Any?]) -> String {
    return values.map { specString($0) }.joined(separator: "\u{1f}")
}

/// Cast Any/Any? to [Any], unwrapping nested Optionals first.
func specArr(_ val: Any?) -> [Any] {
    guard let v = _unwrapOptional(val) else { return [] }
    if let a = v as? [Any] { return a }
    if let a = v as? [[String: Any]] { return a.map { $0 as Any } }
    return []
}

/// Functional helpers — typed wrappers around Array operations so the
/// compiler doesn't have to infer through `as?` casts inside expressions.
func specFirst(_ arr: Any?, _ predicate: (Any) -> Bool) -> Any? {
    return specArr(arr).first(where: predicate)
}

func specFilter(_ arr: Any?, _ predicate: (Any) -> Bool) -> [Any] {
    return specArr(arr).filter(predicate)
}

func specMap(_ arr: Any?, _ transform: (Any) -> Any) -> [Any] {
    return specArr(arr).map(transform)
}

func specMapIndexed(_ arr: Any?, _ transform: (Any, Int) -> Any) -> [Any] {
    return specArr(arr).enumerated().map { transform($1, $0) }
}

func specSome(_ arr: Any?, _ predicate: (Any) -> Bool) -> Bool {
    return specArr(arr).contains(where: predicate)
}

func specConcat(_ a: Any?, _ b: Any?) -> [Any] {
    return specArr(a) + specArr(b)
}

/// Dynamic indexing: handles array index (Int / Double / numeric String)
/// and dictionary key (String). Returns nil if the lookup fails.
func specGet(_ obj: Any?, _ key: Any?) -> Any? {
    guard let unwrapped = _unwrapOptional(obj), let key = _unwrapOptional(key) else { return nil }
    // Dictionary lookup by String key
    if let dict = unwrapped as? [String: Any] {
        if let s = key as? String { return dict[s] }
        return dict[String(describing: key)]
    }
    // Array lookup by numeric index
    if let arr = unwrapped as? [Any] {
        var idx: Int? = nil
        if let i = key as? Int { idx = i }
        else if let d = key as? Double { idx = Int(d) }
        else if let s = key as? String, let d = Double(s) { idx = Int(d) }
        if let i = idx, i >= 0, i < arr.count { return arr[i] }
    }
    if let arr = unwrapped as? [[String: Any]] {
        var idx: Int? = nil
        if let i = key as? Int { idx = i }
        else if let d = key as? Double { idx = Int(d) }
        if let i = idx, i >= 0, i < arr.count { return arr[i] }
    }
    return nil
}

/// Substring extraction (0-based indices).
func specSlice(_ val: Any?, _ start: Any, _ end: Any? = nil) -> Any {
    // Safe conversion to Int
    func toInt(_ v: Any) -> Int {
        if let d = v as? Double { return Int(d) }
        if let i = v as? Int { return i }
        if let s = v as? String, let d = Double(s) { return Int(d) }
        return 0
    }
    // Unwrap nested Optional<Any> wrappers first
    guard let v = _unwrapOptional(val) else { return "" }

    if let s = v as? String {
        let si = s.index(s.startIndex, offsetBy: max(0, min(s.count, toInt(start))))
        let ei: String.Index
        if let e = end {
            ei = s.index(s.startIndex, offsetBy: max(0, min(s.count, toInt(e))))
        } else {
            ei = s.endIndex
        }
        return String(s[si..<ei])
    }
    // Use specArr so [[String: Any]] works too
    let a = specArr(v)
    let si = toInt(start)
    let ei = end.map { toInt($0) } ?? a.count
    return Array(a[max(0, min(a.count, si))..<max(0, min(a.count, ei))])
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

// MARK: - SpecRow (Identifiable wrapper for Table)

/// Wraps a `[String: Any]` row for use with SwiftUI `Table`, which
/// requires `Identifiable` conformance.
struct SpecRow: Identifiable {
    let id: String
    let data: [String: Any]
    subscript(key: String) -> Any? { data[key] }

    /// Convert a dynamic array of rows into SpecRow instances.
    static func wrap(_ rows: Any?, idField: String = "id") -> [SpecRow] {
        return specArr(rows).enumerated().map { idx, item in
            if let dict = item as? [String: Any] {
                let rowId = specString(dict[idField] ?? idx)
                return SpecRow(id: rowId, data: dict)
            }
            return SpecRow(id: "\(idx)", data: [:])
        }
    }
}
