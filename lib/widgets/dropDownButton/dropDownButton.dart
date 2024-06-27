import 'package:flutter/material.dart';
import 'package:pfe/backendClass/fb_rdb.dart';

class DropDuwnButton extends StatefulWidget {
  final List<String> list;
  final int? taskid ; 
  final double width;
  final String  initvalue ; 
  
  const DropDuwnButton({super.key, required this.list, this.width = 155, required this.initvalue, required this.taskid});

  @override
  State<DropDuwnButton> createState() => DropDuwnButtonState();
}

class DropDuwnButtonState extends State<DropDuwnButton> {
  static String? dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.initvalue;
    super.initState();
  }

  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          isFocused = hasFocus;
        });
      },
      child: Container(
        height: 48,
        width: widget.width,
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          // Change the border color based on the focus state
          border: Border.all(
            color: isFocused ? Theme.of(context).primaryColor : Colors.blue, // Use blue color when not focused
            width: 1
          ),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_drop_down, color: isFocused ? Theme.of(context).primaryColor : Colors.grey), // Optional: change icon color when not focused
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black, fontSize: 16),
            onChanged: (String? newValue) {
              List<String> status = [
                                  "notAssgined",
                                  "a faire",
                                  "en attente",
                                  "en cours",
                                  "complete"
                                ]; 
                            List<String> priority = ["Urgente", "Élevée", "Normale", "Basse"]; 
              if(status.contains(newValue) && widget.taskid != null ) {
                 FB_RBD().Update_Data(
                              "Tasks/" +
                                  widget.taskid.toString() 
                                  ,
                              {"status": newValue.toString()});

              }if(priority.contains(newValue) && widget.taskid != null ) {

                 FB_RBD().Update_Data(
                              "Tasks/" +
                                  widget.taskid.toString() 
                                  ,
                              {"priority": newValue.toString()});
              }
              setState(() {
                if (newValue != null) {
                  dropdownValue = newValue;
                }
              });
            },
            items: widget.list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
