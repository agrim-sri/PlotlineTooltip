//
//  ATArrowConstant.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 18/08/23.
//

import Foundation
import SwiftUI

struct FrameModifier: ViewModifier {
    
    @Binding var rect: CGRect
    
    init(_ rect: Binding<CGRect>) {
        _rect = rect
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear.preference(key: FramePreferenceKey.self, value: proxy.frame(in: .global))
                }
            )
            .onPreferenceChange(FramePreferenceKey.self) { preference in
                self.rect = preference
            }
    }
}

extension View {
    func takeFrame(_ rect: Binding<CGRect>) -> some View {
        self.modifier(FrameModifier(rect))
    }
}

struct FramePreferenceKey: PreferenceKey {
    typealias V = CGRect
    static var defaultValue: V = .zero
    static func reduce(value: inout V, nextValue: () -> V) {
        value = nextValue()
    }
}
