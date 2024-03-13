//
//  ContentView.swift
//  SliderSwiftUI
//
//  Created by Александр Соколов on 12.03.2024.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var alertIsVisible = false
    @State private var sliderValue = Double.random(in: 0...100)
    //let targetValue = Int.random(in: 0...100)
    @State private var targetValue = Int.random(in: 0...100)
    
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(sliderValue))
        return 100 - difference
    }

    var body: some View {
        VStack {
            Text("Подвинь слайдер, как можно ближе к: \(targetValue)")
            HStack {
                Slider(value: $sliderValue, in: 0...100)
                    .opacity(computeScore() != 0 ? 1.0 : 0.0)
                if computeScore() == 0 {
                    UIKitSlider()
                }
            }
            Button("Проверь меня") {
                alertIsVisible = true
            }
            .alert(isPresented: $alertIsVisible) {
                 Alert(title: Text("Результат"),
                       message: Text("Вы заработали \(computeScore()) баллов"),
                       dismissButton: .default(Text("OK")))
            }
            Button("Начать заново") {
                targetValue = Int.random(in: 0...100)
                sliderValue = Double.random(in: 0...100)
            }
        }
        .padding()
    }
}

struct UIKitSlider: UIViewRepresentable {
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.value = 100
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = 100
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



