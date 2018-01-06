//
//  ray.swift
//  RayTracer
//
//  Created by David Garcia on 1/2/18.
//  Copyright © 2018 Ayy Lmao LLC. All rights reserved.
//

import Foundation
import simd

public func dot (_ left: double3, _ right: double3) -> Double {
    return left.x * right.x + left.y * right.y + left.z * right.z
}

public func unit_vector (_ v: double3) -> double3 {
    let length : Double = sqrt(dot(v,v))
    return double3(x: v.x/length, y:v.y/length, z: v.z/length)
}

public struct ray {
    public var origin: double3
    public var direction: double3
    public func point_at_parameter(t: Double) -> double3{
        return origin + t * direction
    }

    public init(origin: double3, direction: double3)
    {
        self.origin = origin
        self.direction = direction
    }
}

public func color(r: ray, world: hitable, _ depth: Int) -> double3 {
    var rec = hit_record()
    if world.hit(r: r, 0.001, Double.infinity, &rec) {
        var scattered = r
        var attenuation = double3()
        //We either attentuate the ray and scatter it or we absorb it
        if depth < 50 && rec.mat_ptr.scatter(ray_in: r, rec, &attenuation, &scattered)
        {
            return attenuation * color(r: scattered, world: world, depth + 1)
        } else {
            return double3(x: 0, y: 0, z: 0)
        }
    }
    else {
        let unit_direction = normalize(r.direction)
        let t = 0.5 * (unit_direction.y + 1)
        return (1.0 - t) * double3(x: 1, y: 1, z: 1) + t * double3(x: 0.5, y: 0.7, z: 1.0)
    }
}

public struct camera {
    let lower_left_corner: double3
    let horizontal: double3
    let vertical: double3
    let origin: double3

    public init() {
        lower_left_corner = double3(x: -2.0, y: 1.0, z: -1.0)
        horizontal = double3(x:4.0, y: 0, z:0)
        vertical = double3(x: 0, y: -2.0, z:0)
        origin = double3()
    }

    public func get_ray(_ u: Double, _ v: Double) -> ray {
        return ray(origin: origin, direction: lower_left_corner + u * horizontal + v * vertical - origin)
    }
}
