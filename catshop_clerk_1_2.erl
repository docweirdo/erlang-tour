-module(catshop_clerk_1_2).
-import(rand, [uniform/1]).
-export([loop/0]).  %loop in export, make_cat raus


loop() ->   %neue funktion
    New_Cat = make_cat(),
    
    case New_Cat of
        {cat, _, black} -> io:fwrite("Die Katze ist schwarz!~n");
        {cat, _, white} -> io:fwrite("Die Katze ist weiß!~n");
        _ -> io:fwrite("Die Katze ist bunt!~n")
    end,

    loop().

%%% Private Funktionen
make_cat() ->
    Name = lists:nth(uniform(11), names()),
    Color = lists:nth(uniform(6), colors()),
    {cat, Name, Color}.

names() -> ["Karl", "Peter", "Kai-Uwe", "Uwe-Kai", "Nils", "Martha", "Elisabeth", "Jonas", "Gerda", "Katharina", "Franziska"].

colors() -> [black, blue, white, orange, pink, brown].
