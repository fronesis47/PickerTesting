//
//  ViewModelParamaters.swift
//  BikeFitPlus1
//
//  Created by Samuel Chambers on 8/3/20.
//  Copyright © 2020 Samuel Chambers. All rights reserved.
//

import Foundation
import Combine

// the data is right; i just need to figure out how to use it





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
        self.name = "yourMom"
        self.models = []
    }
    
    init(name:String, models:[Model]) {
        self.name = name
        self.models = models
    }

// do I need same for years in models, or will they come along for the ride?
    mutating func add(model: Model) {
      models.append(model)
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
    var years: [String]
    
    init () {
        
        self.name = "Paul"
        self.years = []
    }

    init(name:String, years:[String]) {
        self.name = name
        self.years = years
    }
}

//ORIGINAL – gets data but it's a mess
//func getBrandsAll() -> [Brand] {
//    var brands: [Brand] = []
//    let allFrames = frameData
//        for i in 0..<allFrames.count {
//            brands.append(Brand(name: allFrames[i].brand, models: [Model(name:  allFrames[i].model, years: [allFrames[i].year.description])]))
//        }
//        let unique = Array(Set(brands))
//        let sorted = unique.sorted()
////        dump(sorted)
//        return sorted
//}


// Paul flavor

func getBrandsAll() -> [Brand] {
    var brands: [String : Brand] = [:]
    var modelHelper: [String : [String : Int]] = [:]
    let allFrames = frameData

    for i in 0..<allFrames.count {
        if brands[allFrames[i].brand] == nil {
            brands[allFrames[i].brand] = Brand(name: allFrames[i].brand, models: [Model(name: allFrames[i].model, years: [allFrames[i].year.description])])

//note the index of the model within the brand
    modelHelper[allFrames[i].brand] = [allFrames[i].model: 0]
        } else if modelHelper[allFrames[i].brand]?[allFrames[i].model] == nil {
            //we have the brand, but not the model, so add that
          brands[allFrames[i].brand]?.models.append(Model(name: allFrames[i].model, years: [allFrames[i].year.description]))
            
            //and note the index where this model appears
            modelHelper[allFrames[i].brand]?[allFrames[i].model] = (brands[allFrames[i].brand]?.models.count)! - 1
//        } else {
////we have this brand and this model, so we just need to add the year
//            let modelIdx = modelHelper[allFrames[i].brand]?[allFrames[i].model] ?? 0
//            print(modelIdx)
//            brands[allFrames[i].brand]?.models[modelIdx].years.append(allFrames[i].year.description)
            }
    }
    
        
    
//the only thing that might not be unique at this point is the years
//that's non-trivial, but ima let you figure that out

        var brandslist: [Brand] = []
        
        for (_,value) in brands {
            brandslist.append(value)
        }
    
        let sorted = brandslist.sorted()
        dump(sorted)
        return sorted
}




// the idea here was to collect all the models belonging to one brand in the newModels array
// then when we came to a new brand, write the models into the current brand
// This doesn't deal with brands only listed once (Orbea)
// and right now the loop just keeps going repeating cannondale and canyon over and over

//func combineSort (uglyData: [Brand]) -> [Brand] {
//    var cleanData: [Brand] = []
//    var newModels = [Model]()
//    var counter = 0
//        while counter < 11 {
//            if uglyData[counter].name == uglyData[counter+1].name {
//                newModels.append(contentsOf: uglyData[counter].models)
////                dump(newModels)
//                }
//
//
//            else if uglyData[counter].name != uglyData[counter+1].name {
//                cleanData.append(Brand(name: uglyData[counter].name, models: newModels))
////                cleanData.append(Brand(name: uglyData[counter+1].name, models: [Model(name: uglyData[counter+1].models[0].name, years: uglyData[counter+1].models[0].years)]))
//
//
//                    newModels = []
//                }
//                counter += 1
//        }
////    let unique = Array(Set(cleanData)) //this attempt to remove duplicates failed (why????)
//    dump(cleanData)
//    return cleanData
//}


// this begins to combine models into brands, but it creates EVERY possible
// combinaton of two models, and it eliminates nothing
//func combineSort (uglyData: [Brand]) -> [Brand] {
//    var cleanData: [Brand] = []
////    var counter = 0
//    for i in 0..<uglyData.count {
//        for j in 1..<(uglyData.count - 1) {
//            if uglyData[i].name == uglyData[j].name {
//                cleanData.append(Brand(name: uglyData[i].name, models: [Model(name: uglyData[i].models[0].name, years: [uglyData[i].models[0].years[0].description]),Model(name: uglyData[j].models[0].name, years: [uglyData[j].models[0].years[0].description])]))
////                counter += 1
//                }
////            counter = 0
//        }
//    }
//    dump(cleanData)
//    return cleanData
//}





//
//
//
//class SearchArrays: ObservableObject {
//
//    var brand: String
//    var model: String
//    var year: Int
//
//    init() {
//        self.brand = ""
//        self.model = ""
//        self.year = 0
//    }
//
//    @Published var brands = getBrands()
//    @Published var models = getAllModels()
//    @Published var years = getAllYears()
//}
//
//
//
//func getBrands() -> [String] {
//    var brands: [String] = []
//    let allFrames = frameData
//        for i in 0..<allFrames.count {
//            brands.append(allFrames[i].brand)
//        }
//    let setBrands = Set(brands)
//    brands = Array(setBrands)
//    return brands.sorted()
//
//}
//
//func getAllModels() -> [String] {
//    var models: [String] = []
//    let allFrames = frameData
//        for i in 0..<allFrames.count {
//            models.append(allFrames[i].model)
//        }
//        let setModels = Set(models)
//        models = Array(setModels)
//        return models.sorted()
//}
//
//
//func getAllYears() -> [Int] {
//    var years: [Int] = []
//    let allFrames = frameData
//    for i in 0..<allFrames.count {
//        years.append(allFrames[i].year)
//    }
//    let setYears = Set(years)
//    years = Array(setYears)
//    return years.sorted().reversed()
//}
//
//
//func getModelsFromBrand (brand: String) -> [String] {
//    var models: [String] = []
//    let allFrames = frameData
//    for i in 0..<allFrames.count {
//        if allFrames[i].brand == brand {
//            models.append(allFrames[i].model)
//        }
//    }
//        let setModels = Set(models)
//        models = Array(setModels)
//        return models.sorted()
//}
//
//func getYearsFromModels (model: String) -> [Int] {
//    var years: [Int] = []
//    let allFrames = frameData
//    for i in 0..<allFrames.count {
//        if allFrames[i].model == model {
//            years.append(allFrames[i].year)
//        }
//    }
//    let setYears = Set(years)
//    years = Array(setYears)
//    return years.sorted().reversed()
//}
//




