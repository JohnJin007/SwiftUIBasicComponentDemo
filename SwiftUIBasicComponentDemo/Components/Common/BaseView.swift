//
//  BaseView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 2024/12/13.
//
import SwiftUI

struct BaseView<Content: View>: View {
    let content: Content       //子视图
    let iconColor: Color?      // 可选的图标颜色
    let buttonTitle: String?   // 可选的自定义返回按钮标题
    let textColor: Color?      // 可选的文字颜色
        
    init(
            buttonTitle: String? = nil,
            textColor: Color? = nil,
            iconColor: Color? = nil,
            @ViewBuilder content: () -> Content
    ) {
        self.buttonTitle = buttonTitle
        self.textColor = textColor
        self.iconColor = iconColor
        self.content = content()
    }
    
    var body: some View {
            content
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: customBackButton())
    }
    
    private func customBackButton() -> some View {
        // 如果子视图没有提供标题或颜色，使用默认值
        let defaultTextColor: Color = .blue
        let defaultIconColor: Color = .blue
        let title = buttonTitle ?? "返回" // 默认返回按钮文字为 "返回"

        return AnyView(
            CustomNavBackButton(
                iconColor: iconColor ?? defaultIconColor,
                buttonTitle: title,
                textColor: textColor ?? defaultTextColor
            )
        )
    }
}
