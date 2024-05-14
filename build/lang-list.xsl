<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ftf="urn:FTF-namespace">
	<xsl:variable name="lang-tunnel-path" select="processing-instruction('xslt-lang-tunnel')"/>
	<xsl:variable name="lang-sections" select="document($lang-tunnel-path)/ftf:tunnel/ftf:section"/>
	<xsl:template match="ftf:lang-list">
		<form id="lang-form" name="lang_form" method="get" action="#">
			<input type="hidden" name="content" value="{$lang-ring}.xml"/>
			<label for="lang-list">
				<xsl:call-template name="parse">
					<xsl:with-param name="id" select="local-name()"/>
				</xsl:call-template>
			</label>
			<select id="lang-list" name="lang" onChange="document.lang_form.submit()">
				<xsl:for-each select="$lang-sections">
					<xsl:element name="option">
						<xsl:attribute name="value">
							<xsl:value-of select="@id"/>
						</xsl:attribute>
						<xsl:if test="@id=$lang">
							<xsl:attribute name="selected">selected</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="@label"/>
					</xsl:element>
				</xsl:for-each>
			</select>
		</form>
	</xsl:template>
</xsl:stylesheet>