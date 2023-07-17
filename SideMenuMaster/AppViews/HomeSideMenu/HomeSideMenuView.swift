import SwiftUI

struct HomeSideMenuView: View {
    @State var isMenuOpen: Bool = false
    let tabs = [MenuTabModel(title: "Home", imageName: "house"), MenuTabModel( title: "Settings", imageName: "gear")]
    @State var selectedTab: MenuTabModel = MenuTabModel(title: "Home", imageName: "house")
    @State var contentbgColor = Color.white
    @StateObject var viewModel: HomeSideMenuViewModel
    
    var body: some View {
        content()
            .navigationBarBackButtonHidden()
    }
    @ViewBuilder private func content() -> some View {
        ZStack {
            WliSideMenuView(
                isMenuOpen: $isMenuOpen,
                tabs: tabs, // add your [MenuTabModel]
                selectedTab: $selectedTab, //initial selectedTab
                contenViewtbgColor: $contentbgColor,     //acces view placeholder background
                bgImage: "",     //add your background image!
                selectionColor: .yellow,
                blurRadius: 32,            // add blur radius for image default value is 32
                enable3D: false, //enable/disable 3D effect
                bgColor: .white  // set bg color of side menu
            ) {
                if selectedTab.title == "Home" {
                    SMHomeView(isMenuOpen: $isMenuOpen, backColor: $contentbgColor, viewModel: viewModel)
                } else if selectedTab.title == "Settings" {
                    SMSettingView(isMenuOpen: $isMenuOpen, backColor: $contentbgColor, viewModel: viewModel)
                }
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeSideMenuView(viewModel: HomeSideMenuViewModel())
//    }
//}

struct SMHomeView: View {
    @Binding var isMenuOpen: Bool
    @Binding var backColor: Color
    @StateObject var viewModel: HomeSideMenuViewModel
    let holidays = ["New Year's Day", "Valentine's Day", "Easter", "Christmas"]
    
    var body: some View {
        ZStack {//Your content is here
            backColor.ignoresSafeArea().cornerRadius(isMenuOpen ? 12:0)
            VStack {
                HStack {
                    Button(action: { isMenuOpen.toggle() }) {
                        Image(systemName: "line.3.horizontal").font(.title).foregroundColor(.black)
                    }.padding(.top, 0).padding(.leading, 12).frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }.background(Color.white)
                VStack(alignment: .leading) {
                    ScrollView {
                            ForEach(holidays, id: \.self) { holiday in
                                Text(holiday).foregroundColor(.black).padding()
                                Divider()
                            }
                    }
                }
            }
        }.onAppear {
            backColor = .white
        }
    }
}

struct SMSettingView: View {
    @EnvironmentObject var coordinator: BaseCoordinator
    @Binding var isMenuOpen: Bool
    @Binding var backColor: Color
    @StateObject var viewModel: HomeSideMenuViewModel
    
    @State var showLogoutAlert: Bool = false
    @State private var showSheet = false
    @State private var showCameraSheet = false
    @State private var image: UIImage = UIImage(systemName: "camera.circle.fill")!
    
    var body: some View {
        ZStack {//Your content is here
            backColor.ignoresSafeArea().cornerRadius(isMenuOpen ? 12:0)
            
            VStack {
                HStack {
                    
                    Button(action: { isMenuOpen.toggle() }) {
                        Image(systemName: "line.3.horizontal").font(.title).foregroundColor(.black)
                        
                    }.padding(.top, 0).padding(.leading, 12).frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }.background(Color.white)
                
                VStack {
                    ScrollView {
                        Spacer(minLength: 100)
                        VStack {
                            Group {
                                AppButtonView(title: "Logout") {
                                    showLogoutAlert = true
                                }
                            }
                        }.padding()
                    }
                }
            }
            
        }.onAppear {
            backColor = .white
        }.alert(isPresented: $showLogoutAlert) {
            Alert(
                title: Text("Logout!!"),
                message: Text("Are you sure you want logout?"),
                primaryButton: .destructive(Text("Logout")) {
                    withTransaction(.init(animation: .default)) {
                        logout()
                    }
                    
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    func logout() {
        UserDefaults.standard.set("", forKey: "UserName")
        UserDefaults.standard.set(false, forKey: "isLogin")
        UserDefaults.standard.synchronize()
        coordinator.initiateLogin()
    }
}
