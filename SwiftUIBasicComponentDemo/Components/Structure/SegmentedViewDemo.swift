//
//  SegmentedViewDemo.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 03/01/2025.
//
import SwiftUI
import JXSegmentedView
import UIKit

struct SegmentedViewDemo: View {
    
    @ObservedObject private var vm: SegmentedViewModel = SegmentedViewModel()
    @State private var selection: Int = 0
    private let colors: [Color] = [.red.opacity(0.1), .green.opacity(0.1), .blue.opacity(0.1)]
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.left")
                    .padding(10)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                Text("顶部导航栏示例")
                Spacer()
            }
            .padding(.leading, 5)
            SegmentedView(selectedIndex: self.$selection, titles: self.$vm.titles)
                .frame(width: UIScreen.main.bounds.size.width, height: 40)
            TabView(selection: $selection) {
                ForEach(0..<3) { idx in
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("页面 [\(idx)]")
                            Spacer()
                        }
                        Button("点击跳转到下一个页面") {
                            let next = self.selection + 1
                            if next >= colors.count {
                                self.selection = 0
                            } else {
                                self.selection = next
                            }
                        }
                        Spacer()
                    }
                    .background(colors[idx])
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .onAppear {
            vm.requestTabs()
        }
        .navigationBarHidden(true)
    }
}

class SegmentedViewModel: ObservableObject {
    
    @Published var titles: [String] = []
    
    func requestTabs() {
        titles = ["TAB A", "TAB B", "TAB C"]
    }
}

struct SegmentedView: UIViewRepresentable {
    @Binding var selectedIndex: Int
    @Binding var titles: [String]
    
    private let segmentedDataSource = JXSegmentedTitleDataSource()
    private let segmentedView = JXSegmentedView()
    
    
    class Coordinator: NSObject, JXSegmentedViewDelegate {
        var parent: SegmentedView
        
        init(_ parent: SegmentedView) {
            self.parent = parent
        }
        
        /// 点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，而不关心具体是点击还是滚动选中的情况。
        func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
            print("didSelectedItemAt index [\(index)]")
            self.parent.selectedIndex = index
        }
        
        /// 点击选中的情况才会调用该方法
        func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
            print("didClickSelectedItemAt index [\(index)]")
        }

        /// 滚动选中的情况才会调用该方法
        func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int) {
            print("didScrollSelectedItemAt index [\(index)]")
        }

        /// 正在滚动中的回调
        func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
            print("scrollingFrom leftIndex [\(leftIndex)], rightIndex[\(rightIndex)], percent[\(percent)]")
        }

        /// 是否允许点击选中目标index的item
        func segmentedView(_ segmentedView: JXSegmentedView, canClickItemAt index: Int) -> Bool {
            print("canClickItemAt index [\(index)]")
            return true
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        print("SegmentedView makeCoordinator called")
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> JXSegmentedView {
        print("SegmentedView makeUIView called")
        segmentedView.delegate = context.coordinator
        segmentedView.defaultSelectedIndex = selectedIndex
        
        segmentedDataSource.titles = ["页面 1", "页面 2", "页面 3"]
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedView.dataSource = self.segmentedDataSource
        
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 20
        segmentedView.indicators = [indicator]
        
        return segmentedView
    }
    
    func updateUIView(_ uiView: JXSegmentedView, context: Context) {
        print("SegmentedView updateUIView called, selected[\(selectedIndex)] title[\(titles)]")
        if uiView.selectedIndex != selectedIndex {
            uiView.selectItemAt(index: selectedIndex)
        }
    }
}
