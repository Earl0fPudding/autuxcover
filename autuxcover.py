from bottle import route, run, error, template, response, request
import xml.etree.ElementTree as ET

@route('/autodiscover/autodiscover.json')
def autodiscover_json():
    config = ET.parse('config.xml')
    response.content_type = 'application/json'
    return template('autodiscover_json', config=config)

@route('/autodiscover/autodiscover.xml')
def autodiscover_xml():
    config = ET.parse('config.xml')
    email = request.body.read().decode("utf-8").split('<EMailAddress>')[1].split('</EMailAddress>')[0]
    username = email.split('@')[0]
    response.content_type = 'application/xml'
    return template('autodiscover_xml', config=config, email=email, username=username)

@error(404)
def err404(message):
    return "The requested page could not be found!"


run(host='localhost', port=8089, debug=True)
