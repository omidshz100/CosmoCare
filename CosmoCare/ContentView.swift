//
//  ContentView.swift
//  CosmoCare
//
//  Created by Omid Shojaeian Zanjani on 10/06/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    @ObservedObject var viewModel:MainViewModel = MainViewModel()
    private var sizeDateItem:CGFloat = 20.0
    
        var body: some View {
            NavigationView {
                VStack{
                    HStack{
                        Text("Evering Routing")
                        Image("ic-moon")
                    }
                    HStack{
                        Spacer()
                            ForEach(viewModel.weekDaysGenerator(date: Date())){ date in
                                    if date.component.day! == Date().component.day{
                                        VStack{
                                            Text("\((date.component.getDayName ?? "").firstLetter)")
                                                .foregroundColor(Color("color-text-dateItem"))
                                        Text("\(date.component.day ?? 0)")
                                                .foregroundColor(Color("color-text-dateItem"))
                                    }
                                    .padding()
                                    }else{
                                        VStack{
                                            Text("\((date.component.getDayName ?? "").firstLetter)")
                                                .foregroundColor(Color("color-text"))
                                        Text("\(date.component.day ?? 0)")
                                    }
                                    .padding()
                                }
                            }
                        Spacer()
                    }
                }
                .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
                .toolbar {
                    ToolbarItem{
                        Button {
                            isDarkModeEnabled.toggle()
                        }label: {
                            Image(systemName: "sun.max")
                        }
                    }
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
