% use deconvwnr, works for 1d, 2d, 3d deconvolutions
clear all, close all
x = [   0.098263311710790
   0.155086096032043
   0.003563918067142
  -0.142277058498506
  -0.060039279117941
  -0.091320076323080
   0.030386872523723
  -0.043766105015552
  -0.123705660084458
   0.187629044487822
   0.079133516622346
   0.037111040920547
  -0.141566383042019
  -0.046375795448581
   0.109295028159200
   0.120654940162629
   0.186386569721647
   0.162531270341950
  -0.061206631955036
  -0.015257150990370
   0.119290360838009
  -0.129615351304963
   0.168522254115479
   0.084663066659657
  -0.056277021780119
  -0.134671531317269
   0.108395504571773
   0.012039714570464
   0.113579038923762
  -0.040763559329454
   0.134390000411704
  -0.104578807051270
   0.108775527600729
  -0.083032407805212
  -0.055300718818091
   0.157048167335985
  -0.019599711667343
   0.010609044373695
  -0.116229893607181
   0.148744659541668
  -0.001648955781333
  -0.053927575173996
  -0.026332382283927
  -0.066060375512395
  -0.006014059059689
  -0.036329463782656
   0.008309994433622
   0.159909062920561
   0.042334424458067
  -0.081353884288030
   0.001792722982642
  -0.080188202885320
  -0.006680655086223
   0.068418653573541
  -0.122340303970450
   0.153974645567535
  -0.110202529061134
   0.063259098929874
   0.137226350706288
  -0.064377973200670
   0.054599765090449
  -0.061179941832527
  -0.147328204384417
  -0.058266644603340
   0.153738120621827
   0.134182697688856
   0.001384776322530
  -0.080471511663260
   0.011062619420080
  -0.088637997385342
  -0.107363086024531
  -0.127604485191839
   0.107612743257083
   0.000789075565351
   0.083684022371855
  -0.090785881771763
  -0.049297960893633
   0.091069693132215
  -0.006323349388948
  -0.145896854021327
   0.014357772299002
   0.014480952983261
  -0.131602007090655
  -0.050899106398505
  -0.081846003918602
  -0.060701465148298
  -0.018066096983226
   0.050228488441916
   0.051921884722301
  -0.003902371047799
   0.118848959416922
   0.100020120644191
  -0.044264199033908
  -0.133861128610631
   0.018755229676438
  -0.131682913279072
   0.118184304213229
  -0.071133170218481
   0.157490883313337
  -0.214330715666752
  -0.060983698210547
  -0.164550788389335
  -0.144251542431746
  -0.019212034924488
  -0.144013221478376
  -0.302176594509617
  -0.216473834302829
  -0.474441662722855
  -0.705214512016837
  -0.968952367605199
  -1.049993465183099
  -1.268374250813187
  -1.692009695112123
  -1.858233163092756
  -2.565048413622313
  -2.779715221466290
  -3.139589955408326
  -3.603471583333582
  -3.860089153943386
  -4.331961456267813
  -4.620589098863282
  -4.890430604593051
  -5.029710543818761
  -5.242831197100556
  -5.331494269971579
  -5.345118164616452
  -5.221646573707658
  -5.345354869462463
  -5.275981525024401
  -4.825883664303867
  -4.580679893721660
  -4.317483709290519
  -3.843738802390995
  -3.710741284842587
  -3.363319595570772
  -2.919817190872362
  -2.665192769801232
  -2.575027240008936
  -2.373960718953435
  -2.322518191104443
  -2.259494952070525
  -2.493270415065255
  -2.903416260723529
  -3.214183526481981
  -3.883443567712129
  -4.137142012733578
  -4.640917859100026
  -4.634448726618548
  -4.576186522402135
  -4.206161090586365
  -3.976236304155781
  -3.504701523585808
  -3.270457746631750
  -3.108612361283680
  -2.543810489944718
  -2.351868235886820
  -2.059558497451079
  -2.251497343937831
  -2.023147124599753
  -1.950976589758546
  -2.193858971083136
  -2.363688245994263
  -2.638198558386976
  -2.664045260360775
  -3.202860328815922
  -3.413089192915168
  -3.793053816323447
  -4.022392529391253
  -4.409608017886703
  -4.962579606263503
  -5.228531249733377
  -5.272436567253120
  -5.431179767240861
  -5.421493426727842
  -5.727488846098166
  -5.790874794386989
  -5.641834802149429
  -5.468121497473788
  -5.256588237462545
  -5.040001044649641
  -4.889468202505808
  -4.694386544359817
  -4.256625760723712
  -3.973822242806325
  -3.701805106988455
  -3.403008002731071
  -3.112369266154950
  -2.637594497671463
  -2.689301635905300
  -2.279064260318801
  -2.064386726438237
  -1.770207013192840
  -1.486750649966708
  -1.589412086437092
  -1.581945795040408
  -1.086797343114209
  -1.193977150916786
  -0.971746215425960
  -0.829851217887881
  -0.680910920283051
  -0.764032783171621
  -0.662571285911875
  -0.827217627425498
  -0.639277753253637
  -0.484779839098724
  -0.462955912757403
  -0.136179055552786
  -0.373461778582128
  -0.268155850811236
  -0.158868463590942
  -0.273252773282949
  -0.287274455230438
  -0.179757611546990
  -0.358801920393151
  -0.170736577543796
  -0.330962011958336
  -0.190048268328415
  -0.135716243527283
  -0.118233122001346
  -0.155402003771532
  -0.178534637953541
  -0.253214856610817
  -0.102992037001199
  -0.158033690198317
   0.003016996955872
   0.063930251533552
  -0.191211949210974
   0.149144415171656
  -0.003658423789215
  -0.044995913061462
  -0.103134011104949
  -0.118458026439154
  -0.037366285290752
   0.041093317623190
  -0.044784415972030
  -0.079167155396102
  -0.010986736861578
  -0.083963909392231
  -0.150064225265535
  -0.042334878035868
   0.073611699348253
  -0.047329703740911
   0.090735648395765
  -0.009625396678661
   0.233314857816871
  -0.012792871843151
   0.055217975877701
  -0.085090689256690
  -0.021939879546339
  -0.050253122021857
  -0.057775846385608
   0.073080312953845
  -0.061716634824908
  -0.058703062346151
   0.064590760890808
   0.047317894912633
  -0.000855854266577
   0.172580681536166
   0.112290161345780
  -0.032571198572429
  -0.061975795328289
   0.005832406797995
   0.022521216265123
  -0.037840889108099
   0.095390678017873
  -0.078978516637576
  -0.048674854345694
  -0.238511491695110
   0.033339817719069
   0.193231483195820
  -0.049042411125015
   0.197939516845040
  -0.104190147311718
   0.043774416092104
   0.107227093634428
   0.001857091685641
  -0.045967672696546
   0.007592092882868
  -0.151617797672775
   0.234135714150821
   0.089056124707562
  -0.020096382604586
   0.138393147134112
   0.161465985105306
  -0.033013075994373
  -0.086016951143329
  -0.006942986387878
   0.248521006852585
   0.212115856269528];

