<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ftf="urn:FTF-namespace">
	<xsl:variable name="lang-tunnel" select="document('tunnel.xml')/ftf:tunnel"/>
	<xsl:variable name="lang" select="$page/@ftf:lang|$lang-tunnel/@default[not($page/@ftf:lang)]"/>
	<xsl:variable name="lang-ring" select="$page/@ftf:lang-ring"/>
	<xsl:variable name="def-values" select="document(concat($lang,'.xml'))/ftf:locale"/>
	<xsl:variable name="spec-values" select="document(concat($lang,'/',$lang-ring,'.xml'))/ftf:locale"/>
	<xsl:variable name="all-values" select="$spec-values|$def-values"/>
	<xsl:template match="ftf:token">
		<xsl:variable name="id" select="@ftf:id"/>
		<xsl:call-template name="parse">
			<xsl:with-param name="id" select="$id"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="parse">
		<xsl:param name="id"/>
		<xsl:choose>
			<xsl:when test="$all-values/ftf:value[@ftf:id=$id]">
				<xsl:apply-templates select="$all-values/ftf:value[@ftf:id=$id]"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:comment>
					<xsl:text>Missing localization for {</xsl:text>
					<xsl:value-of select="$id"/>
					<xsl:text>}.</xsl:text>
				</xsl:comment>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="ftf:value">
		<xsl:apply-templates/>
	</xsl:template>
</xsl:stylesheet>