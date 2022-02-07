<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
<link href='/resources/lib/fullcalendar-5.10.1/lib/main.css' rel='stylesheet' />
<script src='/resources/lib/fullcalendar-5.10.1/lib/main.js'></script>
<style>
  #calendar {
    max-width: 1100px;
    margin: 0 auto;
  }
  a {
  	color : black;
  	text-decoration: none;
  }
  .fc-day-sat {
  	background-color: rgba(0, 255, 255, 0.1);
  }
  .fc-day-sun {
  	background-color: rgba(255, 0, 0, 0.1);
  }
  thead {
  	border-bottom: thick double gray;
  }
  table {
  	overflow: hidden;
  }

</style>
<script>
	var adminURL = '${admin eq 'admin' ? '/admin' : ''}';
	function setTextColor(color) {
		console.log('color :' +  color);
		var red  = parseInt(color.substr(1,2),16);
		console.log('red :' +  red);
		var green = parseInt(color.substr(3,2),16);
		console.log('green :' +  green);
		var blue = parseInt(color.substr(5,2),16);
		console.log('blue :' +  blue);
		console.log('textcolor :' +  (red*0.299 + green*0.587 + blue*0.114));
		var ret = (red*0.299 + green*0.587 + blue*0.114) > 140 ? '#000000' : '#ffffff'
		return ret;
	};

  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
	var date = new Date(${empty reserveList ? '' : '\''.concat(reserveList[0].startdate).concat('\'')});
    var calendar = new FullCalendar.Calendar(calendarEl, {
		locale:'ja',
		initialDate: new Date(date.getFullYear(), date.getMonth(), 1),// the first day of current month
		validRange: function(currentDate) {
		    // Generate a new date for manipulating in the next step
		    var startDate = new Date(date.getFullYear(), date.getMonth(), 1); // the first day of current month
		    var endDate = new Date(currentDate.getFullYear() + 3, currentDate.getMonth() + 1, 1); // after 3 years from startDate
		
		    return { start: startDate, end: endDate };
		  },
		editable: false,
		selectable: true,
		businessHours: false,
		dayMaxEventRows: true,
		views: {
		    dayGrid: {
		      dayMaxEventRows: 5 // adjust to 6 only for timeGridWeek/timeGridDay
		    }
		  },
		headerToolbar: {
		    left: 'title',
		    center: '',
		    right: 'prevYear,prev,today,next,nextYear'
		  },		  
		  
		events: [
		<c:forEach var="reserve" items="${reserveList}">
		  {
		    title: '${reserve.roominfo.roomtitle}-${reserve.name}',
		    backgroundColor: '${reserve.roominfo.colorcd}',
		    textColor: setTextColor('${reserve.roominfo.colorcd}'),
		    url: adminURL + '/reserve/modify?no=${reserve.no}&name=${reserve.name}&phone=${reserve.phone}',
		    start: '${reserve.startdate}',
		    end: '${reserve.enddate}T23:59:59'
		  },
		  </c:forEach>
		],
		displayEventTime : false,
		eventDisplay : 'block'
	});
	console.log(calendar);
	calendar.render();
	
});
</script>