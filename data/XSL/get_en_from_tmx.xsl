<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- a TXT file -->
    <xsl:output method="text" encoding="utf-8" indent="yes"/>

    <!-- break line -->
    <xsl:variable name="break" select="'&#xA;'"/>

    <!-- main template -->
    <xsl:template match="/">

        <!-- every '<seg>' element in english version -->
        <xsl:apply-templates select="//tuv[@xml:lang = 'en']/seg"/>

    </xsl:template>

    <!-- factory for a '<seg>' element -->
    <xsl:template match="seg">
        <xsl:value-of select="."/>
        <xsl:value-of select="$break"/>
    </xsl:template>

</xsl:stylesheet>