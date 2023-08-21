//
//  ATArrowConstant.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 18/08/23.
//

import Foundation
import SwiftUI

public extension View {
    
    func tooltip<F: View>(isPresented: Binding<Bool>,
                     alignment: Alignment = .center,
                     constant: ATConstant = .init(),
                     @ViewBuilder foreground: @escaping () -> F) -> some View {
        self.modifier(AxisTooltip(isPresented: isPresented,
                                          alignment: alignment,
                                          constant: constant,
                                          foreground: foreground))
    }
    
    func toolTip<B: View, F: View>(isPresented: Binding<Bool>,
                     alignment: Alignment = .center,
                     constant: ATConstant = .init(),
                     @ViewBuilder background: @escaping () -> B,
                     @ViewBuilder foreground: @escaping () -> F) -> some View {
        self.modifier(AxisTooltip(isPresented: isPresented,
                                          alignment: alignment,
                                          constant: constant,
                                          background: background,
                                          foreground: foreground))
    }
}
