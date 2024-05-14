<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ftf="urn:FTF-namespace">
	<xsl:include href="common.xsl"/>
	<xsl:include href="../lang/parser.xsl"/>
	<xsl:variable name="page" select="/*"/>
	<!-- <xsl:variable name="layout" select="document('layout/layout.xml')/html"/> -->
	<xsl:variable name="layout-path" select="processing-instruction('xslt-layout')"/>
	<xsl:variable name="layout" select="document($layout-path)/html"/>
	<xsl:variable name="build-config-path" select="processing-instruction('xslt-build-config')"/>
	<xsl:variable name="build-config" select="document($build-config-path)/ftf:config"/>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
	<!-- <xsl:output method="xml" encoding="UTF-8"/> -->
	<xsl:template match="/">
		<xsl:apply-templates select="$layout"/>
	</xsl:template>
	<xsl:template match="*[namespace-uri()='']">
		<xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template name="build">
		<xsl:param name="config"/>
		<xsl:choose>
			<xsl:when test="$config/@ftf:template">
				<xsl:apply-templates select="document($config/@ftf:template)/ftf:layout-artefact"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="parse">
					<xsl:with-param name="id" select="$config/@ftf:id"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="ftf:layout-component[@ftf:type='artefact']">
		<xsl:variable name="name" select="@ftf:role"/>
		<xsl:call-template name="build">
			<xsl:with-param name="config" select="$build-config/ftf:build[@ftf:id=$name]"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="ftf:layout-component[not(@ftf:type) or @ftf:type='plain']">
		<xsl:call-template name="parse">
			<xsl:with-param name="id" select="@ftf:role"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="ftf:layout-artefact">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:include href="specific.xsl"/>
</xsl:stylesheet>