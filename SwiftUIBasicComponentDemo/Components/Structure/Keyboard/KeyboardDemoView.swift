//
//  KeyboardDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 06/01/2025.
//
import SwiftUI

struct KeyboardDemoView: View {
    var body: some View {
        VStack {
            NavigationLink {
                KeyboardAwareDemoView()
            } label: {
                Text("Keyboard Aware Demo 1")
            }
            .frame(height: 40)
            
            NavigationLink {
                if #available(iOS 15.0, *) {
                    KeyboardAwareDemoView2()
                } else {
                    Text("Only available on 15.0 and newer")
                }
            } label: {
                Text("Keyboard Aware Demo 2")
            }
            .frame(height: 40)

            
            NavigationLink {
                KeyboardAwareDemo3()
            } label: {
                Text("Keyboard Aware Demo 3")
            }
            .frame(height: 40)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
