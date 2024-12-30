//
//  AlertDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 24/12/2024.
//

import SwiftUI

struct AlertDemoView: View {
    @State private var regularToast: Bool = false
    @State private var regularToastLong: Bool = false
    @State private var regularToastLongSubTitle: Bool = false
    @State private var errorToast: Bool = false
    @State private var completeToast: Bool = false
    @State private var loadingToast: Bool = false
    @State private var systemImageToast: Bool = false
    @State private var systemImageBannerPop: Bool = false
    @State private var systemImageBannerSlide: Bool = false
    @State private var systemImageHub: Bool = false
    
    var body: some View {
        VStack {
            Group {
                Button("弹出 .regular 类型", action: {
                    self.regularToast.toggle()
                }).frame(height: 40)
                Button("弹出 .regular 类型", action: {
                    self.regularToastLong.toggle()
                }).frame(height: 40)
                Button("弹出 .regular 类型", action: {
                    self.regularToastLongSubTitle.toggle()
                }).frame(height: 40)
                Button("弹出 .error 类型", action: {
                    self.errorToast.toggle()
                }).frame(height: 40)
                Button("弹出 .complete 类型", action: {
                    self.completeToast.toggle()
                }).frame(height: 40)
                Button("弹出 .loading 类型", action: {
                    self.loadingToast.toggle()
                }).frame(height: 40)
                Button("弹出 .systemImage 类型", action: {
                    self.systemImageToast.toggle()
                }).frame(height: 40)
                Button("弹出 .banner(.pop) 类型", action: {
                    self.systemImageBannerPop.toggle()
                }).frame(height: 40)
                Button("弹出 .banner(.slide) 类型", action: {
                    self.systemImageBannerSlide.toggle()
                }).frame(height: 40)
                Button("弹出 .hub 类型", action: {
                    self.systemImageHub.toggle()
                }).frame(height: 40)
            }
        }
        .toast(isPresenting: $regularToast) {
            AlertToast(type: .regular, title: "标题")
        }
    }
}