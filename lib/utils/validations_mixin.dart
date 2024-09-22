mixin ValidationsMixin{
  String? isNotEmpty(String? value,[String? message]){
    if(value!.isEmpty)return message ??"Obrigatório";
    return null;
  }
  String? combine(List<String? Function()> validators){
    for (final func in validators){
      final validation =func();
      if(validation!=null)return validation;
    }
    return null;
  }
  String? isNotEmptyWithCondition(String? value,[bool? codition]){
    if(value!.isEmpty && codition!)return"Obrigatório";
    return null;}
  
}