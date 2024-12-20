//
//  ImageDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 18/12/2024.
//
import SwiftUI
import Kingfisher

struct ImageDemoView: View {
    @State private var tip: String = ""
    @State private var playLottie: Int = 0
    
    private var sampleResourceImageView: some View {
        VStack {
            SampleSectionTitleView(title: "1.资源图片示例")
            HStack {
                Image(uiImage: R.image.icons8HeartLock48()!)
                    .onTapGesture {
                        self.tip = "点击了图片"
                    }
                Image(uiImage: R.image.icons8HeartLock48()!)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        self.tip = "点击了30x图片"
                    }
                Image(uiImage: R.image.icons8HeartLock48()!)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        self.tip = "点击了50x图片"
                    }
                    .blur(radius: 3)
            }
        }
    }
    
    private var sampleGradientImageView: some View {
        VStack {
            SampleSectionTitleView(title: "2.渐变图片 Shape等")
            ScrollView(.horizontal) {
                HStack {
                    LinearGradient(colors: [.red, .green, .blue], startPoint: .top, endPoint: .bottom) //渐变矩形
                        .frame(width: 100, height: 100)
                        .overlay(Text("LinearGradient").foregroundColor(.white))
                    RoundedRectangle(cornerRadius: 10.0)    //圆角矩形
                        .fill(.blue)
                        .frame(width: 100, height: 100)
                        .overlay(Text("RoundedRectangle").foregroundColor(.white))
                    Capsule().fill(.red)    //胶囊形状
                        .frame(width: 150, height: 100)
                        .overlay(Text("Capsule").foregroundColor(.white))
                    Circle()    //圆形
                        .fill(.green)   //填充绿色
                        .frame(width: 100, height: 100) // 设置圆形的尺寸
                        .overlay(   //在圆形上叠加视图
                            Text("Circle")  //显示文字
                                .foregroundColor(.white)    //设置文字颜色为白色
                                .font(.headline)    //设置文字字体大小
                        )
                        .shadow(radius: 10) //添加阴影效果
                }
            }
        }
    }
    
    private var sampleImageEffectView: some View {
        VStack {
            SampleSectionTitleView(title: "3.图片效果")
            ScrollView(.horizontal) {
                HStack {
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .overlay(
//                            RoundedRectangle(cornerRadius: 100)
//                                .stroke(.blue, lineWidth: 3)
//                                .shadow(color: .gray, radius: 2, x: 2, y: 2)
                            Circle()
                                .stroke(.blue, lineWidth: 3)
                        )
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(.blue, lineWidth: 2)
                                .shadow(color: .gray, radius: 2, x: 2, y: 2)
                        )
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .scaleEffect()
                        .frame(width: 100, height: 100, alignment: .top)
                        .overlay(
                            Text("顶部")
                        )
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                        .overlay(
                            Text("中间")
                        )
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .overlay(
                            Text("底部")
                        )
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .clipShape(ContainerRelativeShape())
                        .frame(width: 100, height: 100)
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 90, height: 90)
                        .overlay {
                            RoundedRectangle(cornerRadius: 90)
                                .stroke(.blue, lineWidth: 2)
                        }
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .clipShape(Ellipse())
                        .frame(width: 100, height: 100)
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .clipShape(Capsule())
                        .frame(width: 100, height: 100)
                    
                }
            }
        }
    }
    
    private var sampleSystemImageView: some View {
        VStack {
            SampleSectionTitleView(title: "4.系统内置图片")
            HStack {
                Image(systemName: "3.circle").imageScale(.large)
                Image(systemName: "13.circle").imageScale(.large)
                Image(systemName: "50.circle").imageScale(.large)
            }
        }
    }
    
    private var sampleLottieImageView: some View {
        VStack {
            SampleSectionTitleView(title: "5. Lottie图片", desc: "点击图片可以重新播放动画")
            LottieView(lottieFile: "thank_you", play: $playLottie)
                .frame(width: 160, height: 160)
                .onTapGesture {
                    self.playLottie = self.playLottie + 1
                }
        }
        .background(.yellow)
    }
    
    private var sampleNetworkImageView: some View {
        VStack {
            SampleSectionTitleView(title: "6.网络图片加载", desc: "基于三方控件 Kingfisher")
            let size: CGFloat = 200
            ScrollView(.horizontal) {
                HStack {
                    KFImage(URL(string: Consts.Sample_Network_Image))
                        .renderingMode(.original)
                        .resizable()
                        .placeholder { progress in
                            RoundedRectangle(cornerRadius: 10.0)
                                .fill(.gray.opacity(0.1))
                                .frame(width: size, height: size)
                                .cornerRadius(size / 10)
                        }
                        .scaledToFit()
                        .padding(size / 10)
                        .frame(width: size, height: size)
                        .clipped()
                        .border(.gray.opacity(0.1))
                    
                    KFImage(URL(string: Consts.Sample_Network_Image))
                        .renderingMode(.original)
                        .resizable()
                        .fade(duration: 500)
                        .placeholder { progress in
                            RoundedRectangle(cornerRadius: 10.0)
                                .fill(.gray.opacity(0.1))
                                .frame(width: size, height: size)
                                .cornerRadius(size / 10)
                        }
                        .padding(size / 10)
                        .frame(width: size, height: size, alignment: .top)
                        .scaledToFit()
                        .clipped()
                        .border(.gray.opacity(0.1))
                }
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("\(self.tip)")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                sampleResourceImageView
                sampleGradientImageView
                sampleImageEffectView
                sampleSystemImageView
                sampleLottieImageView
                sampleNetworkImageView
            }
            .padding(15)
        }
    }
}
