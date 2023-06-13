//
//  BioView.swift
//  Prueba
//
//  Created by Laura on 11/06/2023.
//

import SwiftUI

struct BioView: View {
    var body: some View {
        
        NavigationView{
            
            VStack{
                Text("Find out what's nearby")
                    .font(.title).fontWeight(.heavy)
                    .padding(.top, 45)
                   

                Image("Bio")
                    .resizable()
                    .frame(width: 200, height: 270)
                    .padding(.top, 30)
                HStack{
                    Text("Hannah Fox")
                        .font(.title).fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 30)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.black)
                        .font(.title2)
                }  .padding(.horizontal, 35)
               
                
                Text("Hannah Fox is geboren op 28 mei 1907 in Amsterdam. Zij is correspondente van beroep en verblijft veel in het buitenland. Op 4 juni 1930 trouwt zij met Johannes Swart die werktuigkundige ingenieur is. Zij hebben twee zoons: Johannes Frans Age Swart, geboren in Eindhoven op 3 juli 1932 en Robert Willem Swart, geboren op 13 december 1933 in Amsterdam. ")
                    .font(.subheadline).fontWeight(.bold).foregroundColor(Color.gray).multilineTextAlignment(.leading)
                        .padding(.top, 4.0)
                        .frame(width: 320.0)
                Spacer()
                
                HStack{
                    NavigationLink(destination: OnBoardingPage2View(), label: {
                        HStack {
                            
                            
                            Text("Talk to Hannah...")
                                .font(.system(size: 17))
                                .font(.title).fontWeight(.bold).multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                        }
                        .frame(width: 200, height: 55)
                        .background(Color.yellow)
                        .cornerRadius(20)
                        
                    })
                    .contentShape(Rectangle())
                    NavigationLink(destination: OnBoardingPage2View(), label: {
                        HStack {
                            
                            
                            Text("More")
                                .font(.system(size: 17))
                                .font(.title).fontWeight(.bold).multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                        }
                        .frame(width: 100, height: 55)
                        .background(Color.gray)
                        .cornerRadius(20)
                        
                    })
                    .contentShape(Rectangle())
                  }
                  }
            
            
            
        }
    }
}

struct BioView_Previews: PreviewProvider {
    static var previews: some View {
        BioView()
    }
}
