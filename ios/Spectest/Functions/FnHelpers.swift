// SpecRuntime.swift — Minimal helpers for Spec-compiled pure functions.
// Drop this file into your Xcode project alongside the generated Swift code.
// These bridge Spec's dynamically-typed fn model to Swift's type system.

import Foundation
import SwiftUI
import os
@_exported import SpecRuntime

// MARK: - Navigation stub

/// The global navigate() and navigateReplace() a page that is not the @router
/// surface calls, as the web's are module-level (Vector #3843). Both write
/// SpecRouteStore, which the router's view reads and a native shell watches
/// (`revision`), so the screen moves. This used to be a no-op, and
/// navigateReplace() had no global at all, so a page calling it did not build.
@MainActor func navigate(_ path: Any) { specNavigate(path) }
@MainActor func navigateReplace(_ path: Any) { specNavigate(path, replace: true) }

/// One navigate(), from the router or any page: the bare path, the params its
/// patterns capture and the parsed query, written to SpecRouteStore in one
/// step. `routes` is the router's own table; a page passes none and the table
/// the router registered is used. `replace` keeps no entry for back().
@MainActor func specNavigate(_ to: Any, _ routes: [(String, [String])]? = nil, replace: Bool = false) {
    let store = SpecRouteStore.shared
    let bare = specRouteBarePath(to)
    store.go(target: specString(to), path: bare, params: specRouteParams(bare, routes ?? store.routes),
             query: specRouteQuery(to), replace: replace)
}

/// The path a route compares: a navigate() target with its query and hash cut
/// off, as the web's `_specNavigate` stores `_routePath` (Vector #3646).
/// `/page?id=3#top` → `/page`; a path with neither is returned as is.
func specRouteBarePath(_ target: Any?) -> String {
    let s = specString(target)
    if let cut = s.firstIndex(where: { $0 == "?" || $0 == "#" }) { return String(s[..<cut]) }
    return s
}

/// A navigate() target's query as `_routeQuery` holds it on the web
/// (`URLSearchParams`): `+` is a space, `%xx` decoded, a key with no `=` is
/// "", the last of a repeated key wins. The hash is not part of it, and a `?`
/// after the `#` belongs to the hash.
func specRouteQuery(_ target: Any?) -> [String: Any] {
    let s = specString(target)
    var out: [String: Any] = [:]
    guard let q = s.firstIndex(of: "?") else { return out }
    if let h = s.firstIndex(of: "#"), h < q { return out }
    var query = s[s.index(after: q)...]
    if let h = query.firstIndex(of: "#") { query = query[..<h] }
    func decode(_ part: Substring) -> String {
        let spaced = part.replacingOccurrences(of: "+", with: " ")
        return spaced.removingPercentEncoding ?? spaced
    }
    for pair in query.split(separator: "&") {
        let kv = pair.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false)
        out[decode(kv[0])] = kv.count > 1 ? decode(kv[1]) : ""
    }
    return out
}

/// `_routeParams` for a bare path, as the web's `_matchRoute` fills it: the
/// first @router pattern whose regex matches gives its `:name` captures, and
/// a path no pattern matches gives none (Vector #3654). `routes` is the table
/// the emitter builds (`swiftRouteTable`), the same regexes the web uses.
func specRouteParams(_ path: String, _ routes: [(String, [String])]) -> [String: Any] {
    let ns = path as NSString
    for (pattern, names) in routes {
        guard let re = try? NSRegularExpression(pattern: pattern),
              let m = re.firstMatch(in: path, range: NSRange(location: 0, length: ns.length)) else { continue }
        var out: [String: Any] = [:]
        for (i, name) in names.enumerated() where i + 1 < m.numberOfRanges {
            let r = m.range(at: i + 1)
            if r.location != NSNotFound { out[name] = ns.substring(with: r) }
        }
        return out
    }
    return [:]
}

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
        // Handle rgba(r, g, b, a) CSS format
        if hex.hasPrefix("rgba(") {
            let inner = hex.dropFirst(5).dropLast(1) // strip "rgba(" and ")"
            let parts = inner.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            if parts.count >= 4,
               let r = Double(parts[0]), let g = Double(parts[1]),
               let b = Double(parts[2]), let a = Double(parts[3]) {
                self = Color(.sRGB, red: r / 255.0, green: g / 255.0, blue: b / 255.0, opacity: a)
                return
            }
            self = .clear; return
        }
        // Handle rgb(r, g, b) CSS format
        if hex.hasPrefix("rgb(") {
            let inner = hex.dropFirst(4).dropLast(1)
            let parts = inner.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            if parts.count >= 3,
               let r = Double(parts[0]), let g = Double(parts[1]), let b = Double(parts[2]) {
                self = Color(.sRGB, red: r / 255.0, green: g / 255.0, blue: b / 255.0, opacity: 1.0)
                return
            }
            self = .clear; return
        }
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
            // Unknown format — clear instead of black
            self = .clear; return
        }
        self = Color(red: r, green: g, blue: b)
    }
}

// MARK: - Borders

/// One line of a CSS `border` shorthand, parsed.
struct SpecBorderSpec {
    var width: CGFloat
    var style: String
    var color: Color
}

private let specBorderStyleWords: Set<String> = [
    "solid", "dashed", "dotted", "double", "groove", "ridge", "inset", "outset",
    "none", "hidden",
]

/// Split a CSS value on whitespace, keeping parenthesised groups whole.
///
/// `rgba(0, 0, 0, 0.1)` is ONE token. Splitting on spaces alone turns it into
/// four, and the colour of every translucent border becomes unparseable — which
/// is the common case for a hairline rule, not an exotic one.
func specCssTokens(_ value: String) -> [String] {
    var out: [String] = []
    var cur = ""
    var depth = 0
    for ch in value {
        if ch == "(" { depth += 1; cur.append(ch) }
        else if ch == ")" { depth -= 1; cur.append(ch) }
        else if (ch == " " || ch == "\t") && depth == 0 {
            if !cur.isEmpty { out.append(cur); cur = "" }
        } else { cur.append(ch) }
    }
    if !cur.isEmpty { out.append(cur) }
    return out
}

/// Parse a CSS border shorthand — `1px solid #e2e8f0`, `2px dashed rgba(…)`,
/// `none`. Order-independent, because CSS is.
func specParseBorder(_ value: Any?) -> SpecBorderSpec {
    // ONLY A STRING. Deliberately not `specString(value)`, whose last resort is
    // `Mirror(reflecting:)` — and reflecting a theme `TokenValue` enum here
    // crashed the app outright (EXC_BAD_ACCESS on the stack guard page, the
    // stack exhausted inside swift_getTypeByMangledName) rather than drawing
    // the wrong border.
    //
    // A border whose value is not text cannot be drawn, and the honest answer
    // to that is no border. The emitter is responsible for passing the declared
    // string — see emitBorderVal — and this is the backstop that keeps the next
    // mistake of that shape a missing hairline instead of a dead app.
    let raw = (value as? String ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    if raw.isEmpty || raw == "none" {
        return SpecBorderSpec(width: 0, style: "none", color: .clear)
    }
    var width: CGFloat = 1
    var style = "solid"
    var colorParts: [String] = []
    for token in specCssTokens(raw) {
        let lower = token.lowercased()
        if specBorderStyleWords.contains(lower) { style = lower; continue }
        if lower.hasSuffix("px"), let n = Double(lower.dropLast(2)) {
            width = CGFloat(n); continue
        }
        if colorParts.isEmpty, !lower.hasPrefix("#"), let n = Double(lower) {
            width = CGFloat(n); continue
        }
        colorParts.append(token)
    }
    if style == "none" || style == "hidden" {
        return SpecBorderSpec(width: 0, style: style, color: .clear)
    }
    let color = colorParts.isEmpty ? Color.clear : Color(hex: colorParts.joined(separator: " "))
    return SpecBorderSpec(width: width, style: style, color: color)
}

/// The SwiftUI dash pattern for a border style. Empty means a solid line.
func specBorderDash(_ spec: SpecBorderSpec) -> [CGFloat] {
    switch spec.style {
    case "dashed": return [spec.width * 3, spec.width * 2]
    case "dotted": return [spec.width, spec.width * 2]
    default: return []
    }
}

// MARK: - One-side borders: the twin of runtime-android's BorderMath.kt

/// The four sides (top, right, bottom, left) once any of `border-top` /
/// `-right` / `-bottom` / `-left` is set: each side's own value where it has
/// one, else the `border` shorthand's, as the CSS cascade merges a later side
/// over the shorthand. A side set to `none` (or no width) draws nothing. A
/// side that is '' is the shorthand's, the web's `bindBorder` rule. Nil when
/// no side is set, so the shorthand alone draws as one border (Vector #2743).
func specMergeBorderSides(_ border: Any?, _ top: Any?, _ right: Any?, _ bottom: Any?, _ left: Any?) -> [SpecBorderSpec?]? {
    func given(_ v: Any?) -> String? {
        guard let s = v as? String, !s.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return nil }
        return s
    }
    let sides = [top, right, bottom, left].map(given)
    if sides.allSatisfy({ $0 == nil }) { return nil }
    func drawn(_ v: Any?) -> SpecBorderSpec? {
        let b = specParseBorder(v)
        return b.width > 0 ? b : nil
    }
    let all = drawn(border)
    return sides.map { $0 != nil ? drawn($0) : all }
}

/// Corner radii (top-left, top-right, bottom-right, bottom-left) scaled down
/// together until each pair fits its side, as CSS does: 9999 on a 20pt box
/// is 10, a circle.
func specClampBorderRadii(_ w: CGFloat, _ h: CGFloat, _ radii: [CGFloat]) -> [CGFloat] {
    let r = (0..<4).map { $0 < radii.count ? max(radii[$0], 0) : 0 }
    var f: CGFloat = 1
    func fit(_ len: CGFloat, _ sum: CGFloat) { if sum > 0 { f = min(f, len / sum) } }
    fit(w, r[0] + r[1]); fit(w, r[3] + r[2]); fit(h, r[0] + r[3]); fit(h, r[1] + r[2])
    return r.map { $0 * f }
}

/// One piece of a side's stroke centerline. Degrees, 0 = +x, clockwise (y down).
enum SpecBorderSeg: Equatable {
    case line(CGPoint, CGPoint)
    case arc(CGPoint, CGFloat, CGFloat, CGFloat)  // center, radius, start, sweep
}

/// The centerline of `side`'s stroke (0 top, 1 right, 2 bottom, 3 left) on a
/// `w` x `h` box, `inset` from the edge (half the stroke width). A side owns
/// the half of each corner arc next to it and the straight run between, so
/// on a circle each side is the 90° arc centered on it. A corner no rounder
/// than `inset` is square: the side runs out to the box edge there.
func specBorderSideSegments(_ side: Int, _ w: CGFloat, _ h: CGFloat, _ radii: [CGFloat], _ inset: CGFloat) -> [SpecBorderSeg] {
    let r = specClampBorderRadii(w, h, radii)
    let round = r.map { $0 > inset }
    let cx = [r[0], w - r[1], w - r[2], r[3]]
    let cy = [r[0], r[1], h - r[2], h - r[3]]
    func arc(_ c: Int, _ start: CGFloat) -> SpecBorderSeg? {
        round[c] ? .arc(CGPoint(x: cx[c], y: cy[c]), r[c] - inset, start, 45) : nil
    }
    func line(_ x0: CGFloat, _ y0: CGFloat, _ x1: CGFloat, _ y1: CGFloat) -> SpecBorderSeg? {
        .line(CGPoint(x: x0, y: y0), CGPoint(x: x1, y: y1))
    }
    let segs: [SpecBorderSeg?]
    switch side {
    case 0: segs = [arc(0, 225), line(round[0] ? cx[0] : 0, inset, round[1] ? cx[1] : w, inset), arc(1, 270)]
    case 1: segs = [arc(1, 315), line(w - inset, round[1] ? cy[1] : 0, w - inset, round[2] ? cy[2] : h), arc(2, 0)]
    case 2: segs = [arc(2, 45), line(round[2] ? cx[2] : w, h - inset, round[3] ? cx[3] : 0, h - inset), arc(3, 90)]
    default: segs = [arc(3, 135), line(inset, round[3] ? cy[3] : h, inset, round[0] ? cy[0] : 0), arc(0, 180)]
    }
    // Drop a run of no length; join two arcs that continue one another (a circle's side).
    var out: [SpecBorderSeg] = []
    for s in segs.compactMap({ $0 }) {
        if case let .line(a, b) = s, a == b { continue }
        if case let .arc(c, rr, start, sweep) = s, case let .arc(pc, pr, pstart, psweep)? = out.last,
           pc == c, pr == rr, abs((pstart + psweep - start).truncatingRemainder(dividingBy: 360)) < 0.001 {
            out[out.count - 1] = .arc(c, rr, pstart, psweep + sweep)
            continue
        }
        out.append(s)
    }
    return out
}

/// One side's stretch of a rounded box's outline, as a stroke centerline, so
/// it can carry its own color and dash (the charter active-leg card draws its
/// route as `border-top: 2px dashed …`).
struct SpecBorderSidePath: Shape {
    let side: Int
    let radius: CGFloat
    let inset: CGFloat
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let o = rect.origin
        for s in specBorderSideSegments(side, rect.width, rect.height, [radius, radius, radius, radius], inset) {
            switch s {
            case let .line(a, b):
                let from = CGPoint(x: o.x + a.x, y: o.y + a.y)
                if p.isEmpty { p.move(to: from) } else { p.addLine(to: from) }
                p.addLine(to: CGPoint(x: o.x + b.x, y: o.y + b.y))
            case let .arc(c, r, start, sweep):
                // y runs down, so an increasing angle turns clockwise on
                // screen, which is SwiftUI's `clockwise: false`.
                p.addArc(center: CGPoint(x: o.x + c.x, y: o.y + c.y), radius: r,
                         startAngle: .degrees(Double(start)), endAngle: .degrees(Double(start + sweep)),
                         clockwise: false)
            }
        }
        return p
    }
}

extension View {
    /// A full `border:` as a stroked overlay.
    ///
    /// `strokeBorder` rather than `stroke`: stroke straddles the edge, so half
    /// a 2px border lands outside the background it is supposed to outline.
    ///
    /// NOT `@ViewBuilder`, AND NO `if`. That is the whole reason this reads the
    /// way it does, and it is not style.
    ///
    /// A `@ViewBuilder` branch returns `_ConditionalContent<A, B>`, so every
    /// border applied to a subtree roughly DOUBLES the size of that subtree's
    /// generic type. Vector's charter views apply these up to nine times each,
    /// and the type grew past what the runtime can instantiate: SwiftUI died in
    /// `__swift_instantiateConcreteTypeFromMangledNameV2` with EXC_BAD_ACCESS
    /// on the stack guard page — the whole app, on the first tap that mounted
    /// a catering card.
    ///
    /// An absent border is therefore drawn, as a zero-width clear stroke, which
    /// renders nothing and keeps ONE concrete return type however many times it
    /// is applied.
    func specBorderAll(_ value: Any?, radius: CGFloat = 0) -> some View {
        let spec = specParseBorder(value)
        return self.overlay(
            RoundedRectangle(cornerRadius: radius)
                .strokeBorder(
                    spec.width > 0 ? spec.color : Color.clear,
                    style: StrokeStyle(lineWidth: spec.width, dash: specBorderDash(spec))
                )
        )
    }

    /// A box with any side border (`border-top:` and friends), the shorthand
    /// beside them (Vector #2743). Each side is its own value or the
    /// shorthand's (specMergeBorderSides) and strokes its own stretch of the
    /// rounded outline in its own color, so a side follows the corners, and a
    /// transparent side (a loading Button's ring) leaves a gap instead of the
    /// shorthand's line. With every side '' at runtime the shorthand draws as
    /// specBorderAll would. Branchless for the same reason as specBorderAll:
    /// the five layers are always there, an absent one a clear zero stroke.
    /// The ROOM a side takes is a padding the emitter puts before the
    /// background (`specBorderWidth`); this draws the lines only.
    func specBorderSides(_ border: Any?, top: Any?, right: Any?, bottom: Any?, left: Any?, radius: CGFloat = 0) -> some View {
        let sides = specMergeBorderSides(border, top, right, bottom, left)
        let all = sides == nil ? specParseBorder(border) : SpecBorderSpec(width: 0, style: "none", color: .clear)
        func layer(_ i: Int) -> some View {
            let b = sides?[i] ?? SpecBorderSpec(width: 0, style: "none", color: .clear)
            return SpecBorderSidePath(side: i, radius: max(radius, 0), inset: b.width / 2)
                .stroke(b.width > 0 ? b.color : Color.clear,
                        style: StrokeStyle(lineWidth: b.width, dash: specBorderDash(b)))
        }
        return self.overlay(
            ZStack {
                RoundedRectangle(cornerRadius: max(radius, 0))
                    .strokeBorder(all.width > 0 ? all.color : Color.clear,
                                  style: StrokeStyle(lineWidth: all.width, dash: specBorderDash(all)))
                layer(0)
                layer(1)
                layer(2)
                layer(3)
            }
            // Left and right are logical on iOS, as `align:` is: a side keeps
            // to its edge in a right-to-left layout.
            .flipsForRightToLeftLayoutDirection(true)
        )
    }
}

/// How far a one-side border insets the content: its width, as on the web,
/// where a border takes room. `none` and an unreadable value are 0.
func specBorderWidth(_ value: Any?) -> CGFloat {
    max(specParseBorder(value).width, 0)
}

/// The room the `border:` shorthand takes on an edge that also has a side
/// value (Vector #2111): its width when that side is absent or '' (the
/// shorthand draws there, specMergeBorderSides' rule), else 0, since the
/// side's own padding (specBorderWidth) already holds the edge.
func specBorderShorthandWidth(_ border: Any?, unless side: Any?) -> CGFloat {
    if let s = side as? String, !s.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return 0 }
    return specBorderWidth(border)
}

// MARK: - Box shadow

/// One layer of a CSS `box-shadow`, in SwiftUI's terms.
struct SpecShadowLayer {
    var color: Color
    var radius: CGFloat
    var x: CGFloat
    var y: CGFloat
    static let none = SpecShadowLayer(color: .clear, radius: 0, x: 0, y: 0)
}

/// A CSS length in a shadow: `0`, `2px`, `-4px`. Nil for anything else.
private func specShadowLength(_ token: String) -> CGFloat? {
    let t = token.lowercased()
    if t.hasSuffix("px"), let n = Double(t.dropLast(2)) { return CGFloat(n) }
    if let n = Double(t) { return CGFloat(n) }
    return nil
}

/// Parse a CSS `box-shadow` (Vector #2095): `0 2px 8px rgba(…)`, several
/// layers separated by commas, or `none`.
///
/// What SwiftUI's `.shadow` cannot draw is left out rather than drawn wrong:
/// an `inset` layer (the grid lines are `inset -1px 0 0 #e6ebf2`), and a
/// layer with no blur and no offset, which is a pure `spread` ring (drawn as
/// a stroke instead: specParseBoxRings, Vector #2619). The CSS
/// blur is twice the Gaussian's deviation, and SwiftUI's radius reads closest
/// to the web at half the CSS blur. Only a string is read, as for borders: a
/// theme TokenValue is never reflected.
func specParseBoxShadow(_ value: Any?) -> [SpecShadowLayer] {
    var out: [SpecShadowLayer] = []
    for layer in specShadowLayers(value) {
        if layer.inset || layer.nums.count < 2 { continue }
        let blur = layer.nums.count > 2 ? max(layer.nums[2], 0) : 0
        if blur == 0 && layer.nums[0] == 0 && layer.nums[1] == 0 { continue }
        out.append(SpecShadowLayer(color: layer.color, radius: blur / 2, x: layer.nums[0], y: layer.nums[1]))
    }
    return out
}

/// One `box-shadow` layer, split into its lengths and its color.
struct SpecShadowParts {
    var nums: [CGFloat]
    var color: Color
    var inset: Bool
}

/// The layers of a CSS `box-shadow`, split at the top-level commas (a comma
/// inside `rgba(…)` is not a layer break). `none` and empty are no layers.
func specShadowLayers(_ value: Any?) -> [SpecShadowParts] {
    let raw = (value as? String ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    if raw.isEmpty || raw.lowercased() == "none" { return [] }
    var layers: [String] = []
    var cur = ""
    var depth = 0
    for ch in raw {
        if ch == "(" { depth += 1 } else if ch == ")" { depth -= 1 }
        if ch == "," && depth == 0 { layers.append(cur); cur = "" } else { cur.append(ch) }
    }
    layers.append(cur)
    var out: [SpecShadowParts] = []
    for layer in layers {
        var nums: [CGFloat] = []
        var colorParts: [String] = []
        var inset = false
        for token in specCssTokens(layer) {
            if token.lowercased() == "inset" { inset = true; continue }
            if colorParts.isEmpty, let n = specShadowLength(token) { nums.append(n); continue }
            colorParts.append(token)
        }
        let color = colorParts.isEmpty ? Color.black.opacity(0.25) : Color(hex: colorParts.joined(separator: " "))
        out.append(SpecShadowParts(nums: nums, color: color, inset: inset))
    }
    return out
}

/// A spread ring: a `box-shadow` layer with no blur and no offset
/// (`0 0 0 2px <color>`), which is how the web draws a field's error ring
/// and a chip's selection ring (Vector #2619).
struct SpecRingLayer {
    var color: Color
    var width: CGFloat
    static let none = SpecRingLayer(color: .clear, width: 0)
}

/// The spread rings of a CSS `box-shadow`, in CSS order (the first is drawn
/// on top). An inset layer, one with blur or an offset, and a spread of 0
/// are not rings: the blurred and offset ones are `.shadow`s
/// (specParseBoxShadow), and SwiftUI cannot draw their spread.
func specParseBoxRings(_ value: Any?) -> [SpecRingLayer] {
    var out: [SpecRingLayer] = []
    for layer in specShadowLayers(value) {
        if layer.inset || layer.nums.count < 4 { continue }
        let n = layer.nums
        if n[0] != 0 || n[1] != 0 || n[2] != 0 || n[3] <= 0 { continue }
        out.append(SpecRingLayer(color: layer.color, width: n[3]))
    }
    return out
}

/// One ring around a box: a rounded rectangle stroked inward by `width`,
/// pushed out by `width`, so it lies wholly outside the box edge, follows its
/// corners (radius + width, as CSS rounds a spread) and takes no room. An
/// absent ring is a zero-width clear stroke: branchless, like specBorderAll.
private func specRingShape(_ ring: SpecRingLayer, radius: CGFloat) -> some View {
    let w = max(ring.width, 0)
    return RoundedRectangle(cornerRadius: max(radius, 0) + w)
        .strokeBorder(w > 0 ? ring.color : Color.clear, lineWidth: w)
        .padding(-w)
        .allowsHitTesting(false)
}

extension View {
    /// A block's `shadow:`, drawn around the box (Vector #2095).
    ///
    /// Over a COMPOSITING GROUP, so the box casts one shadow: `.shadow` on a
    /// stack is applied to every view in it, and each line of text on a card
    /// cast its own. The emitter puts this after the rounded clip, which
    /// would otherwise cut the shadow off at the box's edge.
    ///
    /// Branchless, with two layers always applied (an absent one is clear and
    /// zero-sized), for the reason `specBorderAll` gives: a conditional view
    /// per box doubles the subtree's generic type. Vector's two-layer tokens
    /// (`shadow.card-soft`, `shadow.modal`) fit; a third layer is dropped.
    ///
    /// SPREAD RINGS (`0 0 0 2px <color>`, Vector #2619) have no `.shadow`
    /// form, so they are drawn as outset strokes over the box, up to two
    /// (the color picker's white-then-blue ring is two), after the shadows so
    /// a ring casts none of its own. `radius` is the box's corner radius.
    func specBoxShadow(_ value: Any?, radius: CGFloat = 0) -> some View {
        let layers = specParseBoxShadow(value)
        let a = layers.count > 0 ? layers[0] : SpecShadowLayer.none
        let b = layers.count > 1 ? layers[1] : SpecShadowLayer.none
        let rings = specParseBoxRings(value)
        let r1 = rings.count > 0 ? rings[0] : SpecRingLayer.none
        let r2 = rings.count > 1 ? rings[1] : SpecRingLayer.none
        return self
            .compositingGroup()
            .shadow(color: a.color, radius: a.radius, x: a.x, y: a.y)
            .shadow(color: b.color, radius: b.radius, x: b.x, y: b.y)
            // CSS paints the first layer on top, so the second goes under.
            .overlay(specRingShape(r2, radius: radius))
            .overlay(specRingShape(r1, radius: radius))
    }
}

// MARK: - Font weight

/// A CSS font-weight, resolved at runtime for a `weight:` bound to state.
/// Keep in step with `swiftFontWeight` in ir-to-swift-ui.ts, which handles
/// the static case at compile time.
func specFontWeight(_ value: Any?) -> Font.Weight {
    let weight = specString(value).trimmingCharacters(in: .whitespaces).lowercased()
    switch weight {
    case "normal": return .regular
    case "bold", "bolder": return .bold
    case "lighter": return .light
    default: break
    }
    guard let n = Double(weight) else { return .regular }
    let steps: [Font.Weight] = [.ultraLight, .thin, .light, .regular, .medium, .semibold, .bold, .heavy, .black]
    let i = min(8, max(0, Int((n / 100).rounded()) - 1))
    return steps[i]
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

/// An Alert's `tone` (info | success | warning | destructive) or a Toast's
/// `severity` (info | success | warning | error): destructive is error.
func specAlertIcon(_ severity: String) -> String {
    switch severity {
    case "error", "destructive": return "exclamationmark.triangle.fill"
    case "warning": return "exclamationmark.circle.fill"
    case "success": return "checkmark.circle.fill"
    default: return "info.circle.fill"
    }
}

func specAlertColor(_ severity: String) -> Color {
    switch severity {
    case "error", "destructive": return .red
    case "warning": return .orange
    case "success": return .green
    default: return .blue
    }
}

/// A Toast's or Snackbar's timer: `perform` runs `ms` after the banner
/// appears, and not at all if it goes away first (its `.task` is cancelled).
/// A banner shown again starts a new count, as the web's delay() does.
struct SpecAutoDismiss: ViewModifier {
    let ms: Double
    let perform: @MainActor () -> Void
    func body(content: Content) -> some View {
        content.task {
            guard ms > 0, !ms.isNaN, ms.isFinite else { return }
            try? await Task.sleep(nanoseconds: UInt64(ms * 1_000_000))
            if Task.isCancelled { return }
            await MainActor.run { perform() }
        }
    }
}

extension View {
    func specAutoDismiss(after ms: Any?, perform: @escaping @MainActor () -> Void) -> some View {
        modifier(SpecAutoDismiss(ms: specDouble(ms), perform: perform))
    }
}

// MARK: - ConfirmDialog with `loading` (Vector #2974)

/// A theme color by its `semantic.*` name without the prefix (`accent`,
/// `interactive`, `destructive`: the keys the theme registry holds), else
/// `fallback` when the app's theme has no such color.
func specThemeColor(_ key: String, _ fallback: Color) -> Color {
    if case .color(let c) = ThemeManager.shared.resolve(key) { return c }
    return fallback
}

/// A ConfirmDialog whose call site passes `loading`: a fitted bottom sheet
/// that stays up until the caller closes it. Apple's `.confirmationDialog`
/// (the shape a dialog without `loading` keeps) dismisses on every button,
/// so the W&B "Save your weight?" closed before its save began and showed
/// no "Saving…". This follows the web ConfirmDialog (ai-reference 1.67.55):
/// while `loading` both buttons are disabled, the confirm reads
/// `loadingLabel` beside a spinner, and a swipe cannot close it. A confirm
/// whose handler sets no loading closes the dialog itself, as the web does;
/// the check waits one main-actor turn, so the handler's Task runs first.
/// Cancel and a swipe run `on cancel` and close it. "Close" writes a
/// writable `open` false (`onClosed`) and hides the sheet locally, which is
/// the web's own `showing`, so an `open:` expression closes too.
struct SpecBusyConfirmDialog: View {
    let isPresented: Bool
    let title: String
    let message: String
    let confirmLabel: String
    let cancelLabel: String
    let loadingLabel: String
    let destructive: Bool
    let loading: Bool
    let isLoading: @MainActor () -> Bool
    let onConfirm: @MainActor () -> Void
    let onCancel: @MainActor () -> Void
    let onClosed: @MainActor () -> Void
    @State private var hidden = false

    var body: some View {
        Color.clear.frame(width: 0, height: 0)
            .sheet(isPresented: Binding(
                get: { isPresented && !hidden },
                set: { shown in if !shown && isPresented && !hidden { cancel() } }
            )) {
                SpecBusyConfirmPanel(title: title, message: message, confirmLabel: confirmLabel,
                                     cancelLabel: cancelLabel, loadingLabel: loadingLabel,
                                     destructive: destructive, loading: loading,
                                     confirm: confirm, cancel: cancel)
            }
            .onChange(of: isPresented) { _, now in if !now { hidden = false } }
    }

    private func close() {
        hidden = true
        onClosed()
    }

    private func cancel() {
        if isLoading() { return }
        onCancel()
        close()
    }

    private func confirm() {
        if isLoading() { return }
        onConfirm()
        Task { @MainActor in
            await Task.yield()
            if !isLoading() { close() }
        }
    }
}

/// The sheet's body: title, message, a full-width confirm over a full-width
/// Cancel, sized to its content. The confirm is filled as the web's primary
/// Button (`semantic.interactive`), or its destructive one.
struct SpecBusyConfirmPanel: View {
    let title: String
    let message: String
    let confirmLabel: String
    let cancelLabel: String
    let loadingLabel: String
    let destructive: Bool
    let loading: Bool
    let confirm: @MainActor () -> Void
    let cancel: @MainActor () -> Void
    @State private var height: CGFloat = 0

    private var confirmText: String { loading && !loadingLabel.isEmpty ? loadingLabel : confirmLabel }

    var body: some View {
        VStack(spacing: 12) {
            Text(verbatim: title).font(.headline).multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)
            if !message.isEmpty {
                Text(verbatim: message).font(.subheadline).foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            VStack(spacing: 8) {
                Button(action: { confirm() }) {
                    HStack(spacing: 8) {
                        if loading { ProgressView().tint(.white) }
                        Text(verbatim: confirmText).fontWeight(.semibold)
                    }
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, minHeight: 30)
                }
                .buttonStyle(.borderedProminent)
                .tint(destructive ? specThemeColor("destructive", .red) : specThemeColor("interactive", .accentColor))
                // Busy, not disabled: a disabled prominent button is drawn
                // nearly blank (iOS 26), and "Saving…" must stay readable.
                // It takes no taps while loading, and confirm() refuses one.
                .allowsHitTesting(!loading)
                .opacity(loading ? 0.85 : 1)
                .accessibilityLabel(Text(verbatim: confirmText))
                .accessibilityAddTraits(loading ? .updatesFrequently : [])
                Button(action: { cancel() }) {
                    Text(verbatim: cancelLabel).frame(maxWidth: .infinity, minHeight: 30)
                }
                .buttonStyle(.bordered)
                .disabled(loading)
            }
            .controlSize(.large)
            .padding(.top, 4)
        }
        .padding(.horizontal, 20)
        .padding(.top, 28)
        .padding(.bottom, 12)
        .fixedSize(horizontal: false, vertical: true)
        .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { h in
            let next = ceil(h)
            if abs(next - height) >= 1 { height = next }
        }
        .presentationDetents(height > 0 ? [.height(height)] : [.medium])
        .presentationDragIndicator(.visible)
        .interactiveDismissDisabled(loading)
    }
}

// MARK: - Snackbar (Vector #2973)

/// The web Snackbar's bar: rgb(30, 30, 30), 8 pt corners, the message in
/// white, `actionLabel` in the accent at semibold, and a × at 70% white. No
/// severity icon: that is the Toast's look, which iOS drew here before.
struct SpecSnackbarBar: View {
    let message: String
    let actionLabel: String
    let onAction: @MainActor () -> Void
    let onClose: @MainActor () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Text(verbatim: message).font(.subheadline).foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            if !actionLabel.isEmpty {
                Button(action: { onAction() }) {
                    Text(verbatim: actionLabel).font(.subheadline.weight(.semibold)).foregroundStyle(specThemeColor("accent", .accentColor))
                }
                .buttonStyle(.borderless)
            }
            Button(action: { onClose() }) {
                Text(verbatim: "\u{00D7}").font(.title3).foregroundStyle(Color.white.opacity(0.7))
                    .frame(width: 24, height: 24)
            }
            .buttonStyle(.borderless)
            .accessibilityLabel(Text(verbatim: "Close"))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(red: 30 / 255, green: 30 / 255, blue: 30 / 255), in: RoundedRectangle(cornerRadius: 8))
        .shadow(color: .black.opacity(0.25), radius: 9, y: 6)
        .environment(\.colorScheme, .dark)
    }
}

