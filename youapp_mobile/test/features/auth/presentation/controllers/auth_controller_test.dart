import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:youapptest/features/auth/domain/entities/user.dart';
import 'package:youapptest/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:youapptest/features/auth/presentation/controllers/auth_controller.dart';

import 'auth_controller_test.mocks.dart';

@GenerateMocks([AuthRepositoryImpl])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthController controller;
  late MockAuthRepositoryImpl mockRepo;

  setUp(() {
    Get.testMode = true;
    mockRepo = MockAuthRepositoryImpl();
    controller = AuthController();
    controller.repository = mockRepo; // Inject mocked repo
  });

  test('Given that correct cretential provided login success', () async {
    final user = User(email: 'test@test.com', accessToken: 'abc123');
    when(mockRepo.login(any)).thenAnswer((_) async => user);

    controller.email.value = 'test@test.com';
    controller.password.value = '123456';

    await controller.login();

    expect(controller.user, isNotNull);
    expect(controller.user!.email, 'test@test.com');
    expect(controller.result.value, '');
  });

  test('Given that incorrect cretential provided login success', () async {
    when(mockRepo.login(any)).thenAnswer((_) async => null);

    await controller.login();

    expect(controller.user, isNull);
    expect(controller.result.value, 'Login failed');
  });

  test('Given that correct details provided register success', () async {
    final user = User(email: 'test@test.com');
    when(mockRepo.register(any)).thenAnswer((_) async => user);

    controller.email.value = 'test@test.com';
    controller.username.value = 'testuser';
    controller.password.value = '123456';
    await controller.register();

    expect(controller.user, isNotNull);
    expect(controller.result.value, '');
  });

  test('Given that incorrect details provided register success', () async {
    when(mockRepo.register(any)).thenAnswer((_) async => null);

    await controller.register();

    expect(controller.user, isNull);
    expect(controller.result.value, 'Registering User failed');
  });
}
