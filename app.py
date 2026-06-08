from flask import Flask, render_template, request

app = Flask(__name__)

SOIL_TYPES = ['clay', 'loam', 'sandy']
SEASONS = ['long_rains', 'short_rains', 'wet_season', 'dry_season', 'cool_season']
FERTILIZERS = ['organic', 'npk', 'compost', 'none']

history = []

CROP_RULES = [
    {
        'crop': 'rice',
        'soil': ['clay', 'loam'],
        'rain_min': 1000,
        'temp_min': 20,
        'temp_max': 30,
        'seasons': ['wet_season'],
        'fertilizers': ['organic'],
        'reason': 'Rice is suited to clay or loam soils with very high rainfall and wet season conditions.'
    },
    {
        'crop': 'maize',
        'soil': ['clay', 'loam'],
        'rain_min': 700,
        'temp_min': 18,
        'temp_max': 30,
        'seasons': ['long_rains'],
        'fertilizers': ['organic', 'npk', 'compost'],
        'reason': 'Maize is suited to loam or clay soil with rainfall above 700mm and warm temperatures in the long rains season.'
    },
    {
        'crop': 'cassava',
        'soil': ['clay', 'loam'],
        'rain_min': 800,
        'rain_max': 1500,
        'temp_min': 22,
        'temp_max': 32,
        'seasons': ['wet_season'],
        'fertilizers': ['organic'],
        'reason': 'Cassava performs well in clay or loam soils with high rainfall and wet season conditions.'
    },
    {
        'crop': 'potato',
        'soil': ['loam'],
        'rain_min': 500,
        'rain_max': 900,
        'temp_min': 15,
        'temp_max': 22,
        'seasons': ['cool_season'],
        'fertilizers': ['organic', 'npk'],
        'reason': 'Potato is suited to loam soil, moderate rainfall, and cool season temperatures.'
    },
    {
        'crop': 'wheat',
        'soil': ['loam', 'clay'],
        'rain_min': 300,
        'rain_max': 800,
        'temp_min': 10,
        'temp_max': 24,
        'seasons': ['cool_season', 'short_rains'],
        'fertilizers': ['npk'],
        'reason': 'Wheat is suited to moderate rainfall, cool season temperatures, and NPK fertilizer.'
    },
    {
        'crop': 'sorghum',
        'soil': ['sandy', 'loam'],
        'rain_min': 250,
        'rain_max': 700,
        'temp_min': 20,
        'temp_max': 35,
        'seasons': ['dry_season'],
        'fertilizers': ['organic', 'compost', 'npk'],
        'reason': 'Sorghum tolerates sandy or loam soils and dry season conditions with moderate rainfall.'
    },
    {
        'crop': 'sunflower',
        'soil': ['sandy', 'loam'],
        'rain_min': 300,
        'rain_max': 700,
        'temp_min': 20,
        'temp_max': 32,
        'seasons': ['dry_season'],
        'fertilizers': ['npk'],
        'reason': 'Sunflower fits sandy or loam soils with moderate rainfall and dry season temperatures.'
    },
    {
        'crop': 'beans',
        'soil': ['loam', 'sandy'],
        'rain_min': 400,
        'rain_max': 900,
        'temp_min': 16,
        'temp_max': 28,
        'seasons': ['short_rains'],
        'fertilizers': ['compost'],
        'reason': 'Beans are suited to loam or sandy soil with moderate rainfall and short rains season.'
    },
    {
        'crop': 'barley',
        'soil': ['loam', 'clay'],
        'rain_min': 300,
        'rain_max': 600,
        'temp_min': 10,
        'temp_max': 22,
        'seasons': ['cool_season'],
        'fertilizers': ['npk'],
        'reason': 'Barley suits light rainfall and cool season conditions on loam or clay soils.'
    },
    {
        'crop': 'millet',
        'soil': ['sandy', 'loam'],
        'rain_min': 200,
        'rain_max': 500,
        'temp_min': 25,
        'temp_max': 35,
        'seasons': ['dry_season'],
        'fertilizers': ['compost'],
        'reason': 'Millet tolerates low rainfall and hot dry season conditions on sandy or loam soils.'
    },
    {
        'crop': 'groundnut',
        'soil': ['sandy', 'loam'],
        'rain_min': 450,
        'rain_max': 850,
        'temp_min': 22,
        'temp_max': 30,
        'seasons': ['short_rains'],
        'fertilizers': ['organic'],
        'reason': 'Groundnut is suited to sandy or loam soils with moderate rainfall and short rains.'
    },
    {
        'crop': 'cotton',
        'soil': ['sandy'],
        'rain_min': 400,
        'rain_max': 800,
        'temp_min': 22,
        'temp_max': 33,
        'seasons': ['dry_season'],
        'fertilizers': ['npk'],
        'reason': 'Cotton thrives in sandy soil with warm dry season conditions and NPK fertilizer.'
    },
    {
        'crop': 'tomato',
        'soil': ['loam'],
        'rain_min': 500,
        'rain_max': 800,
        'temp_min': 18,
        'temp_max': 25,
        'seasons': ['cool_season'],
        'fertilizers': ['compost'],
        'reason': 'Tomato prefers loam soil with moderate rainfall and mild cool season temperatures.'
    },
    {
        'crop': 'pepper',
        'soil': ['loam'],
        'rain_min': 400,
        'rain_max': 750,
        'temp_min': 20,
        'temp_max': 30,
        'seasons': ['short_rains'],
        'fertilizers': ['compost'],
        'reason': 'Pepper favors loam soil with moderate rainfall and warm short rains conditions.'
    },
    {
        'crop': 'soybeans',
        'soil': ['loam'],
        'rain_min': 500,
        'rain_max': 900,
        'temp_min': 18,
        'temp_max': 30,
        'seasons': ['long_rains', 'short_rains'],
        'fertilizers': ['npk'],
        'reason': 'Soybeans do well in loam soil with moderate rainfall and NPK fertilizer during rains.'
    },
    {
        'crop': 'onions',
        'soil': ['loam'],
        'rain_min': 300,
        'rain_max': 700,
        'temp_min': 15,
        'temp_max': 24,
        'seasons': ['cool_season'],
        'fertilizers': ['compost'],
        'reason': 'Onions prefer loam soil with moderate rainfall and cool season conditions.'
    }
]

