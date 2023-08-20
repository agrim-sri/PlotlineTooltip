//
//  ATArrowConstant.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 18/08/23.
//

import Foundation
import SwiftUI

public struct ATShadowConstant: Equatable {
    
    public var color: Color
    public var radius: CGFloat
    public var x: CGFloat
    public var y: CGFloat
    
    
    public init(color: Color = .black.opacity(0.3),
                radius: CGFloat = 3,
                x: CGFloat = 0,
                y: CGFloat = 0) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }
}
