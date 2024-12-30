//
//  TabDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 30/12/2024.
//
import SwiftUI

enum TabType: Int, Hashable {
    case home
    case videos
    case message
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .videos:
            return "Videos"
        case .message:
            return "Message"
        }
    }
    
    var image: String {
        switch self {
        case .home:
            return "house.fill"
        case .videos:
            return "video.fill"
        case .message:
            return "message.fill"
            
        }
    }
}

struct TabDemoView: View {
    @State private var selectedTab: TabType = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    Text(TabType.home.title)
                    Image(systemName: TabType.home.image)
                }
                .tag(TabType.home)
            
            Color(.blue)
                .ignoresSafeArea(edges: .top)
                .tabItem {
                    Text("消息")
                    Image(systemName: "message.fill")
                }
                .tag(TabType.message)
            
            Color(.purple)
                .ignoresSafeArea()
                .tabItem {
                    Text("视频")
                    Image(systemName: "video.fill")
                }
                .tag(TabType.videos)
                .badge(10)
        }
        .tint(Color.red)
//        .onAppear {
//            UITabBar.appearance().unselectedItemTintColor = .systemBrown
//            UITabBar.appearance().selectedItem?.badgeColor = .green
//            UITabBar.appearance().backgroundColor = .yellow
//            UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
//            UITabBarItem.appearance().setBadgeTextAttributes([.foregroundColor : UIColor.red, .font: UIFont.boldSystemFont(ofSize: 14)], for: .normal)
//            UITabBarItem.appearance().setBadgeTextAttributes([.foregroundColor: UIColor.blue], for: .selected)
//        }
    }
}
