//
//  BathymetryResponse.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 03/04/2025.
//

import Foundation
import CoreLocation

struct BathymetryResponse: Codable {
    let bathymetry: Bathymetry
}

struct Bathymetry: Codable {
    let type: String
    let bbox: [Double]
    let features: [Feature]
}

struct Feature: Codable {
    let type: String
    let properties: FeatureProperties
    let geometry: Geometry
}

struct FeatureProperties: Codable {
    let depth: Double
    let id: String
}

struct Geometry: Codable {
    let type: String
    let bbox: [Double]
    let coordinates: [[[Double]]]
}
