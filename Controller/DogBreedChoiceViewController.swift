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
   
   // @IBOutlet var searchTextField: UITextField!
    
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
        var count = 0
        guard searchText != "" else { return }
        var listOfDogs = list.dogBreedList
        var setOfDogs = Set(listOfDogs)
        
        let myNewResuilts = setOfDogs.filter { breed in
            if breed.hasPrefix(searchText) {
                print(breed)
                print(searchText)
                return true
            }
            return false
        }
        
        print(myNewResuilts)
        searchResults = Array(myNewResuilts)
//        searchResults = list.dogBreedList.filter({ breed in
//
//            let lowerCaseBreed = breed.lowercased()
//            let preFixMatch = lowerCaseBreed.hasPrefix(searchText)
//            if preFixMatch {
//                count += 1
//               return true
//            }
//            count += 1
//            return false
//        })
//        searchResults = list.dogBreedList.filter({ (breed) -> Bool in
//            //guard searchText != "" else { return }
//           // let breedMatch = breed.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
//
//            let lowerBreed = breed.lowercased()
//
//            let prefixMatch = lowerBreed.hasPrefix(inputTextLowered)
//
//            return prefixMatch
//        })
        print(count)
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
        
        return cell
        
    }
    //TODO: Finish selection of dog breed
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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


