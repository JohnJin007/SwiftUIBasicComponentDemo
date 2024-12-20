//
//  CustomPreferenceKey.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 17/12/2024.
//
import SwiftUI

struct CustomPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = CGPoint()
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

extension View {
    func customPreference(_ value: CGPoint) -> some View {
        self.preference(key: CustomPreferenceKey.self, value: value)
    }
}
