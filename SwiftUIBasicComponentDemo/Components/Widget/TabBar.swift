//
//  TabBarDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 10/01/2025.
//
import SwiftUI

struct TabBar: View {
    @Binding var currentSelected: Tab
    @Namespace var animationNamespace
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tabItem in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        currentSelected = tabItem
                    }
                } label: {
                    VStack {
                        Image(systemName: tabItem.icon)
                            .font(.system(size: 24))
                            .frame(height: 30)
                        Text(tabItem.text)
                            .font(.body.bold())
                    }
                    .foregroundColor(currentSelected == tabItem ? .pink : .secondary)
                    .frame(maxWidth: .infinity)
                    //新增背景过渡效果
                    .background(
                        ZStack{
                            if currentSelected == tabItem {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.pink.opacity(0.2))
                                    .matchedGeometryEffect(id: "background_rectangle", in: animationNamespace)
                            }
                        }
                    )
                }
                
            }
        }
        .padding(6)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 4)
        .padding(.horizontal)
        .frame(maxHeight:.infinity, alignment: .bottom)
    }
}
