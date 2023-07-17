import SwiftUI
@main
struct AppContentView: App {
    @Environment(\.scenePhase)var scenePhase
    @ObservedObject var coordinator = BaseCoordinator()
    
    init() {
        AppTheme.navigationBarColors(background: .purple, titleColor: .white, tintColor: .white)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                ZStack {
                    appContent()
                        .sheet(item: $coordinator.presentSheetItem) { present in
                            ViewFactory.viewForDestination(present)
                        }
                        .fullScreenCover(item: $coordinator.fullCoverItem) { present in
                            ViewFactory.viewForDestination(present)
                        }
                    
                }
                .navigationDestination(for: DestinationFlowPage.self) { destination in
                    ViewFactory.viewForDestination(destination)
                }
            }
            .environmentObject(coordinator)
        }
        
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .active {
                print("Active")
            } else if newPhase == .background {
                print("Background")
            }
        }
    }
    
    @ViewBuilder func appContent() -> some View {
        ViewFactory.getLoginView()
    }
}
