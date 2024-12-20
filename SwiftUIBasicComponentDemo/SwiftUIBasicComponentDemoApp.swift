//
//  SwiftUIBasicComponentDemoApp.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 2024/12/10.
//

import SwiftUI

@main
struct SwiftUIBasicComponentDemoApp: App {
    @Environment(\.scenePhase) private var scenePhase  // 监听应用生命周期状态
     
    init() {
        debugPrint("App is init")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: setupNavigationBar) // 当应用的主视图首次显示时触发
                .onDisappear(perform: setupStatusBar)  // 当应用的主视图消失时触发
                .onChange(of: scenePhase) { oldPhase,newPhase in
                    switch newPhase {
                    case .active:
                        debugPrint("App is active")
                    case .inactive:
                        debugPrint("App is inactive")
                    case .background:
                        debugPrint("App is in the background")
                    @unknown default:
                        debugPrint("Unknown state")
                    }
                }
        }
    }
    
    private func setupNavigationBar() {
        
        if #available(iOS 13.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            navigationBarAppearance.shadowImage = UIImage() // 移除默认阴影
            navigationBarAppearance.shadowColor = nil       // 移除分隔线阴影颜色
            
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            
            UITableView.appearance().sectionHeaderTopPadding = 0
        } else {
            UINavigationBar.appearance().shadowImage = UIImage()    // 移除分隔线
        }
    }
    
    private func setupStatusBar() {
        
    }
}
