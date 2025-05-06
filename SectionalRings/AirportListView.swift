//
//  AirportListView.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 5/2/25.
//

import SwiftUI

struct AirportListView: View {

    @EnvironmentObject var landables: Landables

    //Use NavigationLink to go to detail view

    var body: some View {
        NavigationStack {
            ScrollView {
                Grid(alignment: .leading) {
                    GridRow {
                        HStack {
                                
                            VStack {
                                Text("ICAO").bold()
                                Text("Elevation").bold()
                            }
                            .frame(width: 80)
                            VStack{
                                Text("Name").bold()
                                Text("Note").bold()
                            }
                            .frame(width: 600)
                            VStack {
                                Text("Width").bold()
                                Text("Length").bold()
                            }
                            .frame(width: 80)
                        }
                    }
                    ForEach(landables.landables, id: \.self) { item in
                        NavigationLink {
                            AirportView()
                                .environmentObject(item)
                        } label: {

                            GridRow {
                                //Toggle("", isOn: item.usable)
                                HStack {
                                    VStack {
                                        Text(item.icao.description)
                                        Text(item.elev.description)
                                    }
                                    .frame(width: 80)
                                    VStack {
                                        Text(item.name)
                                        Text(item.note).lineLimit(nil)
                                    }
                                    .frame(width: 600)
                                    VStack {
                                        Text(item.width.description)
                                        Text(item.length.description)
                                    }
                                    .frame(width: 80)
                                }
                            }
                        }
                        Divider()

                    }
                }
            }
        }
    }
}

#Preview {
    AirportListView()
        .environmentObject(Landables())
}
