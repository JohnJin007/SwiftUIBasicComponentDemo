//
//  AnimationDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 20/12/2024.
//

import SwiftUI

struct AnimationDemoView:View {
    // 用于切换不同动画的索引
    @State private var animationIndex = 0
    // 控制矩形的显示与隐藏
    @State private var showSquare: Bool = false
    // 显示当前动画类型的提示文本
    @State private var tip: String = ""
    
    private var toggleSampleView: some View {
        VStack {
            // 显示一个自定义的标题视图
            SampleSectionTitleView(title: "1.入场动画")
            // 按钮：点击时会触发切换动画的逻辑
            Button {
                // 每次点击按钮时，增加动画索引
                self.animationIndex = self.animationIndex + 1
                // 根据当前的 animationIndex 使用不同的动画
                switch animationIndex % 3 {
                case 0:
                    // 如果是第 0 种动画类型，切换 showSquare 的显示状态，但没有动画效果
                    self.showSquare.toggle()
                    self.tip = "无动画出现"
                case 1:
                    // 如果是第 1 种动画类型，使用默认的动画切换 showSquare 状态
                    withAnimation {
                        self.showSquare.toggle()
                    }
                    self.tip = "使用动画出现"
                case 2:
                    // 如果是第 2 种动画类型，使用自定义的动画时长（0.4秒）
                    withAnimation(.easeInOut(duration: 0.4)) {
                        self.showSquare.toggle()
                    }
                    self.tip = "使用动画和自定义时长出现"
                default:
                    break
                }
            } label: {
                Text("点我")
                    .foregroundColor(.white)
                    .font(.system(size: 16))
            }
            .padding(30)
            .background(.blue)
            .cornerRadius(6)
            Text(tip)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            // 如果 showSquare 为 true，显示两个矩形
            if showSquare {
                // 第一个矩形：粉色矩形，使用非对称的缩放动画
                Rectangle()
                    .fill(.pink)
                    .frame(width: 100, height: 100)
                    .transition(.asymmetric(insertion: .scale, removal: .scale)) // 允许为视图的插入和移除分别指定不同的动画效果，使用缩放动画作为插入和移除的过渡效果
                Rectangle()
                    .fill(.blue)
                    .frame(width: 100, height: 100)
                    .transition(
                        .modifier(
                            active: CornerRotationModifier(angle: .radians(-.pi/2), anchor: .topLeading), // 旋转 90 度，旋转锚点为左上角
                            identity: CornerRotationModifier(angle: .radians(0), anchor: .topLeading)   // 默认状态，不旋转
                        )
                    )
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                toggleSampleView
            }
            .padding(15)
        }
        .navigationTitle("动画示例")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 自定义的旋转修饰符
// 这个修饰符用于旋转视图，并指定旋转的角度和锚点
struct CornerRotationModifier: ViewModifier {
    let angle: Angle    // 旋转角度
    let anchor: UnitPoint // 旋转的锚点，表示旋转中心的位置
    
    // 这个方法会应用旋转效果到视图内容
    func body(content: Content) -> some View {
        content
            .rotationEffect(angle, anchor: anchor) // 应用旋转效果，使用传入的角度和锚点
            .clipped()
    }
}
