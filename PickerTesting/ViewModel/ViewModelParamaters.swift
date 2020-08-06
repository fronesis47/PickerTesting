//
//  ViewModelParamaters.swift
//  BikeFitPlus1
//
//  Created by Samuel Chambers on 8/3/20.
//  Copyright © 2020 Samuel Chambers. All rights reserved.

import Foundation
import Combine

struct Brand: Hashable, Comparable {
    static func == (lhs: Brand, rhs: Brand) -> Bool {
        return lhs.name == rhs.name && lhs.models == rhs.models
    }
    
    static func <(lhs: Brand, rhs: Brand) -> Bool {
        return lhs.name < rhs.name
    }
    
    var name: String
    var models: [Model]

    init () {
        self.name = "Bob"
        self.models = []
    }
    
    init(name:String, models:[Model]) {
        self.name = name
        self.models = models
    }
}

struct Model: Hashable, Comparable {
    static func == (lhs: Model, rhs: Model) -> Bool {
        return lhs.name == rhs.name && lhs.years == rhs.years
    }
    
    static func <(lhs: Model, rhs: Model) -> Bool {
        return lhs.name < rhs.name
    }
    
    
    func yearAt (index: Int) -> Int {
        return Array(self.years)[index]
    }

    var name: String
    var years: Set<Int>

//this should allow me to add to years: var brand = Brand(); brand.models.addYear(2022)
//    mutating func addYear(year: Int) {
//      years += [year]
//    }
    

// void init could be []; generic parameters init required self
    init () {
        self.name = "Paul"
        self.years = Set<Int>()
    }

    init(name: String, years: Set<Int>) {
        self.name = name
        self.years = years
    }
}


func getBrandsAll() -> [Brand] {
    var brands: [String : Brand] = [:]
    var modelHelper: [String : [String : Int]] = [:]
    let allFrames = frameData
    
    for i in 0..<allFrames.count {
        if brands[allFrames[i].brand] == nil {
            brands[allFrames[i].brand] = Brand(name: allFrames[i].brand, models: [Model(name: allFrames[i].model, years: [allFrames[i].year])])

                modelHelper[allFrames[i].brand] = [allFrames[i].model : 0]

        } else if modelHelper[allFrames[i].brand]?[allFrames[i].model] == nil {

              brands[allFrames[i].brand]?.models.append(Model(name: allFrames[i].model, years: [allFrames[i].year]))

//Must be set non-nil; avoids repeating models. Old code complex; for years block too; not needed
             modelHelper[allFrames[i].brand]?[allFrames[i].model] = (brands[allFrames[i].brand]?.models.count)! - 1



        } else {

        let modelIdx = modelHelper[allFrames[i].brand]?[allFrames[i].model] ?? 0
        print(modelIdx)
        brands[allFrames[i].brand]?.models[modelIdx].years.insert(allFrames[i].year)


        }
        }
    
//    dump(brands)
        var brandslist: [Brand] = []
        
        for (_,value) in brands {
                brandslist.append(value)
            
        }
        let sorted = brandslist.sorted()
        dump(sorted)
    
    
    
    
    
    
    
    
    
    
        return sorted
}

