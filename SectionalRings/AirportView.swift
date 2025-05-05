//
//  AirportView.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 5/2/25.
//

import SwiftUI

struct AirportView: View {
    
    @EnvironmentObject var landables: Landables
    
    var body: some View {
        ScrollView {
            Grid(alignment: .leading) {
                GridRow {
                    Text("ICAO").bold()
                    Text("Name").bold()
                    Text("Elev").bold()
                    Text("Width").bold()
                    Text("Length").bold()
                    Text("Note").bold()
                }
                ForEach(landables.landables, id: \.self) { item in
                    GridRow {
                        //Toggle("", isOn: item.usable)
                        Text(item.icao.description)
                        Text(item.name)
                        Text(item.elev.description)
                        Text(item.width.description)
                        Text(item.length.description)
                        Text(item.note).lineLimit(nil)
                    }
                    Divider()
                }
            }
            List {
                ForEach(landables.landables, id: \.self) { item in
                    HStack {
                        //Toggle("", isOn: item.usable)
                        Text(item.name)
                        Text(item.note)
                    }.border(Color.blue)
                }
            }
            .frame(height: CGFloat((landables.landables.count * 65) + (landables.landables.count < 4 ? 200 : 0)), alignment: .top)
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 20) {
//                ForEach(landables, id: \.self) { item in
//                    HStack {
//                        Text(item.name)
//                        Text(item.note)
//                    }
//                }
//            }
        }
    }
}

#Preview {
    AirportView()
        .environmentObject(Landables())
}
