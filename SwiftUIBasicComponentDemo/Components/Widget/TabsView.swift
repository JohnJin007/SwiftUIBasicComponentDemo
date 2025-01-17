//
//  TabsView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 13/01/2025.
//
import SwiftUI

struct TabItem: Identifiable {
    var id: Int
    var text: String
}

struct tabs: View {
    let list: [TabItem]
    @Binding var currentSelect: Int
    @Namespace var animationNamespace
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(list) { tabItem in
                        Button {
                            withAnimation {
                                currentSelect = tabItem.id
                            }
                        } label: {
                            HStack {
                                Spacer()
                                Text(tabItem.text)
                                    .padding(EdgeInsets(top: 8, leading: 12, bottom: 10, trailing: 12))
                                    .fixedSize()
                                    .foregroundColor(currentSelect == tabItem.id ? Color.Hex(0x1677ff) : Color.Hex(0x333))
                                    .font(.system(size: currentSelect == tabItem.id ? 20 : 17))
                                    .fontWeight(currentSelect == tabItem.id ? .bold : .regular)
                                    .animation(nil, value: UUID())
                                Spacer()
                            }
                            .background {
                                VStack() {
                                    if(currentSelect == tabItem.id) {
                                        Spacer()
                                        Rectangle()
                                            .fill(Color.Hex(0x1677ff))
                                            .frame(height: 2)
                                            .padding(.horizontal, 12)
                                            .cornerRadius(2)
                                            .matchedGeometryEffect(id: "tab_line", in: animationNamespace)
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(minWidth: UIScreen.main.bounds.width)
            }
            .onChange(of: currentSelect) { oldValue, newValue in
                withAnimation(.easeInOut) {
                    scrollProxy.scrollTo(currentSelect, anchor: .center)
                }
            }
        }
    }
}
