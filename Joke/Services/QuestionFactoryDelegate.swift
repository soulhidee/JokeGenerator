import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(questions: JokeQuestionAndPunchline?)
}
