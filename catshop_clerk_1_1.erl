-module(catshop_clerk_1_1).
% hier erklären, dass 2 wege gibt; lists und rand import
-import(rand, [uniform/1]).
-export([make_cat/0]).

-record(cat, {name, color}).


make_cat() ->
    Name = lists:nth(uniform(11), names()),
    Color = lists:nth(uniform(6), colors()),
    #cat{name=Name, color=Color}.


%%% Private Funktionen
names() -> ["Karl", "Peter", "Kai-Uwe", "Uwe-Kai", "Nils", "Martha", "Elisabeth", "Jonas", "Gerda", "Katharina", "Franziska"].

colors() -> [black, blue, white, orange, pink, brown].
