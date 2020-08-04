-module(catshop_sup).
-behaviour(supervisor).

-export([open_shop/0, init/1]).

open_shop() ->
    supervisor:start_link(?MODULE, []).

init([]) ->
    {ok, {{one_for_all, 1, 60},
        [
            {one, {catshop_clerk_2_3, start_shift, [pink]}, permanent, 5000, worker, [start_shift]},
            {two, {catshop_clerk_2_3, start_shift, [black]}, permanent, 5000, worker, [start_shift]},
            {three, {catshop_clerk_2_3, start_shift, [brown]}, permanent, 5000, worker, [start_shift]}
        
        ]}}.