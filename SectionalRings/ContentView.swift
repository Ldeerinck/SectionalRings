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
            VStack {
                HStack {
                    Button("Test") {
                        let p = LCCParameters()
                        let po = lambertConformalConic(lat: 28.5, lon: -96.0, params: p)
                        let x = po
                    }
                    Button("Center") {
                        let spot = middle
                        let img = CGRect(x: spot.x - UIScreen.main.bounds.width / 2, y:spot.y - (UIScreen.main.bounds.height - 200) / 2, width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height - 200)
                        let finishedImage = drawInto(image:i)
                        si = UIImage(cgImage: finishedImage.cgImage!.cropping(to:img)!)
                    }
                    Button("Warner") {
                        let spot = inches2xy(left: 40.86, top:29.59, size: i.size)
                        // x was 41.02 (-0.16), y was 29.39 (+20)
                        let scaler:Double = 25.0
                        let img = CGRect(x: spot.x - UIScreen.main.bounds.width / 2.0 * scaler, y: spot.y - ((UIScreen.main.bounds.height - 200.0) / 2.0 * scaler), width: UIScreen.main.bounds.width * scaler , height: UIScreen.main.bounds.height * scaler - 200.00)
                        let finishedImage = drawRings(image: i)
                        si = UIImage(cgImage: finishedImage.cgImage!.cropping(to:img)!)
                    }
                    Button("Jacumba") {
                        let spot = inches2xy(left: 44.71, top:35.33, size: i.size)
                        // x was 44.87 (-0.16), y was 35.10 (+0.23)
                        let img = CGRect(x: spot.x - UIScreen.main.bounds.width / 2, y:spot.y - (UIScreen.main.bounds.height - 200) / 2, width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height - 200)
                        si = UIImage(cgImage: i.cgImage!.cropping(to:img)!)
                    }
                    Button("Borrego") {
                        let spot = inches2xy(left: 43.43, top:29.77, size: i.size)
                        // x was 44.59 (-0.16), y was 29.56 (+0.21)
                        let img = CGRect(x: spot.x - UIScreen.main.bounds.width / 2, y:spot.y - (UIScreen.main.bounds.height - 200) / 2, width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height - 200)
                        si = UIImage(cgImage: i.cgImage!.cropping(to:img)!)
                        let spot1 = inches2xy(left: 10, top:10, size: i.size)
                        let spot2 = inches2xy(left: 11.45, top:10, size: i.size)
                        print("1nm = ", spot2.x - spot1.x)
                    }

                }
                HStack {
                    Button("Big Bear") {
                        let spot = inches2xy(left: 39.36, top:21.02, size: i.size)
                        // x was 39.52 (-0.16), y was 20.86 (+0.16)
                        let img = CGRect(x: spot.x - UIScreen.main.bounds.width / 2, y:spot.y - (UIScreen.main.bounds.height - 200) / 2, width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height - 200)
                        si = UIImage(cgImage: i.cgImage!.cropping(to:img)!)
                    }
                    Button("Re-Use") {
                        let spot = inches2xy(left: 42.61, top:22.10, size: i.size)
                        let img = CGRect(x: spot.x - UIScreen.main.bounds.width / 2, y:spot.y - (UIScreen.main.bounds.height - 200) / 2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
                        si = UIImage(cgImage: i.cgImage!.cropping(to:img)!)
                    }
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

