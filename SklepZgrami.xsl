<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:exsl="http://exslt.org/common"
extension-element-prefixes="exsl">
<xsl:output method="html"/>
<xsl:key name="klucz_do_produktu" match="sklep_z_grami/produkty/gry/gra | sklep_z_grami/produkty/akcesoria/klawiatura |sklep_z_grami/produkty/akcesoria/mysz |sklep_z_grami/produkty/akcesoria/sluchawki" use="@id"/>
<xsl:template match="/">
	<html>
		<link rel="stylesheet" type="text/css" href="SklepZgrami.css"/>
		<head>
			<title>Sklep Z Grami</title>
		</head>
		<body>
			<h2>Sklep Z Grami</h2>
			<div class="produkty">
				<xsl:apply-templates select="sklep_z_grami/produkty"/>
			</div>
			<div clas="zamówienia">
				<xsl:apply-templates select="sklep_z_grami/zamówienia"/>
			</div>
			<footer>
				<p>Autor: Stefan Popiołek</p>
			</footer>
			<script src="SklepZgrami.js"><br/></script>
		</body>
	</html>
</xsl:template>

<xsl:template match="produkty">
	<h1>Produkty</h1>
	<div class="gry">
		<xsl:apply-templates select="./gry"/>
	</div>
	<div class="akcesoria">
		<xsl:apply-templates select="./akcesoria"/>
	</div>
</xsl:template>

<xsl:template match="gry">
	<h2>Gry</h2>
	 <div class="Filtry">
       <h4>Filtry</h4>
        Nazwa: <input type="text" id="szukaj_gry_nazwa" onkeyup="szukaj_Gry()" placeholder="Podaj nazwę" title="szukaj w grach"/>
        Gatunek: <input type="text" id="szukaj_gry_gatunek" onkeyup="szukaj_Gry()" placeholder="Podaj gatunek" title="szukaj w grach"/>
        Firma: <input type="text" id="szukaj_gry_firma" onkeyup="szukaj_Gry()" placeholder="Podaj nazwę fimry" title="szukaj w grach"/>
     </div>
     
	<table id="gry_tab">
		<tr>
			<th>nazwa</th>
			<th>firma</th>
			<th>gatunek</th>
			<th>cena zl</th>
			<th>cena USD</th>
			<th>cena euro</th>
		</tr>
		<xsl:for-each select="./gra">
			<tr>
				<td><xsl:value-of select="./nazwa"/></td>
				<td><xsl:value-of select="./firma"/></td>
				<td><xsl:value-of select="./gatunek"/></td>
				<td><xsl:apply-templates select="./cena" mode="zl"/></td>
				<td><xsl:apply-templates select="./cena" mode="USD"/></td>
				<td><xsl:apply-templates select="./cena" mode="euro"/></td>
			</tr>
		</xsl:for-each>
	</table>
</xsl:template>
<xsl:template match="akcesoria">
	<h2>Akcesoria</h2>
	<h3>Klawiatury</h3>
	<table id="klawiatury">
		<tr>
			<th>Nazwa</th>
			<th>Typ</th>
			<th>Długość kabla</th>
			<th>Firma</th>
			<th>Cena zl</th>
			<th>Cena USD</th>
			<th>Cena euro</th>
		</tr>
		<xsl:for-each select="./klawiatura">
			<tr>
				<td><xsl:value-of select="./nazwa"/></td>
				<td><xsl:value-of select="./typ"/></td>
				<td><xsl:value-of select="concat(./kabel,./kabel/@miara)"/></td>
				<td><xsl:value-of select="./firma"/></td>
				<td><xsl:apply-templates select="./cena" mode="zl"/></td>
				<td><xsl:apply-templates select="./cena" mode="USD"/></td>
				<td><xsl:apply-templates select="./cena" mode="euro"/></td>
			</tr>
		</xsl:for-each>
	</table>
	<h3>Myszki</h3>
	
	<table id="mysz_tab">
		<tr>
			<th>Nazwa</th>
			<th>Typ</th>
			<th>Długość kabla</th>
			<th>Firma</th>
			<th>Cena zl</th>
			<th>Cena USD</th>
			<th>Cena euro</th>
		</tr>
		<xsl:for-each select="./mysz">
			<tr>
				<td><xsl:value-of select="./nazwa"/></td>
				<td><xsl:value-of select="./typ"/></td>
				<td><xsl:value-of select="concat(./kabel,./kabel/@miara)"/></td>
				<td><xsl:value-of select="./firma"/></td>
				<td><xsl:apply-templates select="./cena" mode="zl"/></td>
				<td><xsl:apply-templates select="./cena" mode="USD"/></td>
				<td><xsl:apply-templates select="./cena" mode="euro"/></td>
			</tr>
		</xsl:for-each>
	</table>
	<h3>Słuchawki</h3>
	 Nazwa: <input type="text" id="nazwa_sluchawki" placeholder="Podaj nazwę" title="Nadaj nazwę"/>
        Firma: <input type="text" id="firma_sluchawki" placeholder="Podaj firmę" title="Nadaj firmę"/>
        Cena zl: <input type="number" id="cena_sluchawki" placeholder="Podaj cenę" title="Nadaj cenę" min="0.22" step="0.01" oninput="validity.valid||(value='');"/>
        <button onclick="dodajSłuchawki()">Dodaj</button> 
        	Nr Kolumny <input type="number" id="rzad_sluchawki" placeholder="Podaj rząd" title="Zmień rząd" min="1" step="1"/>
		<button id="update_button" onclick="update()">Update</button> 
	<table id="sluchawki_tab">
		<tr>
			<th>Nazwa</th>
			<th>Firma</th>
			<th>Cena zl</th>
			<th>Cena USD</th>
			<th>Cena euro</th>
		</tr>
		<xsl:for-each select="./sluchawki">
			<tr>
				<td><xsl:value-of select="./nazwa"/></td>
				<td><xsl:value-of select="./firma"/></td>
				<td><xsl:apply-templates select="./cena" mode="zl"/></td>
				<td><xsl:apply-templates select="./cena" mode="USD"/></td>
				<td><xsl:apply-templates select="./cena" mode="euro"/></td>
			</tr>
		</xsl:for-each>
	</table>
