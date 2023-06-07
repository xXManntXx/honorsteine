//
//  ContentView.swift
//  Stolperstaine
//
//  Created by Viktor on 05/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color.white
                
                VStack {
                    Image("onBoarding3")
                        .resizable()
                        .frame(width: 350, height: 350)
                    
                    Text("Integrated ChatBot")
                        .font(.system(size: 30))
                        .frame(width: 250, height: 60)
                        .foregroundColor(Color.black)
                    
                    Text("Chat with our integrated chatBot which will help you learn more about the victims of the war")
                        .font(.system(size: 17))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    
                    NavigationLink(destination: OnBoardingPage2(), label: {
                                   Text("NEXT")
                                       .font(.system(size: 18))
                                       .foregroundColor(Color("Yellow"))
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
