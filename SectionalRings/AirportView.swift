//
//  AirportView.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 5/5/25.
//

import SwiftUI

struct AirportView: View {

    @EnvironmentObject var landable: Landable
    @State var imgScale: CGFloat = 1.0
    @State var lastScale: CGFloat = 1.0
    @State var tempSpot: CGPoint = .zero //CGPoint(x: landable.pixelX, y: landable.pixelY)
    
    let i: UIImage = UIImage(named: "Los Angeles SEC.tif")!
    let secBit: UIImage = UIImage(named: "Sectional Bit.jpg")!
    @Namespace var namespace
    
    var body: some View {
        
        let _ = print(/*self.title,*/ self.namespace, terminator: " -- ")
        let _ = Self._printChanges()
        
        VStack {
            HStack {
                VStack {
                    HStack {
                        LabeledContent {
                            TextField("ICAO", text: $landable.icao)
                                .frame(width: 90)
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
                    Text("Use")
                    Toggle("", isOn: $landable.useable).frame(alignment:.center)
                }
                .frame(width: 90)
            }
        }
        Group {
            GeometryReader { geo in
                ZStack {
                    //let spot = CGPoint(x:landable.pixelX, y:landable.pixelY) //inches2xy(left: landable.tiffX, top: landable.tiffY, size: i.size)
                    //let img = CGRect(x: spot.x - UIScreen.main.bounds.width / 2.0, y: spot.y - ((UIScreen.main.bounds.height - 200.0) / 2.0), width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height  - 200.00)
                    //let image = i.cgImage!//.cropping(to: img)!
                    let halfWidth:CGFloat = geo.size.width / 4.0
                    let halfHeight:CGFloat = geo.size.height / 4.0
                    //var tempSpot: CGPoint = .zero
                    //tempSpot = CGPoint(x:landable.pixelX, y:landable.pixelY)
                    
                    ZoomableContainer(startAt: $landable.location) {
                        Image(uiImage:i)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .onScrollGeometryChange(for: CGRect.self) { geometry in
                        geometry.visibleRect
                    } action: {oldValue, newValue in
                        print("Mid vs Airport: ", newValue.midX, landable.pixelX, newValue.midY, landable.pixelY)
                      tempSpot = CGPoint(x: newValue.midX, y: newValue.midY)
                    }
                    .onAppear() {
//                        self.scrollTo(x: CGFloat(landable.pixelX), y: CGFloat(landable.pixelY))
                    }
                    
                    
//                    ScrollView([.horizontal,.vertical], showsIndicators: true){
//                        Image(uiImage: i)
//                        //.resizable()
//                        //.aspectRatio(contentMode: .fit)
//                       // .frame(width: i.size.width, height: i.size.height) //this line didn't change anything
//                        .scaleEffect(imgScale)
//                        .gesture(
//                            MagnifyGesture()
//                                .onChanged { magGesture in
//                                    let delta = magGesture.magnification / self.lastScale
//                                    self.lastScale = magGesture.magnification
//                                    self.imgScale = self.imgScale * delta
//                                }
//                                .onEnded { val in
//                                    self.lastScale = 1.0
//                                }
//                            )
//                    }
//                    
//                
//                    .defaultScrollAnchor(UnitPoint(
//                        x: (landable.pixelX) / i.size.width,
//                        y: (landable.pixelY) / i.size.height
//                    ))
//                    .border(.orange, width:5)
//                    //use instance var point
//                    //use func scrollTo(x: CGFloat, y:CGFloat)
//                    //apple docs here: https://developer.apple.com/documentation/swiftui/scrollposition
//                    //instance var ScrollGemoetry has what we want: https://developer.apple.com/documentation/swiftui/scrollgeometry
//                    //                .onScrollGeometryChange(for: CGPoint.self) { geometry in
//                    //                    geometry.contentOffset
//                    //                } action: {oldValue, newValue in
//                    //                    print(oldValue, newValue, CGPoint(x:landable.pixelX, y:landable.pixelY))
//                    //                }
//                    .onScrollGeometryChange(for: CGRect.self) { geometry in
//                        geometry.visibleRect
//                    } action: {oldValue, newValue in
//                        print("Mid vs Airport: ", newValue.midX, landable.pixelX, newValue.midY, landable.pixelY)
//                        tempSpot = CGPoint(x: newValue.midX, y: newValue.midY)
//                    }
//                    .onScrollGeometryChange(for: CGPoint.self) { geometry in
//                        geometry.contentOffset
//                    } action: {oldValue, newValue in
//                        print("Offset : ", newValue.x, newValue.y)
//                    }
//                    .onScrollPhaseChange() { _, newPhase in
//                        if newPhase == .idle {
//                            print("Airport is: \(landable.pixelX), \(landable.pixelY)")
//                            print("Center is : \(tempSpot)")
//                        }
//                    }
                    
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
}

#Preview {
    let warner = Landable("CL35","Warner Springs","Los-Angeles",33.2838889,116.667222,2880,35,70,12245.493338134676,8836.926481257557,"Gliderport.  Aerotows 7 days.")
    AirportView()
        .environmentObject(warner)
}
