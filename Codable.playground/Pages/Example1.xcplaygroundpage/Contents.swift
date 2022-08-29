import UIKit

let json = """
{
"quote": "Count your age by friends, not years. Count your life by smiles, not tears.",
"author": "John Lennon"
}
"""

struct Quote: Decodable {
    let quote: String
    let author: String
}
// String -> Struct로
// 데이터 형식으로 바꿔야 하고
// 그리고 나서 Quote라는 구조체에 담아야 한다.

guard let result = json.data(using: .utf8) else { fatalError("Error") }
print(result)

// Data -> Quote
do {
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
    print(value.quote)
    print(value.author)
} catch {
    print(error)
}
