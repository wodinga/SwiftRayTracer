//
//  ViewController.swift
//  RayTracer
//
//  Created by David Garcia on 1/2/18.
//  Copyright © 2018 Ayy Lmao LLC. All rights reserved.
//

import Cocoa
import CoreImage
class ViewController: NSViewController {

    @IBOutlet var CIView: CIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}

