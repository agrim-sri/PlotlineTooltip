//
//  TooltipView.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 19/08/23.
//

import SwiftUI

struct TooltipView: View {
    
    @ObservedObject var data: TooltipData
    
    //    @State private var alignmentIndexes: [Int] = [5, 6, 7, 8, 0]
    
    let alignments: [Alignment] = [.center, .leading, .trailing, .top, .bottom, .topLeading, .topTrailing, .bottomLeading, .bottomTrailing]
    
    @State private var showConfiguration = false
    @State private var selectedButtonIndex: Int? = nil
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            ZStack {
                Color.gray.edgesIgnoringSafeArea(.all)
                ForEach(0..<5) { index in
                    Button(action: {
                        data.isPresented[index].toggle()
                    }) {
                        Text("Button \(index + 1)")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .axisToolTip(isPresented: $data.isPresented[index], alignment: alignments[data.alignmentIndexes[index]], constant: data.constants[index], foreground: {
                        HStack {
                            Image(data.imageNames[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Label(data.tooltips[index], systemImage: "heart")
                        }
                        .frame(width: 200)
                        .padding(data.textPaddings[index])
                        .font(Font.system(size: data.textSizes[index]))
                        .foregroundColor(data.textColors[index])
                        .background(Color.black)
                    })
                    .contextMenu {
                        Button(action: {
                            selectedButtonIndex = index
                            showConfiguration = true
                        }) {
                            Text("Configure Tooltip")
                            Image(systemName: "gear")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showConfiguration, content: {
            ConfigurationView(constant: $data.constants[selectedButtonIndex ?? 0],
                              tooltipText: $data.tooltips[selectedButtonIndex ?? 0],
                              alignmentIndex: $data.alignmentIndexes[selectedButtonIndex ?? 0],
                              textColor: $data.textColors[selectedButtonIndex ?? 0],
                              textSize: $data.textSizes[selectedButtonIndex ?? 0],
                              textPadding: $data.textPaddings[selectedButtonIndex ?? 0],
                              imageName: $data.imageNames[selectedButtonIndex ?? 0],
                              alignments: alignments)
        })
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Text(""))
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TooltipView(data: TooltipData()).preferredColorScheme(.light)
    }
}
