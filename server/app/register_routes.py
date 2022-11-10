from flask import request, redirect, render_template, url_for
from .score_form import ScoreForm, Org, Squad
from .results import write_result, read_result


def register_routes(app_blueprint):

    @app_blueprint.route('/')
    def home():
        return redirect(url_for('app.score', n=3))

    @app_blueprint.route('/score/<int:n>', methods=['GET', 'POST'])
    def score(n):
        # from flask import current_app
        # if request.method == 'POST':
        #     current_app.logger.info("INSIDE POST")
        #     current_app.logger.info(request.data)
        # if request.method == 'GET':
        #     current_app.logger.info("INSIDE GET")
        org = Org()
        org.squads = []
        for _ in range(n):
            org.squads.append(Squad())
        form = ScoreForm(obj=org)
        if form.validate_on_submit():
            form.populate_obj(org)
            sid = write_result(data_from(form))
            return redirect(url_for('app.scores', sid=sid))
        else:
            # current_app.logger.info("form.invalidate_on_submit() == False")
            return render_template('score.html', form=form)

    @app_blueprint.route('/scores/<sid>', methods=['GET'])
    def scores(sid):
        return render_template('scores.html', result=read_result(sid))


def data_from(form):
    def squad(n):
        return {
            "char": "ABCDEF"[n],
            "letters": form.squads[n].letters.data,
            "is_word": form.squads[n].is_word.data
        }
    return {
        "squads": [squad(n) for n in range(len(form.squads))],
        "is_sentence": form.is_sentence.data,
        "is_profound": form.is_profound.data
    }
