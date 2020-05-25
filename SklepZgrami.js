
function szukaj_Gry() {
  // Declare variables
  var input0,input1,input2,filter0,filter1,filter2,table,tr,td,i,txtValue0,txtValue1,txtValue2;
  input0 = document.getElementById("szukaj_gry_nazwa");
  input1 = document.getElementById("szukaj_gry_firma");
  input2 = document.getElementById("szukaj_gry_gatunek");
  filter0 = input0.value.toUpperCase();
  filter1 = input1.value.toUpperCase();
  filter2 = input2.value.toUpperCase();
  table = document.getElementById("gry_tab");
  tr = table.getElementsByTagName("tr");

  // Loop through all table rows, and hide those who don't match the search query
  for (i = 0; i < tr.length; i++) {
    td0 = tr[i].getElementsByTagName("td")[0];
    td1 = tr[i].getElementsByTagName("td")[1];
    td2 = tr[i].getElementsByTagName("td")[2];
    if (td0) {
      txtValue0 = td0.textContent || td0.innerText;
      txtValue1 = td1.textContent || td1.innerText;
      txtValue2 = td2.textContent || td2.innerText;
      if (txtValue0.toUpperCase().indexOf(filter0) > -1 && txtValue1.toUpperCase().indexOf(filter1) > -1 && txtValue2.toUpperCase().indexOf(filter2) > -1 ) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
   
  }
}
function usunZamowienie(){
	var input=document.getElementById("szukaj_zamowienie");
	var element=document.getElementById(input.value);
	element.parentNode.removeChild(element);
	element=document.getElementById(input.value+'p');
	element.parentNode.removeChild(element);
}
function dodajSłuchawki(){
	var nazwa,firma,cena,tabela,rzad,kolmuna_nazwa,kolumna_firma,kolumna_cena_zl,kolumna_cena_USD,kolumna_cena_euro;
	nazwa=document.getElementById("nazwa_sluchawki").value;
	firma=document.getElementById("firma_sluchawki").value;
	cena=document.getElementById("cena_sluchawki").value;
	if( nazwa==="" ){
		alert("Podaj nazwę");
	}else if(firma===""){
		alert("Podaj firmę")
	}else{
		tabela=document.getElementById("sluchawki_tab");
		rzad=tabela.insertRow();
		kolumna_nazwa=rzad.insertCell(0);
		kolumna_firma=rzad.insertCell(1);
		kolumna_cena_zl=rzad.insertCell(2);
		kolumna_cena_USD=rzad.insertCell(3);
		kolumna_cena_euro=rzad.insertCell(4);
		kolumna_nazwa.innerHTML=nazwa;
		kolumna_firma.innerHTML=firma;
		kolumna_cena_zl.innerHTML=cena;
		kolumna_cena_USD.innerHTML=(cena*0.24).toFixed(2);
		kolumna_cena_euro.innerHTML=(cena*0.22).toFixed(2);
	}
}
function update(){
	var nazwa,firma,cena,tabela,rzad,kolmuna_nazwa,kolumna_firma,kolumna_cena_zl,kolumna_cena_USD,kolumna_cena_euro;
	nazwa=document.getElementById("nazwa_sluchawki").value;
	firma=document.getElementById("firma_sluchawki").value;
	cena=document.getElementById("cena_sluchawki").value;
	tabela=document.getElementById("sluchawki_tab");
	var nr=document.getElementById("rzad_sluchawki").value;
	var rzedy=tabela.getElementsByTagName("tr");
	if (tabela.rows.length-1<nr){
		alert("Nie ma takiego rzędu");
	}else{
		if(nazwa.length!=0){
			rzedy[nr].deleteCell(0);
			var komorka_naz=rzedy[nr].insertCell(0);
			komorka_naz.innerHTML=nazwa;
		}
		if(firma.length!=0){
			rzedy[nr].deleteCell(1);
			var komorka_naz=rzedy[nr].insertCell(1);
			komorka_naz.innerHTML=firma;
		}
		if(cena.length!=0){
			rzedy[nr].deleteCell(4);
			rzedy[nr].deleteCell(3);
			rzedy[nr].deleteCell(2);
			var komorka_cena1=rzedy[nr].insertCell(2);
			var komorka_cena2=rzedy[nr].insertCell(3);
			var komorka_cena3=rzedy[nr].insertCell(4);
			komorka_cena1.innerHTML=cena;
			komorka_cena2.innerHTML=(cena*0.24).toFixed(2);
			komorka_cena3.innerHTML=(cena*0.22).toFixed(2);
		}
		
	}
}

	
