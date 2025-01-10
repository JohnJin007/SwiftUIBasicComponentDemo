//
//  KeyboardAwareDemoView2.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 17/12/2024.
//

import SwiftUI

struct Message: Identifiable, Hashable {
    let id = UUID()
    let text: String
}

@available(iOS 15.0, *)
struct KeyboardAwareDemoView2: View {
    @State private var text = ""
    @State var messages: [Message] = (0...60).map{ Message(text: "message:\($0)")}
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                List {
                    ForEach(messages) { message in
                        TextField(text: self.$text) {
                            Text(message.text)
                                .id(message.id)
                        }
                    }
                }
                .listStyle(.inset)
                .safeAreaInset(edge: .bottom) {
                    SendEdge(messages: $messages)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private struct SendEdge: View {
        @Binding var messages: [Message]
        @State private var text = ""
        @FocusState var focused: Bool
        var body: some View {
            ZStack(alignment: .top) {
                Color.clear
                Rectangle()
                    .fill(.secondary)
                    .opacity(0.3)
                    .frame(height: 0.6)
                HStack(alignment: .firstTextBaseline) {
                    TextField("", text: $text)
                        .focused($focused)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                        .onSubmit {
                            debugPrint("commited")
                            messages.append(Message(text: text))
                        }
                        .onChange(of: focused) { oldValue, newValue in
                            
                        }
                    Button("回复") {
                        focused = false
                        messages.append(Message(text: text))
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                    .tint(.green)
                }
                .padding(.horizontal, 30)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 53)
            .background(.regularMaterial)
        }
    }
}