/// A mounted Snackbar. It draws nothing where it is mounted: the bar goes in
/// a window of its own at the bottom of the screen, 16 pt above the tab bar
/// or the home indicator, as the web's is `position: fixed` 16px from the
/// bottom. A Snackbar can be mounted anywhere in a screen (a row, a sheet),
/// and no view there can reach the screen's bottom edge. One bar shows at a
/// time; the newest mounted one wins, and it leaves when it unmounts.
struct SpecSnackbar: View {
    let message: String
    let actionLabel: String
    let duration: Any?
    let onAction: @MainActor () -> Void
    let onClose: @MainActor () -> Void
    @State private var token = UUID()
    @State private var closed = false

    var body: some View {
        #if canImport(UIKit)
        Color.clear.frame(width: 0, height: 0)
            .onAppear { closed = false; publish() }
            .onChange(of: message) { _, _ in publish() }
            .onChange(of: actionLabel) { _, _ in publish() }
            .onDisappear { SpecSnackbarPresenter.hide(token) }
            .specAutoDismiss(after: duration) { close() }
        #else
        if !closed {
            bar.specAutoDismiss(after: duration) { close() }
        }
        #endif
    }

    private var bar: SpecSnackbarBar {
        SpecSnackbarBar(message: message, actionLabel: actionLabel,
                        onAction: { onAction(); close() }, onClose: { close() })
    }

    /// The web's doClose: the bar goes whether or not the caller listens,
    /// then `on close` runs (and the emitter's close writes `open` false).
    private func close() {
        if closed { return }
        closed = true
        #if canImport(UIKit)
        SpecSnackbarPresenter.hide(token)
        #endif
        onClose()
    }

    #if canImport(UIKit)
    private func publish() {
        if closed { return }
        SpecSnackbarPresenter.show(token, bar)
    }
    #endif
}

#if canImport(UIKit)
/// The Snackbar's window: exactly the bar's frame, above the app's window
/// (sheets included), so the screen around it keeps its taps.
@MainActor
enum SpecSnackbarPresenter {
    private static var window: UIWindow?
    private static var host: UIHostingController<SpecSnackbarBar>?
    private static var owner: UUID?

    static func show(_ id: UUID, _ bar: SpecSnackbarBar) {
        guard let scene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive })
            ?? UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).first
        else { return }
        let fresh = owner != id || window?.isHidden != false
        owner = id
        let w: UIWindow
        if let existing = window, existing.windowScene === scene { w = existing } else {
            w = UIWindow(windowScene: scene)
            w.windowLevel = .normal + 1
            w.backgroundColor = .clear
            window = w
            host = nil
        }
        if let h = host { h.rootView = bar } else {
            let h = UIHostingController(rootView: bar)
            h.view.backgroundColor = .clear
            host = h
            w.rootViewController = h
        }
        place(w, in: scene)
        w.isHidden = false
        if fresh {
            let reduce = UIAccessibility.isReduceMotionEnabled
            w.alpha = 0
            w.transform = reduce ? .identity : CGAffineTransform(translationX: 0, y: 24)
            UIView.animate(withDuration: 0.22) { w.alpha = 1; w.transform = .identity }
            UIAccessibility.post(notification: .announcement, argument: bar.message)
        }
    }

    static func hide(_ id: UUID) {
        guard owner == id, let w = window else { return }
        owner = nil
        UIView.animate(withDuration: 0.18, animations: { w.alpha = 0 }) { _ in
            if owner == nil { w.isHidden = true }
        }
    }

    /// 16 pt in from each side and 16 pt above whatever the bottom edge
    /// holds: a visible tab bar's top, else the safe area's bottom.
    private static func place(_ w: UIWindow, in scene: UIWindowScene) {
        guard let h = host else { return }
        let appWindow = scene.windows.first(where: { $0.isKeyWindow && $0 !== w })
            ?? scene.windows.first(where: { $0 !== w && !$0.isHidden && $0.windowLevel == .normal })
        let screen = appWindow?.bounds ?? scene.screen.bounds
        var floor = screen.maxY - (appWindow?.safeAreaInsets.bottom ?? 0)
        if let root = appWindow, let bar = visibleTabBar(in: root) {
            floor = min(floor, bar.convert(bar.bounds, to: root).minY)
        }
        let width = min(screen.width - 32, 560)
        let size = h.sizeThatFits(in: CGSize(width: width, height: .greatestFiniteMagnitude))
        let height = max(ceil(size.height), 44)
        w.frame = CGRect(x: screen.minX + 16, y: floor - 16 - height, width: width, height: height)
    }

    private static func visibleTabBar(in v: UIView) -> UITabBar? {
        if let bar = v as? UITabBar, bar.window != nil, !bar.isHidden, bar.alpha > 0.01, bar.bounds.height > 0 {
            return bar
        }
        for sub in v.subviews where !sub.isHidden {
            if let bar = visibleTabBar(in: sub) { return bar }
        }
        return nil
    }
}
#endif

// MARK: - Native Status/Priority Pills

// MARK: - Icon Mapping (Lucide → SF Symbols)

/// The keyboard for a BOUND `inputMode:` (the web attribute's words), resolved
/// at runtime: numeric → the digits pad, decimal → digits with a point, tel →
/// the phone pad, email / url their keyboards, anything else the default.
#if canImport(UIKit)
func specKeyboardType(_ mode: Any?) -> UIKeyboardType {
    switch specString(_unwrapOptional(mode) ?? "") {
    case "numeric": return .numberPad
    case "decimal": return .decimalPad
    case "tel": return .phonePad
    case "email": return .emailAddress
    case "url": return .URL
    default: return .default
    }
}
#endif

#if canImport(UIKit)
/// A text field whose keystrokes stay LOCAL until typing pauses (150 ms) or
/// the field loses focus; then the binding is written once. Every emitted
/// field used to write the ViewModel on each keystroke, and a ViewModel is
/// one ObservableObject for the whole surface, so a keystroke re-evaluated a
/// 3,000-line screen and the keyboard lagged behind the thumb (the shop app's
/// squawk findings, on the phone, 2026-10-15). A Done sits above the keyboard:
/// the number pads have no Return, and a multi-line field's Return is a newline.
///
/// The debounce is the keyboard's, not the author's: an external write while
/// the field is NOT focused replaces the buffer at once, and losing focus
/// flushes before anything reads the value.
/// A text field's async per-keystroke handler, in keystroke order (Vector
/// #1881). The emitter used to start a bare Task per write, and unstructured
/// Tasks do not start in the order they were made, so an earlier keystroke's
/// handler could run last and write the older text back (the flight-school
/// Users search ended on "greg@s" after "greg@skyline" was typed). Here each
/// field (owner + call site) runs one handler at a time, and a run that a newer
/// keystroke overtook before it began is dropped: the newest text is always the
/// last one handled.
@MainActor enum SpecLatestRuns {
    static var gen: [String: Int] = [:]
    static var tail: [String: Task<Void, Never>] = [:]
}

@MainActor func specLatest(_ owner: AnyObject, file: StaticString = #fileID, line: UInt = #line, column: UInt = #column, _ run: @escaping @MainActor () async -> Void) {
    let key = "\(ObjectIdentifier(owner).hashValue):\(file):\(line):\(column)"
    let g = (SpecLatestRuns.gen[key] ?? 0) + 1
    SpecLatestRuns.gen[key] = g
    let prev = SpecLatestRuns.tail[key]
    SpecLatestRuns.tail[key] = Task { @MainActor in
        _ = await prev?.value
        guard SpecLatestRuns.gen[key] == g else { return }
        await run()
        // The newest run finished and every older one was before it: forget the field.
        if SpecLatestRuns.gen[key] == g { SpecLatestRuns.gen[key] = nil; SpecLatestRuns.tail[key] = nil }
    }
}

/// The text field holding focus, as a way to blur it before a tap's click
/// (Vector #2696). A SwiftUI Button takes no focus, so a tap on one left the
/// field focused and its `on change` waited for a later blur, after the click
/// had read the old value. Now a tap blurs it first: the field commits, its
/// blur runs, and the click after them, as the web's press blurs the input
/// before `click` and Android's SpecFocusedField does (InputCommit.kt, #2663).
/// [owner] is the field's own identity, so a field that blurs after another
/// took focus forgets nothing.
@MainActor enum SpecFocusedField {
    private static var owner: UUID?
    private static var blurIt: (() -> Bool)?

    static func focused(_ owner: UUID, blur: @escaping () -> Bool) { self.owner = owner; blurIt = blur }

    static func blurred(_ owner: UUID) { if self.owner == owner { self.owner = nil; blurIt = nil } }

    /// Blurs the focused field now. True when that queued a handler (its
    /// change or blur), which runs a beat later (SpecTextField.commit).
    static func blur() -> Bool {
        guard let b = blurIt else { return false }
        owner = nil; blurIt = nil
        return b()
    }
}

/// A tap's click (a Button's action, a clicked block's): the focused field
/// blurs first, and when that queued its change or blur the click runs after
/// them, on the same beat's delay, so it reads what they wrote (Vector #2696).
/// With no field focused, or one with nothing to say, the click runs at once.
@MainActor func specClick(_ run: @escaping () -> Void) {
    if SpecFocusedField.blur() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { run() }
    } else {
        run()
    }
}

/// A screen sheet's swipe-down dismiss (Vector #2755): the focused field
/// commits first, as for a tap (specClick), but a turn of the run loop LATER.
/// The sheet's binding is set from inside SwiftUI's own sheet update, and the
/// blur dismisses the keyboard, whose layout re-enters that update: run there,
/// it crashed the app with an exclusivity fault in SheetBridge (measured on
/// the simulator, Mx's Report Squawk sheet, 2026-10-27).
@MainActor func specSheetDismiss(_ run: @escaping () -> Void) {
    DispatchQueue.main.async { specClick(run) }
}

struct SpecTextField: View {
    let placeholder: String
    @Binding var text: String
    let autofocus: Bool
    let selectTail: Bool
    let onBlur: (() -> Void)?
    let onCommit: ((String) -> Void)?
    let maxLength: Int?
    @State private var local: String = ""
    @State private var seeded = false
    @State private var pending: Task<Void, Never>? = nil
    /// The text at the last commit, at focus, or as the page last set it.
    @State private var commitBase: String = ""
    /// This field's name in SpecFocusedField, and whether a tap's blur has
    /// already run its blur, so the focus edge that follows does not run it twice.
    @State private var focusId = UUID()
    @State private var blurRan = false
    @FocusState private var focused: Bool

    init(_ placeholder: String, text: Binding<String>, autofocus: Bool = false, selectTail: Bool = false, maxLength: Int? = nil, onBlur: (() -> Void)? = nil, onCommit: ((String) -> Void)? = nil) {
        self.placeholder = placeholder
        self._text = text
        self.autofocus = autofocus
        self.selectTail = selectTail
        self.maxLength = maxLength
        self.onBlur = onBlur
        self.onCommit = onCommit
    }

    // `maxLength:` (Vector #1441): the web input refuses the 11th character of
    // a 10-character field; here the edit lands and is cut back before it is
    // written, so the box never keeps it and the signal never holds it. A
    // negative cap is the DOM's "no limit".
    private func clipped(_ v: String) -> String {
        if let m = maxLength, m >= 0, v.count > m { return String(v.prefix(m)) }
        return v
    }

    // `on blur` (Vector #980: TimeField commits a typed time on blur). On the
    // web the input event lands before blur and both are synchronous; here
    // flush() has just written the text, and a component reading it back as a
    // PROP sees it only once SwiftUI re-renders that component. So the blur
    // runs a beat later, after the write has reached the props it reads.
    @discardableResult
    private func blurred() -> Bool {
        guard let onBlur else { return false }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { onBlur() }
        return true
    }

    // `on change` (Vector #1954): the web fires it when the user COMMITS the
    // text, Return or focus leaving, and only when it moved since the last
    // commit; `on input` is the per-keystroke one, and runs from the Binding's
    // setter. Android's SpecCommitGate (InputCommit.kt) is the same rule. A
    // beat later, like the blur, so a component reading the value back as a
    // prop sees it; and before the blur, as on the web.
    @discardableResult
    private func commit() -> Bool {
        guard let onCommit else { return false }
        flush()
        if local == commitBase { return false }
        commitBase = local
        let v = local
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { onCommit(v) }
        return true
    }

    // A tap's blur (SpecFocusedField): commit and blur now, then give up the
    // keyboard. The focus edge that follows finds nothing left to commit, and
    // blurRan keeps it from running `on blur` again.
    private func blurForTap() -> Bool {
        flush()
        let changed = commit()
        let told = blurred()
        blurRan = true
        SpecKeyboardDone.dismiss()
        return changed || told
    }

    private func focusMoved(_ f: Bool) {
        if f {
            commitBase = local
            blurRan = false
            SpecFocusedField.focused(focusId) { blurForTap() }
            if selectTail { SpecTailSelect.arm() }
            return
        }
        SpecFocusedField.blurred(focusId)
        flush(); commit()
        if blurRan { blurRan = false } else { blurred() }
    }

    var body: some View {
        TextField(placeholder, text: $local)
            .focused($focused)
            .onAppear { if !seeded { local = text; commitBase = text; seeded = true }; SpecKeyboardDone.install(); if autofocus { focused = true } }
            .onSubmit { commit() }
            // While focused, a change to `text` is usually the echo of this
            // field's own deferred write and must not stomp newer keystrokes.
            // But one that arrives with NO write in flight came from somewhere
            // else — a stepper's +/- (Vector's W&B weight pad, #832) — and
            // ignoring it left the field showing 0 under a seat that read 10.
            // A value the page sets is never a change (commitBase).
            .onChange(of: text) { v in if v != local && (!focused || pending == nil) { local = v; commitBase = v } }
            .onChange(of: local) { v in
                // Only what the user types: the web leaves a longer value the
                // page itself sets alone, and so does this.
                let c = focused ? clipped(v) : v
                if c != v { local = c; return }
                deferWrite(v)
            }
            .onChange(of: focused) { f in focusMoved(f) }
            .onChange(of: autofocus) { f in if f { focused = true } }
            // A field that goes away focused (its sheet closed) is no one's to
            // blur, but its last keystrokes, still in the write's 150 ms
            // debounce, are written: a sheet swiped away a beat after typing
            // keeps what was typed (Vector #2755).
            .onDisappear { if pending != nil { flush() }; SpecFocusedField.blurred(focusId) }
    }

    private func deferWrite(_ v: String) {
        pending?.cancel()
        pending = Task {
            try? await Task.sleep(nanoseconds: 150_000_000)
            if Task.isCancelled { return }
            await MainActor.run { if text != v { text = v }; pending = nil }
        }
    }

    private func flush() {
        pending?.cancel()
        pending = nil
        if text != local { text = local }
    }
}

/// The editable tail of a reading: the ones digit, the point and every
/// decimal ("3225.4" → the "5.4"). The web's computeTailRange, in UTF-16
/// offsets (what UITextInput counts).
func specTailRange(_ s: String) -> (Int, Int) {
    let u = Array(s.utf16)
    let len = u.count
    let dot = u.firstIndex(of: 46)
    let tail = 1 + (dot != nil ? 1 + (len - dot! - 1) : 0)
    return (max(0, len - tail), len)
}

/// `data-select-tail:` on iOS (2026-10-18): the field gained focus, so once
/// UIKit has placed the caret from the tap, select the tail on whatever holds
/// the keyboard. Through UITextInput, not a UITextField cast — the class
/// behind a SwiftUI field is the platform's business (see SpecKeyboardDone).
/// A re-tap inside an already-focused field does not re-arm, so a caret the
/// user places by hand is kept.
enum SpecTailSelect {
    static func arm() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            guard let r = SpecKeyboardDone.currentResponder() as? UITextInput,
                  let all = r.textRange(from: r.beginningOfDocument, to: r.endOfDocument),
                  let s = r.text(in: all), !s.isEmpty else { return }
            let (a, b) = specTailRange(s)
            guard let from = r.position(from: r.beginningOfDocument, offset: a),
                  let to = r.position(from: r.beginningOfDocument, offset: b) else { return }
            r.selectedTextRange = r.textRange(from: from, to: to)
        }
    }
}

/// The Done above every keyboard, hung on the UIKit responder itself
/// (2026-10-15, the third attempt). SwiftUI's keyboard toolbar came and went
/// by screen — a TabView hid it, a hidden navigation bar hid it, an
/// `if focused` inside it hid it — and the UI test that said it was there reads
/// the accessibility tree, which reports a button the screen never drew. So
/// when a keyboard rises this finds the first responder and gives it an
/// accessory bar. A responder that is neither a UITextField nor a UITextView
/// (the class behind a SwiftUI field is the platform's business, and the
/// earlier UIKit attempt died on exactly that cast without saying so) gets the
/// same bar in a window of its own, parked on the keyboard's top edge, so no
/// screen can open a keyboard with no way to close it. Installed once, by the
/// first field that appears; the responder's class chain goes to the unified
/// log so the next reader can see what the platform handed us.
enum SpecKeyboardDone {
    private static var installed = false
    private static weak var current: UIResponder?
    private static var floating: UIWindow?
    private static let log = Logger(subsystem: "spec.runtime", category: "keyboard")

    static func install() {
        if installed { return }
        installed = true
        NSLog("SpecKeyboardDone: installed")
        let nc = NotificationCenter.default
        // A UIKit field says when editing begins, keyboard or not (a hardware
        // keyboard keeps the software one off-screen and the show notification
        // with it — which is how the simulator hid the earlier attempt).
        nc.addObserver(forName: UITextField.textDidBeginEditingNotification, object: nil, queue: .main) { n in began(n.object as? UIResponder) }
        nc.addObserver(forName: UITextView.textDidBeginEditingNotification, object: nil, queue: .main) { n in began(n.object as? UIResponder) }
        nc.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { n in attach(n) }
        nc.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { n in attach(n) }
        nc.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in floating?.isHidden = true }
        // The floating bar also goes when editing ENDS or the keyboard is
        // gone, whichever notification arrives: measured 2026-10-16 in the
        // shop app's Report squawk sheet, the bar outlived the keyboard and
        // sat over the sheet's Save button, taking its taps.
        nc.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { _ in floating?.isHidden = true }
        nc.addObserver(forName: UITextField.textDidEndEditingNotification, object: nil, queue: .main) { _ in floating?.isHidden = true }
        nc.addObserver(forName: UITextView.textDidEndEditingNotification, object: nil, queue: .main) { _ in floating?.isHidden = true }
    }

    /// Resigns whatever holds the keyboard; SwiftUI's FocusState follows, and
    /// the field's local buffer flushes on that edge.
    static func dismiss() {
        floating?.isHidden = true
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    static func currentResponder() -> UIResponder? { firstResponder() }

    private static func firstResponder() -> UIResponder? {
        current = nil
        UIApplication.shared.sendAction(#selector(UIResponder.spec_reportFirstResponder(_:)), to: nil, from: nil, for: nil)
        return current
    }

    fileprivate static func report(_ r: UIResponder) { current = r }

    private static func makeBar(width: CGFloat) -> SpecDoneBar {
        let bar = SpecDoneBar(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        bar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", image: nil, primaryAction: UIAction { _ in dismiss() }),
        ]
        bar.sizeToFit()
        return bar
    }

    private static func describe(_ r: UIResponder) -> String {
        var names: [String] = []
        var x: UIResponder? = r
        while let v = x, names.count < 5 { names.append(String(describing: type(of: v))); x = v.next }
        return names.joined(separator: " > ")
    }

    /// Hangs the bar on a UIKit text field or text view; false for any other
    /// responder, which the keyboard path then covers with the floating bar.
    @discardableResult
    private static func hang(on r: UIResponder) -> Bool {
        let width = (r as? UIView)?.window?.bounds.width ?? UIScreen.main.bounds.width
        if let tf = r as? UITextField {
            if !(tf.inputAccessoryView is SpecDoneBar) { tf.inputAccessoryView = makeBar(width: width); tf.reloadInputViews() }
            floating?.isHidden = true
            return true
        }
        if let tv = r as? UITextView {
            if !(tv.inputAccessoryView is SpecDoneBar) { tv.inputAccessoryView = makeBar(width: width); tv.reloadInputViews() }
            floating?.isHidden = true
            return true
        }
        return false
    }

    private static func began(_ r: UIResponder?) {
        guard let r else { return }
        NSLog("SpecKeyboardDone: editing began in %@", describe(r))
        log.fault("SpecKeyboardDone: editing began in \(describe(r), privacy: .public)")
        hang(on: r)
    }

    private static func attach(_ n: Notification) {
        guard let r = firstResponder() else {
            NSLog("SpecKeyboardDone: a keyboard rose with no first responder")
            log.fault("SpecKeyboardDone: a keyboard rose with no first responder")
            return
        }
        NSLog("SpecKeyboardDone: keyboard %@ for %@", n.name.rawValue, describe(r))
        log.fault("SpecKeyboardDone: keyboard \(n.name.rawValue, privacy: .public) for \(describe(r), privacy: .public)")
        if hang(on: r) { return }
        guard let kb = (n.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              kb.height > 0, kb.minY < UIScreen.main.bounds.height else { return }
        showFloating(above: kb, scene: (r as? UIView)?.window?.windowScene)
    }

    /// The fallback: a 44 pt window whose bottom edge is the keyboard's top.
    /// `.normal + 1` is above the app's own window (sheets included) and well
    /// below the keyboard's, and below the status bar's, so it changes nothing
    /// about either.
    private static func showFloating(above kb: CGRect, scene: UIWindowScene?) {
        let scene = scene ?? UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }
        guard let scene else { return }
        let w: UIWindow
        if let f = floating, f.windowScene === scene { w = f } else {
            w = SpecPassThroughWindow(windowScene: scene)
            w.windowLevel = .normal + 1
            w.backgroundColor = .clear
            w.rootViewController = UIViewController()
            w.rootViewController?.view.backgroundColor = .clear
            floating = w
        }
        w.frame = CGRect(x: kb.minX, y: kb.minY - 44, width: kb.width, height: 44)
        let host = w.rootViewController!.view!
        host.subviews.forEach { $0.removeFromSuperview() }
        let bar = makeBar(width: kb.width)
        bar.frame = host.bounds
        bar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        host.addSubview(bar)
        w.isHidden = false
    }
}

/// The bar takes a touch only on a control in it (the Done button), and lets
/// every other point fall through to the window under the keyboard (Vector
/// #982). On iOS 26 a toolbar draws nothing but its glass button, so the rest
/// of its 44 pt strip shows the page beneath — the W&B pad's 190 lb chip sat
/// there, looked tappable, and its taps went to the bar. Returning nil from
/// hitTest is what makes UIKit try the next window down. Also how `attach`
/// tells its own bar from one somebody else installed.
final class SpecDoneBar: UIToolbar {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hit = super.hitTest(point, with: event) else { return nil }
        return specTouchesControl(hit, within: self) ? hit : nil
    }
}

/// True when `v`, or a view between it and `root`, is a control: the button
/// inside a bar, not the bar's own background.
func specTouchesControl(_ v: UIView, within root: UIView) -> Bool {
    var x: UIView? = v
    while let cur = x, cur !== root {
        if cur is UIControl { return true }
        x = cur.superview
    }
    return false
}

/// The fallback bar's window: the same rule, so the strip beside Done does
/// not swallow the page's taps either.
final class SpecPassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hit = super.hitTest(point, with: event) else { return nil }
        return specTouchesControl(hit, within: self) ? hit : nil
    }
}


extension UIResponder {
    @objc func spec_reportFirstResponder(_ sender: Any?) { SpecKeyboardDone.report(self) }
}

/// An image's bitmap by URL: a `file://` source from disk (the camera's held
/// photo), anything else fetched with the session's headers, the way every
/// other request is (2026-10-15). AsyncImage sent none, so a squawk's
/// uploaded photo, served by the API behind the session, came back
/// unauthorized. A relative path is resolved against the API origin.
func specLoadUIImage(_ s: String) async -> UIImage? {
    if s.isEmpty { return nil }
    if s.hasPrefix("file://") {
        guard let u = URL(string: s) else { return nil }
        return specDrawableImage(UIImage(contentsOfFile: u.path))
    }
    guard let u = URL(string: SpecBaseURL.absolutize(s)) else { return nil }
    var req = URLRequest(url: u)
    applyAuthHeaders(to: &req)
    guard let (data, _) = try? await URLSession.shared.data(for: req) else { return nil }
    return specDrawableImage(UIImage(data: data))
}

/// The image, or nil when it has no area. A file read while it is being
/// rewritten (Scan a Form turns a page upright in place) can decode to 0 x 0,
/// and `.aspectRatio(contentMode:)` on one is 0 / 0: a NaN size that traps
/// the layout around it (a GeometryReader, a wrapping row).
func specDrawableImage(_ ui: UIImage?) -> UIImage? {
    guard let ui else { return nil }
    let w = ui.size.width, h = ui.size.height
    return w > 0 && h > 0 && w.isFinite && h.isFinite ? ui : nil
}

/// A bitmap's size in its own pixels: the web's naturalWidth / naturalHeight.
func specNaturalSize(_ ui: UIImage) -> CGSize {
    CGSize(width: ui.size.width * ui.scale, height: ui.size.height * ui.scale)
}

/// An image by URL (see specLoadUIImage). The loaded image is resizable and
/// fits (or fills) its box; the placeholder is clear so the box's own paint
/// shows while it loads.
///
/// `onLoad` is the web's `load` event (Vector I-5656): once per source, with
/// the bitmap's natural width and height, after it is decoded. Until then an
/// image fired none, so PanZoom never learned its image's size and drew it
/// at 0 x 0. `onError`: the source could not be read.
struct SpecRemoteImage: View {
    let url: Any?
    let fill: Bool
    var onLoad: ((Double, Double) -> Void)? = nil
    var onError: (() -> Void)? = nil
    @State private var loaded: UIImage? = nil
    @State private var loadedFor: String = ""

    private var urlString: String { specString(_unwrapOptional(url) ?? "") }

    var body: some View {
        let s = urlString
        Group {
            if let ui = loaded, loadedFor == s {
                Image(uiImage: ui).resizable().aspectRatio(contentMode: fill ? .fill : .fit)
            } else if s.hasPrefix("file://"), let u = URL(string: s), let ui = specDrawableImage(UIImage(contentsOfFile: u.path)) {
                // Drawn at once, before the task below has decoded it.
                Image(uiImage: ui).resizable().aspectRatio(contentMode: fill ? .fill : .fit)
            } else {
                Color.clear
            }
        }
        .task(id: s) {
            guard !s.isEmpty else { return }
            guard let ui = await specLoadUIImage(s) else {
                if !Task.isCancelled { onError?() }
                return
            }
            if Task.isCancelled { return }
            loaded = ui
            loadedFor = s
            let n = specNaturalSize(ui)
            onLoad?(Double(n.width), Double(n.height))
        }
    }
}

// MARK: - PanZoom (Vector I-5656)
//
// The registry's PanZoom (look closely at an image: pinch, drag, double-tap),
// a hand-written twin as Android's PanZoom.kt is (#2222). The web body is
// pointer events on a DOM viewport and a CSS-transformed <img>; this target
// has neither `transform:` nor those gestures, so the emitter lowers a PanZoom
// mount here, with the same props and the same three events (`load`, `change`,
// `error`). The geometry is pan-zoom.spec's fns, held to their numbers: the
// image is drawn at its FIT size times `s`, centered in the viewport, then
// moved by (tx, ty); all in points, focal points from the viewport's top-left.
//
// The mount's body (Scan a Form's "read from" box) is drawn in a layer that
// exactly covers the image and is sized and moved with it, the web's
// data-pan-zoom-overlay. It takes no touches; with no body there is no layer.
//
// A command, a focus and a double tap move over 160 ms, as the web's
// transition; a finger moves the view directly; Reduce Motion moves every one
// at once. At fit a one-finger drag is left to whatever holds the viewer (a
// scroll view, a sheet), since there is nothing to pan.

struct SpecPzView: Equatable {
    var s: Double
    var tx: Double
    var ty: Double
    static let fit = SpecPzView(s: 1, tx: 0, ty: 0)
}

func specPzFitSize(_ vw: Double, _ vh: Double, _ natW: Double, _ natH: Double, _ allowUpscale: Bool) -> (w: Double, h: Double) {
    if vw <= 0 || vh <= 0 || natW <= 0 || natH <= 0 { return (0, 0) }
    if !(vw.isFinite && vh.isFinite && natW.isFinite && natH.isFinite) { return (0, 0) }
    let k = min(vw / natW, vh / natH)
    let k2 = allowUpscale ? k : min(k, 1)
    return (natW * k2, natH * k2)
}

func specPzMaxScale(_ fitW: Double, _ natW: Double, _ maxActual: Double) -> Double {
    if fitW <= 0 || natW <= 0 { return 1 }
    return max(maxActual * natW / fitW, 2)
}

func specPzClampPan(_ s: Double, _ tx: Double, _ ty: Double, _ fitW: Double, _ fitH: Double, _ vw: Double, _ vh: Double) -> (tx: Double, ty: Double) {
    let slackX = max((fitW * s - vw) / 2, 0)
    let slackY = max((fitH * s - vh) / 2, 0)
    return (min(max(tx, -slackX), slackX), min(max(ty, -slackY), slackY))
}

func specPzZoomAt(_ s: Double, _ tx: Double, _ ty: Double, _ factor: Double, _ x: Double, _ y: Double, _ vw: Double, _ vh: Double, _ fitW: Double, _ fitH: Double, _ maxS: Double) -> SpecPzView {
    let cur = s > 0 ? s : 1
    let ns = min(max(cur * factor, 1), max(maxS, 1))
    let fx = x - vw / 2
    let fy = y - vh / 2
    let p = specPzClampPan(ns, fx - (fx - tx) * ns / cur, fy - (fy - ty) * ns / cur, fitW, fitH, vw, vh)
    return SpecPzView(s: ns, tx: p.tx, ty: p.ty)
}

