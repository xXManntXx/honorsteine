//
//  MyRoutes.swift
//  Stolperstaine
//
//  Created by Viktor on 09/06/2023.
//

import SwiftUI

struct MyRoutes: View {
    var body: some View {
        ZStack {
            Color.white
            VStack {
                HStack {
                    NavigationLink(destination: Map()) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 30))
                            .foregroundColor(.yellow)
                            .padding(.horizontal, -100)
                    }
                    

                    
                    Text("Eindhoven")
                        .font(.system(size: 28))
                }
                Spacer()
                
                MyRoutesComp()
                MyRoutesComp()
                
                Image("SmallMap")
                    .offset(y:30)
            }
            .padding(40)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

struct MyRoutes_Previews: PreviewProvider {
    static var previews: some View {
        MyRoutes()
    }
}
