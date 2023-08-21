//
//  TooltipDataModel.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 19/08/23.
//

import Foundation
import SwiftUI

class TooltipData: ObservableObject, Codable {
    
    @Published var currentButtonIndex: Int = 0
    @Published var imageNames: [String] = Array(repeating: "Plotline", count: 5)
    @Published var tooltips: [String] = Array(repeating: "Tooltip text goes here.", count: 5)
    @Published var constants: [ATConstant] = Array(repeating: .init(border: ATBorderConstant(color: .pink)), count: 5)
    @Published var alignmentIndexes: [Int] = [5, 6, 7, 8, 0]
    @Published var isPresented: [Bool] = Array(repeating: false, count: 5)
    @Published var textColors: [Color] = Array(repeating: Color.white, count: 5)
    @Published var textSizes: [CGFloat] = Array(repeating: 16.0, count: 5)
    @Published var textPaddings: [CGFloat] = Array(repeating: 8.0, count: 5)
    
    
    let alignments: [Alignment] = [.center, .leading, .trailing, .top, .bottom, .topLeading, .topTrailing, .bottomLeading, .bottomTrailing]
    
    init() {
        // All properties are already provided default values, so the initializer body can be empty
        self.loadFromUserDefaults()
    }
    
    enum CodingKeys: String, CodingKey {
        case currentButtonIndex, imageNames, tooltips, constants, alignmentIndexes, isPresented, textColors, textSizes, textPaddings
    }
    
    struct RGBAColor: Codable {
        var red: CGFloat
        var green: CGFloat
        var blue: CGFloat
        var opacity: CGFloat
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        currentButtonIndex = try container.decode(Int.self, forKey: .currentButtonIndex)
        imageNames = try container.decode([String].self, forKey: .imageNames)
        tooltips = try container.decode([String].self, forKey: .tooltips)
        constants = try container.decode([ATConstant].self, forKey: .constants)
        alignmentIndexes = try container.decode([Int].self, forKey: .alignmentIndexes)
        isPresented = try container.decode([Bool].self, forKey: .isPresented)
        
        // Decode Color
        let colorComponents = try container.decode([RGBAColor].self, forKey: .textColors)
        textColors = colorComponents.map { Color(rgbaComponents: ($0.red, $0.green, $0.blue, $0.opacity)) }
        
        //textColors = colorComponents.map { Color(rgbaComponents: $0) }
        
        textSizes = try container.decode([CGFloat].self, forKey: .textSizes)
        textPaddings = try container.decode([CGFloat].self, forKey: .textPaddings)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(currentButtonIndex, forKey: .currentButtonIndex)
        try container.encode(imageNames, forKey: .imageNames)
        try container.encode(tooltips, forKey: .tooltips)
        try container.encode(constants, forKey: .constants)
        try container.encode(alignmentIndexes, forKey: .alignmentIndexes)
        try container.encode(isPresented, forKey: .isPresented)
        
        // Encode Color
        let colorComponents = textColors.compactMap { color -> RGBAColor? in
            if let components = color.rgbaComponents {
                return RGBAColor(red: components.red, green: components.green, blue: components.blue, opacity: components.opacity)
            }
            return nil
        }
        try container.encode(colorComponents, forKey: .textColors)
        
        
        try container.encode(textSizes, forKey: .textSizes)
        try container.encode(textPaddings, forKey: .textPaddings)
    }
}


extension Color {
    var rgbaComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat)? {
        guard let components = UIColor(self).cgColor.components else { return nil }
        return (components[0], components[1], components[2], components[3])
    }
    
    init(rgbaComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat)) {
        self.init(red: Double(rgbaComponents.red), green: Double(rgbaComponents.green), blue: Double(rgbaComponents.blue), opacity: Double(rgbaComponents.opacity))
    }
    
    
}

extension Alignment {
    var stringValue: String {
        switch self {
        case .center: return "center"
        case .leading: return "leading"
            // ... Handle other cases ...
        default: return "unknown"
        }
    }
    
    init?(fromString value: String) {
        switch value {
        case "center": self = .center
        case "leading": self = .leading
            // ... Handle other cases ...
        default: return nil
        }
    }
}

