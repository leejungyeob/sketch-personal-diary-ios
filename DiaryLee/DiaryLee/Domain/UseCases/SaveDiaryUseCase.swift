import Foundation

class SaveDiaryUseCase {
    private let diaryRepository: DiaryRepository

    init(diaryRepository: DiaryRepository) {
        self.diaryRepository = diaryRepository
    }

    func execute(diary: Diary) async throws {
        try await diaryRepository.save(diary: diary)
    }
}