func specPzStep(_ s: Double, _ dir: Double, _ maxS: Double) -> Double {
    let top = max(maxS, 1)
    let n = dir > 0 ? s * 1.5 : s / 1.5
    if n < 1.02 { return 1 }
    if n > top * 0.98 { return top }
    return n
}

func specPzPercent(_ s: Double, _ fitW: Double, _ natW: Double) -> Double {
    if natW <= 0 { return 0 }
    return (100 * s * fitW / natW).rounded()
}

func specPzActualScale(_ fitW: Double, _ natW: Double, _ maxS: Double) -> Double {
    if fitW <= 0 || natW <= 0 { return 1 }
    return min(max(natW / fitW, 1), max(maxS, 1))
}

func specPzFinite(_ v: Double) -> Double { v.isFinite ? v : 0 }

private func specPzIsNumber(_ v: Any?) -> Bool {
    guard let u = _unwrapOptional(v) else { return false }
    if u is Bool { return false }
    if let n = u as? NSNumber { return CFGetTypeID(n) != CFBooleanGetTypeID() }
    return u is Double || u is Int || u is Float
}

/// pan-zoom.spec's pzFocusView: the view that frames `rect` (fractions of the
/// image) at about 80% of the viewport, between fit and min(ceiling, 2.6x).
func specPzFocusView(_ rect: Any?, _ vw: Double, _ vh: Double, _ fitW: Double, _ fitH: Double, _ maxS: Double) -> SpecPzView {
    guard let r = _unwrapOptional(rect), (r is [String: Any] || r is NSDictionary), vw > 0, vh > 0, fitW > 0, fitH > 0 else { return .fit }
    let x = specGet(r, "x"), y = specGet(r, "y"), w = specGet(r, "width"), h = specGet(r, "height")
    guard specPzIsNumber(x), specPzIsNumber(y), specPzIsNumber(w), specPzIsNumber(h) else { return .fit }
    let rw = max(specNum(w), 0)
    let rh = max(specNum(h), 0)
    let cx = specNum(x) + rw / 2
    let cy = specNum(y) + rh / 2
    let top = min(max(maxS, 1), 2.6)
    let sx = rw > 0 ? 0.8 * vw / (rw * fitW) : top
    let sy = rh > 0 ? 0.8 * vh / (rh * fitH) : top
    let s = max(min(min(sx, sy), top), 1)
    let p = specPzClampPan(s, (0.5 - cx) * fitW * s, (0.5 - cy) * fitH * s, fitW, fitH, vw, vh)
    return SpecPzView(s: s, tx: p.tx, ty: p.ty)
}

/// A length the web reads against a containing box: "12.5%" of `of`, "40px"
/// or a number in points, nil for empty / auto. A value that is not a finite
/// number ("NaN%", which `{x * 100}%` gives for a missing x) is nil too: the
/// web drops an invalid length, and SwiftUI traps placing a view at NaN.
func specLengthIn(_ v: Any?, of total: CGFloat) -> CGFloat? {
    guard let r = specLengthInRaw(v, of: total), r.isFinite else { return nil }
    return r
}

private func specLengthInRaw(_ v: Any?, of total: CGFloat) -> CGFloat? {
    guard let u = _unwrapOptional(v), !(u is NSNull) else { return nil }
    if u is String {
        let t = specString(u).trimmingCharacters(in: .whitespaces)
        if t.isEmpty || t == "auto" { return nil }
        if t.hasSuffix("%"), let d = Double(t.dropLast()) { return total * CGFloat(d) / 100 }
        let n = t.hasSuffix("px") ? String(t.dropLast(2)) : t
        if let d = Double(n) { return CGFloat(d) }
        return nil
    }
    let d = specNum(u)
    return d.isNaN ? nil : CGFloat(d)
}

/// The size of the layer SpecPercentPlaced children are placed in.
private struct SpecPlacedLayerSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}
extension EnvironmentValues {
    var specPlacedLayerSize: CGSize {
        get { self[SpecPlacedLayerSizeKey.self] }
        set { self[SpecPlacedLayerSizeKey.self] = newValue }
    }
}

/// An absolutely placed child of a layer, its `left` / `top` / `right` /
/// `bottom` / `width` / `height` read against the LAYER's size, as the web's
/// percentages are. The layer hands its size down as `specPlacedLayerSize`:
/// a positioned layer reads it with a GeometryReader (Vector #5472), and
/// SpecPanZoom gives its overlay the image's own box (PanZoom's read box,
/// I-5656), with no reader, so a size that animates with a zoom is read as
/// it is. The layer's alignment anchors the child to the corner of the edges
/// it names; `right` / `bottom` move it back from the far one. Between two
/// edges with no size it fills the span; with no size and no span it keeps
/// its content's width, as an absolute box sized in points does.
struct SpecPercentPlaced<Content: View>: View {
    var left: Any? = nil
    var top: Any? = nil
    var right: Any? = nil
    var bottom: Any? = nil
    var width: Any? = nil
    var height: Any? = nil
    @ViewBuilder let content: () -> Content
    @Environment(\.specPlacedLayerSize) private var layer

    var body: some View {
        let l = specLengthIn(left, of: layer.width)
        let r = specLengthIn(right, of: layer.width)
        let t = specLengthIn(top, of: layer.height)
        let b = specLengthIn(bottom, of: layer.height)
        var w = specLengthIn(width, of: layer.width)
        if w == nil, let l, let r { w = layer.width - l - r }
        var h = specLengthIn(height, of: layer.height)
        if h == nil, let t, let b { h = layer.height - t - b }
        return content()
            .fixedSize(horizontal: w == nil, vertical: false)
            .frame(width: w.map { max($0, 0) }, height: h.map { max($0, 0) }, alignment: .topLeading)
            .offset(x: l ?? r.map { -$0 } ?? 0, y: t ?? b.map { -$0 } ?? 0)
    }
}

// MARK: - Bound absolute edges in percent (Vector #5482)

/// Whether a bound length is a percent string ("30%").
func specIsPercentLength(_ v: Any?) -> Bool {
    guard let s = _unwrapOptional(v) as? String else { return false }
    return s.trimmingCharacters(in: .whitespaces).hasSuffix("%")
}

extension View {
    /// An absolute box with a BOUND edge. A px value keeps the caller's own
    /// modifiers (`px`: the offset or padding it always had); a percent one
    /// is placed by SpecAbsPercentLayout against the overlay's proposal,
    /// which is the layer's size, with no GeometryReader.
    @ViewBuilder
    func specAbsEdges<P: View>(left: Any?, top: Any?, right: Any?, bottom: Any?, @ViewBuilder _ px: (Self) -> P) -> some View {
        if specIsPercentLength(left) || specIsPercentLength(top) || specIsPercentLength(right) || specIsPercentLength(bottom) {
            SpecAbsPercentLayout(left: left, top: top, right: right, bottom: bottom) { self }
        } else {
            px(self)
        }
    }
}

/// Places its one subview at the edges it names, each read against the
/// proposal (the positioned layer's size): one edge moves it (`right` /
/// `bottom` back from the far corner, which the layer's alignment anchors),
/// two on an axis inset it between them, as the px path's padding does.
struct SpecAbsPercentLayout: Layout {
    var left: Any?
    var top: Any?
    var right: Any?
    var bottom: Any?

    private struct Resolved { var l, r, t, b: CGFloat?; var child: ProposedViewSize }

    private func resolve(_ p: ProposedViewSize) -> Resolved {
        let l = specLengthIn(left, of: p.width ?? 0), r = specLengthIn(right, of: p.width ?? 0)
        let t = specLengthIn(top, of: p.height ?? 0), b = specLengthIn(bottom, of: p.height ?? 0)
        var child = p
        if let l, let r, let w = p.width { child.width = max(w - l - r, 0) }
        if let t, let b, let h = p.height { child.height = max(h - t - b, 0) }
        return Resolved(l: l, r: r, t: t, b: b, child: child)
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let e = resolve(proposal)
        let s = subviews.first?.sizeThatFits(e.child) ?? .zero
        let w = (e.l != nil && e.r != nil) ? s.width + e.l! + e.r! : s.width
        let h = (e.t != nil && e.b != nil) ? s.height + e.t! + e.b! : s.height
        return CGSize(width: max(w, 0), height: max(h, 0))
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let e = resolve(proposal)
        let x = e.l ?? e.r.map { -$0 } ?? 0
        let y = e.t ?? e.b.map { -$0 } ?? 0
        subviews.first?.place(at: CGPoint(x: bounds.minX + x, y: bounds.minY + y), anchor: .topLeading, proposal: e.child)
    }
}

/// The registry PanZoom, as ir-to-swift-ui mounts it: its props as the call
/// site wrote them, its events through `onDispatch` (name, [payload]), its
/// body as `overlay`.
struct SpecPanZoom: View {
    var src: Any? = ""
    var alt: Any? = ""
    var allowUpscale: Any? = false
    var maxActual: Any? = 4
    var resetKey: Any? = ""
    var command: Any? = ""
    var focus: Any? = nil
    var focusKey: Any? = ""
    var onDispatch: ((Any?, Any?) -> Void)? = nil
    var overlay: AnyView? = nil

    @State private var image: UIImage? = nil
    @State private var imageFor: String = ""
    @State private var vw: Double = 0
    @State private var vh: Double = 0
    @State private var natW: Double = 0
    @State private var natH: Double = 0
    @State private var view: SpecPzView = .fit
    /// The view a pinch began from, and the drag's base (view minus travel).
    @State private var pinchBase: SpecPzView? = nil
    @State private var dragBase: CGPoint? = nil

    private var url: String { specString(_unwrapOptional(src) ?? "") }
    private var upscale: Bool { specTruthy(allowUpscale) }
    private var ceilingActual: Double {
        let m = specNum(maxActual)
        return m.isNaN || m <= 0 ? 4 : m
    }
    private var fit: (w: Double, h: Double) { specPzFitSize(vw, vh, natW, natH, upscale) }
    private var maxS: Double { specPzMaxScale(fit.w, natW, ceilingActual) }

    /// Every change of view goes through here, so the host's readout never
    /// falls behind the picture (the web's applyView).
    private func apply(_ v: SpecPzView, animated: Bool) {
        if !(v.s.isFinite && v.tx.isFinite && v.ty.isFinite) { return }
        if animated && !UIAccessibility.isReduceMotionEnabled {
            withAnimation(.easeOut(duration: 0.16)) { view = v }
        } else {
            view = v
        }
        // Before the image has a size there is no view to report.
        if natW <= 0 { return }
        let f = fit
        let m = maxS
        let change: [String: Any] = [
            "scale": v.s,
            "percent": specPzPercent(v.s, f.w, natW),
            "atFit": v.s <= 1.001,
            "atMax": v.s >= m - 0.001,
            "atActual": abs(v.s - specPzActualScale(f.w, natW, m)) < 0.001,
        ]
        onDispatch?("change", [change] as [Any])
    }

    private func runCommand(_ raw: String) {
        let c = raw.components(separatedBy: "#").first ?? ""
        let f = fit
        let m = maxS
        if c == "fit" { apply(.fit, animated: true); return }
        let target: Double
        switch c {
        case "in": target = specPzStep(view.s, 1, m)
        case "out": target = specPzStep(view.s, -1, m)
        case "actual": target = specPzActualScale(f.w, natW, m)
        default: return
        }
        apply(specPzZoomAt(view.s, view.tx, view.ty, target / view.s, vw / 2, vh / 2, vw, vh, f.w, f.h, m), animated: true)
    }

    private func resize(_ size: CGSize) {
        // A layout pass can offer an unbounded or unsettled size; a fit read
        // from one is infinite, and centering it is inf - inf = NaN, which
        // traps the next layout (a GeometryReader around it included).
        let w = specPzFinite(Double(size.width)), h = specPzFinite(Double(size.height))
        if w == vw && h == vh { return }
        vw = w
        vh = h
        // A resize or rotate keeps the scale and re-clamps the pan.
        let f = fit
        let p = specPzClampPan(view.s, view.tx, view.ty, f.w, f.h, w, h)
        apply(SpecPzView(s: view.s, tx: p.tx, ty: p.ty), animated: false)
    }

    private var zoomed: Bool { view.s > 1.001 }

    private var pinch: some Gesture {
        MagnifyGesture()
            .onChanged { g in
                let base = pinchBase ?? view
                if pinchBase == nil { pinchBase = base }
                let f = fit
                let next = specPzZoomAt(base.s, base.tx, base.ty, Double(g.magnification), Double(g.startLocation.x), Double(g.startLocation.y), vw, vh, f.w, f.h, maxS)
                apply(next, animated: false)
                dragBase = nil
            }
            .onEnded { _ in
                pinchBase = nil
                dragBase = nil
            }
    }

    private var drag: some Gesture {
        DragGesture(minimumDistance: 4)
            .onChanged { g in
                if pinchBase != nil { return }
                let t = g.translation
                // Re-based on the first change after a pinch, so the image
                // does not jump back to where the drag began.
                let base = dragBase ?? CGPoint(x: view.tx - Double(t.width), y: view.ty - Double(t.height))
                if dragBase == nil { dragBase = base }
                let f = fit
                let p = specPzClampPan(view.s, Double(base.x) + Double(t.width), Double(base.y) + Double(t.height), f.w, f.h, vw, vh)
                // A pan alone reports no `change`, as on the web.
                view = SpecPzView(s: view.s, tx: p.tx, ty: p.ty)
            }
            .onEnded { _ in dragBase = nil }
    }

    private var doubleTap: some Gesture {
        SpatialTapGesture(count: 2)
            .onEnded { g in
                if zoomed { apply(.fit, animated: true); return }
                let f = fit
                apply(specPzZoomAt(view.s, view.tx, view.ty, 2.5 / view.s, Double(g.location.x), Double(g.location.y), vw, vh, f.w, f.h, maxS), animated: true)
            }
    }

    var body: some View {
        let s = url
        let f = fit
        // Never a non-finite size or offset: SwiftUI traps placing one.
        let w = specPzFinite(max(f.w * view.s, 0))
        let h = specPzFinite(max(f.h * view.s, 0))
        // The viewport's size is the proposal's, never the image's: the web
        // PanZoom fills its parent and draws the image inside it. Sized from
        // its content, a zoomed image widened the viewport, which widened the
        // fit, which widened the image (x1.5 a pass after Zoom In) until the
        // layout around it went to infinity and NaN and trapped.
        Color.clear
            .overlay {
                ZStack {
                    if let ui = image, imageFor == s {
                        ZStack(alignment: .topLeading) {
                            Image(uiImage: ui)
                                .resizable()
                                .frame(width: w, height: h)
                                .accessibilityLabel(specString(alt))
                            if let overlay {
                                overlay
                                    .frame(width: w, height: h, alignment: .topLeading)
                                    .environment(\.specPlacedLayerSize, CGSize(width: w, height: h))
                                    .allowsHitTesting(false)
                            }
                        }
                        .frame(width: w, height: h)
                        .offset(x: specPzFinite(view.tx), y: specPzFinite(view.ty))
                    }
                }
            }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
        .contentShape(Rectangle())
        .onGeometryChange(for: CGSize.self) { $0.size } action: { resize($0) }
        .gesture(doubleTap)
        .simultaneousGesture(pinch)
        .simultaneousGesture(drag, including: zoomed ? .all : .subviews)
        .task(id: s) {
            guard !s.isEmpty else { return }
            guard let ui = await specLoadUIImage(s) else {
                if !Task.isCancelled { onDispatch?("error", [] as [Any]) }
                return
            }
            if Task.isCancelled { return }
            let n = specNaturalSize(ui)
            // A decode with no size keeps what we have, as the web's onLoaded.
            if n.width <= 0 || n.height <= 0 { return }
            image = ui
            imageFor = s
            natW = Double(n.width)
            natH = Double(n.height)
            onDispatch?("load", [["naturalWidth": natW, "naturalHeight": natH] as [String: Any]] as [Any])
            apply(.fit, animated: false)
        }
        // The watches: each runs when its prop CHANGES, not as the view appears.
        .onChange(of: specChangeKey(resetKey)) { _, _ in apply(.fit, animated: false) }
        .onChange(of: specString(command)) { _, c in runCommand(c) }
        .onChange(of: specChangeKey(focusKey)) { _, _ in
            guard let r = _unwrapOptional(focus), !(r is NSNull) else { return }
            let f = fit
            apply(specPzFocusView(r, vw, vh, f.w, f.h, maxS), animated: true)
        }
    }
}

/// SpecTextField's multi-line twin (the `textarea` primitive).
struct SpecTextEditor: View {
    @Binding var text: String
    let autofocus: Bool
    /// Shown while the box is empty, as the web's `placeholder` is. TextEditor
    /// has none of its own; the overlay sits at the editor's text inset and
    /// takes the font the call site applies.
    let placeholder: String
    let maxLength: Int?
    let onCommit: ((String) -> Void)?
    /// `readonly:` shows the text and takes no edit or focus; `disabled:` does
    /// the same and dims the box, as the web's opacity 0.5 (Vector
    /// bwoody77/vector#4938: the charter Messages draft stayed editable while
    /// it was sending).
    let readOnly: Bool
    let disabled: Bool
    /// `on blur`, a beat after the commit, as SpecTextField runs it.
    let onBlur: (() -> Void)?
    @State private var local: String = ""
    @State private var seeded = false
    @State private var pending: Task<Void, Never>? = nil
    @State private var commitBase: String = ""
    @State private var focusId = UUID()
    @FocusState private var focused: Bool

    /// The registry textarea's height in lines (Vector bwoody77/vector#4929):
    /// `rows` lines when empty, growing with the text to the upper bound,
    /// then scrolling inside itself. nil keeps the old sizing, where the call
    /// site's frame decides (the primitive `textArea`'s `height:` floor).
    let lines: ClosedRange<Int>?
    @State private var contentHeight: CGFloat = 0
    @State private var lineHeight: CGFloat = 0

    init(text: Binding<String>, autofocus: Bool = false, placeholder: String = "", maxLength: Int? = nil, onCommit: ((String) -> Void)? = nil, lines: ClosedRange<Int>? = nil, readOnly: Bool = false, disabled: Bool = false, onBlur: (() -> Void)? = nil) {
        self._text = text; self.autofocus = autofocus; self.placeholder = placeholder; self.maxLength = maxLength; self.onCommit = onCommit; self.lines = lines
        self.readOnly = readOnly; self.disabled = disabled; self.onBlur = onBlur
    }

    private var locked: Bool { readOnly || disabled }

    // UITextView's text inset: 8pt above and below, 5pt of line padding a side.
    private static let insetV: CGFloat = 16
    private static let insetH: CGFloat = 5

    /// The editor's height for `lines`: the measured text, clamped to the
    /// range. Before the first measurement, the low end at a body line.
    private var fittedHeight: CGFloat? {
        guard let lines else { return nil }
        let line = lineHeight > 0 ? lineHeight : 22
        let text = contentHeight > 0 ? contentHeight : line
        let h = min(max(text, line * CGFloat(lines.lowerBound)), line * CGFloat(lines.upperBound))
        return ceil(h + Self.insetV)
    }

    /// Two hidden Texts in the editor's font and width: the draft (a trailing
    /// newline still counts as a line, hence the space) and one line. A
    /// TextEditor reports no content height of its own.
    @ViewBuilder private var measure: some View {
        if lines != nil {
            ZStack(alignment: .topLeading) {
                Text(verbatim: local + " ")
                    .fixedSize(horizontal: false, vertical: true)
                    .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { h in
                        if abs(h - contentHeight) >= 0.5 { contentHeight = h }
                    }
                Text(verbatim: " ")
                    .fixedSize(horizontal: false, vertical: true)
                    .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { h in
                        if abs(h - lineHeight) >= 0.5 { lineHeight = h }
                    }
            }
            .padding(.horizontal, Self.insetH)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .hidden()
            .allowsHitTesting(false)
            .accessibilityHidden(true)
        }
    }

    // `on change` on focus loss, when the text moved (Vector #1954); Return
    // is a newline here, as in a web textarea. SpecTextField.commit's rule.
    @discardableResult
    private func commit() -> Bool {
        guard let onCommit else { return false }
        if local == commitBase { return false }
        commitBase = local
        let v = local
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { onCommit(v) }
        return true
    }

    // A tap's blur (SpecFocusedField, Vector #2696): commit now, then give up
    // the keyboard; the focus edge that follows finds nothing left to commit.
    private func blurForTap() -> Bool {
        flush()
        let changed = commit()
        let told = blurred()
        blurRan = true
        SpecKeyboardDone.dismiss()
        return changed || told
    }

    @State private var blurRan = false
    @discardableResult
    private func blurred() -> Bool {
        guard let onBlur else { return false }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { onBlur() }
        return true
    }

    // `maxLength:` (Vector #2087), SpecTextField's cut-back: a typed or pasted
    // edit past the cap is trimmed before it is written. A negative cap is the
    // DOM's "no limit".
    private func clipped(_ v: String) -> String {
        if let m = maxLength, m >= 0, v.count > m { return String(v.prefix(m)) }
        return v
    }

    var body: some View {
        TextEditor(text: $local)
            .frame(height: fittedHeight)
            .background(alignment: .topLeading) { measure }
            .overlay(alignment: .topLeading) {
                if local.isEmpty && !placeholder.isEmpty {
                    Text(verbatim: placeholder)
                        .foregroundStyle(Color(.placeholderText))
                        .padding(.top, 8).padding(.leading, 5)
                        .allowsHitTesting(false)
                        .accessibilityHidden(true)
                }
            }
            .focused($focused)
            // Read-only or disabled: no keyboard, no edit. A box that locks
            // while focused (Send tapped with the keyboard up) lets it go.
            .disabled(locked)
            .opacity(disabled ? 0.5 : 1)
            .onChange(of: locked) { l in if l { focused = false } }
            .onAppear { if !seeded { local = text; commitBase = text; seeded = true }; SpecKeyboardDone.install(); if autofocus && !locked { focused = true } }
            // While focused, a change to `text` is usually the echo of this
            // field's own deferred write and must not stomp newer keystrokes.
            // But one that arrives with NO write in flight came from somewhere
            // else — a stepper's +/- (Vector's W&B weight pad, #832) — and
            // ignoring it left the field showing 0 under a seat that read 10.
            .onChange(of: text) { v in if v != local && (!focused || pending == nil) { local = v; commitBase = v } }
            .onChange(of: local) { v in
                // Only what the user types: a longer value the page itself
                // sets is left alone, as the web's is.
                let c = focused ? clipped(v) : v
                if c != v { local = c; return }
                deferWrite(v)
            }
            .onChange(of: focused) { f in
                if f { commitBase = local; blurRan = false; SpecFocusedField.focused(focusId) { blurForTap() } }
                else {
                    SpecFocusedField.blurred(focusId); flush(); commit()
                    if blurRan { blurRan = false } else { blurred() }
                }
            }
            .onDisappear { if pending != nil { flush() }; SpecFocusedField.blurred(focusId) }
            .onChange(of: autofocus) { f in if f && !locked { focused = true } }
    }

    private func deferWrite(_ v: String) {
        pending?.cancel()
        pending = Task {
            try? await Task.sleep(nanoseconds: 150_000_000)
            if Task.isCancelled { return }
            await MainActor.run { if text != v { text = v }; pending = nil }
        }
    }

    private func flush() {
        pending?.cancel()
        pending = nil
        if text != local { text = local }
    }
}
#endif

/// The registry textarea's line range on iOS (Vector bwoody77/vector#4929):
/// opens at `rows` (4 when unusable, the component's default) and grows to
/// max(rows, 6) lines before it scrolls inside itself.
func specTextareaLines(_ rows: Any?) -> ClosedRange<Int> {
    let d = specNum(rows)
    let r = d.isFinite && d >= 1 ? Int(d) : 4
    return r...max(r, 6)
}

