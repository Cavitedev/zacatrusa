import '../../../core/multiple_result.dart';
import '../../infrastructure/core/internet_feedback.dart';
import '../../zacatrus/domain/details_page/zacatrus_details_page_data.dart';

class DetailsState {
  final Either<InternetFeedback, ZacatrusDetailsPageData>? data;

  const DetailsState({
    this.data,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetailsState &&
          runtimeType == other.runtimeType &&
          data == other.data);

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() {
    return 'DetailsState{' + ' data: $data,' + '}';
  }

  DetailsState copyWith({
    Either<InternetFeedback, ZacatrusDetailsPageData>? data,
  }) {
    return DetailsState(
      data: data ?? this.data,
    );
  }
}
