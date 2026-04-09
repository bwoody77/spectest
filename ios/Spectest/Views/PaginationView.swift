import SwiftUI
import SpecRuntime

@Observable
final class PaginationViewModel {
  var maxButtons: Any = 7
  var page: Any = 1
  var pageSize: Any = 10
  var total: Any? = nil
  var totalPages: Any { (((total as? Double ?? 0) > (0 as? Double ?? 0)) ? ((specString(((total as? Double ?? 0) .truncatingRemainder(dividingBy: (pageSize as? Double ?? 0)))) == specString(0)) ? ((total as? Double ?? 0) / (pageSize as? Double ?? 0)) : specAdd(((((total as? Double ?? 0) - (((total as? Double ?? 0) .truncatingRemainder(dividingBy: (pageSize as? Double ?? 0))) as? Double ?? 0)) as? Double ?? 0) / (pageSize as? Double ?? 0)), 1)) : 1) }
  var currentPage: Any { (((page as? Double ?? 0) < (1 as? Double ?? 0)) ? 1 : (((page as? Double ?? 0) > (totalPages as? Double ?? 0)) ? totalPages : page)) }
  var startItem: Any { specAdd(((((currentPage as? Double ?? 0) - (1 as? Double ?? 0)) as? Double ?? 0) * (pageSize as? Double ?? 0)), 1) }
  var endItem: Any { (((((currentPage as? Double ?? 0) * (pageSize as? Double ?? 0)) as? Double ?? 0) > (total as? Double ?? 0)) ? total : ((currentPage as? Double ?? 0) * (pageSize as? Double ?? 0))) }
  var hasPrev: Any { ((currentPage as? Double ?? 0) > (1 as? Double ?? 0)) }
  var hasNext: Any { ((currentPage as? Double ?? 0) < (totalPages as? Double ?? 0)) }
}

