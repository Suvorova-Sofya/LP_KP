parent("Alexey Suvorov","Sergey Suvorov","Valentina Tishenko").
parent("Andrey Suvorov","Sergey Suvorov","Valentina Tishenko").
parent("","Andrey Suvorov","").
parent("Yanina Kotilevskaya","Vladimir Kotelev","Nina Kotilevskaya").
parent("Sofya Suvorova","Alexey Suvorov","Yanina Kotilevskaya").
parent("Ksenia Suvorova","Alexey Suvorov","Yanina Kotilevskaya").
parent("Alexandr Suvorov","Alexey Suvorov","Yanina Kotilevskaya").
parent("","","Sofya Suvorova").
parent("","","Ksenia Suvorova").
parent("","Alexandr Suvorov","").

shyrin(X):-
	parent(_,_,X)->
		(parent(X,Y,Z),
		parent(X1,Y,Z),
		parent(_,X1,_)->
			write(X1)
		;false)
	;false.


brother(Z,X,X1):-
	(Z ?= "brother")->
	(parent(X,Y,Y1),
	parent(X1,Y,Y1),
	parent(_,X1,_),
	X1 \= X).

brother_1(Z,X,X1):-
	parent(X,Y,Y1),
	parent(X1,Y,Y1),
	parent(_,X1,_),
	X1 \= X,
	Z=["brother","child-mother","child-father"].



sister(Z,X,X1):-
	(Z ?= "sister")->
	(parent(X,Y,Y1),
	parent(X1,Y,Y1),
	parent(_,_,X1),
	X1 \= X).

sister_1(Z,X,X1):-
	parent(X,Y,Y1),
	parent(X1,Y,Y1),
	parent(_,_,X1),
	X1 \= X,
	Z=["sister","child-mother","child-father"].




mother(Z,X,X1):-
	(Z ?= "mother")->
	(parent(X,_,X1)).

mother_1(Z,X,X1):-
	parent(X,_,X1),
	Z=["mother","mother-simbling"].



father(Z,X,X1):-
	(Z ?= "father")->
	(parent(X,X1,_)).

father_1(Z,X,X1):-
	parent(X,X1,_),
	Z=["father","father-simbling"].




child(Z,X,X1):-
	(Z ?= "child")->(
	(parent(_,_,X))->
	(parent(X1,_,X));parent(X1,X,_)).

child_1(Z,X,X1):-
	(parent(_,_,X))->
	(parent(X1,_,X),(Z="child";Z="husband-child"));parent(X1,X,_),
	Z=["child","wife-child"].





grand_mother(Z,X,X1):-
	(Z ?= "grand_mother")->
	(parent(X,Y,Y1),(parent(Y,_,X1);parent(Y1,_,X1))).

grand_mother_1(Z,X,X1):-
	parent(X,Y,Y1),(parent(Y,_,X1);parent(Y1,_,X1)),
	Z=["grand_mother","mother-parent"].




grand_father(Z,X,X1):-
	(Z ?= "grand_father")->
	(parent(X,Y,Y1),(parent(Y,X1,_);parent(Y1,X1,_))).

grand_father_1(Z,X,X1):-
	parent(X,Y,Y1),(parent(Y,X1,_);parent(Y1,X1,_)),
	Z=["grand_father","father-parent"].




uncle(Z,X,X1):-
	(Z ?= "uncle")->
	(parent(X,Y,Y1),
	((parent(Y1,M,M1),parent(X1,M,M1),X1 \= Y1);
	(parent(Y,M,M1),parent(X1,M,M1),X1 \= Y))).

uncle_1(Z,X,X1):-
	(Z ?= "")->
	(parent(X,Y,Y1),
	((parent(Y1,M,M1),parent(X1,M,M1),X1 \= Y1);
	(parent(Y,M,M1),parent(X1,M,M1),X1 \= Y)),
	Z=["uncle","simbling-parent"]).




niece(Z,X,X1):-
	(Z ?= "niece")->
	(parent(X,Y,Y1),parent(M,Y,Y1),M \= X,
	((parent(X1,_,M));(parent(X1,M,_))),parent(_,_,X1)).