YIELD_RULES = [
    {
        'yield': 'high',
        'crops': ['maize', 'rice', 'cassava'],
        'rain_min': 800,
        'temp_min': 18,
        'temp_max': 30,
        'fertilizers': ['organic', 'npk', 'compost'],
        'reason': 'High yield expected when rainfall is strong, temperature is favorable, and fertilizer is applied.'
    },
    {
        'yield': 'medium',
        'crops': ['wheat', 'sorghum', 'sunflower', 'beans', 'potato', 'groundnut', 'cotton', 'tomato', 'soybeans', 'onions'],
        'rain_min': 500,
        'rain_max': 900,
        'temp_min': 16,
        'temp_max': 30,
        'fertilizers': ['organic', 'npk', 'compost'],
        'reason': 'Medium yield is expected under moderate rainfall, favorable temperature, and fertilizer use.'
    },
    {
        'yield': 'medium',
        'crops': ['millet'],
        'rain_min': 200,
        'rain_max': 500,
        'temp_min': 25,
        'temp_max': 35,
        'fertilizers': ['organic', 'npk', 'compost'],
        'reason': 'Millet achieves medium yield in hot, dry conditions with adequate soil and fertilizer.'
    }
]

DEFAULT_LOW_YIELD_REASON = 'Low yield is likely when rainfall, temperature, or fertilizer conditions are suboptimal.'


