<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:ftf="urn:FTF-namespace">
	<xsl:include href="common.xsl"/>
	<xsl:output method="text" encoding="UTF-8"/>
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="ftf:content">
		<xsl:apply-templates/>
	</xsl:template>
</xsl:stylesheet>