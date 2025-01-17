//
//  TabsDemoView2.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 13/01/2025.
//
import SwiftUI

struct TabsDemoView2: View {
    let list = [
        TabItem(id: 1, text: "关注"),
        TabItem(id: 2, text: "推荐"),
        TabItem(id: 3, text: "热榜")
    ]
    
    @State var currentSelect: Int = 1
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                    Section(
                        header: tabs(list: list, currentSelect: $currentSelect)
                            .background(.white)
                    ){
                        TabView(selection: $currentSelect) {
                            ForEach(list) { tabItem in
                                VStack {
                                    switch currentSelect {
                                    case 1:
                                        Home(title: tabItem.text)
                                    case 2:
                                        My(title: tabItem.text)
                                    case 3:
                                        Home(title: tabItem.text)
                                    default:
                                        Text("")
                                    }
                                }
                                .tag(tabItem.id)
                                .refreshable {
                                    print("触发刷新")
                                }
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(minHeight: proxy.size.height)
                    }

                }
            }
        }
    }
}
