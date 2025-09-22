/// Auth feature에 대한 추상 인터페이스 정의
/// 추상 클래스이므로 메서드 시그니처 작성
/// - Future 제네릭 타입은 bool로 간단하게 선언할 수 있지만 보통은 Result Pattern을 사용
/// - 예) Fututre<Either<AuthFailure, User>> login(String email, String password);
abstract class AuthRepository {
  Future<bool> login(String email, String password);
  Future<bool> register(String email, String password);
}
