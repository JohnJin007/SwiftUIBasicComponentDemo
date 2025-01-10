//
//  KeyboardAwareDemo3.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 07/01/2025.
//
import SwiftUI

struct KeyboardAwareDemo3: View {
    @State private var text = ""
    @State var messages:[Message] = (0...60).map{ Message(text: "message:\($0)")}
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(messages) { message in
                    TextField(message.text, text: self.$text)
                }
            }
            SendEdge()
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private struct SendEdge: View, KeyboardReadable {
        @State private var text = ""
        @State private var showEmoij = false
        @State private var keyboardShowing: Bool = false
        @State private var keyboardHeightValue: CGFloat = 0
        @State private var keyboardHiden: Bool = true
        
        
        var body: some View {
            VStack {
                Divider()
                HStack {
                    Button("Emoij") {
                        hideKeyboard()
                        self.showEmoij = !self.showEmoij
                    }
                    .frame(height: 35)
                    TextEditor(text: $text)
                        .cornerRadius(4)
                        .border(.gray)
                        .frame(minHeight: 50, maxHeight: keyboardShowing ? 150 : 50)
                    Button("Send") {
                        hideKeyboard()
                    }
                    .frame(height: 35)
                }
                if !keyboardHiden {
                    VStack {
                        Text("Emoij Container")
                    }
                    .frame(height: keyboardHeightValue)
                }
            }
            .onReceive(keyboardHeight) { height in
                keyboardHeightValue = height
            }
            .onReceive(keyboardDidChangePublisher) { show in
                keyboardHiden = !show
            }
            .onReceive(keyboardWillChangePublisher) { show in
                keyboardShowing = show
            }
        }
    }
}
