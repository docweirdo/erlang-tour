-module(catshop_clerk_2_1).

-import(rand, [uniform/1]).
-export([start_shift/0, order_cat/1, return_cat/2, end_shift/1, loop/1]).  

-record(cat, {name, color}).

%%% Client API
start_shift() -> spawn_link(?MODULE, loop, [[]]).

order_cat(ClerkPID) ->
    
    Ref = erlang:monitor(process, ClerkPID),
    ClerkPID ! {self(), order},
    
    receive
        Cat when is_record(Cat, cat) -> 
            erlang:demonitor(Ref),
            Cat;

        {'DOWN', Ref, process, ClerkPID, Reason} ->
            erlang:error(Reason)

    after 5000 ->
        erlang:demonitor(Ref),
        erlang:error(timeout)
    end.


end_shift(ClerkPID) ->
    Ref = erlang:monitor(process, ClerkPID),
    ClerkPID ! {self(), terminate},

    receive
        ok -> 
            erlang:demonitor(Ref),
            ok;
        {'DOWN', Ref, process, ClerkPID, Reason} ->
            erlang:error(Reason)
    
    after 5000 ->
        erlang:demonitor(Ref),
        erlang:error(timeout)
    end.


return_cat(ClerkPID, Cat) ->
    ClerkPID ! {return, Cat},
    ok.

%%% Server Funktionen
loop(Catlist) ->
    
    receive

        {ClientPID, order} ->
            if  
                Catlist =:= [] ->
                    ClientPID ! make_cat(),
                    loop(Catlist);
                
                Catlist =/= [] ->
                    ClientPID ! hd(Catlist),
                    loop(tl(Catlist))
            end;

        {ClientPID, terminate} ->
            ClientPID ! ok;
                
        {return, Cat} when is_record(Cat, cat) ->
            loop([Cat | Catlist])


    end.



%%% Private Funktionen
make_cat() ->
    Name = lists:nth(uniform(11), names()),
    Color = lists:nth(uniform(6), colors()),
    #cat{name=Name, color=Color}.

names() -> ["Karl", "Peter", "Kai-Uwe", "Uwe-Kai", "Nils", "Martha", "Elisabeth", "Jonas", "Gerda", "Katharina", "Franziska"].

colors() -> [black, blue, white, orange, pink, brown].
