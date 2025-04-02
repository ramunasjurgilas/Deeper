//
//  ScanStorageService.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 02/04/2025.
//

import CoreData

class ScanStorageService {
    static func saveScans(_ scans: [LoginResponse.Scan], context: NSManagedObjectContext) {
        for scanData in scans {
            let scan = Scan(context: context)
            scan.id = Int32(scanData.id)
            scan.latitude = scanData.lat
            scan.longitude = scanData.lon
            scan.name = scanData.name
            scan.scanPoints = Int32(scanData.scanPoints)

            // Convert ISO8601 string to Date
            if let dateString = scanData.date,
               let date = ISO8601DateFormatter().date(from: dateString) {
                scan.date = date
            } else {
                scan.date = Date()
            }
        }
        do {
            try context.save()
        } catch {
            print("❌ Failed to save scans: \(error) log and present to user")
        }
    }
}
