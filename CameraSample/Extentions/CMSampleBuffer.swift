import Foundation
import UIKit
import AVFoundation

extension CMSampleBuffer {
    func toUIImage() -> UIImage? {
        let pixelBuffer: CVImageBuffer = CMSampleBufferGetImageBuffer(self)!

        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)

        let pixelBufferWidth = CGFloat(CVPixelBufferGetWidth(pixelBuffer))
        let pixelBufferHeight = CGFloat(CVPixelBufferGetHeight(pixelBuffer))
        let imageRect: CGRect = CGRect(x: 0, y: 0, width: pixelBufferWidth, height: pixelBufferHeight)
        let ciContext = CIContext.init()
        let cgimage = ciContext.createCGImage(ciImage, from: imageRect)

        let rawImage = UIImage(cgImage: cgimage!)
        guard let rawCGImage = rawImage.cgImage else { return nil }
        let image = UIImage(cgImage: rawCGImage, scale: rawImage.scale, orientation: .right)
        return image
    }
}
