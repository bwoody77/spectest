// SpecRuntime.swift — Minimal helpers for Spec-compiled pure functions.
// Drop this file into your Xcode project alongside the generated Swift code.
// These bridge Spec's dynamically-typed fn model to Swift's type system.

import Foundation
import SwiftUI

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
    guard let s = val as? String else {
        if let a = val as? [Any] {
            let si = Int(start as! Double)
            let ei = end != nil ? Int(end as! Double) : a.count
            return Array(a[max(0, si)..<min(a.count, ei)])
        }
        return ""
    }
    let si = s.index(s.startIndex, offsetBy: max(0, min(s.count, Int(start as! Double))))
    let ei: String.Index
    if let e = end {
        ei = s.index(s.startIndex, offsetBy: max(0, min(s.count, Int(e as! Double))))
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
