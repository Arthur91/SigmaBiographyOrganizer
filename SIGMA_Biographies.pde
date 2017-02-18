import controlP5.*;    //This library deals with controls for UI.
import java.util.*;
ControlP5 cp5;        //Control class object.

import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;

//To add dialog boxes.
import static javax.swing.JOptionPane.*;

//Biography class to store all records into.
Bio[] biographies;
String[] lines;
int recordCount;
int num = 4;
int startingEntry = 0;
ArrayList<String> foundBio = new ArrayList<String>();

String ap, am, name, id;
  
void setup(){
  size(800,700);
  PFont font = createFont("arial",15);
  PFont bioFont = createFont("arial", 11);
  cp5 = new ControlP5(this);
  
  cp5.addTextfield("Apellido paterno")
    .setPosition(20,10)
    .setSize(300,30)
    .setFont(font)
    .setColor(color(255,0,0));
    
  cp5.addTextfield("Apellido materno")
    .setPosition(20,70)
    .setSize(300,30)
    .setFont(font)
    .setColor(color(255,0,0));
  
  cp5.addTextfield("Nombre")
    .setPosition(20,130)
    .setSize(300,30)
    .setFont(font)
    .setColor(color(255,0,0));
    
  cp5.addTextfield("ID")
    .setPosition(400,10)
    .setSize(200,30)
    .setFont(font)
    .setFocus(true)
    .setColor(color(255,0,0));
    
  cp5.addButton("AGOTADO")
    .setPosition(20,200)
    .setSize(100,30)
    .setFont(font);
    
  cp5.addButton("ALTA")
    .setPosition(20,250)
    .setSize(100,30)
    .setFont(font);
  
  /*
  cp5.addButton("BAJA")
    .setPosition(20,300)
    .setSize(100,30)
    .setFont(font);
  */

  cp5.addButton("LIMPIAR")
    .setPosition(20,350)
    .setSize(100,30)
    .setFont(font);
    
  cp5.addScrollableList("BIOGRAFIAS")
    .setFont(bioFont)
    .setPosition(400, 80)
    .setSize(300,400)
    .setBarHeight(50)
    .setItemHeight(50);
}
void draw(){
  background(0);
  fill(255);
  ap = cp5.get(Textfield.class,"Apellido paterno").getText();
  am = cp5.get(Textfield.class,"Apellido materno").getText();
  name = cp5.get(Textfield.class,"Nombre").getText();
  id = cp5.get(Textfield.class,"ID").getText();
  if(id.length() <= 0){
    search(ap, am, name);
  }
}

//Automatically searches in the file registry with the starting name/ap/am.
void search(String ap, String am, String name){
  //If ap starts with...
  if(ap.length() > 0){
    //then search for record that holds that lastname.
    //println("Ap: " + ap);
    //Open file with the starting character.
    String fileName = ap.substring(0,1) + ".csv";
    lines = loadStrings(fileName);
    if(lines != null){
      //Work through each of the records.
      foundBio.clear();
      for(int i=0; i<lines.length; i++){
        String[] pieces = split(lines[i], TAB);
        //Find all records that match the query.
        if(ap.equals(pieces[0])){
          foundBio.add(pieces[0] + ", " + pieces[1] + ", " + pieces[2] + ", " + pieces[3]);
        }else{
          println("Match not found " + pieces[0] + " --- " + ap);
        }
      }
      if(!foundBio.isEmpty()){
        cp5.get(ScrollableList.class, "BIOGRAFIAS").setItems(foundBio);
      }
    }
    else{
      /*println("File does not exist. Creating.");
      //Add to the list of biographies to buy.
      AGOTADO(fileName, ap, am, name, id);*/
    }
  }
  else if(am.length() > 0){
    //println("Am: " + am);
    String fileName = "AMList.csv";
    lines = loadStrings(fileName);
    if(lines != null){
      //Work through each of the records.
      foundBio.clear();
      for(int i=0; i<lines.length; i++){
        String[] pieces = split(lines[i], TAB);
        //Find all records that match the query.
        if(am.equals(pieces[0])){
          foundBio.add(pieces[1] + ", " + pieces[0] + ", " + pieces[2] + ", " + pieces[3]);
        }else{
          println("Match not found " + pieces[0] + " --- " + am);
        }
      }
      if(!foundBio.isEmpty()){
        cp5.get(ScrollableList.class, "BIOGRAFIAS").setItems(foundBio);
      }
    }
    else{
      /*println("File does not exist. Creating.");
      //Add to the list of biographies to buy.
      AGOTADO(fileName, ap, am, name, id);*/
    }
  }
  else if(name.length() > 0){
    //println("Name: " + name);
    String fileName = "NameList.csv";
    lines = loadStrings(fileName);
    if(lines != null){
      //Work through each of the records.
      foundBio.clear();
      for(int i=0; i<lines.length; i++){
        String[] pieces = split(lines[i], TAB);
        //Find all records that match the query.
        if(name.equals(pieces[0])){
          foundBio.add(pieces[1] + ", " + pieces[2] + ", " + pieces[0] + ", " + pieces[3]);
        }else{
          println("Match not found " + pieces[0] + " --- " + name);
        }
      }
      if(!foundBio.isEmpty()){
        cp5.get(ScrollableList.class, "BIOGRAFIAS").setItems(foundBio);
      }
    }
    else{
      /*println("File does not exist. Creating.");
      //Add to the list of biographies to buy.
      AGOTADO(fileName, ap, am, name, id);*/
    }
  }
  else{
  }
}

