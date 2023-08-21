//
//  ATArrowConstant.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 18/08/23.
//

import Foundation
import SwiftUI

public struct ATArrowConstant: Equatable, Codable {
    
    public var width: CGFloat
    public var height: CGFloat
    
    public init(width: CGFloat = 10, height: CGFloat = 10) {
        self.width = width
        self.height = height
    }
}
