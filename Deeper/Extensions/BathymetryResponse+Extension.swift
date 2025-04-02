//
//  File.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 03/04/2025.
//

extension BathymetryResponse {
    static func dummyLake() -> BathymetryResponse {
        let baseLon = -120.04
        let baseLat = 39.03
        let step = 0.005

        let features: [Feature] = (0..<5).map { i in
            let depth = Double((i + 1) * 2)
            let offset = Double(i) * step
            return Feature(
                type: "Feature",
                properties: FeatureProperties(
                    depth: depth,
                    id: "lake-layer-\(i)"
                ),
                geometry: Geometry(
                    type: "Polygon",
                    bbox: [
                        baseLat + offset,
                        baseLon + offset,
                        baseLat + (4 * step) - offset,
                        baseLon + (4 * step) - offset
                    ],
                    coordinates: [[
                        [baseLon + offset, baseLat + offset, depth],
                        [baseLon + (4 * step) - offset, baseLat + offset, depth],
                        [baseLon + (4 * step) - offset, baseLat + (4 * step) - offset, depth],
                        [baseLon + offset, baseLat + (4 * step) - offset, depth],
                        [baseLon + offset, baseLat + offset, depth]
                    ]]
                )
            )
        }

        return BathymetryResponse(
            bathymetry: Bathymetry(
                type: "FeatureCollection",
                bbox: [
                    baseLat,
                    baseLon,
                    baseLat + (4 * step),
                    baseLon + (4 * step)
                ],
                features: features
            )
        )
    }
}
