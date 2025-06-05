//
//  Test UI.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 6/2/25.
//

import SwiftUI

struct Test_UI: View {
    
    @EnvironmentObject var landable: Landable
    
    var body: some View {
        
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                common(label: "ICAO", field: $landable.icao)
                common(label: "Elevation", field: $landable.elev)
            }
            .background(.blue)
            VStack(alignment: .leading) {
                common(label: "Name", field: $landable.name)
                common(label: "Note", field: $landable.note)
            }
            .background(.blue)
            VStack(alignment: .leading) {
                common(label: "Length", field: $landable.length)
                common(label: "Width", field: $landable.width)
            }
            .background(.blue)
        }
        .background(.yellow)

        
    }
    
    //Collapse to one func
    //ask if multiline, default to no
    //ask if text, feet, hundred_feet, default to text
    //ask for maximum label width
    //ask for maximum field width
    
    func common(label:String, field:Binding<String>) -> some View {
        let labelWidth = 50.0 //label.widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold))
        print("1a) \(label) is \(labelWidth) wide.")
        let fieldWidth = field.wrappedValue.widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .regular))
        print("1b) \(field.wrappedValue) is \(fieldWidth) wide.")
        return HStack(alignment: .firstTextBaseline) {
            Text(label).bold()
                .lineLimit(1)
                .frame(width:80.0, alignment: .trailing)
                .background(.green)
            TextField(label, text: field, axis: .vertical)
                .frame(maxWidth: .infinity)
                    .background(.purple)
            }
        
        .frame(width: labelWidth + fieldWidth + 10.0)
        .background(.red)
    }
    
    //For Int fields
    func common(label:String, field:Binding<Int>) -> some View {
        let labelWidth = label.widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold))
        print("2a) \(label) is \(labelWidth) wide.")
        let fieldWidth = String(field.wrappedValue).widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .regular))
        print("2b) \(field.wrappedValue) is \(fieldWidth) wide.")
        return HStack {
            Text(label).bold()
                .background(.green)
                .frame(width: 80.0, alignment: .trailing)
            TextField(label, value: field, formatter: nfFeet)
                .background(.purple)
                .frame(width: labelWidth + fieldWidth)
                .background(.red)
        }
    }
}

#Preview {
    let warner = Landable("CL35","Warner Springs","Los-Angeles",33.2838889,116.667222,2880,35,70,12245.493338134676,8836.926481257557,"Gliderport.  Aerotows 7 days.")
    
    Test_UI()
        .environmentObject(warner)
}
