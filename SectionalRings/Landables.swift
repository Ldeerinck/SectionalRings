//
//  Landables.swift
//  Sectional Rings
//
//  Created by Chuck Deerinck on 4/24/25.
//

import Foundation
import SwiftUI
import Combine

class Landable: ObservableObject, Hashable, Identifiable, Copyable, Escapable {
    var id:UUID = UUID()
    var icao:String
    var name:String
    var sectional:String
    var lat:Double
    var lon:Double
    var elev:Int
    var length:Int
    var width:Int
    var tiffX:Double
    var tiffY:Double
    var pdfX:Double
    var pdfY:Double
    var note:String
    var errX:Double
    var errY:Double
//    var useable: Binding<Bool>
    var isUseable:Bool
    
    init(_ icao: String, _ name: String, _ sectional: String, _ lat: Double, _ lon: Double, _ elev: Int, _ length: Int, _ width: Int, _ tiffX: Double, _ tiffY: Double, _ pdfX: Double, _ pdfY: Double, _ note: String, _ errX: Double, _ errY: Double, _ useable:Bool = true) {
        self.icao = icao
        self.name = name
        self.sectional = sectional
        self.lat = lat
        self.lon = lon
        self.elev = elev
        self.length = length
        self.width = width
        self.tiffX = tiffX
        self.tiffY = tiffY
        self.pdfX = pdfX
        self.pdfY = pdfY
        self.note = note
        self.errX = errX
        self.errY = errY
        self.isUseable = useable
//        let enabled = CurrentValueSubject<Bool, Never>(useable)
//        self.useable = Binding<Bool>(
//            get: { enabled.value },
//            set: { enabled.value = $0 }
//            )
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func ==(lhs: Landable, rhs: Landable) -> Bool {
        return lhs.name == rhs.name
    }
}

class Landables: ObservableObject { //}, RandomAccessCollection {
    @Published var landables:[Landable]
    
