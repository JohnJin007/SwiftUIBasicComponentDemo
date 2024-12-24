//
//  JKRoundedRectangle.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 23/12/2024.
//
import SwiftUI

public struct JKRoundedRectangle: Shape {
    public var radius: CGFloat = .infinity
    public var corners: UIRectCorner = .allCorners
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    public func jk_cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(JKRoundedRectangle(radius: radius, corners: corners))
    }
}
