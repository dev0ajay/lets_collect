part of 'contact_us_bloc.dart';

abstract class ContactUsState extends Equatable {
  const ContactUsState();
}

class ContactUsInitial extends ContactUsState {
  @override
  List<Object> get props => [];
}

class ContactUsLoading extends ContactUsState {
  @override
  List<Object> get props => [];
}

class ContactUsLoaded extends ContactUsState {
  final ContactUsRequestResponse contactUsRequestResponse;
  const ContactUsLoaded({required this.contactUsRequestResponse});
  @override
  List<Object> get props => [contactUsRequestResponse];
}

class ContactUsErrorState extends ContactUsState {
  final String errorMsg;
  const ContactUsErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
