//
//  MyRoutesComp.swift
//  Stolperstaine
//
//  Created by Viktor on 09/06/2023.
//

import SwiftUI

struct MyRoutesComp: View {
    var body: some View {
        HStack(spacing: 20) {
            Image("Routes")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Strijp-S Stones")
                    .font(.system(size: 18))
                    .foregroundColor(.black)

                Text("2022 Eindhoven")
                    .font(.system(size: 15))
                    .font(.headline)
                    .foregroundColor(.gray)
                Text("Christinastraat 2a • Eindhoven, NL")
                    .font(.system(size: 12))
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
           
    

                
                Image(systemName: "play")
                    .font(.system(size: 30))
                    .padding()
            
           
        }
        .frame(width: 330)
        .padding(10)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray .opacity(0.4), radius: 4, x: 0, y: 5) // Add the shadow here
    }
}

struct MyRoutesComp_Previews: PreviewProvider {
    static var previews: some View {
        MyRoutesComp()
    }
}
