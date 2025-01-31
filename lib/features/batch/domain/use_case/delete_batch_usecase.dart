import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prabin/app/shared_prefs/token_shared_prefs.dart';
import 'package:prabin/app/usecase/usecase.dart';
import 'package:prabin/core/error/failure.dart';
import 'package:prabin/features/batch/domain/repository/batch_repository.dart';

class DeleteBatchParams extends Equatable {
  final String batchId;

  const DeleteBatchParams({required this.batchId});

  const DeleteBatchParams.empty() : batchId = '_empty.string';

  @override
  List<Object?> get props => [
        batchId,
      ];
}

class DeleteBatchUsecase implements UsecaseWithParams<void, DeleteBatchParams> {
  final IBatchRepository batchRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteBatchUsecase({
    required this.batchRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(DeleteBatchParams params) async {
    // Get token from Shared Preferences and send it to the server
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await batchRepository.deleteBatch(params.batchId, r);
    });
  }
}
