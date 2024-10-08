import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';

part 'login.store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  @observable
  bool isFacebookLoading = false;

  @observable
  bool isGoogleLoading = false;

  @action
  Future<UserCredential> signInWithGoogle() async {
    isGoogleLoading = true;
    //Abre a página de do Google para realizar o login (ou selecionar a conta)
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //Obtem os dados autenticado do usuário no google
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    //Criar uma credencial para o firebase fazer o login
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    //Envia a credencial para o firebase fazer o login
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    isGoogleLoading = false;
    return userCredential;
  }

  @action
  Future<UserCredential> signInWithFacebook() async {
    isFacebookLoading = true;
    // Abre a página de do Facebook para realizar o login (ou selecionar a conta)
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Cria uma credencial com os dados autenticados do Facebook
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    //Envia a credencial para o firebase fazer o login
    final userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    isFacebookLoading = false;
    return userCredential;
  }
}