/// Maps Lucide icon names (used in Spec) to SF Symbols equivalents.
func specIconName(_ lucide: String) -> String {
    let map: [String: String] = [
        // Navigation & Actions
        "home": "house.fill",
        // Lucide renamed home → house and ships log-in beside log-out; Vector's
        // More rows ("Log In as User…") drew the placeholder (Vector #1550).
        "house": "house.fill",
        "arrow-left": "chevron.left",
        "arrow-right": "chevron.right",
        "plus": "plus",
        "edit": "pencil",
        // Lucide's own names for two glyphs the shop app's check rows use
        // (2026-10-14): both rendered the placeholder before this.
        "pencil": "pencil",
        "history": "clock.arrow.circlepath",
        "check": "checkmark",
        "check-circle": "checkmark.circle.fill",
        "circle": "circle",
        "x": "xmark",
        "menu": "line.3.horizontal",
        "search": "magnifyingglass",

        // Content
        "list": "list.bullet",
        "clipboard": "doc.on.clipboard",
        "flag": "flag.fill",
        "flag-off": "flag.slash",
        "layout": "rectangle.grid.2x2",
        "eye": "eye.fill",
        "eye-off": "eye.slash.fill",
        "eye-closed": "eye.slash",
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

        // Added 2026-09-15. Every name below was verified against
        // NSImage(systemSymbolName:) rather than guessed — a wrong name is
        // indistinguishable from a missing one at runtime (see the fallback).
        // Chevrons & movement
        "chevron-down": "chevron.down",
        "chevron-up": "chevron.up",
        "chevron-left": "chevron.left",
        "chevron-right": "chevron.right",
        "chevrons-up-down": "chevron.up.chevron.down",
        "more-horizontal": "ellipsis",
        "rotate-ccw": "arrow.counterclockwise",
        "rotate-cw": "arrow.clockwise",
        "refresh-cw": "arrow.clockwise",
        "external-link": "arrow.up.right.square",

        // Status
        "circle-alert": "exclamationmark.circle.fill",
        "alert-circle": "exclamationmark.circle.fill",
        "circle-check": "checkmark.circle.fill",
        "x-circle": "xmark.circle.fill",
        "shield": "shield.fill",
        "shield-check": "checkmark.shield.fill",
        "wifi": "wifi",
        "wifi-off": "wifi.slash",

        // Content & documents
        "file-text": "doc.text.fill",
        "file": "doc.fill",
        "image": "photo.fill",
        "copy": "doc.on.doc.fill",
        "save": "square.and.arrow.down.fill",
        "printer": "printer.fill",
        "qr-code": "qrcode",
        "book": "book.fill",
        "book-open": "book.pages.fill",
        "graduation-cap": "graduationcap.fill",
        "link": "link",
        "filter": "line.3.horizontal.decrease.circle",
        "sliders-horizontal": "slider.horizontal.3",

        // People & comms
        "mail": "envelope.fill",
        "send": "paperplane.fill",
        "phone": "phone.fill",
        "users": "person.2.fill",
        "user-plus": "person.badge.plus",
        "inbox": "tray.fill",
        "message-square": "message.fill",
        "pen-line": "pencil.line",
        "lock": "lock.fill",
        "unlock": "lock.open.fill",
        "log-out": "rectangle.portrait.and.arrow.right",
        "log-in": "arrow.right.to.line",

        // Money
        "credit-card": "creditcard.fill",
        // Vector's flight-school More screen (2026-10-16): Charges and Fuel
        // Receipts drew the dashed question mark.
        "wallet": "wallet.bifold.fill",
        "receipt": "receipt.fill",
        "file-search": "doc.text.magnifyingglass",
        "dollar-sign": "dollarsign.circle.fill",

        // Time & media
        "calendar": "calendar",
        "calendar-days": "calendar",
        "timer": "timer",
        "play": "play.fill",
        "pause": "pause.fill",
        "square": "square",
        "square-check": "checkmark.square.fill",
        "square-check-big": "checkmark.square.fill",
        "minus": "minus",
        "camera": "camera.fill",
        "trash": "trash.fill",
        "trash-2": "trash.fill",
        "download": "arrow.down.circle.fill",
        "upload": "arrow.up.circle.fill",

        // Aviation / ops — the charter and maintenance entries lean on these
        "plane": "airplane",
        "map-pin": "mappin.circle.fill",
        "map": "map.fill",
        "navigation": "location.north.fill",
        "gauge": "gauge.medium",
        "thermometer": "thermometer.medium",
        "droplet": "drop.fill",
        "fuel": "fuelpump.fill",
        // Ground, lodging and bookings — the charter pilot app's destination
        // card (2026-10-05). Unmapped names fall to the dashed question mark
        // below, which is what a car and a hotel row showed on the phone.
        "truck": "truck.box.fill",
        "car": "car.fill",
        "bus": "bus.fill",
        "moon": "moon.fill",
        "bed": "bed.double.fill",
        "bed-double": "bed.double.fill",
        "hotel": "bed.double.fill",
        "building": "building.2.fill",
        "clipboard-check": "checklist",
        "clipboard-list": "list.clipboard.fill",
        "wrench": "wrench.and.screwdriver.fill",
        "cloud": "cloud.fill",
        "wind": "wind",
    ]
    // An unmapped name used to be returned verbatim. A lucide name is not an
    // SF Symbol, so Image(systemName:) drew NOTHING — the charter login's icon
    // tile was a plain violet square with no glyph and no warning. A visible
    // placeholder makes a missing mapping something you can see and fix.
    return map[lucide] ?? "questionmark.square.dashed"
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

// MARK: - DOM shims

/// `event.stopPropagation()` / `preventDefault()` on a platform with no DOM.
///
/// These exist on the web to stop an event bubbling to an ancestor listener.
/// SwiftUI has no bubbling to stop — a Button's action does not propagate to the
/// row behind it — so what they buy in a browser is the DEFAULT here, and doing
/// nothing is the honest translation rather than a missing feature.
///
/// Named rather than emitted as an empty statement so it is greppable: seeing
/// specDomNoop() in generated Swift should lead a reader to this comment.
@inline(__always)
@discardableResult
func specDomNoop() -> Any? { return nil }

// MARK: - HTTP / JSON

/// Resolve a spec URL against the configured base, for a device or simulator.
private func __specResolveURL(_ url: Any) -> URL? {
    guard let urlStr = url as? String else { return nil }
    // SpecBaseURL.absolutize is the ONE rule for what an endpoint means, shared
    // with DataSource.buildUrl. A relative "/api/…" has no scheme and no host,
    // and URLSession rejects it with -1002; this used to only rewrite a url that
    // already said localhost, so a relative one went out as-is and could never
    // fetch.
    return URL(string: SpecBaseURL.absolutize(urlStr))
}

/// Apply a spec `options` map (method / body / headers) to a request.
private func __specApplyOptions(_ options: Any?, to req: inout URLRequest) {
    guard let opts = options as? [String: Any] else { return }
    if let m = opts["method"] as? String { req.httpMethod = m }
    if let body = opts["body"], !(body is NSNull) {
        if let s = body as? String { req.httpBody = s.data(using: .utf8) }
        else if let d = try? JSONSerialization.data(withJSONObject: body) { req.httpBody = d }
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    if let headers = opts["headers"] as? [String: Any] {
        for (k, v) in headers { req.setValue(specString(v), forHTTPHeaderField: k) }
    }
}

/// `fetchResult(url, options)` — a request whose STATUS the caller can read.
///
/// Answers `{ ok, status, body, timedOut }` and NEVER throws, which is the whole
/// point: `__specFetch` below hands back the body and nothing else, so an author
/// cannot tell a success from a refusal, and `fn` has no try/catch to recover
/// with. Mirrors the web runtime's `__specFetchResult` field for field.
///
/// `options.timeoutMs` caps the request, and `timedOut` distinguishes "nothing
/// answered in time" from "the server said no" — a caller that conflates them
/// tells the user the wrong thing.
///
/// A 401 still fires `SpecAuth.unauthorizedHandler`, exactly as the DataSource
/// path does, so a stale session is handled the same way however it is noticed.
@discardableResult
func __specFetchResult(_ url: Any, _ options: Any? = nil) async -> Any? {
    guard let u = __specResolveURL(url) else {
        return ["ok": false, "status": 0.0, "timedOut": false,
                "body": ["error": "Invalid URL"] as [String: Any]] as [String: Any]
    }
    var req = URLRequest(url: u)
    __specApplyOptions(options, to: &req)
    applyAuthHeaders(to: &req)

    var timedOut = false
    // SPEC_SOURCE_DELAY_MS / SPEC_SOURCE_FAIL_ONCE slow or fail this request
    // as they do a @source's, so a screen that loads with fetchResult can test
    // its first-load state (Vector #2677). A no-op outside DEBUG; a forced
    // failure reads as offline, status 0, below.
    if let opts = options as? [String: Any], let ms = opts["timeoutMs"] {
        let seconds = specDouble(ms) / 1000.0
        if seconds > 0 { req.timeoutInterval = seconds }
    }

    do {
        try await specSourceBeforeFetch(url: u.absoluteString)
        let (data, response) = try await URLSession.shared.data(for: req)
        let http = response as? HTTPURLResponse
        let status = http?.statusCode ?? 0
        if status == 401 { SpecAuth.unauthorizedHandler?() }
        // An empty body is `nil`, not a parse failure — 204 and a bare 200 are
        // ordinary answers and must not read as errors.
        let body: Any? = data.isEmpty
            ? nil
            : try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
        return ["ok": (200...299).contains(status),
                "status": Double(status),
                "timedOut": false,
                "body": body as Any] as [String: Any]
    } catch {
        // URLSession reports a timeout as .timedOut; everything else here is a
        // transport failure (offline, DNS, refused), which is status 0 on the
        // web side too.
        if let urlErr = error as? URLError, urlErr.code == .timedOut { timedOut = true }
        return ["ok": false,
                "status": 0.0,
                "timedOut": timedOut,
                "body": ["error": timedOut ? "Request timed out" : error.localizedDescription] as [String: Any]] as [String: Any]
    }
}

/// Async HTTP fetch — bridges spec's `fetch(url, options)` to URLSession.
/// Returns the decoded JSON body as Any (or nil on error).
///
/// NAMED `__specFetch`, not `fetch`. astToIR rewrites every `fetch(...)` in spec
/// source to `__specFetch(...)` for both targets, and this helper was called
/// `fetch` — so an action calling it emitted an undefined identifier and the iOS
/// build failed. It went unnoticed because the one app driving this target
/// reaches the network through an @extern api.js instead, so `fetch()` in an
/// action had never actually been compiled for iOS.
@discardableResult
func __specFetch(_ url: Any, _ options: Any? = nil) async -> Any? {
    guard let u = __specResolveURL(url) else { return nil }
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
    // Auth headers from SpecAuth.headerProvider, filling gaps only — so an
    // explicit Authorization in `options.headers` above still wins.
    //
    // This is the path a ported api.js takes. `fetch()` in a Spec action is how
    // apiGetSafe / apiPostSafe reach the server once they are fn rather than
    // @extern, and without this they would go out bare and 401 — the same
    // failure the DataSource path had.
    applyAuthHeaders(to: &req)
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

/// Safely convert Any/Optional to a display string, unwrapping optionals.
func specString(_ val: Any?) -> String {
    guard let v = val else { return "" }
    // A JSON null is NSNull, not nil, and String(describing:) prints it as
    // "<null>": text(row) over a server list holding a null showed that word
    // where the web shows nothing (Vector #1689).
    if v is NSNull { return "" }
    if let s = v as? String { return s }
    // A JSON boolean BEFORE the Double branch. JSONSerialization decodes
    // true/false as a CFBoolean NSNumber, which also bridges to Double, so it
    // read "1"/"0" and never equalled a Spec `true` ("true") through specEq —
    // `row.flag == true` was false on iOS for every server flag.
    if let n = v as? NSNumber, CFGetTypeID(n) == CFBooleanGetTypeID() {
        return n.boolValue ? "true" : "false"
    }
    if let d = v as? Double { return specNumberText(d) }
    if let b = v as? Bool { return b ? "true" : "false" }
    if let i = v as? Int { return String(i) }
    // Array.prototype.toString: the elements joined with ",", a null one as
    // nothing. A map is "[object Object]". Swift's own text ("[1.0, 2.0]",
    // "[:]") reached a template, a `+` and a join of a nested list (#1788).
    if let a = v as? [Any] { return a.map { specString($0) }.joined(separator: ",") }
    if v is [String: Any] || v is NSDictionary { return "[object Object]" }
    // Unwrap nested optionals
    let mirror = Mirror(reflecting: v)
    if mirror.displayStyle == .optional {
        if let child = mirror.children.first { return specString(child.value) }
        return ""
    }
    return String(describing: v)
}

/// JS `String(v)` with JS's own text for null ("null"), where specString's
/// "" is one of the deliberate rules: an `indexOf` / `replace` needle, a map
/// key, the text a default `sort` compares.
func specJsString(_ val: Any?) -> String {
    return specIsNil(val) ? "null" : specString(val)
}

/// A number as JS `String(d)` writes it: ECMA-262 Number::toString over the
/// shortest digits that read back as `d`.
///
/// Swift's `description` picks the same shortest digits; only the layout
/// differs. JS writes plain digits from 1e-7 up to 1e21 ("0.000001",
/// "123456789012345680000"), the exponent outside that ("1e-7", "1e+21"), and
/// NaN as "NaN". Swift said "1e-06", "1e-07" and "nan" (#1788). The old
/// `String(Int(d))` TRAPPED on ±Infinity and past Int.max (Vector #1639).
func specNumberText(_ d: Double) -> String {
    if d.isNaN { return "NaN" }
    if d == 0 { return "0" }   // and -0, which JS prints as "0"
    if d.isInfinite { return d < 0 ? "-Infinity" : "Infinity" }
    if d < 0 { return "-" + specNumberText(-d) }
    if d < 1e15, d == d.rounded(.down) { return String(Int64(d)) }
    // digits × 10^(n − k): the (s, k, n) of Number::toString.
    let text = d.description
    var mantissa = Substring(text)
    var exp = 0
    if let e = text.firstIndex(of: "e") {
        mantissa = text[..<e]
        exp = Int(text[text.index(after: e)...].replacingOccurrences(of: "+", with: "")) ?? 0
    }
    var whole = mantissa
    var frac: Substring = ""
    if let dot = mantissa.firstIndex(of: ".") {
        whole = mantissa[..<dot]
        frac = mantissa[mantissa.index(after: dot)...]
    }
    var digits = String(whole) + frac
    var n = whole.count + exp
    while digits.count > 1, digits.first == "0" { digits.removeFirst(); n -= 1 }
    while digits.count > 1, digits.last == "0" { digits.removeLast() }
    let k = digits.count
    if k <= n && n <= 21 { return digits + String(repeating: "0", count: n - k) }
    if 0 < n && n <= 21 { return String(digits.prefix(n)) + "." + digits.dropFirst(n) }
    if -6 < n && n <= 0 { return "0." + String(repeating: "0", count: -n) + digits }
    let e = n - 1
    let sign = e >= 0 ? "+" : "-"
    let lead = k == 1 ? digits : String(digits.prefix(1)) + "." + digits.dropFirst()
    return lead + "e" + sign + String(abs(e))
}

/// A grid's `columns:` rule read at runtime, for a BOUND value (a named
/// computed): `repeat(auto-fill | auto-fit, minmax(Npx, …))` is an adaptive
/// column of minimum N; `repeat(N, …)` and a run of `fr` units are N flexible
/// columns; anything else is one. The static shapes the emitter's gridCols
/// lowers, minus the responsive floor, which a computed rule states itself.
func specGridColumns(_ v: Any?) -> [GridItem] {
    let s = specString(v)
    func capture(_ pattern: String) -> String? {
        guard let re = try? NSRegularExpression(pattern: pattern),
              let m = re.firstMatch(in: s, range: NSRange(s.startIndex..., in: s)),
              m.numberOfRanges > 1, let r = Range(m.range(at: 1), in: s) else { return nil }
        return String(s[r])
    }
    if let n = capture(#"repeat\(\s*auto-(?:fill|fit)\s*,\s*minmax\(\s*([0-9.]+)px"#), let min = Double(n), min > 0 {
        return [GridItem(.adaptive(minimum: CGFloat(min)))]
    }
    if let n = capture(#"repeat\(\s*([0-9]+)"#), let count = Int(n), count > 0 {
        return Array(repeating: GridItem(.flexible()), count: count)
    }
    let frs = (try? NSRegularExpression(pattern: #"[0-9.]*fr"#))?.numberOfMatches(in: s, range: NSRange(s.startIndex..., in: s)) ?? 0
    if frs > 1 { return Array(repeating: GridItem(.flexible()), count: frs) }
    return [GridItem(.flexible())]
}

/// One row of a KEYED `each`: the element, its offset, and the key that
/// gives its view a stable identity across inserts and deletes.
struct SpecKeyedEntry: Identifiable {
    let key: String
    let offset: Int
    let element: Any
    var id: String { key }
}

/// The list paired with its keys. A key that repeats (or is empty) is made
/// unique with the offset, so ForEach never sees two rows with one id.
func specKeyed(_ arr: [Any], _ keyOf: (Any) -> Any) -> [SpecKeyedEntry] {
    var seen = Set<String>()
    var out: [SpecKeyedEntry] = []
    out.reserveCapacity(arr.count)
    for (i, el) in arr.enumerated() {
        var k = specString(keyOf(el))
        if k.isEmpty || seen.contains(k) { k = k + "#" + String(i) }
        seen.insert(k)
        out.append(SpecKeyedEntry(key: k, offset: i, element: el))
    }
    return out
}

/// Convert a px-string (e.g. "240px", "16", "3.5px") or numeric value to CGFloat.
/// Handles Any values that may be String, Double, or Int at runtime.
func specPx(_ val: Any) -> CGFloat {
    if let d = val as? Double { return CGFloat(d) }
    if let i = val as? Int { return CGFloat(i) }
    if let s = val as? String {
        if s == "auto" || s.isEmpty { return CGFloat(0) }
        // Strip "px" suffix if present, then parse
        let trimmed = s.hasSuffix("px") ? String(s.dropLast(2)) : s
        if let d = Double(trimmed) { return CGFloat(d) }
    }
    return CGFloat(0)
}

/// ViewModifier-style height frame that skips when the value resolves to 0
/// (meaning "auto" or unparseable). This prevents blocks with `height: "auto"`
/// from collapsing to zero.
extension View {
    @ViewBuilder
    func specFrameHeight(_ h: CGFloat, alignment: Alignment = .center) -> some View {
        if h > 0 {
            self.frame(height: h, alignment: alignment)
        } else {
            self
        }
    }
}

/// The width twin, taking the RAW bound value rather than a parsed CGFloat so
/// it can tell "100%" (fill) from "auto" / "" / 0 (no frame) from a length.
/// Without it a bound `width: 'auto'` became `.frame(width: 0)`, and every
/// FilterChip collapsed to its border.
extension View {
    @ViewBuilder
    func specFrameWidth(_ val: Any?, alignment: Alignment = .center) -> some View {
        if let s = _unwrapOptional(val) as? String, s == "100%" {
            self.frame(maxWidth: .infinity, alignment: alignment)
        } else if let f = specPercentFraction(_unwrapOptional(val)) {
            // Any other percent is a fraction of the parent's base, the
            // reading a static percent width gets (Vector #5482; the screen
            // where no parent hosts one). specPx read "55%" as 0, so a
            // skeleton line's `width: width` with '55%' drew no frame, and an
            // empty box with no frame is zero wide (Vector #1281).
            self.specPercentFrame(.width, f, alignment: alignment)
        } else if specPx(_unwrapOptional(val) ?? "") > 0 {
            self.frame(width: specPx(_unwrapOptional(val) ?? ""), alignment: alignment)
        } else {
            self
        }
    }
}

/// A BOUND `padding:`, the CSS shorthand read when the view draws: one length
/// is every edge, two are vertical horizontal, three top horizontal bottom,
/// four top right bottom left. A static shorthand is expanded by the emitter
/// (paddingShorthand); a bound one used to go through specPx, which reads one
/// length, so '0px 14px 8px' padded nothing (Vector I-2463).
func specPaddingInsets(_ val: Any?) -> EdgeInsets {
    let raw = _unwrapOptional(val)
    if let s = raw as? String {
        let parts = s.split(whereSeparator: { $0 == " " || $0 == "\t" }).map { specPx(String($0)) }
        guard (1...4).contains(parts.count) else { return EdgeInsets() }
        let t = parts[0]
        let r = parts.count > 1 ? parts[1] : t
        let b = parts.count > 2 ? parts[2] : t
        let l = parts.count > 3 ? parts[3] : r
        return EdgeInsets(top: t, leading: l, bottom: b, trailing: r)
    }
    let p = specPx(raw ?? "")
    return EdgeInsets(top: p, leading: p, bottom: p, trailing: p)
}

extension View {
    func specPadding(_ val: Any?) -> some View {
        self.padding(specPaddingInsets(val))
    }
}

/// The screen's width, which a percent width is read against. The helpers
/// are also compiled on macOS (the fn parity tests), where there is no
/// UIScreen.
func specScreenWidth() -> CGFloat {
    #if canImport(UIKit)
    return UIScreen.main.bounds.width
    #else
    return 0
    #endif
}

/// The screen's height, the fallback for a percent height with no host.
func specScreenHeight() -> CGFloat {
    #if canImport(UIKit)
    return UIScreen.main.bounds.height
    #else
    return 0
    #endif
}

// MARK: - In-flow percent sizes (Vector #5482)
//
// The web reads `width: 55%` against the parent's content box. SwiftUI has no
// such length, so the PARENT carries `.specPercentHost()`: a Layout probe that
// records the size the parent is OFFERED (the largest finite proposal of a
// pass) and hands it down as `specPercentBase`. Each percent size is
// `.specPercentFrame(prop, fraction)` against that base, falling back to the
// screen until the first pass has run or where no parent hosts one.
//
// The base is never the parent's own resulting size: a parent that hugs its
// content would then be sized from a child sized from it, and shrink (or
// grow) a little every pass (I-5656's runaway). What a parent is offered
// comes from above it, so the child cannot move it.

/// The box an in-flow percent size is read against; nil on an axis not yet read.
struct SpecPercentBase: Equatable {
    var width: CGFloat? = nil
    var height: CGFloat? = nil
}
private struct SpecPercentBaseKey: EnvironmentKey {
    static let defaultValue = SpecPercentBase()
}
extension EnvironmentValues {
    var specPercentBase: SpecPercentBase {
        get { self[SpecPercentBaseKey.self] }
        set { self[SpecPercentBaseKey.self] = newValue }
    }
}

/// Which frame a percent size is, mirroring the px frames the emitter writes.
enum SpecPercentProp { case width, height, minWidth, maxWidth, minHeight, maxHeight }

struct SpecPercentFrameModifier: ViewModifier {
    let prop: SpecPercentProp
    let fraction: CGFloat
    let alignment: Alignment
    @Environment(\.specPercentBase) private var base

    @ViewBuilder
    func body(content: Content) -> some View {
        let w = max((base.width ?? specScreenWidth()) * fraction, 0)
        let h = max((base.height ?? specScreenHeight()) * fraction, 0)
        switch prop {
        case .width: content.frame(width: w, alignment: alignment)
        case .height: content.frame(height: h, alignment: alignment)
        case .minWidth: content.frame(minWidth: w, alignment: alignment)
        case .maxWidth: content.frame(maxWidth: w, alignment: alignment)
        case .minHeight: content.frame(minHeight: h, alignment: alignment)
        case .maxHeight: content.frame(maxHeight: h, alignment: alignment)
        }
    }
}

extension View {
    /// A percent size of the parent's base (`specPercentBase`).
    func specPercentFrame(_ prop: SpecPercentProp, _ fraction: CGFloat, alignment: Alignment = .center) -> some View {
        modifier(SpecPercentFrameModifier(prop: prop, fraction: fraction, alignment: alignment))
    }
    /// Hosts the base a percent-sized child reads: what this box is offered.
    func specPercentHost() -> some View {
        modifier(SpecPercentHostModifier())
    }
}

/// Reads the proposals its one subview is measured with, and lays it out
/// exactly as it would be without the probe. At each placement it reports the
/// largest finite proposal seen since the last one (a stack probes a child
/// with 0 and infinity before it offers the real width).
struct SpecPercentProbe: Layout {
    let report: (SpecPercentBase) -> Void
    struct Seen { var w: CGFloat? = nil; var h: CGFloat? = nil }

    func makeCache(subviews: Subviews) -> Seen { Seen() }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Seen) -> CGSize {
        if let w = proposal.width, w.isFinite, w > 0 { cache.w = max(cache.w ?? 0, w) }
        if let h = proposal.height, h.isFinite, h > 0 { cache.h = max(cache.h ?? 0, h) }
        return subviews.first?.sizeThatFits(proposal) ?? .zero
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Seen) {
        subviews.first?.place(at: bounds.origin, anchor: .topLeading, proposal: proposal)
        let seen = SpecPercentBase(width: cache.w, height: cache.h)
        cache = Seen()
        if seen.width != nil || seen.height != nil { report(seen) }
    }
}

struct SpecPercentHostModifier: ViewModifier {
    @State private var base = SpecPercentBase()

    func body(content: Content) -> some View {
        let state = $base
        return SpecPercentProbe(report: { seen in
            // After the pass, never during it: a state write inside layout
            // is a write during the view update.
            DispatchQueue.main.async {
                let cur = state.wrappedValue
                let next = SpecPercentBase(width: seen.width ?? cur.width, height: seen.height ?? cur.height)
                if specPercentMoved(cur.width, next.width) || specPercentMoved(cur.height, next.height) {
                    state.wrappedValue = next
                }
            }
        }) {
            content.environment(\.specPercentBase, base)
        }
    }
}

/// Whether a base moved by half a point or more (or was read for the first time).
func specPercentMoved(_ a: CGFloat?, _ b: CGFloat?) -> Bool {
    switch (a, b) {
    case (nil, nil): return false
    case let (x?, y?): return abs(x - y) >= 0.5
    default: return true
    }
}
// END specPercentHost

/// "55%" → 0.55; nil for anything that is not a plain percent.
func specPercentFraction(_ val: Any?) -> CGFloat? {
    guard let s = val as? String else { return nil }
    let t = s.trimmingCharacters(in: .whitespaces)
    guard t.hasSuffix("%"), let n = Double(t.dropLast()) else { return nil }
    return CGFloat(n / 100)
}

/// A BOUND `max-width:` (2026-10-19, Vector #980). CSS reads "100%", "none",
/// "auto" and anything it cannot parse as no cap, but specPx reads them as 0,
/// so `.frame(maxWidth: specPx(vm.maxWidth))` crushed Vector's TimeField —
/// `maxWidth: '100%'` from the caller — to a zero-wide column.
func specMaxPx(_ val: Any?) -> CGFloat {
    let px = specPx(_unwrapOptional(val) ?? "")
    return px > 0 ? px : .infinity
}

/// A component's `ariaLabel:` on its native control. Empty keeps the
/// control's own name (a field's placeholder) rather than blanking it.
extension View {
    @ViewBuilder
    func specAccessibilityLabel(_ val: Any?) -> some View {
        let s = specString(_unwrapOptional(val) ?? "")
        if s.isEmpty { self } else { self.accessibilityLabel(s) }
    }
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

/// A registry Slider's range, from min and max as the view model holds them
/// (an Int, a Double or a JSON NSNumber, read through specDouble). `a...b`
/// traps when b < a, which a max still loading as 0 would hit, so the upper
/// bound never falls below the lower (Vector #2852).
func specSliderRange(_ lo: Any?, _ hi: Any?) -> ClosedRange<Double> {
    let a = specDouble(lo)
    return a...max(a, specDouble(hi))
}

/// A registry Pagination's page count: `total` items at `pageSize` a page,
/// rounded up, never below 1 (Vector #2854). A total of 0, a page size of 0
/// or anything unreadable is one page, so the label never says "1 / 0" and
/// nothing divides by zero. `totalPages:` passes its count with a size of 1.
func specPageCount(_ total: Any?, _ pageSize: Any?) -> Int {
    let t = specDouble(total), s = specDouble(pageSize)
    guard t > 0, s > 0, t.isFinite, s.isFinite else { return 1 }
    return max(1, specInt((t / s).rounded(.up)))
}

/// A registry Pagination's page, clamped to 1...count as the web's
/// `currentPage` is (Vector #2854).
func specPageClamp(_ page: Any?, _ count: Int) -> Int {
    return min(max(1, specInt(specDouble(page))), max(1, count))
}

/// A registry RadioGroup's picker style: a segmented bar for a short list,
/// a menu past three choices, where a bar would squeeze every label into one
/// row (Vector #2852). The emitter folds a fixed count of Radio children
/// itself; this decides for bound `options`.
extension View {
    @ViewBuilder
    func specRadioPickerStyle(count: Int) -> some View {
        if count <= 3 { self.pickerStyle(.segmented) } else { self.pickerStyle(.menu) }
    }
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

/// JS `a + b`: numeric addition, or concatenation when either side is text
/// (a map counts, as "[object Object]"), with Kotlin's two deliberate rules:
/// null is "" to text (JS writes "null"), and a list on either side
/// concatenates lists.
///
/// Unwraps Optional<Any> first so "Optional(...)" doesn't leak into display
/// strings. ANY numeric mix adds: a literal at a view call site is a bare
/// Swift Int while a fn body computes Double, and "both Double or both Int"
/// fell through to concatenation, so addDaysISO(winISO, 6) made "20732" + "6"
/// and a week header read "Oct 6 – Aug 22" of 2537. A Bool is 0 or 1 and null
/// is 0, as in JS: `null + null` was "" and a `reduce` sum over [null, 1]
/// made "01" (#1788).
func specAdd(_ a: Any?, _ b: Any?) -> Any {
    let ua = _unwrapOptional(a), ub = _unwrapOptional(b)
    // A list on either side concatenates lists (2026-10-15): an action's
    // `selectedIds = selectedIds + [id]` lowered here and made the STRING
    // "[][\"id\"]", which the shop app then posted as compliance_item_ids —
    // the server read it character by character and refused "[" as a uuid.
    // A null side contributes nothing.
    if ua is [Any] || ub is [Any] {
        var out: [Any] = []
        for side in [ua, ub] where !specIsNil(side) {
            if let l = side as? [Any] { out += l } else { out.append(side!) }
        }
        return out
    }
    func isText(_ v: Any?) -> Bool { v is String || v is [String: Any] || v is NSDictionary }
    if isText(ua) || isText(ub) { return specString(ua) + specString(ub) }
    return specNum(ua) + specNum(ub)
}

/// `length(v)`: UTF-16 code units for a string, JS's count (an emoji is 2,
/// where Swift's `count` of grapheme clusters said 1), elements for a list.
/// Anything else is 0 (Kotlin's deliberate rule 3; JS answers undefined), a
/// map included: it used to count its entries (#1788).
func specLength(_ val: Any?) -> Double {
    guard let v = _unwrapOptional(val) else { return 0 }
    if let s = v as? String { return Double(s.utf16.count) }
    if let a = v as? [Any] { return Double(a.count) }
    return 0.0
}

// JS truthiness, which `as! Bool` is not. A Spec fn leans on it constantly —
// `x || fallback`, `if someString`, `a && b` — and a force-cast TRAPS on every
// value that is not literally a Bool: a dictionary, a string, a number, nil.
func specTruthy(_ v: Any?) -> Bool {
    guard let v = _unwrapOptional(v) else { return false }
    // A JSON null is NSNull, not nil, and fell through to `return true` —
    // so `if leg.actual_out` was taken for every leg the server sent with a
    // null actual_out (fflChip returned no "Not filed" chip on iOS). JS's
    // `if (null)` is false.
    if v is NSNull { return false }
    if let b = v as? Bool { return b }
    if let d = v as? Double { return d != 0 && !d.isNaN }
    if let i = v as? Int { return i != 0 }
    if let s = v as? String { return !s.isEmpty }
    // Every list and map is TRUE, empty or not, as in JS: `[]` and `{}` read
    // false here, which turned `xs || fallback`, `!m` and `m ? a : b` (#1788).
    return true
}

/// `aria-current`'s on/off: truthy, and not the STRING "false", which ARIA
/// reads as off and `specTruthy` reads as a non-empty string. Its on values
/// are words ("page", "step", "true").
func specAriaOn(_ v: Any?) -> Bool {
    guard specTruthy(v) else { return false }
    if let s = _unwrapOptional(v) as? String { return s.lowercased() != "false" }
    return true
}

/// `aria-checked` / `aria-selected`'s on/off: a string is on only when it is
/// "true" ("false" and "mixed" are not selected), as aria-hidden compares its
/// string form; anything else by its truthiness, so a Bool binding is as it was.
func specAriaChecked(_ v: Any?) -> Bool {
    if let s = _unwrapOptional(v) as? String { return s == "true" }
    return specTruthy(v)
}

// A determinate progressbar's stand-in ProgressView (Vector #2800): the span
// of aria-valuemin...aria-valuemax, never empty, and the value measured from
// the minimum, held inside it.
func specProgressTotal(_ lo: Double, _ hi: Double) -> Double {
    return hi > lo ? hi - lo : 1
}

func specProgressValue(_ now: Double, _ lo: Double, _ hi: Double) -> Double {
    return min(max(now - lo, 0), specProgressTotal(lo, hi))
}

// `a || b` and `a && b` in JS yield a VALUE, not a Bool: `extracted || {}` is
// the object. Emitting them as Swift's boolean operators lost the value and
// force-cast both sides on the way.
func specOr(_ a: Any?, _ b: @autoclosure () -> Any?) -> Any? {
    return specTruthy(a) ? a : b()
}

func specAnd(_ a: Any?, _ b: @autoclosure () -> Any?) -> Any? {
    return specTruthy(a) ? b() : a
}

// `x == null` in Spec. NOT Swift's `x == nil`, which answers the wrong
// question here: a fn local is declared `var x: Any`, and an optional assigned
// into an `Any` is BOXED — `Optional<Any>.none` sitting inside a non-optional
// `Any` is not nil, so every `if x == null` guard in an emitted fn passed
// straight through and the arm meant to be skipped ran against a nil.
// JS `Number(v)` — the coercion Spec's arithmetic operators mean.
//
// Deliberately NOT specDouble. specDouble answers 0 for anything it cannot
// read, which is right for a frame size and wrong for a number: `'abc' * 1`
// is NaN in JS, and the whole `let n = v * 1; if isNaN(n)` idiom depends on
// that. Returning 0 there turns unparseable text into a legitimate zero.
//
// null is 0 (JS `Number(null)` is 0, and a fn that cares guards on
// `v == null` first); an empty or whitespace string is 0; a Bool is 0/1; a
// one-element list is its element and any longer list is NaN — all as JS.
func specNum(_ v: Any?) -> Double {
    guard let u = _unwrapOptional(v) else { return 0 }
    // A JSON null is NSNull, not nil. JS's Number(null) is 0; without this the
    // fall-through below answered NaN, and formatCurrency(null) printed "" on
    // iOS where the web printed "$0.00".
    if u is NSNull { return 0 }
    if let d = u as? Double { return d }
    if let i = u as? Int { return Double(i) }
    if let b = u as? Bool { return b ? 1 : 0 }
    if let f = u as? Float { return Double(f) }
    if let s = u as? String { return specStringToNumber(s) }
    // A list is its text read as a number: [] is 0, ["12"] is 12, [1, 2] NaN.
    if u is [Any] { return specStringToNumber(specString(u)) }
    return Double.nan
}

/// ECMAScript WhiteSpace and LineTerminator: what trim(), Number() and
/// parseFloat() skip. Not CharacterSet.whitespacesAndNewlines, which also
/// takes U+0085 and leaves out U+FEFF.
func specIsJsWhitespace(_ u: UInt16) -> Bool {
    switch u {
    case 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x20, 0xA0, 0x1680, 0x2028, 0x2029, 0x202F, 0x205F, 0x3000, 0xFEFF: return true
    default: return u >= 0x2000 && u <= 0x200A
    }
}

/// JS `s.trim()`: whitespace and line terminators off both ends. Swift's
/// `.whitespaces` kept "\n" (#1788).
func specTrim(_ val: Any?) -> String {
    let u = Array(specString(val).utf16)
    var a = 0, b = u.count
    while a < b, specIsJsWhitespace(u[a]) { a += 1 }
    while b > a, specIsJsWhitespace(u[b - 1]) { b -= 1 }
    return String(decoding: u[a..<b], as: UTF16.self)
}

/// JS StringToNumber. Strict where Swift's `Double(_:)` is lenient: "nan",
/// "inf", "0x1p3" are NaN, as in JS; "0x1A", "0b11" and "0o7" are integers.
func specStringToNumber(_ raw: String) -> Double {
    let s = specTrim(raw)
    if s.isEmpty { return 0 }
    switch s {
    case "Infinity", "+Infinity": return .infinity
    case "-Infinity": return -.infinity
    default: break
    }
    let c = Array(s.utf8)
    if c.count > 2, c[0] == 48 {
        let radix: Int
        switch c[1] {
        case 120, 88: radix = 16
        case 98, 66: radix = 2
        case 111, 79: radix = 8
        default: radix = 0
        }
        if radix != 0 {
            var v = 0.0
            for ch in c[2...] {
                guard let d = specDigitValue(Character(UnicodeScalar(ch))), d < radix else { return .nan }
                v = v * Double(radix) + Double(d)
            }
            return v
        }
    }
    // [+-]? (digits [. digits*] | . digits) ([eE] [+-]? digits)?
    var i = 0
    if i < c.count, c[i] == 43 || c[i] == 45 { i += 1 }
    var mantissa = 0
    while i < c.count, c[i] >= 48 && c[i] <= 57 { i += 1; mantissa += 1 }
    if i < c.count, c[i] == 46 {
        i += 1
        while i < c.count, c[i] >= 48 && c[i] <= 57 { i += 1; mantissa += 1 }
    }
    if mantissa == 0 { return .nan }
    if i < c.count, c[i] == 101 || c[i] == 69 {
        i += 1
        if i < c.count, c[i] == 43 || c[i] == 45 { i += 1 }
        var expDigits = 0
        while i < c.count, c[i] >= 48 && c[i] <= 57 { i += 1; expDigits += 1 }
        if expDigits == 0 { return .nan }
    }
    if i != c.count { return .nan }
    return Double(s) ?? .nan
}

/// JS ToPrimitive for the operators: a list is its joined text, a map is
/// "[object Object]", anything else is itself.
private func _specToPrimitive(_ v: Any?) -> Any? {
    let u = _unwrapOptional(v)
    if u is [Any] || u is [String: Any] || u is NSDictionary { return specString(u) }
    return u
}

/// JS ordering over two dynamic values: two strings compare as strings, anything
/// else as numbers, and a side that is not a number (NaN) compares false both
/// ways. Before this both emitters coerced both sides to Double, so a string
/// pair was NaN < NaN — false both ways — and a comparator sort by tail or by
/// ISO instant was a no-op on iOS. Answers nil for the incomparable case.
///
/// A list or map compares as its text (JS ToPrimitive): `"" < [1, 2]` is
/// `"" < "1,2"`, true, where it was false both ways (#1788). Two strings
/// compare by UTF-16 code unit, as JS does; Swift's `<` is Unicode order.
func specOrder(_ a: Any?, _ b: Any?) -> Int? {
    let ua = _specToPrimitive(a), ub = _specToPrimitive(b)
    if let sa = ua as? String, let sb = ub as? String {
        return specCompareUTF16(sa, sb)
    }
    let da = specNum(ua), db = specNum(ub)
    if da.isNaN || db.isNaN { return nil }
    return da == db ? 0 : (da < db ? -1 : 1)
}
func specLt(_ a: Any?, _ b: Any?) -> Bool { if let o = specOrder(a, b) { return o < 0 }; return false }
func specGt(_ a: Any?, _ b: Any?) -> Bool { if let o = specOrder(a, b) { return o > 0 }; return false }
func specLte(_ a: Any?, _ b: Any?) -> Bool { if let o = specOrder(a, b) { return o <= 0 }; return false }
func specGte(_ a: Any?, _ b: Any?) -> Bool { if let o = specOrder(a, b) { return o >= 0 }; return false }

/// `delay("name", ms) { … }` / `clearDelay("name")`: one cancelable timer per
/// name on the view model, as the web's `_timers` map. A new delay under a
/// name cancels the pending one — the debounce "search as you type" is built
/// on — and the body runs on the main actor, where the view model lives.
@MainActor
final class SpecTimers {
    private var tasks: [String: Task<Void, Never>] = [:]
    func delay(_ name: String, _ ms: Double, _ body: @escaping @MainActor () async -> Void) {
        tasks[name]?.cancel()
        let ns = UInt64(max(0, ms.isNaN ? 0 : ms) * 1_000_000)
        tasks[name] = Task { @MainActor in
            try? await Task.sleep(nanoseconds: ns)
            if Task.isCancelled { return }
            await body()
        }
    }
    func clear(_ name: String) { tasks[name]?.cancel(); tasks[name] = nil }
    func clearAll() { for t in tasks.values { t.cancel() }; tasks.removeAll() }
}

/// `Int(d)` TRAPS on NaN and on infinity, and specNum can answer both.
func specInt(_ d: Double) -> Int {
    if d.isNaN { return 0 }
    if d >= Double(Int.max) { return Int.max }
    if d <= Double(Int.min) { return Int.min }
    return Int(d)
}

/// A bound `maxLength:` as SpecTextField / SpecTextEditor take it. A null cap
/// is NO cap, as on the web, where bindAttr removes the attribute (Vector
/// #2228: the registry TextInput binds null when its `maxLength` prop is 0).
/// `specInt(specNum(nil))` answered 0, which clipped every keystroke away.
func specMaxLength(_ v: Any?) -> Int? {
    guard let u = _unwrapOptional(v), !(u is NSNull) else { return nil }
    return specInt(specNum(u))
}

/// The registry TextInput's bound `maxLength:` prop, where 0 is no cap
/// (text-input.spec), as its web input binds null for 0 (Vector
/// bwoody77/vector#4938).
func specTextInputMaxLength(_ v: Any?) -> Int? {
    guard let m = specMaxLength(v), m > 0 else { return nil }
    return m
}

// The clock, as Spec's `nowMs()` and `today()` stdlib pair.
//
// Epoch MILLISECONDS, floored to a whole one: JS `Date.now()` is an integer,
// and `timeIntervalSince1970 * 1000` is not — leaving the fraction on makes
// every derived value disagree with the web in the sub-millisecond digits,
// which is exactly the kind of difference a parity test reports and nobody
// can explain.
func specNowMs() -> Double {
    return (Date().timeIntervalSince1970 * 1000).rounded(.down)
}

// Spec's `uniqueId(prefix)`: "<prefix>-<n>", a fresh n per call. On the web
// it is the id an aria-describedby names; iOS has no element ids, so nothing
// reads it here. It exists so a component that mints one in @state builds.
private let specUniqueIdLock = NSLock()
private var specUniqueIdSeq = 0
func specUniqueId(_ prefix: String) -> String {
    specUniqueIdLock.lock()
    defer { specUniqueIdLock.unlock() }
    specUniqueIdSeq += 1
    return "\(prefix)-\(specUniqueIdSeq)"
}

// Today as "YYYY-MM-DD" in UTC — matching JS's
// `new Date().toISOString().slice(0,10)`, which is UTC and not the device's
// calendar. A local-calendar answer here would be a nicer default and a
// cross-target divergence, and the fns that want a tenant's calendar already
// take an offset and do the arithmetic themselves.
func specToday() -> String {
    let f = DateFormatter()
    f.calendar = Calendar(identifier: .gregorian)
    f.locale = Locale(identifier: "en_US_POSIX")
    f.timeZone = TimeZone(secondsFromGMT: 0)
    f.dateFormat = "yyyy-MM-dd"
    return f.string(from: Date())
}

// The closed Select's text: the label of the option whose value is the
// current one, else the placeholder (flagged, so it can draw secondary).
func specSelectLabel(_ options: Any?, _ value: Any?, _ placeholder: Any?) -> (text: String, isPlaceholder: Bool) {
    let current = specString(value ?? "")
    if let hit = specArr(options).first(where: { specString(specGet($0, "value") ?? "") == current }) {
        let label = specString(specGet(hit, "label") ?? "")
        return (label.isEmpty ? current : label, false)
    }
    let ph = specString(placeholder ?? "")
    return (ph.isEmpty ? (current.isEmpty ? "Select…" : current) : ph, current.isEmpty)
}

// A searchable Select's list for a query (Vector #2691), as select.spec's
// filteredOptions: an empty query keeps every option; otherwise an option
// stays when its label holds the query, ignoring case, or when it is marked
// `pinned` (a trailing action row such as "Add a new issue type…", which a
// search that matches nothing needs most). Order is kept.
func specSelectFilter(_ options: Any?, _ query: String) -> [Any] {
    let all = specArr(options)
    let q = query.lowercased()
    if q.isEmpty { return all }
    return all.filter { specTruthy(specGet($0, "pinned")) || specString(specGet($0, "label") ?? "").lowercased().contains(q) }
}

// `Select(searchable: true)` on iOS (Vector #2691). A Menu cannot hold a text
// field, so the closed field (the emitter's label, the same one the Menu
// draws) opens a sheet: a native search field over the options, the picked
// one ticked, an optional clear row first. A pick writes the selection
// binding, which is how the Menu reports a pick too, and closes the sheet.
struct SpecSearchSelect<FieldLabel: View>: View {
    var title: String
    var options: Any?
    @Binding var selection: String
    var showClear: Bool = false
    var clearLabel: Any? = "Clear selection"
    @ViewBuilder var label: () -> FieldLabel
    @State private var open = false
    @State private var query = ""

    var body: some View {
        Button {
            query = ""
            open = true
        } label: {
            label()
        }
        .buttonStyle(.plain)
        .accessibilityValue(specSelectLabel(options, selection, "").text)
        .sheet(isPresented: $open) {
            let filtered = specSelectFilter(options, query)
            NavigationStack {
                List {
                    if showClear && query.isEmpty {
                        Button { pick("") } label: {
                            Label(specString(clearLabel ?? "Clear selection"), systemImage: "xmark")
                        }
                    }
                    ForEach(Array(filtered.enumerated()), id: \.offset) { _, opt in
                        let value = specString(specGet(opt, "value") ?? "")
                        let sub = specString(specGet(opt, "sub") ?? "")
                        Button { pick(value) } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(verbatim: specOptionLabel(opt)).foregroundStyle(Color.primary)
                                    if !sub.isEmpty { Text(verbatim: sub).font(.footnote).foregroundStyle(Color.secondary) }
                                }
                                Spacer(minLength: 8)
                                if value == selection {
                                    Image(systemName: "checkmark").foregroundStyle(Color.accentColor).accessibilityHidden(true)
                                }
                            }
                            .contentShape(Rectangle())
                        }
                        .accessibilityAddTraits(value == selection ? .isSelected : [])
                    }
                }
                .listStyle(.plain)
                // A search that leaves nothing (Vector #2130) says so, in
                // the phone's language, instead of a blank sheet. Only for a
                // search: options that never loaded are the caller's to say.
                .overlay {
                    if !query.isEmpty && filtered.isEmpty {
                        ContentUnavailableView.search(text: query)
                    }
                }
                // iOS-only placements, guarded so the helpers still build for
                // the macOS swiftc probes the compiler tests run.
                #if os(iOS)
                .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always))
                #else
                .searchable(text: $query)
                #endif
                .navigationTitle(title)
                #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                #endif
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { open = false }
                    }
                }
            }
        }
    }

    private func pick(_ value: String) {
        selection = value
        open = false
    }
}

