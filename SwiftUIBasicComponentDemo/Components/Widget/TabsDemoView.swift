//
//  TabsDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 13/01/2025.
//
import SwiftUI

struct TabsDemoView: View {
    
    let list = [
        TabItem(id: 1, text: "关注"),
        TabItem(id: 2, text: "推荐"),
        TabItem(id: 3, text: "热榜"),
        TabItem(id: 4, text: "头条精选"),
        TabItem(id: 5, text: "后端"),
        TabItem(id: 6, text: "前端")
    ]
    
    @State var currentSelect: Int = 1
    
    var body: some View {
        VStack(spacing: 0) {
            tabs(list: list, currentSelect: $currentSelect)
            TabView(selection: $currentSelect) {
                ForEach(list) { tabItem in
                    Text(tabItem.text)
                        .tag(tabItem.id)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

