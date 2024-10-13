import Foundation

func readFile(at path: String) -> String? {
    try? String(contentsOfFile: path, encoding: .utf8)
}

func writeFile(at path: String, content: String) {
    try? content.write(toFile: path, atomically: true, encoding: .utf8)
}

func countWords(in text: String) -> Int {
    text.split(separator: " ").count
}

func containsWord(in text: String, word: String) -> Bool {
    text.contains(word)
}

func replaceWord(in text: String, target: String, replacement: String) -> String {
    text.replacingOccurrences(of: target, with: replacement)
}

func showMenu() {
    print("""
    Choose an operation:
    1. Count words
    2. Search word
    3. Replace word
    4. Exit
    """)
}

func main() {
    print("Enter the file path:")
    guard let filePath = readLine(), !filePath.isEmpty else {
        print("Invalid path.")
        return
    }
    guard let content = readFile(at: filePath) else {
        print("Unable to read file. Check the path.")
        return
    }

    var continueRunning = true
    while continueRunning {
        showMenu()
        if let choice = readLine() {
            switch choice {
            case "1":
                print("Number of words: \(countWords(in: content))")
            case "2":
                print("Enter the word to search:")
                if let wordToSearch = readLine() {
                    let found = containsWord(in: content, word: wordToSearch)
                    print("Is the word '\(wordToSearch)' present? \(found)")
                }
            case "3":
                print("Enter the word to replace:")
                if let targetWord = readLine() {
                    print("Enter the new word:")
                    if let replacementWord = readLine() {
                        let newContent = replaceWord(in: content, target: targetWord, replacement: replacementWord)
                        writeFile(at: filePath, content: newContent)
                        print("Replaced '\(targetWord)' with '\(replacementWord)' in the file.")
                    }
                }
            case "4":
                continueRunning = false
                print("Exiting the program.")
            default:
                print("Invalid option. Try again.")
            }
        }
    }
}

main()