// A display-format date string <-> Date, for the registry DatePicker. The
// formats are the three numeric ones date-format.spec's pickerDateFormat
// admits — 'MM/DD/YYYY', 'DD/MM/YYYY', 'YYYY-MM-DD' — and anything else reads
// as the first, as it does there. Parsing is by the positions of YYYY / MM /
// DD in the format, the way displayToISO does it, so the two targets accept
// the same strings. Noon UTC, so no calendar rounding can move the day.
func specDateFromDisplay(_ value: Any?, _ fmt: Any?) -> Date {
    let f = specPickerDateFormat(fmt)
    let s = specString(value ?? "")
    guard let yr = f.range(of: "YYYY"), let mr = f.range(of: "MM"), let dr = f.range(of: "DD") else { return Date() }
    func num(_ r: Range<String.Index>, _ len: Int) -> Int? {
        let start = f.distance(from: f.startIndex, to: r.lowerBound)
        guard s.count >= start + len else { return nil }
        let a = s.index(s.startIndex, offsetBy: start)
        let b = s.index(a, offsetBy: len)
        return Int(s[a..<b])
    }
    guard let y = num(yr, 4), let m = num(mr, 2), let d = num(dr, 2), (1...12).contains(m), (1...31).contains(d) else { return Date() }
    var c = DateComponents()
    c.year = y; c.month = m; c.day = d; c.hour = 12
    return specDateCalendar().date(from: c) ?? Date()
}

/// The calendar both edges of the picker read. SwiftUI's DatePicker draws (and
/// keeps the time of day of) its selection in the device's zone, so a day is
/// local noon here. UTC was wrong at both ends: a 9 pm pick in New York wrote
/// tomorrow, and Auckland's picker showed a stored day as the next one.
func specDateCalendar() -> Calendar {
    var cal = Calendar(identifier: .gregorian)
    cal.timeZone = TimeZone.current
    return cal
}

/// Today at local noon, where the empty picker's calendar opens.
func specDateDraftToday() -> Date {
    let cal = specDateCalendar()
    var c = cal.dateComponents([.year, .month, .day], from: Date())
    c.hour = 12
    return cal.date(from: c) ?? Date()
}

// ── Native time picker (Vector #1313) ────────────────────────────────────
// A primitive `textInput(x) { type: 'time' }`. The value is the web time
// input's: "HH:MM", 24-hour, a wall-clock time with no zone. The picker is
// held in GMT on a fixed day, so no device zone or DST change can move the
// minutes between the string and the wheel; the 12/24-hour face follows the
// device's own setting.
func specTimeFromHHMM(_ s: String) -> Date {
    var cal = Calendar(identifier: .gregorian)
    cal.timeZone = TimeZone(identifier: "GMT")!
    let parts = s.split(separator: ":")
    let h = parts.count >= 2 ? Int(parts[0]) ?? 0 : 0
    let m = parts.count >= 2 ? Int(parts[1].prefix(2)) ?? 0 : 0
    let c = DateComponents(year: 2001, month: 1, day: 1, hour: min(max(h, 0), 23), minute: min(max(m, 0), 59))
    return cal.date(from: c) ?? Date(timeIntervalSinceReferenceDate: 0)
}

func specTimeToHHMM(_ d: Date) -> String {
    var cal = Calendar(identifier: .gregorian)
    cal.timeZone = TimeZone(identifier: "GMT")!
    let c = cal.dateComponents([.hour, .minute], from: d)
    return String(format: "%02d:%02d", c.hour ?? 0, c.minute ?? 0)
}

/// True when `s` is a time the web input would hold: "HH:MM" (or with
/// seconds), hours 0-23, minutes 0-59. "" and junk are unset, never midnight.
func specTimeIsHHMM(_ s: String) -> Bool {
    let parts = s.split(separator: ":", omittingEmptySubsequences: false)
    guard parts.count == 2 || parts.count == 3,
          parts[0].count == 2, parts[1].count == 2,
          let h = Int(parts[0]), let m = Int(parts[1]) else { return false }
    return (0...23).contains(h) && (0...59).contains(m)
}

/// The device's wall clock now, as the GMT-held picker date: where an unset
/// field's wheel opens, as the web time input opens on the current time.
func specTimeDraftNow() -> Date {
    let c = Calendar.current.dateComponents([.hour, .minute], from: Date())
    return specTimeFromHHMM(String(format: "%02d:%02d", c.hour ?? 0, c.minute ?? 0))
}

/// `aria-invalid:` as the web reads it: set and not "false" (Vector I-5193).
func specAriaInvalid(_ v: Any?) -> Bool {
    let u = _unwrapOptional(v)
    if specIsNil(u) { return false }
    if let b = u as? Bool { return b }
    let s = specString(u).trimmingCharacters(in: .whitespaces).lowercased()
    return !(s.isEmpty || s == "false")
}

/// SwiftUI's DatePicker always shows a time, so bound straight to "" it drew
/// 00:00 and looked set: a mechanic tapped Extend and was told to pick a time
/// with nothing visibly missing (Vector I-5193). Empty, this draws the
/// `placeholder:` (else "--:--", as Android does) as a row; a tap opens the
/// wheel on the clock's time and writes only on Set. Set, it is the picker as
/// before, 00:00 included. `error` (the textInput's `aria-invalid:`) draws the
/// same red ring as the date field beside it.
struct SpecTimePicker: View {
    @Binding var text: String
    var wheel: Bool = false
    var disabled: Bool = false
    var placeholder: String = ""
    var error: Bool = false
    @State private var choosing = false
    @State private var draft = Date()

    private var shownPlaceholder: String { placeholder.isEmpty ? "--:--" : placeholder }

    var body: some View {
        field.specFieldError(error, message: "")
    }

    @ViewBuilder private var field: some View {
        if specTimeIsHHMM(text) {
            setPicker
        } else {
            Button {
                draft = specTimeDraftNow()
                choosing = true
            } label: {
                Text(shownPlaceholder).foregroundStyle(.secondary)
            }
            .accessibilityValue(shownPlaceholder)
            .disabled(disabled)
            .sheet(isPresented: $choosing) {
                NavigationStack {
                    wheelPicker
                        .padding(.horizontal)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) { Button("Cancel") { choosing = false } }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Set") { text = specTimeToHHMM(draft); choosing = false }
                            }
                        }
                }
                .presentationDetents([.medium])
            }
        }
    }

    @ViewBuilder private var wheelPicker: some View {
        let p = DatePicker("", selection: $draft, displayedComponents: .hourAndMinute)
            .labelsHidden()
            .environment(\.timeZone, TimeZone(identifier: "GMT")!)
        #if canImport(UIKit)
        p.datePickerStyle(.wheel)
        #else
        p.datePickerStyle(.compact)
        #endif
    }

    @ViewBuilder private var setPicker: some View {
        let picker = DatePicker("", selection: Binding(
            get: { specTimeFromHHMM(text) },
            set: { let v = specTimeToHHMM($0); if v != text { text = v } }
        ), displayedComponents: .hourAndMinute)
            .labelsHidden()
            .environment(\.timeZone, TimeZone(identifier: "GMT")!)
            .disabled(disabled)
        #if canImport(UIKit)
        if wheel {
            picker.datePickerStyle(.wheel)
        } else {
            picker.datePickerStyle(.compact)
        }
        #else
        // macOS has no wheel; the helpers compile there for the fn tests.
        picker.datePickerStyle(.compact)
        #endif
    }
}

// ── Native segmented Picker (Vector #1289) ───────────────────────────────
// A `role: "radiogroup"` block with `data-ios-picker: 'segmented'` is a
// SpecSegmentedHost; every `role: "radio"` button is a SpecSegmentRadio. A
// hosted radio draws nothing and reports itself through SpecSegmentKey; the
// host draws one segmented Picker from the reports, in view order. The
// radios can therefore come from a loop, a slot or another component.

/// One radio's report. Equal by what the Picker shows, so a re-render that
/// changes nothing does not re-set the host's state.
struct SpecSegmentItem: Equatable, @unchecked Sendable {
    let label: String
    let checked: Bool
    let disabled: Bool
    let pick: () -> Void
    static func == (a: SpecSegmentItem, b: SpecSegmentItem) -> Bool {
        a.label == b.label && a.checked == b.checked && a.disabled == b.disabled
    }
}

struct SpecSegmentKey: PreferenceKey {
    static let defaultValue: [SpecSegmentItem] = []
    static func reduce(value: inout [SpecSegmentItem], nextValue: () -> [SpecSegmentItem]) {
        value.append(contentsOf: nextValue())
    }
}

private struct SpecSegmentHostedKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var specSegmentHosted: Bool {
        get { self[SpecSegmentHostedKey.self] }
        set { self[SpecSegmentHostedKey.self] = newValue }
    }
}

struct SpecSegmentRadio<Content: View>: View {
    let label: String
    let checked: Bool
    let disabled: Bool
    let pick: () -> Void
    @ViewBuilder let content: () -> Content
    @Environment(\.specSegmentHosted) private var hosted

    var body: some View {
        if hosted {
            Color.clear
                .frame(width: 0, height: 0)
                .preference(key: SpecSegmentKey.self,
                            value: [SpecSegmentItem(label: label, checked: checked, disabled: disabled, pick: pick)])
        } else {
            content()
        }
    }
}

struct SpecSegmentedHost<Content: View>: View {
    let enabled: Bool
    let label: String
    let fill: Bool
    @ViewBuilder let content: () -> Content
    @State private var items: [SpecSegmentItem] = []

