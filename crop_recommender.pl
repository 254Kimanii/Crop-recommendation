% crop_recommender.pl
% Prolog expert system for crop recommendation and yield estimation.

% Valid input categories
soil_type(clay).
soil_type(loam).
soil_type(sandy).

season(long_rains).
season(short_rains).
season(wet_season).
season(dry_season).
season(cool_season).

fertilizer_type(organic).
fertilizer_type(npk).
fertilizer_type(compost).
fertilizer_type(none).

% Rule-based crop recommendations
recommend_crop(Soil, Rain, Temp, Season, Fertilizer, maize, Reason) :-
    member(Soil, [loam, clay]),
    Rain > 700,
    Temp >= 18,
    Temp =< 30,
    Season = long_rains,
    member(Fertilizer, [organic, npk, compost]),
    Reason = 'Maize is suited to loam or clay soil with rainfall above 700mm and warm temperatures in the long rains season.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, rice, Reason) :-
    member(Soil, [clay, loam]),
    Rain >= 1000,
    Temp >= 20,
    Temp =< 30,
    Season = wet_season,
    Fertilizer = organic,
    Reason = 'Rice is suited to clay or loam soils with very high rainfall and wet season conditions.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, wheat, Reason) :-
    member(Soil, [loam, clay]),
    Rain >= 300,
    Rain =< 800,
    Temp >= 10,
    Temp =< 24,
    member(Season, [cool_season, short_rains]),
    Fertilizer = npk,
    Reason = 'Wheat is suited to moderate rainfall, cool season temperatures, and NPK fertilizer.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, sorghum, Reason) :-
    member(Soil, [sandy, loam]),
    Rain >= 250,
    Rain =< 700,
    Temp >= 20,
    Temp =< 35,
    Season = dry_season,
    member(Fertilizer, [organic, compost, npk]),
    Reason = 'Sorghum tolerates sandy or loam soils and dry season conditions with moderate rainfall.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, sunflower, Reason) :-
    member(Soil, [sandy, loam]),
    Rain >= 300,
    Rain =< 700,
    Temp >= 20,
    Temp =< 32,
    Season = dry_season,
    Fertilizer = npk,
    Reason = 'Sunflower fits sandy or loam soils with moderate rainfall and dry season temperatures.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, beans, Reason) :-
    member(Soil, [loam, sandy]),
    Rain >= 400,
    Rain =< 900,
    Temp >= 16,
    Temp =< 28,
    Season = short_rains,
    Fertilizer = compost,
    Reason = 'Beans are suited to loam or sandy soil with moderate rainfall and short rains season.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, cassava, Reason) :-
    member(Soil, [clay, loam]),
    Rain >= 800,
    Rain =< 1500,
    Temp >= 22,
    Temp =< 32,
    Season = wet_season,
    Fertilizer = organic,
    Reason = 'Cassava performs well in clay or loam soils with high rainfall and wet season conditions.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, potato, Reason) :-
    Soil = loam,
    Rain >= 500,
    Rain =< 900,
    Temp >= 15,
    Temp =< 22,
    Season = cool_season,
    member(Fertilizer, [organic, npk]),
    Reason = 'Potato is suited to loam soil, moderate rainfall, and cool season temperatures.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, barley, Reason) :-
    member(Soil, [loam, clay]),
    Rain >= 300,
    Rain =< 600,
    Temp >= 10,
    Temp =< 22,
    Season = cool_season,
    Fertilizer = npk,
    Reason = 'Barley suits light rainfall and cool season conditions on loam or clay soils.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, millet, Reason) :-
    member(Soil, [sandy, loam]),
    Rain >= 200,
    Rain =< 500,
    Temp >= 25,
    Temp =< 35,
    Season = dry_season,
    Fertilizer = compost,
    Reason = 'Millet tolerates low rainfall and hot dry season conditions on sandy or loam soils.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, groundnut, Reason) :-
    member(Soil, [sandy, loam]),
    Rain >= 450,
    Rain =< 850,
    Temp >= 22,
    Temp =< 30,
    Season = short_rains,
    Fertilizer = organic,
    Reason = 'Groundnut is suited to sandy or loam soils with moderate rainfall and short rains.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, cotton, Reason) :-
    Soil = sandy,
    Rain >= 400,
    Rain =< 800,
    Temp >= 22,
    Temp =< 33,
    Season = dry_season,
    Fertilizer = npk,
    Reason = 'Cotton thrives in sandy soil with warm dry season conditions and NPK fertilizer.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, tomato, Reason) :-
    Soil = loam,
    Rain >= 500,
    Rain =< 800,
    Temp >= 18,
    Temp =< 25,
    Season = cool_season,
    Fertilizer = compost,
    Reason = 'Tomato prefers loam soil with moderate rainfall and mild cool season temperatures.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, pepper, Reason) :-
    Soil = loam,
    Rain >= 400,
    Rain =< 750,
    Temp >= 20,
    Temp =< 30,
    Season = short_rains,
    Fertilizer = compost,
    Reason = 'Pepper favors loam soil with moderate rainfall and warm short rains conditions.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, soybeans, Reason) :-
    Soil = loam,
    Rain >= 500,
    Rain =< 900,
    Temp >= 18,
    Temp =< 30,
    member(Season, [long_rains, short_rains]),
    Fertilizer = npk,
    Reason = 'Soybeans do well in loam soil with moderate rainfall and NPK fertilizer during rains.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, onions, Reason) :-
    Soil = loam,
    Rain >= 300,
    Rain =< 700,
    Temp >= 15,
    Temp =< 24,
    Season = cool_season,
    Fertilizer = compost,
    Reason = 'Onions prefer loam soil with moderate rainfall and cool season conditions.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, cassava, Reason) :-
    Soil = loam,
    Rain >= 900,
    Rain =< 1300,
    Temp >= 22,
    Temp =< 32,
    Season = wet_season,
    Fertilizer = organic,
    Reason = 'Cassava also thrives in loam soil under high rainfall and wet season conditions.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, maize, Reason) :-
    Soil = clay,
    Rain >= 750,
    Rain =< 1100,
    Temp >= 18,
    Temp =< 28,
    Season = long_rains,
    Fertilizer = npk,
    Reason = 'Maize also fits clay soils with strong long rains and NPK fertilizer.'.

