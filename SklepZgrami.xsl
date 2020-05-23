<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:key name="klucz_do_produktu" match="sklep_z_grami/produkty/gry/gra | sklep_z_grami/produkty/akcesoria/klawiatura |sklep_z_grami/produkty/akcesoria/mysz |sklep_z_grami/produkty/akcesoria/sluchawki" use="@id"/>
<xsl:template match="/">
	<html>
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
	<h2>gry</h2>
	<table>
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
	<table>
		<tr>
			<th>nazwa</th>
			<th>typ</th>
			<th>długość kabla</th>
			<th>firma</th>
			<th>cena zl</th>
			<th>cena USD</th>
			<th>cena euro</th>
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
	<table>
		<tr>
			<th>nazwa</th>
			<th>typ</th>
			<th>długość kabla</th>
			<th>firma</th>
			<th>cena zl</th>
			<th>cena USD</th>
			<th>cena euro</th>
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
	<table>
		<tr>
			<th>nazwa</th>
			<th>firma</th>
			<th>cena zl</th>
			<th>cena USD</th>
			<th>cena euro</th>
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
		<xsl:for-each select="./zamówienie">
			<p1>Zamówienie nr: <xsl:value-of select="@id_zam"/></p1>
			<table>
				<tr>
					<th>Produkt typ</th>
					<th>nazwa</th>
					<th>firma</th>
					<th>ilość</th>
					<th>cena sztuka</th>
					<th>cena łącznie</th>
				</tr>
				<xsl:for-each select="key('klucz_do_produktu',@id)">
					<xsl:variable name="pomoc" >
						<xsl:apply-templates select="./cena" mode="zl"/>
					</xsl:variable>
					<tr>
						<td><xsl:if test="substring(@id,1,3)='gra'">gra</xsl:if><xsl:if test="substring(@id,1,3)='kla'">klawiatura</xsl:if><xsl:if test="substring(@id,1,3)='slu'">słuchawki</xsl:if><xsl:if test="substring(@id,1,3)='mys'">mysz</xsl:if></td>
						<td><xsl:value-of select="./nazwa"/></td>
						<td><xsl:value-of select="./firma"/></td>
						<td><xsl:value-of select="zamówienie/ilosc"/></td>
						<td><xsl:value-of select="$pomoc"/></td>
						<td><xsl:value-of select="$pomoc*zamówienie/ilosc"/></td>
					</tr>
				
				</xsl:for-each>
				
			
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
