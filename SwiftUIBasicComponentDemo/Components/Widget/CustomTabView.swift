//
//  CustomTabView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 30/12/2024.
//
import SwiftUI

struct CustomTabView: View {
    @StateObject var viewRouter: ViewRouter
    var body: some View {
        GeometryReader { geometry in
            VStack {
                switch viewRouter.currentPage {
                case .home:
                    Home(title: "")
                case .my:
                    My(title: "")
                }
                Spacer()
                ZStack {
                    HStack {
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/5, height: geometry.size.height/32, systemIconName: "chart.pie.fill", tabName: "首页")
                            .frame(maxWidth: .infinity)
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .my, width: geometry.size.width/5, height: geometry.size.height/32, systemIconName: "person.crop.circle.fill", tabName: "我的")
                            .frame(maxWidth: .infinity)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/9)
                    .background(.yellow)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}
