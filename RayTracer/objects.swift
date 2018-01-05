//
//  objects.swift
//  RayTracer
//
//  Created by David Garcia on 1/4/18.
//  Copyright © 2018 Ayy Lmao LLC. All rights reserved.
//

import Foundation
import simd

public struct hit_record {
    var t: Double
    var p: double3
    var normal:  double3

    init() {
        t = 0.0
        p = double3(x: 0.0, y: 0.0, z:  0.0)
        normal = double3(x: 0.0, y: 0.0, z: 0.0)
    }
}

public protocol hitable {
    func hit(r: ray, _ tmin: Double, _ tmax: Double, _ rec: inout hit_record) -> Bool
}

public class sphere: hitable {
    var center = double3(x: 0.0, y: 0.0, z: 0.0)
    var radius = Double(0.0)
    public init(c: double3, r: Double) {
        center = c
        radius = r
    }

    public func hit(r: ray, _ tmin: Double, _ tmax: Double, _ rec: inout hit_record) -> Bool {
        let oc = r.origin - center
        let a = dot(r.direction, r.direction)
        let b = dot(oc, r.direction)
        let c = dot(oc, oc) - radius*radius
        let discriminant = b*b - a*c
        if discriminant > 0 {
            var t = (-b - sqrt(discriminant)) / a
            if t < tmin {
                t = (-b + sqrt(discriminant)) / a
            }
//            print ("\(tmin) < \(t) < \(tmax)")
            if tmin < t && t < tmax {
                rec.t = t
                rec.p = r.point_at_parameter(t: rec.t)
                rec.normal = (rec.p - center) / double3(radius)
                return true
            }
        }
        return false
    }
}

public class hitable_list: hitable {
    var list = [hitable]()
    public func add(_ h: hitable) {
        list.append(h)
    }
    public func hit(r: ray, _ tmin: Double, _ tmax: Double, _ rec: inout hit_record) -> Bool {
        var hit_anything = false
        for item in list {
            if (item.hit(r: r, tmin, tmax, &rec)) {
                hit_anything = true
            }
        }
        return hit_anything
    }
}

//This is to create matte materials
public func random_in_unit_sphere() -> double3 {
    var p = double3()
    repeat {
        p = 2.0 * double3(x: Double(drand48()), y: Double(drand48()), z: Double(drand48())) - double3(x: 1, y:1, z: 1)
    } while dot(p,p) >= 1.0
    return p
}
