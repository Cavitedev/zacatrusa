import '../../url/filters/zacatrus_page_query_parameter.dart';

class ReviewUrl {
  const ReviewUrl({
    required this.url,
    required this.numberOfReviews,
    required this.pageIndex,
  });

  static const int _reviewsPerPage = 50;
  final String url;
  final int numberOfReviews;
  final ZacatrusPageIndex pageIndex;

  ReviewUrl nextPage() {
    return copyWith(pageIndex: pageIndex.copyWithNextPage());
  }

  String buildUrl() {
    return "$url?${pageIndex.toParam()}limit=$_reviewsPerPage";
  }

  ReviewUrl copyWith({
    String? url,
    int? numberOfComments,
    ZacatrusPageIndex? pageIndex,
  }) {
    return ReviewUrl(
      url: url ?? this.url,
      numberOfReviews: numberOfComments ?? numberOfReviews,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}
