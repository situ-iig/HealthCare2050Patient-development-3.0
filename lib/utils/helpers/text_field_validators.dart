class TextFieldValidators{
  String text;
  TextFieldValidators(this.text);


  String? defaultValidator() {
    if (text.isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }

  String? emailValidator(){
    if (text.isEmpty) {
      return 'Email is Required';
    }
    if (!RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(text)) {
      return 'Please enter a valid email Address';
    }
    return null;
  }

  String? phoneValidator(){
    if(text.length <=9){
      return "Please enter a valid number";
    }else{
      return null;
    }
  }

  var pinRegExp = RegExp("[1-9][0-9]{5}");

  String? pinCodeValidator(){
    if(!pinRegExp.hasMatch(text)){
      return "Please enter a valid pin code";
    }

    else{
      return null;
    }
  }
  String? ageValidator(){
    if(text.isEmpty){
      return "Please enter age";
    }else {
      return null;
    }
  }
}