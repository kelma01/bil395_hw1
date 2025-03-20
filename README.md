# Lex ve Yacc Kullanarak Hesap Makinesi

Bu hesap makinesi programı, Lex ve Yacc kullanılarak implement edilmiştir. Temel aritmetik işlemleri(toplama, çıkarma, çarpma, bölme) destekler. Çalıştırıldığı andan itibaren sürekli kullanıcıdan giriş olarak bir ifade alır ve işlenebiliyorsa cevabını, işlenemiyor ise hata mesajını döner.

Lex, token'ları tanımlamada kullanıldı.  Bunlar; tamsayılar, operatörler ve parantezlerden oluşmaktadır.
Yacc, Lex'in belirlediği tokenleri parse ederek ifadeleri çözümler. Beraberinde hata yönetimi gibi kontrolleri de bulunmaktadır.

## Çözümü Gerçekleştirme Adımları

Lexical Analiz ile token türlerini tanımladık, aldığı girdiler ile tokenleri üretir, bunu yaparken de boşlukları yok sayar ve bilinmeyen karakterler için hata mesajlarını oluşturur.

Parsing aşamasında Yacc kullanırken girdiler çözümlenir, hata kontrolleri yapılır. Hata durumuna göre sonuç kullanıcıya sunulur.

## Hata Mesajları

1. Sıfıra bölme durumunda "Error: cannot divided by zero" hata mesajı alınır.
2. Girilen expressionda bir syntax hatası durumunda "Error: syntax error" hata mesajı alınır. 
3. Girilen expressionda eğer tokenlerde tanımlanmayan bir karakter var ise "Error: unknown character" hata mesajı alınır.

## Kodu Çalıştırma

```bash
#Aşağıdaki komutlar ile kod compile edilir:
lex calculator.l
yacc -d calculator.y
gcc lex.yy.c y.tab.c -o calculator

#Aşaığdaki komut ile de program çalıştırılır:
./calculator
```