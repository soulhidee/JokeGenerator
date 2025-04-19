import Foundation

protocol JokeLoading {
    func loadJoke(handler: @escaping (Result<RandomJoke, Error>) -> Void)
}

struct JokeLoader: JokeLoading {
    private let networkClient = NetworkClient()
    private var randomJokeUrl: URL {
        guard let url = URL(string: "https://official-joke-api.appspot.com/jokes/random") else {
            preconditionFailure("Unable to construct mostRandomJokeUrl")
        }
        return url
    }
    
    func loadJoke(handler: @escaping (Result<RandomJoke, any Error>) -> Void) {
        networkClient.fetch(url: randomJokeUrl) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let randomJoke = try decoder.decode(RandomJoke.self, from: data)
                    handler(.success(randomJoke))
                } catch {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
}
