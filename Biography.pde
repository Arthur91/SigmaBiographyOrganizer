class Bio{
  String name, ap, am;
  int id;
  
  public Bio(String[] data){
    id = int(data[0]);
    name = data[1];
    ap = data[2];
    am = data[3];
  }
}