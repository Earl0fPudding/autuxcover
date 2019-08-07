from bottle import route, run, error, template, response
import xml.etree.ElementTree as ET

@route('/autodiscover/autodiscover.json')
def hello():
    config = ET.parse('config.xml')
    response.content_type = 'application/json'
    return template('autodiscover_json', config=config)

@error(404)
def err404(message):
    return "The requested page could not be found!"


run(host='localhost', port=8089, debug=True)
