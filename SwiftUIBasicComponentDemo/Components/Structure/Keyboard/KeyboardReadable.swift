//
//  KeyboardReadable.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 07/01/2025.
//
import UIKit
import Combine
import Foundation

public protocol KeyboardReadable {
    var keyboardWillChangePublisher: AnyPublisher<Bool, Never> { get }
    var keyboardDidChangePublisher: AnyPublisher<Bool, Never> { get }
    var keyboardHeight: AnyPublisher<CGFloat, Never> { get }
}

extension KeyboardReadable {
    public var keyboardWillChangePublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map {_ in true},
            
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
    
    public var keyboardDidChangePublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardDidShowNotification)
                .map { _ in true },
            
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardDidHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
    
    public var keyboardHeight: AnyPublisher<CGFloat, Never> {
        NotificationCenter
            .default
            .publisher(for: UIResponder.keyboardDidShowNotification)
            .map { notification in
                if let keyboardFrame: NSValue = notification
                    .userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardRectangle = keyboardFrame.cgRectValue
                    let keyboardHeight = keyboardRectangle.height
                    return keyboardHeight
                } else {
                    return 0
                }
            }
            .eraseToAnyPublisher()
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
