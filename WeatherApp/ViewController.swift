//
//  ViewController.swift
//  WeatherApp
//
//  Created by Денис Андреев on 7/10/19.
//  Copyright © 2019 Денис Андреев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        searchBar.delegate = self
    }
    
}



extension ViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        searchBar.resignFirstResponder()
        
        let urlString = "https://api.apixu.com/v1/current.json?key=df6d7f5296d74441bf095518191007 &q=Kiev"
        
        let url = URL(string: urlString)
        
        var locationName:String?
        var temperature:Double?
        
        let task = URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
            do {
                let json  = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let location = json["location"]  {
                    locationName = location["name"] as? String
                }
                
                
                if let current = json["current"] {
                    temperature = current["temp_c"] as? Double
                }
                
                DispatchQueue.main.async {
                    self?.cityLabel.text = locationName
                    self?.temperatureLabel.text = "\(temperature)"
                }
                
            }
            catch let jsonError {
                print(jsonError)
            }
            
        }
        task.resume()
        
    }
}
