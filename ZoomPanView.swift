import SwiftUI

struct ZoomPanView: View {
    let image: UIImage
    let minScale: CGFloat
    let maxScale: CGFloat
    let initialScale: CGFloat
    let initialOffset: CGPoint
    
    @State private var currentScale: CGFloat
    @State private var offset: CGPoint
    @Binding var centerPoint: CGPoint
    
    init(
        image: UIImage,
        minScale: CGFloat = 1.0,
        maxScale: CGFloat = 4.0,
        initialScale: CGFloat = 1.0,
        initialOffset: CGPoint = .zero,
        centerPoint: Binding<CGPoint> = .constant(.zero)
    ) {
        self.image = image
        self.minScale = minScale
        self.maxScale = maxScale
        self.initialScale = initialScale
        self.initialOffset = initialOffset
        self._centerPoint = centerPoint
        
        // Initialize state variables
        _currentScale = State(initialValue: initialScale)
        _offset = State(initialValue: initialOffset)
    }
    
    var body: some View {
        GeometryReader { geometry in
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(currentScale)
                .offset(x: offset.x, y: offset.y)
                .gesture(
                    SimultaneousGesture(
                        MagnificationGesture()
                            .onChanged { value in
                                let delta = value / currentScale
                                currentScale *= delta
                                currentScale = min(maxScale, max(minScale, currentScale))
                            },
                        DragGesture()
                            .onChanged { value in
                                offset = CGPoint(
                                    x: offset.x + value.translation.width,
                                    y: offset.y + value.translation.height
                                )
                                updateCenterPoint(in: geometry)
                            }
                    )
                )
                .onAppear {
                    updateCenterPoint(in: geometry)
                }
        }
    }
    
    private func updateCenterPoint(in geometry: GeometryProxy) {
        let viewCenter = CGPoint(
            x: geometry.size.width / 2,
            y: geometry.size.height / 2
        )
        
        // Calculate the center point relative to the image
        let centerX = (viewCenter.x - offset.x) / currentScale
        let centerY = (viewCenter.y - offset.y) / currentScale
        
        centerPoint = CGPoint(x: centerX, y: centerY)
    }
}

#Preview {
    ZoomPanView(
        image: UIImage(systemName: "photo") ?? UIImage(),
        initialScale: 1.0,
        initialOffset: .zero
    )
} 