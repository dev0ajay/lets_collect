part of 'contact_us_bloc.dart';

abstract class ContactUsEvent extends Equatable {
  const ContactUsEvent();
}

class GetContactUsEvent extends ContactUsEvent{
  final ContactUsRequest contactUsRequest;
  const GetContactUsEvent({required this.contactUsRequest});
  @override
  List<Object?> get props => [];
}