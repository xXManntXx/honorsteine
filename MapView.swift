
//  MapView.swift
//  Prueba
//
//  Created by Laura on 09/06/2023.
///

import SwiftUI
import MapKit

struct MapView: View {
    @State private var searchText = ""
    @State private var annotations = [AnnotationItem]()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.4416, longitude: 5.4697), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.05))
    @GestureState private var scale: CGFloat = 2.0

    var body: some View {
        NavigationView{
            ZStack(alignment: .top) {
                // Map view
                Map(coordinateRegion: $region, annotationItems: annotations) { annotation in
                    MapMarker(coordinate: annotation.coordinate, tint: .red)
                }
                .gesture(
                    MagnificationGesture()
                        .updating($scale) { value, state, _ in
                            state = value.magnitude
                        }
                        .onChanged { value in
                            let delta = (1.0 - value.magnitude) * 0.2
                            let span = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * delta, longitudeDelta: region.span.longitudeDelta * delta)
                            region.span = span
                        }
                )
                
                // Search bar
                VStack {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .padding(.horizontal)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.leading, 8)
                                .padding(.horizontal, 23)
                            
                            TextField("Search", text: $searchText, onCommit: searchButtonClicked)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 0)
                        }
                    }
                    .padding(.top, 76)
                    .padding(.horizontal)
                    
                    Spacer()
                }
                
                
                NavigationLink(destination: OnBoardingPage1View(), label: {
                    HStack {
                        Image(systemName: "map.fill")
                            .foregroundColor(.white)
                            .font(.title)
                        
                        Text("Create new route")
                            .font(.system(size: 16))
                            .font(.title).fontWeight(.bold).multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                    }
                    .frame(width: 325, height: 70)
                    .background(Color.yellow)
                    .cornerRadius(20)
                    .padding(.vertical, 40)
                    .padding(.top, 545)
                })
                .contentShape(Rectangle())
                
                
                
                NavigationLink(destination: OnBoardingPage1View(), label: {
                    HStack {
                        Image("Stone")
                            .resizable()
                         
                            .frame(width: 90, height: 100)
                            .cornerRadius(10)
                            .padding(.leading, -12)
                            .padding(.trailing, 12)
                        VStack {
                            Text("Strip-S Stones")
                                .font(.system(size: 20))
                                .font(.title).fontWeight(.bold).multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                           
                            Text("2022 Einhoeven")
                                .font(.system(size: 15))
                                .font(.title).fontWeight(.medium).multilineTextAlignment(.leading)
                                .foregroundColor(.gray)
                                .padding(.top, -13)
                                .padding(.leading, -22)
                            
                            HStack {
                                ForEach(0..<4) { index in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                                Image(systemName: "star.leadinghalf.fill")
                                    .foregroundColor(.yellow)
                                    .opacity(0.7)
                            }
                            .padding(.top, -10)
                            
                            
                            HStack{
                                Image(systemName: "bookmark.fill")
                                    .foregroundColor(.black)
                                    .font(.title2)
                                
                                Image(systemName: "cross.fill")
                                    .foregroundColor(.black)
                                    .font(.title2)
                                    
                            }
                            .padding(.top, 3)
                            .padding(.leading, 22)
                            
                        }
                        
                    }
                    .frame(width: 325, height: 130)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.vertical, 40)
                    .padding(.top, 630)
                    .padding(.bottom, 60)
                })
                .contentShape(Rectangle())
                
               
            }
            .ignoresSafeArea()
        
        }
      
    }
    
    private func searchButtonClicked() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let mapItems = response?.mapItems else {
                // Handle error or display no results
                return
            }
            
            annotations = mapItems.map { mapItem in
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                
                return AnnotationItem(annotation: annotation)
            }
        }
    }
}

struct AnnotationItem: Identifiable {
    let id = UUID()
    let annotation: MKPointAnnotation
    
    var coordinate: CLLocationCoordinate2D {
        return annotation.coordinate
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
