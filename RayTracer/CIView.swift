//
//  CIView.swift
//  RayTracer
//
//  Created by David Garcia on 1/3/18.
//  Copyright © 2018 Ayy Lmao LLC. All rights reserved.
//

import Cocoa

class CIView: NSView {
    let width = 800
    let height = 400
    let image:CIImage
   
    required init?(coder: NSCoder) {
        let pixelSet = makePixelSet(width: width, height: height)
        image = imageFromPixels(pixels: pixelSet)
        super.init(coder: coder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let context = NSGraphicsContext.current?.cgContext

        if let cgImg = image.cgImage {
            context?.draw(cgImg, in: self.frame)
        }
    }
    
}
