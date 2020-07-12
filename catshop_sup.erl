-module(catshop_sup).
-behaviour(supervisor).

-export([open_shop/0, init/1]).

open_shop() ->
    supervisor:start_link(?MODULE, []).

init([]) ->
    {ok, {{one_for_all, 1, 60},
        [
            #{id=>one, start=>{catshop_clerk_2_3, start_shift, [pink]}},
            #{id=>two, start=>{catshop_clerk_2_3, start_shift, [black]}},
            #{id=>three, start=>{catshop_clerk_2_3, start_shift, [brown]}}
        
        ]}}.