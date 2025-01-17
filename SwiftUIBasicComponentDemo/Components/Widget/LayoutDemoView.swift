//
//  LayoutDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 20/12/2024.
//
import SwiftUI

struct LayoutDemoView: View {
    @State private var count = 16
    
    private var hStackSampleView: some View {
        VStack {
            SampleSectionTitleView(title: "1. HStack 示例")
            ScrollView {
                HStack {
                    Text("HStack允许在水平方向布局")
                        .padding(.bottom, 30)
                        .border(.green, width: 1)
                    Text("效果类似 Android的LinearLayout")
                        .padding(.top, 30)
                        .padding(.horizontal, 10)
                        .border(.green, width: 1)
                }
                .frame(height: 100)
                .border(.gray, width: 1)
            }
        }
    }
    
    private var contentAlignmentSampleView: some View {
        VStack {
            Group {
                SampleSectionTitleView(title: "2.frame方法的alignment属性", desc: "该属性用在容器上,用来指定容器内元素的对齐方式")
                ZStack {
                    Divider()
                    HStack {
                        Text("1")
                            .frame(width: 50, height: 50, alignment: .topLeading)
                            .border(.green, width: 1)
                        Text("2")
                            .frame(width: 50, height: 50, alignment: .bottomTrailing)
                            .border(.green, width: 1)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    .frame(height: 90, alignment: .top)
                    .border(.blue, width: 1)
                }
                .frame(height: 100)
                .border(.gray, width: 1)
                ZStack {
                    Divider()
                    HStack(alignment: .top) {
                        Text("3")
                            .frame(width: 50, height: 50, alignment: .bottomLeading)
                            .border(.green, width: 1)
                        Text("4")
                            .frame(width: 60, height: 60, alignment: .topTrailing)
                            .border(.green, width: 1)
                    }
                    .padding(.horizontal, 30)
                    .frame(height: 90)
                    .border(.blue, width: 1)
                }
                .frame(height: 100)
                .border(.gray, width: 1)
            }
            Group {
                SampleSectionTitleView(title: "3.HStack构造方法的alignment属性", desc: "该属性用在容器上,分别是.firstTextBaseline和.lastTextBaseline")
                ZStack {
                    Divider()
                    HStack(alignment: .firstTextBaseline) {
                        Text("1")
                            .frame(width: 50, height: 50, alignment: .topLeading)
                            .border(.green, width: 1)
                        Text("2")
                            .frame(width: 50, height: 50, alignment: .bottomTrailing)
                            .border(.green, width: 1)
                        Text("3")
                            .frame(width: 50, height: 50)
                            .border(.green, width: 1)
                    }
                    .padding(.horizontal, 30)
                    .frame(height: 90)
                    .border(.blue, width: 1)
                }
                .frame(height: 100)
                .border(.gray, width: 1)
                ZStack {
                    Divider()
                    HStack(alignment: .lastTextBaseline) {
                        Text("1")
                            .frame(width: 50, height: 50, alignment: .topLeading)
                            .border(.green, width: 1)
                        Text("2")
                            .frame(width: 50, height: 50, alignment: .bottomTrailing)
                            .border(.green, width: 1)
                        Text("3")
                            .frame(width: 50, height: 50, alignment: .bottom)
                            .border(.green, width: 1)
                    }
                    .padding(.horizontal, 30)
                    .frame(height: 90)
                    .border(.blue, width: 1)
                }
                .frame(height: 100)
                .border(.gray, width: 1)
            }
            Group {
                SampleSectionTitleView(title: "4.多行文本的对齐方式")
                VStack(spacing: 10) {
                    Text(Consts.longText)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    Text(Consts.longText)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    Text(Consts.longText)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
    }
    
    private var alignmentGuideSampleView: some View {
        VStack {
            Group {
                SampleSectionTitleView(title: "5.垂直对齐", desc: "alignmentGuide方法垂直居中微调")
                ZStack {
                    Divider()
                    HStack(alignment: .center) {
                        Text("1")
                            .frame(width: 50, height: 50)
                            .border(.green, width: 1)
                            .alignmentGuide(VerticalAlignment.center) { d in
                                10
                            }
                        Text("2")
                            .frame(width: 50, height: 50)
                            .border(.green, width: 1)
                            .alignmentGuide(VerticalAlignment.center) { d in
                                -10
                            }
                        Text("3")
                            .frame(width: 50, height: 50)
                            .border(.green, width: 1)
                            .alignmentGuide(VerticalAlignment.center) { d in
                                0
                            }
                    }
                    .padding(.horizontal, 30)
                    .frame(height: 90)
                    .border(.blue, width: 1)
                }
                .frame(height: 100)
                .border(.gray, width: 1)
            }
            Group {
                SampleSectionTitleView(title: "6.水平对齐", desc: "alignmentGuide方法水平居中微调")
                ZStack {
                    Divider()
                    HStack {
                        Divider()
                    }
                    Group {
                        VStack(alignment: .leading) {
                            Text("1")
                                .frame(width: 50, height: 50)
                                .border(.green, width: 1)
                                .alignmentGuide(HorizontalAlignment.leading) { d in
                                    10
                                }
                            Text("2")
                                .frame(width: 50, height: 50)
                                .border(.green, width: 1)
                                .alignmentGuide(HorizontalAlignment.leading) { d in
                                    -10
                                }
                            Text("3")
                                .frame(width: 50, height: 50)
                                .border(.green, width: 1)
                                .alignmentGuide(HorizontalAlignment.leading, computeValue: { d in
                                    let info = "Squre[3]: width[\(d.width)], height[\(d.height)], h.center[\(d[HorizontalAlignment.center])], h.leading[\(d[HorizontalAlignment.leading])], h.trailing[\(d[HorizontalAlignment.trailing])], v.top[\(d[VerticalAlignment.top])], v.bottom[\(d[VerticalAlignment.bottom])], v.center[\(d[VerticalAlignment.center])]"
                                    debugPrint(info)
                                    return 0
                                })
                        }
                        .padding(10)
                        .border(.blue, width: 1)
                    }
                    .padding(.vertical, 5)
                }
                .border(.gray, width: 1)
            }
        }
    }
    
    var body: some View {
        //        ScrollView {
        //            VStack {
        //                hStackSampleView
        //                contentAlignmentSampleView
        //                alignmentGuideSampleView
        //            }
        //            .padding(15)
        //        }
        //        .navigationBarTitle("布局示例", displayMode: .inline)
        //        GeometryReader { geometry in
        //            HStack(spacing: 0) {
        //                Text("Left")
        //                    .font(.largeTitle)
        //                    .foregroundStyle(.black)
        //                    .frame(width: geometry.size.width * 0.33)
        //                    .background(.yellow)
        //                Text("Right")
        //                    .font(.largeTitle)
        //                    .foregroundStyle(.black)
        //                    .frame(width: geometry.size.width * 0.67)
        //                    .background(.orange)
        //            }
        //        }
        //        .frame(height: 50)
        //        .padding()
        //        .navigationBarTitle("布局示例", displayMode: .inline)
        //    }
        RadialLayout {
            ForEach(0..<count, id: \.self) { _ in
                Circle()
                    .fill(.red)
                    .frame(width: 32, height: 32)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Stepper("Count: \(count)", value: $count.animation(), in: 0...36)
                .padding()
        }
    }
}

//自定义布局
struct RadialLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        //计算圆形的半径
        let radius = min(bounds.size.width, bounds.size.height) / 2
        //计算每个子视图占据圆周的角度,并转化为弧度
        let angle = Angle.degrees(360 / Double(subviews.count)).radians
        
        //循环放置子视图
        for(index, subview) in subviews.enumerated() {
            //获取每个子视图的大小
            let viewSize = subview.sizeThatFits(.unspecified)
            //根据每个子视图的索引计算其在圆周上的位置,(- .pi / 2 是为了调整起始角度，使得第一个子视图位于顶部)
            let xPos = cos(angle * Double(index) - .pi / 2) * (radius - viewSize.width / 2)
            let yPos = sin(angle * Double(index) - .pi / 2) * (radius - viewSize.height / 2)
            
            //计算最终的位置，将子视图放置在父视图的中心，并加上偏移量
            let point = CGPoint(x: bounds.midX + xPos, y: bounds.midY + yPos)
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}
