<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:rss="urn:RSS-namespace" xmlns:ftf="urn:FTF-namespace">
	<xsl:include href="default.xsl"/>
	<xsl:variable name="feed" select="/atom:feed|/rss:rss/rss:channel"/>
	<xsl:variable name="feed-title" select="$feed/atom:title|$feed/rss:title"/>
	<xsl:template match="ftf:layout-component[@ftf:role='body-content']">
		<div class="hfeed h-feed">
			<h1>
				<a class="feed-title p-name" href="{$feed/atom:link[not(@rel) or @rel='alternate']/@href|$feed/rss:link}">
					<xsl:value-of select="$feed-title"/>
				</a>
			</h1>
			<h2>
				<xsl:value-of select="$feed/atom:subtitle|$feed/rss:description"/>
			</h2>
			<span>
				<xsl:text>Last updated </xsl:text>
				<abbr class="published dt-published" title="{$feed/atom:updated|$feed/rss:lastBuildDate}">
					<xsl:value-of select="$feed/atom:updated|$feed/rss:lastBuildDate"/>
				</abbr>
			</span>
			<xsl:apply-templates select="$feed/atom:entry|$feed/rss:item">
				<xsl:sort select="atom:updated|rss:pubDate" order="descending"/>
			</xsl:apply-templates>
		</div>
	</xsl:template>
	<xsl:template match="atom:entry|rss:item">
		<div class="hentry h-entry">
			<h3>
				<xsl:choose>
					<xsl:when test="atom:link[@rel='bookmark' or @rel='alternate' or not(@rel)]/@href|rss:link">
						<a class="entry-title p-name" href="{atom:link[@rel='bookmark' or @rel='alternate']/@href|rss:link}" rel="bookmark">
							<xsl:value-of select="atom:title|rss:title"/>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<span class="entry-title p-name">
							<xsl:value-of select="atom:title|rss:title"/>
						</span>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> - </xsl:text>
				<abbr class="updated dt-updated" title="{atom:updated|rss:pubDate}">
					<xsl:value-of select="atom:updated|rss:pubDate"/>
				</abbr>
			</h3>
			<div>
				<xsl:text>Published </xsl:text>
				<abbr class="published dt-published" title="{atom:published|atom:updated|rss:pubDate}">
					<xsl:value-of select="atom:published|atom:updated|rss:pubDate"/>
				</abbr>
				<xsl:apply-templates select="atom:author|rss:author"/>
				<xsl:if test="atom:contributor">
					<xsl:text> and </xsl:text>
					<xsl:for-each select="atom:contributor/atom:name">
						<span class="fn p-name">
							<xsl:value-of select="."/>
						</span>
						<xsl:if test="position()&lt;last()">
							<xsl:text>, </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="atom:summary or rss:description">
						<p class="entry-summary p-summary">
							<xsl:value-of select="atom:summary|rss:description" disable-output-escaping="yes"/>
						</p>
						<a href="{atom:link[not(@rel) or @rel='alternate']/@href|rss:link}">Continue reading...</a>
					</xsl:when>
					<xsl:when test="atom:content/@src">
						<a href="{atom:content/@src}">Go there.</a>
					</xsl:when>
					<xsl:otherwise>
						<p class="entry-content e-content">
							<xsl:value-of select="atom:content" disable-output-escaping="yes"/>
						</p>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="atom:author|rss:author">
		<address class="vcard author h-card">
			<xsl:choose>
				<xsl:when test="atom:email and atom:name">
					<a class="email fn p-name u-email" href="mailto:{atom:email}">
						<xsl:value-of select="atom:name"/>
					</a>
				</xsl:when>
				<xsl:when test="atom:uri and atom:name">
					<a class="url fn p-name u-url" href="{atom:uri}">
						<xsl:value-of select="atom:name"/>
					</a>
				</xsl:when>
				<xsl:when test="atom:name">
					<span class="fn p-name">
						<xsl:value-of select="atom:name"/>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<span class="fn">
						<xsl:value-of select="."/>
					</span>
				</xsl:otherwise>
			</xsl:choose>
		</address>
	</xsl:template>
</xsl:stylesheet>