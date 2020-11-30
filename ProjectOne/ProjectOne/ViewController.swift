//
//  ViewController.swift
//  ProjectOne
//
//  Created by Alanna Romao on 11/5/20.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var pictureViews = [String : Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let savedViews = defaults.object(forKey: "views") as? Data{
            let jsonDecoder = JSONDecoder()
            
            do {
                pictureViews = try jsonDecoder.decode([String : Int].self, from: savedViews)
            } catch {
                print("Failed to load views")
            }
        }
        
        title = "Storm Viewer"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
        for picture in pictures {
            if pictureViews[picture] == nil {
                pictureViews.updateValue(0, forKey: picture)
            }
        }
        print(pictures)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let temp = pictures[indexPath.row]
        cell.textLabel?.text = temp
        cell.detailTextLabel?.text = "Views: " + String(pictureViews[temp]!)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController{
            vc.selectedImage = pictures[indexPath.row]
            vc.title = "\(indexPath.row + 1)" + " of " + "\(pictures.count)"
            if let n = pictureViews[vc.selectedImage!] {
                pictureViews.updateValue(n + 1, forKey: vc.selectedImage!)
                let jsonEncoder = JSONEncoder()
                if let savedData = try? jsonEncoder.encode(pictureViews) {
                    let defaults = UserDefaults.standard
                    defaults.set(savedData, forKey: "views")
                } else {
                    print("Failed to save views")
                }
                tableView.reloadData()
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