    var body: some View {
        if enabled {
            // A segmented Picker cannot disable one segment, so a disabled
            // option is refused here: the selection stays where it was.
            let selection = Binding<Int>(
                get: { items.firstIndex(where: { $0.checked }) ?? -1 },
                set: { i in
                    guard items.indices.contains(i), !items[i].disabled else { return }
                    items[i].pick()
                }
            )
            let picker = Picker(label, selection: selection) {
                ForEach(Array(items.enumerated()), id: \.offset) { i, item in
                    Text(item.label).tag(i)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .accessibilityLabel(label)
            Group {
                if fill { picker.frame(maxWidth: .infinity) } else { picker.fixedSize() }
            }
            // The radios stay mounted, unseen, so their reports keep coming.
            .background(
                content()
                    .environment(\.specSegmentHosted, true)
                    .hidden()
                    .accessibilityHidden(true)
            )
            .onPreferenceChange(SpecSegmentKey.self) { reported in
                MainActor.assumeIsolated { items = reported }
            }
        } else {
            content()
        }
    }
}

/// A native field's error state, as the web field and the iOS TextInput draw
/// it: the destructive ring around the field, the message under it, and the
/// message as the field's VoiceOver hint. One look for the DatePicker
/// (Vector #840) and the Select (Vector #1716). `inset` pads the field inside
/// the ring (a compact DatePicker draws its own capsule); a field with its own
/// box passes 0 and its `cornerRadius`, so the ring lies on its border.
struct SpecFieldErrorModifier: ViewModifier {
    let error: Bool
    let message: String
    var cornerRadius: CGFloat = 6
    var inset: CGFloat = 4

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            content
                .padding(error ? inset : 0)
                .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(error ? ThemeManager.shared.color("destructive") : Color.clear, lineWidth: 1.5))
                .accessibilityHint(error ? message : "")
            if error && !message.isEmpty {
                Text(message)
                    .font(.footnote)
                    .foregroundStyle(ThemeManager.shared.color("destructive"))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

extension View {
    func specFieldError(_ error: Bool, message: String, cornerRadius: CGFloat = 6, inset: CGFloat = 4) -> some View {
        modifier(SpecFieldErrorModifier(error: error, message: message, cornerRadius: cornerRadius, inset: inset))
    }
}

/// The registry DatePicker on iOS. SwiftUI's DatePicker always shows a date,
/// so bound straight to an empty value it drew today and looked set. Empty,
/// this draws the placeholder as a row; a tap opens a calendar that saves on
/// Set only, so no date is written by looking. Set, it is the compact picker
/// plus Clear, which writes "" back as the web picker's clear does.
struct SpecOptionalDatePicker: View {
    @Binding var text: String
    let format: Any?
    let placeholder: String
    /// What VoiceOver calls the field (specDatePickerName).
    let name: String
    let disabled: Bool
    let error: Bool
    let errorMessage: String
    /// Clear as the ⓧ glyph rather than the word: a primitive date input sits
    /// two to a row (Vector #1282, Days Off), where two pickers and two
    /// "Clear"s overflow a phone and the word wraps to "Cle / ar".
    let iconClear: Bool
    @State private var choosing = false
    @State private var draft = Date()

    init(text: Binding<String>, format: Any?, placeholder: Any?, label: Any? = "", ariaLabel: Any? = "",
         disabled: Bool = false, error: Bool = false, errorMessage: Any? = "", iconClear: Bool = false) {
        self.iconClear = iconClear
        self._text = text
        self.format = format
        let ph = specString(placeholder ?? "")
        self.placeholder = ph.isEmpty ? "Set a date" : ph
        self.name = specDatePickerName(ariaLabel, label)
        self.disabled = disabled
        self.error = error
        self.errorMessage = specString(errorMessage ?? "")
    }

    private var isSet: Bool { specDateIsDisplay(text, format) }

    // `error` / `errorMessage`: the red ring and the line under the field, as
    // the web picker and the iOS TextInput draw them. Dropped, a date the page
    // refused looked fine and Save did nothing (Vector #840, Mx confirm sheet).
    var body: some View {
        field.specFieldError(error, message: errorMessage)
    }

    @ViewBuilder private var field: some View {
        if isSet {
            HStack(spacing: iconClear ? 6 : 12) {
                // Named, and the name kept when the label is hidden: "" here
                // left VoiceOver nothing to say (Vector #1663).
                DatePicker(name, selection: Binding(
                    get: { specDateFromDisplay(text, format) },
                    set: { text = specDateToDisplay($0, format) }
                ), displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                if !disabled && iconClear {
                    Button { text = "" } label: {
                        Image(systemName: "xmark.circle.fill").foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Clear date")
                } else if !disabled {
                    Button("Clear") { text = "" }
                        .font(.subheadline)
                        .accessibilityLabel("Clear date")
                }
            }
            .disabled(disabled)
        } else {
            Button {
                draft = specDateDraftToday()
                choosing = true
            } label: {
                Text(placeholder).foregroundStyle(.secondary)
            }
            // The field's name, its words the value: "Defer until, Pick a
            // date", as the web's named input reads its placeholder.
            .accessibilityLabel(name)
            .accessibilityValue(placeholder)
            .disabled(disabled)
            .sheet(isPresented: $choosing) {
                NavigationStack {
                    DatePicker(name, selection: $draft, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding(.horizontal)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) { Button("Cancel") { choosing = false } }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Set") { text = specDateToDisplay(draft, format); choosing = false }
                            }
                        }
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
}

/// The date field's accessible name, the web DatePicker's chain: `ariaLabel`,
/// else `label`, else "Date picker" (date-picker.spec; the same words are its
/// catalog key, and the iOS build is English only).
func specDatePickerName(_ ariaLabel: Any?, _ label: Any?) -> String {
    let aria = specString(_unwrapOptional(ariaLabel))
    if !aria.isEmpty { return aria }
    let lbl = specString(_unwrapOptional(label))
    return lbl.isEmpty ? "Date picker" : lbl
}

/// What VoiceOver calls a labelled field (TextInput, DatePicker): `ariaLabel`,
/// else the visible `label`, as the web's registry fields name their control.
/// "" when both are, so the caller keeps whatever name the control had.
func specFieldName(_ ariaLabel: Any?, _ label: Any?) -> String {
    let aria = specString(_unwrapOptional(ariaLabel))
    return aria.isEmpty ? specString(_unwrapOptional(label)) : aria
}

/// True when a field's name already speaks its visible label, so the label
/// Text above it is hidden from VoiceOver (Vector #1840). Read, it made a swipe
/// say "Defer until", then "Defer until, Pick a date". A different ariaLabel
/// keeps the label readable: its words are said nowhere else.
func specLabelNamesField(_ ariaLabel: Any?, _ label: Any?) -> Bool {
    let aria = specString(_unwrapOptional(ariaLabel))
    return aria.isEmpty || aria == specString(_unwrapOptional(label))
}

/// True when `value` parses as a date in `fmt`; "" and junk are unset.
func specDateIsDisplay(_ value: Any?, _ fmt: Any?) -> Bool {
    let s = specString(value ?? "")
    if s.isEmpty { return false }
    let d = specDateFromDisplay(s, fmt)
    return specDateToDisplay(d, fmt) == s
}

func specDateToDisplay(_ date: Date, _ fmt: Any?) -> String {
    let c = specDateCalendar().dateComponents([.year, .month, .day], from: date)
    let y = String(format: "%04d", c.year ?? 0), m = String(format: "%02d", c.month ?? 0), d = String(format: "%02d", c.day ?? 0)
    switch specPickerDateFormat(fmt) {
    case "DD/MM/YYYY": return "\(d)/\(m)/\(y)"
    case "YYYY-MM-DD": return "\(y)-\(m)-\(d)"
    default: return "\(m)/\(d)/\(y)"
    }
}

private func specPickerDateFormat(_ fmt: Any?) -> String {
    let f = specString(fmt ?? "")
    return ["MM/DD/YYYY", "DD/MM/YYYY", "YYYY-MM-DD"].contains(f) ? f : "MM/DD/YYYY"
}

// JS `a ?? b` — null/undefined only, never merely falsy. Separate from
// specOr on purpose: `0 ?? 60` is 0 and `0 || 60` is 60.
func specCoalesce(_ a: Any?, _ b: @autoclosure () -> Any?) -> Any? {
    return specIsNil(a) ? b() : a
}

// JS `parseFloat` — leading whitespace skipped, the LONGEST numeric prefix
// taken, NaN when there is none. "12.5kg" is 12.5 and "abc" is NaN; neither
// is an error.
func specParseFloat(_ v: Any?) -> Double {
    let s = Array(specString(v).trimmingCharacters(in: .whitespacesAndNewlines))
    var i = 0
    var out = ""
    if i < s.count, s[i] == "+" || s[i] == "-" { out.append(s[i]); i += 1 }
    if s[i...].starts(with: Array("Infinity")) { return out.hasPrefix("-") ? -.infinity : .infinity }
    var sawDigit = false, sawDot = false
    while i < s.count {
        let c = s[i]
        if c.isNumber { out.append(c); sawDigit = true; i += 1 }
        else if c == "." && !sawDot { out.append(c); sawDot = true; i += 1 }
        else { break }
    }
    if !sawDigit { return Double.nan }
    // Exponent, only when it is complete — JS reads "1e" as 1.
    if i < s.count, s[i] == "e" || s[i] == "E" {
        var j = i + 1
        var exp = String(s[i])
        if j < s.count, s[j] == "+" || s[j] == "-" { exp.append(s[j]); j += 1 }
        var expDigits = false
        while j < s.count, s[j].isNumber { exp.append(s[j]); expDigits = true; j += 1 }
        if expDigits { out += exp }
    }
    return Double(out) ?? Double.nan
}

// JS `parseInt` — the same longest-prefix rule in a radix, so "3.7" is 3 and
// "12abc" is 12. A radix of 0 is an omitted one: base 10, or 16 after a
// leading 0x ("0x1A" is 26; the emitter passed 10 and got 0, #1788). Radix 16
// accepts the 0x too, as JS does.
func specParseInt(_ v: Any?, _ radix: Int) -> Double {
    var s = Substring(specTrim(specJsString(v)))
    var neg = false
    if s.first == "+" { s = s.dropFirst() }
    else if s.first == "-" { neg = true; s = s.dropFirst() }
    var r = (radix == 0) ? 10 : radix
    // JS answers NaN for a radix outside 2...36; `Int(_:radix:)` TRAPPED on
    // one (Vector #1639).
    guard (2...36).contains(r) else { return Double.nan }
    if radix == 0 || radix == 16, s.lowercased().hasPrefix("0x") { s = s.dropFirst(2); r = 16 }
    var digits = ""
    var val = 0.0
    for c in s {
        guard let d = specDigitValue(c), d < r else { break }
        digits.append(c)
        val = val * Double(r) + Double(d)
    }
    guard !digits.isEmpty else { return Double.nan }
    // Radix 10 through Double's own parser, which rounds a long digit run
    // exactly as JS does; the running sum is only exact up to 2^53.
    if r == 10, let exact = Double(digits) { val = exact }
    return neg ? -val : val
}

/// An ASCII digit or letter's value as a radix digit (a/A = 10 … z/Z = 35).
private func specDigitValue(_ c: Character) -> Int? {
    guard let a = c.asciiValue else { return nil }
    switch a {
    case 48...57: return Int(a) - 48
    case 97...122: return Int(a) - 87
    case 65...90: return Int(a) - 55
    default: return nil
    }
}

/// `toString(x, radix)`: JS's Number.prototype.toString(radix), fraction
/// included ((3.5).toString(2) is "11.1"), and past Int.max the digits V8
/// writes. `String(_:radix:)` dropped the fraction and clamped to Int.max
/// (#1788); it TRAPS on a radix outside 2...36, where JS throws, and a
/// non-finite x has no Int at all, so both print base 10 (Vector #1639).
func specRadixString(_ v: Double, _ radix: Int) -> String {
    guard v.isFinite, (2...36).contains(radix), radix != 10 else { return specNumberText(v) }
    return specDoubleToRadix(v, radix)
}

/// V8's DoubleToRadixCString (src/numbers/conversions.cc), for a finite value
/// and a radix other than 10. Kotlin's specToString runs the same steps.
private func specDoubleToRadix(_ valueArg: Double, _ radix: Int) -> String {
    let chars = Array("0123456789abcdefghijklmnopqrstuvwxyz")
    var value = valueArg
    let negative = value < 0
    if negative { value = -value }
    var integer = value.rounded(.down)
    var fraction = value - integer
    // Fraction digits only as far as the input double's own precision.
    var delta = max(Double.leastNonzeroMagnitude, 0.5 * (value.nextUp - value))
    var frac: [Int] = []
    if fraction >= delta {
        repeat {
            fraction *= Double(radix)
            delta *= Double(radix)
            let digit = Int(fraction)
            frac.append(digit)
            fraction -= Double(digit)
            // Round to even.
            if fraction > 0.5 || (fraction == 0.5 && digit & 1 == 1), fraction + delta > 1 {
                // Carry back through the digits already written.
                while true {
                    guard let last = frac.popLast() else { integer += 1; break }
                    if last + 1 < radix { frac.append(last + 1); break }
                }
                break
            }
        } while fraction >= delta
    }
    // Integer digits; past 2^53 the low ones are not represented, so they are 0.
    var whole: [Character] = []
    while integer / Double(radix) >= 9007199254740992.0 {
        integer /= Double(radix)
        whole.append("0")
    }
    repeat {
        let remainder = integer.truncatingRemainder(dividingBy: Double(radix))
        whole.append(chars[Int(remainder)])
        integer = (integer - remainder) / Double(radix)
    } while integer > 0
    let fracText = frac.isEmpty ? "" : "." + String(frac.map { chars[$0] })
    return (negative ? "-" : "") + String(whole.reversed()) + fracText
}

/// `range(start, end)` and `range(start, end, step)`, as the JS emission's
/// `Array.from({ length })`: start, start + step, … for end − start elements
/// (ceil((end − start) / step) with a step), so range(0.5, 3) is [0.5, 1.5]
/// where truncating the bounds said [0, 1, 2] (#1788). A range that runs the
/// wrong way, or a zero step (JS throws), is empty; `start..<end` and
/// `stride(by: 0)` TRAPPED on those (Vector #1639).
func specRange(_ start: Double, _ end: Double, _ step: Double? = nil) -> [Double] {
    let st = step ?? 1
    let count = step == nil ? end - start : ((end - start) / st).rounded(.up)
    guard count.isFinite, count >= 1, count < Double(Int.max) else { return [] }
    return (0..<Int(count)).map { start + Double($0) * st }
}

/// `fromEntries(list)`: JS `Object.fromEntries`, where a repeated key keeps
/// the LAST value. `Dictionary(uniqueKeysWithValues:)` TRAPPED on a repeat,
/// and `as! String` on a non-string key (Vector #1639); JS writes the key as
/// text. An entry that is not a list of two is skipped.
func specFromEntries(_ list: Any?) -> [String: Any] {
    var out: [String: Any] = [:]
    for e in specArr(list) {
        let pair = specArr(e)
        guard pair.count >= 2 else { continue }
        out[specPropertyKey(pair[0])] = pair[1]
    }
    return out
}

/// A map's keys in JS's order as far as this target can give it: integer-like
/// keys ("0", "2", "10") first, ascending, as JS lists them. JS lists the rest
/// in INSERTION order, which a Swift Dictionary does not keep (nor does a
/// JSONSerialization NSDictionary), so the rest come sorted, which at least
/// answers the same on every launch; dictionary order changed per process.
private func specOrderedKeys(_ m: Any) -> [String] {
    var all: [String] = []
    if let d = m as? [String: Any] { all = Array(d.keys) }
    else if let nd = m as? NSDictionary { all = nd.allKeys.map { specPropertyKey($0) } }
    func index(_ k: String) -> UInt64? {
        guard let n = UInt64(k), String(n) == k, n < 4294967295 else { return nil }
        return n
    }
    let indices = all.compactMap { k in index(k).map { (k, $0) } }.sorted { $0.1 < $1.1 }.map { $0.0 }
    let rest = all.filter { index($0) == nil }.sorted { specCompareUTF16($0, $1) < 0 }
    return indices + rest
}

/// `keys(v)`: a map's keys (see specOrderedKeys), a list's or a string's
/// indices as text, as JS's Object.keys. Anything else is [].
func specKeys(_ v: Any?) -> [Any] {
    let u = _unwrapOptional(v)
    if let a = u as? [Any] { return a.indices.map { String($0) } }
    if let s = u as? String { return (0..<s.utf16.count).map { String($0) } }
    if let u, u is [String: Any] || u is NSDictionary { return specOrderedKeys(u) }
    return []
}

/// `values(v)`, in the order specKeys lists the keys: a list's elements, a
/// string's UTF-16 units.
func specValues(_ v: Any?) -> [Any] {
    let u = _unwrapOptional(v)
    if let a = u as? [Any] { return a }
    if u is String { return specKeys(u).map { specGet(u, $0) ?? (Optional<Any>.none as Any) } }
    if let u, u is [String: Any] || u is NSDictionary {
        return specOrderedKeys(u).map { specGet(u, $0) ?? (Optional<Any>.none as Any) }
    }
    return []
}

/// `entries(v)`: `[key, value]` pairs, in the order specKeys lists the keys.
func specEntries(_ v: Any?) -> [Any] {
    return specKeys(v).map { [$0, specGet(v, $0) ?? (Optional<Any>.none as Any)] as [Any] }
}

/// `haversine(lat1, lng1, lat2, lng2)`: great-circle metres on a 6,371 km
/// sphere, the JS emission's formula term for term. ir-to-swift has always
/// called this; it was never written, so a fn using it did not build for iOS
/// (Vector #1639).
func specHaversine(_ lat1: Double, _ lng1: Double, _ lat2: Double, _ lng2: Double) -> Double {
    let r = 6371e3
    let dLat = (lat2 - lat1) * Double.pi / 180
    let dLng = (lng2 - lng1) * Double.pi / 180
    let a = pow(sin(dLat / 2), 2) + cos(lat1 * Double.pi / 180) * cos(lat2 * Double.pi / 180) * pow(sin(dLng / 2), 2)
    return r * 2 * atan2(sqrt(a), sqrt(1 - a))
}

/// `bearing(lat1, lng1, lat2, lng2)`: initial course in degrees from north,
/// 0 up to 360, as the JS emission computes it (Vector #1639, as above).
func specBearing(_ lat1: Double, _ lng1: Double, _ lat2: Double, _ lng2: Double) -> Double {
    let la1 = lat1 * Double.pi / 180
    let la2 = lat2 * Double.pi / 180
    let dLng = (lng2 - lng1) * Double.pi / 180
    let y = sin(dLng) * cos(la2)
    let x = cos(la1) * sin(la2) - sin(la1) * cos(la2) * cos(dLng)
    return (atan2(y, x) * 180 / Double.pi + 360).truncatingRemainder(dividingBy: 360)
}

/// `deepMerge(a, b)`: two maps merge key by key, recursively; anything else
/// in `b` (a list, a scalar, null) replaces `a`. The JS emission's rule; on
/// this target null and undefined are one value, so a null `b` replaces too,
/// as Kotlin's does. Called by ir-to-swift, never written (Vector #1639).
func deepMerge(_ a: Any?, _ b: Any?) -> Any {
    let ua = _unwrapOptional(a), ub = _unwrapOptional(b)
    if let ma = ua.flatMap({ $0 as? [String: Any] }), let mb = ub.flatMap({ $0 as? [String: Any] }) {
        var out = ma
        for (k, v) in mb { out[k] = deepMerge(ma[k], v) }
        return out
    }
    return ub ?? (Optional<Any>.none as Any)
}

// JS `Math.round`: half toward +Infinity. Swift's `.rounded()` is half away
// from zero, so the two disagree on every negative half — Math.round(-2.5)
// is -2, (-2.5).rounded() is -3. A margin, a delta and a temperature are all
// routinely negative, and the difference is a whole unit.
//
// Not floor(v + 0.5), whose add rounds: 4503599627370497 + 0.5 is
// 4503599627370498 (#1788), and 0.49999999999999994 + 0.5 is 1.
func specRound(_ v: Double) -> Double {
    if v.isNaN || v.isInfinite { return v }
    let f = v.rounded(.down)
    let r = v - f >= 0.5 ? f + 1 : f
    return r == 0 && v < 0 ? -0.0 : r
}

/// `isNaN(x)`: JS Number.isNaN, true only for the number NaN. Text is not
/// coerced, so isNaN("abc") is false (#1788); the idiom `isNaN(v * 1)`
/// coerces first.
func specIsNaN(_ v: Any?) -> Bool {
    if case let .num(d) = _specKind(v) { return d.isNaN }
    return false
}

/// `min(a, b, …)`: JS Math.min, so NaN anywhere is NaN and -0 is below 0.
/// Swift's `min` skipped a NaN (#1788).
func specMin(_ xs: Any?...) -> Double {
    var acc = Double.infinity
    for x in xs {
        let d = specNum(x)
        if d.isNaN { return .nan }
        if d < acc || (d == 0 && acc == 0 && d.sign == .minus) { acc = d }
    }
    return acc
}

/// `max(a, b, …)`: JS Math.max.
func specMax(_ xs: Any?...) -> Double {
    var acc = -Double.infinity
    for x in xs {
        let d = specNum(x)
        if d.isNaN { return .nan }
        if d > acc || (d == 0 && acc == 0 && acc.sign == .minus) { acc = d }
    }
    return acc
}

// JS `Number.prototype.toFixed`.
//
// NOT `String(format: "%.Nf")`, which rounds half to EVEN: (0.25).toFixed(1)
// is "0.3" in JS and "0.2" through printf, and (0.125).toFixed(2) is "0.13"
// against "0.12". The cases that differ are exactly the ones a person would
// check by hand.
//
// Scaling by a power of ten and rounding is NOT the fix — it introduces its
// own error and gets (8.345).toFixed(2) wrong, which printf gets right. So
// this works on the double's EXACT decimal expansion (a binary double always
// has a finite one) and applies JS's half-away-from-zero rule to the digit
// string. 60 places is past the end of that expansion for any value this is
// reachable with, so a tail of "5000…" is an exact half and nothing else is.
//
// JS takes 0...100 digits (this stopped at 20), and from 1e21 up prints the
// number as String(x) would ("1e+21"), #1788.
func specToFixed(_ v: Double, _ digits: Int) -> String {
    if v.isNaN { return "NaN" }
    if abs(v) >= 1e21 { return specNumberText(v) }
    let d = max(0, min(100, digits))
    let neg = v < 0
    let exact = String(format: "%.\(max(60, d + 1))f", abs(v))
    let parts = exact.split(separator: ".", maxSplits: 1)
    var intPart = Array(String(parts[0]))
    var frac = Array(parts.count > 1 ? String(parts[1]) : "")
    while frac.count < d + 1 { frac.append("0") }

    // Round half away from zero at position d.
    let tail = frac[d...]
    let first = tail.first!
    var roundUp = false
    if first > "5" { roundUp = true }
    else if first == "5" { roundUp = true }   // exact half OR more — both round up
    frac = Array(frac[0..<d])

    if roundUp {
        var i = frac.count - 1
        var carry = true
        while carry && i >= 0 {
            if frac[i] == "9" { frac[i] = "0"; i -= 1 }
            else { frac[i] = Character(String(Int(String(frac[i]))! + 1)); carry = false }
        }
        if carry {
            var j = intPart.count - 1
            while carry && j >= 0 {
                if intPart[j] == "9" { intPart[j] = "0"; j -= 1 }
                else { intPart[j] = Character(String(Int(String(intPart[j]))! + 1)); carry = false }
            }
            if carry { intPart.insert("1", at: 0) }
        }
    }
    let body = d > 0 ? String(intPart) + "." + String(frac) : String(intPart)
    // The sign follows the INPUT, not the result: JS (-0.04).toFixed(1) is
    // "-0.0". Negative zero itself is not negative (-0 < 0 is false), which is
    // why (-0).toFixed(1) is "0.0" — the same test gives both answers.
    return neg ? "-" + body : body
}

/// `x == null` in Spec. NSNull counts: every value a fn reads off the server
/// comes through JSONSerialization, which decodes a JSON `null` as NSNull, so
/// unwrapping Optionals alone answered "not null" for exactly the fields a
/// null guard exists for. A web `== null` is true for both.
func specIsNil(_ v: Any?) -> Bool {
    guard let u = _unwrapOptional(v) else { return true }
    return u is NSNull
}

/// -1, 0 or 1: two strings by UTF-16 code unit, JS's string order.
func specCompareUTF16(_ a: String, _ b: String) -> Int {
    var ia = a.utf16.makeIterator(), ib = b.utf16.makeIterator()
    while true {
        switch (ia.next(), ib.next()) {
        case (nil, nil): return 0
        case (nil, _): return -1
        case (_, nil): return 1
        case let (x?, y?): if x != y { return x < y ? -1 : 1 }
        }
    }
}

/// A Spec value sorted into JS's kinds, for `==` and `===`.
private enum _SpecKind {
    case null, bool(Bool), num(Double), str(String), object(Any)
}

private func _specKind(_ v: Any?) -> _SpecKind {
    guard let u = _unwrapOptional(v), !(u is NSNull) else { return .null }
    if let s = u as? String { return .str(s) }
    // A JSON boolean is a CFBoolean NSNumber, which also casts to Double.
    if let n = u as? NSNumber, CFGetTypeID(n) == CFBooleanGetTypeID() { return .bool(n.boolValue) }
    if let d = u as? Double { return .num(d) }
    if let i = u as? Int { return .num(Double(i)) }
    if let b = u as? Bool { return .bool(b) }
    if let f = u as? Float { return .num(Double(f)) }
    return .object(u)
}

/// Two objects are `==` only when they are the SAME object. A server row
/// (NSDictionary / NSArray) is a reference, so the row a view stored is equal
/// to itself; a list or map Spec code built is a Swift value with no identity,
/// so it equals nothing, as two separately built JS objects never do.
private func _specSameObject(_ a: Any, _ b: Any) -> Bool {
    guard type(of: a) is AnyClass, type(of: b) is AnyClass else { return false }
    return (a as AnyObject) === (b as AnyObject)
}

/// JS loose `a == b`, which is what Spec's `==` means. It compared the two
/// sides' TEXT, so `null == ""` was true and `true == 1`, `0 == ""` and
/// `[] == false` were false (#1788).
func specEq(_ a: Any?, _ b: Any?) -> Bool {
    return _specLooseEq(_specKind(a), _specKind(b))
}

func specNeq(_ a: Any?, _ b: Any?) -> Bool {
    return !specEq(a, b)
}

private func _specLooseEq(_ x: _SpecKind, _ y: _SpecKind) -> Bool {
    switch (x, y) {
    case (.null, .null): return true
    case (.null, _), (_, .null): return false
    case let (.num(p), .num(q)): return p == q
    case let (.str(p), .str(q)): return p.utf16.elementsEqual(q.utf16)
    case let (.bool(p), .bool(q)): return p == q
    case let (.object(p), .object(q)): return _specSameObject(p, q)
    case let (.num(p), .str(q)): return p == specStringToNumber(q)
    case let (.str(p), .num(q)): return specStringToNumber(p) == q
    case let (.bool(p), _): return _specLooseEq(.num(p ? 1 : 0), y)
    case let (_, .bool(q)): return _specLooseEq(x, .num(q ? 1 : 0))
    case let (_, .object(q)): return _specLooseEq(x, _specPrimitiveKind(q))
    case let (.object(p), _): return _specLooseEq(_specPrimitiveKind(p), y)
    }
}

/// An object's ToPrimitive as a kind; something with no text of its own (a
/// closure, a Date) is null here, which equals nothing but null.
private func _specPrimitiveKind(_ o: Any) -> _SpecKind {
    let k = _specKind(_specToPrimitive(o))
    if case .object = k { return .null }
    return k
}

/// JS `===` (strict), for `indexOf` over a list.
func specStrictEq(_ a: Any?, _ b: Any?) -> Bool {
    switch (_specKind(a), _specKind(b)) {
    case (.null, .null): return true
    case let (.num(p), .num(q)): return p == q
    case let (.str(p), .str(q)): return p.utf16.elementsEqual(q.utf16)
    case let (.bool(p), .bool(q)): return p == q
    case let (.object(p), .object(q)): return _specSameObject(p, q)
    default: return false
    }
}

/// JS SameValueZero, for `includes` over a list: `===`, except NaN finds NaN.
func specSameValueZero(_ a: Any?, _ b: Any?) -> Bool {
    if case let .num(p) = _specKind(a), case let .num(q) = _specKind(b), p.isNaN, q.isNaN { return true }
    return specStrictEq(a, b)
}

/// Unwrap nested Optional<Any> wrappers so `as? [Any]` can succeed against
/// values that arrive through `Any?` pipelines (e.g. ViewModel state).
///
/// Through a protocol every Optional conforms to, not `Mirror`: this runs on
/// every specGet / specIsNil, so a view body reading a server row pays it per
/// field, and building a Mirror per call was the second-largest cost in a row
/// body after specGet's dictionary cast (Vector #766).
private func _unwrapOptional(_ val: Any?) -> Any? {
    guard let v = val else { return nil }
    var current: Any = v
    while let wrapped = current as? _SpecOptional {
        guard let inner = wrapped._specWrapped else { return nil }
        current = inner
    }
    return current
}

private protocol _SpecOptional { var _specWrapped: Any? { get } }
extension Optional: _SpecOptional {
    fileprivate var _specWrapped: Any? {
        switch self {
        case .some(let w): return w
        case .none: return nil
        }
    }
}

/// Stable hashable key for a tuple of Any-typed View params, so SwiftUI's
/// `.task(id:)` can re-fire when any prop changes. Uses String(describing:)
/// because Any isn't Hashable on its own.
func specPropsKey(_ values: [Any?]) -> String {
    // A map prop by its CONTENT, not specString's "[object Object]" (JS's
    // text, #1788): the key must change when the map does, or `.task(id:)`
    // never re-fires for a new row.
    return values.map { specChangeKey($0) }.joined(separator: "\u{1f}")
}

/// A value's CONTENT as text, for the surface's own "did this change" checks
/// (a prop key, a watch, the params sync). A list or map is described element
/// by element; specString's JS text ("[object Object]") is the same for every
/// map, so a watch on one would never fire again (#1788).
func specChangeKey(_ v: Any?) -> String {
    guard let u = _unwrapOptional(v) else { return "" }
    if u is [String: Any] || u is NSDictionary || u is [Any] { return String(describing: u) }
    return specString(u)
}

/// Content equality, for those same checks. Not specEq: JS `==` never finds
/// two maps equal, so a params sync built on it would write every prop on
/// every pass.
func specSame(_ a: Any?, _ b: Any?) -> Bool {
    return specChangeKey(a) == specChangeKey(b)
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

/// Mirrors JS `findIndex`: the position of the first match, or -1 on a miss.
/// Returns Double because every Spec number is a Double on this target — an Int
/// here would make `idx == -1` fail to type-check at the call site.
func specFindIndex(_ arr: Any?, _ predicate: (Any) -> Bool) -> Double {
    return Double(specArr(arr).firstIndex(where: predicate) ?? -1)
}

/// `concat(list, b)`: the list's elements, then b's when b is a list, else b
/// itself, as JS's concat. A b that was not a list was dropped (#1788).
func specConcat(_ a: Any?, _ b: Any?) -> [Any] {
    let ub = _unwrapOptional(b)
    if let l = ub as? [Any] { return specArr(a) + l }
    return specArr(a) + [ub ?? (Optional<Any>.none as Any)]
}

/// `concat(a, b)` when `a` is not known to be a list: a string `a` joins
/// text, as JS's String.prototype.concat ("ab" + "c"); anything else is the
/// list form.
func specConcatValue(_ a: Any?, _ b: Any?) -> Any {
    if let s = _unwrapOptional(a) as? String { return s + specJsString(b) }
    return specConcat(a, b)
}

/// `join(list, sep)`: elements as JS renders them (a null as nothing, a
/// nested list joined with ","). A null separator renders "" like any null
/// text (Kotlin's deliberate rule 1; JS writes "null").
func specJoin(_ list: Any?, _ sep: Any?) -> String {
    return specArr(list).map { specString($0) }.joined(separator: specString(sep))
}

/// `sort(list)` with no comparator: elements compare as their JS text by
/// UTF-16 code unit, so 10 sorts before 9 and null sorts as "null" (Swift
/// put it first, as ""). Stable, as V8's is.
func specSortDefault(_ list: Any?) -> [Any] {
    let keyed = specArr(list).map { ($0, specJsString($0)) }
    return keyed.sorted { specCompareUTF16($0.1, $1.1) < 0 }.map { $0.0 }
}

/// `push(arr, item)` — append in place AND yield the array.
///
/// JS's emission is `(arr.push(item), arr)`: the array object is mutated and
/// the same array is the value of the expression. Swift arrays are VALUE
/// types, so a plain `[Any]` parameter would be a copy and the append would be
/// invisible to the caller. `inout` gives us the write-back that reference
/// semantics give JS for free.
///
/// The `Any` overload is the one the emitter normally uses: `fn` locals are
/// declared `var name: Any`. The `[Any]` overload exists so hand-written or
/// future concretely-typed call sites work too.
@discardableResult
func specPush(_ arr: inout Any, _ item: Any) -> [Any] {
    var list = specArr(arr)
    list.append(item)
    arr = list
    return list
}

@discardableResult
func specPush(_ arr: inout [Any], _ item: Any) -> [Any] {
    arr.append(item)
    return arr
}

/// The single read-modify-write rule for a value nested inside a container:
/// returns `container` with `key` set to `value`.
///
/// Every nested write goes through here — indexed assignment (`m[k] = v`,
/// emitted as `m = specSet(m, k, v)`) and `specPushInto` below. Swift
/// collections are value types, so "modify in place" is really "rebuild and
/// store back"; keeping that in one function is what stops the assignment path
/// and the push path from drifting apart.
func specSet(_ container: Any?, _ key: Any?, _ value: Any) -> Any {
    let base = _unwrapOptional(container)
    if var dict = base as? [String: Any] {
        dict[specPropertyKey(key)] = value
        return dict
    }
    if base is [Any] || base is [[String: Any]] {
        var arr = specArr(base)
        // A key that names no index (`xs[-1]`, `xs["x"]`) is dropped: JS
        // stores it as a property no list operation sees. `Int(specDouble(k))`
        // wrote "x" into slot 0.
        guard let idx = specListIndex(key) else { return arr }
        if idx < arr.count {
            arr[idx] = value
        } else {
            // JS grows the list; past one beyond the end it leaves holes,
            // which read as undefined. Pad with null, as Kotlin does (#1788).
            while arr.count < idx { arr.append(Optional<Any>.none as Any) }
            arr.append(value)
        }
        return arr
    }
    // Not a collection: nil, or a scalar. JS throws on null and silently drops
    // the write on a number/string. Starting a fresh dictionary covers the one
    // case that matters — a map-typed local that has no value yet.
    return [specPropertyKey(key): value]
}

/// `push(container[key], item)` — append to a list nested one level inside a
/// map or list held by an addressable local, and write the result back.
///
/// JS gets this for free: `buckets[key]` yields the array object itself, so
/// `.push` mutates the copy inside `buckets`. Swift hands back a value copy,
/// so without the write-back the append vanishes — the same silent no-op
/// `specPush` fixes for a plain local. Grouping helpers (bucket rows by key,
/// then read the buckets out) are the shape that needs this.
@discardableResult
func specPushInto(_ container: inout Any, _ key: Any, _ item: Any) -> [Any] {
    var list = specArr(specGet(container, key))
    list.append(item)
    container = specSet(container, key, list)
    return list
}

/// `push` on a value that has no address (a temporary, or a Swift `let`
/// binding such as a function parameter or a for-in loop variable). There is
/// nothing for the mutation to be observed through, so this returns the
/// appended copy. See the `push` case in ir-to-swift.ts for when it is chosen.
@discardableResult
func specPushCopy(_ arr: Any?, _ item: Any) -> [Any] {
    var list = specArr(arr)
    list.append(item)
    return list
}

/// Dynamic indexing: handles array index (Int / Double / numeric String)
/// and dictionary key (String). Returns nil if the lookup fails.
func specGet(_ obj: Any?, _ key: Any?) -> Any? {
    guard let unwrapped = _unwrapOptional(obj), let key = _unwrapOptional(key) else { return nil }
    // A server object, looked up in place. JSONSerialization hands back an
    // NSDictionary, and `as? [String: Any]` on one does not wrap it: it builds
    // a Swift Dictionary, bridging every key, on EVERY field read. A view body
    // reads a row's fields dozens of times, so Vector's Schedule Maintenance
    // rows spent 83% of their body here and a tap took ~110 ms to show its
    // check on a 48-item plane (#766). `type(of:) is AnyClass` keeps a Swift
    // dictionary (a value, built by Spec code) off this path: `as? NSDictionary`
    // would bridge it the other way.
    if type(of: unwrapped) is AnyClass, let nd = unwrapped as? NSDictionary {
        if let s = key as? String { return nd.object(forKey: s) }
        return nd.object(forKey: specPropertyKey(key))
    }
    // Dictionary lookup by String key. A number names its JS text: `m[1]` is
    // `m["1"]`; String(describing: 1.0) asked for "1.0" (#1788).
    if let dict = unwrapped as? [String: Any] {
        if let s = key as? String { return dict[s] }
        return dict[specPropertyKey(key)]
    }
    // `.length` is a PROPERTY in Spec, on lists and strings alike, and the fn
    // emitter lowers a property read on an untyped value to specGet — so
    // `b.length == 0` on a list that arrived through `bases || []` asked a
    // dictionary for a key and got nil. Vector's shop plan read every fleet as
    // empty on iOS that way (2026-10-06). JS semantics: count for an array or
    // a string, undefined for anything else.
    if let k = key as? String, k == "length" {
        if let a = unwrapped as? [Any] { return Double(a.count) }
        if let s = unwrapped as? String { return Double(s.utf16.count) }
        return nil
    }
    // A string reads one UTF-16 unit at an index, as JS: "abc"[1] is "b".
    if let s = unwrapped as? String {
        guard let i = specListIndex(key) else { return nil }
        let u = s.utf16
        guard i < u.count else { return nil }
        return String(decoding: [u[u.index(u.startIndex, offsetBy: i)]], as: UTF16.self)
    }
    // Array lookup by numeric index
    if let arr = unwrapped as? [Any] {
        if let i = specListIndex(key), i < arr.count { return arr[i] }
    }
    if let arr = unwrapped as? [[String: Any]] {
        if let i = specListIndex(key), i < arr.count { return arr[i] }
    }
    return nil
}

/// JS ToPropertyKey: a key's text, a number without its ".0" and null as
/// "null".
func specPropertyKey(_ key: Any?) -> String {
    if let s = key as? String { return s }
    return specJsString(key)
}

/// A key as JS reads it on a list: a whole, finite, non-negative number, or
/// that number's own text ("1", not "01" or "1.0"). Anything else names no
/// element, so the read is undefined. `Int(d)` TRAPPED on a NaN or infinite
/// index (Vector #1368: a tz offset string reached `* 1` and then a list) and
/// read `xs[1.5]` as `xs[1]`.
func specListIndex(_ key: Any) -> Int? {
    if let n = key as? NSNumber, CFGetTypeID(n) == CFBooleanGetTypeID() { return nil }
    if let i = key as? Int { return i >= 0 ? i : nil }
    if let d = key as? Double {
        guard d.isFinite, d >= 0, d == d.rounded(.towardZero), d < 9007199254740992 else { return nil }
        return Int(d)
    }
    if let s = key as? String, let i = Int(s), i >= 0, String(i) == s { return i }
    return nil
}

/// Substring extraction (0-based indices).
func specSlice(_ val: Any?, _ start: Any, _ end: Any? = nil) -> Any {
    // JS's relative index: a negative one counts back from the end, and
    // either end clamps into 0...count. An end that lands before the start is
    // an empty slice; `s[si..<ei]` TRAPPED on it, as slice(s, 1, -1) (Vector
    // #1639). specInt, never Int(d): NaN and infinity reach here too.
    func bound(_ v: Any?, _ count: Int) -> Int {
        let n = specInt(specNum(v))
        return n < 0 ? max(0, count + n) : min(n, count)
    }
    // Unwrap nested Optional<Any> wrappers first
    guard let v = _unwrapOptional(val) else { return "" }
    let e = _unwrapOptional(end)

    // By UTF-16 unit, as JS: slice("a😀b", 0, 3) is "a😀" (#1788).
    if let s = v as? String {
        let u = Array(s.utf16)
        let si = bound(start, u.count)
        let ei = max(si, e == nil ? u.count : bound(e, u.count))
        return String(decoding: u[si..<ei], as: UTF16.self)
    }
    // Use specArr so [[String: Any]] works too
    let a = specArr(v)
    let si = bound(start, a.count)
    let ei = max(si, e == nil ? a.count : bound(e, a.count))
    return Array(a[si..<ei])
}

/// The UTF-16 offset of `needle` in `s`, code unit for code unit (JS's
/// search: "é" never finds "e\u{301}"), or nil. An empty needle is at 0.
func specUTF16Find(_ s: String, _ needle: String) -> Int? {
    let h = Array(s.utf16), n = Array(needle.utf16)
    if n.isEmpty { return 0 }
    if n.count > h.count { return nil }
    outer: for i in 0...(h.count - n.count) {
        for j in 0..<n.count where h[i + j] != n[j] { continue outer }
        return i
    }
    return nil
}

/// `indexOf(v, needle)`: the UTF-16 index of the needle's text in a string,
/// or the index of the first STRICTLY equal element of a list (JS `===`).
/// -1 when absent. `indexOf(s, "")` is 0; the list form always said -1
/// (#1788).
func specIndexOf(_ haystack: Any?, _ needle: Any?) -> Double {
    let h = _unwrapOptional(haystack)
    if let s = h as? String { return Double(specUTF16Find(s, specJsString(needle)) ?? -1) }
    if let a = h as? [Any] { return Double(a.firstIndex { specStrictEq($0, needle) } ?? -1) }
    return -1.0
}

/// `includes(v, needle)`: a substring (an empty one is in every string), or
/// a SameValueZero element: JS's `includes`, under which the string "1" is
/// not in [1, 2, 3].
func specIncludes(_ haystack: Any?, _ needle: Any?) -> Bool {
    let h = _unwrapOptional(haystack)
    if let s = h as? String { return specUTF16Find(s, specJsString(needle)) != nil }
    if let a = h as? [Any] { return a.contains { specSameValueZero($0, needle) } }
    return false
}

/// `replace(s, find, with)`: the FIRST occurrence only, as JS's string
/// replace (`replacingOccurrences` replaced all), the replacement taking JS's
/// `$$`, `$&`, `` $` `` and `$'` (#1788).
func specReplace(_ s: Any?, _ find: Any?, _ with: Any?) -> String {
    let str = specString(s)
    guard let at = specUTF16Find(str, specJsString(find)) else { return str }
    let u = Array(str.utf16)
    let end = at + specJsString(find).utf16.count
    let repl = specSubstitute(specJsString(with), u, at, end, [])
    return String(decoding: u[0..<at], as: UTF16.self) + repl + String(decoding: u[end...], as: UTF16.self)
}

/// JS GetSubstitution over UTF-16 `str`: `$$`, `$&`, `` $` ``, `$'` and
/// `$1`..`$99` (a group that did not take part is ""; a `$n` naming no group
/// stays as written).
func specSubstitute(_ repl: String, _ str: [UInt16], _ start: Int, _ end: Int, _ groups: [String?]) -> String {
    guard repl.contains("$") else { return repl }
    let r = Array(repl.utf16)
    var out: [UInt16] = []
    func digit(_ c: UInt16) -> Int? { c >= 48 && c <= 57 ? Int(c) - 48 : nil }
    var i = 0
    while i < r.count {
        let c = r[i]
        if c != 36 || i + 1 >= r.count { out.append(c); i += 1; continue }
        let n = r[i + 1]
        switch n {
        case 36: out.append(36); i += 2
        case 38: out += str[start..<end]; i += 2
        case 96: out += str[0..<start]; i += 2
        case 39: out += str[end...]; i += 2
        default:
            if let one = digit(n) {
                let two = i + 2 < r.count ? digit(r[i + 2]).map { one * 10 + $0 } : nil
                if let t = two, t >= 1, t <= groups.count { out += Array((groups[t - 1] ?? "").utf16); i += 3 }
                else if one >= 1, one <= groups.count { out += Array((groups[one - 1] ?? "").utf16); i += 2 }
                else { out.append(c); i += 1 }
            } else { out.append(c); i += 1 }
        }
    }
    return String(decoding: out, as: UTF16.self)
}

/// `toLowerCase(s)` / `toUpperCase(s)`: JS's full, locale-independent case
/// mapping. Swift's plain `lowercased()` missed the final sigma ("ΣΑΣ" is
/// "σας"); Foundation's locale form applies it (#1788).
func specToLowerCase(_ s: Any?) -> String {
    return specString(s).lowercased(with: Locale(identifier: "en_US_POSIX"))
}

func specToUpperCase(_ s: Any?) -> String {
    return specString(s).uppercased(with: Locale(identifier: "en_US_POSIX"))
}

/// Left-pad a string.
// Returns String, not Any — the emitter types the call `string` and every
// rule downstream trusts that. It also coerces rather than force-casting:
// `val as! String` trapped on the Double that `specGet` hands back for a
// numeric field, which is the ordinary way a zero-padded minute arrives.
func specPadStart(_ val: Any?, _ targetLen: Any?, _ padChar: Any?) -> String {
    let s = specString(val)
    let len = specInt(specNum(targetLen))
    let pad = specString(padChar)
    if s.count >= len || pad.isEmpty { return s }
    let needed = len - s.count
    return String(String(repeating: pad, count: needed).prefix(needed)) + s
}

/// fillPattern(pattern, fields): replace each `{name}` (letters, digits,
/// underscore) with fields[name]. A field that is missing, nil or NSNull stays
/// written as `{name}`, matching the JS emission. Values render through
/// specString, so a number field reads `9`, not `9.0`.
func specFillPattern(_ pattern: Any?, _ fields: Any?) -> String {
    let p = specString(pattern)
    let map = specAsMap(fields)
    var out = ""
    var i = p.startIndex
    while i < p.endIndex {
        if p[i] == "{", let close = p[p.index(after: i)...].firstIndex(of: "}") {
            let name = String(p[p.index(after: i)..<close])
            if !name.isEmpty,
               name.allSatisfy({ ($0.isASCII && ($0.isLetter || $0.isNumber)) || $0 == "_" }),
               let value = _unwrapOptional(map[name]),
               !(value is NSNull) {
                out += specString(value)
                i = p.index(after: close)
                continue
            }
        }
        out.append(p[i])
        i = p.index(after: i)
    }
    return out
}

/// Character at index.
/// JS `s.split(sep)`. `components(separatedBy: "")` answers `[s]` for an
/// empty separator, where JS answers one item per character, so a fn walking
/// a string with `split('')` did nothing on iOS (Vector #1442). Characters
/// are grapheme clusters here and UTF-16 units in JS: they agree on text a
/// person types (a precomposed é is one of each), not on an emoji.
func specSplit(_ s: String, _ sep: String) -> [String] {
    if sep.isEmpty { return s.map { String($0) } }
    return s.components(separatedBy: sep)
}

func specCharAt(_ val: Any?, _ idx: Any?) -> String {
    let s = specString(val)
    let i = specInt(specNum(idx))
    guard i >= 0, i < s.count else { return "" }
    return String(s[s.index(s.startIndex, offsetBy: i)])
}

/// Runtime type check. `list` and `map` are first-class fn types, and JS
/// typeof cannot tell them (or null) apart from a plain object — so this
/// distinguishes all six kinds instead of mirroring JS typeof verbatim.
func specTypeOf(_ val: Any) -> String {
    if val is String { return "string" }
    if val is Bool { return "boolean" }
    if val is Double || val is Int { return "number" }
    if val is NSNull || val as AnyObject === NSNull() { return "null" }
    if val is [Any] { return "list" }
    if val is [String: Any] { return "map" }
    return "undefined"
}

/// True only for lists. `for … in` over a map or nil traps, so a defensive
/// fn guards every loop with this.
func specIsList(_ val: Any) -> Bool {
    if val is NSNull || val as AnyObject === NSNull() { return false }
    return val is [Any]
}

// MARK: - Object spread

/// Coerce a dynamic value to a map for `{ ...expr }`. A non-map (nil, NSNull,
/// number, string, list) contributes nothing, so a spread can never trap.
///
/// Named `specAsMap`, not `specMap` — `specMap` is already the list `map`
/// helper above, and a same-named one-argument overload reads like a typo.
func specAsMap(_ val: Any?) -> [String: Any] {
    guard let unwrapped = _unwrapOptional(val) else { return [:] }
    return (unwrapped as? [String: Any]) ?? [:]
}

/// Left-to-right merge for object literals containing a spread; later parts
/// win, matching JS object-spread semantics. Order of `parts` is the source
/// order of the literal's entries, so reordering it changes which value wins.
func specMergeMaps(_ parts: [[String: Any]]) -> [String: Any] {
    var out: [String: Any] = [:]
    for part in parts {
        for (k, v) in part { out[k] = v }
    }
    return out
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
private func specBuildRegex(_ pattern: String, _ flags: String) -> NSRegularExpression? {
  var opts: NSRegularExpression.Options = []
  if flags.contains("i") { opts.insert(.caseInsensitive) }
  return try? NSRegularExpression(pattern: specTranslateJsRegex(pattern), options: opts)
}

private let specRegexWS = "\\t\\n\\x{0B}\\f\\r\\x{20}\\x{A0}\\x{1680}\\x{2000}-\\x{200A}\\x{2028}\\x{2029}\\x{202F}\\x{205F}\\x{3000}\\x{FEFF}"
private let specRegexWord = "[A-Za-z0-9_]"

/// An ECMAScript pattern (the cross-platform subset) as an ICU one, the same
/// translation Kotlin's translateJsRegex makes. ICU reads several constructs
/// differently: \d took ٣ and \w took é (Unicode classes), \b followed them,
/// `$` matched before a final newline and `.` refused U+0085 (#1788). Each
/// class is spelled out, so the pattern means what it means on the web.
func specTranslateJsRegex(_ src: String) -> String {
  let c = Array(src)
  var out = ""
  var inClass = false
  var i = 0
  func quantifierAt(_ at: Int) -> String? {
    // {n} {n,} {n,m}
    var j = at + 1, sawDigit = false
    while j < c.count, c[j].isASCII, c[j].isNumber { j += 1; sawDigit = true }
    guard sawDigit, j < c.count else { return nil }
    if c[j] == "," {
      j += 1
      while j < c.count, c[j].isASCII, c[j].isNumber { j += 1 }
    }
    guard j < c.count, c[j] == "}" else { return nil }
    return String(c[at...j])
  }
  while i < c.count {
    let ch = c[i]
    if ch == "\\", i + 1 < c.count {
      out += specRegexEscape(c, i + 1, inClass)
      i += 2
      continue
    }
    if inClass {
      switch ch {
      case "]": out += "]"; inClass = false
      case "[": out += "\\["
      case "&": out += "\\&"
      default: out.append(ch)
      }
      i += 1
      continue
    }
    switch ch {
    case "[":
      if i + 1 < c.count, c[i + 1] == "]" { out += "(?!)"; i += 2; continue }
      if i + 2 < c.count, c[i + 1] == "^", c[i + 2] == "]" { out += "[\\x{0}-\\x{10FFFF}]"; i += 3; continue }
      if i + 1 < c.count, c[i + 1] == "^" { out += "[^"; i += 2; inClass = true; continue }
      out += "["; inClass = true
    case "$": out += "\\z"
    case ".": out += "[^\\n\\r\\x{2028}\\x{2029}]"
    case "{":
      if let q = quantifierAt(i) { out += q; i += q.count; continue }
      out += "\\{"
    case "}": out += "\\}"
    case "]": out += "\\]"
    default: out.append(ch)
    }
    i += 1
  }
  return out
}

/// The translation of the escape whose letter is at c[at].
private func specRegexEscape(_ c: [Character], _ at: Int, _ inClass: Bool) -> String {
  let n = c[at]
  func hexFollows(_ count: Int) -> Bool {
    guard at + count < c.count else { return false }
    return (1...count).allSatisfy { c[at + $0].isHexDigit }
  }
  let boundary = "(?:(?<=\(specRegexWord))(?!\(specRegexWord))|(?<!\(specRegexWord))(?=\(specRegexWord)))"
  let notBoundary = "(?:(?<=\(specRegexWord))(?=\(specRegexWord))|(?<!\(specRegexWord))(?!\(specRegexWord)))"
  switch n {
  case "d": return inClass ? "0-9" : "[0-9]"
  case "D": return "[^0-9]"
  case "w": return inClass ? "A-Za-z0-9_" : specRegexWord
  case "W": return "[^A-Za-z0-9_]"
  case "s": return inClass ? specRegexWS : "[\(specRegexWS)]"
  case "S": return "[^\(specRegexWS)]"
  case "b": return inClass ? "\\x{08}" : boundary
  case "B": return inClass ? "B" : notBoundary
  case "v": return "\\x{0B}"
  case "0": return "\\x{0}"
  case "f", "n", "r", "t": return "\\" + String(n)
  case "c": return at + 1 < c.count && c[at + 1].isLetter ? "\\c" : "\\\\c"
  case "x": return hexFollows(2) ? "\\x" : "x"
  case "u": return hexFollows(4) ? "\\u" : "u"
  case "1"..."7": return "\\x{\(n)}"   // only inside a class (the validator refuses backreferences): legacy octal
  default: return n.isLetter || n.isNumber ? String(n) : "\\" + String(n)
  }
}

public func regexTest(_ s: Any?, _ pattern: String, _ flags: String = "") -> Bool {
  let str = specString(s)
  guard let re = specBuildRegex(pattern, flags) else { return false }
  let range = NSRange(str.startIndex..<str.endIndex, in: str)
  return re.firstMatch(in: str, options: [], range: range) != nil
}

/// First match as [full, group1, ...] or nil — mirrors ECMA String.match without 'g'.
public func regexMatch(_ s: Any?, _ pattern: String, _ flags: String = "") -> [Any?]? {
  let str = specString(s)
  guard let re = specBuildRegex(pattern, flags) else { return nil }
  let range = NSRange(str.startIndex..<str.endIndex, in: str)
  guard let m = re.firstMatch(in: str, options: [], range: range) else { return nil }
  var out: [Any?] = []
  for i in 0..<m.numberOfRanges {
    let r = m.range(at: i)
    if r.location == NSNotFound { out.append(nil) }
    else if let rr = Range(r, in: str) { out.append(String(str[rr])) }
    else { out.append(nil) }
  }
  return out
}

/// Replaces ALL occurrences. Template uses $1..$9 (validated portable subset).
public func regexReplace(_ s: Any?, _ pattern: String, _ repl: Any?, _ flags: String = "") -> String {
  let str = specString(s)
  guard let re = specBuildRegex(pattern, flags) else { return str }
  let range = NSRange(str.startIndex..<str.endIndex, in: str)
  // JS's replacement patterns ($&, $$, $`, $'), not ICU's template, which
  // also eats a backslash.
  let u = Array(str.utf16)
  let replacement = specJsString(repl)
  var out = ""
  var last = 0
  for m in re.matches(in: str, options: [], range: range) {
    let groups: [String?] = (1..<max(1, m.numberOfRanges)).map { g in
      let r = m.range(at: g)
      return r.location == NSNotFound ? nil : String(decoding: u[r.location..<(r.location + r.length)], as: UTF16.self)
    }
    out += String(decoding: u[last..<m.range.location], as: UTF16.self)
    out += specSubstitute(replacement, u, m.range.location, m.range.location + m.range.length, groups)
    last = m.range.location + m.range.length
  }
  return out + String(decoding: u[last...], as: UTF16.self)
}

public func regexSplit(_ s: Any?, _ pattern: String) -> [Any?] {
  let str = specString(s)
  guard let re = specBuildRegex(pattern, "") else { return [str] }
  let range = NSRange(str.startIndex..<str.endIndex, in: str)
  var parts: [Any?] = []
  var last = str.startIndex
  re.enumerateMatches(in: str, options: [], range: range) { m, _, _ in
    guard let m = m, let r = Range(m.range, in: str) else { return }
    parts.append(String(str[last..<r.lowerBound]))
    last = r.upperBound
  }
  parts.append(String(str[last...]))
  return parts
}

// MARK: - Currency stdlib (pinned en_US locale — mirrors the JS emission's
// pinned 'en-US' Intl.NumberFormat; unknown codes fall back to "CODE 12.34")

// `code` is Any?, not String: a fn passes it through from an untyped
// parameter (`fn moneyDisplayCents(cents: any, code: any)`), and the emitted
// call handed an Any to a String parameter — "cannot convert value of type
// 'Any' to expected argument type 'String'" (money-display.spec, the flight
// school app's iOS build, 2026-10-15). A literal "USD" still reads the same.
public func formatCurrency(_ cents: Any?, _ code: Any?, _ decimals: Any? = nil) -> String {
  // specNum, not specDouble. The JS is `cents * 1` followed by an
  // isFinite check, so unparseable text is NaN and the answer is "".
  // specDouble answers 0 for the same input, which rendered "$0.00" — a
  // price, for a field the user had typed letters into.
  let n = specNum(cents)
  if n.isNaN || n.isInfinite { return "" }
  let d = specIsNil(decimals) ? 2 : specInt(specNum(decimals))
  // A code that is not three letters makes Intl throw, and the JS emission
  // catches it as "CODE 12.34", null as "null". NumberFormatter formatted
  // "US" and null as dollars (#1788).
  let codeText = specJsString(code)
  let letters = codeText.unicodeScalars.filter { $0.isASCII && CharacterSet.letters.contains($0) }.count
  if codeText.unicodeScalars.count != 3 || letters != 3 || d < 0 || d > 100 {
    return codeText + " " + specToFixed(n / 100.0, d)
  }
  let fmt = NumberFormatter()
  fmt.numberStyle = .currency
  fmt.currencyCode = specString(code)
  fmt.locale = Locale(identifier: "en_US")
  fmt.minimumFractionDigits = d
  fmt.maximumFractionDigits = d
  // Intl rounds half AWAY FROM ZERO ("halfExpand"); NumberFormatter defaults
  // to half-to-EVEN, so a half-cent went the other way — 0.5 cents formatted
  // as "$0.00" on iOS and "$0.01" on the web. Foundation's .halfUp is the
  // away-from-zero rule, and it matches Intl on negatives and on the
  // float-representation traps (1.005, 2.675) too.
  fmt.roundingMode = .halfUp
  return fmt.string(from: NSNumber(value: n / 100.0)) ?? codeText + " " + specToFixed(n / 100.0, d)
}

// MARK: - Registry components provided as views
//
// The registry's Autocomplete, MultiSelect, FormErrorSummary, Spinner,
// SkeletonRow and SkeletonCard are not emitted from their web-shaped bodies on
// iOS (SWIFT_REGISTRY_LOWERED in the emitter); these are their views, with
// every registry prop accepted as `Any?` so a call site passing any subset of
// them compiles. MultiSelect is a REAL menu; Autocomplete opens a searchable
// sheet (SpecSearchSelect, Vector #3919), the phone's shape for the web's
// text field over a suggestion panel. Both dispatch the same `change` +
// `commit` the web does. Born in Vector's
// maintenance app as hand-written stand-ins (2026-10-06); moved here so every
// app gets them (2026-10-13).

private func specOptionLabel(_ opt: Any) -> String {
    let l = specString(specGet(opt, "label") ?? "")
    return l.isEmpty ? specString(specGet(opt, "value") ?? "") : l
}

struct AutocompleteView: View {
    var ariaLabel: Any? = nil
    var disabled: Any? = nil
    var error: Any? = nil
    var errorMessage: Any? = nil
    var freeText: Any? = nil
    var highlight: Any? = nil
    var openOnFocus: Any? = nil
    var options: Any? = nil
    var placeholder: Any? = nil
    var value: Any? = nil
    var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
    @State private var typed = ""
    private var current: String { specString(value ?? "") }
    private var currentLabel: String {
        specArr(options).first { specString(specGet($0, "value") ?? "") == current }.map(specOptionLabel) ?? current
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if specTruthy(freeText) {
                TextField(specString(placeholder ?? ""), text: $typed)
                    .textFieldStyle(.roundedBorder)
                    .disabled(specTruthy(disabled))
                    .onAppear { typed = current }
                    .onChange(of: typed) { _, v in onDispatch?("change", [v]) }
                    .onSubmit { onDispatch?("commit", [typed]) }
            } else {
                // A searchable sheet, not a Menu (Vector #3919). The Menu with
                // a Button per option never opened inside the Mx report
                // sheet: a tap reached it (XCUITest found it hittable) and
                // nothing showed, so no aircraft could be picked and no
                // squawk filed. The sheet is also the web's shape: type a
                // tail, pick it from the filtered list. It is the searchable
                // Select's sheet (SpecSearchSelect), so a pick writes the
                // binding, which dispatches the web's `change` + `commit`.
                SpecSearchSelect(
                    title: specString(ariaLabel ?? placeholder ?? ""),
                    options: options,
                    selection: Binding(get: { current }, set: { v in
                        onDispatch?("change", [v])
                        onDispatch?("commit", [v])
                    })
                ) {
                    HStack {
                        Text(verbatim: currentLabel.isEmpty ? specString(placeholder ?? "") : currentLabel)
                            .foregroundStyle(currentLabel.isEmpty ? .secondary : .primary)
                        Spacer()
                        Image(systemName: "chevron.up.chevron.down").foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    // A Spacer and a stroke draw nothing, so without this the
                    // only tap target was the words and the chevron.
                    .contentShape(Rectangle())
                    .background(RoundedRectangle(cornerRadius: 8).stroke(specTruthy(error) ? Color.red : Color.gray.opacity(0.4)))
                }
                .disabled(specTruthy(disabled))
                .accessibilityLabel(specString(ariaLabel ?? ""))
            }
            if specTruthy(error), !specString(errorMessage ?? "").isEmpty {
                Text(specString(errorMessage ?? "")).font(.footnote).foregroundStyle(.red)
            }
        }
    }
}

struct MultiSelectView: View {
    var ariaLabel: Any? = nil
    var disabled: Any? = nil
    var display: Any? = nil
    var label: Any? = nil
    var maxChips: Any? = nil
    var mode: Any? = nil
    var options: Any? = nil
    var placeholder: Any? = nil
    var searchable: Any? = nil
    var showCheckbox: Any? = nil
    /// "md" | "sm" (registry 0.10.0, Vector I-5651): "sm" stands as tall as a
    /// "sm" Select beside it. Without the parameter every call passing it
    /// failed to compile (charter's binder record field, Vector #5482).
    var size: Any? = nil
    /// Replaces the joined labels when the caller passes one (registry 0.8.0).
    var summary: Any? = nil
    var values: Any? = nil
    var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
    private var selected: [String] { specArr(values).map { specString($0) } }
    private var summaryText: String {
        let labels = specArr(options).filter { selected.contains(specString(specGet($0, "value") ?? "")) }.map(specOptionLabel)
        if labels.isEmpty { return specString(placeholder ?? "") }
        let given = specString(summary ?? "")
        return given.isEmpty ? labels.joined(separator: ", ") : given
    }
    private var small: Bool { specString(size ?? "") == "sm" }
    var body: some View {
        Menu {
            ForEach(Array(specArr(options).enumerated()), id: \.offset) { _, opt in
                let v = specString(specGet(opt, "value") ?? "")
                Button {
                    var next = selected
                    if let i = next.firstIndex(of: v) { next.remove(at: i) } else { next.append(v) }
                    onDispatch?("change", [next as [Any]])
                } label: {
                    Label(specOptionLabel(opt), systemImage: selected.contains(v) ? "checkmark" : "")
                }
            }
        } label: {
            HStack {
                Text(summaryText).foregroundStyle(selected.isEmpty ? .secondary : .primary)
                Spacer()
                Image(systemName: "chevron.up.chevron.down").foregroundStyle(.secondary)
            }
            .padding(.horizontal, small ? 4 : 12)
            .padding(.vertical, small ? 0 : 10)
            .frame(minHeight: small ? 30 : nil)
            .contentShape(Rectangle())   // the whole field is the tap target (Vector #3919)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
        }
        .disabled(specTruthy(disabled))
    }
}

// MARK: - EditableGrid (Vector #2869)
//
// EditableGrid's web body `extends DataGrid` and inherits its row windowing,
// column drag and block cache (11 @externs with no Swift twin), so on iOS the
// body is not emitted (SWIFT_REGISTRY_LOWERED) and a mount site calls this
// view: a header row and one row of editable cells per item. A cell commits
// when it loses focus (or on Return), and a changed value dispatches the same
// events the web does: `cellEdit(rowId, colKey, value, original)`, then
// `cellSave(rowId, colKey, value)` under saveMode "auto", and
// `rowSave(rowId, changes)` under "row-blur" when focus moves to another row.
// Not ported: keyboard navigation, undo/redo, paste, fill-down (no hardware
// keyboard shape on a phone) and `activation` (a tap on a cell edits it).

// BEGIN SpecEditableGridEdits: Foundation only. swift-editable-grid-run.test.ts
// compiles this block for the Mac and runs it.
/// The grid's edits, keyed "rowId::colKey" as the web keys them. A value is
/// kept only while it differs from the row's own.
struct SpecEditableGridEdits {
    var values: [String: String] = [:]
    var invalid: Set<String> = []
    var lastRow: String? = nil

    static func cellKey(_ rowId: String, _ colKey: String) -> String { rowId + "::" + colKey }

    /// What the cell shows: the edit, else the row's own value.
    func shown(_ rowId: String, _ colKey: String, original: String) -> String {
        values[Self.cellKey(rowId, colKey)] ?? original
    }

    func isDirty(_ rowId: String, _ colKey: String) -> Bool { values[Self.cellKey(rowId, colKey)] != nil }

    func isInvalid(_ rowId: String, _ colKey: String) -> Bool { invalid.contains(Self.cellKey(rowId, colKey)) }

    /// A cell's value leaving the cell. True when it differs from what the
    /// cell showed, which is when the grid emits cellEdit; committing the
    /// same value again (Return, then the focus leaving) is false.
    mutating func commit(rowId: String, colKey: String, original: String, value: String, required: Bool) -> Bool {
        let ck = Self.cellKey(rowId, colKey)
        if (values[ck] ?? original) == value { return false }
        if value == original { values[ck] = nil } else { values[ck] = value }
        if required && value.isEmpty { invalid.insert(ck) } else { invalid.remove(ck) }
        return true
    }

    /// Focus entering a row. When it left another row that has edits, that
    /// row's id and its changes ([{key, value}], as the web's getRowChanges).
    mutating func enterRow(_ rowId: String) -> (rowId: String, changes: [[String: String]])? {
        let prev = lastRow
        lastRow = rowId
        guard let prev, prev != rowId else { return nil }
        let changes = values.keys.filter { $0.hasPrefix(prev + "::") }.sorted().map { ["key": $0, "value": values[$0] ?? ""] }
        return changes.isEmpty ? nil : (prev, changes)
    }

    /// The next sort, as the web's toggleSortState: none → asc → desc → none.
    static func toggleSort(_ state: [[String: String]], _ colKey: String) -> [[String: String]] {
        guard let existing = state.first(where: { $0["key"] == colKey }) else { return [["key": colKey, "direction": "asc"]] }
        if existing["direction"] == "asc" {
            return state.map { $0["key"] == colKey ? ["key": colKey, "direction": "desc"] : $0 }
        }
        return state.filter { $0["key"] != colKey }
    }

    /// A column width as points, by egCssLength's rule: digits alone, or
    /// "Npx", are points; "Nrem"/"Nem" are N×16; anything else is unsized.
    static func length(_ raw: String) -> Double? {
        let s = raw.trimmingCharacters(in: .whitespaces)
        for (unit, scale) in [("px", 1.0), ("rem", 16.0), ("em", 16.0)] where s.hasSuffix(unit) {
            return Double(s.dropLast(unit.count)).map { $0 * scale }
        }
        return Double(s)
    }

    /// A column's frame, as egSizedColumn sizes it: a `width` pins the column
    /// (min = max), otherwise `minWidth` (default 100) is a floor and it grows.
    static func columnWidths(width: String?, minWidth: String?) -> (min: Double, max: Double?) {
        if let w = width.flatMap(length) { return (w, w) }
        return (minWidth.flatMap(length) ?? 100, nil)
    }
}
// END SpecEditableGridEdits

// UIKit system colors and keyboards: iOS only. The macOS probes that compile
// this file as plain Swift (fn-parity host stubs, the Slider probe) skip it.
#if canImport(UIKit)
struct EditableGridView: View {
    var activation: Any? = nil
    var background: Any? = nil
    var blockSize: Any? = nil
    var bordered: Any? = nil
    var cellPadding: Any? = nil
    var collapsedGroups: Any? = nil
    var columnOrder: Any? = nil
    var columnRules: Any? = nil
    var columns: Any? = nil
    var configurableColumns: Any? = nil
    var controlSize: Any? = nil
    var dataVersion: Any? = nil
    var defaultExpanded: Any? = nil
    var defaultOpen: Any? = nil
    var emptyText: Any? = nil
    var excludedKeys: Any? = nil
    var expandable: Any? = nil
    var expandColumn: Any? = nil
    var expandTrigger: Any? = nil
    var externalFilter: Any? = nil
    var externalSort: Any? = nil
    var groupBackground: Any? = nil
    var groupBy: Any? = nil
    var groupCounts: Any? = nil
    var groupRules: Any? = nil
    var hasMore: Any? = nil
    var headerPadding: Any? = nil
    var height: Any? = nil
    var hiddenColumns: Any? = nil
    var hoverBackground: Any? = nil
    var loading: Any? = nil
    var overscan: Any? = nil
    var pinBackground: Any? = nil
    var pinFirst: Any? = nil
    var reorderableColumns: Any? = nil
    var rowCount: Any? = nil
    var rowHeight: Any? = nil
    var rowIdField: Any? = nil
    var rowKeyField: Any? = nil
    var rows: Any? = nil
    var rowsClickable: Any? = nil
    var rowTestId: Any? = nil
    var saveMode: Any? = nil
    var selectAllMatching: Any? = nil
    var selected: Any? = nil
    var selection: Any? = nil
    var skeletonVariant: Any? = nil
    var sort: Any? = nil
    var source: Any? = nil
    var stickyHeader: Any? = nil
    var stripeBackground: Any? = nil
    var striped: Any? = nil
    var undoDepth: Any? = nil
    var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
    @State private var edits = SpecEditableGridEdits()
    @State private var sortState: [[String: String]]? = nil

    private var idField: String {
        let s = specString(rowIdField ?? "")
        return s.isEmpty ? "id" : s
    }
    private var mode: String {
        let s = specString(saveMode ?? "")
        return s.isEmpty ? "batch" : s
    }
    /// DataGrid's visibleColumns: not `visible: false`, not in hiddenColumns.
    private var visibleColumns: [Any] {
        let hidden = Set(specArr(hiddenColumns).map { specString($0) })
        return specArr(columns).filter { c in
            !(specGet(c, "visible") as? Bool == false) && !hidden.contains(specString(specGet(c, "key") ?? ""))
        }
    }
    private var currentSort: [[String: String]] {
        sortState ?? specArr(sort).map { ["key": specString(specGet($0, "key") ?? ""), "direction": specString(specGet($0, "direction") ?? "")] }
    }

    private static func heading(_ col: Any) -> String {
        for k in ["header", "label", "key"] {
            if let v = specGet(col, k), !(v is NSNull) { return specString(v) }
        }
        return ""
    }
    private static func optString(_ v: Any?) -> String? {
        guard let v, !(v is NSNull) else { return nil }
        return specString(v)
    }
    private static func widths(_ col: Any) -> (min: CGFloat, max: CGFloat) {
        let w = SpecEditableGridEdits.columnWidths(width: optString(specGet(col, "width")), minWidth: optString(specGet(col, "minWidth")))
        return (CGFloat(w.min), w.max.map { CGFloat($0) } ?? .infinity)
    }

    private func headerCell(_ col: Any) -> some View {
        let key = specString(specGet(col, "key") ?? "")
        let w = Self.widths(col)
        let dir = currentSort.first { $0["key"] == key }?["direction"]
        return HStack(spacing: 4) {
            Text(verbatim: Self.heading(col)).font(.caption.weight(.semibold)).foregroundStyle(.secondary)
            if let dir { Text(verbatim: dir == "asc" ? "\u{2191}" : "\u{2193}").font(.caption).foregroundStyle(Color.accentColor) }
        }
        .padding(.vertical, 8).padding(.horizontal, 8)
        .frame(minWidth: w.min, maxWidth: w.max, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            guard specTruthy(specGet(col, "sortable")) else { return }
            let next = SpecEditableGridEdits.toggleSort(currentSort, key)
            sortState = next
            onDispatch?("sort", [next as [Any]])
        }
        .accessibilityAddTraits(.isHeader)
    }

    private func bodyCell(_ row: Any, rowIndex: Int, col: Any) -> some View {
        let rowRaw: Any = specGet(row, idField).flatMap { $0 is NSNull ? nil : $0 } ?? Double(rowIndex)
        let rowId = specString(rowRaw)
        let colKey = specString(specGet(col, "key") ?? "")
        let originalRaw = specGet(row, colKey)
        let original = Self.optString(originalRaw) ?? ""
        let w = Self.widths(col)
        return SpecEditableGridCell(
            shown: edits.shown(rowId, colKey, original: original),
            label: Self.heading(col) + ", row \(rowIndex + 1)",
            kind: specString(specGet(col, "type") ?? ""),
            options: specArr(specGet(col, "options")),
            editable: !(specGet(col, "editable") as? Bool == false),
            dirty: edits.isDirty(rowId, colKey),
            invalid: edits.isInvalid(rowId, colKey),
            onFocus: {
                if let left = edits.enterRow(rowId), mode == "row-blur" {
                    onDispatch?("rowSave", [left.rowId, left.changes as [Any]])
                }
            },
            onCommit: { value in
                let required = specTruthy(specGet(col, "required"))
                guard edits.commit(rowId: rowId, colKey: colKey, original: original, value: value, required: required) else { return }
                onDispatch?("cellEdit", [rowRaw, colKey, value, originalRaw ?? NSNull()])
                if mode == "auto" { onDispatch?("cellSave", [rowRaw, colKey, value]) }
            }
        )
        .frame(minWidth: w.min, maxWidth: w.max, alignment: .leading)
    }

    /// Columns that fit the width share it (a flexible column grows past its
    /// floor, as on the web); wider than the screen, the grid scrolls sideways
    /// at its floors. In a horizontal ScrollView alone every flexible column
    /// sat at its floor and the grid stopped short of the edge.
    private var grid: some View {
        ViewThatFits(in: .horizontal) {
            table
            ScrollView(.horizontal, showsIndicators: true) { table }
        }
    }

    private var table: some View {
        let cols = visibleColumns
        let items = specArr(rows)
        return VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                ForEach(Array(cols.enumerated()), id: \.offset) { _, col in headerCell(col) }
            }
            .background(Color(.tertiarySystemGroupedBackground))
            Divider()
            ForEach(Array(items.enumerated()), id: \.offset) { i, row in
                HStack(spacing: 0) {
                    ForEach(Array(cols.enumerated()), id: \.offset) { _, col in bodyCell(row, rowIndex: i, col: col) }
                }
                .background(specTruthy(striped) && i % 2 == 1 ? Color(.secondarySystemBackground) : Color.clear)
                Divider()
            }
            if items.isEmpty {
                let empty = specString(emptyText ?? "")
                Text(verbatim: empty.isEmpty ? "No rows" : empty)
                    .foregroundStyle(.tertiary)
                    .padding(24)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    var body: some View {
        Group {
            if let h = SpecEditableGridEdits.length(specString(height ?? "")) {
                ScrollView(.vertical) { grid }.frame(height: CGFloat(h))
            } else {
                grid
            }
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator).opacity(0.3)))
    }
}

/// EditableGridNative is the web's direct mount of the same grid.
typealias EditableGridNativeView = EditableGridView

/// One editable cell. It holds its own text while focused and commits when
/// the focus leaves (or on Return); a select column picks from a menu.
private struct SpecEditableGridCell: View {
    let shown: String
    let label: String
    let kind: String
    let options: [Any]
    let editable: Bool
    let dirty: Bool
    let invalid: Bool
    let onFocus: () -> Void
    let onCommit: (String) -> Void
    @State private var text = ""
    @FocusState private var focused: Bool

    private var shownLabel: String {
        options.first { specString(specGet($0, "value") ?? "") == shown }.map(specOptionLabel) ?? shown
    }

    var body: some View {
        Group {
            if !editable {
                Text(verbatim: shown)
            } else if kind == "select" {
                Menu {
                    ForEach(Array(options.enumerated()), id: \.offset) { _, opt in
                        Button(specOptionLabel(opt)) {
                            onFocus()
                            onCommit(specString(specGet(opt, "value") ?? ""))
                        }
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text(verbatim: shownLabel).foregroundStyle(.primary)
                        Image(systemName: "chevron.up.chevron.down").font(.caption2).foregroundStyle(.secondary)
                    }
                }
                .accessibilityLabel(label)
            } else {
                TextField(label, text: $text)
                    .keyboardType(kind == "number" ? .decimalPad : .default)
                    .focused($focused)
                    .onSubmit { onCommit(text) }
                    .onChange(of: focused) { _, isFocused in
                        if isFocused { onFocus() } else { onCommit(text) }
                    }
                    .accessibilityLabel(label)
            }
        }
        .font(.subheadline)
        .onAppear { text = shown }
        .onChange(of: shown) { _, v in if !focused { text = v } }
        .padding(.vertical, 8).padding(.horizontal, 8)
        .background(dirty ? Color.orange.opacity(0.08) : Color.clear)
        .overlay(Rectangle().stroke(invalid ? Color.red : Color.clear, lineWidth: 2))
    }
}
#endif

struct FormErrorSummaryView: View {
    var firstField: Any? = nil
    var items: Any? = nil
    var jumpLabel: Any? = nil
    var title: Any? = nil
    var visible: Any? = nil
    var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
    var body: some View {
        if specTruthy(visible) {
            VStack(alignment: .leading, spacing: 4) {
                Text(specString(title ?? "Fix these to continue:")).font(.subheadline.weight(.semibold))
                ForEach(Array(specArr(items).enumerated()), id: \.offset) { _, item in
                    let text = specString(specGet(item, "message") ?? specGet(item, "label") ?? item)
                    Text("• " + text).font(.footnote)
                }
            }
            .foregroundStyle(.red)
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.red.opacity(0.08)))
        }
    }
}

// The kit skeletons draw SwiftUI's own placeholder (Vector #1287): the row's
// shape with stand-in words, `.redacted(reason: .placeholder)`, so the bars
// are the system's grey and the shape of text, not hand-colored blocks. The
// frames are the web body's, so the page lays out as it does there. Static:
// redaction has no shimmer, so Reduce Motion needs nothing.
struct SkeletonRowView: View {
    var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "circle.fill").resizable().frame(width: 38, height: 38)
            VStack(alignment: .leading, spacing: 7) {
                Text(verbatim: "Placeholder name").font(.system(size: 12)).frame(height: 12)
                Text(verbatim: "Detail line").font(.system(size: 10)).frame(height: 10)
            }
            Spacer()
            Text(verbatim: "Status").font(.system(size: 13)).frame(width: 64, height: 24)
        }
        .frame(maxWidth: .infinity)
        .redacted(reason: .placeholder)
        .accessibilityHidden(true)
    }
}

struct SkeletonCardView: View {
    var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(verbatim: "Placeholder title").font(.system(size: 14)).frame(height: 14)
            Text(verbatim: "A longer placeholder line of detail text").font(.system(size: 10)).frame(height: 10)
            Text(verbatim: "A shorter line of detail").font(.system(size: 10)).frame(height: 10)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.08)))
        .redacted(reason: .placeholder)
        .accessibilityHidden(true)
    }
}

