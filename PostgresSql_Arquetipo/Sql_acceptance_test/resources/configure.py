from collections import namedtuple
import configparser
def get_variables(environment):
    DBConfig = namedtuple('DBCONFIG', 'user, pwd')

    configParser = configparser.RawConfigParser()   
    configFilePath = r'resources\database.ini'
    configParser.read(configFilePath)
    db_config = {
        "local": DBConfig(configParser.get('LOCAL', 'username'), configParser.get('LOCAL', 'password'))
    }
    return {
        "dbconfig": db_config[environment]
    }
        