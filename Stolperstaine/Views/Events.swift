//
//  Events.swift
//  Stolperstaine
//
//  Created by Viktor on 08/06/2023.
//

import SwiftUI

    
    struct Events: View {
        var body: some View {
            ScrollView{
                VStack {
                    HStack {
                       
                        NavigationLink(destination: Map()) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 30))
                                .foregroundColor(.yellow)
                                .cornerRadius(10)
                                .padding(.horizontal, 40)
                        }
                  
                        
                        Text("**HONOR WALK**")
                            .font(.system(size: 28))
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 10)
                            .offset(x: -50)
                    }

                    
                    Spacer()
                    
                    VStack(alignment: .center){
                        Image("Map")
                            .resizable()
                            .frame(width: 320, height: 320)
                            .cornerRadius(20)
                        
                        HStack(alignment: .center){
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(2)
                            
                            Text("120")
                                .font(.system(size: 15))
                            
                            Image(systemName: "paperplane")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(2)
                            
                            Text("30")
                                .font(.system(size: 15))
                            
                            NavigationLink(destination: MyRoutes()) {
                                Text("**Join**")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .frame(width: 170, height: 50)
                                    .background(Color("Yellow"))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 10)
                            }
                        }
                        
                        VStack(alignment: .center){
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                                .font(.system(size: 15))
                                .frame(width: 320, height: 200)
                                .foregroundColor(.black .opacity(0.6))
                            
                            Image("Victim1")
                                .resizable()
                                .frame(width: 250, height: 350)
                                .padding(2)
                            
                            Text("Julius Kleerekoper")
                            
                            Image("Victim2")
                                .resizable()
                                .frame(width: 250, height: 350)
                                .padding(2)
                            
                            Text("Julius Kleerekoper")
                        }
                        .padding()
                    }
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }


struct Events_Previews: PreviewProvider {
    static var previews: some View {
        Events()
    }
}
