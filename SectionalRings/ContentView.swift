//
//  ContentView.swift
//  Sectional Rings
//
//  Created by Chuck Deerinck on 4/5/25.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    let fromRect = CGRect(x: 0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
    let i: UIImage = UIImage(named: "Los Angeles SEC.tif")!
    let middle:CGPoint = CGPoint(x: 16645.0 / 2, y: 12349.0 / 2)
    @State var si: UIImage = UIImage()

        var body: some View {
        
        VStack {
                HStack {
                    Button("Render") {
                        let spot = inches2xy(left: 40.86, top:29.59, size: i.size)
                        // x was 41.02 (-0.16), y was 29.39 (+20)
                        let scaler:Double = 25.0
                        let img = CGRect(x: spot.x - UIScreen.main.bounds.width / 2.0 * scaler, y: spot.y - ((UIScreen.main.bounds.height - 200.0) / 2.0 * scaler), width: UIScreen.main.bounds.width * scaler , height: UIScreen.main.bounds.height * scaler - 200.00)
                        let finishedImage = drawRings(image: i)
                        //add overlay(s)
                        //save file
                        si = UIImage(cgImage: finishedImage.cgImage!.cropping(to:img)!)
                    }
            }
            ZStack {
                Image(uiImage:si).resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main .bounds.width, height: UIScreen.main.bounds.height - 200)
                Rectangle().frame(maxWidth: 1)
                Rectangle().frame(maxHeight: 1)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

