//
//  NetworkService.swift
//
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import Combine
import Foundation

public protocol Networkable {
    func sendRequest<T: Decodable>(urlStr: String) async throws -> T
    func sendRequest<T: Decodable>(endpoint: Endpoint) async throws -> T
    func sendRequest<T: Decodable>(endpoint: Endpoint, resultHandler: @escaping (Result<T, NetworkError>) -> Void)
    func sendRequest<T: Decodable>(endpoint: Endpoint, type: T.Type) -> AnyPublisher<T, NetworkError>
}

public final class NetworkService: Networkable {
    public func sendRequest<T>(urlStr: String) async throws -> T where T: Decodable {
        guard let urlStr = urlStr as String?, let url = URL(string: urlStr) as URL?else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
            throw NetworkError.unexpectedStatusCode
        }
        guard let data = data as Data? else {
            throw NetworkError.unknown
        }
        guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decode
        }
        return decodedResponse
    }

    public func sendRequest<T>(endpoint: Endpoint, type: T.Type) -> AnyPublisher<T, NetworkError> where T: Decodable {
        guard let urlRequest = createRequest(endpoint: endpoint) else {
            precondition(false, "Failed URLRequest")
        }
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    throw NetworkError.invalidURL
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if error is DecodingError {
                    return NetworkError.decode
                } else if let error = error as? NetworkError {
                    return error
                } else {
                    return NetworkError.unknown
                }
            }
            .eraseToAnyPublisher()
    }

    public func sendRequest<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let urlRequest = createRequest(endpoint: endpoint) else {
            throw NetworkError.decode
        }
        return try await withCheckedThrowingContinuation { continuation in
            let task = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
                .dataTask(with: urlRequest) { data, response, _ in
                    guard response is HTTPURLResponse else {
                        continuation.resume(throwing: NetworkError.invalidURL)
                        return
                    }
                    guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                        continuation.resume(throwing:
                                                NetworkError.unexpectedStatusCode)
                        return
                    }
                    guard let data = data else {
                        continuation.resume(throwing: NetworkError.unknown)
                        return
                    }
                    guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                        continuation.resume(throwing: NetworkError.decode)
                        return
                    }
                    continuation.resume(returning: decodedResponse)
                }
            task.resume()
        }
    }

    public func sendRequest<T: Decodable>(endpoint: Endpoint,
                                          resultHandler: @escaping (Result<T, NetworkError>) -> Void) {

        guard let urlRequest = createRequest(endpoint: endpoint) else {
            DispatchQueue.main.async {
                resultHandler(.failure(.invalidURL))
            }
            return
        }
        let urlTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    resultHandler(.failure(.invalidURL))
                }
                return
            }
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                DispatchQueue.main.async {
                    resultHandler(.failure(.unexpectedStatusCode))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    resultHandler(.failure(.unknown))
                }
                return
            }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                DispatchQueue.main.async {
                    resultHandler(.failure(.decode))
                }
                return
            }
            DispatchQueue.main.async {
                resultHandler(.success(decodedResponse))
            }
        }
        urlTask.resume()
    }

    public init() {

    }
}

extension Networkable {
    fileprivate func createRequest(endpoint: Endpoint) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        // Adding query parameters
        urlComponents.queryItems = endpoint.queryParams?.map { URLQueryItem(name: $0.key, value: $0.value) }

        // Handling path parameters
        var path = endpoint.path
        for (key, value) in endpoint.pathParams ?? [:] {
            path = path.replacingOccurrences(of: "{\(key)}", with: value)
        }
        urlComponents.path = path
        guard let url = urlComponents.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        if let body = endpoint.body {
            let encoder = JSONEncoder()
            request.httpBody = try? encoder.encode(body)
        }
        return request
    }
}
