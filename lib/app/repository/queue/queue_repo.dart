import 'package:medidropbox/app/services/api_model.dart';

abstract class QueueRepo {
  Future<ApiModel> getMyQueues();
  Future<ApiModel>  getLiveQueueDoctor(String doctorId);
  Future<ApiModel>  getLiveQueueForDoctorPublicNoAuth(String doctorId);
 
}
