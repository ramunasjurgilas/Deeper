//
//  BathymetryMapView.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 03/04/2025.
//

import SwiftUI
import GoogleMaps

struct BathymetryMapView: View {
    let bathymetry: BathymetryResponse

    init(bathymetry: BathymetryResponse) {
        self.bathymetry = bathymetry
    }

    var body: some View {
        GoogleMapsBathymetryView(bathymetry: bathymetry)
            .edgesIgnoringSafeArea(.all)
    }
}

struct GoogleMapsBathymetryView: UIViewRepresentable {
    let bathymetry: BathymetryResponse?

    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: 39.05, longitude: -120.025, zoom: 12)
        let mapView = GMSMapView(frame: .zero, camera: camera)
        drawPolygons(on: mapView)
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.clear()
        drawPolygons(on: uiView)
    }

    private func drawPolygons(on mapView: GMSMapView) {
        guard let bathymetry = bathymetry else { return }
        let sortedFeatures = bathymetry.bathymetry.features.sorted {
            $0.properties.depth > $1.properties.depth
        }

        for feature in sortedFeatures {
            guard let outer = feature.geometry.coordinates.first else { continue }

            let path = GMSMutablePath()
            for coord in outer {
                let lat = coord[1]
                let lon = coord[0]
                path.add(CLLocationCoordinate2D(latitude: lat, longitude: lon))
            }

            let polygon = GMSPolygon(path: path)
            let alpha = CGFloat(min(1.0, feature.properties.depth / 10.0))
            let colors: [UIColor] = [.red, .green, .yellow, .blue, .purple]
            let color = colors.randomElement()?.withAlphaComponent(alpha) ?? UIColor.red.withAlphaComponent(alpha)
            print("👍🏻 PPPP", alpha, color, feature.properties.depth)
            polygon.fillColor = colors.randomElement()
            polygon.strokeColor = colors.randomElement()
            polygon.strokeWidth = 1
            polygon.map = mapView
        }
    }
}

#Preview {
    BathymetryMapView(bathymetry: .dummyLake())
}
