class PlayController{

  bool isplaying = false;


  double? tamanhoTela = 300;


  void Click() {

    isplaying = !isplaying;

  }


  double RetornaTamanhaContainer()
  {
    var resultado;
    if(isplaying) {
      resultado =   0.54;
    }
    else {
      resultado =   0.8;
    }
    return resultado;
  }
}