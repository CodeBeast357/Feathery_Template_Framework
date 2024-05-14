<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:ftf="urn:FTF-namespace">
	<xsl:include href="../struct/common.xsl"/>
	<xsl:output method="xml" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="ftf:layout-component[@ftf:role='head-title']">
		<xsl:text>Insert head title here</xsl:text>
	</xsl:template>
	<xsl:template match="ftf:layout-component[@ftf:role='head-components']">
		<link rel="stylesheet" type="text/css" href="layout.css"/>
	</xsl:template>
	<xsl:template match="ftf:layout-component[@ftf:role='index-content']">
		<xsl:text>Insert index content here</xsl:text>
	</xsl:template>
	<xsl:template match="ftf:layout-component[@ftf:role='body-header']">
		<xsl:text>Insert body header here</xsl:text>
	</xsl:template>
	<xsl:template match="ftf:layout-component[@ftf:role='body-content']">
		<xsl:text>Insert body content here</xsl:text>
	</xsl:template>
	<xsl:template match="ftf:layout-component[@ftf:role='body-footer']">
		<xsl:text>Insert body footer here</xsl:text>
	</xsl:template>
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>