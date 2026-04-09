// @speckeep
import SwiftUI
import SpecRuntime
@Observable final class DataGridSpecViewModel {}
struct DataGridSpecView: View { @State private var vm = DataGridSpecViewModel(); var body: some View { SpecDataGridView(columns: [] as [Any], rows: [] as [Any], selection: "none", height: CGFloat(300)) } }
