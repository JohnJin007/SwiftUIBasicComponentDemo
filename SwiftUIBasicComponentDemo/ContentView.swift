//
//  ContentView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 2024/12/10.
//

import SwiftUI

struct ContentView: View {
    // 示例条目控件
    private func sampleItemView(view: any View, name: String) -> some View {
        NavigationLink(destination: {
            AnyView(view)
        }, label: {
            HStack {
                Spacer()
                Text(name).font(.system(size: 18))
                Spacer()
            }.frame(height: 100)
                .background(Rectangle().fill(.gray.opacity(0.3)))
                .cornerRadius(5, antialiased: true)
        })
    }
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(SampleData.getSamples()) { group in
                    HStack(spacing: 10) {
                        ForEach(group.items) { item in
                            sampleItemView(view: item.destination, name: item.name)
                        }
                    }
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 15)
            }
            .navigationBarTitle("SwiftBasicComponent", displayMode: .inline)
            .onReceive(NotificationCenter.Publisher(
                center: NotificationCenter.default,
                name: NSNotification.Name(Events.Sample_Notification_Name)
            ), perform: { out in
                debugPrint("RECEIVED NOTIFICATION WITH \(String(describing: out.object))")
            })
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
