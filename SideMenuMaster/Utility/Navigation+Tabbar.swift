import SwiftUI

class AppTheme {
    static func navigationBarColors(background: UIColor?,
                                    titleColor: UIColor? = nil, tintColor: UIColor? = nil ) {
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .clear
        
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
        
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        
        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
        
    }
    
    static func tabbarColors(background: UIColor,
                             titleColorSelected: UIColor, titleColorUnSelected: UIColor ) {
        // Customize TabBar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = background
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: titleColorSelected], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: titleColorUnSelected], for: .normal)
    }
}
