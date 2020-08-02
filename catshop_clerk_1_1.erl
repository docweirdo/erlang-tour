-module(catshop_clerk_1_1).
-import(rand, [uniform/1]).
-export([make_cat/0]).



make_cat() ->
    Name = lists:nth(uniform(11), names()),
    % hier erklären, dass Variablen nur 1x zugewiesen werden können
    Color = lists:nth(uniform(6), colors()),
    {cat, Name, Color}.


%%% Private Funktionen
names() -> ["Karl", "Peter", "Kai-Uwe", "Uwe-Kai", "Nils", "Martha", "Elisabeth", "Jonas", "Gerda", "Katharina", "Franziska"].

colors() -> [black, blue, white, orange, pink, brown].
