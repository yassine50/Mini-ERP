import 'package:pfe/DataClass/tech.dart';

class TaskData { 
int? id  ; 
String? createdBy ; 
String? titre ; 
String? desc ; 
String? priority ; 
String? note = "" ; 
String? status ;  //notAssgined ["notAssgined", "a faire", "en attente", "en cours", "complete"],
List<String>? assgined  ; 
}