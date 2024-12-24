//
//  PopupDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 23/12/2024.
//
import SwiftUI

struct PopupDemoView: View {
    @State var showAlert: Bool = false
    @State var showSheet: Bool = false
    @State var showPop: Bool = false
    @State var showCustomPop: Bool = false
    @State var pickerIndex: Int = 0
    @State var dataSelection: Date = Date()
    
    private var sheet: ActionSheet {
        return ActionSheet(title: Text("标题"), message: Text("内容"), buttons: [
            .destructive(Text("destructive按钮"), action: {
                print("你点击了 destructive按钮")
            }),
            .default(Text("default按钮"), action: {
                print("你点击了default按钮")
            }),
            .cancel(Text("取消"), action: {
                print("你点击了取消按钮")
            })
        ])
    }
    
    private var sampleAlertDemoView: some View {
        VStack {
            SampleSectionTitleView(title: "1.消息对话框", desc: "基于alert实现")
            Button {
                self.showAlert = true
            } label: {
                Text("消息对话框")
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("标题"),
                      message: Text("内容"),
                      primaryButton: .destructive(Text("确定"), action: {
                    print("你点击了确定按钮")
                }),
                      secondaryButton: .cancel())
            }

        }
    }
    
    private var sampleActionSheetDemoView: some View {
        VStack {
            SampleSectionTitleView(title: "2.底部对话框", desc: "基于actionSheet实现")
            Button {
                self.showSheet = true
            } label: {
                Text("底部对话框")
            }
            .actionSheet(isPresented: $showSheet, content: {sheet})
        }
    }
    
    private var sampleSheetDemoView: some View {
        VStack {
            SampleSectionTitleView(title: "3.sheet浮层", desc: "基于sheet方法实现")
            Button {
                self.showPop = true
            } label: {
                Text("显示 sheet 浮层")
            }
            .sheet(isPresented: $showPop) {
                if #available(iOS 16.0, *) {
                    NavigationStack {
                        PopLayerView()
                    }
                    .presentationDetents([.medium,.large]) //指定浮层可以显示的不同高度（例如中等高度和大高度）
                    .presentationDragIndicator(.visible)   //浮层的拖动指示器可见
                } else {
                    PopLayerView()
                }
            }
        }
    }
    
    private var sampleCustomPopDemoView: some View {
        VStack {
            SampleSectionTitleView(title: "4.自定义浮层对话框", desc: "基于overlay + blur方法实现")
            Button("显示自定义浮层对话框") {
                withAnimation {
                    self.showCustomPop = true
                }
            }
        }
    }
    
    private var samplePickerDemoView: some View {
        VStack {
            SampleSectionTitleView(title: "5.弹出选择框", desc: "基于Picker实现，附其他样式的Picker")
            Picker("ss", selection: $pickerIndex) {
                ForEach(0..<10) { idx in
                    Text("选项\(idx)")
                }
            }
            .frame(width: UIScreen.main.bounds.width - 30, height: 40)
            Picker("tips", selection: $pickerIndex) {
                ForEach(0..<5) { idx in
                    Text("选项\(idx)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            Picker("tips", selection: $pickerIndex) {
                ForEach(0..<5) { idx in
                    Text("选项\(idx)")
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 100)
        }
    }
    
    private var sampleDatePickerDemoView: some View {
        VStack {
            SampleSectionTitleView(title: "6.时间和日期选择框", desc: "基于DatePicker实现，附其他样式的DatePicker")
            HStack {
                Text("日期选择")
                Spacer()
                DatePicker(selection: $dataSelection, displayedComponents: .date) {
                    Text("Label")
                }
            }
            .frame(width: UIScreen.main.bounds.width - 30, height: 40)
            HStack {
                Text("时间选择")
                Spacer()
                DatePicker(selection: $dataSelection, displayedComponents: .hourAndMinute) {
                    Text("Label")
                }
            }
            .frame(width: UIScreen.main.bounds.width - 30, height: 40)
            DatePicker("日期选择", selection: $dataSelection, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .padding(.vertical, 20)
            DatePicker("时间选择", selection: $dataSelection, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .padding(.vertical, 20)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                sampleAlertDemoView
                sampleActionSheetDemoView
                sampleSheetDemoView
                sampleCustomPopDemoView
                samplePickerDemoView
                sampleDatePickerDemoView
            }
            .padding(15)
        }
        .blur(radius: showCustomPop ? 6 : 0) //添加模糊效果,radius 参数指定了模糊的强度，数值越大，模糊越强
        .overlay {
            showCustomPop ? CustomPopView(showPop: $showCustomPop) : nil
        }
    }
}

struct PopLayerView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        return VStack(spacing: 15) {
            Text("自定义弹窗内容")
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("点击退出")
            }
        }
    }
}

struct CustomPopView: View {
    @State private var showAlert: Bool = false
    @Binding var showPop: Bool
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button("Show Alert") {
                    self.showAlert = true
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("alert from popup"), message: Text("message"), primaryButton: .destructive(Text("primary")), secondaryButton: .cancel())
                }
                Spacer()
            }
            .padding(40)
            .background(Rectangle().fill(.white))
            .cornerRadius(16)
            .transition(.offset(x: 0, y: 100))
        }
        .padding(.all, 8)
        .background(.black.opacity(0.3))
        .onTapGesture {
            self.showPop = false
        }
        //.edgesIgnoringSafeArea(.all)
        .opacity(showAlert ? 0 : 1)
    }
}
