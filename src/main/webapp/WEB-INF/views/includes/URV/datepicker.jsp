<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
<script src="/resources/lib/jquery-ui-1.13.0/datepicker-ja.js"></script>
<script type="text/javascript">
//script for datepicker
  function resett(resetflg) { $( function () {
	$( "#startdate" ).datepicker( "destroy" );
	$( "#enddate" ).datepicker( "destroy" );
	var cannot_select_after = new Date('9999-12-31');
	var cannot_select_before = new Date('1970-01-01');
    var startdates = ${startdates};
    var enddates = ${enddates};
    var dateFormat = "yy-mm-dd",
      from = $( "#startdate" )
        .datepicker({
          dateFormat : "yy-mm-dd",
          minDate: 0,
          maxDate: "+3Y",
          defaultDate: "+1w",
          changeMonth: true,
          changeYear: true,
          //showOn: "both",
          //buttonImage: "/resources/img/calendar.png",
          //buttonImageOnly: true,
          //buttonText: "Select date",
          beforeShowDay: function(date){
        	  //date: 달력 날짜 한칸 -> ret[0] : true ->선택가능 ,false -> 선택불가
        	  //달력페이지가 바뀔때 마다 각 달력날짜에 대해 호출
              var flag = true;
              const nineHours = 32400000;
              for(var i = 0;i < startdates.length ;i++) {
            	  if(new Date(startdates[i]).getTime() - nineHours <= date.getTime() && new Date(enddates[i]).getTime() - nineHours >= date.getTime()) {
            		  console.log(date + "   cannnot select this date!!!!!!");
            		  flag = false;
            		  break;
            	  }
              }
              return [ flag ];
          }
        })
        .on( "change", function() {
          console.log("from change " + getDate( this ) );
          var fromdate = getDate( this );
          
          to.datepicker( "option", "minDate", getDate( this ) );
          to.datepicker("option","beforeShowDay", function(date){
        	  //date: 달력 날짜 한칸 -> ret[0] : true ->선택가능 ,false -> 선택불가
        	  //달력페이지가 바뀔때 마다 각 달력날짜에 대해 호출
              var flag = true;
              const nineHours = 32400000;
              console.log("from?? " + fromdate)
              
              if(cannot_select_after.getTime() < new Date('9999-12-31').getTime()) {
            	  if(date.getTime() >= cannot_select_after.getTime() - nineHours) {
            		  console.log(date + "   cannnot select after the date!!!!!!");
	            	  flag = false;
	              }
	              return [ flag ];
              }//memoization
              
              
              //최초 1회 실행 or startdates.length가 0이면 매번 실행됨
              for(var i = 0;i < startdates.length ;i++) {
            	  var startdate = new Date(startdates[i]).getTime() - nineHours;
            	  if( startdate >= fromdate.getTime() && startdate < cannot_select_after.getTime() - nineHours ) {
            		  cannot_select_after = new Date(startdates[i]);
            	  } 
            	  //foooooooooooo----------------------xxxxxxxxx-----------------xxxxxxxxxxxxxxxxxxx--------xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              }
              if(date.getTime() >= cannot_select_after.getTime() - nineHours) {
            	  console.log(date + "   cannnot select after the date!!!!!!");
            	  flag = false;
              }
              return [ flag ];
          });
          updateCost();
        });
        
      to = $( "#enddate" ).datepicker({
    	  dateFormat : "yy-mm-dd",
    	  minDate: 0,
          maxDate: "+3Y",
        defaultDate: "+1w",
        changeMonth: true,
        changeYear: true,
        //showOn: "both",
        //buttonImage: "/resources/img/calendar.png",
        //buttonImageOnly: true,
        //buttonText: "Select date",
        beforeShowDay: function(date){
        	  //date: 달력 날짜 한칸 -> ret[0] : true ->선택가능 ,false -> 선택불가
        	  //달력페이지가 바뀔때 마다 각 달력날짜에 대해 호출
              var flag = true;
              const nineHours = 32400000;
              for(var i = 0;i < startdates.length ;i++) {
            	  if(new Date(startdates[i]).getTime() - nineHours <= date.getTime() && new Date(enddates[i]).getTime() - nineHours >= date.getTime()) {
            		  console.log(date + "   cannnot select this date!!!!!!");
            		  flag = false;
            		  break;
            	  }
              }
              return [ flag ];
          }
      })
      .on( "change", function() {
    	  console.log("to change " + getDate( this ));
    	  var todate = getDate( this );
        from.datepicker( "option", "maxDate", getDate( this ) );
        from.datepicker("option","beforeShowDay", function(date){
        	  //date: 달력 날짜 한칸 -> ret[0] : true ->선택가능 ,false -> 선택불가
        	  //달력페이지가 바뀔때 마다 각 달력날짜에 대해 호출
              var flag = true;
              const nineHours = 32400000;
              console.log("to?? " + todate)
              
              if(cannot_select_before.getTime() > new Date('1970-01-01').getTime()) {
            	  if(date.getTime() <= cannot_select_before.getTime() - nineHours) {
            		  console.log(date + "   cannnot select before the date!!!!!!");
	            	  flag = false;
	              }
	              return [ flag ];
              }//memoization
              
              
              //최초 1회 실행 or startdates.length가 0이면 매번 실행됨
              for(var i = 0;i < enddates.length ;i++) {
            	  var enddate = new Date(enddates[i]).getTime() - nineHours;
            	  if( enddate <= todate.getTime() && enddate > cannot_select_before.getTime() - nineHours ) {
            		  cannot_select_before = new Date(enddates[i]);
            	  } 
            	  //xxxxxxxxxxxxxxx----------------------xxxxxxxxx-----------------xxxxxxxxxxxxxxxxxxx--------ooooooooooE
              }
              if(date.getTime() <= cannot_select_before.getTime() - nineHours) {
            	  console.log(date + "   cannnot select before the date!!!!!!");
            	  flag = false;
              }
              return [ flag ];
          });
        updateCost();
      });
    <c:if test="${U eq '01'}">
	    if(resetflg == false) {
	    	console.log("resetflg : " + resetflg);
		    from.datepicker( "setDate", new Date("${reserve.startdate}") );
			to.datepicker( "setDate", new Date("${reserve.enddate}") );
			from.trigger("change",[new Date("${reserve.startdate}")]);
			to.trigger("change",[new Date("${reserve.enddate}")]);
	    } else {
	    	console.log("resetflg : " + resetflg);
	    	from.datepicker( "setDate", "" );
			to.datepicker( "setDate", "" );
			updateCost();
	    }
	</c:if>	
 
    function getDate( element ) {
      var date;
      try {
        date = $.datepicker.parseDate( dateFormat, element.value );
      } catch( error ) {
        date = null;
      }
 
      return date;
    }
  });
}
resett(false);  
</script>
