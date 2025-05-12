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
                VStack(alignment: .center) {
                    Text("Useable")
                    Toggle("", isOn: $landable.useable).frame(alignment:.center)
                }
            }
        }
        Group {
            ZStack {
                let spot = CGPoint(x:landable.pixelX, y:landable.pixelY) //inches2xy(left: landable.tiffX, top: landable.tiffY, size: i.size)
                let img = CGRect(x: spot.x - UIScreen.main.bounds.width / 2.0, y: spot.y - ((UIScreen.main.bounds.height - 200.0) / 2.0), width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height  - 200.00)
                let image = i.cgImage!.cropping(to: img)!
                
                ZoomableContainer {
                    Image(uiImage: UIImage(cgImage: image))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                Rectangle()
                    .stroke(lineWidth: 2.0)
                    .fill(.red)
                    .frame(maxWidth: 1, maxHeight: .infinity)
                Rectangle()
                    .stroke(lineWidth: 2.0)
                    .fill(.red)
                    .frame(maxWidth: .infinity, maxHeight: 1)
            }
        }
        .border(.red)
    }
}

#Preview {
    let warner = Landable("CL35","Warner Springs","Los-Angeles",33.2838889,116.667222,2880,35,70,12245.493338134676,8836.926481257557,"Gliderport.  Aerotows 7 days.")
    AirportView()
        .environmentObject(warner)
}
