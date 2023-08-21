//
//  TooltipViewModel.swift
//  PlotlineTooltips
//
//  Created by user on 21/08/23.
//

import Foundation

extension TooltipData {
    
    func saveToUserDefaults() {
        
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(self) {
            UserDefaults.standard.set(encodedData, forKey: "TooltipData")
        }
        print("sent")
    }
    
    func loadFromUserDefaults() {

        let decoder = JSONDecoder()
        if let savedData = UserDefaults.standard.data(forKey: "TooltipData") {
            do {
                let loadedData = try decoder.decode(TooltipData.self, from: savedData)
                
                DispatchQueue.main.async {
                    // Assign values from loadedData to your published properties
                    self.currentButtonIndex = loadedData.currentButtonIndex
                    self.imageNames = loadedData.imageNames
                    self.tooltips = loadedData.tooltips
                    self.constants = loadedData.constants
                    self.alignmentIndexes = loadedData.alignmentIndexes
                    self.isPresented = loadedData.isPresented
                    self.textColors = loadedData.textColors
                    self.textSizes = loadedData.textSizes
                    self.textPaddings = loadedData.textPaddings
                }
                
            } catch {
                print("Failed to load data: \(error.localizedDescription)")
            }
        }
        
        print("Received")
    }
}

