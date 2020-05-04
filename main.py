from firebase_admin import initialize_app, credentials, messaging
import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

cred = credentials.Certificate(
        BASE_DIR + '/test-27fe0-firebase-adminsdk-0ag63-888429f919.json')
app = initialize_app(cred)
token = input('Token: ')
while True:
    try:
        message = input('Mensagem: ')
        messaging.send(
            messaging.Message(
                data={'message': message},
                token=token
            ),
            app=app
        )
    except KeyboardInterrupt:
        break
    except Exception as e:
        print(e)
        break


