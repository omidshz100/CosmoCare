//
//  LoadingAnimation.swift
//  CosmoCare
//
//  Created by Omid Shojaeian Zanjani on 12/06/23.
//

import SwiftUI

struct LoadingAnimation: View {
    @State var isAnimating:Bool = false
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.6)
            .stroke(AngularGradient(colors: [.blue, .green], center: .center), style: StrokeStyle(lineWidth: 8, lineCap: .round, dash: [0.1,16], dashPhase: 8))
            .frame(width: 48, height: 48)
            .rotationEffect(Angle(degrees: isAnimating ? 360:0))
            .onAppear(){
                withAnimation(Animation.linear(duration: 1)
                                    .repeatForever(autoreverses: false)){
                                    isAnimating.toggle()
                }
            }
                
    }
}

struct LoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimation()
    }
}
