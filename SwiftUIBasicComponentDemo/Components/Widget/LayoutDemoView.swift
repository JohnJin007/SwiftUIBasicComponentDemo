//
//  LayoutDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 20/12/2024.
//
import SwiftUI

struct LayoutDemoView: View {
    
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
        ScrollView {
            VStack {
                hStackSampleView
                contentAlignmentSampleView
                alignmentGuideSampleView
            }
            .padding(15)
        }
        .navigationBarTitle("布局示例", displayMode: .inline)
    }
}
