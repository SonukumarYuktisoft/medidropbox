part of 'peyment_method_bloc.dart';

abstract class PeymentMethodEvent extends Equatable {
  const PeymentMethodEvent();
  @override
  List<Object> get props => [];
}

class OnCreateBooking extends PeymentMethodEvent{
   const OnCreateBooking({required this.gst,required this.taxableAmount,
   required this.totalAmount,required this.hosId,required this.docId});
   final String totalAmount;
   final String taxableAmount;
   final String gst;
   final String docId;
   final String hosId;
  @override
  List<Object> get props => [totalAmount,taxableAmount,gst,docId,hosId];
}
