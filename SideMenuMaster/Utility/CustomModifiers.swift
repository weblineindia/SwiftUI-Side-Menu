import Foundation
import SwiftUI

struct NavigationBarStyle: ViewModifier {
    var title: String = ""
    var displayMode: NavigationBarItem.TitleDisplayMode
    
    @ViewBuilder func body(content: Content) -> some View {
        
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode( displayMode)
        
    }
}

struct NavigationCustomBackButton: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    var backAction: (() -> Void)?
    var buttonTitle = ""
    var buttonImage = ""
    
    @ViewBuilder func body(content: Content) -> some View {
        
        content
            .navigationBarBackButtonHidden(true)
        
        // Add your custom back button here
        
            .toolbar {
                
                ToolbarItemGroup(placement: .navigationBarLeading, content: {
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                        
                        if let action = backAction {
                            action()
                        }
                    }) {
                        HStack {
                            if buttonImage.count > 0 {
                                Image(buttonImage)
                            } else {
                                Image(systemName: "arrow.left")
                            }
                            
                            Text(buttonTitle.count > 0 ? buttonTitle : "")
                        }
                    }.tint(.white)
                })
            }
        
    }
}

extension View {
    func navigationMode(title: String = "", displayMode: NavigationBarItem.TitleDisplayMode = .automatic) -> some View {
        self.modifier(NavigationBarStyle(title: title, displayMode: displayMode))
    }
    
    func setCustomNavigationBackButton(title: String, image: String, action: @escaping () -> Void) -> some View {
        self.modifier(NavigationCustomBackButton(backAction: action, buttonTitle: title, buttonImage: image))
    }
}

struct AppButtonView: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
        }
    }
}
