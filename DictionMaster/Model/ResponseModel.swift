//
//  ResponseModel.swift
//  DictionMaster
//
//  Created by Emerson Sampaio on 04/02/24.
//

import Foundation

struct Response: Codable {
    let word: String
    let phonetic: String?
    let phonetics: [Phonetic]
    let meanings: [Meaning]
    let license: License
    let sourceUrls: [String]
}

struct ErrorResponse: Codable {
    let title, message, resolution: String
}

struct License: Codable {
    let name: String
    let url: String
}

struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
    let synonyms, antonyms: [String]
}

struct Definition: Codable, Identifiable {
    let id = UUID()
    let definition: String
    let synonyms, antonyms: [String]
    let example: String?
}

struct Phonetic: Codable {
    let audio: String
    let sourceURL: String?
    let license: License?
    let text: String?
}
