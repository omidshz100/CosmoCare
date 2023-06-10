import Foundation
import AVFoundation
import CoreImage
import Vision
import UIKit

class ViewModelNew: NSObject, ObservableObject {
  
  static let shared = ViewModelNew()
  
  @Published var current: CVPixelBuffer?
  @Published var someData:String = ""
  
  
  let videoOutputQueue = DispatchQueue(
    label: "com.\(COMPANYNAME).VideoOutputQ",
    qos: .userInitiated,
    attributes: [],
    autoreleaseFrequency: .workItem)
  
  
  
  @Published var frame: CGImage?
  @Published var error: Error?
  

  
  /// Adding Image fillter business logic
  var comicFilter = false
  var monoFilter = false
  var crystalFilter = false
  private let context = CIContext()
  /// Ending of adding business logic
  ////
  
  
  // Adding Detection things
  private var requests = [VNRequest]()
  @discardableResult
  func setupVision() -> NSError? {
      // Setup Vision parts
      let error: NSError! = nil
      
      guard let modelURL = Bundle.main.url(forResource: "Larocheposay", withExtension: "mlmodelc") else {
          return NSError(domain: "VisionObjectRecognitionViewController", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model file is missing"])
      }
      do {
          let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL))
          let objectRecognition = VNCoreMLRequest(model: visionModel, completionHandler: { (request, error) in
              DispatchQueue.main.async(execute: {
                  // perform all the UI updates on the main queue
                  if let results:[VNObservation] = request.results {
                      self.writeTheNameOfDetectedObj(results)
                  }
              })
          })
          self.requests = [objectRecognition]
      } catch let error as NSError {
          print("Model loading went wrong: \(error)")
      }
      return error
  }
  
  func writeTheNameOfDetectedObj(_ results: [Any]) {
      for observation in results where observation is VNRecognizedObjectObservation {
          guard let objectObservation = observation as? VNRecognizedObjectObservation else {
              continue
          }
          // Select only the label with the highest confidence.
          let topLabelObservation = objectObservation.labels[0]
          //
          
          //self.label.text = topLabelObservation.identifier
        
        // Doing something here with this String
        
        print(topLabelObservation.identifier)
        self.someData = topLabelObservation.identifier
      }
  }
  // End of adding Detection things
  
  
  
  
  override init() {
    super.init()
    CameraManager.shared.set(self, queue: videoOutputQueue)
    setupSubscriptions()
    setupVision()
  }
  
  
  func setupSubscriptions() {
    //------------
    CameraManager.shared.$error
      
      .receive(on: RunLoop.main)
      
      .map { $0 }
      
      .assign(to: &$error)
    //-------------------
    self.$current
      .receive(on: RunLoop.main)
      .compactMap { $0 }
      .compactMap { buffer in
        // 1
        guard let image = CGImage.create(from: buffer) else {
          return nil
        }
        // 2
        var ciImage = CIImage(cgImage: image)
        // 3
        if self.comicFilter {
          ciImage = ciImage.applyingFilter("CIComicEffect")
        }
        if self.monoFilter {
          ciImage = ciImage.applyingFilter("CIPhotoEffectNoir")
        }
        if self.crystalFilter {
          ciImage = ciImage.applyingFilter("CICrystallize")
        }
        // 4
        return self.context.createCGImage(ciImage, from: ciImage.extent)
      }
      .assign(to: &$frame)

    //------------------------
  }
}
extension ViewModelNew: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(
    _ output: AVCaptureOutput,
    didOutput sampleBuffer: CMSampleBuffer,
    from connection: AVCaptureConnection
  ) {
    if let buffer = sampleBuffer.imageBuffer {
      DispatchQueue.main.async {
        self.current = buffer
      }
    }
    
    
    guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
        return
    }
    
    let exifOrientation = exifOrientationFromDeviceOrientation()
    
    let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: exifOrientation, options: [:])
    do {
        try imageRequestHandler.perform(self.requests)
    } catch {
        print(error)
    }
  }
  
  public func exifOrientationFromDeviceOrientation() -> CGImagePropertyOrientation {
      let curDeviceOrientation = UIDevice.current.orientation
      let exifOrientation: CGImagePropertyOrientation
      
      switch curDeviceOrientation {
      case UIDeviceOrientation.portraitUpsideDown:  // Device oriented vertically, home button on the top
          exifOrientation = .left
      case UIDeviceOrientation.landscapeLeft:       // Device oriented horizontally, home button on the right
          exifOrientation = .upMirrored
      case UIDeviceOrientation.landscapeRight:      // Device oriented horizontally, home button on the left
          exifOrientation = .down
      case UIDeviceOrientation.portrait:            // Device oriented vertically, home button on the bottom
          exifOrientation = .up
      default:
          exifOrientation = .up
      }
      return exifOrientation
  }
}
