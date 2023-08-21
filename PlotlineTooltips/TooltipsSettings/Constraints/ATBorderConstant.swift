//
//  ATArrowConstant.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 18/08/23.
//

import Foundation
import SwiftUI

public struct ATBorderConstant: Equatable, Codable {
    
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
    
    enum CodingKeys: String, CodingKey {
        case radius
        case lineWidth
        case color
        // If you decide to omit StrokeStyle, remove the following line
        // case style
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        radius = try container.decode(CGFloat.self, forKey: .radius)
        lineWidth = try container.decode(CGFloat.self, forKey: .lineWidth)
        
        let rgba = try container.decode([Double].self, forKey: .color)
        color = Color(red: rgba[0], green: rgba[1], blue: rgba[2], opacity: rgba[3])
        
        // Handle StrokeStyle if you decide to include it
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(radius, forKey: .radius)
        try container.encode(lineWidth, forKey: .lineWidth)
        
        if let rgbaColor = color.toRGBA() {
            try container.encode(rgbaColor, forKey: .color)
        }
        
        // Handle StrokeStyle if you decide to include it
    }
}

extension Color {
    func toRGBA() -> [Double]? {
        guard let components = self.cgColor?.components, components.count >= 3 else {
            return nil
        }
        let red = Double(components[0])
        let green = Double(components[1])
        let blue = Double(components[2])
        let alpha = Double(components.count > 3 ? components[3] : 1)
        
        return [red, green, blue, alpha]
    }
    
}