/// The registry Toggle's `appearance: "check"` (Vector #1295): a round tick
/// at the leading edge, then the label, the whole row the target. iOS has no
/// checkbox, and a switch in a list row reads as a setting; this is the
/// selection mark Reminders and Mail draw. It stays a Toggle: the binding,
/// the on change and the label are SwiftUI's. Selected is the isSelected
/// trait, which is what VoiceOver reads and XCUITest's `isSelected` sees.
struct SpecCheckToggleStyle: ToggleStyle {
    var tint: Color?
    func makeBody(configuration: Configuration) -> some View {
        Button { configuration.isOn.toggle() } label: {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundStyle(configuration.isOn ? (tint ?? Color.accentColor) : Color.secondary)
                    .accessibilityHidden(true)
                configuration.label
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(configuration.isOn ? .isSelected : [])
    }
}

/// The registry's Spinner, as the platform's own ProgressView. `color` tints
/// it as it colors the web ring's arc (nil, the system tint, when empty);
/// `tone` and `trackColor` paint a ring the native control does not draw.
struct SpinnerView: View {
    var color: Any? = nil
    var label: Any? = nil
    var size: Any? = nil
    var tone: Any? = nil
    var trackColor: Any? = nil
    var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
    var body: some View {
        let text = specString(label ?? "")
        HStack(spacing: 8) {
            ProgressView().controlSize(specString(size ?? "md") == "lg" ? .large : (specString(size ?? "md") == "sm" ? .small : .regular))
                .tint(specPaint(color))
            if !text.isEmpty { Text(text).font(.footnote).foregroundStyle(.secondary) }
        }
    }
}

/// The registry's BottomSheet, as the phone's own sheet: `.sheet` with
/// presentation detents from `snapPoints` (fractions of the screen), a drag
/// indicator for `showHandle`, and `fitContent` as a sheet as tall as its
/// body. The caller's body arrives as `specChildren` (the registry declares
/// `@children`, so the CLI registers it slotted); dismissing dispatches
/// `close` as the web does. Before this the charter app carried an EmptyView
/// under the name.
///
/// The `.sheet` hangs on `Color.clear.frame(0, 0)`, never on an EmptyView:
/// SwiftUI drops a presentation modifier on an EmptyView in a container that
/// gives it no place (measured 2026-10-16 in the shop app's ServicingShell,
/// where the Set level sheet and the check's More sheet both opened nothing),
/// the same drop the screen-anchored overlay emit works around the same way.
///
/// THE BODY SCROLLS (Vector #1328). It used to be the sheet's content as is,
/// and `fitContent` opened at `.medium`: a body taller than half the screen
/// was laid out centered in the half and cut at both ends, so the fs
/// Documents sheet's title and Close sat above the top of the screen. Now the
/// body sits in a ScrollView that bounces only when it is taller than the
/// sheet, and `fitContent` measures it: the detent is the body's own height
/// (SwiftUI stops a `.height` detent at the tallest sheet it can show, and the
/// body scrolls inside that). A short body is a short sheet, no empty half.
/// A `snapPoints` sheet keeps its body as is: its height is the author's, and
/// a body built to fill it (a list over a pinned footer) must not be nested
/// in a ScrollView that would hand it no height to fill.
/// The ScrollView sits in a plain VStack, never as the sheet's root view: a
/// root ScrollView makes no room for the keyboard (Vector #838).
struct BottomSheetView: View {
    var fitContent: Any? = nil
    var initialSnap: Any? = nil
    var maxWidth: Any? = nil
    var open: Any? = nil
    var showHandle: Any? = nil
    var snapPoints: Any? = nil
    var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
    var specChildren: AnyView = AnyView(EmptyView())
    @State private var bodyHeight: CGFloat = 0
    private var detents: Set<PresentationDetent> {
        if specTruthy(fitContent) { return bodyHeight > 0 ? [.height(bodyHeight)] : [.medium] }
        let fractions = specArr(snapPoints).map { specNum($0) }.filter { $0 > 0 && $0 <= 1 }
        if fractions.isEmpty { return [.medium, .large] }
        return Set(fractions.map { $0 >= 1 ? PresentationDetent.large : PresentationDetent.fraction($0) })
    }
    var body: some View {
        Color.clear.frame(width: 0, height: 0).sheet(isPresented: Binding(get: { specTruthy(open) }, set: { if !$0 { onDispatch?("close", nil) } })) {
            Group {
                if specTruthy(fitContent) {
                    VStack(spacing: 0) {
                        ScrollView(.vertical, showsIndicators: true) {
                            specChildren
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                                .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { h in
                                    let next = ceil(h)
                                    if abs(next - bodyHeight) >= 1 { bodyHeight = next }
                                }
                        }
                        .scrollBounceBehavior(.basedOnSize)
                    }
                } else {
                    specChildren
                }
            }
            .presentationDetents(detents)
            .presentationDragIndicator(specTruthy(showHandle ?? true) ? .visible : .hidden)
        }
    }
}

/// A vertical scroll pane as tall as its content, never taller than its cap
/// or than it is offered (Vector #1347). The emitter writes it in place of
/// `ScrollView` for a column with `overflow: auto` and a `max-height`, and
/// hands it the cap. The web box is as tall as its rows until the cap and
/// only then scrolls. SwiftUI's `.frame(maxHeight: cap)` is not that: a
/// flexible frame with no minimum is min(offered, cap) tall WHATEVER its child
/// measures, so the fs Book board's setup sheet (`max-height: 45%`) stood
/// 447 pt over 267 pt of rows. This one measures its content and frames
/// itself to min(content, cap), with a zero minimum so a parent offering less
/// still gets less; past the cap it scrolls, and it bounces only then.
struct SpecHugScroll<Content: View>: View {
    let capPoints: CGFloat?
    /// A `max-height: 45%` cap: a fraction of the parent's base (Vector #5482).
    let capFraction: CGFloat?
    let content: Content
    @State private var contentHeight: CGFloat? = nil
    @Environment(\.specPercentBase) private var base
    init(maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.capPoints = maxHeight
        self.capFraction = nil
        self.content = content()
    }
    init(maxFraction: CGFloat, @ViewBuilder content: () -> Content) {
        self.capPoints = nil
        self.capFraction = maxFraction
        self.content = content()
    }
    private var maxHeight: CGFloat {
        if let capPoints { return capPoints }
        return max((base.height ?? specScreenHeight()) * (capFraction ?? 1), 0)
    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            content.onGeometryChange(for: CGFloat.self) { $0.size.height } action: { h in
                if contentHeight == nil || abs((contentHeight ?? 0) - h) >= 0.5 { contentHeight = h }
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .frame(minHeight: 0, idealHeight: hug, maxHeight: hug)
    }
    /// The ideal height too: a parent that asks for one (a fitContent
    /// BottomSheet's ScrollView) would otherwise get the ScrollView's own.
    private var hug: CGFloat { min(contentHeight ?? maxHeight, maxHeight) }
}

// MARK: - Vector drawing (Canvas)
//
// The `vector` block lowers to a SwiftUI Canvas whose shapes may read data:
// a loop item's coordinates, a fn-built points string, a paint map. These
// parse those runtime values the way the browser parses the SVG attribute.

/// A fill or stroke value: nil for "none", "transparent" or nothing (no paint,
/// as in SVG), otherwise the CSS color — hex or rgb()/rgba().
func specPaint(_ v: Any?) -> Color? {
    if let c = v as? Color { return c }
    let s = specString(v).trimmingCharacters(in: .whitespaces)
    if s.isEmpty || s == "none" || s == "transparent" || s == "null" { return nil }
    return Color(css: s)
}

/// The numbers in an SVG list attribute ("10,20 30 40"), in order.
func specNumberList(_ v: Any?) -> [Double] {
    specString(v)
        .split(whereSeparator: { $0 == "," || $0 == " " || $0 == "\n" || $0 == "\t" })
        .compactMap { Double($0) }
}

/// An SVG `points` string as points; a trailing odd number is dropped.
func specPoints(_ v: Any?) -> [CGPoint] {
    let n = specNumberList(v)
    var out: [CGPoint] = []
    var i = 0
    while i + 1 < n.count {
        out.append(CGPoint(x: n[i], y: n[i + 1]))
        i += 2
    }
    return out
}

/// A viewBox as [x, y, w, h]; an unreadable or empty box is 0 0 100 100.
func specViewBox(_ v: Any?) -> [Double] {
    let n = specNumberList(v)
    if n.count == 4 && n[2] > 0 && n[3] > 0 { return n }
    return [0, 0, 100, 100]
}

/// A viewBox's width over its height, for the Canvas's aspect ratio.
func specViewBoxAspect(_ v: Any?) -> CGFloat {
    let b = specViewBox(v)
    return CGFloat(b[2] / b[3])
}

/// A vector's viewBox → view mapping OUTSIDE its Canvas closure: the same
/// arithmetic as the `_tx`/`_ty` the Canvas declares, for the tap layer laid
/// over a drawing whose shapes carry `on click` (the hit areas must land on
/// the shapes they belong to). `stretch` is `preserveAspectRatio: 'none'`.
struct SpecVecMap {
    let sx: Double, sy: Double, ox: Double, oy: Double, vx: Double, vy: Double
    init(size: CGSize, vb: [Double], stretch: Bool) {
        let w = Double(size.width), h = Double(size.height)
        vx = vb[0]; vy = vb[1]
        if stretch {
            sx = w / vb[2]; sy = h / vb[3]; ox = 0; oy = 0
        } else {
            let s = min(w / vb[2], h / vb[3])
            sx = s; sy = s
            ox = (w - vb[2] * s) / 2; oy = (h - vb[3] * s) / 2
        }
    }
    func rect(_ x: Double, _ y: Double, _ w: Double, _ h: Double) -> CGRect {
        CGRect(x: (x - vx) * sx + ox, y: (y - vy) * sy + oy, width: max(w, 0) * sx, height: max(h, 0) * sy)
    }
}

/// The union of a clickable group's shapes, for its hit area.
func specUnionRects(_ rs: [CGRect]) -> CGRect {
    let u = rs.reduce(CGRect.null) { $0.union($1) }
    return u.isNull ? .zero : u
}

/// A `strokeDasharray` value as dash lengths (viewBox units).
func specDash(_ v: Any?) -> [Double] {
    specNumberList(v).filter { $0 >= 0 }
}

/// A registry Button's text: `loadingLabel` while loading, when it is not
/// blank, else the label (button.spec `effectiveLabel`, Vector #2432).
func specButtonLabel(_ label: Any?, loading: Bool, loadingLabel: Any?) -> String {
    let busy = specString(loadingLabel)
    return loading && !busy.isEmpty ? busy : specString(label)
}

/// A bound `text-anchor` as a horizontal UnitPoint fraction: middle 0.5, end 1,
/// anything else SVG's default, start (0). Android's twin is specVecAnchor.
func specVecAnchor(_ v: Any?) -> Double {
    switch specString(v).trimmingCharacters(in: .whitespaces) {
    case "middle": return 0.5
    case "end": return 1
    default: return 0
    }
}

/// A bound `stroke-linecap`; anything but round or square is SVG's default, butt.
func specVecCap(_ v: Any?) -> CGLineCap {
    switch specString(v).trimmingCharacters(in: .whitespaces) {
    case "round": return .round
    case "square": return .square
    default: return .butt
    }
}

/// A bound `stroke-linejoin`; anything but round or bevel is SVG's default, miter.
func specVecJoin(_ v: Any?) -> CGLineJoin {
    switch specString(v).trimmingCharacters(in: .whitespaces) {
    case "round": return .round
    case "bevel": return .bevel
    default: return .miter
    }
}

/// A live region: what a `role: 'alert'` / `aria-live` block is on the web.
///
/// SwiftUI has no live region, so the emitter attaches this to such a block
/// and it posts the VoiceOver announcement a browser would have made. It speaks
/// when the region's text CHANGES (and is not empty), and an assertive region
/// also when it appears, since a `visibility:`-gated alert mounts with its
/// words already set. A redraw with the same words posts nothing: `onChange`
/// fires on a new value only, so an error left on screen is said once.
///
/// Assertive is `.high` (interrupts, is not cut off); polite is `.low`, which
/// VoiceOver queues behind whatever it is saying, as `aria-live: polite` does.
///
/// `collapses`: the region holds only words and the emitter leaves it out of
/// the layout while they are empty (`specLiveHasWords`, #833), so it mounts
/// when they arrive. That appearance IS the change the web reports, so it
/// speaks whatever the politeness. Clearing the words unmounts it, which says
/// nothing, and the next failure mounts it fresh and speaks again.
extension View {
    func specLiveRegion(_ parts: [String], assertive: Bool, collapses: Bool = false) -> some View {
        modifier(SpecLiveRegion(
            text: specLiveText(parts),
            assertive: assertive,
            speaksOnAppear: assertive || collapses))
    }
}

/// A region's words as one utterance: its non-empty texts, space-joined.
func specLiveText(_ parts: [String]) -> String {
    parts.filter { !$0.isEmpty }.joined(separator: " ")
}

/// Whether a words-only live region has anything to show. While it does not,
/// the emitter does not draw it at all: an empty `Text` is a full line tall,
/// and a stack spaces any child it holds, so only an absent view takes no room.
func specLiveHasWords(_ parts: [String]) -> Bool {
    parts.contains { !$0.isEmpty }
}

/// `SPEC_LIVE_REGION_PROBE=1` in the launch environment makes every region
/// that has spoken carry a 1-pt element `spec-live-region` whose label is the
/// last thing it announced and whose value is its politeness and how many
/// times those words have been announced ("assertive 2"). XCUITest cannot
/// hear VoiceOver, so this is how a UI test proves the post ran with the words.
///
/// The count is per WORDS and process-wide, not per view: a collapsing region
/// unmounts when its words clear and mounts fresh on the next failure, and a
/// count kept in the region's own @State restarted at 1 each time, so a
/// repeated error that WAS said again read "assertive 1" (Vector I-411).
let specLiveRegionProbe = ProcessInfo.processInfo.environment["SPEC_LIVE_REGION_PROBE"] == "1"

struct SpecLiveRegion: ViewModifier {
    let text: String
    let assertive: Bool
    let speaksOnAppear: Bool
    @State private var spoken = ""
    @State private var times = 0

