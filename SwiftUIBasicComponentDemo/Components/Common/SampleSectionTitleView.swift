//
//  SampleSectionTitleView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 2024/12/12.
//
import SwiftUI

struct SampleSectionTitleView: View {
    
    var title: String = ""
    
    var desc: String = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title).font(.system(size: 16)).foregroundColor(.white)
                if !desc.isEmpty {
                    Text(desc).font(.system(size: 14)).foregroundColor(.white)
                }
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .background(.green)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    SampleSectionTitleView(title: "hello", desc: "world")
}
