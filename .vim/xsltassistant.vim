" xsltassistant.vim
" 
" Version 1.0
" 01/2009 by wywacczy (wywacczy@gmail.com)
" 

"==================================
" KEYS         MAKES
"==================================
",an     <xsl:attribute name="">
"        </xsl:attribute>
"
""""""""""""""""""""""""""""""""""""
",as     <xsl:apply-templates select=""/>
"
""""""""""""""""""""""""""""""""""""
",at     <xsl:apply-templates/>        
"
""""""""""""""""""""""""""""""""""""
",cp     <xsl:copy>
"          
"        </xsl:copy>
"
""""""""""""""""""""""""""""""""""""
",co     <xsl:copy-of select="">
"        </xsl:copy>
"      
""""""""""""""""""""""""""""""""""""
",ce     <xsl:choose>
"  
"        </xsl:choose>
"       
""""""""""""""""""""""""""""""""""""
",ch     <xsl:choose>
"          <xsl:when test="">
"          </xsl:when>
"          <xsl:otherwise>
"            
"          </xsl:otherwise>
"        </xsl:choose>
"
""""""""""""""""""""""""""""""""""""
",ct     <xsl:call-template select="">
"        </xsl:call-template>
"
""""""""""""""""""""""""""""""""""""
",en     <xsl:element name="">
"        </xsl:element>
"        
""""""""""""""""""""""""""""""""""""
",fe     <xsl:for-each select="">
"        </xsl:for-each>
"
""""""""""""""""""""""""""""""""""""
",if     <xsl:if test="">
"        </xsl:if>
"
""""""""""""""""""""""""""""""""""""
",msg    <xsl:message>
"          
"        </xsl:message>
"        
""""""""""""""""""""""""""""""""""""
",ow     <xsl:otherwise>
"  
"        </xsl:otherwise>
"
""""""""""""""""""""""""""""""""""""
",sty    <?xml version="1.0"?>
"        <xsl:stylesheet
"        version="1.0"
"        xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
"          
"        </xsl:stylesheet>
"
""""""""""""""""""""""""""""""""""""
",te     <xsl:template match=""/>
"
""""""""""""""""""""""""""""""""""""
",tm     <xsl:template match="">
"        </xsl:template>
"       
""""""""""""""""""""""""""""""""""""
",tn     <xsl:template name="">
"        </xsl:template>
"
""""""""""""""""""""""""""""""""""""
",tt     <xsl:text></xsl:text>
"
""""""""""""""""""""""""""""""""""""
",vn     <xsl:variable name="" select=""/>
"
""""""""""""""""""""""""""""""""""""
",vo     <xsl:value-of select=""/>
"
""""""""""""""""""""""""""""""""""""
",wh     <xsl:when test="">
"        </xsl:when>
"
""""""""""""""""""""""""""""""""""""
",wp     <xsl:with-param name="" select=""/>        
"
""""""""""""""""""""""""""""""""""""

" On to loading xml.vim
runtime ftplugin/xml.vim

inoremap " ""<ESC>i

imap ,tm <xsl:template match="<esc>la><CR><esc>k$hi
imap ,tn <xsl:template name="<esc>la><CR><esc>k$hi
imap ,te <xsl:template match="<esc>la/><esc>$2hi
imap ,ct <xsl:call-template name="<esc>la><CR><esc>k$hi
imap ,at <xsl:apply-templates/>
imap ,as <xsl:apply-templates select="<esc>la/><esc>2hi
imap ,vn <xsl:variable name="<esc>la select="<esc>la/><esc>3bla
imap ,vo <xsl:value-of select="<esc>la/><esc>$2hi
imap ,if <xsl:if test="<esc>la><CR><esc>k$hi
imap ,wh <xsl:when test="<esc>la><CR><esc>k$hi
imap ,ow <xsl:otherwise><CR><esc>O
imap ,ce <xsl:choose><CR><esc>O
imap ,ch ,ce,ow<esc>kO,wh
imap ,fe <xsl:for-each select="<esc>la><CR><esc>k$hi
imap ,en <xsl:element name="<esc>la><CR><esc>k$hi
imap ,an <xsl:attribute name="<esc>la><CR><esc>k$hi
imap ,wp <xsl:with-param name="<esc>la select="<esc>la/><esc>bbbla
imap ,tt <xsl:text>
imap ,cp <xsl:copy><CR><esc>O
imap ,co <xsl:copy-of select="<esc>la><CR><esc>k$hi
imap ,msg <xsl:message><CR><esc>O
imap ,sty <?xml version="1.0<esc>la?><CR><xsl:stylesheet<CR>version="1.0<esc>la<CR>xmlns:xsl="http://www.w3.org/1999/XSL/Transform<esc>la><CR><esc>O
