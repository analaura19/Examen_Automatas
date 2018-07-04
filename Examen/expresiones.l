%{
#include <iostream>
#include "gramaticas.tab.h"
using namespace std;
#define YY_DECL extern "C" int yylex()
#define guardar std::string(yytext, yylen)
extern void printError(std::string, char);

%}
%option yylineno
%option noyywrap

%%
(\s)+|(\t)+|(\n)+|(\R)+ {
		/*Whitespaces ignored*/;
	}
(\/\*)((.|\s|\n)*)?(\*\/) {
 		/*Block comments ignored*/;
 	}
(\/\/)((.|\n\r)*)? {
 		/*In-line comments ignored*/;
 	}
para	{
		yylval.hilera = new std::string(yytext,yyleng);
 		return FOR;
 	}
==|<=|>=|>|<	{
		yylval.hilera = new std::string(yytext,yyleng);
 		return COMPARACION;
 	}
ini {
		yylval.hilera = new std::string(yytext,yyleng);
 		return INI;
 	}
fin {
		yylval.hilera = new std::string(yytext,yyleng);
 		return FIN;
 	}
ret {
		yylval.hilera = new std::string(yytext,yyleng);
 		return RET;
 	}
print 	{
		yylval.hilera = new std::string(yytext,yyleng);
 		return PRINT;
 	}
\( {
		yylval.hilera = new std::string(yytext,yyleng);
 		return PARI;
 	}
\) {
		yylval.hilera = new std::string(yytext,yyleng);
 		return PARD;
 	}
\[ {
		yylval.hilera = new std::string(yytext,yyleng);
 		return CORI;
 	}
\] {
		yylval.hilera = new std::string(yytext,yyleng);
 		return CORD;
 	}
\= {
		yylval.hilera = new std::string(yytext,yyleng);
 		return IGUAL;
 	}
\;	{
		yylval.hilera = new std::string(yytext,yyleng);
		return PYC;
	}
\: {
		yylval.hilera = new std::string(yytext,yyleng);
		return DOSP;
 	}
,	{
		yylval.hilera = new std::string(yytext,yyleng);
		return COM;
	}
[a-zñ][a-zA-Z0-9_ñ]*	{
		yylval.hilera = new std::string(yytext,yyleng);
 		return ID;
 	}
[0-9]+ {
		yylval.intVal = atoi(yytext);
 		return NUM;
 	}
[\+] {
		yylval.hilera = new std::string(yytext,yyleng);
 		return MAS;
 	}
[\-] {
		yylval.hilera = new std::string(yytext,yyleng);
 		return MENOS;
 	}
[A-Z_Ñ0-9][a-zA-Z0-9_ñ]*|[0-9]+(\.|\,)[0-9]+|[a-zA-Z0-9_ñ\@\#\$\%\&\?\¿\¡\!]+	{
		printError("Error lexico", 'a');
 		return ERROR;
 	}
%%
