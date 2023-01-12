//
//  DogBreedChoiceViewController.swift
//  Pawk
//
//  Created by Josfry Barillas on 1/9/23.
//

import UIKit

class DogBreedChoiceViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
  
    var list = DogBreeds()
    var searchBar: UISearchController!
    var searchResults = [String]()
    var selectedIndex = 0
    var dogBreedSelection = ""
   
   // @IBOutlet var searchTextField: UITextField!
    // TODO: ADD A DONE BUTTON TO PASSBACK SELECTION
    @IBOutlet var searchBarField: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchBar.searchBar
        searchBar.searchResultsUpdater = self
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.hidesNavigationBarDuringPresentation = false
        searchBar.searchBar.tintColor = .systemOrange
        tableView.dataSource = self
        tableView.delegate = self
        print(list.dogBreedList)
    
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DogFormViewController
        destinationVC.dogBreed = dogBreedSelection
    }
}

extension DogBreedChoiceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let list = list.dogBreedList
        
        if searchBar.isActive {
            return searchResults.count
        } else {
            return list.dogBreedList.count
        }
        
    }
    
    func filterContentForSearchText(searchText: String) {
        let inputTextLowered = searchText.lowercased()
       // var count = 0
        guard searchText != "" else { return }
        var listOfDogs = list.dogBreedList
        var setOfDogs = Set(listOfDogs)
        
        let myNewResuilts = setOfDogs.filter { breed in
            if breed.hasPrefix(searchText) {
               //print(breed)
               //print(searchText)
                return true
            }
            return false
        }
        
        print(myNewResuilts)
        searchResults = Array(myNewResuilts)
        print(searchResults)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.searchBar.text != "" else { return }
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText: searchText)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "dogBreed")
        //cell.textLabel?.text = "\(list.dogBreedList[indexPath.row])"
        guard let textFieldText = searchBar.searchBar.text else { return cell }
        if searchBar.isActive && textFieldText != "" {
            cell.textLabel?.text = "\(searchResults[indexPath.row])"
        } else {
            cell.textLabel?.text = "\(list.dogBreedList[indexPath.row])"
        }
        
        let breed = (searchBar.isActive) ? searchResults[(indexPath as NSIndexPath).row] : list.dogBreedList[(indexPath as NSIndexPath).row]
        cell.accessoryType = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let textFieldText = searchBar.searchBar.text else { return }
       
        if searchBar.isActive && textFieldText != "" {
            let selectedBreed = searchResults[indexPath.row]
            dogBreedSelection = selectedBreed
            print(selectedBreed)
        } else {
            let selectedBreed = list.dogBreedList[indexPath.row]
            dogBreedSelection = selectedBreed
            print(selectedBreed)
        }

        tableView.reloadData()
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

extension DogBreedChoiceViewController {
    
    
    public class DogBreeds {
        let dogBreedListFile = "DogBreedList.txt"
        var dogBreedList = [String]()
        
        public init () {
            dogBreedList = FileParser.getLines(from: dogBreedListFile)
        }
    }
    struct FileParser {

        
        
        static func getLines(from fileName: String) -> [String] {
            let mainPath = #file
            let lastPathComponent = mainPath.components(separatedBy: "/").last ?? ""
            let filePath = mainPath.replacingOccurrences(of: lastPathComponent, with: fileName)
            let contents = (try? String(contentsOfFile: filePath, encoding: .utf8)) ?? ""
            var names = contents.components(separatedBy: .newlines)
            names.removeAll(where: { $0.isEmpty })
            
            let filteredNames = names.map { breed in
                if breed.contains("[") {
                    if let badIndex = (breed.range(of: "[")?.lowerBound) {
                        let dogBreedName = String(breed.prefix(upTo: badIndex))
                        return dogBreedName
                    }
                }
                return breed
            }
            print(names)
            print(filteredNames)
            return filteredNames
        }
    }
}

extension DogBreedChoiceViewController {
    
}


