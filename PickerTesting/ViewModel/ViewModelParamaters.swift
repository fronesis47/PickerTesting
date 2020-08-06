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

    var name: String
    var years: [Int]

//this should allow me to add to years: var brand = Brand(); brand.models.addYear(2022)
    mutating func addYear(year: Int) {
      years += [year]
    }
    

// void init could be []; generic parameters init required self
    init () {
        self.name = "Paul"
        self.years = []
    }

    init(name: String, years: [Int]) {
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
//we have the brand, but not the model, so add that
//SC: OK, but if clause adds brand/model AND year; here we add model AND year to same brand
              brands[allFrames[i].brand]?.models.append(Model(name: allFrames[i].model, years: [allFrames[i].year]))

//Must be set non-nil; avoids repeating models. Old code complex; for years block too; not needed
             modelHelper[allFrames[i].brand]?[allFrames[i].model] = (brands[allFrames[i].brand]?.models.count)! - 1
//            modelHelper[allFrames[i].brand]?[allFrames[i].model] = 0
//  dump(modelHelper)

//MARK: years did not work
// This code block below was firing every time we iterated and found a brand and model present
// it then appended a year..but there was already a year there (added under the if or the else if above)
// so for each model in allFrames, we did NOT repeat the brand or model, but we DID ADD another year to the years array

// BOTTOM LINE: I see no way that with ONE iteration through allFrames it's possible to do both of these things:
// 1) NOT repeat models; 2) get multiple years for same model name.
// Easy soluton is to just deal with this in the data (new model year gets unique model name)
// But I'm curious how it could be dealt with in the code. I can only think of doing it AFTER the fact, i.e.
// by going back through all frames again to find same model/new year combos, then APPEND them
// though this might be EASIER to do while the data is still in dictionary form – not sure

            
//        } else {
////
//            let modelIdx = modelHelper[allFrames[i].brand]?[allFrames[i].model] ?? 0
//            print(modelIdx)
//            brands[allFrames[i].brand]?.models[modelIdx].years.append(allFrames[i].year.description)
//////////
            
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

