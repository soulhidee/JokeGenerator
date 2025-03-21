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
    private var currentQuestionsIndex = 0
    
    private let question: [JokeQuestionAndPunchline] = [
        JokeQuestionAndPunchline(text: "Why did the chicken get a penalty?", punchline: "For fowl play!"),
        JokeQuestionAndPunchline(text: "Why did the scarecrow become a motivational speaker?", punchline: "Because he was outstanding in his field!"),
        JokeQuestionAndPunchline(text: "Why don’t skeletons fight each other?", punchline: "They don’t have the guts!"),
        JokeQuestionAndPunchline(text: "Why did the computer catch a cold?", punchline: "It left its Windows open!"),
        JokeQuestionAndPunchline(text: "Why did the math book look sad?", punchline: "It had too many problems!"),
        JokeQuestionAndPunchline(text: "Why did the golfer bring two pairs of pants?", punchline: " In case he got a hole in one!"),
        JokeQuestionAndPunchline(text: "Why did the tomato turn red?", punchline: "Because it saw the salad dressing!"),
        JokeQuestionAndPunchline(text: "Why did the bicycle fall over?", punchline: "Because it was two-tired!"),
        JokeQuestionAndPunchline(text: "Why don’t programmers like nature?", punchline: "Too many bugs!")]
    
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
    
    
    // вью модель для состояния "Вопрос показан"
    private struct QuestionStepViewModel {
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
    private func convert(model: JokeQuestionAndPunchline) -> QuestionStepViewModel {
        let stepJoke = QuestionStepViewModel(
            question: model.text,
            jokeId: "\(currentQuestionsIndex + 1)")
        return stepJoke
    }
    
    private func show(joke step: QuestionStepViewModel) {
        questionLabel.text = step.question
        numberLabel.text = step.jokeId
    }
    
    
}

