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

public func imageFromPixels(_ width: Int, _ height: Int) -> CIImage {
    var pixel  = Pixel(red: 0, green: 0, blue: 0)
    var pixels = [Pixel](repeating: pixel, count: width * height)
    let lower_left_corner = double3(x: -2.0, y: 1.0, z: -1.0)
    let horizontal = double3(x:4.0, y: 0.0, z:0.0)
    let vertical = double3(x: 0.0, y: -2.0, z: 0.0)
    let origin = double3()
    let world = hitable_list()
    var object = sphere(c: double3(x: 0, y: -100.5, z: -1), r: 100)
    world.add(object)
    object = sphere(c: double3(x: 0, y: 0, z: -1), r: 0.5)
    world.add(object)
    for i in 0..<width {
        for j in 0..<height {
            let u = Double(i) / Double(width)
            let v = Double(j) / Double(height)
            let r  = ray(origin: origin, direction: lower_left_corner + u * horizontal + v * vertical)

            let col = color(r: r, world: world)
            pixel = Pixel(red: UInt8(col.x * 255), green: UInt8(col.y * 255), blue: UInt8(col.z * 255))
            pixels[i + j * width] = pixel
        }
    }
    let bitsPerComponent = 8
    let bitsPerPixel = 32
    let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

    let providerRef = CGDataProvider.init(data:NSData(bytes: pixels, length: pixels.count * MemoryLayout<Pixel>.size))

    let image = CGImage.init(width: width , height: height, bitsPerComponent: bitsPerComponent,
                             bitsPerPixel: bitsPerPixel, bytesPerRow: width * MemoryLayout<Pixel>.size,
                             space: rgbColorSpace, bitmapInfo: bitmapInfo, provider: providerRef!,
                             decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
    return CIImage.init(cgImage: image!)
}
