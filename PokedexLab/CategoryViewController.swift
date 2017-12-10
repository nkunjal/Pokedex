//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = collectionRows.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! MyTableViewCell
        let pokemon = pokemonArray![indexPath.row]
        cell.name.text = pokemon.name
        if let image = cachedImages[indexPath.row] {
            cell.photo.image = image
        } else {
            let url = URL(string: pokemon.imageUrl)!
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let _ = response as? HTTPURLResponse {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.cachedImages[indexPath.row] = image
                            DispatchQueue.main.async {
                                cell.photo.image = UIImage(data: imageData)
                            }
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code")
                    }
                }
            }
            downloadPicTask.resume()
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryToPokemonSegue" {
            if let dest = segue.destination as? PokemonInfoViewController {
                let selectedRow = sender as! Int
                dest.pokemon = pokemonArray![selectedRow]
                dest.image = cachedImages[selectedRow]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "categoryToPokemonSegue", sender: indexPath.row)
    }

    
        
    @IBOutlet weak var collectionRows: UITableView!
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionRows.delegate = self
        collectionRows.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
