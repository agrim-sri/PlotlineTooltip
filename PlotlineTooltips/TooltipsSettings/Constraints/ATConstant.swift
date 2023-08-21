//
//  ATArrowConstant.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 18/08/23.
//

import Foundation
import SwiftUI

public enum ATAxisMode: Equatable, Codable {
    case top
    case bottom
    case leading
    case trailing
}

public struct ATConstant: Equatable, Codable {
    
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
    
    enum CodingKeys: String, CodingKey {
            case axisMode
            case border
            case arrow
            case shadow
            case distance
            // If you decide to represent Animation, add its key here
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            axisMode = try container.decode(ATAxisMode.self, forKey: .axisMode)
            border = try container.decode(ATBorderConstant.self, forKey: .border)
            arrow = try container.decode(ATArrowConstant.self, forKey: .arrow)
            shadow = try container.decode(ATShadowConstant.self, forKey: .shadow)
            distance = try container.decode(CGFloat.self, forKey: .distance)
            // Decoding Animation if you represent it
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(axisMode, forKey: .axisMode)
            try container.encode(border, forKey: .border)
            try container.encode(arrow, forKey: .arrow)
            try container.encode(shadow, forKey: .shadow)
            try container.encode(distance, forKey: .distance)
            // Encoding Animation if you represent it
        }
}
