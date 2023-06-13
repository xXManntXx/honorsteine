//
//  OnBoardingPage2View.swift
//  Prueba
//
//  Created by Laura on 09/06/2023.
//

import SwiftUI

struct OnBoardingPage2View: View {
    var body: some View {
        NavigationView{
            VStack{
                
                
                Spacer()
                Image("Image2")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                Text("Choose a route")
                    .font(.title).fontWeight(.heavy).multilineTextAlignment(.leading).padding(-20.0)
                
                
                
                
                Text("Travel by the city view stones and experience the history")
                    .font(.subheadline).fontWeight(.bold).foregroundColor(Color.gray).multilineTextAlignment(.center).padding(.top, 24.0).frame(width: 310.0)
                Spacer()
                
                Image("D2")
                    .resizable()
                    .scaledToFill()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .frame(width: 60,height: 50)
                    
                    
                    
                    NavigationLink(destination: OnBoardingPage2View(), label: {
                                   Text("NEXT")
                                       .font(.system(size: 18))
                                       .foregroundColor(.white)
                                       .frame(width: 250, height: 50)
                                       .background(Color.yellow)
                                       .cornerRadius(10)
                                       .padding(.vertical, 40)
                               })
                        .contentShape(Rectangle())
                    
                    Button( action: {}){
                    
                            Text("Skip")
                                .font(.system(size: 18))

                    }
                    .padding(.horizontal, 110)
                    .foregroundColor(.yellow)
                    .cornerRadius(10)
                  
                }
              
                .padding()
            }
            .ignoresSafeArea()
        }
    }


struct OnBoardingPage2View_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage2View()
    }
}
