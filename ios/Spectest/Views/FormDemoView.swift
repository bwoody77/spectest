import SwiftUI
import SpecRuntime
@Observable final class FormDemoViewModel {}
struct FormDemoView: View { @State private var vm = FormDemoViewModel(); var body: some View { Text("Stub").foregroundStyle(.secondary).padding() } }
