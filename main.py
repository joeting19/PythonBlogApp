from flask import Flask, render_template, redirect, url_for
from flask_bootstrap import Bootstrap
from flask_sqlalchemy import SQLAlchemy
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired, URL
from flask_ckeditor import CKEditor, CKEditorField
from datetime import date
from waitress import serve
from flask import request
import logging
from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime

app = Flask(__name__)
app.config['SECRET_KEY'] = '8BYkEfBA6O6donzWlSihBXox7C0sKR6b'
ckeditor = CKEditor(app)
Bootstrap(app)

#logging
logger = logging.getLogger('website_logger')
logger.setLevel(logging.INFO)
handler = logging.FileHandler('website.log')
formatter = logging.Formatter('%(asctime)s %(levelname)s %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)


##CONNECT TO DB
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:postgres@20.84.69.25:5432/postgres'
#app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///posts.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

##CONFIGURE TABLE for cloud blog posts
class BlogPost(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(250), unique=True, nullable=False)
    subtitle = db.Column(db.String(250), nullable=False)
    date = db.Column(db.String(250), nullable=False)
    body = db.Column(db.Text, nullable=False)
    author = db.Column(db.String(250), nullable=False)
    img_url = db.Column(db.String(250), nullable=False)

##CONFIGURE TABLE for spirituality blog posts
class SpiritPost(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(250), unique=True, nullable=False)
    subtitle = db.Column(db.String(250), nullable=False)
    date = db.Column(db.String(250), nullable=False)
    body = db.Column(db.Text, nullable=False)
    author = db.Column(db.String(250), nullable=False)
    img_url = db.Column(db.String(250), nullable=False)


#config blog table
class VisitorLog(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    time = db.Column(DateTime, default=datetime.now)
    ip_address = db.Column(db.String(20))
    message = db.Column(db.String(200))


#function to create log
def log(message):
    if not request.headers.getlist("X-Forwarded-For"):
        ip = request.remote_addr
    else:
        ip = request.headers.getlist("X-Forwarded-For")[0]
    ip_address = ip
    log_entry = VisitorLog(ip_address=ip_address, message=message)
    db.session.add(log_entry)
    db.session.commit()


##WTForm
class CreatePostForm(FlaskForm):
    title = StringField("Blog Post Title", validators=[DataRequired()])
    subtitle = StringField("Subtitle", validators=[DataRequired()])
    author = StringField("Your Name", validators=[DataRequired()])
    img_url = StringField("Blog Image URL", validators=[DataRequired(), URL()])

    # Notice body's StringField changed to CKEditorField
    body = CKEditorField("Blog Content", validators=[DataRequired()])
    submit = SubmitField("Submit Post")

##RENDER HOME PAGE USING DB
@app.route('/')
def get_all_posts():
    posts = BlogPost.query.all()
    log('Homepage visited')
    return render_template("index.html", all_posts=posts)


##RENDER POST USING DB
@app.route("/post/<int:post_id>")
def show_post(post_id):
    requested_post = BlogPost.query.get(post_id)
    log(requested_post.title + " post visited")
    return render_template("post.html", post=requested_post)


@app.route("/new-post", methods=["GET", "POST"])
def add_new_post():
    form = CreatePostForm()
    if form.validate_on_submit():
        new_post = BlogPost(
            title=form.title.data,
            subtitle=form.subtitle.data,
            body=form.body.data,
            img_url=form.img_url.data,
            author=form.author.data,
            date=date.today().strftime("%B %d, %Y")
        )
        db.session.add(new_post)
        db.session.commit()
        log('Post Added')
        return redirect(url_for("get_all_posts"))
    return render_template("make-post.html", form=form)

@app.route("/edit-post/<int:post_id>", methods=["GET", "POST"])
def edit_post(post_id):
    post = BlogPost.query.get(post_id)
    edit_form = CreatePostForm(
        title=post.title,
        subtitle=post.subtitle,
        body=post.body,
        img_url=post.img_url,
        author=post.author )
    if edit_form.validate_on_submit():
        post.title = edit_form.title.data
        post.subtitle = edit_form.subtitle.data
        post.img_url = edit_form.img_url.data
        post.author = edit_form.author.data
        post.body = edit_form.body.data
        db.session.commit()
        log(post.title +' Post edited')
        return redirect(url_for("show_post", post_id=post.id))
    return render_template("make-post.html", form=edit_form, is_edit=True)

@app.route("/delete/<int:post_id>")
def delete_post(post_id):
    post_to_delete = BlogPost.query.get(post_id)
    db.session.delete(post_to_delete)
    db.session.commit()
    log(post_to_delete.title + ' Post deleted')
    return redirect(url_for('get_all_posts'))

@app.route("/about")
def about():
    log('About page visited')
    return render_template("about.html")




#this section is for my spirituality blogs
@app.route("/spirit")
def get_all_posts_spirit():
    posts = SpiritPost.query.all()
    log('Spirituality page visited')
    return render_template("spirit.html", all_posts=posts)

@app.route("/spirit/new-post", methods=["GET", "POST"])
def add_new_post_spirit():
    form = CreatePostForm()
    if form.validate_on_submit():
        new_post = SpiritPost(
            title=form.title.data,
            subtitle=form.subtitle.data,
            body=form.body.data,
            img_url=form.img_url.data,
            author=form.author.data,
            date=date.today().strftime("%B %d, %Y")
        )
        db.session.add(new_post)
        db.session.commit()
        log('Spirituality Post Added')
        return redirect(url_for("get_all_posts_spirit"))
    return render_template("make-post.html", form=form)



##RENDER POST USING DB
@app.route("/spirit/post/<int:post_id>")
def show_post_spirit(post_id):
    requested_post = SpiritPost.query.get(post_id)
    log(requested_post.title + " post visited")
    return render_template("post_spirit.html", post=requested_post)


@app.route("/spirit/edit-post/<int:post_id>", methods=["GET", "POST"])
def edit_post_spirit(post_id):
    post = SpiritPost.query.get(post_id)
    edit_form = CreatePostForm(
        title=post.title,
        subtitle=post.subtitle,
        body=post.body,
        img_url=post.img_url,
        author=post.author )
    if edit_form.validate_on_submit():
        post.title = edit_form.title.data
        post.subtitle = edit_form.subtitle.data
        post.img_url = edit_form.img_url.data
        post.author = edit_form.author.data
        post.body = edit_form.body.data
        db.session.commit()
        log(post.title +' Post edited')
        return redirect(url_for("show_post_spirit", post_id=post.id))
    return render_template("make-post.html", form=edit_form, is_edit=True)


@app.route("/spirit/delete/<int:post_id>")
def delete_post_spirit(post_id):
    post_to_delete = SpiritPost.query.get(post_id)
    db.session.delete(post_to_delete)
    db.session.commit()
    log(post_to_delete.title +' Post deleted')
    return redirect(url_for('get_all_posts_spirit'))

@app.route("/contact")
def contact():
    return render_template("contact.html")

@app.route("/resume")
def resume():
    log('resume visited')
    return render_template("srt-resume.html")

if __name__ == "__main__":
    #serve(app, listen='*:5000')
    app.run(host='0.0.0.0', port=5000)



