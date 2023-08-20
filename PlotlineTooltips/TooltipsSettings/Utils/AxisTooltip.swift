//
//  ATArrowConstant.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 18/08/23.
//

import SwiftUI

public struct AxisTooltip<B, F>: ViewModifier where B: View, F: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @State private var parentRect: CGRect = .zero
    @State private var targetRect: CGRect = .zero
    @State private var tooltipRect: CGRect = .zero
    

    @Binding var isPresented: Bool
    

    public var alignment: Alignment
    
    public var constant: ATConstant
    
    public var background: (() -> B)? = nil
    
    public var foreground: () -> F
    
    public func body(content: Content) -> some View {
        GeometryReader { parentProxy in
            ZStack(alignment: alignment) {
                Color.clear
                    .takeFrame($parentRect)
                content
                    .takeFrame($targetRect)
                    .overlay(
                        GeometryReader { proxy in
                            ZStack {
                                if isPresented {
                                    foreground()
                                        .fixedSize()
                                        .takeFrame($tooltipRect)
                                        .background(backgroundView)
                                        .overlay(
                                            ZStack {
                                                if let style = constant.border.style {
                                                    shape()
                                                        .stroke(style: style)
                                                        .fill(constant.border.color)
                                                }else {
                                                    shape()
                                                        .stroke(constant.border.color, lineWidth: constant.border.lineWidth)
                                                }
                                            }
                                        )
                                        .clipShape(shape())
                                        .offset(position())
                                        .animation(.none, value: isPresented)
                                        .shadow(color: constant.shadow.color,
                                                radius: constant.shadow.radius,
                                                x: constant.shadow.x,
                                                y: constant.shadow.y)
                                }
                            }
                            .opacity(isPresented ? 1 : 0)
                            .blur(radius: isPresented ? 0 : 3)
                            .animation(constant.animation ?? .none , value: isPresented)
                        }
                    )
            }
        }
    }
    
    //MARK: - Properties
    private var backgroundView: some View {
        ZStack {
            if let background = background {
                background()
            }else {
                if #available(iOS 15.0, *) {
                    if #available(macOS 12.0, *) {
                        Rectangle()
                            .fill(colorScheme == .dark ? Color.black.opacity(0.015) : Color.black.opacity(0.015))
                            .background(.ultraThinMaterial)
                    } else {
                        Rectangle()
                            .fill(colorScheme == .dark ? Color.white.opacity(0.06) : Color.black.opacity(0.06))
                    }
                } else {
                    Rectangle()
                        .fill(colorScheme == .dark ? Color.white.opacity(0.06) : Color.black.opacity(0.06))
                }
            }
        }
        .frame(width: tooltipRect.width + constant.arrow.height * 2, height: tooltipRect.height + constant.arrow.height * 2)
    }
    
    private func shape() -> some Shape {
        TooltipShape(axisMode: constant.axisMode,
                     cornerRadius: constant.border.radius,
                     arrowWidth: constant.arrow.width,
                     arrowHeight: constant.arrow.height,
                     arrowPosition: arrowPosition())
    }
    
    private func arrowPosition() -> CGFloat {
        switch constant.axisMode {
        case .top, .bottom:
            var value = tooltipRect.width * 0.5
            if Int(targetRect.midX) < Int(tooltipRect.midX) {
                value = (targetRect.origin.x - parentRect.origin.x) + targetRect.width * 0.5
            }else if Int(targetRect.midX) > Int(tooltipRect.midX) {
                value = (tooltipRect.width - targetRect.width) + targetRect.width * 0.5
            }
            return value
        case .leading, .trailing:
            var value = tooltipRect.height * 0.5
            if Int(targetRect.midY) < Int(tooltipRect.midY) {
                value = (targetRect.origin.y - parentRect.origin.y) + targetRect.height * 0.5
            }else if Int(targetRect.midY) > Int(tooltipRect.midY) {
                value = (tooltipRect.height - targetRect.height) + targetRect.height * 0.5
            }
            return value
        }
    }
    
    private func position() -> CGSize {
        switch constant.axisMode {
        case .top, .bottom:
            var value: CGFloat = -tooltipRect.width * 0.5 + targetRect.width * 0.5
            let target = (targetRect.origin.x - parentRect.origin.x + targetRect.width)
            let padding = parentRect.width - target
            let margin = (tooltipRect.width - targetRect.width) * 0.5
            
            if (targetRect.origin.x - parentRect.origin.x) < margin {
                value = -(targetRect.origin.x - parentRect.origin.x)
            } else if padding < margin {
                value = targetRect.width + padding - tooltipRect.width
            }
            return CGSize(width: value,
                          height: constant.axisMode == .bottom ? targetRect.height + constant.distance + constant.arrow.height : -(tooltipRect.height + constant.distance + constant.arrow.height))
        case .leading, .trailing:
            var value: CGFloat = -tooltipRect.height * 0.5 + targetRect.height * 0.5
            let target = (targetRect.origin.y - parentRect.origin.y + targetRect.height)
            let padding = parentRect.height - target
            let margin = (tooltipRect.height - targetRect.height) * 0.5
            
            if (targetRect.origin.y - parentRect.origin.y) < margin {
                value = -(targetRect.origin.y - parentRect.origin.y)
            } else if padding < margin {
                value = targetRect.height + padding - tooltipRect.height
            }
            return CGSize(width: constant.axisMode == .trailing ? targetRect.width + constant.distance + constant.arrow.height : -(tooltipRect.width + constant.distance + constant.arrow.height),
                          height: value)
        }
    }
}

public extension AxisTooltip where B == EmptyView, F : View {
    
    init(isPresented: Binding<Bool>,
         alignment: Alignment = .center,
         constant: ATConstant = .init(),
         @ViewBuilder foreground: @escaping () -> F) {
        _isPresented = isPresented
        self.alignment = alignment
        self.constant = constant
        self.foreground = foreground
    }
}

public extension AxisTooltip where B : View, F : View {
    
    init(isPresented: Binding<Bool>,
         alignment: Alignment = .center,
         constant: ATConstant = .init(),
         @ViewBuilder background: @escaping () -> B,
         @ViewBuilder foreground: @escaping () -> F) {
        _isPresented = isPresented
        self.alignment = alignment
        self.constant = constant
        self.background = background
        self.foreground = foreground
    }
}

struct AxisTooltip_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello!")
                .font(.largeTitle)
                .padding()
                .background(Color.purple)
                .modifier(AxisTooltip(isPresented: .constant(true), alignment: .trailing,
                                      constant: .init(axisMode: .bottom),
                                      foreground: {
                    Text("Tooltipfwefewefefew")
                        .padding()
                        .frame(height: 200)
                    
                }))
        }
        .padding()
        .preferredColorScheme(.light)
    }
}
