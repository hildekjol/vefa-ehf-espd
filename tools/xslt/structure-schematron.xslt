<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:s="urn:fdc:difi.no:2017:vefa:structure-1"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:u="utils"
                xmlns="http://purl.oclc.org/dsdl/schematron"
                exclude-result-prefixes="xsl xs s u">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:param name="pattern_only" select="'false'"/>
    <xsl:param name="prefix" select="if (/s:Structure/s:Reference[@type = 'sch:prefix']) then /s:Structure/s:Reference[@type = 'sch:prefix']/text() else 'STRUCTURE'"/>

    <xsl:function name="u:path" as="xs:string">
        <xsl:param name="e"/>

        <xsl:choose>
            <xsl:when test="$e/s:Reference[@type = 'sch:context' and text() = 'AS_ROOT']">
                <xsl:value-of select="normalize-space($e/s:Term/text())"/>
            </xsl:when>
            <xsl:when test="$e/s:Reference[@type = 'sch:context']">
                <xsl:value-of select="normalize-space($e/s:Reference[@type = 'sch:context']/text())"/>
            </xsl:when>
            <xsl:when test="$e/local-name() = 'Document'">
                <xsl:value-of select="normalize-space($e/s:Term/text())"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat(u:path($e/parent::element()), '/', normalize-space($e/s:Term/text()))"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="u:pid" as="xs:string">
        <xsl:param name="id"/>
        <xsl:value-of select="if (string-length(string($id)) &lt; 2) then concat('0', string($id)) else string($id)"/>
    </xsl:function>

    <xsl:template match="/s:Structure">
        <xsl:choose>
            <xsl:when test="$pattern_only = 'true'">
                <xsl:call-template name="pattern"/>
            </xsl:when>
            <xsl:otherwise>
                <schema schemaVersion="iso" queryBinding="xslt2">

                    <title>Basic rules for <xsl:value-of select="s:Name/text()" /></title>

                    <xsl:for-each select="s:Namespace">
                        <ns prefix="{@prefix}" uri="{text()}"/>
                    </xsl:for-each>

                    <xsl:call-template name="pattern"/>
                </schema>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="pattern">
        <pattern>
            <xsl:for-each select="//s:Document | //s:Element[s:Element or s:Attribute or s:Value[@type = 'FIXED']]">
                <xsl:call-template name="element"/>
            </xsl:for-each>
        </pattern>
    </xsl:template>

    <xsl:template name="element">
        <xsl:variable name="id" select="u:pid(position())"/>

        <rule context="{u:path(.)}">
            <!-- Verify existence of mandatory attributes. -->
            <xsl:for-each select="s:Attribute[not(@usage) or @usage = 'Mandatory']">
                <assert id="{$prefix}-B{$id}1{u:pid(position())}"
                        test="@{s:Term/text()}"
                        flag="fatal">Attribute <xsl:value-of select="s:Term/text()" /> MUST be present.</assert>
            </xsl:for-each>

            <!-- Verify fixed values in attributes. -->
            <xsl:for-each select="s:Attribute[s:Value[@type = 'FIXED']]">
                <assert id="{$prefix}-B{$id}2{u:pid(position())}"
                        test="not(@{s:Term/text()}) or @{s:Term/text()} = '{s:Value/text()}'"
                        flag="fatal">Attribute <xsl:value-of select="s:Term/text()" /> MUST be have value '<xsl:value-of select="s:Value/text()"/>'.</assert>
            </xsl:for-each>

            <!-- Verify fixed value of element -->
            <xsl:if test="s:Value[@type = 'FIXED']">
                <assert id="{$prefix}-B{$id}301"
                        test="normalize-space(text()) = '{s:Value/text()}'"
                        flag="fatal">Element <xsl:value-of select="s:Term/text()" /> MUST be have value '<xsl:value-of select="s:Value/text()"/>'.</assert>
            </xsl:if>

            <!-- Verify existence of mandatory elements. -->
            <xsl:for-each select="s:Element[not(@cardinality) or not(starts-with(@cardinality, '0..'))]">
                <assert id="{$prefix}-B{$id}4{u:pid(position())}"
                        test="{s:Term/text()}"
                        flag="fatal">Element <xsl:value-of select="s:Term/text()" /> MUST be present.</assert>
            </xsl:for-each>
        </rule>
    </xsl:template>

</xsl:stylesheet>