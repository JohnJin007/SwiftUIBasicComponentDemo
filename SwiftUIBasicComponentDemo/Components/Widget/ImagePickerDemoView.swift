//
//  ImagePickerDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 18/12/2024.
//

import SwiftUI

struct ImagePickerDemoView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var showingCameraPicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        ScrollView {
            VStack {
                if image != nil {
                    image?
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                }
                Text("相册是否可用:\(String(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)))")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                Button("从相册中选择图片") {
                    self.showingImagePicker = true
                }
                .frame(height: 40)
                Text("相机是否可用:\(String(UIImagePickerController.isSourceTypeAvailable(.camera)))")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                Button("从相机中获取图片") {
                    self.showingCameraPicker = true
                }
                .frame(height: 40)
            }
//            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
//              ImagePicker(image: self.$inputImage, sourceType: .photoLibrary)
//            }
//            .sheet(isPresented: $showingCameraPicker, onDismiss: loadImage) {
//                ImagePicker(image: self.$inputImage, sourceType: .camera)
//            }
            .fullScreenCover(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage, sourceType: .photoLibrary)
                    .edgesIgnoringSafeArea(.all)    // 让相册视图扩展到整个屏幕，包括安全区域
            }
            .fullScreenCover(isPresented: $showingCameraPicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage, sourceType: .camera)
                    .edgesIgnoringSafeArea(.all)    // 让相机视图扩展到整个屏幕，包括安全区域
            }
        }
        .navigationTitle("图片选择示例")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else {
            print("image empty")
            return
        }
        image = Image(uiImage: inputImage)
    }
}
