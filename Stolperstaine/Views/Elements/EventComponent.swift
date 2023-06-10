//
//  EventComponent.swift
//  Stolperstaine
//
//  Created by Viktor on 08/06/2023.
//

import SwiftUI

struct EventComponent: View {
    var body: some View {
        HStack(spacing: 20) {
            Image("EventStone")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Honor Walk")
                    .font(.system(size: 20))
                    .foregroundColor(.black)

                Text("Walking")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {
                // Handle play button action
            }) {
                Image(systemName: "play.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(15)
                    .foregroundColor(.white)
                    .background(Color("Yellow"))
                    .cornerRadius(30)
            }
        }
        .frame(width: 330)
        .padding(10)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray .opacity(0.4), radius: 4, x: 0, y: 5) // Add the shadow here
    }
}

struct EventComponent_Previews: PreviewProvider {
    static var previews: some View {
        EventComponent()
    }
}

