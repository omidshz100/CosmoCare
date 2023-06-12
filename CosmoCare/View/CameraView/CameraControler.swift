//
//  CameraControler.swift
//  CosmoCare
//
//  Created by Omid Shojaeian Zanjani on 10/06/23.
//

import SwiftUI

struct CameraControler: View {
    
    var body: some View {
        VStack{
            Spacer()
            IphoneCaptureImageBtn()
        }
    }
}

struct IphoneCaptureImageBtn:View{
    var body: some View {
        Button(action: {
                    // Add your button action here
            //CameraManager.shared.capturePhoto()
                }) {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                                .frame(width: 100, height: 100)
                        )
                }
                .shadow(radius: 5)
    }
}
struct CameraControler_Previews: PreviewProvider {
    static var previews: some View {
        CameraControler()
    }
}
