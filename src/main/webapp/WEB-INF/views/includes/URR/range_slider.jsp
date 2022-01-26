<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
<c:set var="labelName" value="${param.labelName}"/>


<c:set var="rangeName" value="${param.rangeName}"/>
<c:set var="rangeMin" value="${param.rangeMin}"/>
<c:set var="rangeMax" value="${param.rangeMax}"/>
<c:set var="rangeStep" value="${empty param.rangeStep ? 1 : param.rangeStep}"/>
<c:set var="rangeUnit" value="${param.rangeUnit}"/>

<%-- current range--%>
<c:set var="criMin" value="${param.criMin}"/>
<c:set var="criMax" value="${param.criMax}"/>

<div class="search-element">
	<p>
	  <input type="hidden" id="search_${rangeName}_min" name="${rangeName}_min" readonly style="border:0; color:#f6931f; font-weight:bold;">
	  <input type="hidden" id="search_${rangeName}_max" name="${rangeName}_max" readonly style="border:0; color:#f6931f; font-weight:bold;">
	  <label for="search_${rangeName}">${labelName} : </label>
	  <input type="text" id="search_${rangeName}" readonly style="border:0; color:#f6931f; font-weight:bold;">
	</p>
	<div id="${rangeName}-slider-range"></div>
	<script>
	  $( function() {
	    $( "#${rangeName}-slider-range" ).slider({
	      range: true,
	      min: ${rangeMin},
	      max: ${rangeMax},
	      step: ${rangeStep},
	      values: [ ${criMin}, ${criMax} ],
	      slide: function( event, ui ) {
	        $( "#search_${rangeName}" ).val(ui.values[ 0 ] + "${rangeUnit}　-　" + ui.values[ 1 ] +  "${rangeUnit}");
	        $( "#search_${rangeName}_min" ).val(ui.values[ 0 ]);
	        $( "#search_${rangeName}_max" ).val(ui.values[ 1 ]);
	      }
	    });
	    $( "#search_${rangeName}_min" ).val($( "#${rangeName}-slider-range" ).slider( "values", 0 ));
        $( "#search_${rangeName}_max" ).val($( "#${rangeName}-slider-range" ).slider( "values", 1 ));
	    $( "#search_${rangeName}" ).val($( "#${rangeName}-slider-range" ).slider( "values", 0 ) +
	    		 "${rangeUnit}　-　" + $( "#${rangeName}-slider-range" ).slider( "values", 1 )+  "${rangeUnit}" );
	  });
  </script>
</div>