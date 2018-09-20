window.onload = function () {
    var text_table_of_contents = document.getElementById('text-table-of-contents');
    var table_of_contents = document.getElementById('table-of-contents');

    table_of_contents.onmouseover = function () {
        text_table_of_contents.style.display = 'block';
    };

    table_of_contents.onmouseout = function () {
        text_table_of_contents.style.display = 'none';
    }
}
