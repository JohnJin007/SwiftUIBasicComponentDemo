//
//  TabBarDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 10/01/2025.
//
import SwiftUI

struct TabBarDemoView: View {
    @State private var currentSelected: Tab = .home
    
    var body: some View {
        VStack {
            switch currentSelected {
            case .home:
                Home(title: "首页")
            case .location:
                My(title: "地址")
            case .collect:
                Home(title: "收藏")
            case .mine:
                My(title: "我的")
            }
            
            TabBar(currentSelected: $currentSelected)
        }
    }
}
