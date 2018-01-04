//
//  pixel.swift
//  RayTracer
//
//  Created by David Garcia on 1/2/18.
//  Copyright © 2018 Ayy Lmao LLC. All rights reserved.
//

import Foundation
import CoreImage
import simd

public struct Pixel{
    var r,g,b,a: UInt8
    public init(red: UInt8, green: UInt8, blue: UInt8){
        r = red
        g = green
        b = blue
        a = 255
    }

}

public func makePixelSet(width: Int, height: Int) -> ([Pixel], Int, Int) {
    var pixel  = Pixel(red: 0, green: 0, blue: 0)
    var pixels = [Pixel](repeating: pixel, count: width * height)
    let lower_left_corner = double3(x: -2.0, y: 1.0, z: -1.0)
    let horizontal = double3(x:4.0, y: 0.0, z:0.0)
    let vertical = double3(x: 0.0, y: -2.0, z: 0.0)
    let origin = double3()
    for i in 0..<width {
        for j in 0..<height {
            let u = Double(i) / Double(width)
            let v = Double(j) / Double(height)
            let r  = ray(origin: origin, direction: lower_left_corner + u * horizontal + v * vertical)
        
            let col = color(r: r)
            pixel = Pixel(red: UInt8(col.x * 255), green: UInt8(col.y * 255), blue: UInt8(col.z * 255))
            pixels[i + j * width] = pixel
        }
    }
    return(pixels, width, height)
}

public func imageFromPixels(pixels: ([Pixel], width: Int, height: Int)) -> CIImage {
    let bitsPerComponent = 8
    let bitsPerPixel = 32
    let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

    let providerRef = CGDataProvider.init(data:NSData(bytes: pixels.0, length: pixels.0.count * MemoryLayout<Pixel>.size))

    let image = CGImage.init(width: pixels.1, height: pixels.2, bitsPerComponent: bitsPerComponent,
                             bitsPerPixel: bitsPerPixel, bytesPerRow: pixels.1 * MemoryLayout<Pixel>.size,
                             space: rgbColorSpace, bitmapInfo: bitmapInfo, provider: providerRef!,
                             decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
    return CIImage.init(cgImage: image!)
}
