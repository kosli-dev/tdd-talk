from flask import redirect, render_template, url_for
from .score_form import ScoreForm, Org, Squad
from .results import write_result, read_result


def register_routes(app_blueprint):

    @app_blueprint.route('/')
    def home():
        return redirect(url_for('app.score', n=3))

    @app_blueprint.route('/score/<int:n>', methods=['POST', 'GET'])
    def score(n):
        org = Org()
        org.squads = []
        for _ in range(n):
            org.squads.append(Squad())
        form = ScoreForm(obj=org)
        if form.validate_on_submit():
            form.populate_obj(org)
            # TODO: Get actual form's data
            sid = write_result(FAKE_FORM_DATA)
            return redirect(url_for('app.scores', sid=sid))
        else:
            return render_template('score.html', form=form)

    @app_blueprint.route('/scores/<sid>', methods=['GET'])
    def scores(sid):
        return render_template('scores.html', result=read_result(sid))


FAKE_FORM_DATA = {
    "squads": [
        {"char": "A", "letters": "xyzzy", "is_word": False},
        {"char": "B", "letters": "hello", "is_word": True},
        {"char": "C", "letters": "world", "is_word": True},
    ],
    "is_sentence": False,
    "is_profound": False
}