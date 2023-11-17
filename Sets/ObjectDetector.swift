//
//  ObjectDetector.swift
//  Sets
//
//  Created by f1235791 on 17/11/2023.
//

import Foundation
import CoreML
import Vision
import CoreImage
import Algorithms

class ObjectDetector: ObservableObject {
    
    var boundingBoxes = [CGRect]()
    
    func detect(ciImage: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: MyObjectDetector(configuration: MLModelConfiguration()).model)
        else {
            return
        }
        
        let request = VNCoreMLRequest(model: model)
        let handler = VNImageRequestHandler(ciImage: ciImage)
        try? handler.perform([request])
        
        guard let results = request.results as? [VNRecognizedObjectObservation] else {
            return
        }
        
        boundingBoxes.removeAll()
        var numerics = [Int]()
        
        for objectObservation in results  {
            let topLabel = objectObservation.labels[0]
            
            print(topLabel.identifier)
            numerics.append(topLabel.numeric())
        }
        
        for combo in numerics.combinations(ofCount: 3) {
            
            let sum = combo[0] + combo[1] + combo[2]
            
            if sum.allDigitsTriple() {
                
                print()
                print("Here's one set: ")
                
                for numeric in combo {
                    let result = results[numerics.firstIndex(of: numeric)!]
                    print(result.labels[0].identifier)
                    boundingBoxes.append(result.boundingBox)
                }
                break
            }
        }
    }
}
extension VNClassificationObservation {
    
    func numeric() -> Int {
        
        let features = self.identifier.components(separatedBy: "_")
        
        return  1232
    }
}
extension Int {
    
    func allDigitsTriple() -> Bool {
        print(self)    // the integer
        
        return true
    }
}
