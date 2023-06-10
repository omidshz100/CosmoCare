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
    @State var isShowingCalender:Bool = false
    @State var date:Date = Date()
    
    
    private var sizeDateItem:CGFloat = 20.0
    
        var body: some View {
            NavigationView {
                VStack{
                    HStack{
                        Text("Evering Routing")
                        Image("ic-moon")
                        Spacer()
                    }
                    .padding()
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
                    HStack{
                        Text("Today")
                        Spacer()
                    }.padding()
                    
                    ScrollView(.vertical){
                        VStack{
                            ForEach(["a","b","c","d","e"],id:\.self){ item in
                                HStack{
                                    Image("ic-moon")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                    Text("some text here ....")
                                    Spacer()
                                }
                            }
                        }
                    }.padding()
                    
                    HStack{
                        Spacer()
                        Button{
                            
                        }label: {
                            Text("Start")
                        }.frame(width: 200, height: 50)
                            .background(Color.yellow)
                            .cornerRadius(20)
                        Spacer()
                    }
                    Spacer()
                }
                .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
                .toolbar {
                    ToolbarItem(placement:.navigationBarTrailing) {
                        Button {
                            // represent calender picker
                            isShowingCalender.toggle()
                        }label: {
                            Image(systemName: "calendar")
                        }
                    }
                    ToolbarItem(placement:.navigationBarTrailing) {
                        Button {
                            isDarkModeEnabled.toggle()
                        }label: {
                            Image(systemName: "sun.max")
                        }
                    }
                }
                .sheet(isPresented: $isShowingCalender) {
                    DatePicketSheet(date: $date, isShowing: $isShowingCalender)
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