niece_1(Z,X,X1):-
	(parent(X,Y,Y1),parent(M,Y,Y1),M \= X,
	((parent(X1,_,M));(parent(X1,M,_))),parent(_,_,X1)),
	Z=["niece","simbling-daughter"].




nephew(Z,X,X1):-
	(Z ?= "nephew")->
	(parent(X,Y,Y1),parent(M,Y,Y1),M \= X,
	((parent(X1,_,M));(parent(X1,M,_))),parent(_,X1,_)).

nephew_1(Z,X,X1):-
	parent(X,Y,Y1),parent(M,Y,Y1),M \= X,
	((parent(X1,_,M));(parent(X1,M,_))),parent(_,X1,_),
	Z=["nephew","simbling-son"].




sister_in_law(Z,X,X1):-
	(Z ?= "sister_in_law")->
	(parent(X,Y,Y1),parent(M,Y,Y1),M \= X,parent(_,M,X1),!).

sister_in_law_1(Z,X,X1):-
	parent(X,Y,Y1),parent(M,Y,Y1),M \= X,parent(_,M,X1),!,
	Z=["sister_in_law","simbling-wife"].




brother_in_law(Z,X,X1):-
	(Z ?= "brother_in_law")->
	((parent(_,X,Y);(parent(_,Y,X))),parent(Y,M,M1),parent(X1,M,M1),
	X1 \= Y,parent(_,X1,_),!).

brother_in_law_1(Z,X,X1):-
	(parent(_,X,Y);(parent(_,Y,X))),parent(Y,M,M1),parent(X1,M,M1),
	X1 \= Y,parent(_,X1,_),!,Z=["brother_in_law","husband-simbling"].



mother_in_law(Z,X,X1):-
	(Z ?= "mother_in_law")->
	(((parent(_,X,Y),!);(parent(_,Y,X),!)),parent(Y,_,X1)).

mother_in_law_1(Z,X,X1):-
	((parent(_,X,Y),!);(parent(_,Y,X),!)),parent(Y,_,X1),
	Z=["mother_in_law","partner-mother"].




father_in_law(Z,X,X1):-
	(Z ?= "father_in_law")->
	(((parent(_,X,Y),!);(parent(_,Y,X),!)),parent(Y,X1,_)).

father_in_law_1(Z,X,X1):-
	((parent(_,X,Y),!);(parent(_,Y,X),!)),parent(Y,X1,_),
	Z=["father_in_law","partner-father"].




daughter_in_law(Z,X,X1):-
	(Z ?= "daughter_in_law")->
	(((parent(Y,X,_));(parent(Y,_,X))),parent(_,Y,X1),!).

daughter_in_law_1(Z,X,X1):-
	((parent(Y,X,_));(parent(Y,_,X))),parent(_,Y,X1),!,
	Z=["daughter_in_law","child-wife"].




son_in_law(Z,X,X1):-
	(Z ?= "son_in_law")->
	(((parent(Y,X,_));(parent(Y,_,X))),parent(_,X1,Y),!).

son_in_law_1(Z,X,X1):-
	((parent(Y,X,_));(parent(Y,_,X))),parent(_,X1,Y),!,
	Z=["son_in_law","child-husband"].




father_of_sister_in_law(Z,X,X1):-
	(Z ?= "father_of_sister_in_law")->
	(parent(X,Y,Y1),parent(M,Y,Y1),M \= X,parent(_,M,M1),
	parent(M1,X1,_),!).

father_of_sister_in_law_1(Z,X,X1):-
	parent(X,Y,Y1),parent(M,Y,Y1),M \= X,parent(_,M,M1),
	parent(M1,X1,_),Z="father_of_sister_in_law",!.




mother_of_sister_in_law(Z,X,X1):-
	(Z ?= "mother_of_sister_in_law")->
	(parent(X,Y,Y1),parent(M,Y,Y1),M \= X,parent(_,M,M1),
	parent(M1,_,X1),!).

