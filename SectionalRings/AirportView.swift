//
//  AirportView.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 5/5/25.
//

import SwiftUI

struct AirportView: View {

    @EnvironmentObject var landable: Landable
    let i: UIImage = UIImage(named: "Los Angeles SEC.tif")!
    let secBit: UIImage = UIImage(named: "Sectional Bit.jpg")!

    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        LabeledContent {
                            TextField("ICAO", text: $landable.icao)
                                .frame(width: 180)
                        } label: {
                            Text("ICAO").bold()
                        }
                        .frame(width: 180)
                        LabeledContent {
                            TextField("Name", text: $landable.name)
                        } label: {
                            Text("Name").bold()
                        }
                        .frame(width: 350)
                        LabeledContent {
                            TextField(
                                "Length",
                                value: $landable.length,
                                formatter: nfFeet
                            )
                        } label: {
                            Text("Length").bold()
                        }
                        .frame(width: 120)
                    }
                    HStack {
                        LabeledContent {
                            TextField(
                                "Elevation",
                                value: $landable.elev,
                                formatter: nfFeet
                            )
                        } label: {
                            Text("Elevation").bold()
                        }
                        .frame(width: 180)
                        LabeledContent {
                            TextField("Note", text: $landable.note)
                        } label: {
                            Text("Note").bold()
                        }
                        .frame(width: 350)
                        LabeledContent {
                            TextField(
                                "Width",
                                value: $landable.width,
                                formatter: nfFeet
                            )
                        } label: {
                            Text("Width").bold()
                        }
                        .frame(width: 120)
                    }
                }
                Toggle("Useable", isOn: $landable.useable).frame(width: 150)
            }
        }
        ZStack {
            let spot = inches2xy(left: landable.tiffX, top: landable.tiffY, size: i.size)
            let img = CGRect(x: spot.x - UIScreen.main.bounds.width / 2.0, y: spot.y - ((UIScreen.main.bounds.height - 200.0) / 2.0), width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height  - 200.00)
            let image = i.cgImage!.cropping(to: img)!
            Image(uiImage: UIImage(cgImage: image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 600, height: 600)
        }
    }
}

#Preview {
    let warner = Landable(
        "CL35",
        "Warner Springs",
        "Los-Angeles",
        33.2838889,
        116.667222,
        2880,
        35,
        70,
        40.86,
        29.59,
        41.02,
        29.39,
        "Gliderport.  Aerotows 7 days.",
        0.16,
        -0.20,
        true
    )
    AirportView()
        .environmentObject(warner)
}