    func body(content: Content) -> some View {
        content
            .onAppear { if speaksOnAppear { announce(text) } }
            .onChange(of: text) { _, now in announce(now) }
            .overlay(alignment: .topLeading) {
                if specLiveRegionProbe && !spoken.isEmpty {
                    Rectangle()
                        .fill(Color.white.opacity(0.001))
                        .frame(width: 1, height: 1)
                        .allowsHitTesting(false)
                        .accessibilityElement()
                        .accessibilityIdentifier("spec-live-region")
                        .accessibilityLabel(spoken)
                        .accessibilityValue("\(assertive ? "assertive" : "polite") \(times)")
                }
            }
    }

    private func announce(_ words: String) {
        guard !words.isEmpty else { return }
        var said = AttributedString(words)
        said.accessibilitySpeechAnnouncementPriority = assertive ? .high : .low
        AccessibilityNotification.Announcement(said).post()
        if specLiveRegionProbe { spoken = words; times = SpecLiveRegionProbeCount.bump(words) }
    }
}

/// How many times each set of words has been announced, for the probe above.
@MainActor
enum SpecLiveRegionProbeCount {
    private static var said: [String: Int] = [:]
    static func bump(_ words: String) -> Int {
        let n = (said[words] ?? 0) + 1
        said[words] = n
        return n
    }
}

// MARK: - Animation presets (`animation: "wave"` and friends)

/// The four built-in `animation:` presets, the iOS half of the web's
/// spec-pulse / spec-wave / spec-spin / spec-fade-in keyframes (ir-to-js
/// ANIMATION_PRESETS, same durations). Before this the emitter dropped every
/// `animation:`, so a loading skeleton's shimmer stood still (Vector #1281).
/// A name that is not a preset (an app's own keyframes, which live in the
/// web's CSS where the emitter cannot read them) leaves the view as it is.
/// Accepts the bare preset (`wave`) or the web's long form
/// (`spec-wave 1.5s ease-in-out infinite`).
func specAnimationPreset(_ raw: Any?) -> String {
    let s = (_unwrapOptional(raw) as? String ?? "").trimmingCharacters(in: .whitespaces)
    var name = s.split(separator: " ").first.map(String.init) ?? ""
    if name.hasPrefix("spec-") { name = String(name.dropFirst(5)) }
    return ["pulse", "wave", "spin", "fade-in"].contains(name) ? name : ""
}

/// translateX(-100%) → translateX(100%) of the view's OWN width, which a
/// GeometryEffect is handed and a plain `.offset` is not.
struct SpecWaveEffect: GeometryEffect {
    var phase: CGFloat
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: phase * size.width, y: 0))
    }
}

struct SpecAnimationModifier: ViewModifier {
    let preset: String
    @State private var shown = false
    // A loading shimmer or pulse is decoration: with Reduce Motion on it
    // stands still (Vector #1287). A spin is a busy indicator and keeps
    // turning, as the system's own ProgressView does, slowed to one turn per
    // 2.4 s as the web's reduced-motion rule does (Vector #2599).
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    // The repeating presets read their phase off the clock (TimelineView),
    // not off a state flipped inside withAnimation(.repeatForever): measured
    // on the flight school Today card, that version parked the shimmer at its
    // first frame and never moved, because the emitted tree re-renders around
    // it and the repeating transaction did not survive.
    func body(content: Content) -> some View {
        // A held wave parks off its clipped box (phase -1), so the Skeleton is
        // a plain grey block, as the web's reduced-motion rule does (#2261).
        switch reduceMotion && (preset == "wave" || preset == "pulse") ? (preset == "wave" ? "held-wave" : "") : preset {
        case "held-wave":
            content.modifier(SpecWaveEffect(phase: -1))
        case "wave", "pulse", "spin":
            TimelineView(.animation) { ctx in
                let t = ctx.date.timeIntervalSinceReferenceDate
                switch preset {
                case "wave":
                    content.modifier(SpecWaveEffect(phase: CGFloat(specEaseInOut(specCycle(t, 1.5)) * 2 - 1)))
                case "pulse":
                    // 1 → 0.5 → 1 over 1.5 s, eased each way.
                    let p = specCycle(t, 1.5)
                    content.opacity(1 - 0.5 * specEaseInOut(p < 0.5 ? p * 2 : (1 - p) * 2))
                default:
                    content.rotationEffect(.degrees(specCycle(t, reduceMotion ? 2.4 : 1) * 360))
                }
            }
        case "fade-in":
            content
                .opacity(shown ? 1 : 0)
                .onAppear { withAnimation(.easeOut(duration: 0.3)) { shown = true } }
        default:
            content
        }
    }
}

/// Where `t` is in a cycle of `period` seconds, 0 ..< 1.
func specCycle(_ t: TimeInterval, _ period: Double) -> Double {
    (t.truncatingRemainder(dividingBy: period)) / period
}

/// CSS `ease-in-out`, near enough: a symmetric quadratic.
func specEaseInOut(_ p: Double) -> Double {
    p < 0.5 ? 2 * p * p : 1 - pow(-2 * p + 2, 2) / 2
}

extension View {
    /// `animation:` on a block; the emitter passes the static preset or the
    /// bound value, and anything that is not a preset is a no-op.
    func specAnimation(_ value: Any?) -> some View {
        modifier(SpecAnimationModifier(preset: specAnimationPreset(value)))
    }
}

// MARK: - Bound aria-label

extension View {
    /// A bound `aria-label:`: the view is named only while the value has
    /// words. nil or "" leaves the view's own words as its name, which is
    /// what the web does when an aria-label binds to null.
    @ViewBuilder
    func specAriaLabel(_ value: Any?) -> some View {
        let s = specString(value)
        if s.isEmpty { self } else { self.accessibilityLabel(s) }
    }
}

// ── Bound justify (Vector I-612) ─────────────────────────────────────────
// `layout: horizontal, justify: <expression>` lowers to Spacers gated on
// these, so the arrangement follows the value. The value may be a Spec word
// (`end`, `between`) or its CSS spelling (`flex-end`, `space-between`);
// anything else packs at the start, as an unknown justify-content does.
func specJustifyCSS(_ v: Any?) -> String {
    let s = specString(_unwrapOptional(v)).trimmingCharacters(in: .whitespaces)
    let words = ["start": "flex-start", "end": "flex-end", "between": "space-between",
                 "around": "space-around", "evenly": "space-evenly"]
    return words[s] ?? s
}

func specJustifyLead(_ v: Any?) -> Bool {
    ["center", "flex-end", "space-around", "space-evenly"].contains(specJustifyCSS(v))
}

func specJustifyBetween(_ v: Any?) -> Bool {
    ["space-between", "space-around", "space-evenly"].contains(specJustifyCSS(v))
}

func specJustifyTrail(_ v: Any?) -> Bool {
    ["center", "space-around", "space-evenly"].contains(specJustifyCSS(v))
}

// ── Bound row align (Vector I-2670) ──────────────────────────────────────
// `layout: horizontal, align: <expression>` is the HStack's cross axis, read
// when the view draws. Spec words or their CSS spelling; anything else
// (center, stretch, baseline, empty) centers, as a literal one does.
func specRowAlign(_ v: Any?) -> VerticalAlignment {
    switch specString(_unwrapOptional(v)).trimmingCharacters(in: .whitespaces) {
    case "start", "flex-start": return .top
    case "end", "flex-end": return .bottom
    default: return .center
    }
}

// ── Bound column align (Vector #3055) ────────────────────────────────────
// `layout: vertical, align: <expression>` is the VStack's cross axis, read
// when the view draws. Spec words or their CSS spelling; anything else
// (start, stretch, an unknown word, empty) is leading, as the web's default
// stretch reads.
func specColumnAlign(_ v: Any?) -> HorizontalAlignment {
    switch specString(_unwrapOptional(v)).trimmingCharacters(in: .whitespaces) {
    case "center": return .center
    case "end", "flex-end": return .trailing
    default: return .leading
    }
}

/// Whether a component's mount site stretches its painted root (Vector #4967).
/// The mount sets it (the parent column's stretch gate, false in a row); the
/// component's root frames itself `maxWidth: .infinity` while it holds, as
/// the web's `display: contents` host lets its root block stretch.
private struct SpecMountFillsKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var specMountFills: Bool {
        get { self[SpecMountFillsKey.self] }
        set { self[SpecMountFillsKey.self] = newValue }
    }
}

// ── Bound align as stretch (Vector #3061) ────────────────────────────────
// Whether a bound `align:` stretches its children on the cross axis, as the
// web's align-items does: stretch, normal, an unset or empty value, and a
// word it ignores all leave the default, stretch. The emitter gates each
// child's `maxWidth` / `maxHeight: .infinity` on it.
func specAlignStretches(_ v: Any?) -> Bool {
    switch specString(_unwrapOptional(v)).trimmingCharacters(in: .whitespaces) {
    case "start", "flex-start", "center", "end", "flex-end", "baseline": return false
    default: return true
    }
}

// ── Bound text-transform (Vector I-2723) ─────────────────────────────────
// `text-transform: <expression>` as a `.textCase`. nil leaves the text as
// written: `none`, empty, and `capitalize` (no TextCase can say it).
func specTextCase(_ v: Any?) -> Text.Case? {
    switch specString(_unwrapOptional(v)).trimmingCharacters(in: .whitespaces).lowercased() {
    case "uppercase": return .uppercase
    case "lowercase": return .lowercase
    default: return nil
    }
}

// MARK: - on focus-in (Vector #5476, #5499)

/// A block's `on focus-in`: the handler runs when a tap lands anywhere inside
/// the block, as the web's bubbling `focusin` does when a field, a picker or a
/// date inside it takes focus. It began as a SwiftUI `simultaneousGesture`
/// tap (#5476), which only a text field let through: a compact DatePicker
/// (UIDatePicker) and a Select (Menu) keep the touch in UIKit, so tapping
/// "Date of examination" on Scan a Form opened the calendar and lit no read
/// box (#5499). So on UIKit the tap is watched from the WINDOW: a recognizer
/// there sees every touch before any control does, never cancels or delays
/// one, and never recognizes, so the field still takes the cursor and the
/// picker still opens. It counts a touch that lifts within 10 pt of where it
/// landed, inside the block's frame, on the same layer as the block (a tap
/// on a sheet or menu drawn over the block is not a tap in it).
extension View {
    func specFocusIn(_ action: @escaping () -> Void) -> some View {
        #if canImport(UIKit)
        return self.background(SpecTapWithin(action: action))
        #else
        return self.simultaneousGesture(TapGesture().onEnded { action() })
        #endif
    }
}

#if canImport(UIKit)
struct SpecTapWithin: UIViewRepresentable {
    let action: () -> Void

    func makeUIView(context: Context) -> SpecTapWithinView {
        let v = SpecTapWithinView()
        v.isUserInteractionEnabled = false
        v.backgroundColor = .clear
        v.action = action
        return v
    }

    func updateUIView(_ v: SpecTapWithinView, context: Context) { v.action = action }

    static func dismantleUIView(_ v: SpecTapWithinView, coordinator: ()) { v.detach() }
}

final class SpecTapWithinView: UIView {
    var action: (() -> Void)?
    private var recognizer: SpecTapWithinRecognizer?

    override func didMoveToWindow() {
        super.didMoveToWindow()
        detach()
        guard let window else { return }
        let r = SpecTapWithinRecognizer(owner: self)
        window.addGestureRecognizer(r)
        recognizer = r
    }

    func detach() {
        if let r = recognizer { r.view?.removeGestureRecognizer(r) }
        recognizer = nil
    }

    /// Shown: no ancestor hidden or faded out (a kept-alive match arm).
    var isShown: Bool {
        var v: UIView? = self
        while let cur = v {
            if cur.isHidden || cur.alpha < 0.01 { return false }
            v = cur.superview
        }
        return window != nil
    }
}

/// The window's child a view lives under: the app's own screen, or the
/// transition view a sheet, popover or menu is presented in.
func specWindowLayer(_ view: UIView) -> UIView {
    var v = view
    while let s = v.superview, !(s is UIWindow) { v = s }
    return v
}

final class SpecTapWithinRecognizer: UIGestureRecognizer, UIGestureRecognizerDelegate {
    weak var owner: SpecTapWithinView?
    private var start: CGPoint?

    init(owner: SpecTapWithinView) {
        self.owner = owner
        super.init(target: nil, action: nil)
        cancelsTouchesInView = false
        delaysTouchesBegan = false
        delaysTouchesEnded = false
        delegate = self
    }

    func gestureRecognizer(_ g: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith other: UIGestureRecognizer) -> Bool { true }

    func gestureRecognizer(_ g: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let owner, owner.isShown, let hit = touch.view, hit.window === owner.window else { return false }
        guard owner.bounds.contains(touch.location(in: owner)) else { return false }
        if hit.isDescendant(of: owner) { return true }
        return specWindowLayer(hit) === specWindowLayer(owner)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        guard touches.count == 1, start == nil, let t = touches.first else { state = .failed; return }
        start = t.location(in: nil)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let start, let t = touches.first else { return }
        let p = t.location(in: nil)
        if hypot(p.x - start.x, p.y - start.y) > 10 { state = .failed }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        if let start, let t = touches.first {
            let p = t.location(in: nil)
            if hypot(p.x - start.x, p.y - start.y) <= 10 { owner?.action?() }
        }
        state = .failed
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) { state = .failed }

    override func reset() { start = nil }
}
#endif
