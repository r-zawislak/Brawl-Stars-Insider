//
//  View.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 03/03/2023.
//

import SwiftUI

extension View {
    func intenseShadow(color: Color, radius: CGFloat, intensity: Int) -> some View {
        var view = AnyView(self)
        let fixedRadius = radius / CGFloat(intensity)
        for _ in 0..<intensity {
            view = AnyView(view.shadow(color: color, radius: fixedRadius))
        }
        
        return view
    }
    
    func animationEnd<Value: VectorArithmetic>(of value: Value, onEnd: @escaping () -> Void) -> some View {
        self
            .modifier(EndAnimationModifier(value: value, onEndAnimation: onEnd))
    }
    
    // MARK: - Alignment
    
    func horizontalAlignment(_ alignment: HorizontalAlignment) -> some View {
        frame(maxWidth: .infinity, alignment: Alignment(horizontal: alignment, vertical: .center))
    }
    
    func verticalAlignment(_ alignment: VerticalAlignment) -> some View {
        frame(maxHeight: .infinity, alignment: Alignment(horizontal: .center, vertical: alignment))
    }
}

private struct EndAnimationModifier<Value: VectorArithmetic>: Animatable, ViewModifier {
    
    var animatableData: Value {
        didSet {
            checkIfFinished()
        }
    }
    
    let endValue: Value
    var onEndAnimation: () -> Void
    
    func body(content: Content) -> some View {
        content
    }
    
    init(value: Value, onEndAnimation: @escaping () -> Void) {
        animatableData = value
        endValue = value
        
        self.onEndAnimation = onEndAnimation
    }
    
    private func checkIfFinished() {
        guard animatableData == endValue else { return }
        
        DispatchQueue.main.async {
            onEndAnimation()
        }
    }
}

