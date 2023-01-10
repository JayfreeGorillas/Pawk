//
//  DogBreedChoiceViewController.swift
//  Pawk
//
//  Created by Josfry Barillas on 1/9/23.
//

import UIKit

class DogBreedChoiceViewController: UIViewController {
  
    var list = DogBreeds()
    

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        print(list.dogBreedList)
    

        // Do any additional setup after loading the view.
    }
    
    
}


extension DogBreedChoiceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "dogBreed")
        cell.textLabel?.text = "someDogBreedHere"
        
        
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
            var lastPathComponent = mainPath.components(separatedBy: "/").last ?? ""
            let filePath = mainPath.replacingOccurrences(of: lastPathComponent, with: fileName)
            let contents = (try? String(contentsOfFile: filePath, encoding: .utf8)) ?? ""
            var names = contents.components(separatedBy: .newlines)
            names.removeAll(where: { $0.isEmpty })
            
            return names
        }
        
            //var dogBreedList = FileParser.getLines(from: dogBreedListFile)
        
    }
    
    
    
}
