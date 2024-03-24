-- ワークスペース1のデータ挿入
INSERT INTO channels_in_workspace (workspace_id, channel_id) VALUES 
    (2, 6),
    (2, 7),
    (2, 8),
    (2, 9);

INSERT INTO users_in_workspace (workspace_id, user_id) VALUES 
    (2, 1),
    (2, 2),
    (2, 3),
    (2, 4),
    (2, 5);
    
-- users_in_channelテーブルにデータを挿入
-- 全ユーザが参加
INSERT INTO users_in_channel (channel_id, user_id) VALUES 
    (6, 1),
    (6, 2),
    (6, 3),
    (6, 4),
    (6, 5),
    (7, 1),
    (7, 2),
    (7, 3),
    (7, 4),
    (7, 5),
    (8, 1),
    (8, 2),
    (8, 3),
    (8, 4),
    (8, 5),
    (9, 1),
    (9, 2),
    (9, 3),
    (9, 4),
    (9, 5);

-- ワークスペース2のチャンネル1にプロジェクトマネジメントに関する会話風のテキストを投稿
INSERT INTO `messages` (`workspace_id`, `channel_id`, `user_id`, `content`) VALUES
(2, 6, 1, 'プロジェクトマネジメントって難しいですよね。'),
(2, 6, 2, 'はい、特にリソースの管理が難しいです。'),
(2, 6, 3, '私もプロジェクトマネジメントには苦労しています。'),
(2, 6, 4, 'スケジュール管理が特に大変ですね。'),
(2, 6, 5, 'リソース配分には悩みますね。'),
(2, 6, 1, 'スコープの変更管理も重要ですね。'),
(2, 6, 2, 'はい、スコープクリープに注意が必要です。'),
(2, 6, 3, 'スコープの変更はプロジェクトに大きな影響を与えます。'),
(2, 6, 4, '顧客の要求変更に迅速に対応するのは難しいですね。'),
(2, 6, 5, 'スコープの変更を管理するツールが欲しいですね。');

-- チャンネル1のスレッドメッセージをINSERT
INSERT INTO `thread_messages` (`message_id`, `user_id`, `content`) VALUES
(51, 2, 'スケジュールの遅れがリソースを圧迫しますね。'),
(53, 3, 'スケジュールの調整はバランスが難しいですね。'),
(55, 4, 'リソースの適切な割り当てがプロジェクト成功の鍵です。'),
(57, 5, 'スコープの変更に対するコミュニケーションも重要ですね。'),
(59, 1, 'スコープの変更にはプロセスが必要です。');

-- チャンネル2のメッセージをINSERT
INSERT INTO `messages` (`workspace_id`, `channel_id`, `user_id`, `content`) VALUES
-- ワークスペース2のチャンネル2にプロジェクトマネジメントに関する会話風のテキストを投稿
(2, 7, 1, 'プロジェクトマネジメントにおいてコミュニケーションは欠かせませんね。'),
(2, 7, 2, 'はい、特にステークホルダーとのコミュニケーションは重要です。'),
(2, 7, 3, '私もステークホルダーとのコミュニケーションに力を入れています。'),
(2, 7, 4, 'プロジェクトの進捗報告は適切なタイミングで行う必要がありますね。'),
(2, 7, 5, '進捗報告はステークホルダーに安心感を与えますね。'),
(2, 7, 1, 'ステークホルダーとの期待管理も大切ですね。'),
(2, 7, 2, 'はい、期待を適切に管理することで誤解を防げます。'),
(2, 7, 3, '期待管理はプロジェクト成功のために不可欠です。'),
(2, 7, 4, 'ステークホルダーとの対話を通じて期待を合わせることが大切ですね。'),
(2, 7, 5, 'ステークホルダーの期待を適切に理解することが重要です。');

