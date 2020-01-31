%{
		/* simple lex program which removes comments from a source program
            The main key is that a variable "comment" is set when the start of a comment
            is seen and then unset when the ending set is seen.  It is possible to have
            two starts closed by on end.

            Shaun Cooper
            January 2015
 	
		 */

		 /*
		 	modified lab2remove.l
			
			
			Long Tran
			January 31, 2020

			Changes:
			+ Declare a new variable called lines to tell the line number we are on  
			+ set the debug variable to 1 to print out the error message
			+ have a new directive that matches newline and when matched increase the count variable and print the newline
			+ do comments on most lines of code
		 */

		// variable to check if we are in a comment
        int comment = 0;
		// set dubug variable to 1
        int debug=1;  /* prints out debug statements if desired */

		// declare variable lines here
		int lines = 0; // count the number of lines of the input

%}
%%
"/*"	{
	// if we are in a comment and we encounter another '/*'
	if (comment && debug) fprintf(stderr,
		" >>>>>>>> line %d: Possible Nested comment <<<<<<<<<<\n", lines);
	// set that we are in a comment
	comment = 1;
	}

"*/"	{
		// if not in a comment, print "*/" out 
          if (!comment) printf("%s",yytext); /*print out if it is not in a comment */
		// set that we are out of a comment
  	  comment = 0;
	}
	
.       { if (!comment) printf("%s",yytext);/*For every character except newline and if it is not in a comment print it out*/}

\n {lines++; if (!comment) printf("\n");/*make a lex directive to increase the line count whenever it encounters a new line and print the newline out when not in a comment*/}
%%


int yywrap(void)
{ return 1;
}// end yywrap

// put explicit return type for main function
int main()
{
  yylex();
  
}// end main

