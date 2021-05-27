//
//  TimeServiceAPI.swift
//
//
//  Created by Yony Gonzalez Vargas on 23/05/21.
//

import Foundation

class TimeServiceAPI {
    
    public static let shared = TimeServiceAPI()
    private init() {}
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: Constants.BaseURL.baseURL)!
    private let username = Constants.BaseURL.username
    private let style = Constants.BaseURL.style
    private let formatted = Constants.BaseURL.formatted
    private let jsonDecoder: JSONDecoder = {
       let jsonDecoder = JSONDecoder()
       jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-mm-dd"
       jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
       return jsonDecoder
    }()
    
    
    // Enum Endpoint
    enum Endpoint: String, CustomStringConvertible, CaseIterable, Identifiable {
        
        var id: String { rawValue }
        
        case nowPlaying = "now_playing"
        case upcoming
        case popular
        case topRated = "top_rated"
        
        var description: String {
            switch self {
                case .nowPlaying: return "Now Playing"
                case .upcoming: return "Upcoming"
                case .topRated: return "Top Rated"
                case .popular: return "Popular"
            }
        }
    }
    
    
    private func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        
//        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
//            completion(.failure(.invalidEndpoint))
//            return
//        }
        
     
       urlSession.dataTask(with: url) { [weak self] (data, response, error) in
        
        guard let self = self else { return }
        
        if error != nil {
            self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
            return
        }
        
        guard let data = data else {
            self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
            return
        }
        
        do {
            let decodedResponse = try self.jsonDecoder.decode(T.self, from: data)
            self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
        }catch let jsonError as NSError {
            print("JSON decode failed, active GPS Device/Simulator to get location: \(jsonError.localizedDescription)")
        }

         }.resume()
    }
    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, APIServiceError>, completion: @escaping (Result<D, APIServiceError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    enum APIServiceError: Error, CustomNSError {
        
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case serializationError
        
        var localizedDescription: String {
            switch self {
            case .apiError: return "Failed to fetch data"
            case .invalidEndpoint: return "Invalid endpoint"
            case .invalidResponse: return "Invalid response"
            case .noData: return "No data"
            case .serializationError: return "Failed to decode data"
            }
        }
        
        var errorUserInfo: [String : Any] {
            [NSLocalizedDescriptionKey: localizedDescription]
        }
        
    }
    
    
    public func fetchTime(lat: String,lng: String, result: @escaping (Result<EventTime, APIServiceError>) -> Void) {
        
        guard let apiURL = URL(string: "\(baseURL)username=\(username)&style=\(style)&formatted=\(formatted)&lat=\(lat)&lng=\(lng)") else {
            result(.failure(.invalidEndpoint))
            return
        }
        fetchResources(url: apiURL, completion: result)
    }
    
    

    
    
}

