//
//  Home.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 30/12/2024.
//
import SwiftUI

struct Home: View {
    @State var title: String
    @Environment(\.self) var environment
    @State private var color = Color.red
    @State private var resolvedColor: Color.Resolved?
    @State private var colorJSON = ""
    let initResolvedColor = Color.Resolved(red: 0, green: 0.6, blue: 0.9, opacity: 1)
    
    var body: some View {
        Rectangle()
            .fill(Color(initResolvedColor).gradient)
            .ignoresSafeArea()
        
        VStack {
            Text(title)
            
            VStack {
                ColorPicker("Select your favorite color", selection: $color)

                if let resolvedColor = resolvedColor {
                    Text("Red: \(resolvedColor.red)")
                    Text("Green: \(resolvedColor.green)")
                    Text("Blue: \(resolvedColor.blue)")
                    Text("Opacity: \(resolvedColor.opacity)")
                }
                
                Text("Color JSON: \(colorJSON)")
            }
            .padding()
            .onChange(of: color, initial: true, getColor)
            
            //组合形状创建新形状
            Circle()
                .union(.capsule.inset(by: 50))
                .fill(.red)
            
            Circle()
                .lineSubtraction(.rect.inset(by: 30))
                .stroke(style: .init(lineWidth: 20, lineCap: .round))
                .padding()
        }
    }
    
    func getColor() {
        resolvedColor = color.resolve(in: environment)
        
        if let colorData = try? JSONEncoder().encode(resolvedColor) {
            colorJSON = String(decoding: colorData, as: UTF8.self)
        }
    }
}
