<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">

	<!-- output as TXT -->
	<xsl:output method="text" encoding="utf-8" indent="yes"/>

	<!-- variables for break line and tabulation -->
	<xsl:variable name="break" select="'&#10;'"/>
	<xsl:variable name="tab" select="'&#09;'"/>

	<!-- main template -->
	<xsl:template match="/">

		<!-- header -->
		<xsl:call-template name="Header"/>

		<!-- a book by row -->
		<xsl:apply-templates select="//book"/>

	</xsl:template>

	<!-- template for a book -->
	<xsl:template match="book">
		<xsl:value-of select="title"/>
		<xsl:value-of select="$tab"/>
		<xsl:value-of select="publication"/>
		<xsl:value-of select="$tab"/>
		<xsl:value-of select="summary"/>
		<xsl:value-of select="$tab"/>
		<xsl:value-of select="mark"/>
		<xsl:value-of select="$tab"/>
		<xsl:value-of select="@xml:lang"/>
		<xsl:value-of select="$tab"/>
		<xsl:value-of select="title/@original_title"/>
		<xsl:value-of select="$tab"/>
		<xsl:value-of select="title/@original_lang"/>
		<xsl:value-of select="$break"/>
	</xsl:template>
		
	<!-- component: Header -->
	<xsl:template name="Header">
		<xsl:value-of select="'title'"/>
		<xsl:value-of select="$tab"/>
		<xsl:value-of select="'publication'"/>
		<xsl:value-of select="$tab"/>
		<xsl:value-of select="'summary'"/>
		<xsl:value-of select="$tab"/>
		<xsl:value-of select="'mark'"/>
		<xsl:value-of select="$tab"/>
		<xsl:value-of select="'language'"/>
		<xsl:value-of select="$tab"/>
		<xsl:value-of select="'original_title'"/>
		<xsl:value-of select="$tab"/>
		<xsl:value-of select="'original_language'"/>
		<xsl:value-of select="$break"/>
	</xsl:template>

</xsl:stylesheet>