-- チャンネル2のスレッドメッセージをINSERT
INSERT INTO `thread_messages` (`message_id`, `user_id`, `content`) VALUES
(61, 2, 'ステークホルダーはプロジェクトの成功に大きく関わりますね。'),
(63, 3, 'ステークホルダーの期待に応えることで信頼関係が築けますね。'),
(65, 4, '進捗報告はステークホルダーとの信頼を築く重要な機会です。'),
(67, 5, 'プロジェクトの目標を明確にすることで期待管理がしやすくなりますね。'),
(69, 1, 'ステークホルダーとの対話はプロジェクトの進行を円滑にします。');

-- チャンネル6のメッセージをINSERT
INSERT INTO `messages` (`workspace_id`, `channel_id`, `user_id`, `content`) VALUES
(2, 8, 1, '新しいプロジェクトの立ち上げに向けて準備を進めています。'),
(2, 8, 2, 'プロジェクトの目標とスコープを確定しました。'),
(2, 8, 3, 'プロジェクトのリソースを確保するために動いています。'),
(2, 8, 4, 'プロジェクトの進行状況についてディスカッションしましょう。'),
(2, 8, 5, 'プロジェクトの課題とリスクを共有しましょう。'),
(2, 8, 1, '新しいプロジェクトのスケジュールを立てる必要があります。'),
(2, 8, 2, 'はい、タイムラインを設定しましょう。'),
(2, 8, 3, 'スケジュールの優先順位を決める必要がありますね。'),
(2, 8, 4, 'リソースの割り当てを考慮に入れたスケジュールを作成しましょう。'),
(2, 8, 5, 'プロジェクトの期限を考慮に入れて、スケジュールを調整しましょう。');

-- チャンネル6のスレッドメッセージをINSERT
INSERT INTO `thread_messages` (`message_id`, `user_id`, `content`) VALUES
(71, 2, 'スケジュールの作成にはリソースの可用性を確認する必要がありますね。'),
(73, 3, 'プロジェクトのマイルストーンを設定するとスケジュールの優先順位が明確になりますね。'),
(75, 4, 'プロジェクトのリスクを分析して、スケジュールにリスク管理の余地を持たせる必要があります。'),
(77, 5, 'スケジュールの柔軟性を持たせることで、変化に対応しやすくなりますね。'),
(79, 1, 'スケジュールはプロジェクトの成否に大きく関わりますので、慎重に計画しましょう。');

-- チャンネル7のメッセージをINSERT
INSERT INTO `messages` (`workspace_id`, `channel_id`, `user_id`, `content`) VALUES
(2, 9, 1, 'プロジェクトのコミュニケーションプランを策定しましょう。'),
(2, 9, 2, 'はい、ステークホルダーとのコミュニケーションスケジュールを作成しましょう。'),
(2, 9, 3, 'プロジェクトの進行状況を報告するためのツールを選定しています。'),
(2, 9, 4, '週次の進捗報告ミーティングを開催する予定です。'),
(2, 9, 5, 'プロジェクトの進行状況を週次でステークホルダーと共有しましょう。'),
(2, 9, 1, 'ステークホルダーからのフィードバックを収集するための仕組みを構築しましょう。'),
(2, 9, 2, 'はい、フィードバックを取り入れてプロジェクトの進行方向を調整しましょう。'),
(2, 9, 3, 'ステークホルダーの期待に応えるためのコミュニケーションプランを作成します。'),
(2, 9, 4, 'ステークホルダーとのコミュニケーションはプロジェクト成功の鍵です。'),
(2, 9, 5, 'ステークホルダーとのコミュニケーションを円滑にするために、週次報告を行います。');

-- チャンネル7のスレッドメッセージをINSERT
INSERT INTO `thread_messages` (`message_id`, `user_id`, `content`) VALUES
(71, 2, 'ステークホルダーとのコミュニケーションは透明性を持たせることが重要ですね。'),
(73, 3, '週次報告はステークホルダーとの信頼関係を築くために重要ですね。'),
(75, 4, 'ステークホルダーのフィードバックを活かしてプロジェクトを改善していきましょう。'),
(77, 5, 'プロジェクトの進行状況をステークホルダーと共有することで、問題を早期に発見できますね。'),
(79, 1, 'ステークホルダーとのコミュニケーションはプロジェクトの成否に直結しますので、十分な配慮が必要です。');
