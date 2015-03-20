<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri="http://www.subshell.com/sophora/jsp" prefix="sophora" %>
<%@ page import="com.subshell.sophora.api.content.value.BinaryData" %>

<%-- Binärdaten der Original-Untertitel-XML holen --%>
<c:set var="bytes" value="${current.binarydata.binaryData.bytes}" />
<%
byte[] bytes = (byte[]) pageContext.getAttribute("bytes");
pageContext.setAttribute("xmltext", new String(bytes));
%>

<%-- XSL für die Transformation, Quelle IRT --%>
<c:set var="xslt">
		<?xml version="1.0" encoding="UTF-8"?>
		<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		    xmlns:xs="http://www.w3.org/2001/XMLSchema"
		    xmlns:tt="http://www.w3.org/ns/ttml" xmlns:ttp="http://www.w3.org/ns/ttml#parameter"
		    xmlns:tts="http://www.w3.org/ns/ttml#styling" xmlns:ebuttm="urn:ebu:tt:metadata"
		    exclude-result-prefixes="xs"
		    version="1.0">
		    <xsl:output encoding="UTF-8" method="text"/>
		<xsl:template match="/">WEBVTT<xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>
		 <xsl:apply-templates select="//tt:p"/>
		 </xsl:template>
		<xsl:template match="tt:p">
		<xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>
		<xsl:value-of select="@xml:id"/><xsl:text>&#xa;</xsl:text>
		<xsl:value-of select="@begin"/> --&#x003E; <xsl:value-of select="@end"/><xsl:text>&#xa;</xsl:text>
		<xsl:apply-templates select="tt:span|tt:br"/>  
		</xsl:template>
		<xsl:template match="tt:span">
		<xsl:value-of select="."/>
		</xsl:template>
		 <xsl:template match="tt:br">
		<xsl:text>&#xa;</xsl:text>
		</xsl:template>
		</xsl:stylesheet>
</c:set>

<%-- Transformation ausführen --%>
<x:transform doc="${xmltext}" xslt="${xslt}"/>
