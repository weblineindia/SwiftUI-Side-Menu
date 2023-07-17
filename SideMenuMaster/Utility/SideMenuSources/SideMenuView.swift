import SwiftUI

@available(iOS 14.0, *)
public struct WliSideMenuView<Content: View>: View {
    @Binding private var isMenuOpen: Bool
    public var tabs: [MenuTabModel]
    @Binding var selectedTab: MenuTabModel
    @Binding var contenViewtbgColor: Color
    public var bgImage: String = ""
    public var selectionColor: Color = Color.blue
    public var bgColor: Color = Color.primary
    public var blurRadius: CGFloat = 32
    public var enable3D: Bool = true
    public let content: Content
    
    public init(isMenuOpen: Binding<Bool>, tabs: [MenuTabModel], selectedTab: Binding<MenuTabModel>, contenViewtbgColor: Binding<Color>, bgImage: String = "", selectionColor: Color = Color.blue, blurRadius: CGFloat = 32, enable3D: Bool = true, bgColor: Color = Color.primary, @ViewBuilder content: () -> Content) {
        self.tabs = tabs
        self.blurRadius = blurRadius
        self.enable3D = enable3D
        self.selectionColor = selectionColor
        self.bgImage = bgImage
        _isMenuOpen = isMenuOpen
        _selectedTab = selectedTab
        self.content = content()
        _selectedTab = selectedTab
        _contenViewtbgColor = contenViewtbgColor
        self.bgColor = bgColor
    }
    
    public var body: some View {
        let topSpace = (window()?.safeAreaInsets.top ?? 0) + 15
        
        ZStack {
            menuBackgroundView
            ZStack {
                RoundedRectangle(cornerRadius: isMenuOpen ? 12 : 0)
                    .foregroundColor(contenViewtbgColor)
                    .shadow(color: .black.opacity(0.6), radius: isMenuOpen ? 14 : 0)
                
                content
                    .disabled(isMenuOpen)
                // .padding(.top,isMenuOpen ? 0: window()?.safeAreaInsets.top)
                
                    .padding(.top, topSpace)
                    .padding(.bottom, isMenuOpen ? 0: window()?.safeAreaInsets.bottom)
            }
            
            .offset(x: isMenuOpen ? (window()?.bounds.width ?? UIScreen.main.bounds.width) * 0.5 : 0)
            // .scaleEffect(isMenuOpen ? 0.8 : 1)
            .scaleEffect(isMenuOpen ? 1 : 1)
            .rotation3DEffect(.degrees(isMenuOpen && enable3D ? -32:0), axis: (x: 0, y: 1, z: 0))
            // .animation(.linear(duration: 0.24), value: isMenuOpen)
            // .ignoresSafeArea(edges: isMenuOpen ? []:[.all])
            
            .animation(.spring(), value: isMenuOpen)
            .ignoresSafeArea(edges: isMenuOpen ? [.all]:[.all])
            
            .onTapGesture {
                if isMenuOpen {
                    isMenuOpen.toggle()
                }
            }
        }
    }
    
    public var menuBackgroundView: some View {
        ZStack(alignment: .init(horizontal: .leading, vertical: .center)) {
            if let bgimg = UIImage(named: bgImage) {
                bgColor.ignoresSafeArea().overlay(
                    Image(uiImage: bgimg).scaledToFill().ignoresSafeArea().blur(radius: blurRadius)
                )
            } else {
                bgColor.ignoresSafeArea().overlay {
                    EmptyView()
                }
            }
            
            /// Side menu list ContentView
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(tabs) { tab in
                        HStack {
                            Image(systemName: tab.imageName)
                            Text(tab.title)
                        }.font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .padding(.horizontal, 4)
                            .background(
                                selectedTab.title == tab.title ? Capsule(style: .circular).fill(selectionColor) : Capsule(style: .circular).fill(Color.clear)
                                
                            ).onTapGesture {
                                selectedTab = tab
                                closeMenuWithDly()
                            }
                            .animation(.linear(duration: 0.24), value: selectedTab)
                    }
                }.padding()
            }
        }
        
    }
    
    func closeMenuWithDly() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            isMenuOpen.toggle()
        })
    }
    func window() -> UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            return nil
        }
        return window
    }
}

public struct MenuTabModel: Identifiable, Equatable {
    
    public var id: UUID = UUID()
    public var title: String
    public var imageName: String
    public init(id: UUID = UUID(), title: String, imageName: String) {
        self.id = id
        self.title = title
        self.imageName = imageName
    }
}
