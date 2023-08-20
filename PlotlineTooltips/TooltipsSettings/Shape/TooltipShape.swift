//
//  ATArrowConstant.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 18/08/23.
//
import Foundation
import SwiftUI

struct TooltipShape: InsettableShape {

    let axisMode: ATAxisMode
    let cornerRadius: CGFloat
    let arrowWidth: CGFloat
    let arrowHeight: CGFloat
    
    var arrowPosition: CGFloat
    var amount: CGFloat = 0
    
    var animatableData: CGFloat {
        get { arrowPosition }
        set {
            arrowPosition = newValue
        }
    }

    func path(in rect: CGRect) -> Path {
        switch axisMode {
        case .top:          return arrowBottom(rect.size)
        case .bottom:       return arrowTop(rect.size)
        case .leading:      return arrowTrailing(rect.size)
        case .trailing:     return arrowLeading(rect.size)
        }
    }
    
    private func arrowTop(_ size: CGSize) -> Path {
        var path = Path()

        let x = limitX(size.width)
        path.move(to: CGPoint(x: x - arrowWidth , y: 0))
        path.addLine(to: CGPoint(x: x , y: -arrowHeight))
        path.addLine(to: CGPoint(x: x + arrowWidth , y: 0))
        path.addArc(center: CGPoint(x: size.width - cornerRadius + amount, y: cornerRadius + amount),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        path.addArc(center: CGPoint(x: size.width - cornerRadius + amount, y: size.height - cornerRadius + amount),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)

        path.addArc(center: CGPoint(x: cornerRadius + amount, y: size.height - cornerRadius + amount),
                    radius: cornerRadius, startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)
        
        path.addArc(center: CGPoint(x: cornerRadius + amount, y: cornerRadius + amount),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)
        
        path.closeSubpath()
        return path
    }
    
    private func arrowBottom(_ size: CGSize) -> Path {
        var path = Path()

        let x = limitX(size.width)

        path.move(to: CGPoint(x: cornerRadius , y: 0))
        path.addArc(center: CGPoint(x: size.width - cornerRadius + amount, y: cornerRadius + amount),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        path.addArc(center: CGPoint(x: size.width - cornerRadius + amount, y: size.height - cornerRadius + amount),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
        path.addLine(to: CGPoint(x: x + arrowWidth , y: size.height))
        path.addLine(to: CGPoint(x: x, y: size.height + arrowHeight))
        path.addLine(to: CGPoint(x: x - arrowWidth , y: size.height))
        path.addArc(center: CGPoint(x: cornerRadius + amount, y: size.height - cornerRadius + amount),
                    radius: cornerRadius, startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)
        path.addArc(center: CGPoint(x: cornerRadius + amount, y: cornerRadius + amount),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)
        path.closeSubpath()
        return path
    }
    
    private func arrowLeading(_ size: CGSize) -> Path {
        var path = Path()

        let y = limitY(size.height)

        path.move(to: CGPoint(x: cornerRadius , y: 0))
        path.addArc(center: CGPoint(x: size.width - cornerRadius + amount, y: cornerRadius + amount),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        path.addArc(center: CGPoint(x: size.width - cornerRadius + amount, y: size.height - cornerRadius + amount),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
        path.addArc(center: CGPoint(x: cornerRadius + amount, y: size.height - cornerRadius + amount),
                    radius: cornerRadius, startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)
        path.addLine(to: CGPoint(x: 0 , y: y + arrowWidth))
        path.addLine(to: CGPoint(x: 0 - arrowHeight, y: y))
        path.addLine(to: CGPoint(x: 0 , y: y - arrowWidth))
        path.addArc(center: CGPoint(x: cornerRadius + amount, y: cornerRadius + amount),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)
        path.closeSubpath()
        return path
    }
    
    private func arrowTrailing(_ size: CGSize) -> Path {
        var path = Path()

        let y = limitY(size.height)

        path.move(to: CGPoint(x: cornerRadius , y: 0))
        path.addArc(center: CGPoint(x: size.width - cornerRadius + amount, y: cornerRadius + amount),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        path.addLine(to: CGPoint(x: size.width , y: y - arrowWidth))
        path.addLine(to: CGPoint(x: size.width + arrowHeight, y: y))
        path.addLine(to: CGPoint(x: size.width , y: y + arrowWidth))
        path.addArc(center: CGPoint(x: size.width - cornerRadius + amount, y: size.height - cornerRadius + amount),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
        path.addArc(center: CGPoint(x: cornerRadius + amount, y: size.height - cornerRadius + amount),
                    radius: cornerRadius, startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)
        path.addArc(center: CGPoint(x: cornerRadius + amount, y: cornerRadius + amount),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)
        path.closeSubpath()
        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.amount += amount
        return shape
    }
    
    private func limitX(_ w: CGFloat) -> CGFloat {
        var x = arrowPosition
        let cornerArrowWidth = cornerRadius + arrowWidth
        if arrowPosition >= (w - cornerArrowWidth) {
            x = w - cornerArrowWidth
        }else if arrowPosition <= cornerArrowWidth {
            x = cornerArrowWidth
        }
        return x
    }
    
    private func limitY(_ h: CGFloat) -> CGFloat {
        var y = arrowPosition
        let cornerArrowWidth = cornerRadius + arrowWidth
        if arrowPosition >= (h - cornerArrowWidth) {
            y = h - cornerArrowWidth
        }else if arrowPosition <= cornerArrowWidth {
            y = cornerArrowWidth
        }
        return y
    }

}

struct TooltipShape_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TooltipShape(axisMode: .leading, cornerRadius: 30, arrowWidth: 20, arrowHeight: 20, arrowPosition: 120)
                .stroke()
                .font(.callout)
                .padding()
                .frame(width: 200)
            Spacer()
            TooltipShape(axisMode: .trailing, cornerRadius: 60, arrowWidth: 20, arrowHeight: 20, arrowPosition: 0)
                .stroke()
                .fill(Color.blue)
                .frame(width: 260, height: 260)
        }
    }
}
