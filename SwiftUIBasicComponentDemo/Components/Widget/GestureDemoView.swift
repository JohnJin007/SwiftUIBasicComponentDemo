//
//  GestureDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 19/12/2024.
//

import SwiftUI

struct GestureDemoView: View {
    @State private var tip: String = ""
    // 定义状态变量，用于保存拖拽的偏移量
    @State private var lineDragAmount: CGSize = .zero
    // 用于设置背景颜色的状态变量
    @State private var letterBkgColor: Color = .green
    // 定义状态变量，用于保存拖拽的偏移量
    @State private var hstackDragAmount: CGSize = .zero
    
    private var sampleDragView: some View {
        VStack {
            // 标题视图
            SampleSectionTitleView(title: "3.拖拽效果")
            // LinearGradient视图，带有渐变色
            LinearGradient(colors: [.red, .green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                // 设置视图的大小
                .frame(width: 100, height: 100)
                // 设置圆角，圆角类型为连续圆角
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                // 使用拖拽偏移量来设置视图的位置
                .offset(lineDragAmount)
                // 添加拖拽手势
                .gesture(
                    DragGesture()
                        // 当拖拽发生变化时更新偏移量
                        .onChanged({ state in
                            self.lineDragAmount = state.translation
                        })
                        // 当拖拽结束时，使用弹簧动画将视图恢复到原位置
                        .onEnded({ _ in
                            withAnimation(.spring()) {
                                self.lineDragAmount = .zero
                            }
                        })
                )
                // 在视图上添加文本，提示用户进行拖拽
                .overlay {
                    Text("拖动我")
                }
            // 用于分隔视图的空白区域，增加间距
            Spacer()
                .frame(height: 50)
            // 水平排列的数字文本视图
            HStack {
                // 使用ForEach遍历生成0到5的数字
                ForEach(0..<6) { index in
                    Text("\(index)")
                        // 设置文本的内边距
                        .padding(10)
                        // 设置文本的字体样式
                        .font(.headline)
                        // 设置背景颜色
                        .background(self.letterBkgColor)
                        // 根据拖拽偏移量调整位置
                        .offset(self.hstackDragAmount)
                        // 为每个数字元素设置动画效果，并且每个数字的动画有延迟，形成错开显示的效果
                        .animation(Animation.easeOut(duration: 0.5).delay(0.1 * Double(index)))
                }
            }
            // 为整个HStack添加拖拽手势
            .gesture(
                DragGesture()
                    // 当拖拽发生变化时，更新拖拽的偏移量
                    .onChanged({ state in
                        self.hstackDragAmount = state.translation
                    })
                    // 拖拽结束时，重置偏移量为零
                    .onEnded({ _ in
                        self.hstackDragAmount = .zero
                    })
            )
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text(self.tip)
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                Group {
                    SampleSectionTitleView(title: "1.长按事件")
                    Text("请长按我")
                        .simultaneousGesture(
                            LongPressGesture().onEnded({ _ in
                                self.tip = "长按了控件"
                            })
                        )
                }
                Group {
                    SampleSectionTitleView(title: "2.连点事件")
                    Text("请连点我")
                        .highPriorityGesture(
                            TapGesture(count: 3).onEnded({ _ in
                                self.tip = "连续点击了控件"
                            })
                        )
                }
                sampleDragView
            }
            .padding(15)
        }
    }
}
