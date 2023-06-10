//
//  HomePage.swift
//  Stolperstaine
//
//  Created by Viktor on 08/06/2023.
//

import SwiftUI

struct HomePage: View {
    @State private var selectedTab: Tab = .house
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView{
                VStack {
                    VStack{
                        ScrollView{
                            LazyVStack(alignment: .leading) {
                                
                                HStack{
                                    Image(systemName: "location.magnifyingglass")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .padding(5)
                                    
                                    Text("Eindhoven")
                                        .font(.system(size: 28))
                                    
                                    Spacer()
                                    
                                    Image(systemName: "bell")
                                        .resizable()
                                        .frame(width: 25, height: 27)
                                        .padding(20)
                                }
                                
                                
                                Text("Upcomming event")
                                    .padding(.horizontal, 10)
                                    .foregroundColor(.black .opacity(0.5))
                            }
                            .padding(10)
                            
                            
                            NavigationLink(destination: Events()) {
                                EventComponent()
                            }
                           
                            NavigationLink(destination: Map(), label: {
                                Text("Create a new route")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .frame(width: 250, height: 50)
                                    .background(Color.yellow)
                                    .cornerRadius(10)
                                    .offset(y: 10)
                            })
                          
                            .contentShape(Rectangle())
                        }
                
                        HStack{
                            Image("EindhovenCenter")
                                .resizable()
                                .frame(width: 150, height: 160)
                                .padding(5)
                                .offset(y:3)
                            
                            Image("Stratum")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .padding(5)
                        }
                       
                        
                        HStack{
                            Image("Strijp-S")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .padding(5)
                            
                            Image("Woensel")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .padding(5)
                        }
                    
                    Spacer()
                    
                    NavBar(selectedTab: $selectedTab)
                            .offset(y: 20)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
