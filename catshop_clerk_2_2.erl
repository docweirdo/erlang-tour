-module(catshop_clerk_2_2).     %modulname angepasst
-behaviour(gen_server).         %Behaviour eingefügt

-import(rand, [uniform/1]).
-export([start_shift/0, order_cat/1, return_cat/2, end_shift/1, handle_call/3, handle_cast/2, init/1]).  %Api and Behaviour function in export

-record(cat, {name, color}).

%%% Client API

start_shift() -> 
    {ok, ClerkPID} = gen_server:start_link(?MODULE, [], []),
    ClerkPID.

order_cat(ClerkPID) ->
    gen_server:call(ClerkPID, {order}).

return_cat(ClerkPID, Cat) ->
    gen_server:cast(ClerkPID, {return, Cat}).

end_shift(ClerkPID) ->
    gen_server:call(ClerkPID, {terminate}).

%%% Server Funktionen
init([]) -> {ok, []}.

handle_call({order}, _From, State) ->
    if  
        State =:= [] ->
            {reply, make_cat(), State};
        
        State =/= [] ->
            {reply, hd(State), tl(State)}
    end;

handle_call({terminate}, _From, State) ->
    {stop, normal, ok, State}.

handle_cast({return, Cat}, State) when is_record(Cat, cat) ->
    {noreply, [Cat | State]}.


%%% Private Funktionen
make_cat() ->
    Name = lists:nth(uniform(11), names()),
    Color = lists:nth(uniform(6), colors()),
    #cat{name=Name, color=Color}.

names() -> ["Karl", "Peter", "Kai-Uwe", "Uwe-Kai", "Nils", "Martha", "Elisabeth", "Jonas", "Gerda", "Katharina", "Franziska"].

colors() -> [black, blue, white, orange, pink, brown].
