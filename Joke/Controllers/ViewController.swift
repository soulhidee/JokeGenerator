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
    private var currentNumberIndex = 0
    
    //MARK: - Models
    // вопросы и панчи
    private struct JokeQuestionAndPunchline {
        let text: String
        let punchline: String
    }
    
    
    // окно с панчем
    private struct JokePunchlineViewModel {
        let title: String
        let punch: String
        let textButton: String
    }
    
    
    // шаг
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
    private func convert(model: JokeQuestionAndPunchline) -> JokeStepViewModel {
        let stepJoke = JokeStepViewModel(
            question: model.text,
            jokeId: "\(currentNumberIndex + 1)"
        )
        
        
        return stepJoke
    }
    
    
    
}

