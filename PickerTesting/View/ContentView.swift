import Foundation
import SwiftUI

struct ContentView: View {

    let brands = getBrandsAll()
    
    @State private var chosenBrand = 0
    @State private var chosenModel = 0
    @State private var chosenYear = 0
    
    
    var body: some View {

 // I think these pickers are CORRECT; they just need cleaned data
        VStack {
            Picker(selection: $chosenBrand, label: Text("Brand")) {
                ForEach(0..<brands.count) {
                    Text(self.brands[$0].name)
                    }
            }
            
            Picker(selection: $chosenModel, label: Text("Model")) {
                ForEach(0..<brands[chosenBrand].models.count) {
                    Text(self.brands[chosenBrand].models[$0].name)
                    }
            }
            
            Picker(selection: $chosenYear, label: Text("Year")) {
                ForEach(0..<brands[chosenBrand].models[chosenModel].years.count) {
                    Text(self.brands[chosenBrand].models[chosenModel].years[$0])
                    }
            }
            
            
        }
    }
}



        
//        Text(brands[0].name)
//
//        Text(brands[1].models[0].name)
//
//        Text(brands[2].models[0].years[0])
        
        

        



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
