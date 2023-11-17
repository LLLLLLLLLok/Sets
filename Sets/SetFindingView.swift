//
//  SetFindingView.swift
//  Sets
//
//  Created by f1235791 on 17/11/2023.
//

import SwiftUI
import PhotosUI

struct SetFindingView: View {
    @ObservedObject var detector = ObjectDetector()
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    var body: some View {
        VStack {
            PhotosPicker("Select photo", selection: $selectedItem, matching: .images)
            
            if let selectedImage {
                selectedImage
                    .resizable()
                    .scaledToFit()
                    .overlay(BoundingBoxOverlay(rects: detector.boundingBoxes))
            }
        }
        .onChange(of: selectedItem) { _ in
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        selectedImage = Image(uiImage: uiImage)
                        
                        guard let ciImage = CIImage (image: uiImage) else { return }
                        detector.detect(ciImage: ciImage)
                        return
                    }
                }
                
                print("Failed")
            }
        }
    }
}

struct SetFindingView_Previews: PreviewProvider {
    static var previews: some View {
        SetFindingView()
    }
}

struct BoundingBoxOverlay: View {
    
    var rects = [CGRect]()
    
    var body: some View {
        GeometryReader { ( geometry: GeometryProxy) in
            ForEach(rects) { (rect: CGRect) in
                let w = geometry.size.width
                let h = geometry.size.height
                Rectangle().path(in: CGRect(
                    x: w * rect.minX,
                    y: h * (1-rect.height-rect.minY),
                    width: w * rect.width,
                    height: h * rect.height)
                ).stroke(Color.pink, lineWidth: 3.0)
            }
        }
    }
}

extension CGRect: Identifiable {
    public var id: String { "\(origin)-\(size)" }
}
