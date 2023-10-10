from flask import Flask, request, jsonify
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from models import Base, User

app = Flask(__name__)

# Configure the RDS database
DB_URI = ''
engine = create_engine(DB_URI)
Base.metadata.bind = engine
DBSession = sessionmaker(bind=engine)

@app.route('/api/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('Username')
    password = data.get('Password')

    # Validate the login credentials (you will implement this logic)
    # In a real application, you'd typically hash the password and compare it to the stored hash
    # For simplicity, this example just checks for a matching user in the database
    session = DBSession()
    user = session.query(User).filter_by(Username=Username).first()
    session.close()

    if user and user.password == password:
       return jsonify({'message': 'Login successful'})
    else:
        return jsonify({'message': 'Login failed'})

if __name__ == '__main__':
    app.run()
