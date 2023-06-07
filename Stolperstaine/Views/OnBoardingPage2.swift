//
//  OnBoardingPage2.swift
//  Stolperstaine
//
//  Created by Viktor on 05/06/2023.
//

import SwiftUI

struct OnBoardingPage2: View {
    var body: some View {
        NavigationView(){
            ZStack{
                Color.white
                
                VStack {
                    Image("onBoarding4")
                        .resizable()
                        .frame(width: 350, height: 350)
                    
                    Text("Integrated ChatBot")
                        .font(.system(size: 30))
                        .frame(width: 250, height: 60)
                    
                    Text("Chat with our integrated chatBot which will help you learn more about the victims of the war")
                        .font(.system(size: 17))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    Image("ImageDot")
                        .resizable()
                        .frame(width: 50, height: 10)
                        .offset(y: 30)
                    
                    Button( action: {}){
                      
                            Text("EXPLORE THE CITY")
                                .font(.system(size: 15))

                    }
                    .padding(.horizontal, 80)
                    .padding(.vertical, 15)
                    .background(.yellow)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .offset(y: 90)
                    
                    
                }
                .offset(y:-100)
                .padding()
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct OnBoardingPage2_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage2()
    }
}
