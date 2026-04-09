// @speckeep — form validation needs runtime-call String fix
import SwiftUI
import SpecRuntime
@Observable final class FormDemoViewModel {}
struct FormDemoView: View { @State private var vm = FormDemoViewModel(); var body: some View { VStack { Text("Form Demo").font(.title2); Text("Form validation coming soon").foregroundStyle(.secondary) }.padding() } }
