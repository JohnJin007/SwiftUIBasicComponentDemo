//
//  TextDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 2024/12/11.
//
import SwiftUI
import MarqueeLabel
import Foundation

struct TextDemoView: View {
    
    @State private var text = ""
    
    @State private var index: Int = 0
    
    let alignments: [TextAlignment] = [.leading, .center, .trailing]
    @State private var alignment = TextAlignment.leading
    
    @State private var ingredients = [String]()
    
    @State private var rolls = [Int]()
    
    @State private var amount = 50.0
    
    @State private var name = "Paul"
    
    private var sampleMarqueeLabelView: some View {
        VStack {
            SampleSectionTitleView(title: "1.走马灯效果", desc: "三方控件 MarqueeLabelView")
            MarqueeLabelView(text: self.$text)
                .onAppear {
                    self.text = "The initializer call Celsius (37.0) is clear in its intent without the need for an argument label. It’s therefore appropriate to write this initializer as init (_ celsius: Double) so that it can be called by providing an unnamed Double value."
                }
                .background(.gray)
        }
    }
    
    private var sampleTextColorView: some View {
        VStack {
            SampleSectionTitleView(title: "2.文本颜色", desc: "")
            Text("蓝色文字").foregroundColor(.blue)
            Text("自定义颜色/加粗").bold().foregroundColor(Color(UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)))
            Text("自定义资源颜色/倾斜")
                .italic()
                .foregroundColor(Color(R.color.custom_color()!))
            // 多语言版本的字符串，建议采用下划线的方式进行多语言配置
            Text(NSLocalizedString("hello_there", comment: ""))
        }.background(.gray)
    }
    
    private var sampleTextSizeView: some View {
        VStack {
            SampleSectionTitleView(title: "3.文本大小和粗细", desc: "")
            ScrollView(.horizontal) {
                HStack {
                    VStack {
                        Text("字体(.largeTitle)").font(.largeTitle)
                        Text("字体(.title)").font(.title)
                        Text("字体(.title2)").font(.title2)
                        Text("字体(.title3)").font(.title3)
                        Text("字体(.headline)").font(.headline)
                        Text("字体(.subheadline)").font(.subheadline)
                        Text("字体(.footnote)").font(.footnote)
                        Text("字体(.caption)").font(.caption)
                        Text("字体(.caption2)").font(.caption2)
                        Text("字体(.callout)").font(.callout)
                    }
                    VStack {
                        Text("字体(10f)").font(.system(size: 10))
                        Text("字体(12f)").font(.system(size: 12))
                        Text("字体(14f)").font(.system(size: 14))
                        Text("字体(16f)").font(.system(size: 16))
                        Text("字体(18f)").font(.system(size: 18))
                        Text("字体(20f)").font(.system(size: 20))
                        Text("字体(22f)").font(.system(size: 22))
                        Text("字体(24f)").font(.system(size: 24))
                        Text("字体(26f)").font(.system(size: 26))
                        Text("字体(28f)").font(.system(size: 28))
                    }
                    VStack() {
                        Text("大小(.regular)").fontWeight(.regular)
                        Text("大小(.medium)").fontWeight(.medium)
                        Text("大小(.bold)").fontWeight(.bold)
                        Text("大小(.heavy)").fontWeight(.heavy)
                        Text("大小(.light)").fontWeight(.light)
                    }
                }
            }
        }
    }
    
    private var sampleTextEffectView: some View {
        VStack {
            SampleSectionTitleView(title: "4.文本效果", desc: "")
            Group {
                Text("普通的背景效果")
                    .shadow(color: .black, radius: 1, x: 3, y: 3)
                Text(".shadow(color: .black, radius: 1, x: 3, y: 3)").font(.system(size: 14)).foregroundColor(.gray)
            }
            Group {
                Text("较强的背景效果")
                    .shadow(color: .black, radius: 2, x: 3, y: 3)
                Text(".shadow(color: .black, radius: 2, x: 3, y: 3)").font(.system(size: 14)).foregroundColor(.gray)
            }
            Group {
                Text("模糊效果").blur(radius: 3)
                Text(".blur(radius: 3)").font(.system(size: 14)).foregroundColor(.gray)
            }
            Group {
                Text("横划效果").strikethrough()
                Text(".strikethrough()").font(.system(size: 14)).foregroundColor(.gray)
            }
            Group {
                Text("边框效果")
                    .padding(5).border(.black, width: 2)
                Text(".padding(5).border(.black, width: 2)").font(.system(size: 14)).foregroundColor(.gray)
            }
            Group {
                Text("边框+填充效果")
                    .border(.black, width: 2).padding(5).border(.black, width: 2)
                Text(".border(.black, width: 2).padding(5).border(.black, width: 2)").font(.system(size: 14)).foregroundColor(.gray)
            }
            Group {
                Text("字距调整")
                    .kerning(5)
                    .background(.blue)
                Text("行间距调整\n适用于多行文本")
                    .lineSpacing(5) //调整文本中的行距
                    .background(.blue)
                    .fontDesign(.serif)
                    .fontWidth(.condensed)
                Text("ffi")
                    .font(.custom("AmericanTypewriter", size: 72))
                    .kerning(amount)
                Text("ffi")
                    .font(.custom("AmericanTypewriter", size: 72))
                    .tracking(amount)
                Slider(value: $amount, in: 0...100) {
                    Text("Adjust the amount of spacing")
                }
                Text("Kerning Example")
                    .font(.title)
                    .kerning(4)
                Text("Tracking Example")
                    .font(.title)
                    .tracking(4)
            }
        }
    }
    
    private var sampleLinkView: some View {
        VStack {
            SampleSectionTitleView(title: "5.链接Link和自定义点击事件", desc: "")
            Link(destination: URL(string: "https://www.baidu.com")!) {
                HStack {
                    Image(uiImage: R.image.icons8ChristmasStar48()!)
                    Text("这是一个跳转到网址的链接")
                }
            }
            Text("文本点击事件(带下划线):\(self.index)").underline().onTapGesture {
                self.index = self.index + 1
            }
            Text("文本点击事件(自定义下划线):\(self.index)").underline(true, color: .black).onTapGesture {
                self.index = self.index + 1
            }
        }
    }
    
    private var sampleTextWrapView: some View {
        VStack {
            SampleSectionTitleView(title: "6.多行文本折叠", desc: "")
            Text("多行文本折叠")
                //.lineLimit(3...6)
                .lineLimit(2, reservesSpace: true) //精确的限制高度
                .background(.yellow)
            Text(Consts.longText)
                .lineLimit(1)
                .truncationMode(.head) //截断文本的方式
                .foregroundStyle(.blue.gradient)
                .fontDesign(.serif)
                .fontWidth(.condensed)
        }
    }
    
    private var sampleTextComplexView: some View {
        VStack {
            SampleSectionTitleView(title: "7.图文混排")
            let message = Image(systemName: "message.badge.filled.fill").renderingMode(.original)
            let wifi = Image(systemName: "wifi")
            let animatableWifi: Image = Image(systemName: "wifi")
            Text("Test").foregroundColor(.red)
            + Text(message).font(.title)
            + Text("文字与SF Symbols混排。\(wifi) Text会将插值图片视作文字的一部分。")
            + Text(animatableWifi).foregroundColor(.blue).underline(pattern: .solid, color: .red)
        }
    }
    
    private var message1: AttributedString {
        var result = AttributedString("Hello!")
        result.font = .largeTitle
        result.foregroundColor = .red
        result.backgroundColor = .green
        return result
    }
    
    private var message2: AttributedString {
        var result = AttributedString("World!")
        result.font = .largeTitle
        result.foregroundColor = .red
        result.backgroundColor = .blue
        result.underlineStyle = Text.LineStyle(pattern: .solid, color: .cyan)
        return result
    }
    
    private var message: AttributedString {
        let string = "The letters go up and down"
        var result = AttributedString()
        
        for (index, letter) in string.enumerated() {
            var letterString = AttributedString(String(letter))
            letterString.baselineOffset = sin(Double(index)) * 5
            result += letterString
        }
        result.font = .largeTitle
        return result
    }
    
    private var message3: AttributedString {
        var result = AttributedString("Learn Swift here")
        result.font = .largeTitle
        result.link = URL(string: "https://www.hackingwithswift.com")
        return result
    }
    
    private var message4: AttributedString {
        var password = AttributedString("abCayer-muQai")
        password.accessibilitySpeechSpellsOutCharacters = true
        return "Your password is: " + password
    }
    
    private var message5: AttributedString {
        var result = Date.now.formatted(.dateTime.weekday(.wide).day().month(.wide).attributed)
        result.foregroundColor = .blue
        
        let weekday = AttributeContainer.dateField(.weekday)
        let weekdayStyling = AttributeContainer.foregroundColor(.red)
        result.replaceAttributes(weekday, with: weekdayStyling)
        
        return result
    }
    
    private var message6: AttributedString {
        var components = PersonNameComponents()
        components.givenName = "Taylor"
        components.familyName = "Swift"
        
        var result = components.formatted(.name(style: .long).attributed)
        
        let familyNameStyling = AttributeContainer.font(.headline)
        let familyName = AttributeContainer.personNameComponent(.familyName)
        result.replaceAttributes(familyName, with: familyNameStyling)
        
        return result
    }
    
    private var message7: AttributedString {
        let amount = Measurement(value: 200, unit: UnitLength.kilometers)
        var result = amount.formatted(.measurement(width: .wide).attributed)
        
        let distanceStyling = AttributeContainer.font(.title)
        let distance = AttributeContainer.measurement(.value)
        result.replaceAttributes(distance, with: distanceStyling)
        
        return result
    }
    
    private var sampleAttributedStringTextView: some View {
        VStack {
            SampleSectionTitleView(title: "8.富文本操作", desc: "")
            Text(message1 + message2)
            Text(message)
            Text(message3)
            Text(message4)
            Text(message5)
            Text(message6)
            Text(message7)
            Text(Consts.longText)
                //.multilineTextAlignment(.center)
                .frame(width: 300)
            Picker("Text alignment", selection: $alignment) {
                ForEach(alignments, id: \.self) { alignment in
                    Text(String(describing: alignment))
                }
            }
            .pickerStyle(.segmented)
            Text(Consts.longText)
                .font(.largeTitle)
                .multilineTextAlignment(alignment)
                .frame(width: 300)
        }
    }
    
    private var sampleFormatTextView: some View {
        VStack {
            SampleSectionTitleView(title: "9.格式化文本", desc: "")
            Text(ingredients, format: .list(type: .or))
            Button("Add Ingredient") {
                let possibles = ["Egg", "Sausage", "Bacon", "Spam"]
                
                if let newIngredient = possibles.randomElement() {
                    ingredients.append(newIngredient)
                }
            }
            
            Text(rolls, format: .list(memberStyle: .number, type: .and))
            Button("Roll Dice") {
                let result = Int.random(in: 1...6)
                rolls.append(result)
            }
            
            let length = Measurement(value: 225, unit: UnitLength.centimeters)
            Text(length, format: .measurement(width: .wide))
            
            Text(72.3, format: .currency(code: "CAD"))
            
            let dueDate = Date.now
            Text("Task due date: \(dueDate, formatter: Self.taskDateFormat)")
            
            // show just the date
            Text(Date.now.addingTimeInterval(600), style: .date)
            
            // show just the time
            Text(Date.now.addingTimeInterval(600), style: .time)
            
            // show the relative distance from now, automatically updating
            Text(Date.now.addingTimeInterval(600), style: .relative)
                .textCase(.uppercase)
            
            // make a timer style, automatically updating
            Text(Date.now.addingTimeInterval(600), style: .timer)
            
            
            // textCase大写或小写
            TextField("Shout your name at me", text: $name)
                .textFieldStyle(.roundedBorder)
                .textCase(.lowercase)
                .padding(.horizontal)
        }
    }
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        BaseView {
            ScrollView {
                VStack {
                    sampleMarqueeLabelView
                    sampleTextColorView
                    sampleTextSizeView
                    sampleTextEffectView
                    sampleLinkView
                    sampleTextWrapView
                    sampleTextComplexView
                    sampleAttributedStringTextView
                    sampleFormatTextView
                }
                .padding(15)
            }
            .navigationTitle("文本示例")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MarqueeLabelView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> MarqueeLabel {
        let marqueeLabel = MarqueeLabel()
        marqueeLabel.type = .continuous
        marqueeLabel.speed = .duration(20)
        marqueeLabel.numberOfLines = 1
        return marqueeLabel
    }
    
    func updateUIView(_ uiView: MarqueeLabel, context: Context) {
        uiView.textAlignment = .center
        uiView.text = text
        uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        uiView.restartLabel()
    }
}