    init() {
        self.landables = defaultLandables()
    }
    
}

func defaultLandables() -> [Landable] {
    
    var landables:[Landable] = []
    
    //Id,Location,Sectional,Lat,Lon,Elev,Length,Width,x,y,x,y,Note,,,Err x,Err y
    landables.append(Landable("L78","Jacumba","Los-Angeles",32.6166667,116.163889,2844,25,60,44.71,35.33,44.87,35.10,"Gliderport.  Winch launch by schedule.",0.16,-0.23, true))
    landables.append(Landable("OCA6","Emory Ranch","Los-Angeles",32.7475,116.02,480,24,40,45.80,34.16,45.96,33.94,"Low bushes on both sides.",0.16,-0.22, true))
    landables.append(Landable("L54","Agua Caliente","Los-Angeles",32.9558333,116.295,1220,25,60,43.68,32.21,43.84,32.20,"Closed by NOTAM.  Land near centerline.",0.16,-0.01, true))
    landables.append(Landable("KCRQ","McClellan-Palomar","Los-Angeles",33.12825,117.28,331,49,150,36.40,31.03,36.56,30.82,"Busy GA airport.  Some gliders present.",0.16,-0.21, true))
    landables.append(Landable("L08","Borrego Valley","Los-Angeles",33.2597222,116.322222,522,50,75,43.43,29.77,43.59,29.56,"Aero-retreivable",0.16,-0.21, true))
    landables.append(Landable("CL35","Warner Springs","Los-Angeles",33.2838889,116.667222,2880,35,70,40.86,29.59,41.02,29.39,"Gliderport.  Aerotows 7 days.",0.16,-0.20, true))
    landables.append(Landable("54CL","Lake Riverside Estates","Los-Angeles",33.5213889,116.795833,3410,35,40,39.89,27.53,40.05,27.33,"Private, but glider friendly.  Aero-retreivable.",0.16,-0.20, true))
    landables.append(Landable("CA89","Skylark / Elsinore","Los-Angeles",33.6311111,117.300556,1262,27,100,36.19,26.64,36.35,26.43,"",0.16,-0.21, true))
    landables.append(Landable("HMT","Hemet-Ryan","Los-Angeles",33.7338889,117.021667,1515,43,100,38.22,25.64,38.38,25.46,"Gliderport.  No local tows.  Aero-retreivable.  gliderstrip to N is 25' wide.",0.16,-0.18, true))
    landables.append(Landable("CN64","Desert Center","Los-Angeles",33.74772,115.32525,559,42,50,50.60,25.28,50.75,25.08,"Clear on both sides, OK for Open Class.",0.15,-0.20, true))
    landables.append(Landable("UDD","Bermuda Dunes","Los-Angeles",33.7483333,116.273889,73,50,0,43.66,25.49,43.82,25.31," ",0.16,-0.18, true))
    landables.append(Landable("BNG","Banning","Los-Angeles",33.9230556,116.849722,2222,49,0,39.44,24.01,39.60,23.84,"Closure announced.",0.16,-0.17, true))
    landables.append(Landable("REI","Redlands","Los-Angeles",34.0852778,117.146389,1574,45,0,37.27,22.62,37.43,22.45,"",0.16,-0.17, true))
    landables.append(Landable("L22","Yacca Valley","Los-Angeles",34.1277778,116.407778,3224,43,0,42.61,22.10,42.76,21.93,"",0.15,-0.17, true))
    landables.append( Landable("L35","Big Bear","Los-Angeles",34.2636111,116.853611,6752,58,75,39.36,21.02,39.52,20.86,"Aero-retreivable",0.16,-0.16, true))
    landables.append(  Landable("NXP","Twentynine Palms Self"," ",34.2833333,116.1675,2051,80,0,44.37,20.63,44.53,20.47,"",0.16,-0.16, true))
    landables.append(   Landable("L26","Hesperia","Los-Angeles",34.3772222,117.315833,3390,39,0,36.01,20.08,36.17,19.92,"",0.16,-0.16, true))
    landables.append(Landable("46CN","Crystal","Los-Angeles",34.4847222,117.826667,3420,27,0,32.30,19.16,32.46,19.01,"",0.16,-0.15, true))
    landables.append(Landable("APV","Apple Valley","Los-Angeles",34.5705556,117.187778,3062,65,0,36.93,18.32,37.09,18.16,"",0.16,-0.16, true))
    landables.append(Landable("5CA4","Ludlow","Los-Angeles",34.7533333,116.154167,1700,26,0,44.32,16.81,44.48,16.67,"",0.16,-0.14, true))
    landables.append(Landable("DAG","Barstow-Daggett","Los-Angeles",34.8536111,116.786667,1930,64,0,39.77,15.79,39.93,15.65,"",0.16,-0.14, true))
    landables.append(Landable("","Chiriaco Summit","Los-Angeles",0,0,1711,40,0,47.80,26.06,47.96,25.87,"",0.16,-0.19, true))
    landables.append(Landable("","Blythe","Los-Angeles",0,0,400,65,0,55.08,26.22,55.24,26.03,"",0.16,-0.19, true))
    landables.append(Landable("TNP","Twentynine Palms","Los-Angeles",0,0,1888,55,0,45.98,22.04,46.14,21.87,"",0.16,-0.17, true))
    landables.append(Landable("","General Fox","Los-Angeles",0,0,2351,72,0,29.46,16.93,29.63,16.79,"",0.17,-0.14, true))
    landables.append(Landable("","Agua Dulce","Los-Angeles",0,0,2633,42,0,28.78,19.02,28.94,18.86,"",0.16,-0.16, true))
    landables.append(Landable("","Santa Paula","Los-Angeles",0,0,250,26,0,23.37,20.38,23.53,20.22,"",0.16,-0.16, true))
    landables.append(Landable("","Santa Ynez","Los-Angeles",0,0,674,28,0,16.04,18.02,16.23,17.86,"",0.19,-0.16, true))
    landables.append(Landable("","Mountain Valley","Los-Angeles",0,0,4220,37,0,27.98,13.78,28.15,13.64,"",0.17,-0.14, true))
    landables.append(Landable("","CalCity","Los-Angeles",0,0,2454,60,0,30.91,13.34,31.07,13.20,"",0.16,-0.14, true))
    landables.append(Landable("","Rosamond","Los-Angeles",0,0,2415,36,0,29.56,15.80,29.72,15.65,"",0.16,-0.15, true))
    landables.append(Landable("","Inyokern","Los-Angeles",0,0,2457,71,0,32.21,8.88,32.38,8.76,"",0.17,-0.12, true))
    landables.append(Landable("","Karn Valley","Los-Angeles",0,0,2614,35,0,28.01,8.27,28.18,8.16,"",0.17,-0.11, true))
    landables.append(Landable("","Desert Air Sky Ranch","Los-Angeles",0,0,0,30,0,46.65,27.68,46.81,27.48,"",0.16,-0.20, true))
    landables.append(Landable("","Baker","Los-Angeles",0,0,922,31,0,44.75,11.95,44.91,11.82,"",0.16,-0.13, true))
    landables.append(Landable("","Jean","Los-Angeles",0,0,2835,46,0,50.01,7.58,50.17,7.47,"",0.16,-0.11, true))
    
    return landables
}

