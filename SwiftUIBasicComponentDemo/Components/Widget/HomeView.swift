//
//  HomeView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 30/12/2024.
//
import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: TabType
    var body: some View {
        VStack {
            Color.red.overlay {
                Button {
                    selectedTab = TabType.message
                } label: {
                    Text("Go to Message Page")
                        .padding()
                        .background()
                        .cornerRadius(10, antialiased: true)
                }
            }
        }
        .frame(width: .infinity, height: .infinity)
        .ignoresSafeArea(edges: .top)
        .tabItem {
            Text("首页")
            Image(systemName: "house.fill")
        }
        .tag(TabType.home)
    }
}
