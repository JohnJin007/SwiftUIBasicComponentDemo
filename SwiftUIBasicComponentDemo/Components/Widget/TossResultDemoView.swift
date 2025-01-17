//
//  TossResultDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 16/01/2025.
//
import SwiftUI

struct TossResultDemoView: View {
    let colors: [Color] = [.red, .green, .blue]
    @State private var maxHeight: CGFloat = 0
    
    var tossResult1: some View {
        //将输出包装在一个组中
        Group {
            if Bool.random() {
                Image(systemName: "dog")
                    .font(.largeTitle)
            } else {
                Text("Better luck next time")
                    .font(.title)
            }
        }
        .frame(width: 400, height: 300)
    }
    
    var tossResult2: some View {
        if Bool.random() {
            return AnyView(Image(systemName: "dog"))
        } else {
            return AnyView(Text("Better luck next time").font(.title))
        }
    }
    
    @ViewBuilder var tossResult3: some View {
        if Bool.random() {
            Image(systemName: "dog")
                .font(.largeTitle)
        } else {
            Text("Better luck next time")
                .font(.title)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Coin Flip")
                    .font(.largeTitle)
                
                tossResult1
                tossResult2
                tossResult3
                TossResult()
                    .frame(width: 400, height: 300)
                
                ForEach((1...10).reversed(), id: \.self) {
                    Text("\($0)...")
                }
                
                Text("Ready or not, here I come!")
                
                ForEach(colors, id: \.self) { color in
                    Text(color.description.capitalized)
                        .padding()
                        .background(color)
                }
                
                //设置相同高度.frame和fixedSize
                HStack {
                    Text("This is a short string.")
                        .padding()
                        .frame(maxHeight: .infinity)
                        .background(.red)
                    
                    Text("This is a very long string with lots and lots of text that will definitely run accross multiple lines because it's just so long.")
                        .padding()
                        .frame(maxHeight: .infinity)
                        .background(.green)
                }
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxHeight: 200)
                
                //设置相同宽度
                VStack {
                    Button("Log in") {
                        
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.red)
                    .clipShape(Capsule())
                    
                    Button("Reset Password") {
                        
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.red)
                    .clipShape(Capsule())
                }
                .fixedSize(horizontal: true, vertical: false)
                
                Spacer()
                    .frame(height: 20)
                
                //设置相同高度
                HStack {
                    Text("Short text")
                        .background(GeometryReader(content: { geometry in
                            Color.red.preference(key: HeightPreferenceKey.self, value: geometry.size.height)
                        })
                        )
                        .frame(height: maxHeight)
                    
                    Text("This is a longer text that might wrap onto multiple lines.")
                        .background(GeometryReader(content: { geometry in
                            Color.green.preference(key: HeightPreferenceKey.self, value: geometry.size.height)
                        })
                        )
                        .frame(height: maxHeight)
                }
            }
        }
    }
}

struct TossResult: View {
    var body: some View {
        if Bool.random() {
            Image(systemName: "dog")
                .font(.largeTitle)
        } else {
            Text("Better luck next time")
                .font(.title)
        }
    }
}

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
