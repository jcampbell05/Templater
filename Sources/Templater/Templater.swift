//Templater.swift

public struct Template {
    public let contents: String

    public init(_ contents: String) {
        self.contents = contents
    }

    public func fill(with context: [String: String]) throws -> String {
        return try _run(template: contents, context: context)
    }
}

private typealias CharacterTriplet = (Character, Character, Character)

private struct BufferOfThree {
    var storage: CharacterTriplet = (Character(" "), Character(" "), Character(" "))
    mutating func push(_ char: Character) {
        storage.0 = storage.1
        storage.1 = storage.2
        storage.2 = char
    }
    
    func contains(chars: CharacterTriplet) -> Bool {
        return chars.0 == storage.0 && chars.1 == storage.1 && chars.2 == storage.2
    }
}

public enum TemplateError: Error {
    case malformedTemplate(String)
    case valuesNotFoundInContext([String])
    case variablesNotFoundInTemplate([String])
}

private func _run(template: String, context: [String: String]) throws -> String {
    
    var chars = template.characters
    var curr = chars.startIndex
    
    let charsStart: CharacterTriplet = (Character("{"), Character("{"), Character(" "))
    let charsEnd: CharacterTriplet = (Character(" "), Character("}"), Character("}"))
    
    var buffer = BufferOfThree()
    var isOpen = false
    var varName: [Character] = []
    var openIndex: String.Index? = nil
    
    var unusedValues = Set(context.keys)
    
    while curr < chars.endIndex {
        if isOpen {
            //expect close, otherwise read insides
            if buffer.contains(chars: charsEnd) {
                //found a new var
                guard let openIdx = openIndex else { throw TemplateError.malformedTemplate(template) }
                let range = Range(uncheckedBounds: (openIdx, curr))
                let actualVarName = varName.dropLast(3)
                let name = String(actualVarName)
                unusedValues.remove(name)
                guard let value = context[name] else {
                    throw TemplateError.valuesNotFoundInContext([name])
                }
                chars.replaceSubrange(range, with: value.characters)
                
                //FIXME: be smarter and continue at the offset index instead of starting over (simpler)
                curr = chars.startIndex
                
                isOpen = false
                openIndex = nil
                varName = []
            } else {
                varName.append(chars[curr])
            }
        } else {
            //expect open, otherwise skip
            if buffer.contains(chars: charsStart) {
                openIndex = chars.index(curr, offsetBy: -3)
                isOpen = true
                varName.append(chars[curr])
            }
        }
        buffer.push(chars[curr])
        chars.formIndex(after: &curr)
    }
    
    guard unusedValues.isEmpty else {
        throw TemplateError.variablesNotFoundInTemplate(Array(unusedValues))
    }
    
    return String(chars)
}
