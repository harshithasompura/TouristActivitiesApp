import Foundation

//Activity Singleton
class ActivityDb {

  static let shared = ActivityDb()
  private init() {}
  
  //MARK: Variables
    
  //List of Activities
  private var activityList: [Activity] = [
    Activity(
      name: "Explore Forbidden Vancouver",
      description:
        "Hit the mean streets of Vancouver with a professional guide as you learn about rum-runners, mobsters, and dirty cops on a walk through Gastown.",
      hostedBy: "Will",
      photo: "activity-1",
      pricingPerPerson: 36.0,
      website:
        "https://www.airbnb.ca/experiences/660055?guests=1&adults=1&s=67&unique_share_id=f37c97a5-7d31-4d90-a384-b7a839f189af"
    ),
    Activity(
      name: "Hiking with Goats",
      description:
        "A guided hike through beautiful lake and mountain scenery, hosted by Pickles and Peanut, French Alpine goat brothers!",
      hostedBy: "Kristina",
      photo: "activity-2",
      pricingPerPerson: 45.0,
      website:
        "https://www.airbnb.ca/experiences/2432389?guests=1&adults=1&s=67&unique_share_id=1fb730dd-f203-49ce-a09e-4cf7d1dfd460"
    ),
    Activity(
      name: "Vancouver by Bike",
      description:
        "Beginning at our bike shop in the heart of Downtown, we'll get fitted for bikes then join the protected bikeway right outside. ",
      hostedBy: "Josh",
      photo: "activity-3",
      pricingPerPerson: 105.0,
      website:
        "https://www.airbnb.ca/experiences/904623?guests=1&adults=1&s=67&unique_share_id=b804498b-05e5-4cf6-b64b-cf677c4c5f33"
    ),
    Activity(
      name: "Lighthouse Park Coastline tour",
      description:
        "Rugged and pristine coastlines are in the itinerary. The feeling that washes over you like the sound of the eagles and waves is delightful.",
      hostedBy: "Natalie",
      photo: "activity-4",
      pricingPerPerson: 52.0,
      website:
        "https://www.airbnb.ca/experiences/1228364?guests=1&adults=1&s=67&unique_share_id=7396b8bb-e74d-4b62-a394-c58a82043f61"
    ),
    Activity(
      name: "Stawamus Chief Hike & Photography",
      description:
        "We'll drive from downtown Vancouver on the scenic Sea-to-Sky Highway to Squamish.",
      hostedBy: "Nafees",
      photo: "activity-5",
      pricingPerPerson: 238.0,
      website:
        "https://www.airbnb.ca/experiences/131977?guests=1&adults=1&s=67&unique_share_id=4e934b5e-2889-4723-85cb-18b850732654"
    ),

  ]

  //single activity detail handler
  private var currentActivity: Activity = Activity(
    name: "", description: "", hostedBy: "", photo: "", pricingPerPerson: 0.0, website: "")
  
  //favourites list
  private var favouriteActivityList: [Activity] = []
  
    
  //MARK: Helpers/methods
  func getAll() -> [Activity] {
    return activityList
  }

  func totalActivities() -> Int {
    return activityList.count
  }

  func setActivityDetail(of: Activity) {
    //details about a single activity
    currentActivity = of
  }

  func getActivityDetail() -> Activity {
    return currentActivity
  }
  
  func setFavouriteActivity(of: Activity){
    //set a favourite activity
    favouriteActivityList.append(of)
    print(#function, of.name)
  }
    
  func removeFavouriteActivity(of: Activity){
      if let index = favouriteActivityList.firstIndex(where: {$0.name == of.name}){
          print(#function, of.name)
          print("Removing.. \(favouriteActivityList[index].name) from favourites list")
          favouriteActivityList.remove(at: index)
      }
  }
  
  func getFavouritesList() -> [Activity]{
        return favouriteActivityList
  }
    
}
