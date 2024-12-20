//
//  ImagePicker.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 18/12/2024.
//
import SwiftUI
import UIKit

/// 这是一个封装 `UIImagePickerController` 的 SwiftUI 视图。
/// 通过 `UIViewControllerRepresentable`，我们能够在 SwiftUI 中使用 UIKit 的 `UIImagePickerController`。
struct ImagePicker: UIViewControllerRepresentable {
    // 使用绑定来将选择的图片传回到父视图
    @Binding var image: UIImage?
    // 确定选择器的类型（相机或相册）
    var sourceType: UIImagePickerController.SourceType
    // 通过环境变量来控制视图的展示和关闭
    @Environment(\.presentationMode) var presentationMode
    
    // 协调器：用于将 UIKit 控件的代理方法转发到 SwiftUI 视图
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        // 父视图
        let parent: ImagePicker
        // 初始化时将父视图传入
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // 图片选择完成后的回调
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            print("image pick")
            // 从返回的信息中获取原始图片
            if let uiImage = info[.originalImage] as? UIImage {
                // 将选择的图片传递回父视图
                parent.image = uiImage
            }
            // 关闭图片选择器
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        // 用户取消选择时的回调
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("image pick canceled!")
            // 关闭图片选择器
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    // 创建 Coordinator 实例，协调 UIKit 和 SwiftUI 之间的通信
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // 创建并返回 `UIImagePickerController` 实例
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        // 设置图片选择器的类型（相机或相册）
        picker.sourceType = sourceType
        // 设置代理，委托给 Coordinator 来处理图片选择和取消操作
        picker.delegate = context.coordinator
        return picker
    }
    
    // `UIViewControllerRepresentable` 需要实现的更新方法，这里不需要做任何更新
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}
