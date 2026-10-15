import Testing
import FocusCore

@Suite("Sessão de foco")
struct FocusSessionTests {
    @Test("Sessão nasce pronta com a duração inteira disponível", arguments: [1, 60, 1_500, Int.max])
    func sessionStartsReady(durationSeconds: Int) throws {
        let session = try FocusSession(durationSeconds: durationSeconds)

        #expect(session.state == .ready)
        #expect(session.durationSeconds == durationSeconds)
        #expect(session.remainingSeconds == durationSeconds)
    }

    @Test("Duração zero ou negativa é rejeitada", arguments: [0, -1, Int.min])
    func invalidDurationIsRejected(durationSeconds: Int) {
        #expect(throws: FocusSession.ValidationError.invalidDuration) {
            try FocusSession(durationSeconds: durationSeconds)
        }
    }

    @Test("Iniciar uma sessão pronta informa a transição para em andamento")
    func startingReadySessionReportsRunningTransition() throws {
        var session = try FocusSession(durationSeconds: 60)

        let transition = session.start()

        #expect(transition == .running)
        #expect(session.state == .running)
        #expect(session.remainingSeconds == 60)
    }

    @Test("Início repetido preserva o progresso e não informa nova transição")
    func repeatedStartPreservesProgress() throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()
        try session.update(elapsedSeconds: 20)

        #expect(session.start() == nil)
        #expect(session.state == .running)
        #expect(session.remainingSeconds == 40)
        #expect(throws: FocusSession.ValidationError.regressiveElapsedTime) {
            try session.update(elapsedSeconds: 19)
        }
        #expect(try session.update(elapsedSeconds: 30) == nil)
        #expect(session.remainingSeconds == 30)
    }

    @Test("Atualizar uma sessão pronta não a modifica", arguments: [Int.min, 0, 60, Int.max])
    func updatingReadySessionDoesNothing(elapsedSeconds: Int) throws {
        var session = try FocusSession(durationSeconds: 60)

        #expect(try session.update(elapsedSeconds: elapsedSeconds) == nil)
        #expect(session.state == .ready)
        #expect(session.remainingSeconds == 60)
        #expect(session.start() == .running)
        #expect(try session.update(elapsedSeconds: 1) == nil)
        #expect(session.remainingSeconds == 59)
    }

    @Test("Cancelar uma sessão pronta não a modifica", arguments: [Int.min, 0, 60, Int.max])
    func cancellingReadySessionDoesNothing(elapsedSeconds: Int) throws {
        var session = try FocusSession(durationSeconds: 60)

        #expect(try session.cancel(elapsedSeconds: elapsedSeconds) == nil)
        #expect(session.state == .ready)
        #expect(session.remainingSeconds == 60)
        #expect(session.start() == .running)
        #expect(try session.update(elapsedSeconds: 1) == nil)
        #expect(session.remainingSeconds == 59)
    }

    @Test("Progresso usa o total decorrido em segundos inteiros", arguments: [
        (0, 60), (1, 59), (30, 30), (59, 1)
    ])
    func progressUsesTotalElapsedSeconds(elapsedSeconds: Int, expectedRemaining: Int) throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()

        #expect(try session.update(elapsedSeconds: elapsedSeconds) == nil)
        #expect(session.state == .running)
        #expect(session.remainingSeconds == expectedRemaining)
    }

    @Test("Atualizações sucessivas não somam os tempos fornecidos")
    func successiveUpdatesUseTotalsRatherThanIncrements() throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()

        try session.update(elapsedSeconds: 10)
        try session.update(elapsedSeconds: 20)

        #expect(session.state == .running)
        #expect(session.remainingSeconds == 40)
    }

    @Test("Repetir o mesmo tempo é permitido")
    func repeatedElapsedTimeIsAccepted() throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()
        try session.update(elapsedSeconds: 20)

        #expect(try session.update(elapsedSeconds: 20) == nil)
        #expect(session.state == .running)
        #expect(session.remainingSeconds == 40)
    }

    @Test("Limite exato e tempo excedido informam conclusão", arguments: [60, 61, Int.max])
    func reachingDurationReportsCompletion(elapsedSeconds: Int) throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()

        #expect(try session.update(elapsedSeconds: elapsedSeconds) == .completed)
        #expect(session.state == .completed)
        #expect(session.remainingSeconds == 0)
    }

    @Test("Conclusão é informada uma única vez")
    func completionIsReportedOnlyOnce() throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()

        #expect(try session.update(elapsedSeconds: 60) == .completed)
        #expect(try session.update(elapsedSeconds: 60) == nil)
        #expect(try session.update(elapsedSeconds: 61) == nil)
        #expect(try session.cancel(elapsedSeconds: 61) == nil)
        #expect(session.state == .completed)
        #expect(session.remainingSeconds == 0)
    }

    @Test("Cancelar antes do limite congela o restante", arguments: [
        (0, 60), (20, 40), (59, 1)
    ])
    func cancellationFreezesRemainingTime(elapsedSeconds: Int, expectedRemaining: Int) throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()

        #expect(try session.cancel(elapsedSeconds: elapsedSeconds) == .cancelled)
        #expect(session.state == .cancelled)
        #expect(session.remainingSeconds == expectedRemaining)
        #expect(try session.update(elapsedSeconds: 60) == nil)
        #expect(session.state == .cancelled)
        #expect(session.remainingSeconds == expectedRemaining)
    }

    @Test("Cancelamento atualiza o restante a partir do último progresso")
    func cancellationUsesItsOwnElapsedTime() throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()
        try session.update(elapsedSeconds: 10)

        #expect(try session.cancel(elapsedSeconds: 20) == .cancelled)
        #expect(session.state == .cancelled)
        #expect(session.remainingSeconds == 40)
    }

    @Test("Cancelamento aceita o mesmo tempo da última atualização")
    func cancellationAcceptsRepeatedElapsedTime() throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()
        try session.update(elapsedSeconds: 20)

        #expect(try session.cancel(elapsedSeconds: 20) == .cancelled)
        #expect(session.remainingSeconds == 40)
    }

    @Test("Conclusão prevalece sobre cancelamento no limite ou depois", arguments: [60, 61, Int.max])
    func cancellationAtOrAfterDurationCompletesSession(elapsedSeconds: Int) throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()
        try session.update(elapsedSeconds: 10)

        #expect(try session.cancel(elapsedSeconds: elapsedSeconds) == .completed)
        #expect(session.state == .completed)
        #expect(session.remainingSeconds == 0)
        #expect(try session.update(elapsedSeconds: elapsedSeconds) == nil)
    }

    @Test("Atualização negativa é rejeitada sem modificar a sessão", arguments: [-1, Int.min])
    func negativeUpdatePreservesSession(elapsedSeconds: Int) throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()
        try session.update(elapsedSeconds: 20)

        #expect(throws: FocusSession.ValidationError.negativeElapsedTime) {
            try session.update(elapsedSeconds: elapsedSeconds)
        }
        #expect(session.state == .running)
        #expect(session.durationSeconds == 60)
        #expect(session.remainingSeconds == 40)
        #expect(throws: FocusSession.ValidationError.regressiveElapsedTime) {
            try session.update(elapsedSeconds: 19)
        }
        #expect(try session.update(elapsedSeconds: 30) == nil)
        #expect(session.remainingSeconds == 30)
    }

    @Test("Cancelamento negativo é rejeitado sem modificar a sessão", arguments: [-1, Int.min])
    func negativeCancellationPreservesSession(elapsedSeconds: Int) throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()
        try session.update(elapsedSeconds: 20)

        #expect(throws: FocusSession.ValidationError.negativeElapsedTime) {
            try session.cancel(elapsedSeconds: elapsedSeconds)
        }
        #expect(session.state == .running)
        #expect(session.durationSeconds == 60)
        #expect(session.remainingSeconds == 40)
        #expect(throws: FocusSession.ValidationError.regressiveElapsedTime) {
            try session.cancel(elapsedSeconds: 19)
        }
        #expect(try session.cancel(elapsedSeconds: 30) == .cancelled)
        #expect(session.remainingSeconds == 30)
    }

    @Test("Atualização regressiva preserva a última entrada aceita", arguments: [0, 19])
    func regressiveUpdatePreservesLastAcceptedTime(elapsedSeconds: Int) throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()
        try session.update(elapsedSeconds: 20)

        #expect(throws: FocusSession.ValidationError.regressiveElapsedTime) {
            try session.update(elapsedSeconds: elapsedSeconds)
        }
        #expect(session.state == .running)
        #expect(session.remainingSeconds == 40)
        #expect(throws: FocusSession.ValidationError.regressiveElapsedTime) {
            try session.update(elapsedSeconds: 19)
        }
        #expect(try session.update(elapsedSeconds: 20) == nil)
        #expect(try session.update(elapsedSeconds: 60) == .completed)
    }

    @Test("Cancelamento regressivo preserva a última entrada aceita", arguments: [0, 19])
    func regressiveCancellationPreservesLastAcceptedTime(elapsedSeconds: Int) throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()
        try session.update(elapsedSeconds: 20)

        #expect(throws: FocusSession.ValidationError.regressiveElapsedTime) {
            try session.cancel(elapsedSeconds: elapsedSeconds)
        }
        #expect(session.state == .running)
        #expect(session.remainingSeconds == 40)
        #expect(throws: FocusSession.ValidationError.regressiveElapsedTime) {
            try session.cancel(elapsedSeconds: 19)
        }
        #expect(try session.cancel(elapsedSeconds: 20) == .cancelled)
        #expect(session.remainingSeconds == 40)
    }

    @Test("Estado concluído ignora novas operações e entradas inválidas", arguments: [Int.min, 0, 20, 60, Int.max])
    func completedSessionRemainsFinal(elapsedSeconds: Int) throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()
        try session.update(elapsedSeconds: 60)

        #expect(session.start() == nil)
        #expect(try session.update(elapsedSeconds: elapsedSeconds) == nil)
        #expect(try session.cancel(elapsedSeconds: elapsedSeconds) == nil)
        #expect(session.state == .completed)
        #expect(session.durationSeconds == 60)
        #expect(session.remainingSeconds == 0)
    }

    @Test("Estado cancelado ignora novas operações e entradas inválidas", arguments: [Int.min, 0, 20, 60, Int.max])
    func cancelledSessionRemainsFinal(elapsedSeconds: Int) throws {
        var session = try FocusSession(durationSeconds: 60)
        session.start()
        try session.cancel(elapsedSeconds: 20)

        #expect(session.start() == nil)
        #expect(try session.update(elapsedSeconds: elapsedSeconds) == nil)
        #expect(try session.cancel(elapsedSeconds: elapsedSeconds) == nil)
        #expect(session.state == .cancelled)
        #expect(session.durationSeconds == 60)
        #expect(session.remainingSeconds == 40)
    }

    @Test("Duração mínima conclui após um segundo")
    func oneSecondSessionCompletesAtOneSecond() throws {
        var session = try FocusSession(durationSeconds: 1)
        session.start()

        #expect(try session.update(elapsedSeconds: 0) == nil)
        #expect(session.remainingSeconds == 1)
        #expect(try session.update(elapsedSeconds: 1) == .completed)
        #expect(session.remainingSeconds == 0)
    }

    @Test("Duração máxima permite progresso e conclusão sem estouro")
    func maximumDurationSupportsProgressAndCompletion() throws {
        var session = try FocusSession(durationSeconds: Int.max)
        session.start()

        try session.update(elapsedSeconds: 1)
        #expect(session.remainingSeconds == Int.max - 1)
        try session.update(elapsedSeconds: Int.max - 1)
        #expect(session.remainingSeconds == 1)
        #expect(try session.update(elapsedSeconds: Int.max) == .completed)
        #expect(session.remainingSeconds == 0)
    }

    @Test("Uma nova sessão começa independente de outra já finalizada")
    func newSessionIsIndependentOfFinishedSession() throws {
        var finished = try FocusSession(durationSeconds: 60)
        finished.start()
        try finished.cancel(elapsedSeconds: 20)

        var newSession = try FocusSession(durationSeconds: 30)
        #expect(newSession.state == .ready)
        #expect(newSession.remainingSeconds == 30)
        #expect(newSession.start() == .running)
        #expect(finished.state == .cancelled)
        #expect(finished.remainingSeconds == 40)
    }
}
