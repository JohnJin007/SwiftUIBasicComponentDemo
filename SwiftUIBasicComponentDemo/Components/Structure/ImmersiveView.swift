//
//  ImmersiveView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 06/01/2025.
//
import SwiftUI

struct ImmersiveView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Color.green.opacity(0.5).ignoresSafeArea(.all)
            ScrollView {
                VStack(alignment: .center, spacing: 15) {
                    Text("这是一个全屏页面")
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("退出")
                    }
                }
                .padding(.top, UIScreen.main.bounds.height / 2)
            }
            .background(Color.red)
        }
        .navigationBarHidden(true)
    }
}
