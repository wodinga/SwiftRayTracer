//
//  vec3.swift
//  RayTracer
//
//  Created by David Garcia on 1/2/18.
//  Copyright © 2018 Ayy Lmao LLC. All rights reserved.
//

import Foundation

public struct vec3  {
    public var x = 0.0, y = 0.0, z = 0.0

    public init(x: Double, y: Double, z: Double)
    {
        self.x = x
        self.y = y
        self.z = z
    }
    public init(){}
}

public func * (left: Double, right: vec3) -> vec3 {
    return vec3(x: left * right.x, y: left * right.y, z: left * right.z)
}

public func + (left: vec3, right: vec3) -> vec3 {
    return vec3(x:left.x + right.x, y: left.y + right.y, z: left.z + right.z)
}

public func - (left: vec3, right: vec3) -> vec3 {
    return vec3(x:left.x - right.x, y: left.z - right.y, z: left.z - right.z)
}

public func dot (_ left: vec3, _ right: vec3) -> Double {
    return left.x * right.x + left.y * right.y + left.z * right.z
}

public func unit_vector (_ v: vec3) -> vec3 {
    if(dot(v,v)<=0)
    {
        print("fuck")
    }
    let length : Double = sqrt(dot(v,v))
    return vec3(x: v.x/length, y:v.y/length, z: v.z/length)
}