def validate_inputs(soil, rainfall, temperature, season, fertilizer):
    if soil not in SOIL_TYPES:
        return False, 'Soil type is invalid.'
    if season not in SEASONS:
        return False, 'Season is invalid.'
    if fertilizer not in FERTILIZERS:
        return False, 'Fertilizer type is invalid.'
    if rainfall < 0:
        return False, 'Rainfall must be zero or positive.'
    if temperature < -10 or temperature > 50:
        return False, 'Temperature must be within a realistic agro range.'
    return True, None


def find_crop(soil, rainfall, temperature, season, fertilizer):
    trace = ['Validating crop compatibility rules.']
    for rule in CROP_RULES:
        if soil not in rule['soil']:
            continue
        if rainfall < rule.get('rain_min', 0):
            continue
        if rule.get('rain_max') is not None and rainfall > rule['rain_max']:
            continue
        if temperature < rule.get('temp_min', -999):
            continue
        if temperature > rule.get('temp_max', 999):
            continue
        if season not in rule['seasons']:
            continue
        if fertilizer not in rule['fertilizers']:
            continue
        trace.append(f"Matched crop rule for {rule['crop']}: {rule['reason']}")
        return rule['crop'], rule['reason'], trace

    trace.append('No crop rule matched the provided inputs.')
    return None, None, trace


def estimate_yield(crop, rainfall, temperature, fertilizer):
    trace = ['Estimating yield from crop and environmental conditions.']
    for rule in YIELD_RULES:
        if crop not in rule['crops']:
            continue
        if rainfall < rule.get('rain_min', 0):
            continue
        if rule.get('rain_max') is not None and rainfall > rule['rain_max']:
            continue
        if temperature < rule.get('temp_min', -999):
            continue
        if temperature > rule.get('temp_max', 999):
            continue
        if fertilizer not in rule['fertilizers']:
            continue
        trace.append(f"Matched yield rule for {crop}: {rule['reason']}")
        return rule['yield'], rule['reason'], trace

    trace.append(DEFAULT_LOW_YIELD_REASON)
    return 'low', DEFAULT_LOW_YIELD_REASON, trace


@app.route('/', methods=['GET', 'POST'])
def index():
    result = None
    error = None
    selected = {
        'soil_type': 'loam',
        'rainfall': 800,
        'temperature': 22,
        'season': 'long_rains',
        'fertilizer': 'npk'
    }

    if request.method == 'POST':
        soil_type = request.form.get('soil_type', '').strip()
        season = request.form.get('season', '').strip()
        fertilizer = request.form.get('fertilizer', '').strip()
        try:
            rainfall = int(request.form.get('rainfall', '0'))
            temperature = float(request.form.get('temperature', '0'))
        except ValueError:
            error = 'Rainfall and temperature must be numeric values.'
            rainfall = 0
            temperature = 0

        selected.update({
            'soil_type': soil_type,
            'rainfall': rainfall,
            'temperature': temperature,
            'season': season,
            'fertilizer': fertilizer
        })

        valid, validation_message = validate_inputs(soil_type, rainfall, temperature, season, fertilizer)
        if not valid:
            error = validation_message
        else:
            crop, crop_reason, crop_trace = find_crop(soil_type, rainfall, temperature, season, fertilizer)
            if crop is None:
                error = 'No recommended crop could be derived from the current rule base.'
            else:
                yield_category, yield_reason, yield_trace = estimate_yield(crop, rainfall, temperature, fertilizer)
                explanation = f"{crop.capitalize()} recommended because {crop_reason} {yield_reason}"
                trace = crop_trace + yield_trace
                result = {
                    'soil_type': soil_type,
                    'rainfall': rainfall,
                    'temperature': temperature,
                    'season': season,
                    'fertilizer': fertilizer,
                    'crop': crop,
                    'yield': yield_category,
                    'explanation': explanation,
                    'trace': trace
                }
                history.insert(0, result)
                if len(history) > 5:
                    history.pop()

    return render_template(
        'index.html',
        soil_types=SOIL_TYPES,
        seasons=SEASONS,
        fertilizers=FERTILIZERS,
        selected=selected,
        result=result,
        error=error,
        history=history
    )


if __name__ == '__main__':
    app.run(debug=True)
