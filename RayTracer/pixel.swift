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
    let world = hitable_list()
    var object = sphere(c: double3(x: 0, y: -100.5, z: -1), r: 100, m: lambertian(a: double3(x:0, y: 0.7, z:0.3)))
    world.add(object)
    object = sphere(c: double3(x: 0, y: 0, z: -3), r: 0.5,m: metal(a: double3(x: 0.8, y: 0.8, z: 0.8), f: 0.1))
    world.add(object)
    object = sphere(c: double3(x: 1, y: 0, z: -1.1), r: 0.5,  m: lambertian(a: double3(x:0.3, y: 0, z:0)))
    world.add(object)
    object = sphere(c: double3(x: -1, y: 0, z: -1.1), r: 0.5, m: metal(a: double3(x: 0.8, y: 0.8, z: 0.8), f: 0.7))
    world.add(object)
    let cam = camera()
    for i in 0..<width {
        for j in 0..<height {
            let ns = 10
            var col = double3()
            //Sampling for color smoothing
            for _ in 0..<ns {
                let u = (Double(i) + Double(drand48())) / Double(width)
                let v = (Double(j) + Double(drand48())) / Double(height)
                let r  = cam.get_ray(u,v)
                col += color(r: r, world: world, 0)
            }

            col /= double3(Double(ns))
            col = double3(sqrt(col.x), sqrt(col.y), sqrt(col.z))
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
