# # import eel

# eel.init('front-end')


# @eel.expose
# def add(num1, num2):
#     return int(num1) + int(num2)


# @eel.expose
# def subtract(num1, num2):
#     return int(num1) - int(num2)


# eel.start('home.html', size=(1000, 600))
from tensorflow.keras.models import load_model
import numpy as np
from flask import Flask,render_template
import easygui
import cv2
import os
import dlib
import face_recognition
from flask_caching import Cache
from shutil import copyfile


app = Flask(__name__)

config = {
    "DEBUG": True,          # some Flask specific configs
    "CACHE_TYPE": "null", # Flask-Caching related configs
}

app.config.from_mapping(config)
cache = Cache(app)


@app.route('/')
@app.route('/home')
@app.route('/home.html')
def home_page():
    return render_template('home.html')


    

@app.route('/potato')
@app.route('/potato.html')
@app.route('/potato.html/<number>')
def potato():
    cpt = sum([len(files) for r, d, files in os.walk("static/potato")])
    # number=cpt+1
    return render_template('potato.html', number = cpt, flag = 1)

@app.route('/')
@app.route('/select_potato')
def select_potato():
	cpt = sum([len(files) for r, d, files in os.walk("static/potato")])


	file = easygui.fileopenbox()

	if file == None:
		return render_template('potato.html', number = cpt, flag = 0)

	if file.lower().endswith(('.png', '.jpg', '.jpeg')) == False:
		return render_template('potato.html', number = cpt, flag=-1)	
	
	frame = cv2.imread(file)
	
	number=cpt+1
	filename=str(number)+'.jpg'
	path = './static/potato'
	cv2.imwrite(os.path.join(path , filename), frame)
	cv2.destroyAllWindows()
	return render_template('detect_potato.html')

@app.route('/detect_potato')
@app.route('/detect_potato.html')
def detect_potato():
    cpt = sum([len(files) for r, d, files in os.walk("static/potato")])
    # number=cpt+1
    return render_template('detect_potato.html')


@app.route('/')
@app.route('/results')
def results(path, img):
    model = load_model(path)
    img = cv2.resize(img, (128, 128))
    img = np.reshape(img,(1, 128, 128, 3))
    y = model.predict(img)>0.7
    return y

@app.route('/')
@app.route('/detect')
def detect():
	person=[]
	folder="static/potato"
	for filename in os.listdir(folder):
	    img = cv2.imread(os.path.join(folder,filename))
	    #img= cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
	    if img is not None:
	        person.append(img)

	folder = 'static/potato'
	for filename in os.listdir(folder):
	    file_path = os.path.join(folder, filename)
	    try:
	        if os.path.isfile(file_path) or os.path.islink(file_path):
	            os.unlink(file_path)
	        elif os.path.isdir(file_path):
	            shutil.rmtree(file_path)
	    except Exception as e:
        	print('Failed to delete %s. Reason: %s' % (file_path, e))
	path = 'static/potato.h5'
	if person is not None:
		for i in person:
			if(results(path,i)):
				return render_template('detect_true.html')
			else:
				return render_template('detect_false.html')


@app.route('/corn')
@app.route('/corn.html')
def corn():
    cpt = sum([len(files) for r, d, files in os.walk("static/corn")])
    # number=cpt+1
    return render_template('corn.html', number = cpt, flag = 1)

@app.route('/')
@app.route('/select_corn')
def select_corn():
	cpt = sum([len(files) for r, d, files in os.walk("static/corn")])


	file = easygui.fileopenbox()

	if file == None:
		return render_template('corn.html', number = cpt, flag = 0)

	if file.lower().endswith(('.png', '.jpg', '.jpeg')) == False:
		return render_template('corn.html', number = cpt, flag=-1)	
	
	frame = cv2.imread(file)
	
	number=cpt+1
	filename=str(number)+'.jpg'
	path = './static/corn'
	cv2.imwrite(os.path.join(path , filename), frame)
	cv2.destroyAllWindows()
	return render_template('detect_corn.html')

@app.route('/detect_corn')
@app.route('/detect_corn.html')
def detect_corn():
    cpt = sum([len(files) for r, d, files in os.walk("static/corn")])
    # number=cpt+1
    return render_template('detect_corn.html')


@app.route('/')
@app.route('/results_corn')
def results_corn(path, img):
    model = load_model(path)
    img = cv2.resize(img, (128, 128))
    img = np.reshape(img,(1, 128, 128, 3))
    y = model.predict(img)>0.7
    return y

@app.route('/')
@app.route('/detect1')
def detect1():
	person=[]
	folder="static/corn"
	for filename in os.listdir(folder):
	    img = cv2.imread(os.path.join(folder,filename))
	    #img= cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
	    if img is not None:
	        person.append(img)

	folder = 'static/corn'
	for filename in os.listdir(folder):
	    file_path = os.path.join(folder, filename)
	    try:
	        if os.path.isfile(file_path) or os.path.islink(file_path):
	            os.unlink(file_path)
	        elif os.path.isdir(file_path):
	            shutil.rmtree(file_path)
	    except Exception as e:
        	print('Failed to delete %s. Reason: %s' % (file_path, e))
	path = 'static/corn.h5'
	if person is not None:
		for i in person:
			if(results_corn(path,i)):
				return render_template('detect_true.html')
			else:
				return render_template('detect_false.html')

@app.route('/test.html')
def test_css():
	return render_template('test.html')	


@app.after_request
def add_header(r):
    """
    Add headers to both force latest IE rendering engine or Chrome Frame,
    and also to cache the rendered page for 10 minutes.
    """
    r.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    r.headers["Pragma"] = "no-cache"
    r.headers["Expires"] = "0"
    r.headers['Cache-Control'] = 'public, max-age=0'
    return r


if __name__ == '__main__':
	app.run(debug=True)    