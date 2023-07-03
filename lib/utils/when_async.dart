import 'package:flutter/widgets.dart';

extension WhenAsyncSnapshot<T> on AsyncSnapshot<T> {
  R when<R>({
    R Function()? empty,
    R Function(dynamic error, StackTrace? stackTrace)? error,
    R Function()? loading,
    R Function(T value)? data,
  }) {
    if (hasData && data != null) // If we have data then lets display it no-matter what!
      return data(requireData);
    if (connectionState != ConnectionState.done && loading != null) // Are we are still loading?
      return loading();
    else if (hasError && error != null) // Did we get an error?
      return error(this.error, stackTrace);
    else if (empty != null) // No data, not loading, no error, we're empty!
      return empty();
    else // We only get here if the developer does not provide any parameters
      throw UnsupportedError('Missing parameters to when()');
  }
}
