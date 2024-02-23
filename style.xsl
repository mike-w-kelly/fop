<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:template match="data">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <fo:layout-master-set>
        <fo:simple-page-master margin="10mm" page-width="210mm" page-height="297mm" master-name="simple">
          <fo:region-body region-name="simple-body" margin-bottom="20mm" margin-top="20mm" />
        </fo:simple-page-master>
      </fo:layout-master-set>
      <fo:page-sequence master-reference="simple">
        <fo:flow flow-name="simple-body">
          <xsl:apply-templates />
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>
  <xsl:template match="par">
    <fo:block>
        <xsl:value-of select="current-time()"/>
        <xsl:apply-templates />
    </fo:block>
  </xsl:template>
</xsl:stylesheet>