t = [
   0.000074534161491
   0.000157349896480
   0.000240165631470
   0.000322981366460
   0.000405797101449
   0.000488612836439
   0.000571428571429
   0.000654244306418
   0.000737060041408
   0.000819875776398
   0.000902691511387
   0.000985507246377
   0.001068322981366
   0.001151138716356
   0.001233954451346
   0.001316770186335
   0.001399585921325
   0.001482401656315
   0.001565217391304
   0.001648033126294
   0.001730848861284
   0.001813664596273
   0.001896480331263
   0.001979296066253
   0.002062111801242
   0.002144927536232
   0.002227743271222
   0.002310559006211
   0.002393374741201
   0.002476190476190
   0.002559006211180
   0.002641821946170
   0.002724637681159
   0.002807453416149
   0.002890269151139
   0.002973084886128
   0.003055900621118
   0.003138716356108
   0.003221532091097
   0.003304347826087
   0.003387163561077
   0.003469979296066
   0.003552795031056
   0.003635610766046
   0.003718426501035
   0.003801242236025
   0.003884057971014
   0.003966873706004
   0.004049689440994
   0.004132505175983
   0.004215320910973
   0.004298136645963
   0.004380952380952
   0.004463768115942
   0.004546583850932
   0.004629399585921
   0.004712215320911
   0.004795031055901
   0.004877846790890
   0.004960662525880
   0.005043478260870
   0.005126293995859
   0.005209109730849
   0.005291925465839
   0.005374741200828
   0.005457556935818
   0.005540372670807
   0.005623188405797
   0.005706004140787
   0.005788819875776
   0.005871635610766
   0.005954451345756
   0.006037267080745
   0.006120082815735
   0.006202898550725
   0.006285714285714
   0.006368530020704
   0.006451345755694
   0.006534161490683
   0.006616977225673
   0.006699792960663
   0.006782608695652
   0.006865424430642
   0.006948240165631
   0.007031055900621
   0.007113871635611
   0.007196687370600
   0.007279503105590
   0.007362318840580
   0.007445134575569
   0.007527950310559
   0.007610766045549
   0.007693581780538
   0.007776397515528
   0.007859213250518
   0.007942028985507
   0.008024844720497
   0.008107660455487
   0.008190476190476
   0.008273291925466
   0.008356107660455
   0.008438923395445
   0.008521739130435
   0.008604554865424
   0.008687370600414
   0.008770186335404
   0.008853002070393
   0.008935817805383
   0.009018633540373
   0.009101449275362
   0.009184265010352
   0.009267080745342
   0.009349896480331
   0.009432712215321
   0.009515527950311
   0.009598343685300
   0.009681159420290
   0.009763975155280
   0.009846790890269
   0.009929606625259
   0.010012422360248
   0.010095238095238
   0.010178053830228
   0.010260869565217
   0.010343685300207
   0.010426501035197
   0.010509316770186
   0.010592132505176
   0.010674948240166
   0.010757763975155
   0.010840579710145
   0.010923395445135
   0.011006211180124
   0.011089026915114
   0.011171842650104
   0.011254658385093
   0.011337474120083
   0.011420289855072
   0.011503105590062
   0.011585921325052
   0.011668737060041
   0.011751552795031
   0.011834368530021
   0.011917184265010
   0.012000000000000
   0.012082815734990
   0.012165631469979
   0.012248447204969
   0.012331262939959
   0.012414078674948
   0.012496894409938
   0.012579710144928
   0.012662525879917
   0.012745341614907
   0.012828157349896
   0.012910973084886
   0.012993788819876
   0.013076604554865
   0.013159420289855
   0.013242236024845
   0.013325051759834
   0.013407867494824
   0.013490683229814
   0.013573498964803
   0.013656314699793
   0.013739130434783
   0.013821946169772
   0.013904761904762
   0.013987577639752
   0.014070393374741
   0.014153209109731
   0.014236024844720
   0.014318840579710
   0.014401656314700
   0.014484472049689
   0.014567287784679
   0.014650103519669
   0.014732919254658
   0.014815734989648
   0.014898550724638
   0.014981366459627
   0.015064182194617
   0.015146997929607
   0.015229813664596
   0.015312629399586
   0.015395445134576
   0.015478260869565
   0.015561076604555
   0.015643892339545
   0.015726708074534
   0.015809523809524
   0.015892339544513
   0.015975155279503
   0.016057971014493
   0.016140786749482
   0.016223602484472
   0.016306418219462
   0.016389233954451
   0.016472049689441
   0.016554865424431
   0.016637681159420
   0.016720496894410
   0.016803312629400
   0.016886128364389
   0.016968944099379
   0.017051759834369
   0.017134575569358
   0.017217391304348
   0.017300207039337
   0.017383022774327
   0.017465838509317
   0.017548654244306
   0.017631469979296
   0.017714285714286
   0.017797101449275
   0.017879917184265
   0.017962732919255
   0.018045548654244
   0.018128364389234
   0.018211180124224
   0.018293995859213
   0.018376811594203
   0.018459627329193
   0.018542443064182
   0.018625258799172
   0.018708074534161
   0.018790890269151
   0.018873706004141
   0.018956521739130
   0.019039337474120
   0.019122153209110
   0.019204968944099
   0.019287784679089
   0.019370600414079
   0.019453416149068
   0.019536231884058
   0.019619047619048
   0.019701863354037
   0.019784679089027
   0.019867494824017
   0.019950310559006
   0.020033126293996
   0.020115942028986
   0.020198757763975
   0.020281573498965
   0.020364389233954
   0.020447204968944
   0.020530020703934
   0.020612836438923
   0.020695652173913
   0.020778467908903
   0.020861283643892
   0.020944099378882
   0.021026915113872
   0.021109730848861
   0.021192546583851
   0.021275362318841
   0.021358178053830
   0.021440993788820
   0.021523809523810
   0.021606625258799
   0.021689440993789
   0.021772256728778
   0.021855072463768
   0.021937888198758
   0.022020703933747
   0.022103519668737
   0.022186335403727
   0.022269151138716
   0.022351966873706
   0.022434782608696
   0.022517598343685
   0.022600414078675
   0.022683229813665
   0.022766045548654
   0.022848861283644
   0.022931677018634
   0.023014492753623
   0.023097308488613
   0.023180124223602
   0.023262939958592
   0.023345755693582
   0.023428571428571
   0.023511387163561
   0.023594202898551
   0.023677018633540
   0.023759834368530
   0.023842650103520
   0.023925465838509
];

bandwidth = 200;
order = 1; 
s = tf('s');
H = 1/(2*pi*bandwidth)*1/(s/(2*pi*bandwidth)+1);
psf = 0.1*impulse(H, t);
deblur = deconvwnr(x, psf, 0);
split_ind = floor(length(deblur)/2);
deblur = [deblur((split_ind+1): end); deblur(1:split_ind)];

filt_bandwidth = 500; 
G_filt = 1/(s/(2*pi*filt_bandwidth)+1);
deblur_filt = lsim(deblur, G_filt, t);
  
figure
subplot(3, 1, 1)
plot(t, psf)

subplot(3,1,2)
plot(t,x)

subplot(3,1,3)
plot(t,deblur)
hold on
plot(t, deblur_filt, 'r')
