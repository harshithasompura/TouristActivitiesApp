import Foundation
import UIKit

class Activity {
    //MARK: Variables
    let name:String
    let description:String
    let hostedBy:String
    let photo:String
    let pricingPerPerson:Double
    let website:String
    
    //MARK: init()
    init(name:String, description:String, hostedBy:String, photo:String, pricingPerPerson:Double, website:String){
        self.name = name
        self.description = description
        self.hostedBy = hostedBy
        self.photo = photo
        self.pricingPerPerson = pricingPerPerson
        self.website = website
    }
}