//Cleans all elements of the screen.
public void LIMPIAR(){
  cp5.get(Textfield.class,"Apellido paterno").clear();
  cp5.get(Textfield.class,"Apellido materno").clear();
  cp5.get(Textfield.class,"Nombre").clear();
  cp5.get(Textfield.class,"ID").clear();
  cp5.get(ScrollableList.class, "BIOGRAFIAS").clear();
}

//Creates a new register.
public void ALTA(){
  if(ap.length() > 0 && am.length() > 0 && name.length() > 0 && id.length() > 0){
    //Save to the required ap.
    String apRecord = ap + TAB + am + TAB + name + TAB + id;
    String amRecord = am + TAB + ap + TAB + name + TAB + id;
    String nameRecord = name + TAB + ap + TAB + am + TAB + id;
    
    //Try to open file and if it exists, append record.
    String fileName = ap.substring(0,1) + ".csv";
    List<String> bioTmp = new ArrayList<String>();
    lines = loadStrings(fileName);
    if(lines != null){
      for(int i=0; i<lines.length; i++){
        bioTmp.add(lines[i]);
      }
    }
    bioTmp.add(apRecord);
    saveStrings(fileName, bioTmp.toArray(new String[bioTmp.size()]));
    
    
    //Save to the am directory.
    String amfileName = "AMList.csv";
    List<String> ambioTmp = new ArrayList<String>();
    lines = loadStrings(amfileName);
    if(lines != null){
      for(int i=0; i<lines.length; i++){
        ambioTmp.add(lines[i]);
      }
    }
    ambioTmp.add(amRecord);
    saveStrings(amfileName, ambioTmp.toArray(new String[ambioTmp.size()]));
    
    //Save to the name directory.
    String namefileName = "NameList.csv";
    List<String> namebioTmp = new ArrayList<String>();
    lines = loadStrings(namefileName);
    if(lines != null){
      for(int i=0; i<lines.length; i++)
        namebioTmp.add(lines[i]);
    }
    namebioTmp.add(nameRecord);
    saveStrings(namefileName, namebioTmp.toArray(new String[namebioTmp.size()]));
    showMessageDialog(null, "Alta realizada con exito", "Alerta", INFORMATION_MESSAGE);
  }else{
    showMessageDialog(null, "DATOS INCOMPLETOS!!!", "Alerta", ERROR_MESSAGE);
  }
}

//If item on list is pressed, display the id number.
void BIOGRAFIAS(int n){
  if(!foundBio.isEmpty()){
    String[] bioData = split(foundBio.get(n), ", ");
    cp5.get(Textfield.class, "Apellido paterno").setText(bioData[0]);
    cp5.get(Textfield.class, "Apellido materno").setText(bioData[1]);
    cp5.get(Textfield.class, "Nombre").setText(bioData[2]);
    cp5.get(Textfield.class, "ID").setText(bioData[3]);
  }
}

//Deletes a register.
public void BAJA(){
  println("Baja realizada");
}

//Marks a register as depleted so that it gets added to the "To Buy" list.
public void AGOTADO(){
  String tobuyFile = "00Comprar.csv";
  String depletedbioName = ap + "," + am + "," + name + "," + id;
  //Check all fields exist.
  if(ap.length() > 0 && am.length() > 0 && name.length() > 0 && id.length() > 0){
    List<String> biotoBuy = new ArrayList<String>();
    lines = loadStrings(tobuyFile);
    //Check if there's a To Buy file already.
    if(lines != null){
      //And add the data it holds if that's the case.
      for(int i=0; i<lines.length; i++){
        biotoBuy.add(lines[i]);
      }      
    }
    //Add new registry to file.
    biotoBuy.add(depletedbioName);
    saveStrings(tobuyFile, biotoBuy.toArray(new String[biotoBuy.size()]));
    showMessageDialog(null, "Registro guardado con exito", "Alerta", INFORMATION_MESSAGE);
  }
  else{
    showMessageDialog(null, "DATOS INCOMPLETOS!!!", "Alerta", ERROR_MESSAGE);
  }
}