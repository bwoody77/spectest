import SwiftUI
import SpecRuntime
@Observable final class PerfSignalsViewModel {}
struct PerfSignalsView: View { @State private var vm = PerfSignalsViewModel(); var body: some View { Text("Stub").foregroundStyle(.secondary).padding() } }
