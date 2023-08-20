//
//  TooltipDataModel.swift
//  PlotlineTooltips
//
//  Created by Ragven Mahto on 19/08/23.
//

import Foundation
import SwiftUI

class TooltipData: ObservableObject {
    
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
}
