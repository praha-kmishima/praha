-- hogehogeさんの記事投稿
SET @user_id = 1;
INSERT INTO articles (user_id, history, subject, content) 
VALUES (
    @user_id,
    0,
    'ほげほげ',
    '2024/09/21 初投稿'
    );

-- kmishimaさんの記事投稿
SET @user_id_kmishima = 2;
INSERT INTO articles (user_id, history, subject, content) 
VALUES (
    @user_id_kmishima,
    0,
    'データベースモデリング5の課題1',
    'データベースモデリング課題の解答です。～～～～'
    );