//
//  AirportListView.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 5/2/25.
//

import SwiftUI

struct AirportListView: View {

    @EnvironmentObject var landables: Landables

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
                            VStack {
                                Text("Name").bold()
                                Text("Note").bold()
                            }
                            VStack {
                                Text("Width").bold()
                                Text("Length").bold()
                            }
                            Text("Useable").bold()
                        }
                    }
                    ForEach($landables.landables, id: \.self) { $item in
                        HStack {
                            NavigationLink {
                                AirportView()
                                    .environmentObject(item)
                            } label: {

                                GridRow {
                                    //Toggle("", isOn: item.usable)
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(item.icao)
                                            Text(item.elev.description)
                                        }
                                        .frame(width: 50)
                                        VStack(alignment: .leading) {
                                            Text(item.name)
                                            Text(item.note).lineLimit(nil)
                                        }
                                        .frame(
                                            minWidth: UIScreen.main.bounds
                                                .width * 0.2,
                                            maxWidth: UIScreen.main.bounds
                                                .width * 0.6
                                        )
                                        VStack {
                                            Text(item.width.description)
                                            Text(item.length.description)
                                        }
                                    }
                                }
                            }
                            Toggle("", isOn: $item.useable)
                                .frame(alignment: .trailing)
                            //                            .overlay(
                            //                                RoundedRectangle(cornerRadius: 10)
                            //                                    .stroke(                             item.useable ? Color.green: Color.red, lineWidth: 2)
                            //                                    .onTapGesture { x in
                            //                                        item.useable.toggle()
                            //                                        print(item.useable)
                            //                                    }
                            //                            )
                        }
                        Divider()

                    }
                }
            }
        }
    }
}

func isItUsable(_ landable: Landable, _ switch: inout Binding<Bool>) {
    //        let enabled = CurrentValueSubject<Bool, Never>(useable)
    //        self.useable = Binding<Bool>(
    //            get: { enabled.value },
    //            set: { enabled.value = $0 }
    //            )
}

#Preview {
    AirportListView()
        .environmentObject(Landables())
}
