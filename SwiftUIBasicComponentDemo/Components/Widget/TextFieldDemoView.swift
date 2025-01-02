//
//  TextFieldDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 2024/12/12.
//
import SwiftUI

struct TextFieldDemoView: View {
    
    @State var firstEditState: String = ""
    @State var account: String = ""
    @State var password: String = ""
    @State var text: String = ""
    @State private var name: String = ""
    @State private var newpassword: String = ""
    @State var searchText: String = ""
    
    private var sampleSingleLineView: some View {
        VStack {
            SampleSectionTitleView(title: "1.单行输入框", desc: "普通文本输入框TextField和密码输入框SecureField")
            Text("State [\(self.firstEditState)]")
                .foregroundColor(.gray)
                .font(.system(size: 14))
            HStack(spacing: 0) {
                Text("账号")
                TextField("请输入账号", text: $account) { change in
                    self.firstEditState = change ? "账号编辑中" : "账号未编辑"
                } onCommit: {
                    self.firstEditState = "账号已提交"
                }
                .onChange(of: account, { oldValue, newValue in
                    if newValue.count > 11 {
                        account = String(newValue.prefix(11)) //限制最大输入为11个字符
                    }
                })
                .padding(10)
                .frame(height: 50, alignment: .top)
                .textFieldStyle(.roundedBorder)
            }
            HStack(spacing: 0) {
                Text("密码")
                SecureField("请输入密码", text: $password) {
                    self.firstEditState = "密码己提交"
                }
                .padding(10)
                .frame(height: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            TextField("请输入", text: $text)
                .textFieldStyle(.plain)
                .accentColor(.red)
                .foregroundColor(.green)
                .font(.system(size: 16))
                .frame(height: 50)
                .textFieldStyle(.automatic)
                .border(.white, width: 1)
                .background(Rectangle().fill(.white))
        }
    }
    
    private var sampleMultiLineView: some View {
        VStack {
            SampleSectionTitleView(title: "2.多行输入框")
            TextEditor(text: $text)
                .keyboardType(.phonePad) //设置键盘类型
                .multilineTextAlignment(.leading) //设置对齐方式
                .accentColor(.purple) //设置光标颜色，默认纯白色光标
                .foregroundColor(.red) //输入字体颜色
                .font(.system(size: 16)) //输入字体大小
                .background(Rectangle().fill(.blue.opacity(0.3))) //背景，无效
                .frame(height: 100) //frame
                .cornerRadius(5) //圆角
                .padding(5) //外边距
                .border(.blue, width: 1) //边框
        }
    }
    
    private var sampleFormTextFieldView: some View {
        VStack {
            SampleSectionTitleView(title: "3.表单中的输入框")
            Section(header: Text("用户信息")) {
                TextField("请输入姓名", text: $name)
                            .textFieldStyle(.plain)
                SecureField("请输入密码", text: $newpassword)
            }
            .background(.blue)
        }
    }
    
    private var sampleCustomSearchBarView: some View {
        VStack {
            SampleSectionTitleView(title: "4.自定义搜索输入框")
            HStack {
                TextField("搜索内容", text: $searchText)
                    .padding(.horizontal, 32)   //水平内边距，与文本内容
                    .padding(.vertical, 7)
                    .background(Color(.systemGray2))
                    .cornerRadius(8)
                    .overlay {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            //编辑时显示清除按钮
                            if searchText != "" {
                                Button {
                                    searchText = ""
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }

                            }
                        }
                    }
                    .onChange(of: searchText) { oldValue, newValue in
                        if searchText != "" {
                            
                        } else {
                            searchText = ""
                        }
                    }
            }
            .padding(.horizontal, 15)
        }
    }
    
    var body: some View {
        BaseView(buttonTitle: "首页", textColor: .red){
            ZStack {
                Color.gray.opacity(0.1).ignoresSafeArea(.all)
                ScrollView {
                    VStack {
                        sampleSingleLineView
                        sampleMultiLineView
                        sampleFormTextFieldView
                        sampleCustomSearchBarView
                    }
                    .padding(15)
                }
            }
            .navigationTitle("输入控件示例")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
