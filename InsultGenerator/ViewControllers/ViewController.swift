//
//  ViewController.swift
//  InsultGenerator
//
//  Created by Виктор Чуриков on 26.09.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var insultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInsultGenerate()
        
    }

    @IBAction func generateInsultPressed() {
        fetchInsultGenerate()
    }
}

extension ViewController{
    func fetchInsultGenerate() {
        guard let url = URL(string: "https://evilinsult.com/generate_insult.php?lang=en&type=json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let insult = try JSONDecoder().decode(Insult.self, from: data)
                DispatchQueue.main.async {
                    self.insultLabel.text = String(insult.insult ?? "")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

