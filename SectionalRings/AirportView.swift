//
//  AirportView.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 5/5/25.
//

import SwiftUI

struct AirportView: View {

    @EnvironmentObject var landable: Landable

    let secBit: UIImage = UIImage(named: "Sectional Bit.jpg")!

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment:.firstTextBaseline) {
                        VStack {
                            Text("ICAO").bold()
                            Text("Elevation").bold()
                        }
                        VStack {
                            Text("Name").bold()
                            Text("Note").bold()
                        }
                        Text("Length").bold()
                        Text("Note").bold()
                        Text("Width").bold()
                    }
                    HStack {
                        TextField("ICAO", text: $landable.icao)
                            .frame(width: 180)
                        TextField("Name", text: $landable.name)
                            .frame(width: 350)
                        TextField(
                            "Length",
                            value: $landable.length,
                            formatter: nfFeet
                        )
                        .frame(width: 120)
                    }
                    HStack {
                        TextField(
                            "Elevation",
                            value: $landable.elev,
                            formatter: nfFeet
                        )
                        .frame(width: 180)
                        TextField("Note", text: $landable.note)
                            .frame(width: 350)
                        TextField(
                            "Width",
                            value: $landable.width,
                            formatter: nfFeet
                        )
                        .frame(width: 120)
                    }
                }
                Toggle("Useable", isOn: $landable.useable).frame(width: 150)
            }
        }
        ZStack {
            Image(uiImage: secBit).resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 600, height: 600)
            Rectangle().frame(maxWidth: 1, maxHeight: 650)
            Rectangle().frame(maxWidth: 650, maxHeight: 1)
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
