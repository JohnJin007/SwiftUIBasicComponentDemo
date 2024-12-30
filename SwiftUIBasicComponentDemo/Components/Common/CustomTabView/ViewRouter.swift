//
//  ViewRouter.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 30/12/2024.
//
import SwiftUI

enum Page {
    case home
    case my
}

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .home
}
