import Foundation
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var coordinator: BaseCoordinator
    @StateObject var viewModel: LoginViewModel
    @State var userName = ""
    @State var istrue = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    Spacer()
                    Text("Login").font(.largeTitle).foregroundColor(.yellow)
                    Spacer()
                }
                TextField("UserName", text: $userName).padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                Spacer()
                HStack {
                    Spacer()
                    AppButtonView(title: "Login") {
                        login()
                    }
                    Spacer()
                }
            }
            .padding(.horizontal)
            
        }.toolbar(.hidden, for: .navigationBar).navigationMode(displayMode: .inline)
        
    }
    
    @ViewBuilder private func content() -> some View {
        
    }
   
    func login() {
        coordinator.initiateHome()
    }
}

//struct LogingPreview: PreviewProvider {
//    static var previews: some View {
//      //  LoginView(viewModel: LoginViewModel)
//    }
//}
