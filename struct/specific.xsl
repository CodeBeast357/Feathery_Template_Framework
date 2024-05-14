<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ftf="urn:FTF-namespace">
	<xsl:include href="../build/lang-list.xsl"/>
	<xsl:include href="../build/nav-list.xsl"/>
	<xsl:variable name="img-dir">image</xsl:variable>
	<xsl:variable name="script-dir">script</xsl:variable>
	<xsl:variable name="style-dir">style</xsl:variable>
	<xsl:template match="ftf:layout-component[@ftf:role='body-content']">
		<xsl:apply-templates select="$page/body/*"/>
	</xsl:template>
	<xsl:template match="ftf:layout-component[@ftf:role='head-components']">
		<xsl:element name="meta">
			<xsl:attribute name="property">og:title</xsl:attribute>
			<xsl:attribute name="content">
				<xsl:call-template name="parse">
					<xsl:with-param name="id">title</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
		</xsl:element>
		<link rel="stylesheet" type="text/css" href="layout/layout.css"/>
		<link rel="stylesheet" type="text/css" href="{$style-dir}/default.css"/>
		<script type="text/javascript" src="{$script-dir}/common.js"></script>
		<script type="text/javascript" src="{$script-dir}/default.js"></script>
		<script type="text/javascript" src="{$script-dir}/standard.js"></script>
		<link rel="alternate" type="application/atom+xml" title="News (Atom 1.0)" href="news.atom"/>
		<link rel="alternate" type="application/rss+xml" title="News (RSS 2.0)" href="news.rss"/>
		<xsl:apply-templates select="$page/head/*"/>
	</xsl:template>
</xsl:stylesheet>