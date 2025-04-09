import Foundation

final class QuestionFactory: QuestionFactoryProtocol {
    private let questions: [JokeQuestionAndPunchline] = [
        JokeQuestionAndPunchline(text: "Why did the chicken get a penalty?", punchline: "For fowl play!", id: 1),
        JokeQuestionAndPunchline(text: "Why did the scarecrow become a motivational speaker?", punchline: "Because he was outstanding in his field!", id: 2),
        JokeQuestionAndPunchline(text: "Why don’t skeletons fight each other?", punchline: "They don’t have the guts!", id: 3),
        JokeQuestionAndPunchline(text: "Why did the computer catch a cold?", punchline: "It left its Windows open!", id: 4),
        JokeQuestionAndPunchline(text: "Why did the math book look sad?", punchline: "It had too many problems!", id: 5),
        JokeQuestionAndPunchline(text: "Why did the golfer bring two pairs of pants?", punchline: " In case he got a hole in one!", id: 6),
        JokeQuestionAndPunchline(text: "Why did the tomato turn red?", punchline: "Because it saw the salad dressing!", id: 7),
        JokeQuestionAndPunchline(text: "Why did the bicycle fall over?", punchline: "Because it was two-tired!", id: 8),
        JokeQuestionAndPunchline(text: "Why don’t programmers like nature?", punchline: "Too many bugs!", id: 9)
    ]
    
    weak var delegate: QuestionFactoryDelegate?
    private var shuffledQuestions: [JokeQuestionAndPunchline] = []
    private var currentIndex = 0
    
    func requestNextQuestion() {
        if currentIndex == shuffledQuestions.count {
            shuffledQuestions = questions.shuffled()
            currentIndex = 0
        }
        
        let question = shuffledQuestions[currentIndex]
        currentIndex += 1
        delegate?.didReceiveNextQuestion(questions: question)
    }
    
    func setup(delegate: QuestionFactoryDelegate) {
        self.delegate = delegate
        shuffledQuestions = questions.shuffled()
    }
}
