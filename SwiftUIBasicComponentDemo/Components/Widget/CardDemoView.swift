//
//  CardDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 16/12/2024.
//
import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    let isStar: Bool
    var isFlipped: Bool = false
    var isMatched: Bool = false
}

struct CardView: View {
    let card: Card
    
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            if card.isFlipped {
                RoundedRectangle(cornerRadius: 10)
                    .fill(card.isStar ? Color.yellow : Color.gray)
                    .overlay(
                        Group {
                            if card.isStar {
                                Image(systemName: "star.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            } else {
                                Image("a-nanguo")
                            }
                        }
                    )
            }else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
            }
        }
        .frame(width: 100, height: 150)
        .rotation3DEffect(.degrees(card.isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0),perspective: 0.5)
        .animation(.easeInOut(duration: 0.3), value: card.isFlipped)
    }
}

struct CardDemoView:View {
    @State private var cards: [Card] = []
    @State private var selectedIndices: [Int] = []
    @State private var message: String? = nil
    
    var body: some View {
        VStack {
            Text(message ?? "找到两张星星卡片")
                .font(.title)
                .foregroundColor(message == "你赢了！" ? .green : .primary)
                .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                ForEach(cards.indices, id: \.self) { index in
                    CardView(card: cards[index])
                        .onTapGesture {
                            flipCard(at: index)
                        }
                        .disabled(cards[index].isFlipped || selectedIndices.count >= 2 || cards[index].isMatched)
                        .padding(10)
                }
            }
        }
        .onAppear(perform: resetGame)
    }
    
    private func flipCard(at index: Int) {
        guard selectedIndices.count < 2 else { return }
        
        cards[index].isFlipped = true
        selectedIndices.append(index)
        
        if selectedIndices.count == 2 {
            checkMatch()
        }
    }
    
    private func checkMatch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let firstIndex = selectedIndices[0]
            let secondIndex = selectedIndices[1]
            
            if cards[firstIndex].isStar && cards[secondIndex].isStar {
                cards[firstIndex].isMatched = true
                cards[secondIndex].isMatched = true
                message = "你赢了！"
            } else {
                cards[firstIndex].isFlipped = false
                cards[secondIndex].isFlipped = false
                if cards[firstIndex].isStar || cards[secondIndex].isStar {
                    message = "未匹配成功，再试一次！"
                }
            }
            selectedIndices.removeAll()
            
            // 如果不是获胜状态，判断是否需要显示所有卡片
            if message != "你赢了！" {
                if cards.filter({ !$0.isMatched }).allSatisfy({ !$0.isFlipped }) {
                    revealAllCards()
                }
            }
        }
    }
    
    private func revealAllCards() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            cards.indices.forEach { index in
                cards[index].isFlipped = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                resetGame()
            }
        }
    }
    
    private func resetGame() {
        let starIndices = (0..<6).shuffled().prefix(2)
        cards = (0..<6).map { index in
            Card(isStar: starIndices.contains(index))
        }
        selectedIndices.removeAll()
        message = nil
    }
}
