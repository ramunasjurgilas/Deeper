//
//  BathymetryMapView.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 03/04/2025.
//

import SwiftUI
import GoogleMaps

struct BathymetryMapView: View {
    var body: some View {
        GoogleMapsEmptyView()
    }
}

struct GoogleMapsEmptyView: UIViewRepresentable {
    typealias UIViewType = GMSMapView

    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: 39.05, longitude: -120.025, zoom: 12)
        return GMSMapView(frame: .zero, camera: camera)
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {}
}

#Preview {
    BathymetryMapView()
}
