//
//  PieChartView.swift
//  CosmoCare
//
//  Created by Omid Shojaeian Zanjani on 13/06/23.
//

import SwiftUI

struct PieChartView: View {
    @Binding var slices: [(Double, Color)]
    @Binding var total:Int
    @Binding var gap:Double
    @Binding var extraRadius:Double
    @Binding var circleColor:UIColor
    
    var body: some View {
         Canvas { context, size in
             // for size of each pie declair ....
            let total = Double(total)//slices.reduce(0) { $0 + $1.0 }
            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
            var pieContext = context
             let circleContext = context
            pieContext.rotate(by: .degrees(-90))
            let radius = min(size.width, size.height) * 0.48
            let radiusForCircle = min(size.width, size.height) * 0.48 - CGFloat(extraRadius)
            let gapSize = Angle(degrees: gap) // size of the gap between slices in degrees
             let pathCircle = Path { p in
                 p.move(to: .zero)
                 p.addArc(center: .zero, radius: CGFloat(radiusForCircle), startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
                 
                 p.closeSubpath()
             }
             circleContext.fill(pathCircle, with: .color(Color(circleColor)))
            var startAngle = Angle.zero
            for (value, color) in slices {
                let angle = Angle(degrees: 360 * (value / total))
                let endAngle = startAngle + angle - gapSize
                let path = Path { p in
                    p.move(to: .zero)
                    p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    p.closeSubpath()
                }
                pieContext.fill(path, with: .color(color))
                startAngle = endAngle + gapSize
            }
        }
         .aspectRatio(1, contentMode: .fit)
         .clipped(antialiased: false)
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(slices: .constant([(1,.red)]), total: .constant(10), gap: .constant(Double(5)), extraRadius: .constant(0), circleColor: .constant(.green))
    }
}
