//
//  ATArrowConstant.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 18/08/23.
//

import Foundation
import SwiftUI

public struct ATShadowConstant: Equatable, Codable {
    
    public var color: Color
    public var radius: CGFloat
    public var x: CGFloat
    public var y: CGFloat
    
    enum CodingKeys: String, CodingKey {
            case color
            case radius
            case x
            case y
        }
    
    
    public init(color: Color = .black.opacity(0.3),
                radius: CGFloat = 3,
                x: CGFloat = 0,
                y: CGFloat = 0) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }
    
    public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let colorComponents = try container.decode([CGFloat].self, forKey: .color)
            self.color = Color(red: Double(colorComponents[0]), green: Double(colorComponents[1]), blue: Double(colorComponents[2]), opacity: Double(colorComponents[3]))
            self.radius = try container.decode(CGFloat.self, forKey: .radius)
            self.x = try container.decode(CGFloat.self, forKey: .x)
            self.y = try container.decode(CGFloat.self, forKey: .y)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let uiColor = UIColor(self.color)
            let components = uiColor.cgColor.components ?? [1, 1, 1, 1]
            try container.encode([components[0], components[1], components[2], uiColor.cgColor.alpha], forKey: .color)
            try container.encode(radius, forKey: .radius)
            try container.encode(x, forKey: .x)
            try container.encode(y, forKey: .y)
        }
    
}
