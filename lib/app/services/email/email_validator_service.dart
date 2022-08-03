import 'package:email_validator/email_validator.dart' show EmailValidator;

abstract class IEmailValidatorService {
  bool validate(
    String email, [
    bool allowTopLevelDomains = false,
    bool allowInternational = true,
  ]);
}

class EmailValidatorService implements IEmailValidatorService {
  bool validate(
    String email, [
    bool allowTopLevelDomains = false,
    bool allowInternational = true,
  ]) =>
      EmailValidator.validate(email, allowTopLevelDomains, allowInternational);
}
