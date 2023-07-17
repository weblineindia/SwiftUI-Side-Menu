import Foundation
import SwiftUI

/// Base cooridnator class with default method
final class BaseCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var presentSheetItem: DestinationFlowPage?
    @Published var fullCoverItem: DestinationFlowPage?
    
    func gotoRoot() {
        path.removeLast(path.count)
    }
    func gotoGeneralDetail(text: String) {
        path.append(DestinationFlowPage.generalDetail(text: text))
    }
    
    func initiateLogin() {
        path.append(DestinationFlowPage.login)
    }
    func initiateHome() {
        path.append(DestinationFlowPage.home)
    }
    
}

/// screens protocol define as per navigation required
protocol LoginNavigator {
    func loginActionHome()
}

/// Extended Base coordinator class with screen added required navigation
extension BaseCoordinator: LoginNavigator {
    func loginActionHome() {
        path.append(DestinationFlowPage.home)
    }
}

/// Define enum to identify individualy navigation trigger point
enum DestinationFlowPage: Hashable, Identifiable {
    static func == (lhs: DestinationFlowPage, rhs: DestinationFlowPage) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    case login
    case home
    case generalDetail(text: String)
    
    var id: String {
        String(describing: self)
    }
    
    func hash(into hasher: inout Hasher) {
        // Hashing logic based on the enum case
        switch self {
        case .home:
            hasher.combine("home")
        case .login:
            hasher.combine("login")
        case .generalDetail(_):
            hasher.combine("generalDetail")
        }
    }
    
}

protocol AnyDataModel {
    var data: Any? { get set }
    var index: Int? { get set }
    var id: String? { get set }
}
