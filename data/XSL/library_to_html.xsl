<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">

	<!-- output as HTML -->
	<xsl:output method="html" encoding="utf-8" indent="yes"/>
		
	<!-- index for stars -->
	<xsl:key name="stars" match="mark" use="."/>
		
	<!-- main template -->
	<xsl:template match="/">

		<!-- DOCTYPE -->
		<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
		<xsl:text>&#9;</xsl:text>
				
		<!-- HTML structure -->
		<html lang="fr" xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>Ma bibliothèque</title>
				<meta charset="utf-8"/>
				<meta name="viewport" content="width=device-width, initial-scale=1"/>

				<!-- Bootstrap stylesheet -->
				<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous"/>
			</head>
			<body>
				<!-- BS5 container -->
				<div class="container-fluid">

					<!-- books -->
					<h1>Liste des livres</h1>
					<!-- Grouped by stars -->
					<xsl:apply-templates select="//mark[count( . | key('stars', .)[1]) = 1]">
						<xsl:sort select="." order="descending" data-type="number"/>
					</xsl:apply-templates>

					<!-- authors -->
					<h1>Liste des auteurs</h1>
					<!-- layout: two authors by column -->
					<div class="row row-cols-1 row-cols-md-3 g-4">
						<!-- call to the template -->
						<xsl:apply-templates select="//author">
							<!-- sorted by last name -->
							<xsl:sort select="lastName"/>
						</xsl:apply-templates>
					</div>

				</div>
			</body>
		</html>
	</xsl:template>
		
	<!-- card component -->
	<xsl:template name="Card">
				
		<!-- variables -->
		<xsl:param name="title"/>
		<xsl:param name="path"/>
		<xsl:param name="addOn"/>
				
		<!-- layout of a card -->
		<div class="col">
			<xsl:element name="div">
				<xsl:attribute name="class">
					<xsl:value-of select="'card'"/>
				</xsl:attribute>
				<xsl:attribute name="style">
					<xsl:value-of select="'width:18rem;'"/>
				</xsl:attribute>
				<xsl:choose>
					<xsl:when test="name(.) = 'author'">
						<xsl:attribute name="id">
							<xsl:value-of select="@id_author"/>
						</xsl:attribute>
					</xsl:when>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="name(.) = 'book'">
						<xsl:element name="a">
							<xsl:attribute name="href">
								<xsl:value-of select="concat('#', @ref_author)"/>
							</xsl:attribute>
							<img src="{$path}" class="card-img-top" alt="Illustration de {$title}" style="height:300"/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<img src="{$path}" class="card-img-top" alt="Photo de {$title}" style="height:300"/>
					</xsl:otherwise>
				</xsl:choose>
				<div class="card-body">
					<h5 class="card-title">
						<xsl:value-of select="$title"/>
						<xsl:text> (</xsl:text>
						<xsl:value-of select="$addOn"/>
						<xsl:text>)</xsl:text>
						<!-- optional: stars -->
						<xsl:if test="mark">
							<div class="text-center mt-2">
								<xsl:call-template name="Star">
									<xsl:with-param name="nb" select="mark"/>
								</xsl:call-template>
							</div>
						</xsl:if>
					</h5>
				</div>
			</xsl:element>
		</div>
	</xsl:template>
		
	<!-- mark template -->
	<xsl:template match="mark">
		<xsl:variable name="nb" select="."/>
		<xsl:element name="h2">
			<xsl:value-of select="concat($nb, ' étoiles')"/>
		</xsl:element>
		<!-- card grid -->
		<div class="row row-cols-1 row-cols-md-3 g-4">
			<xsl:apply-templates select="//book[mark = $nb]">
				<!-- sorted by title -->
				<xsl:sort select="title"/>
			</xsl:apply-templates>
		</div>
	</xsl:template>
		
	<!-- book template -->
	<xsl:template match="book">
		<xsl:variable name="id_author" select="@ref_author"/>
		<xsl:variable name="author" select="//author[@id_author = $id_author]"/>
		<!-- call to the template 'Card' -->
		<xsl:call-template name="Card">
			<!-- fix the parameters -->
			<xsl:with-param name="title" select="concat(title, ', de ', $author/firstName, ' ', $author/lastName)"/>
			<xsl:with-param name="path" select="concat('images/books/', translate(title, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ô,', 'abcdefghijklmnopqrstuvwxyz-o'),'.jpg')"/>
			<xsl:with-param name="addOn">
				<!-- title or original title? -->
					<xsl:if test="title/@original_title and not(title/@original_title = title)">
						<xsl:value-of select="title/@original_title"/>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<!-- publication date -->
					<xsl:value-of select="publication"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
		
	<!-- author template -->
	<xsl:template match="author">
		<!-- call to the template 'Card' -->
		<xsl:call-template name="Card">
			<!-- fix the parameters -->
			<xsl:with-param name="title" select="concat(firstName, ' ', lastName)"/>
			<xsl:with-param name="path" select="concat('images/authors/', translate(lastName, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),'.jpg')"/>
			<xsl:with-param name="addOn">
				<!-- birth date -->
				<xsl:value-of select="substring(birth, 1, 4)"/>
				<xsl:text>-</xsl:text>
				<!-- death date -->
				<xsl:value-of select="substring(death, 1, 4)"/>
			</xsl:with-param>
		</xsl:call-template>        
	</xsl:template>
		
	<!-- component: Star -->
	<xsl:template name="Star">
		<!-- number of stars? -->
		<xsl:param name="nb"/>
		<!-- fetch icon -->
		<img src="images/icons/star.svg" width="20" />
		<!-- if nb > 1 -->
		<xsl:if test="number($nb) &gt; 1">
			<!-- call the component till it is needed -->
			<xsl:call-template name="Star">
				<!-- nb - 1 -->
				<xsl:with-param name="nb" select="number($nb - 1)"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>