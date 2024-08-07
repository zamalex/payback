import 'package:dio/dio.dart';

class DioErrorHelper {
  static String handleError(DioError error) {
    String errorDescription = '';

    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = 'Request to API server was cancelled';
          break;

        case DioErrorType.connectTimeout:
          errorDescription = 'Connection timeout with API server';
          break;

        case DioErrorType.sendTimeout:
          errorDescription = 'Send timeout in connection with API server';
          break;

        case DioErrorType.receiveTimeout:
          errorDescription = 'Receive timeout in connection with API server';
          break;

        case DioErrorType.response:
        // Handle DioErrorType.response
          if (error.response != null) {
           try{
             final statusCode = error.response!.statusCode;
             final data = error.response!.data;
             //e.response?.data['message']??e.message
             String e = data['message']??error.message;
             if(data['data']!=null){

               data['data'].forEach((k, v) {
                 e = '${e} \n ${v}';
               });
             }

             errorDescription =
             'Code: $statusCode\nResponse data: ${e}';
           }catch(e){
             errorDescription = 'Response was invalid';

           }
          } else {
            errorDescription = 'Response was null';
          }
          break;

        case DioErrorType.other:
          errorDescription = 'Something went wrong while processing Dio request';
          break;
      }
    } else {
      errorDescription = 'Unexpected error occurred';
    }

    return errorDescription;
  }
}