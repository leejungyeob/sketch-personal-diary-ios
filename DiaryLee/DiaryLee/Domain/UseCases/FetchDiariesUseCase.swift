import Foundation

class FetchDiariesUseCase {
    private let diaryRepository: DiaryRepository

    init(diaryRepository: DiaryRepository) {
        self.diaryRepository = diaryRepository
    }

    func execute() async throws -> [Diary] {
        return try await diaryRepository.fetchDiaries()
    }
}
