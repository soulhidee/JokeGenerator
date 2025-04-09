import UIKit

final class ViewController: UIViewController, QuestionFactoryDelegate {
    //MARK: - Outlets
    @IBOutlet private var showButton: UIButton!
    @IBOutlet private var refreshButton: UIButton!
    @IBOutlet private var numberLabel: UILabel!
    @IBOutlet private var questionLabel: UILabel!
    
    //MARK: - Private Properties
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: JokeQuestionAndPunchline?
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        questionFactory = QuestionFactory()
        questionFactory?.setup(delegate: self)
        questionFactory?.requestNextQuestion()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addBorders(to: questionLabel, color: .black, thickness: 2)
    }
    
    //MARK: - Actions
    @IBAction func refreshButtonClicked(_ sender: UIButton) {
        questionFactory?.requestNextQuestion()
    }
    
    @IBAction func showButtonClicked(_ sender: UIButton) {
        guard let currentQuestion else { return }
        let punchline = JokePunchlineViewModel(
            title: "Punchline",
            punch: currentQuestion.punchline,
            textButton: "OK")
        showAlert(with: punchline)
        
    }
    
    //MARK: - Private Methods
    private func convert(model: JokeQuestionAndPunchline) -> QuestionStepViewModel {
        let questionStep = QuestionStepViewModel(
            question: model.text,
            jokeId: "\(model.id)")
        return questionStep
    }
    
    private func show(joke step: QuestionStepViewModel) {
        questionLabel.text = step.question
        numberLabel.text = step.jokeId
    }
    
    
    private func displayCurrentQuestion() {
        guard let currentQuestion else { return }
        let viewModel = convert(model: currentQuestion)
        show(joke: viewModel)
    }
    
    private func showAlert(with model: JokePunchlineViewModel) {
        let alert = UIAlertController(title: model.title, message: model.punch, preferredStyle: .alert)
        let action = UIAlertAction(title: model.textButton, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.questionFactory?.requestNextQuestion()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func addBorders(to label: UILabel, color: UIColor, thickness: CGFloat) {
        label.layer.sublayers?.removeAll(where: { $0.name == "borderLayer" })
        
        let width = label.bounds.width
        
        let topBorder = CALayer()
        topBorder.name = "borderLayer"
        topBorder.frame = CGRect(x: 0, y: 0, width: width, height: thickness)
        topBorder.backgroundColor = color.cgColor
        label.layer.addSublayer(topBorder)
        
        let bottomBorder = CALayer()
        bottomBorder.name = "borderLayer"
        bottomBorder.frame = CGRect(x: 0, y: label.bounds.height - thickness, width: width, height: thickness)
        bottomBorder.backgroundColor = color.cgColor
        label.layer.addSublayer(bottomBorder)
    }
    
    func didReceiveNextQuestion(question: JokeQuestionAndPunchline?) {
        guard let question else { return }
        currentQuestion = question
        displayCurrentQuestion()
        
    }
    
}

