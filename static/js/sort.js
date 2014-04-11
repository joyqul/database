$(document).ready(function() {
  $("#flight").tablesorter({ 
    sortList: [[0,0], [1,0]],
    0: { sorter: "digit" },
    1: { sorter: "text" },
    2: { sorter: "text" },
    3: { sorter: "text" },
    4: { sorter: "text" },
    5: { sorter: "text" },
    6: { sorter: "digit" },
    7: { sorter: "false" },
    8: { sorter: "false" },
  }); 
});
