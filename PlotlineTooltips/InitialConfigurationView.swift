//
//  InitialConfigurationView.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 19/08/23.
//

import SwiftUI


struct InitialConfigurationView: View {
    
    @ObservedObject var data: TooltipData
    
    @State private var currentButtonIndex: Int = 0
    //@State private var tooltips: [String] = Array(repeating: "Tooltip text goes here.", count: 5)
    //@State private var constants: [ATConstant] = Array(repeating: .init(border: ATBorderConstant(color: .pink)), count: 5)
    //@State private var alignmentIndexes: [Int] = Array(repeating: 0, count: 5)
    //let alignments: [Alignment] = [.center, .leading, .trailing, .top, .bottom, .topLeading, .topTrailing, .bottomLeading, .bottomTrailing]
    
    @ObservedObject var appState: AppState
    
    var body: some View {
        ScrollView{
            VStack {
                Menu("Target Button: \(currentButtonIndex + 1)") {
                    ForEach(0..<5) { index in
                        Button(action: {
                            currentButtonIndex = index
                        }) {
                            Text("Button \(index + 1)")
                        }
                    }
                }
                .padding()
                
                ConfigurationView(constant: $data.constants[currentButtonIndex],
                                  tooltipText: $data.tooltips[currentButtonIndex],
                                  alignmentIndex: $data.alignmentIndexes[currentButtonIndex],
                                  textColor: $data.textColors[currentButtonIndex],
                                  textSize: $data.textSizes[currentButtonIndex],
                                  textPadding: $data.textPaddings[currentButtonIndex],
                                  imageName: $data.imageNames[currentButtonIndex],
                                  alignments: data.alignments)
                
                Spacer()
                
                Button("Render Tooltip") {
                    appState.isTooltipViewActive = true
                    data.saveToUserDefaults()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                //            NavigationLink("Render Tooltip", destination: TooltipView(tooltips: tooltips, constants: constants, alignmentIndexes: alignmentIndexes))
                //                .padding()
                //                .background(Color.blue)
                //                .foregroundColor(.white)
                //                .cornerRadius(10)
                
            }
            .padding()
        }
    }
}