</xsl:template>
<xsl:template match="zamówienia">
	<div class="zamówienia">
		<h2>Zamówienia</h2>
		Usuń zamówienie nr:<input type="text" id="szukaj_zamowienie" placeholder="Podaj nazwę" title="usuń zamówienie"/>
		 <button onclick="usunZamowienie()">Usuń</button> 
		<xsl:for-each select="./zamówienie">
		
				<xsl:variable name="pomoc" select="@id_zam"/>
				<xsl:variable name="cena_łącznie">
					 <xsl:for-each select="./produkt">
						 <xsl:variable name="cen_zl" >
							<xsl:apply-templates select="key('klucz_do_produktu',@id)/cena" mode="zl"/>
						</xsl:variable>
						<number>
							<xsl:value-of select="$cen_zl*ilosc"/>
						</number>
					</xsl:for-each>
				</xsl:variable>
				<p><xsl:attribute name="id" select="concat($pomoc,'p')"/>Zamówienie nr:<xsl:value-of select="$pomoc"/></p>
				<table>
					<xsl:attribute name="id" select="$pomoc"/>
					<tr>
						<th>Produkt typ</th>
						<th>Nazwa</th>
						<th>Firma</th>
						<th>Ilość</th>
						<th>Cena sztuka</th>
						<th>Cena łącznie</th>
					</tr>
					<xsl:for-each select="./produkt">
						<xsl:variable name="cena_zl" >
							<xsl:apply-templates select="key('klucz_do_produktu',@id)/cena" mode="zl"/>
						</xsl:variable>
						<tr>
							<td><xsl:if test="substring(@id,1,3)='gra'">gra</xsl:if><xsl:if test="substring(@id,1,3)='kla'">klawiatura</xsl:if><xsl:if test="substring(@id,1,3)='slu'">słuchawki</xsl:if><xsl:if test="substring(@id,1,3)='mys'">mysz</xsl:if></td>
							<td><xsl:value-of select="key('klucz_do_produktu',@id)/nazwa"/></td>
							<td><xsl:value-of select="key('klucz_do_produktu',@id)/firma"/></td>
							<td><xsl:value-of select="ilosc"/></td>
							<td><xsl:value-of select="$cena_zl"/></td>
							<td><xsl:value-of select="$cena_zl*ilosc"/></td>
						</tr>
					</xsl:for-each>
					<tr>
						<th>Łącznie do zapłaty</th>
						<td> <xsl:value-of select="concat(sum(exsl:node-set($cena_łącznie)/number),'zl')"/></td>
					</tr>

				</table>
			
		</xsl:for-each>
	</div>

</xsl:template>








<xsl:template match="cena" mode="zl">
	<xsl:if test="@waluta='zl'">
		<xsl:value-of select="."/>
	</xsl:if>
	<xsl:if test="@waluta='USD'">
		<xsl:value-of select='format-number(.*4.14,"#.00")'/>
	</xsl:if>
	<xsl:if test="@waluta='euro'">
		<xsl:value-of select='format-number(.*4.52,"#.00")'/>
	</xsl:if>
</xsl:template>
<xsl:template match="cena" mode="USD">
	<xsl:if test="@waluta='zl'">
		<xsl:value-of select='format-number(.*0.24,"#.00")'/>
	</xsl:if>
	<xsl:if test="@waluta='USD'">
		<xsl:value-of select="."/>
	</xsl:if>
	<xsl:if test="@waluta='euro'">
		<xsl:value-of select='format-number(.*1.09,"#.00")'/>
	</xsl:if>
</xsl:template>
<xsl:template match="cena" mode="euro">
	<xsl:if test="@waluta='zl'">
		<xsl:value-of select='format-number(.*0.22,"#.00")'/>
	</xsl:if>
	<xsl:if test="@waluta='USD'">
		<xsl:value-of select='format-number(.*0.92,"#.00")'/>
	</xsl:if>
	<xsl:if test="@waluta='euro'">
		<xsl:value-of select="."/>
	</xsl:if>
</xsl:template>


</xsl:stylesheet> 
