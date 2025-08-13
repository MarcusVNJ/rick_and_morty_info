import 'package:rick_and_morty_info/core/error/failure.dart';

sealed class RequestFailure extends Failure {
  const RequestFailure({required super.message, super.errorCode});
}

class BadRequestError extends RequestFailure {
  const BadRequestError({
    super.message = 'Sua requisição não pôde ser processada. Verifique os dados enviados.',
    super.errorCode = 400,
  });
}

class TimeOutError extends RequestFailure {
  const TimeOutError({
    super.message = 'A conexão demorou mais que o esperado. Verifique sua conexão e tente novamente.'
  });
}

class InternalServerError extends RequestFailure {
  const InternalServerError({
    super.message = 'Houve um problema com o servidor. Tente novamente mais tarde.',
    super.errorCode = 500,
  });
}

class NoConnectionError extends RequestFailure {
  const NoConnectionError({
    super.message = 'Não foi possível se conectar ao servidor. Verifique sua conexão com a internet.'
  });
}

class RequestCancelledError extends RequestFailure {
  const RequestCancelledError({
    super.message = 'A requisição foi cancelada.',
  });
}

class UnknownError extends RequestFailure {
  const UnknownError({
    super.message = 'Ocorreu um erro inesperado. Por favor, contate o suporte.',
  });
}