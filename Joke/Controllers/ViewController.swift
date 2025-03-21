//
//  ViewController.swift
//  Joke
//
//  Created by Даниил on 21.03.2025.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet private var showButton: UIButton!
    @IBOutlet private var refreshButton: UIButton!
    @IBOutlet private var numberLabel: UILabel!
    @IBOutlet private var questionLabel: UILabel!
    
    //MARK: - Private Properties
    
    
    //MARK: - Models
    private struct JokeQuestionAndPunchline {
        let text: String
        let punchline: String
    }
    
    private struct JokePunchlineViewModel {
        let title: String
        let punch: String
        let textButton: String
    }
    
    private struct JokeStepViewModel {
        let question: String
        let jokeId: String
    }

    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    //MARK: - Actions
    @IBAction func refreshButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func showButtonClicked(_ sender: UIButton) {
    }
    
    //MARK: - Private Methods
    
    
    
    
}

