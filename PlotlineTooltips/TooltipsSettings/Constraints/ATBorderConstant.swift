//
//  ATArrowConstant.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 18/08/23.
//

import Foundation
import SwiftUI

public struct ATBorderConstant: Equatable {
    
    public var radius: CGFloat
    public var lineWidth: CGFloat
    public var color: Color
    public var style: StrokeStyle?
    
    public init(radius: CGFloat = 10,
                lineWidth: CGFloat = 2,
                color: Color = .white.opacity(0.1),
                style: StrokeStyle? = nil) {
        self.radius = radius
        self.lineWidth = lineWidth
        self.color = color
        self.style = style
    }
}