mother_of_sister_in_law_1(Z,X,X1):-
	parent(X,Y,Y1),parent(M,Y,Y1),M \= X,parent(_,M,M1),
	parent(M1,_,X1),Z="mother_of_sister_in_law",!.


wife(Z,X,X1):-
	(Z ?= "wife")->
	(parent(_,X,X1),!).

wife_1(Z,X,X1):-
	parent(_,X,X1),!,
	Z=["wife","child-mother"].



husband(Z,X,X1):-
	(Z ?= "husband")->
	(parent(_,X1,X),!).

husband_1(Z,X,X1):-
	parent(_,X1,X),!,
	Z=["husband","child-father"].


matchmaker(Z,X,X1):-
	(Z ?= "matchmaker")->
	(((parent(Y,X,_));(parent(Y,_,X))),
	((parent(_,Y,Y1));(parent(_,Y1,Y))),!,
	((parent(Y1,X1,_));(parent(Y1,_,X1)))).

matchmaker_1(Z,X,X1):-
	((parent(Y,X,_));(parent(Y,_,X))),
	((parent(_,Y,Y1));(parent(_,Y1,Y))),
	((parent(Y1,X1,_));(parent(Y1,_,X1))),
	Z=["matchmaker","child-partner_parent"].


get_one([],_).
get_one([H|[]],H):-!.
get_one([H|T],X):-
(X=H;get_one(T,X)).


relative(X,Y,Z):-
	(X ?= "")->(
		brother_1(X,Y,Z);sister_1(X,Y,Z);mother_1(X,Y,Z);
		father_1(X,Y,Z);child_1(X,Y,Z);wife_1(X,Y,Z);
		husband_1(X,Y,Z);grand_mother_1(X,Y,Z);grand_father_1(X,Y,Z);
		uncle_1(X,Y,Z);niece_1(X,Y,Z);nephew_1(X,Y,Z);
		sister_in_law_1(X,Y,Z);brother_in_law_1(X,Y,Z);mother_in_law_1(X,Y,Z);
		father_in_law_1(X,Y,Z);daughter_in_law_1(X,Y,Z);
		son_in_law_1(X,Y,Z);father_of_sister_in_law_1(X,Y,Z);
		mother_of_sister_in_law_1(X,Y,Z);matchmaker_1(X,Y,Z)),!,get_one(X,X1),write(X1);
	((Z ?= "")->
		(brother(X,Y,Z),sister(X,Y,Z),mother(X,Y,Z),
		father(X,Y,Z),child(X,Y,Z),wife(X,Y,Z),
		husband(X,Y,Z),grand_mother(X,Y,Z),grand_father(X,Y,Z),
		uncle(X,Y,Z),niece(X,Y,Z),nephew(X,Y,Z),
		sister_in_law(X,Y,Z),brother_in_law(X,Y,Z),mother_in_law(X,Y,Z),
		father_in_law(X,Y,Z),daughter_in_law(X,Y,Z),
		son_in_law(X,Y,Z),father_of_sister_in_law(X,Y,Z),
		mother_of_sister_in_law(X,Y,Z),matchmaker(X,Y,Z),write(Z));
		(brother(X,Z,Y),sister(X,Z,Y),mother(X,Z,Y),
		father(X,Z,Y),child(X,Z,Y),wife(X,Z,Y),
		husband(X,Z,Y),grand_mother(X,Z,Y),grand_father(X,Z,Y),
		uncle(X,Z,Y),niece(X,Z,Y),nephew(X,Z,Y),
		sister_in_law(X,Z,Y),brother_in_law(X,Z,Y),mother_in_law(X,Z,Y),
		father_in_law(X,Z,Y),daughter_in_law(X,Z,Y),
		son_in_law(X,Z,Y),father_of_sister_in_law(X,Z,Y),
		mother_of_sister_in_law(X,Z,Y),matchmaker(X,Z,Y),write(Y)))
.



?-relative("brother",Z,"Alexey Suvorov"),nl.


