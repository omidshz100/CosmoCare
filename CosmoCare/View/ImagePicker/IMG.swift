//
//  IMG.swift
//  CosmoCare
//
//  Created by Omid Shojaeian Zanjani on 11/06/23.
//

import SwiftUI

struct IMG: View {

    @State var showImagePicker: Bool = false
    @State var image: Image? = nil

    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    self.showImagePicker.toggle()
                }) {
                    Text("Show image picker")
                }
                image?.resizable().frame(width: 100, height: 100)
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    self.image = Image(uiImage: image)
                }
            }
        }
    }
}
