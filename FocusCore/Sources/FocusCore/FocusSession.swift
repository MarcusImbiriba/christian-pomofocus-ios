/// Lógica portável de uma sessão, com duração em segundos inteiros.
public struct FocusSession {
    public enum State: Equatable {
        case ready
        case running
        case completed
        case cancelled
    }

    public enum ValidationError: Error, Equatable {
        case invalidDuration
        case negativeElapsedTime
        case regressiveElapsedTime
    }

    public let durationSeconds: Int
    public private(set) var remainingSeconds: Int
    public private(set) var state: State = .ready
    private var lastElapsedSeconds: Int = 0

    public init(durationSeconds: Int) throws {
        guard durationSeconds > 0 else {
            throw ValidationError.invalidDuration
        }

        self.durationSeconds = durationSeconds
        self.remainingSeconds = durationSeconds
    }

    /// Informa o novo estado quando ocorre uma transição; caso contrário, nil.
    @discardableResult
    public mutating func start() -> State? {
        guard state == .ready else { return nil }

        state = .running
        return .running
    }

    /// Recebe o total decorrido desde o início, não um incremento.
    /// Retorna .completed somente na transição de conclusão; caso contrário, nil.
    /// Entradas negativas ou regressivas em andamento lançam erro sem mutação.
    /// Sessões prontas ou finalizadas ignoram a chamada, inclusive sua entrada.
    @discardableResult
    public mutating func update(elapsedSeconds: Int) throws -> State? {
        guard state == .running else { return nil }
        guard elapsedSeconds >= 0 else {
            throw ValidationError.negativeElapsedTime
        }
        guard elapsedSeconds >= lastElapsedSeconds else {
            throw ValidationError.regressiveElapsedTime
        }

        lastElapsedSeconds = elapsedSeconds

        // Comparar antes de subtrair mantém o restante não negativo,
        // inclusive quando o tempo fornecido é Int.max.
        if elapsedSeconds >= durationSeconds {
            remainingSeconds = 0
            state = .completed
            return .completed
        }

        remainingSeconds = durationSeconds - elapsedSeconds
        return nil
    }

    /// Atualiza o tempo antes de cancelar: no limite ou após ele, conclui.
    /// Antes do limite, retorna .cancelled e congela o restante atualizado.
    /// Entradas inválidas em andamento lançam erro sem cancelar a sessão.
    /// Sessões prontas ou finalizadas ignoram a chamada, inclusive sua entrada.
    @discardableResult
    public mutating func cancel(elapsedSeconds: Int) throws -> State? {
        guard state == .running else { return nil }

        if try update(elapsedSeconds: elapsedSeconds) == .completed {
            return .completed
        }

        state = .cancelled
        return .cancelled
    }
}
