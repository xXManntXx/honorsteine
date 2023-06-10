//
//  NavBar.swift
//  Stolperstaine
//
//  Created by Viktor on 08/06/2023.
//

import SwiftUI

enum Tab: String, CaseIterable{
    case house
    case basketball
    case stats = "chart.bar"
    case person
}

func getPage(for tab: Tab) -> some View {
        switch tab {
        case .house:
            return AnyView(HomePage())
        case .basketball:
            return AnyView(Map())
        case .stats:
            return AnyView(ListOfCities())
        case .person:
            return AnyView(Events())
        }
    }

struct NavBar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    
    @State private var figurePosition: CGPoint = .zero
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Button(action: {
                        withAnimation(.spring()) {
                            selectedTab = tab
                            figurePosition = currentFigurePosition(for: tab)
                        }
                    }) {
                        NavigationLink(destination: getPage(for: tab)){
                            Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                                .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                                .foregroundColor(selectedTab == tab ? .white : .yellow)
                                .font(.system(size: 22))
                                .overlay(
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 26)
                                            .fill(selectedTab == tab ? Color("OffWhite") : .clear)
                                            .frame(width: 80, height: 60)
                                        Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                                            .foregroundColor(selectedTab == tab ? .black : .gray)
                                            .font(.system(size: 22))
                                    }
                                )
                            
                        }
                    }
                    Spacer()
                }
            }
            .frame(width: 450,height: 70)
            .background(Color("OffWhite"))
            .padding()
        }
    }
    
    private func currentFigurePosition(for tab: Tab) -> CGPoint {
        guard let index = Tab.allCases.firstIndex(of: tab) else {
            return .zero
        }
        let tabWidth: CGFloat = 80
        let xOffset = CGFloat(index) * tabWidth + tabWidth / 2 - 25
        return CGPoint(x: xOffset, y: -25)
    }
    
    struct NavBar_Previews: PreviewProvider {
        static var previews: some View {
            NavBar(selectedTab: .constant(.house))
        }
    }
}
