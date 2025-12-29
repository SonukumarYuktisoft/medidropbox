import 'package:medidropbox/app/services/api_model.dart';

abstract class QueueRepo {
  Future<ApiModel> getMyQueues();
  Future<ApiModel>  getLiveQueueDoctor(String doctorId,{String? date =''});
  Future<ApiModel>  getLiveQueueForDoctorPublicNoAuth(String doctorId,{String? date =''});
 
}
