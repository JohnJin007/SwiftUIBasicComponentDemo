//
//  Sample.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 2024/12/11.
//
import Foundation
import SwiftUI

// 示例条目
struct SampleItem: Identifiable {
    
    var id: UUID = UUID()
    
    var name: String
    
    var destination: any View
    
}

// 示例分组
class SampleGroup: Identifiable {
    var id: UUID = UUID()
    
    var items:[SampleItem] = []
    
    // TODO: 使用结构体的时候下面的方法将会无效
    func addItem(item: SampleItem) {
        self.items.append(item)
    }
}

struct SampleData {
    private static let items:[SampleItem] = [
        SampleItem(name: "文本", destination: TextDemoView()),
        SampleItem(name: "按钮", destination: ButtonDemoView()),
        SampleItem(name: "输入框", destination: TextFieldDemoView()),
        SampleItem(name: "卡片", destination: CardDemoView()),
        SampleItem(name: "图片展示", destination: ImageDemoView()),
        SampleItem(name: "图片选择", destination: ImagePickerDemoView()),
        SampleItem(name: "表单", destination: FormDemoView()),
        SampleItem(name: "手势", destination: GestureDemoView()),
        SampleItem(name: "动画", destination: AnimationDemoView()),
        SampleItem(name: "布局", destination: LayoutDemoView()),
        SampleItem(name: "弹窗", destination: PopupDemoView())
    ]
    
    // 获取示例数据
    static func getSamples() -> [SampleGroup] {
        var groups:[SampleGroup] = []
        var index = 0
        var group: SampleGroup? = nil
        for item in items {
            if index % 3 == 0 {
                group = SampleGroup()
                groups.append(group!)
            }
            group?.addItem(item: item)
            index = index + 1
        }
        return groups
    }
}
