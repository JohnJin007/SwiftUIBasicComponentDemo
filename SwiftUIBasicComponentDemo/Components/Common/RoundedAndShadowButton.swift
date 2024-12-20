//
//  RoundedAndShadowButton.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 19/12/2024.
//
import SwiftUI

struct RoundedAndShadowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.blue)
            )
            .compositingGroup()
            .shadow(radius: configuration.isPressed ? 0 : 5, x: 0, y: configuration.isPressed ? 0 : 3)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == RoundedAndShadowButtonStyle {
    static var roundedAndShadow: RoundedAndShadowButtonStyle {
        RoundedAndShadowButtonStyle()
    }
}

struct RoundedAndShadowButton<V>: View where V: View {
    let label:V
    let action: () -> Void
    init(label: V, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }
    var body: some View {
        Button {
            action()
        } label: {
            label
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                )
                .compositingGroup()
                .shadow(radius: 5, x: 0, y: 3)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
