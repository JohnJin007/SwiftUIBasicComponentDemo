//
//  TabPgeDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 02/01/2025.
//
import SwiftUI

struct TabPgeDemoView: View {
    @State var selection: Int = 0
    
    var body: some View {
        VStack {
            VStack {
                Picker(selection: $selection) {
                    ForEach(0..<3) { idx in
                        Text("标签\(idx)")
                    }
                } label: {
                    Text("")
                }
                .pickerStyle(SegmentedPickerStyle())
                Picker(selection: $selection) {
                    ForEach(0..<3) { idx in
                        SimpleTab(image: "trash", text: "标签 \(idx)")
                    }
                } label: {
                    Text("")
                }
                .pickerStyle(InlinePickerStyle())
            }
            contentView
        }
        .padding(15)
        .navigationBarTitle("TAB示例", displayMode: .inline)
    }
    
    struct SimpleTab: View {
        let image: String
        let text: String
        
        var body: some View {
            HStack {
                Image(systemName: image)
                    .font(.system(size: 14))
                Text(text)
                    .font(.system(size: 14))
            }
        }
    }
    
    private var contentView: some View {
        switch selection {
        case 0:
            return AnyView(
                ZStack {
                    Color.red.opacity(0.1).ignoresSafeArea(.all)
                    VStack(alignment: .trailing) {
                        Spacer()
                        Text("页面1")
                        Spacer()
                    }
                }
            )
        case 1:
            return AnyView(
                ZStack {
                    Color.green.opacity(0.1).ignoresSafeArea(.all)
                    VStack(alignment: .trailing) {
                        Spacer()
                        Text("页面2")
                        Spacer()
                    }
                }
            )
        case 2:
            return AnyView(
                ZStack {
                    Color.blue.opacity(0.1).ignoresSafeArea(.all)
                    VStack(alignment: .trailing) {
                        Spacer()
                        Text("页面3")
                        Spacer()
                    }
                }
            )
        default:
            return AnyView(
                VStack(content: {
                    Form {
                        Text("Default")
                    }
                })
            )
        }
    }
}
