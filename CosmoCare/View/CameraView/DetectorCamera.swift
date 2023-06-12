//
//  DetectorCamera.swift
//  CosmoCare
//
//  Created by Omid Shojaeian Zanjani on 10/06/23.
//

import SwiftUI

struct DetectorCamera: View {
    @StateObject private var modelViewCamera = ViewModelNew()
    
    var body: some View {
        ZStack {
            FrameView(image: modelViewCamera.frame)
                .edgesIgnoringSafeArea(.all)
            CameraControler()
        }
    }
}

struct DetectorCamera_Previews: PreviewProvider {
    static var previews: some View {
        DetectorCamera()
    }
}
