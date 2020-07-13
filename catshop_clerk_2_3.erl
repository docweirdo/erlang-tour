-module(catshop_clerk_2_3).     %modulname angepasst
-behaviour(gen_server).         

-import(rand, [uniform/1]).
-export([start_shift/1, order_cat/1, return_cat/2, end_shift/1, handle_call/3, handle_cast/2, init/1]).  %Api and Behaviour function in export

-record(cat, {name, color}).
-record(state, {forbiddenColor, catlist}).

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
init(ForbiddenColor) -> {ok, #state{forbiddenColor = ForbiddenColor, catlist=[]}}.

handle_call({order}, _From, State) ->

    if  
        State#state.catlist =:= [] ->
            {reply, make_cat(), State};
        
        State#state.catlist =/= [] ->
            Cat = hd(State#state.catlist),
            Catlist = tl(State#state.catlist),
            {reply, State#state{catlist = Catlist}, Cat}
    end;

handle_call({terminate}, _From, State) ->
    {stop, normal, ok, State}.

handle_cast({return, Cat}, State) when is_record(Cat, cat) ->
    if 
        Cat#cat.color =:= State#state.forbiddenColor ->
            {stop, bad_color, State};

        true -> {noreply, State#state{catlist=[Cat | State#state.catlist]}}
    end.

%%% Private Funktionen
make_cat() ->
    Name = lists:nth(uniform(11), names()),
    Color = lists:nth(uniform(6), colors()),
    #cat{name=Name, color=Color}.

names() -> ["Karl", "Peter", "Kai-Uwe", "Uwe-Kai", "Nils", "Martha", "Elisabeth", "Jonas", "Gerda", "Katharina", "Franziska"].

colors() -> [black, blue, white, orange, pink, brown].
