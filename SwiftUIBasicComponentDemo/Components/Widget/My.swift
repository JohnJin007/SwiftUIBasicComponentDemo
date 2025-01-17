//
//  My.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 30/12/2024.
//
import SwiftUI

struct My: View {
    @State var title: String
    
    var body: some View {
        VStack {
            Text(title)
            
            //组合形状创建新形状
            Circle()
                .union(.capsule.inset(by: 100))
                .fill(.red)
                .frame(width: 150, height: 150)
        }
    }
}
