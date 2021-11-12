#起動コマンド　morbo myapp2.pl
# テンプレートを扱う
use Mojolicious::Lite;

#アプリケーションオブジェクト
my $app = app;

#Mojoのホームディレクトリを表すホームオブジェクトの取得
my $home = $app->home;
print "$home\n";

#Config読み込み
plugin('Config');
$app->plugin('Config');

get '/' => sub{
  my $self = shift;
  my $app = $self->app;
  #Confから値を取り出してスタッシュでテンプレートに渡す
  my $name = $app->config('name');
  my $age = $app->config('age');
  #スタッシュに値を設定して描画
  $self->render('stash_test', 'name' => $name, age => $age);
};

get '/info' => sub{
    my $self = shift;
    my $app = $self->app;
    my $title = $app->config('title');
    $self->render('info',
        title => $title
    );
};

# リダイレクト
get '/index' => sub {
  my $self = shift;
  $self->redirect_to('/');
};

# post '/post' => sub {
#     my $self = shift;
# }


app->start;

__DATA__

@@ stash_test.html.ep
<%
  #スタッシュから値を取得 javaのjspとおんなじな
  my $name = stash('name');
  my $age = stash('age');
%>
<html>
  <head>
    <title>Stash</title>
  </head>
  <body>
    <h1><%= $name %>:<%= $age %></h1>
  </body>
</html>