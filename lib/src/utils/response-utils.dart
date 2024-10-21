class DoubleResponse<T, R> {
  DoubleResponse(
    this.data1,
    this.data2,
  );
  final T? data1;
  final R? data2;

  DoubleResponse<T, R> copyWith({
    T? data1,
    R? data2,
  }) {
    return DoubleResponse<T, R>(
      data1 ?? this.data1,
      data2 ?? this.data2,
    );
  }
}

class TripleResponse<T, R, P> {
  TripleResponse(
    this.data1,
    this.data2,
    this.data3,
  );
  final T data1;
  final R data2;
  final P data3;

  TripleResponse<T, R, P> copyWith({
    T? data1,
    R? data2,
    P? data3,
  }) {
    return TripleResponse<T, R, P>(
      data1 ?? this.data1,
      data2 ?? this.data2,
      data3 ?? this.data3,
    );
  }
}

class PaginatedResponse<T> {
  PaginatedResponse(
    this.data,
    this.nextPageUrl,
    this.count, {
    this.previousUrl,
  });

  final T? data;
  final String? count;
  final String? nextPageUrl;
  final String? previousUrl;

  bool get hasReachedMax => nextPageUrl == null || nextPageUrl == "null";
  String? get nextPage =>
      nextPageUrl != "null" ? nextPageUrl?.split("?")[1] : null;
  String? get previousPage => previousUrl != null && previousUrl != "null"
      ? previousUrl!.contains('?')
          ? previousUrl?.split("?")[1]
          : null
      : null;
  PaginatedResponse<T> copyWith({
    T? data,
    String? count,
    String? nextPageUrl,
    String? previousPageUrl,
  }) {
    return PaginatedResponse<T>(
        data ?? this.data, count ?? this.count, nextPageUrl ?? this.nextPageUrl,
        previousUrl: previousUrl ?? previousUrl);
  }
}

class DoublePaginatedResponse<T, R> {
  DoublePaginatedResponse({
    this.data1,
    this.data2,
    this.nextPageUrl,
    this.count,
  });

  final T? data1;
  final R? data2;
  final int? count;
  final String? nextPageUrl;

  bool get hasReachedMax => nextPageUrl == null || nextPageUrl == "null";
  String? get nextPage =>
      nextPageUrl != "null" ? nextPageUrl?.split("?")[1] : null;

  DoublePaginatedResponse<T, R> copyWith({
    T? data1,
    R? data2,
    int? count,
    String? nextPageUrl,
  }) {
    return DoublePaginatedResponse<T, R>(
        data1: data1 ?? this.data1,
        data2: data2 ?? this.data2,
        count: count ?? this.count,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl);
  }
}
