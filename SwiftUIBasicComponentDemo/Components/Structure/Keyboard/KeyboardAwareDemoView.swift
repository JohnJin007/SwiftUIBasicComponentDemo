//
//  KeyboardAwareDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 07/01/2025.
//
import SwiftUI

struct KeyboardAwareDemoView: View {
    
    @State var messages: [Message] = (0...60).map{ Message(text: "message: \($0)") }
    @State private var text = ""
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                List {
                    ForEach(messages) { message in
                        TextField(message.text, text: self.$text)
                    }
                    if #available(iOS 15.0, *) {
                        SendAbove15(proxy: proxy)
                    } else {
                        Send(proxy: proxy)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @available(iOS 15.0, *)
    private struct SendAbove15: View {
        @State private var keyboardHeight: CGFloat = 0.0
        @State private var showCalendar: Bool = false
        @State private var text: String = ""
        @FocusState var keyboardFocused: Bool
        
        let proxy: GeometryProxy
        
        
        var body: some View {
            VStack(spacing: 0) {
                Divider()
                ZStack {
                    VStack {
                        HStack(spacing: 12) {
                            Image(systemName: "calendar.circle")
                                .onTapGesture {
                                    keyboardHeight = proxy.safeAreaInsets.bottom
                                    showCalendar = true
                            }
                            TextEditor(text: $text)
                                .cornerRadius(4)
                                .focused($keyboardFocused)
                                .border(.gray)
                            Image(systemName: "tray.circle")
                            Image(systemName: "paperplane")
                                .onTapGesture {
                                    keyboardFocused = false
                                }
                        }
                        .padding(.horizontal, 12)
                        .frame(height: keyboardFocused ? 100: 56)
                        Text("Calendar Container")
                            .frame(height: showCalendar && !keyboardFocused ? keyboardHeight : 0)
                    }
                }
            }
        }
    }
    
    private struct Send: View, EventReceiver {
        @State private var text: String = ""
        @State private var keyboardFocused: Bool = false
        private let keboardEventReceiver = KeboardEventReceiver()
        
        let proxy: GeometryProxy
        
        var body: some View {
            VStack(spacing: 0) {
                Divider()
                ZStack {
                    VStack {
                        HStack(spacing: 12) {
                            Image(systemName: "calendar.circle")
                                .onTapGesture {
                                    
                                }
                            TextEditor(text: $text)
                                .cornerRadius(4)
                                .border(.gray)
                            Image(systemName: "tray.circle")
                            Image(systemName: "paperplane")
                                .onTapGesture {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        }
                        .padding(.horizontal, 12)
                        .frame(height: keyboardFocused ? 100 : 56)
                    }
                }
            }
            .onAppear {
                keboardEventReceiver.registerReceiver(receiver: self)
                keboardEventReceiver.registerForKeyboardNotifications()
            }
            .onDisappear {
                keboardEventReceiver.unRegisterForKeyboardNotifications()
            }
        }
        
        func onReceive(hide: Bool) {
            self.keyboardFocused = !hide
        }
    }
}

protocol EventReceiver {
    func onReceive(hide: Bool)
}

class KeboardEventReceiver {
    private var receivers: [EventReceiver] = []
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unRegisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func registerReceiver(receiver: EventReceiver) {
        receivers.append(receiver)
    }
    
    @objc func keyboardWillShown(_ notificiation: NSNotification) {
        debugPrint("keyboard shown")
        receivers.forEach { receiver in
            receiver.onReceive(hide: false)
        }
    }
    
    @objc func keyboardWillBeHidden(_ notificiation: NSNotification) {
        debugPrint("keyboard hidden")
        receivers.forEach { receiver in
            receiver.onReceive(hide: true)
        }
    }
}
