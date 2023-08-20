//
//  ConfigurationView.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 19/08/23.
//

import Foundation
import SwiftUI

struct ConfigurationView: View {
    @Binding var constant: ATConstant
    @Binding var tooltipText: String
    @Binding var alignmentIndex: Int
    @Binding var textColor: Color
    @Binding var textSize: CGFloat
    @Binding var textPadding: CGFloat
    
    @Binding var imageName: String
    
    let alignments: [Alignment]
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                // Tooltip Text
                VStack(alignment: .leading) {
                    Text("Tooltip Text").foregroundColor(Color.black).opacity(1)
                    TextField("Enter tooltip text", text: $tooltipText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("Tooltip Image").foregroundColor(Color.black).opacity(1)
                    TextField("Image Name", text: $imageName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)

                }
                
                // Text Size and Slider
                HStack{
                    VStack(alignment: .leading) {
                        Text("Text Size: \(textSize, specifier: "%.0f")")
                        TextField("0.0", value: $textSize, formatter: NumberFormatter())
                            .frame(width: .none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    
                    VStack {
                        Text("Text Padding: \(textPadding, specifier: "%.0f")")
                        TextField("0.0", value: $textPadding, formatter: NumberFormatter())
                            .frame(width: .none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        //                    Slider(value: $textPadding, in: 0...30)
                    }
                }
                
                
                ColorPicker("Text Color", selection: $textColor)
                
                ColorPicker("Border Color", selection: $constant.border.color)
                
                // Border
                VStack(alignment: .leading) {
                    
                    HStack {
                        VStack(alignment: .leading){
                            Text("Corner Radius:")
                            TextField("0.0", value: $constant.border.radius, formatter: NumberFormatter()).frame(width:.none).textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                        VStack(alignment:.leading){
                            Text("Tooltip Width:")
                            TextField("0.0", value: $constant.border.lineWidth, formatter: NumberFormatter()).frame(width:.none).textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                        
                    }
                }
                
                // Arrow Configuration
                
                HStack {
                    VStack(alignment: .leading){
                        Text("Arrow Width")
                        TextField("0.0", value: $constant.arrow.width, formatter: NumberFormatter()).frame(width:.none).textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    VStack(alignment: .leading){
                        Text("Arrow Height")
                        TextField("0.0", value: $constant.arrow.height, formatter: NumberFormatter()).frame(width:.none).textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    
                }
                
                // Distance Configuration
                VStack(alignment: .leading) {
                    Text("Distance").opacity(1)
                    TextField("0.0", value: $constant.distance, formatter: NumberFormatter()).textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Axis Mode Configuration
                VStack(alignment: .leading) {
                    Text("AxisMode").opacity(1)
                    Picker("", selection: $constant.axisMode) {
                        Text("Top").tag(ATAxisMode.top)
                        Text("Bottom").tag(ATAxisMode.bottom)
                        Text("Leading").tag(ATAxisMode.leading)
                        Text("Trailing").tag(ATAxisMode.trailing)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Alignment Picker
                VStack(alignment: .leading){
                    Text("Button's Alignment")
                    Picker("", selection: $alignmentIndex) {
                        ForEach(Array(alignments.enumerated()), id:\.offset) { index, align in
                            Image(systemName: getAlignmentIcon(alignments[index])).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                }
                                
            }
            .padding()
            .font(.callout)
            .animation(.easeInOut, value: constant)
            .animation(.easeInOut, value: alignmentIndex)
            
            Spacer()
        }
    }
    
    private func getAlignmentIcon(_ alignment: Alignment) -> String {
        switch alignment {
        case .center: return "rectangle.center.inset.filled"
        case .leading: return "rectangle.leftthird.inset.filled"
        case .trailing: return "rectangle.rightthird.inset.filled"
        case .top: return "rectangle.topthird.inset.filled"
        case .bottom: return "rectangle.bottomthird.inset.filled"
        case .topLeading: return "rectangle.inset.topleft.filled"
        case .topTrailing: return "rectangle.inset.topright.filled"
        case .bottomLeading: return "rectangle.inset.bottomleft.filled"
        case .bottomTrailing: return "rectangle.inset.bottomright.filled"
        default: return ""
        }
    }
    
}


struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView(
            constant: .constant(ATConstant()),
            tooltipText: .constant("Sample Tooltip Text"),
            alignmentIndex: .constant(0),
            textColor: .constant(.black),
            textSize: .constant(4),
            textPadding: .constant(5),
            imageName: .constant("Plotline"),
            alignments: [.center, .leading, .trailing, .top, .bottom, .topLeading, .topTrailing, .bottomLeading, .bottomTrailing]
        )
    }
}
