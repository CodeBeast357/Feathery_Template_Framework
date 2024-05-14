<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ftf="urn:FTF-namespace">
	<xsl:include href="default.xsl"/>
	<xsl:template match="ftf:standard-form">
		<xsl:element name="form">
			<xsl:attribute name="name">
				<xsl:value-of select="@ftf:name"/>
			</xsl:attribute>
			<xsl:attribute name="method">
				<xsl:value-of select="@ftf:method"/>
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="@ftf:type='static'">
					<xsl:attribute name="action">
						<xsl:value-of select="@ftf:action"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="@ftf:type='dynamic'">
					<xsl:attribute name="action">#</xsl:attribute>
					<xsl:attribute name="onSubmit">try{sendSimpleForm('<xsl:value-of select="@ftf:action"/>', '<xsl:value-of select="@ftf:method"/>', callbacks.get('<xsl:value-of select="@ftf:name"/>'), this);}finally{return false;}</xsl:attribute>
				</xsl:when>
				<xsl:when test="@ftf:type='dynamic-xml'">
					<xsl:attribute name="action">#</xsl:attribute>
					<xsl:attribute name="onSubmit">try{sendSimpleXMLForm('<xsl:value-of select="@ftf:action"/>', '<xsl:value-of select="@ftf:method"/>', callbacks.get('<xsl:value-of select="@ftf:name"/>'), this);}finally{return false;}</xsl:attribute>
				</xsl:when>
			</xsl:choose>
			<fieldset>
				<legend>
					<xsl:call-template name="parse">
						<xsl:with-param name="id" select="@ftf:label"/>
					</xsl:call-template>
				</legend>
				<dl>
					<xsl:apply-templates select="ftf:input-field"/>
				</dl>
				<input type="submit" />
				<input type="reset" />
			</fieldset>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ftf:input-field">
		<xsl:variable name="field-label" select="@ftf:label"/>
		<xsl:variable name="field-id" select="generate-id(@ftf:label)"/>
		<xsl:variable name="importance" select="@ftf:importance"/>
		<xsl:variable name="default" select="@ftf:default"/>
		<dt>
			<xsl:choose>
				<xsl:when test="@ftf:type!='checkbox' and @ftf:type!='radio'">
					<label for="{$field-id}">
						<xsl:variable name="parsed-content">
							<xsl:call-template name="parse">
								<xsl:with-param name="id" select="$field-label"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:value-of select="$parsed-content"/>
					</label>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="parse">
						<xsl:with-param name="id" select="$field-label"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</dt>
		<dd>
			<xsl:choose>
				<xsl:when test="@ftf:type='text' or @ftf:type='password' or @ftf:type='file'">
					<xsl:element name="input">
						<xsl:attribute name="type">
							<xsl:value-of select="@ftf:type"/>
						</xsl:attribute>
						<xsl:attribute name="id">
							<xsl:value-of select="$field-id"/>
						</xsl:attribute>
						<xsl:attribute name="name">
							<xsl:value-of select="@ftf:name"/>
						</xsl:attribute>
						<xsl:attribute name="onBlur">validateField('<xsl:value-of select="parent::*/@ftf:name"/>', '<xsl:value-of select="@ftf:name"/>', '<xsl:value-of select="$importance"/>');</xsl:attribute>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@ftf:type='checkbox' or @ftf:type='radio'">
					<xsl:variable name="type" select="@ftf:type"/>
					<xsl:variable name="value-name" select="@ftf:name"/>
					<xsl:for-each select="ftf:option">
						<xsl:variable name="option-label" select="@ftf:label"/>
						<xsl:variable name="option-id" select="generate-id(@ftf:label)"/>
						<xsl:element name="input">
							<xsl:attribute name="type">
								<xsl:value-of select="$type"/>
							</xsl:attribute>
							<xsl:attribute name="id">
								<xsl:value-of select="$option-id"/>
							</xsl:attribute>
							<xsl:attribute name="name">
								<xsl:value-of select="$value-name"/>[]</xsl:attribute>
							<xsl:attribute name="value">
								<xsl:value-of select="@ftf:value"/>
							</xsl:attribute>
							<xsl:if test="contains($default, @ftf:value)">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</xsl:element>
						<label for="{$option-id}">
							<xsl:call-template name="parse">
								<xsl:with-param name="id" select="$option-label"/>
							</xsl:call-template>
						</label>
						<br/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="@ftf:type='select-single' or @ftf:type='select-multiple'">
					<xsl:element name="select">
						<xsl:attribute name="id">
							<xsl:value-of select="$field-id"/>
						</xsl:attribute>
						<xsl:attribute name="size">
							<xsl:value-of select="@ftf:size"/>
						</xsl:attribute>
						<xsl:attribute name="onBlur">validateField('<xsl:value-of select="parent::*/@ftf:name"/>', '<xsl:value-of select="@ftf:name"/>', '<xsl:value-of select="$importance"/>');</xsl:attribute>
						<xsl:choose>
							<xsl:when test="@ftf:type='select-multiple'">
								<xsl:attribute name="name">
									<xsl:value-of select="@ftf:name"/>[]</xsl:attribute>
								<xsl:attribute name="multiple">multiple</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="name">
									<xsl:value-of select="@ftf:name"/>
								</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:for-each select="ftf:option">
							<xsl:variable name="option-label" select="@ftf:label"/>
							<xsl:element name="option">
								<xsl:attribute name="value">
									<xsl:value-of select="@ftf:value"/>
								</xsl:attribute>
								<xsl:if test="contains($default, @ftf:value)">
									<xsl:attribute name="selected">selected</xsl:attribute>
								</xsl:if>
								<xsl:call-template name="parse">
									<xsl:with-param name="id" select="$option-label"/>
								</xsl:call-template>
							</xsl:element>
						</xsl:for-each>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@ftf:type='textarea'">
					<xsl:variable name="text-content">
						<xsl:call-template name="parse">
							<xsl:with-param name="id" select="$default"/>
						</xsl:call-template>
					</xsl:variable>
					<textarea id="{$field-id}" name="{@ftf:name}" onBlur="validateField('{parent::*/@ftf:name}', '{@ftf:name}', '{$importance}');">
						<xsl:value-of select="$text-content"/>
					</textarea>
				</xsl:when>
			</xsl:choose>
		</dd>
	</xsl:template>
</xsl:stylesheet>