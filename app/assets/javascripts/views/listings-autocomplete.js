var courses_data = {};

$(document).ready(function()
	{
	var Autocomplete = (function()
		{
		function ShowBookTag(book)
			{
			}
		
		function ShowSectionBooks(books)
			{
			function CleanTitle(title)
				{
				var replacements = {
					'([A-Z])([A-Z]*)': function(str, m1, m2)
						{
						return m1 + m2.toLowerCase();
						},
					'(.)-(.)': function(str, m1, m2)
						{
						return m1 + ' - ' + m2;
						},
					'W/(.)': function(str, m1)
						{
						return 'with '+m1;
						},
					'([A-Za-z])\\.([A-Za-z])': function(str, m1, m2)
						{
						return m1+'. '+m2;
						}
					};

				$.each(replacements, function(regex, func)
					{
					title = title.replace((new RegExp(regex, 'g')), func);
					});
				return title;
				}
			
				
			var list = $('<div />');
			$.each(books, function(index, book)
				{
				var obj = $(['<li>', 
					'<p class="title">', CleanTitle(book.title), '</p>',
					'<p class="isbn">', 'ISBN: ', book.isbn, '</p>',
					'<p class="price-new">', book['new'], ' new at B&amp;N', '</p>',
				'</li>'].join('')).data('book', book).appendTo(list);
				});
			$('#matched-books').html(list.unwrap());
			}
			
		function ShowDropdown()
			{
			var list = $('<div />');
				$.each(matched_books, function(section, books)
					{
					$(['<li>',
						'<span class="class-section">', section, '</span>',
						'<span class="num-books">(', books.length, ' book', (books.length == 1 ? '' : 's'), ')</span>',
					'</li>'].join('')).data('books', books).appendTo(list);
					});
				$('#matched-books').html(list.unwrap());
					
			if ($('#matched-books').is(':visible'))
				return;
			$('#isbn').addClass('autocomplete');
			$('#matched-books').slideDown(200);
			$(document).delegate('body', 'mousedown', function(event)
				{
				$(document).undelegate('body', 'mousedown');
				if ($(event.target).closest('#matched-books').length == 0)
					HideDropdown();
				else
					{
					ShowSectionBooks($(event.target).closest('li').data('books'));
					$(document).delegate('body', 'mousedown', function(event)
						{
						match = false;
						$(document).undelegate('body', 'mousedown');
						console.log($(event.target).closest('li').data('book'));
						if ($(event.target).closest('#matched-books').length !== 0)
							$('#isbn').val(($(event.target).closest('li').data('book').isbn));
						HideDropdown();
						});
					}
				});
			}
		
		function HideDropdown()
			{
			$('#matched-books').slideUp(200);
			$('#isbn').removeClass('autocomplete');
			}
		
		var book_list_stack = [books.gatech],
			last_entry = '',
			match = false;
		
		$(document).delegate('#isbn', 'focus', function() {
			if (($('#isbn').val().length > 0) && match)
				ShowDropdown();
			});				
		
		
		return function(event)
			{
			function Update(val)
				{
				if (val)
					var str_part = val;
				else
					var str_part = self.val().toLowerCase().replace(/[^0-9a-z]/g, '');
				matched_books = {};
					
				if (str_part != last_entry)
					{
					if (last_entry.slice(0, -1) == str_part)
						{
						book_list_stack.pop();
						matched_books = book_list_stack[book_list_stack.length-1];
						last_entry = str_part;
						}
					else if (str_part.slice(0, -1) == last_entry)
						{
						var book_list = book_list_stack[book_list_stack.length-1];
						$.each(book_list, function(section, books)
							{
							$.each(books, function(index, book)
								{
								if (book.match.toLowerCase().indexOf(str_part) === 0)
									{
									if (matched_books[section])
										matched_books[section].push(book);
									else
										matched_books[section] = [book];
									}
								});
							});
						book_list_stack.push(matched_books);
						last_entry = str_part;
						}
					else
						{
						for (var a = 0, val = self.val(); a < val.length; a++)
							{
							book_list_stack = [books.gatech];
							last_entry = '';
							Update(val.slice(0, a));
							}
						}
					}
				else
					matched_books = book_list_stack[book_list_stack.length-1];
				
				var length = 0;
				for (key in matched_books)
					{
					if (matched_books.hasOwnProperty(key))
						length++;
					}
				
				match = true;
				if (length == 0)
					{
					HideDropdown();
					match = false;
					}
				else if (length == 1)
					{
					$.each(matched_books, function(section, books)
						{
						ShowSectionBooks(books);
						});
					}
				
				if (length > 0)
					ShowDropdown();
				}
			
			if (event.type == 'change')
				return false;
				
			var self = $(this);
			if (event && event.type == 'keydown')
				window.setTimeout(function() {Update();}, 0);
			else
				Update();
			}
		})();
	
	$(document).delegate('#buy-isbn', 'keydown', Autocomplete);
	$(document).delegate('#buy-isbn', 'change', Autocomplete)
	
	});