struct PaginationView: View {
  @State private var vm = PaginationViewModel()
  var maxButtons: Any = 7
  var page: Any = 1
  var pageSize: Any = 10
  var total: Any? = nil
  init(maxButtons: Any = 7, page: Any = 1, pageSize: Any = 10, total: Any? = nil) { self._vm = State(initialValue: PaginationViewModel()); self.maxButtons = maxButtons; self.page = page; self.pageSize = pageSize; self.total = total }
  var body: some View {
    VStack() {
      HStack(alignment: .center, spacing: CGFloat(8)) {
        Text(specString("\(specString(vm.startItem))-\(specString(vm.endItem)) of \(specString(vm.total))"))
          .font(.callout.bold())
          .foregroundStyle(.secondary)
        HStack(alignment: .center, spacing: CGFloat(4)) {
          HStack(alignment: .center, ) {
            Text(specString("u2039"))
              .font(.body.bold())
              .foregroundStyle(.primary)
          }
          .padding(CGFloat(8))
          .clipShape(RoundedRectangle(cornerRadius: CGFloat(8)))
          .opacity(specPx(((vm.hasPrev) as? Bool ?? false ? 1 : 0.4)))
          .frame(minWidth: CGFloat(32))
          .frame(minHeight: CGFloat(32))
          .clipShape(RoundedRectangle(cornerRadius: CGFloat(8)))
          .onTapGesture { if vm.hasPrev as? Bool ?? false {
  /* event callback */
} }
          HStack(alignment: .center, ) {
            Text(specString("1"))
              .font(.body.bold())
              .foregroundStyle(Color(hex: ((specString(vm.currentPage) == specString(1)) ? "#ffffff" : "#496183") as? String ?? "#000"))
          }
          .padding(CGFloat(8))
          .frame(minWidth: CGFloat(32))
          .frame(minHeight: CGFloat(32))
          .background(Color(hex: ((specString(vm.currentPage) == specString(1)) ? "#1677ff" : "transparent") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
          .onTapGesture { /* event callback */ }
          HStack(alignment: .center, ) {
            if (((vm.currentPage as? Double ?? 0) > (3 as? Double ?? 0)) && ((vm.totalPages as? Double ?? 0) > (vm.maxButtons as? Double ?? 0))) {
              Text(specString("u2026"))
                .font(.body.bold())
                .foregroundStyle(.tertiary)
            }
          }
          .padding(CGFloat(8))
          .frame(minWidth: CGFloat(32))
          HStack(alignment: .center, ) {
            if (((vm.totalPages as? Double ?? 0) > (2 as? Double ?? 0)) && ((((vm.currentPage as? Double ?? 0) - (1 as? Double ?? 0)) as? Double ?? 0) > (1 as? Double ?? 0))) {
              Text(specString("\(specString(((vm.currentPage as? Double ?? 0) - (1 as? Double ?? 0))))"))
                .font(.body.bold())
                .foregroundStyle(.secondary)
            }
          }
          .padding(CGFloat(8))
          .frame(minWidth: CGFloat(32))
          .frame(minHeight: CGFloat(32))
          .background(Color.clear, in: RoundedRectangle(cornerRadius: CGFloat(8)))
          .onTapGesture { /* event callback */ }
          HStack(alignment: .center, ) {
            if (((vm.currentPage as? Double ?? 0) > (1 as? Double ?? 0)) && ((vm.currentPage as? Double ?? 0) < (vm.totalPages as? Double ?? 0))) {
              Text(specString("\(specString(vm.currentPage))"))
                .font(.body.bold())
                .foregroundStyle(Color(.secondarySystemGroupedBackground))
            }
          }
          .padding(CGFloat(8))
          .frame(minWidth: CGFloat(32))
          .frame(minHeight: CGFloat(32))
          .background(Color.blue, in: RoundedRectangle(cornerRadius: CGFloat(8)))
          HStack(alignment: .center, ) {
            if (((vm.totalPages as? Double ?? 0) > (2 as? Double ?? 0)) && ((specAdd(vm.currentPage, 1) as? Double ?? 0) < (vm.totalPages as? Double ?? 0))) {
              Text(specString("\(specString(specAdd(vm.currentPage, 1)))"))
                .font(.body.bold())
                .foregroundStyle(.secondary)
            }
          }
          .padding(CGFloat(8))
          .frame(minWidth: CGFloat(32))
          .frame(minHeight: CGFloat(32))
          .background(Color.clear, in: RoundedRectangle(cornerRadius: CGFloat(8)))
          .onTapGesture { /* event callback */ }
          HStack(alignment: .center, ) {
            if (((vm.currentPage as? Double ?? 0) < (((vm.totalPages as? Double ?? 0) - (2 as? Double ?? 0)) as? Double ?? 0)) && ((vm.totalPages as? Double ?? 0) > (vm.maxButtons as? Double ?? 0))) {
              Text(specString("u2026"))
                .font(.body.bold())
                .foregroundStyle(.tertiary)
            }
          }
          .padding(CGFloat(8))
          .frame(minWidth: CGFloat(32))
          HStack(alignment: .center, ) {
            if ((vm.totalPages as? Double ?? 0) > (1 as? Double ?? 0)) {
              Text(specString("\(specString(vm.totalPages))"))
                .font(.body.bold())
                .foregroundStyle(Color(hex: ((specString(vm.currentPage) == specString(vm.totalPages)) ? "#ffffff" : "#496183") as? String ?? "#000"))
            }
          }
          .padding(CGFloat(8))
          .frame(minWidth: CGFloat(32))
          .frame(minHeight: CGFloat(32))
          .background(Color(hex: ((specString(vm.currentPage) == specString(vm.totalPages)) ? "#1677ff" : "transparent") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
          .onTapGesture { /* event callback */ }
          HStack(alignment: .center, ) {
            Text(specString("u203A"))
              .font(.body.bold())
              .foregroundStyle(.primary)
          }
          .padding(CGFloat(8))
          .clipShape(RoundedRectangle(cornerRadius: CGFloat(8)))
          .opacity(specPx(((vm.hasNext) as? Bool ?? false ? 1 : 0.4)))
          .frame(minWidth: CGFloat(32))
          .frame(minHeight: CGFloat(32))
          .clipShape(RoundedRectangle(cornerRadius: CGFloat(8)))
          .onTapGesture { if vm.hasNext as? Bool ?? false {
  /* event callback */
} }
        }

      }

    }
    .foregroundStyle(.primary)
    .onAppear { vm.total = total; vm.pageSize = pageSize; vm.page = page; vm.maxButtons = maxButtons }
  }
}
