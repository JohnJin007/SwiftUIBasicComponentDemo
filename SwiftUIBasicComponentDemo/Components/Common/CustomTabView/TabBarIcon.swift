//
//  TabBarIcon.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 30/12/2024.
//
import SwiftUI

struct TabBarIcon: View {
    @StateObject var viewRouter: ViewRouter
    
    let assignedPage: Page
    
    let width, height: CGFloat
    
    let systemIconName, tabName: String
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
            Text(tabName)
                .font(.footnote)
                .font(.system(size: 16))
            Spacer()
        }
        .padding(.horizontal, -2)
        .padding(.vertical, 3)
        .onTapGesture {
            viewRouter.currentPage = assignedPage
        }
        .foregroundColor(viewRouter.currentPage == assignedPage ? .blue : .gray)
    }
}
