//
//  GameSceneDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 14/01/2025.
//
import SwiftUI
import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame) //设置物理边界
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8) //添加重力
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return } //从触摸事件集合中获取第一个触摸点。如果没有触摸事件发生，直接返回。
        let location = touch.location(in: self) //转换为相对于场景的坐标
        let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))//创建一个红色的矩形 SKSpriteNode
        box.position = location //将创建的盒子放置在用户触摸的位置
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50)) //给盒子添加一个矩形形状的物理体，这样它会参与物理模拟
        box.physicsBody?.friction = 0.5 //设置物理体的摩擦力
        box.physicsBody?.restitution = 0.8 //设置物理体的弹性(值越大，反弹越强）
        box.physicsBody?.applyImpulse(CGVector(dx: CGFloat.random(in: -5...5), dy: CGFloat.random(in: -5...5)))  // 应用随机冲击
        addChild(box) //将新创建的盒子节点添加到场景中
    }
}

struct GameSceneDemoView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 300, height: 400)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: 350, height: 500)
            .ignoresSafeArea()
    }
}
