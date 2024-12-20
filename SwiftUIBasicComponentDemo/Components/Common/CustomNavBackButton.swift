//
//  CustomBackButton.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 2024/12/11.
import SwiftUI

struct CustomNavBackButton: View {
    // 通过环境变量获取当前视图的呈现模式
    @Environment(\.presentationMode) var presentationMode
    // 返回按钮图标颜色
    let iconColor: Color
    // 返回按钮的标题
    let buttonTitle: String
    // 返回按钮文字颜色
    let textColor: Color
    
    var body: some View {
        HStack {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward").foregroundColor(iconColor).fontWeight(.semibold)
                Spacer().frame(width:3)
                Text(buttonTitle).foregroundColor(textColor)
            }
        }
    }
}
