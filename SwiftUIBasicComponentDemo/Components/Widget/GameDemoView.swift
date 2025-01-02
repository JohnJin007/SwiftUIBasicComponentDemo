//
//  GameDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 31/12/2024.
//
import SwiftUI

struct gameRowView: View {
    var gameName: String
    var gameHelpText: String
    var gameImage: String
    
    var body: some View {
        VStack(alignment:.center, spacing: 60) {
            Text(gameName)
                .font(.system(size: 48)) //设置字体的大小、字体类型，或者自定义字体等,外观
                .bold() // 设置文本的粗体,样式
                .foregroundColor(.white)
            VStack(alignment: .center, spacing: 10){
                Text(gameHelpText)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                Image(gameImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: UIScreen.main.bounds.size.width - 20)
            }
        }
    }
}

struct GameDemoView: View {
    
    //准备游戏
    func prepareView() -> some View {
        VStack(alignment: .center, spacing: 80) {
            Spacer()
            Text("请确定你已启用Apple Watch上的空气投篮App")
                .font(.system(size: 17))
                .foregroundColor(.white)
                .lineLimit(2)
                .lineSpacing(15)
                .multilineTextAlignment(.center)
            Image("watch_application")
                .resizable()    // 使图像可调整大小
                .aspectRatio(contentMode: .fit) // 保持宽高比，适配父视图
                .scaledToFit()  // 也能达到类似的效果
            Spacer()
        }
        .frame(maxWidth: UIScreen.main.bounds.size.width / 2)
    }
    
    // 游戏列表
    func gameListView() -> some View {
        TabView {
            gameRowView(gameName: "投篮", gameHelpText: "手举球开始游戏", gameImage: "basketball")
            gameRowView(gameName: "打棒球", gameHelpText: "双手挥动开始游戏", gameImage: "baseball")
        }
        .tabViewStyle(PageTabViewStyle())
    }
    
    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            gameListView()
        }
    }
    
}
