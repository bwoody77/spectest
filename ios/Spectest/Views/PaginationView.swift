import SwiftUI
import SpecRuntime

@Observable
final class PaginationViewModel {
  var maxButtons: Any = 7
  var page: Any = 1
  var pageSize: Any = 10
  var total: Any? = nil
  var totalPages: Any { ((specDouble(total) > specDouble(0)) ? (specEq((specDouble(total) .truncatingRemainder(dividingBy: specDouble(pageSize))), 0) ? (specDouble(total) / specDouble(pageSize)) : specAdd((specDouble((specDouble(total) - specDouble((specDouble(total) .truncatingRemainder(dividingBy: specDouble(pageSize)))))) / specDouble(pageSize)), 1)) : 1) }
  var currentPage: Any { ((specDouble(page) < specDouble(1)) ? 1 : ((specDouble(page) > specDouble(totalPages)) ? totalPages : page)) }
  var startItem: Any { specAdd((specDouble((specDouble(currentPage) - specDouble(1))) * specDouble(pageSize)), 1) }
  var endItem: Any { ((specDouble((specDouble(currentPage) * specDouble(pageSize))) > specDouble(total)) ? total : (specDouble(currentPage) * specDouble(pageSize))) }
  var hasPrev: Any { (specDouble(currentPage) > specDouble(1)) }
  var hasNext: Any { (specDouble(currentPage) < specDouble(totalPages)) }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
        Text(verbatim: specString("\(specString(vm.startItem))-\(specString(vm.endItem)) of \(specString(vm.total))"))
          .font(.callout.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        HStack(alignment: .center, spacing: CGFloat(4)) {
          HStack(alignment: .center, ) {
            Text(verbatim: specString("u2039"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          }
          .padding(CGFloat(8))
          .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          .opacity(specPx(((vm.hasPrev) as? Bool ?? false ? 1 : 0.4)))
          .frame(minWidth: CGFloat(32))
          .frame(minHeight: CGFloat(32))
          .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          .onTapGesture { if (vm.hasPrev) as? Bool ?? false {
  /* event callback */
} }
          HStack(alignment: .center, ) {
            Text(verbatim: specString("1"))
              .font(.body.bold())
              .foregroundStyle(Color(hex: (specEq(vm.currentPage, 1) ? "#ffffff" : "#496183") as? String ?? "#000"))
          }
          .padding(CGFloat(8))
          .frame(minWidth: CGFloat(32))
          .frame(minHeight: CGFloat(32))
          .background(Color(hex: (specEq(vm.currentPage, 1) ? "#1677ff" : "transparent") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          .onTapGesture { /* event callback */ }
          HStack(alignment: .center, ) {
            if ((specDouble(vm.currentPage) > specDouble(3)) && (specDouble(vm.totalPages) > specDouble(vm.maxButtons))) {
              Text(verbatim: specString("u2026"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            }
          }
          .padding(CGFloat(8))
          .frame(minWidth: CGFloat(32))
          HStack(alignment: .center, ) {
            if ((specDouble(vm.totalPages) > specDouble(2)) && (specDouble((specDouble(vm.currentPage) - specDouble(1))) > specDouble(1))) {
              Text(verbatim: specString("\(specString((specDouble(vm.currentPage) - specDouble(1))))"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }
          }
          .padding(CGFloat(8))
          .frame(minWidth: CGFloat(32))
          .frame(minHeight: CGFloat(32))
          .background(Color.clear, in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          .onTapGesture { /* event callback */ }
          HStack(alignment: .center, ) {
            if ((specDouble(vm.currentPage) > specDouble(1)) && (specDouble(vm.currentPage) < specDouble(vm.totalPages))) {
              Text(verbatim: specString("\(specString(vm.currentPage))"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.on-destructive"))
            }
          }
          .padding(CGFloat(8))
          .frame(minWidth: CGFloat(32))
          .frame(minHeight: CGFloat(32))
          .background(ThemeManager.shared.color("semantic.accent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          HStack(alignment: .center, ) {
            if ((specDouble(vm.totalPages) > specDouble(2)) && (specDouble(specAdd(vm.currentPage, 1)) < specDouble(vm.totalPages))) {
              Text(verbatim: specString("\(specString(specAdd(vm.currentPage, 1)))"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }
          }
          .padding(CGFloat(8))
          .frame(minWidth: CGFloat(32))
          .frame(minHeight: CGFloat(32))
          .background(Color.clear, in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          .onTapGesture { /* event callback */ }
          HStack(alignment: .center, ) {
            if ((specDouble(vm.currentPage) < specDouble((specDouble(vm.totalPages) - specDouble(2)))) && (specDouble(vm.totalPages) > specDouble(vm.maxButtons))) {
              Text(verbatim: specString("u2026"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            }
          }
          .padding(CGFloat(8))
          .frame(minWidth: CGFloat(32))
          HStack(alignment: .center, ) {
            if (specDouble(vm.totalPages) > specDouble(1)) {
              Text(verbatim: specString("\(specString(vm.totalPages))"))
                .font(.body.bold())
                .foregroundStyle(Color(hex: (specEq(vm.currentPage, vm.totalPages) ? "#ffffff" : "#496183") as? String ?? "#000"))
            }
          }
          .padding(CGFloat(8))
          .frame(minWidth: CGFloat(32))
          .frame(minHeight: CGFloat(32))
          .background(Color(hex: (specEq(vm.currentPage, vm.totalPages) ? "#1677ff" : "transparent") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          .onTapGesture { /* event callback */ }
          HStack(alignment: .center, ) {
            Text(verbatim: specString("u203A"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          }
          .padding(CGFloat(8))
          .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          .opacity(specPx(((vm.hasNext) as? Bool ?? false ? 1 : 0.4)))
          .frame(minWidth: CGFloat(32))
          .frame(minHeight: CGFloat(32))
          .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          .onTapGesture { if (vm.hasNext) as? Bool ?? false {
  /* event callback */
} }
        }

      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.total = total; vm.pageSize = pageSize; vm.page = page; vm.maxButtons = maxButtons }
  }
}
