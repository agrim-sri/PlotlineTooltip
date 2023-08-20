//
//  ATArrowConstant.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 18/08/23.
//

import Foundation
import SwiftUI

public enum ATAxisMode: Equatable {
    case top
    case bottom
    case leading
    case trailing
}

public struct ATConstant: Equatable {
    
    public var axisMode: ATAxisMode
    public var border: ATBorderConstant
    public var arrow: ATArrowConstant
    public var shadow: ATShadowConstant
    public var distance: CGFloat
    public var animation: Animation?
    
    
    public init(axisMode: ATAxisMode = .bottom,
                border: ATBorderConstant = .init(),
                arrow: ATArrowConstant = .init(),
                shadow: ATShadowConstant = .init(),
                distance: CGFloat = 8,
                animation: Animation? = .easeInOut(duration: 0.28)) {
        self.axisMode = axisMode
        self.border = border
        self.arrow = arrow
        self.shadow = shadow
        self.distance = distance
        self.animation = animation
    }
}
