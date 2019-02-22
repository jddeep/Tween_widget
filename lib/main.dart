import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(dscApp());

class dscApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Flippercard(),
    );
  }
}

class Flippercard extends StatefulWidget {
  @override
  _FlippercardState createState() => _FlippercardState();
}

class _FlippercardState extends State<Flippercard> 
  with SingleTickerProviderStateMixin{
  
  bool flipped = false;
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState(){
    super.initState();
    _controller =AnimationController(vsync: this, duration: Duration(seconds: 1)
    );

    _animation =TweenSequence([
      TweenSequenceItem(tween: Tween(
        begin: 0.0,
        end: -pi/2
      ),
      weight: 0.5
      ),
        TweenSequenceItem(tween: Tween(
        begin: pi/2,
        end: 0.0
      ),
      weight: 0.5
      ),

    ]).animate(_controller);
  }

  _letsAnimate() {
    if(!mounted) return;
    if(flipped){
      _controller.reverse();
      flipped=false;
    }else{
      _controller.forward();
      flipped =true;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> cards = List();
    for(int i=0;i<5;i++){
        cards.add(Animatedcards());
    }
    return Scaffold(
      
      appBar: AppBar(
        title: Text("DSCApp"),
        centerTitle: true,
      ),
      // body: ListView(
      //   scrollDirection: Axis.vertical,
      //   children: cards,
      // ),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (BuildContext context, int index){
          return cards[index];
        },
      ),
    );
  }

  Widget Animatedcards(){
      return Container(
        padding: EdgeInsets.only(top: 8.0),
        child: AnimatedBuilder(
        animation: _animation,
              builder: (context, child) => Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_animation.value),          
              child: GestureDetector(
                onTap: _letsAnimate,
                
                child: IndexedStack(
                  
                  children: <Widget>[
                    CardOne(),
                    CardTwo()
                  ],
                  alignment: Alignment.center,
                  index: _controller.value<0.5?0:1,
                ),
              ),
            ),
    ),
      );
  }
}
class CardOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
            return Card(
                   color: Colors.red,
                    child: Container(
                      width: 300.0,
                      height: 300.0,
                      child:Center(
                      child: Text("DSC...", 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                      ),
                    ),
    );
  }
}
class CardTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
                        color: Colors.green,
                    child: Container(
                      width: 300.0,
                      height: 300.0,
                      child:Center(
                      child: Text("ROCKS!!!", 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                      ),
                    ),
    );
  }
}