recommend_crop(Soil, Rain, Temp, Season, Fertilizer, wheat, Reason) :-
    Soil = clay,
    Rain >= 350,
    Rain =< 650,
    Temp >= 10,
    Temp =< 22,
    Season = cool_season,
    Fertilizer = npk,
    Reason = 'Wheat can also grow on clay soils with moderate rainfall and cool season temperatures.'.

% Yield prediction rules
expected_yield(_, Rain, Temp, Fertilizer, Crop, high, Reason) :-
    member(Crop, [maize, rice, cassava]),
    Rain >= 800,
    Temp >= 18,
    Temp =< 30,
    Fertilizer \= none,
    Reason = 'High yield expected when rainfall is strong, temperature is favorable, and fertilizer is applied.'.

expected_yield(_, Rain, Temp, Fertilizer, Crop, medium, Reason) :-
    member(Crop, [wheat, sorghum, sunflower, beans, potato, groundnut, cotton, tomato, soybeans, onions]),
    Rain >= 500,
    Rain =< 900,
    Temp >= 16,
    Temp =< 30,
    member(Fertilizer, [organic, npk, compost]),
    Reason = 'Medium yield is expected under moderate rainfall, favorable temperature, and fertilizer use.'.

expected_yield(_, Rain, Temp, Fertilizer, millet, medium, Reason) :-
    Rain >= 200,
    Rain =< 500,
    Temp >= 25,
    Temp =< 35,
    member(Fertilizer, [organic, compost, npk]),
    Reason = 'Millet achieves medium yield in hot, dry conditions with adequate soil and fertilizer.'.

expected_yield(_, Rain, Temp, Fertilizer, _, low, Reason) :-
    (Rain < 500 ; Temp < 16 ; Temp > 32 ; Fertilizer = none),
    Reason = 'Low yield is likely when rainfall, temperature, or fertilizer conditions are suboptimal.'.

% Main recommendation predicate
recommend(Soil, Rain, Temp, Season, Fertilizer, Crop, YieldCategory, Explanation) :-
    valid_inputs(Soil, Rain, Temp, Season, Fertilizer),
    recommend_crop(Soil, Rain, Temp, Season, Fertilizer, Crop, CropReason),
    expected_yield(Soil, Rain, Temp, Fertilizer, Crop, YieldCategory, YieldReason),
    format(atom(Explanation), '~w Recommended because ~w ~w', [Crop, CropReason, YieldReason]).

% Input validation
valid_inputs(Soil, Rain, Temp, Season, Fertilizer) :-
    soil_type(Soil),
    number(Rain),
    number(Temp),
    Rain >= 0,
    Temp >= -10,
    season(Season),
    fertilizer_type(Fertilizer).

% Interactive CLI entry point
start :-
    nl, write('Crop Recommender Expert System'), nl,
    write('Enter soil type (clay, loam, sandy): '), read(Soil),
    write('Enter rainfall in mm: '), read(Rain),
    write('Enter temperature in Celsius: '), read(Temp),
    write('Enter crop season (long_rains, short_rains, wet_season, dry_season, cool_season): '), read(Season),
    write('Enter fertilizer type (organic, npk, compost, none): '), read(Fertilizer), nl,
    ( recommend(Soil, Rain, Temp, Season, Fertilizer, Crop, YieldCategory, Explanation)
    -> format('Recommendation: ~w~n', [Crop]),
       format('Expected yield category: ~w~n', [YieldCategory]),
       format('Explanation: ~w~n', [Explanation])
    ; write('No suitable crop recommendation could be determined from the available rules.'), nl ),
    nl.

% Sample test queries
sample_test(1) :- recommend(loam, 800, 22, long_rains, npk, Crop, Yield, Explanation),
                 format('Test 1: ~w, ~w~nExplanation: ~w~n', [Crop, Yield, Explanation]).

sample_test(2) :- recommend(clay, 1200, 25, wet_season, organic, Crop, Yield, Explanation),
                 format('Test 2: ~w, ~w~nExplanation: ~w~n', [Crop, Yield, Explanation]).

sample_test(3) :- recommend(sandy, 450, 28, dry_season, compost, Crop, Yield, Explanation),
                 format('Test 3: ~w, ~w~nExplanation: ~w~n', [Crop, Yield, Explanation]).

sample_test(4) :- recommend(loam, 650, 18, cool_season, npk, Crop, Yield, Explanation),
                 format('Test 4: ~w, ~w~nExplanation: ~w~n', [Crop, Yield, Explanation]).

sample_test(5) :- recommend(sandy, 500, 24, short_rains, organic, Crop, Yield, Explanation),
                 format('Test 5: ~w, ~w~nExplanation: ~w~n', [Crop, Yield, Explanation]).
