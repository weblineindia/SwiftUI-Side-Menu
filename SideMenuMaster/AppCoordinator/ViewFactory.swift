import Foundation
import SwiftUI

class ViewFactory {
    @ViewBuilder static func viewForDestination(_ destination: DestinationFlowPage) -> some View {
        switch destination {
        case .login:
            self.getLoginView()
        case .home:
            self.getHomeSideMenuView()
        case .generalDetail(text: let text):
            getGeneralDetail(text: text)
        }
    }
    
    static func getLoginView() -> some View {
        let view = LoginView(viewModel: LoginViewModel())
        return view
    }
   
    static func getHomeSideMenuView() -> some View {
        let view = HomeSideMenuView(viewModel: HomeSideMenuViewModel())
        return view
    }
    static func getProfileView() -> some View {
        EmptyView()
    }
  
    static func getGeneralDetail(text: String) -> some View {
        Text(text).setCustomNavigationBackButton(title: "", image: "") {
        }.navigationTitle("Detail")
    }
    
}
