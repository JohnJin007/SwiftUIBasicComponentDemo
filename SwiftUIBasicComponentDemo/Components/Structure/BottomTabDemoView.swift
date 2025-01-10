//
//  BottomTabDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 02/01/2025.
//
import SwiftUI

struct BottomTabDemoView: View {
    @State var selection: Int = 0
    @State var tip: String = "0"
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                ForEach(0..<5) { idx in
                    VStack {
                        getTabView(idx: idx)
                    }
                    .tabItem {
                        VStack {
                            Text("Tab \(idx+1)")
                            Image(systemName: "trash")
                        }
                    }
                }
            }
        }
        .navigationBarHidden(selection == 4)
        .navigationBarTitle("顶部导航栏示例\(selection + 1)", displayMode: .inline)
        .navigationBarItems(trailing: trailingView)
        .statusBar(hidden: selection == 4) // hide status bar
    }
    
    private func getTabView(idx: Int) -> some View {
        return VStack {
            if idx == 0 {
                SlidePageView(tip: $tip)
            } else if idx == 1 {
                SlidePageViewWithCustomIndicator()
            } else {
                NormalPageView(idx: idx)
            }
        }
    }
    
    private var trailingView: some View {
        switch selection {
        case 0:
            return AnyView(Image(systemName: "plus.circle"))
        case 1:
            return AnyView(Image(systemName: "person.badge.plus"))
        default:
            return AnyView(EmptyView())
        }
    }
}

struct SlidePageView: View {
    
    @State var selection: Int = 0
    private let colors:[Color] = [.red.opacity(0.1), .green.opacity(0.1), .blue.opacity(0.1), .orange.opacity(0.1), .yellow.opacity(0.1), .pink.opacity(0.1), .purple.opacity(0.1), .black.opacity(0.1)]
    @Binding var tip: String
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(0..<8) { idx in
                VStack(spacing: 15) {
                    Spacer()
                    Text(tip)
                    HStack {
                        Spacer()
                        Text("可滑动页面[\(idx)]")
                        Spacer()
                    }
                    Button("跳转到下一个页面") {
                        let next = self.selection + 1
                        if next >= 8 {
                            self.selection = 0
                        } else {
                            self.selection = next
                        }
                        tip = "\(selection)"
                    }
                    Spacer()
                }
                .background(colors[idx])
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

struct SlidePageViewWithCustomIndicator: View {
    private let colors: [Color] = [.red.opacity(0.1), .green.opacity(0.1), .blue.opacity(0.1), .orange.opacity(0.1), .yellow.opacity(0.1), .pink.opacity(0.1), .purple.opacity(0.1), .black.opacity(0.1)]
    @State var selection: Int = 0
    
    private var customIndicatorView: some View {
        HStack(spacing: 8) {
            ForEach(0..<8) { idx in
                Rectangle()
                    .fill(.red.opacity(selection == idx ? 1 : 0.5))
                    .frame(width: 8, height: 4, alignment: .center)
                    .cornerRadius(6)
            }
        }
        .padding(.bottom, 20)
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(0..<8) { idx in
                VStack(spacing: 15) {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("可滑动页面[\(idx)]")
                        Spacer()
                    }
                    Button("跳转到下一个页面") {
                        let next = self.selection + 1
                        if next >= 8 {
                            self.selection = 0
                        } else {
                            self.selection = next
                        }
                    }
                    Spacer()
                }
                .background(colors[idx])
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .overlay(customIndicatorView, alignment: .bottom)
    }
}

struct NormalPageView: View {
    
    let idx: Int
    private let colors: [Color] = [.red.opacity(0.1), .green.opacity(0.1), .blue.opacity(0.1), .orange.opacity(0.1), .yellow.opacity(0.1)]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("TAB页面[\(idx + 1)]")
                Spacer()
            }
            Spacer()
        }
        .background(colors[idx])
    }
}
