//
//  HideKeyboard.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 30/12/2024.
//  隐藏虚拟键盘
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil)
    }
}
