//
//  ray.swift
//  RayTracer
//
//  Created by David Garcia on 1/2/18.
//  Copyright © 2018 Ayy Lmao LLC. All rights reserved.
//

import Foundation

public struct ray {
    public var origin: vec3
    public var direction: vec3
    public func point_at_parameter(t: Double) -> vec3{
        return origin + t * direction
    }

    public init(origin: vec3, direction: vec3)
    {
        self.origin = origin
        self.direction = direction
    }
}

public func color(r: ray) -> vec3 {
    var result = vec3(x: 0,y: 0,z: 0)
    let minusZ = vec3(x: 0, y:0, z: -1.0)
    var t = hit_sphere(center: minusZ, 0.5, r)
    if t > 0.0 {
        let norm = unit_vector(r.point_at_parameter(t:t) - minusZ)
        return 0.5 * vec3(x: norm.x + 1.0, y: norm.y + 1.0, z: norm.z + 1.0)
    }
    let unit_direction = unit_vector(r.direction)
    t = 0.5 * (unit_direction.y + 1.0)
    result = (1.0 - t) * vec3(x: 1.0, y: 1.0, z:1.0) + t * vec3(x: 0.5, y: 0.7, z:1.0)
    return result
}

public func hit_sphere(center: vec3, _ radius: Double, _ r: ray) -> Double {
    let oc = r.origin - center
    let a = dot(r.direction, r.direction)
    let b = 2.0 * dot(oc, r.direction)
    let c = dot(oc, oc) - radius * radius
    let discriminant = b * b - 4 * a * c
    if discriminant < 0 {
        return -1.0
    } else {
        return (-b - sqrt(discriminant)) / (2.0)
    }
}
