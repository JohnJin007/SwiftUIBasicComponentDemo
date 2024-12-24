//
//  ButtonDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 2024/12/12.
//

import SwiftUI

struct ButtonDemoView: View {
    
    @State var tip: String = "ButtonDemo"
    @State var isToggleOn: Bool = false
    @State var bold: Bool = false
    @State var sliderValue = 0.0
    @State var stepValue = 0
    @State var stepperValue = 0
    
    private var sampleButton: some View {
        VStack {
            SampleSectionTitleView(title: "1.普通按钮", desc: "基于原生的Button按钮")
            
            Rectangle()
                .fill(.yellow)
                .jk_cornerRadius(20, corners: [.topLeft, .topRight])
                .frame(width: 200, height: 100)
                .overlay(
                    Text("设置局部圆角")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                )
            
            Button("按钮") {
                debugPrint("点击事件")
            }
            
            Button("Bordered Button") {
                debugPrint("Bordered button tapped!")
            }
            .buttonStyle(.bordered)
            
            Button("borderedProminent Button") {
                debugPrint("borderedProminent button tapped!")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                self.tip = "你点击了普通按钮"
                debugPrint(self.tip)
            } label: {
                Text("普通按钮:自定义背景和圆角")
                    .foregroundColor(.white)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 30)
            .background(Rectangle().fill(.green))
            .cornerRadius(8, antialiased: true)
            
            Button {
                self.tip = "你点击了带渐入动画按钮"
            } label: {
                Text("带动画按钮")
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            }
            .background(Rectangle().fill(.blue))
            .cornerRadius(8, antialiased: false)
            .animation(.easeIn(duration: 5))
            .background(
                GeometryReader { proxy in
                    let frame = proxy.frame(in: .local)
                    let origin = frame.origin
                    Color.clear.preference(key: CustomPreferenceKey.self, value: origin)
                }
            )
            
            Button {
                self.tip = "你点击了带透明度按钮"
            } label: {
                Text("带透明度按钮")
            }
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            .background(Rectangle().fill(.purple))
            .cornerRadius(8, antialiased: true)
            .opacity(0.5)
            
            Button {
                self.tip = "你点击了发送一个通知按钮"
                NotificationCenter.default.post(name: NSNotification.Name(Events.Sample_Notification_Name), object: Message(text: "Hello world!"))
            } label: {
                Text("发送一个通知")
                    .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            .background(RoundedRectangle(cornerRadius: 10, style: .circular))
            .foregroundColor(.green)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 2))

            Button {
                self.tip = "你点击了带图标按钮"
            } label: {
                HStack {
                    Image(systemName: "trash")
                        .font(.system(size: 14))
                    Text("带图标按钮")
                        .font(.system(size: 14))
                }
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
            }
        }.onPreferenceChange(CustomPreferenceKey.self) { value in
            self.tip = "Received preference change with value:[\(value)]"
            debugPrint(self.tip)
        }
    }
    
    private var sampleToggleView: some View {
        VStack {
            SampleSectionTitleView(title: "2.开关按钮", desc: "基于原生的 Toggle")
            Toggle(isOn: $isToggleOn) {
                
            }
            Toggle(isOn: $isToggleOn) {
                Text("开关状态：\(self.isToggleOn ? "打开" : "关闭")")
            }
            if #available(iOS 15.0, *) {
                Toggle(isOn: $bold) {
                    HStack {
                        Image(systemName: "bold")
                        Text(".button风格的开关按钮")
                    }.toggleStyle(.button)
                }
            }
        }
    }
    
    private var sampleSliderView: some View {
        VStack {
            SampleSectionTitleView(title: "3.滑块按钮", desc: "基于原生的Slider")
            Slider(value: $sliderValue, in: 0...10, label: {
                Text("貌似没什么用")
            }, minimumValueLabel: {
                Text("开始（0）")
            }, maximumValueLabel: {
                Text("结束（10）")
            })
            
            Slider(value: $sliderValue, in: 0...100, step: 10, label: {
                Text("貌似没什么用")
            }, minimumValueLabel: {
                Text("开始（0）")
            }, maximumValueLabel: {
                Text("结束（100）")
            })
            
            Text("当前的值:\(self.sliderValue)")
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
    }
    
    private var sampleStepperView: some View {
        VStack {
            SampleSectionTitleView(title: "4. 步进按钮", desc: "基于原生的 Stepper")
            Stepper(value: $stepValue, step: 2, label: {
                Text("步进值为 [\(self.stepValue)]")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            })
            Stepper(label: {
                Text("步进值为 [\(self.stepperValue)]")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }, onIncrement: {
                self.stepperValue = self.stepperValue + 5
            }, onDecrement: {
                self.stepperValue = self.stepperValue - 5
            }, onEditingChanged: { editing in
                print("editing \(editing)")
            })
        }
    }
    
    private var sampleNavigationLink: some View {
        VStack {
            SampleSectionTitleView(title: "5.跳转按钮", desc: "基于原生的NavigationLink")
            NavigationLink {
                Text("这是另一个页面的布局")
            } label: {
                Text("跳转到另一个页面")
                    .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            .background(Rectangle().fill(.blue))
            .cornerRadius(8)
        }
    }
    
    private var sampleCustomButtonStyle: some View {
        VStack {
            SampleSectionTitleView(title: "6.自定义按钮外观和样式,交互动画")
            let label = Label("Press Me", systemImage: "digitalcrown.horizontal.press.fill")
            RoundedAndShadowButton(label: label) {
                debugPrint("button view")
            }
            
            Button {
                debugPrint("rounded and shadow")
            } label: {
                label
            }
            .buttonStyle(.roundedAndShadow)

        }
    }
    
    var body: some View {
        BaseView(textColor: .red, iconColor: .red) {
            ScrollView {
                VStack {
                    sampleButton
                    sampleToggleView
                    sampleSliderView
                    sampleStepperView
                    sampleNavigationLink
                    sampleCustomButtonStyle
                }
                .padding(15)
            }
            .navigationTitle("按钮示例")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
