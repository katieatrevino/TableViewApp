//
//  ViewController.swift
//  TableStory
//
//  Created by Trevino, Katie on 3/20/24.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "Mochas and Javas", neighborhood: "LBJ Drive", desc: "This coffee shop offers a nice and calm atmosphere to get some homework done or enjoy coffee with a friend.", lat: 29.891651917822784, long: -97.94064250589906, imageName: "rest1"),
    Item(name: "The Coffee Bar", neighborhood: "Downtown San Marcos", desc: "Easily accessible downtown, if you ever have down time on campus, take a short walk to this coffee shop for a nice break.", lat: 29.885117920981415, long: -97.93993237216877, imageName: "rest2"),
    Item(name: "Jo’s Cafe ", neighborhood: "Texas State Campus", desc: "Close to campus, this coffee shop offers both outdoor and indoor seating with delicious food options available for you and your classmates.", lat: 29.883917706896867, long: -97.94578547984807, imageName: "rest3"),
    Item(name: "The Native Blends", neighborhood: "Downtown", desc: "Off campus come to this cozy coffee shop and enjoy quiet vibes with relaxing music and get a smoothie. ", lat: 29.88736941359464, long: -97.93809118434653, imageName: "rest4"),
    Item(name: "Tantra SMTX", neighborhood: "Hopkins", desc: "Right off campus, not too far enjoy live music and good vibes with this new and hip coffee shop.", lat: 29.8840809763216, long: -97.94405360311765, imageName: "rest5")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var theTable: UITableView!
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
   }


   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
       let item = data[indexPath.row]
       cell?.textLabel?.text = item.name
       
       //Add image references
                     let image = UIImage(named: item.imageName)
                     cell?.imageView?.image = image
                     cell?.imageView?.layer.cornerRadius = 10
                     cell?.imageView?.layer.borderWidth = 5
                     cell?.imageView?.layer.borderColor = UIColor.white.cgColor
       
       
       
       return cell!
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let item = data[indexPath.row]
       performSegue(withIdentifier: "ShowDetailSegue", sender: item)
     
   }
       
    // add this function to original ViewController
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "ShowDetailSegue" {
                 if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                     // Pass the selected item to the detail view controller
                     detailViewController.item = selectedItem
                 }
             }
         }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        
        //set center, zoom level and region of the map
               let coordinate = CLLocationCoordinate2D(latitude: 29.887340551827577, longitude: -97.9428232146469)
               let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
               mapView.setRegion(region, animated: true)
               
            // loop through the items in the dataset and place them on the map
                for item in data {
                   let annotation = MKPointAnnotation()
                   let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                   annotation.coordinate = eachCoordinate
                       annotation.title = item.name
                       mapView.addAnnotation(annotation)
                       }

    }


}

