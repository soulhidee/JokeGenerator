import UIKit

final class ViewController: UIViewController, QuestionFactoryDelegate {
    //MARK: - Private Properties
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: JokeQuestionAndPunchline?
    private var alertPresenter: AlertPresenter?
    
    //MARK: - Outlets
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var showButton: UIButton!
    @IBOutlet private var refreshButton: UIButton!
    @IBOutlet private var numberLabel: UILabel!
    @IBOutlet private var questionLabel: UILabel!
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorOn()
        let loader = JokeLoader()
        let factory = QuestionFactory(randomJokeLoader: loader, delegate: self)
        self.questionFactory = factory
        alertPresenter = AlertPresenter(presentingController: self)
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
    
    private func activityIndicatorOn() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func activityIndicatorOff() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    private func showNetworkError(message: String) {
        activityIndicatorOff()
        let model = AlertModel(title: "Ошибка",
                               message: message,
                               buttonText: "Попробывать еще раз") { [weak self] in
            guard let self else { return }
            self.questionFactory?.requestNextQuestion()
        }
        alertPresenter?.show(alert: model)
    }
    
    func didLoadDataFromServer() {
        activityIndicatorOff()
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToLoadData(with error: Error) {
        showNetworkError(message: error.localizedDescription)
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
        activityIndicatorOff()
        currentQuestion = question
        displayCurrentQuestion()
    }
}
