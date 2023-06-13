//
//  UsingProgressView.swift
//  CosmoCare
//
//  Created by Omid Shojaeian Zanjani on 13/06/23.
//

import SwiftUI

struct UsingProgressView: View {
    @State var slices:[(Double,Color)] = []
    @State var total:Int = 10
    @State var gap:Double = 0
    @State var radious:Double = 0
    @State var color:UIColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    
    var body: some View {
        VStack{
            ZStack{
                var _ = print(radious)
                PieChartView(slices: $slices,
                             total: $total,
                             gap: $gap,
                             extraRadius: $radious, circleColor: $color)
                Image("Soggetto")
                    .resizable()
                    .frame(width: 50, height: 140)
            }
            .frame(width: 300, height: 300)
            .clipped(antialiased: false)
            Text("09:30")
                .padding()
            Text("Radious : \(radious)")
            Slider(value: $radious, in: -100...100) {
                               Text("Label")
                           } minimumValueLabel: {
                               Image(systemName: "tortoise")
                           } maximumValueLabel: {
                               Image(systemName: "hare")
                           } onEditingChanged: {
                               print("\($0)")
                           }
            Text("This Cosmetic help you to use it for having more moisturizing on your face ... ")
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width > 0 {
                                // right
                                let colors:[Color] = [.red, .yellow, .green, .black, .blue, .orange, .brown, .mint, .indigo]
                                if slices.count < total {
                                    slices.append((1, colors.randomElement()!))
                                }
                            } else if value.translation.width < 0 {
                                // Left
                                slices.removeLast()
                            }
                        }
                )
        }
    }
}
struct UsingProgressView_Previews: PreviewProvider {
    static var previews: some View {
        UsingProgressView()
    }
}
