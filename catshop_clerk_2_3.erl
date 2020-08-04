-module(catshop_clerk_2_3).
-behaviour(gen_server).         

-import(rand, [uniform/1]).
-export([start_shift/1, order_cat/1, return_cat/2, end_shift/1, handle_call/3, handle_cast/2, init/1]).


%%% Client API
start_shift(ForbiddenColor) -> 
    gen_server:start_link(?MODULE, ForbiddenColor, []).

order_cat(ClerkPID) ->
    gen_server:call(ClerkPID, {order}).

end_shift(ClerkPID) ->
    gen_server:call(ClerkPID, {terminate}).

return_cat(ClerkPID, Cat) ->
    gen_server:cast(ClerkPID, {return, Cat}).

%%% Server Funktionen
init(ForbiddenColor) -> {ok, {state, ForbiddenColor, []}}.

handle_call({order}, _From, {state, ForbiddenColor, Catlist}) ->

    if  
        Catlist == [] ->
            {reply, make_cat(), {state, ForbiddenColor, Catlist}};
        
        Catlist =/= [] ->
            Cat = hd(Catlist),
            TailCatlist = tl(Catlist),
            {reply, {state, ForbiddenColor, TailCatlist}, Cat}
    end;

handle_call({terminate}, _From, State) ->
    {stop, normal, ok, State}.

handle_cast({return, {cat, Name, Color}}, {state, ForbiddenColor, Catlist}) ->
    if 
        Color =:= ForbiddenColor ->
            {stop, bad_color, {state, ForbiddenColor, Catlist}};

        true -> {noreply, {state, ForbiddenColor, [{cat, Name, Color} | Catlist]}}
    end.

%%% Private Funktionen
make_cat() ->
    Name = lists:nth(uniform(11), names()),
    Color = lists:nth(uniform(6), colors()),
    {cat, Name, Color}.

names() -> ["Karl", "Peter", "Kai-Uwe", "Uwe-Kai", "Nils", "Martha", "Elisabeth", "Jonas", "Gerda", "Katharina", "Franziska"].

colors() -> [black, blue, white, orange, pink, brown].
