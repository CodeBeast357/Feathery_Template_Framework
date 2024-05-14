<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ftf="urn:FTF-namespace">
	<xsl:template match="ftf:nav-list">
		<ul id="nav-list">
			<li>
				<a href="title.xml">Index</a>
			</li>
			<li>
				<a href="news.atom">News (atom)</a>
			</li>
			<li>
				<a href="news.rss">News (rss)</a>
			</li>
			<li>
				<a href="temp.xml">Temp</a>
			</li>
			<xsl:for-each select="$page/ftf:navigation/ftf:relation">
				<li>
					<a href="{@url}">
						<xsl:call-template name="parse">
							<xsl:with-param name="id" select="@ftf:label"/>
						</xsl:call-template>
					</a>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
</xsl:stylesheet>