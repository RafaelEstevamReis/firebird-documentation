<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="src"
                version="1.0">


  <!-- A component (e.g. article) index should be in the ToC: -->

  <xsl:template name="component.toc">
    <xsl:param name="toc-context" select="."/>

    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <xsl:variable name="cid">
      <xsl:call-template name="object.id">
        <xsl:with-param name="object" select="$toc-context"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="nodes" select="section|sect1|refentry
                                       |article|bibliography|glossary
                                       |appendix|index"/>               <!-- added index -->
    <xsl:if test="$nodes">
      <fo:block id="toc...{$id}"
                xsl:use-attribute-sets="toc.margin.properties">
        <xsl:call-template name="table.of.contents.titlepage"/>
        <xsl:apply-templates select="$nodes" mode="toc">
          <xsl:with-param name="toc-context" select="$toc-context"/>
        </xsl:apply-templates>
      </fo:block>
    </xsl:if>
  </xsl:template>


  <!-- only refer to index in toc if index is really gonna be there -->
  <xsl:template match="index" mode="toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:if test="count(.//indexentry) > 0 or $generate.index != 0">
      <!-- original first test used to be *, causing index toc entry to be
           generated if empty index had title! -->
      <xsl:call-template name="toc.line"/>
    </xsl:if>
  </xsl:template>



</xsl:stylesheet>
