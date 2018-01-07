//
//  material.swift
//  RayTracer
//
//  Created by Rafael Garcia on 1/5/18.
//  Copyright © 2018 Ayy Lmao LLC. All rights reserved.
//

import Foundation
import simd

public protocol material {
        func scatter(ray_in: ray, _ rec: hit_record, _ attenuation: inout double3, _ scattered: inout ray) -> Bool
}

//Diffuse spheres
public class lambertian: material {
    //Measure of reflectiveness
    var albedo: double3

    public init(a: double3) {
        albedo = a
    }
    public func scatter(ray_in: ray, _ rec: hit_record, _ attenuation: inout double3, _ scattered: inout ray) -> Bool{
        let target = rec.p + rec.normal + random_in_unit_sphere()
        //Scatter
        scattered = ray(origin: rec.p, direction: target - rec.p)
        attenuation = albedo
        return true
    }
    
}

//Metallic spheres
public class metal: material {

    var albedo: double3
    var fuzz: Double
    init(a: double3, f: Double) {
        albedo = a
        if f < 1 {
            fuzz = f
        }
        else {
            fuzz = 1
        }
    }

  public func scatter(ray_in: ray, _ rec: hit_record, _ attenuation: inout double3, _ scattered: inout ray) -> Bool {
        let reflected = reflect(normalize(ray_in.direction), n: rec.normal)
        scattered = ray(origin: rec.p, direction: reflected + fuzz * random_in_unit_sphere())
        attenuation = albedo
        return dot(scattered.direction, rec.normal) > 0
    }

}
