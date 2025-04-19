import UIKit

final class ViewController: UIViewController, QuestionFactoryDelegate {
    //MARK: - Private Properties
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: JokeQuestionAndPunchline?
    private var alertPresenter: AlertPresenter?
    
    //MARK: - Outlets
    @IBOutlet private var showButton: UIButton!
    @IBOutlet private var refreshButton: UIButton!
    @IBOutlet private var numberLabel: UILabel!
    @IBOutlet private var questionLabel: UILabel!
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        questionFactory = QuestionFactory()
        questionFactory?.setup(delegate: self)
        questionFactory?.requestNextQuestion()
        alertPresenter = AlertPresenter(presentingController: self)
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
        
        let alertModel = AlertModel(
            title: punchline.title,
            message: punchline.punch,
            buttonText: punchline.textButton,
            completion: { [weak self] in
                self?.questionFactory?.requestNextQuestion()
            }
        )
        
        alertPresenter?.show(alert: alertModel)
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
    
    func didLoadDataFromServer() {
        
    }
    
    func didFailToLoadData(with error: Error) {
        
    }
    
    //MARK: - UI Setup
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
    
    //MARK: - Delegate Methods
    func didReceiveNextQuestion(question: JokeQuestionAndPunchline?) {
        guard let question else { return }
        currentQuestion = question
        displayCurrentQuestion()
    }
}
