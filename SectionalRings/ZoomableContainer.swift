//
//  ZoomableContainer.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 5/5/25.
//  Taken from https://stackoverflow.com/questions/58341820/isnt-there-an-easy-way-to-pinch-to-zoom-in-an-image-in-swiftui


import Foundation
//  ZoomableContainer.swift
//  Taken from https://stackoverflow.com/questions/58341820/isnt-there-an-easy-way-to-pinch-to-zoom-in-an-image-in-swiftui

import SwiftUI

fileprivate let maxAllowedScale = 32.0

struct ZoomableContainer<Contentx: View>: View {
    let content: Contentx
    let startAt: CGPoint
    let imageSize: CGSize

    @State private var currentScale: CGFloat = 1.0
    @State private var tapLocation: CGPoint = .zero

    init(startAt: CGPoint, imageSize: CGSize, @ViewBuilder content: () -> Contentx) {
        self.content = content()
        self.startAt = startAt
        if startAt != .zero { currentScale = maxAllowedScale }
        self.imageSize = imageSize
    }

    func doubleTapAction(location: CGPoint) {
        tapLocation = location
        currentScale = currentScale == 1.0 ? maxAllowedScale : 1.0
    }

    var body: some View {
        if startAt == .zero {
            ZoomableScrollView(scale: $currentScale, tapLocation: $tapLocation) {
                content
            }
            .onTapGesture(count: 2, perform: doubleTapAction)
        } else {
            ZoomableScrollView(scale: $currentScale, tapLocation: $tapLocation) {
                content
            }
            .defaultScrollAnchor(UnitPoint(x: startAt.x / imageSize.width, y: startAt.y / imageSize.height))
            .onTapGesture(count: 2, perform: doubleTapAction)
        }
    }

    fileprivate struct ZoomableScrollView<Content: View>: UIViewRepresentable {
        private var content: Content
        @Binding private var currentScale: CGFloat
        @Binding private var tapLocation: CGPoint

        init(scale: Binding<CGFloat>, tapLocation: Binding<CGPoint>, @ViewBuilder content: () -> Content) {
            _currentScale = scale
            _tapLocation = tapLocation
            self.content = content()
        }

        func makeUIView(context: Context) -> UIScrollView {
            // Setup the UIScrollView
            let scrollView = UIScrollView()

                
                scrollView.delegate = context.coordinator // for viewForZooming(in:)
                scrollView.maximumZoomScale = maxAllowedScale
                scrollView.minimumZoomScale = 1
                scrollView.bouncesZoom = true
                scrollView.showsHorizontalScrollIndicator = false
                scrollView.showsVerticalScrollIndicator = false
                scrollView.clipsToBounds = true

            // Create a UIHostingController to hold our SwiftUI content
            let hostedView = context.coordinator.hostingController.view!
            hostedView.translatesAutoresizingMaskIntoConstraints = true
            hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            hostedView.frame = scrollView.bounds
            scrollView.addSubview(hostedView)
                return scrollView
        }
        
        //Added by cjd
        func getCenter() -> CGPoint {
            return CGPoint.zero
        }

        func makeCoordinator() -> Coordinator {
            return Coordinator(hostingController: UIHostingController(rootView: content), scale: $currentScale)
        }

        func updateUIView(_ uiView: UIScrollView, context: Context) {
            // Update the hosting controller's SwiftUI content
            context.coordinator.hostingController.rootView = content

            if uiView.zoomScale > uiView.minimumZoomScale { // Scale out
                uiView.setZoomScale(currentScale, animated: true)
            } else if tapLocation != .zero { // Scale in to a specific point
                uiView.zoom(to: zoomRect(for: uiView, scale: uiView.maximumZoomScale, center: tapLocation), animated: true)
                // Reset the location to prevent scaling to it in case of a negative scale (manual pinch)
                // Use the main thread to prevent unexpected behavior
                DispatchQueue.main.async { tapLocation = .zero }
            }

            assert(context.coordinator.hostingController.view.superview == uiView)
        }

        // MARK: - Utils

        func zoomRect(for scrollView: UIScrollView, scale: CGFloat, center: CGPoint) -> CGRect {
            let scrollViewSize = scrollView.bounds.size

            let width = scrollViewSize.width / scale
            let height = scrollViewSize.height / scale
            let x = center.x - (width / 2.0)
            let y = center.y - (height / 2.0)

            return CGRect(x: x, y: y, width: width, height: height)
        }

        // MARK: - Coordinator

        class Coordinator: NSObject, UIScrollViewDelegate {
            var hostingController: UIHostingController<Content>
            @Binding var currentScale: CGFloat

            init(hostingController: UIHostingController<Content>, scale: Binding<CGFloat>) {
                self.hostingController = hostingController
                _currentScale = scale
            }

            func viewForZooming(in scrollView: UIScrollView) -> UIView? {
                return hostingController.view
            }

            func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
                currentScale = scale
            }
        }
    }
}
