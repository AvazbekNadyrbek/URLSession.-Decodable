import Foundation

// MARK: - Top-Level Response
struct RikandMortyModel: Decodable {
    let info: Info
    let results: [Character]

    // MARK: - Paging Info
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    // MARK: - Character
    struct Character: Decodable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let type: String
        let gender: String
        let image: String
        let episode: [String]
        let url: String
        let created: String
    }

}
