//
//  Sectionals.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 6/3/25.
//

import Foundation

enum SectionalStatus: String {
    case unloaded = "Unloaded"
    case loading = "Loading"
    case loaded = "Loaded"
    case error = "Error"
}

struct Sectional: Hashable, Equatable {
    var id: UUID = UUID()
    var name: String
    var favorite: Bool = false
    var status: SectionalStatus = .unloaded
    var keepCurrent: Bool = false
    // These are in the htm file
    //   Need to validate which fields vary, and which are constants
    var currentEdition: Date? // From htm file in em tag Beginning_Date in yyyymmdd format
    var nextEdition: Date? // From htm file in em tag Ending_Date + 1 in yyyymmdd format
    var rowCount: Double? // em tag Row_Count
    var coloumnCount: Double? // em gat Column_Count
    var firstStandardParallel: Double? // em tag Standard_Parallel (1st occurance)
    var secondStandardParallel: Double? // em tag Standard_Parallel (2nd occurance)
    var LatitudeofFalseOrigin: Double? // em tag Latitude_of_Projection_Origin
    var LongitudeofFalseOrigin: Double? // em tag Longitude_of_Central_Meridian
    var FalseEasting:Double? = 2000000.0 / 3.2808333333 // em tag False_Easting, but values appear to be 0
    var FalseNorthing:Double? = 0.0 // em tag False_Northing, but values appear to be 0
    var abscissaResolution: Double? // em tag Abscissa_Resolution
    var ordinateResolution: Double? // em tag Ordinate_Resolution
    var planarDistanceUnits: String? // em tag Planar_Distance_Units (verify if allways "Meters"
    var ellipsoidName: String? // emtage Ellipsoid_Name
    var ellipsoidSemiMajorAxis: Double? // em tag Semi-major_Axis
    var denominatorOfFlatteningRatio: Double? // em tag Denominator_of_Flattening_Ratio
    // These are in the TFW file
    var xPixelSize: Double?
    var yAxisRotation: Double?
    var xAxisRotation: Double?
    var xUpperLeft: Double?
    var yUpperLeft: Double?
    //Posible other values to limit image bleed.
    //  Could be lat/lon limits, or x/y limits.
    
    func description() -> String {
        return "Sectional(\"\(self.name)\",\"\(self.status)\",\"\(String(describing: self.currentEdition))\",\(String(describing: self.nextEdition)),\(self.keepCurrent)\")"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func ==(lhs: Sectional, rhs: Sectional) -> Bool {
        return lhs.name == rhs.name
    }
}
//https://aeronav.faa.gov/visual/04-17-2025/sectional-files/Los_Angeles.zip
//https://aeronav.faa.gov/visual/04-17-2025/sectional-files/Anchorage.zip

class Sectionals: ObservableObject {
    var faaBaseUrl: String = "https://aeronav.faa.gov/visual/_edition_/sectional-files/"
    var faaBaseExt: String = ".zip"
    @Published var sectionals:[Sectional] = []
    
    init() {
        self.sectionals = defaultSectionals()
        for item in self.sectionals.enumerated() {
            if item.element.name == "Los Angeles" {
                sectionals[item.offset].favorite = true
            }
        }
    }
    
    func describe() {
        for each in self.sectionals {
            print(each.description())
        }
    }
    
}

func defaultSectionals() -> [Sectional] {
    var sectionals:[Sectional] = []
    
    sectionals.append(Sectional(name: "Albuquerque"))
    sectionals.append(Sectional(name: "Anchorage"))
    sectionals.append(Sectional(name: "Atlanta"))
    sectionals.append(Sectional(name: "Bethel"))
    sectionals.append(Sectional(name: "Billings"))
    sectionals.append(Sectional(name: "Brownsville"))
    sectionals.append(Sectional(name: "Cape Lisburne"))
    sectionals.append(Sectional(name: "Charlotte"))
    sectionals.append(Sectional(name: "Cheyenne"))
    sectionals.append(Sectional(name: "Chicago"))
    sectionals.append(Sectional(name: "Cincinnati"))
    sectionals.append(Sectional(name: "Cold Bay"))
    sectionals.append(Sectional(name: "Dallas-Ft Worth"))
    sectionals.append(Sectional(name: "Dawson"))
    sectionals.append(Sectional(name: "Denver"))
    sectionals.append(Sectional(name: "Detroit"))
    sectionals.append(Sectional(name: "Dutch Harbor"))
    sectionals.append(Sectional(name: "El Paso"))
    sectionals.append(Sectional(name: "Fairbanks"))
    sectionals.append(Sectional(name: "Great Falls"))
    sectionals.append(Sectional(name: "Green Bay"))
    sectionals.append(Sectional(name: "Halifax"))
    sectionals.append(Sectional(name: "Hawaiian Islands"))
    sectionals.append(Sectional(name: "Houston"))
    sectionals.append(Sectional(name: "Jacksonville"))
    sectionals.append(Sectional(name: "Juneau"))
    sectionals.append(Sectional(name: "Kansas City"))
    sectionals.append(Sectional(name: "Ketchikan"))
    sectionals.append(Sectional(name: "Klamath Falls"))
    sectionals.append(Sectional(name: "Kodiak"))
    sectionals.append(Sectional(name: "Lake Huron"))
    sectionals.append(Sectional(name: "Las Vegas"))
    sectionals.append(Sectional(name: "Los Angeles"))
    sectionals.append(Sectional(name: "McGrath"))
    sectionals.append(Sectional(name: "Memphis"))
    sectionals.append(Sectional(name: "Miami"))
    sectionals.append(Sectional(name: "Montreal"))
    sectionals.append(Sectional(name: "New Orleans"))
    sectionals.append(Sectional(name: "New York"))
    sectionals.append(Sectional(name: "Nome"))
    sectionals.append(Sectional(name: "Omaha"))
    sectionals.append(Sectional(name: "Phoenix"))
    sectionals.append(Sectional(name: "Point Barrow"))
    sectionals.append(Sectional(name: "St Louis"))
    sectionals.append(Sectional(name: "Salt Lake City"))
    sectionals.append(Sectional(name: "San Antonio"))
    sectionals.append(Sectional(name: "San Francisco"))
    sectionals.append(Sectional(name: "Seattle"))
    sectionals.append(Sectional(name: "Seward"))
    sectionals.append(Sectional(name: "Twin Cities"))
    sectionals.append(Sectional(name: "Washington"))
    sectionals.append(Sectional(name: "Western Aleutian Islands"))
    sectionals.append(Sectional(name: "Wichita"))
    
    return sectionals
}
