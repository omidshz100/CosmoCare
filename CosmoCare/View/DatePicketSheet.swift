//
//  DatePicketSheet.swift
//  CosmoCare
//
//  Created by Omid Shojaeian Zanjani on 10/06/23.
//

import SwiftUI

struct DatePicketSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var date:Date
    @Binding var isShowing:Bool
    var body: some View {
        NavigationView {
            VStack{
                DatePicker("Due date ", selection: $date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                Spacer()
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        //isShowing.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Text("Done")
                    }
                }
            }
        }
    }
}

struct DatePicketSheet_Previews: PreviewProvider {
    static var previews: some View {
        DatePicketSheet(date: .constant(Date()), isShowing: .constant(true))
    }
}
