//
//  Ex_SwiftData.swift
//  Organization-App
//
//  Created by The Godfather Júnior on 20/02/25.
//

import Foundation

extension Manager_SwiftData {
    func encode<T: Codable>(content: T) -> Data? {
        do {
            let data = try JSONEncoder().encode(content)
            return data
        } catch {
            return nil
        }
    }

    func decode<T: Decodable>(content: Data) throws -> T {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: content)
            return decodedData
        } catch {
            throw error
        }
    }
}
