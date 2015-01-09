h  = mojs.helpers

describe 'Helpers ->', ->
  describe 'prefix', ->
    it 'should have prefix', ->
      expect(h.prefix).toBeDefined()
      expect(h.prefix.js).toBeDefined()
      expect(h.prefix.css).toBeDefined()
      expect(h.prefix.lowercase).toBeDefined()
      expect(h.prefix.dom).toBeDefined()
  describe 'browsers detection', ->
    it 'should have browsers flag', ->
      expect(h.isFF).toBeDefined()
      expect(h.isIE).toBeDefined()

  describe 'tween related map ->', ->
    it 'should be a map of tween related options ->', ->
      expect(h.tweenOptionMap.duration)   .toBe 1
      expect(h.tweenOptionMap.delay)      .toBe 1
      expect(h.tweenOptionMap.repeat)     .toBe 1
      expect(h.tweenOptionMap.easing)     .toBe 1
      expect(h.tweenOptionMap.yoyo)       .toBe 1
      expect(h.tweenOptionMap.onStart)    .toBe 1
      expect(h.tweenOptionMap.onComplete) .toBe 1
      expect(h.tweenOptionMap.onUpdate)   .toBe 1
      mapLen = Object.keys(h.tweenOptionMap).length
      expect(mapLen)                      .toBe 8

  describe 'methods ->', ->
    describe 'strToArr method', ->
      it 'should parse string to array',->
        expect(h.strToArr('200 100').join ' ').toBe '200 100'
      it 'should parse number to array',->
        expect(h.strToArr(200).join ' ').toBe '200'
      it 'should parse string with multiple spaces to array',->
        expect(h.strToArr('200   100').join ' ').toBe '200 100'
      it 'should trim string before parse',->
        expect(h.strToArr(' 200   100 ').join ' ').toBe '200 100'
      it 'should return array of numbers',->
        expect(h.strToArr(' 200.5   100 ')[0]).toBe 200.5
      it 'should throw if parsing fails',->
        expect(-> h.strToArr(' 200.5 ,  100 ')).toThrow()
    describe 'normDashArrays method', ->
      it 'should normalize two inconsistent dash arrays', ->
        arr1 = [100, 500]; arr2 = [150, 200, 300.7]
        h.normDashArrays(arr1, arr2)
        expect(arr1.join(' ')).toBe '100 500 0'
      it 'should normalize MODIFY passed arrays', ->
        arr1 = [100]; arr2 = [150, 200, 25]
        h.normDashArrays(arr1, arr2)
        expect(arr1.join(' ')).toBe '100 0 0'
      it 'should normalize two inconsistent dash arrays #2', ->
        arr1 = [100, 500]; arr2 = [150]
        h.normDashArrays(arr1, arr2)
        expect(arr1.join(' ')).toBe '100 500'
      it 'should normalize two inconsistent dash arrays #3', ->
        arr1 = [100]; arr2 = [150, 200, 17.5]
        h.normDashArrays(arr1, arr2)
        expect(arr2.join(' ')).toBe '150 200 17.5'
      it 'should should throw if one arg or nothing was passed', ->
        expect(-> h.normDashArrays([100, 500])).toThrow()
        expect(-> h.normDashArrays()).toThrow()
    describe 'isArray method', ->
      it 'should check if variable is array', ->
        expect(h.isArray []).toBe true
        expect(h.isArray {}).toBe false
        expect(h.isArray '').toBe false
        expect(h.isArray 2).toBe false
        expect(h.isArray NaN).toBe false
        expect(h.isArray null).toBe false
        expect(h.isArray()).toBe false

    describe 'calcArrDelta method', ->
      it 'should should throw if on of the args are not arrays', ->
        expect(-> h.calcArrDelta([200, 300, 100], 'a')).toThrow()
        expect(-> h.calcArrDelta('a', [200, 300, 100])).toThrow()

      it 'should should throw if less then 2 arrays passed', ->
        expect(-> h.calcArrDelta [200, 300, 100]).toThrow()
        expect(-> h.calcArrDelta()).toThrow()
      it 'should calculate delta of two arrays', ->
        arr1 = [200, 300, 100]; arr2 = [250, 150, 0]
        delta = h.calcArrDelta arr1, arr2
        expect(delta.join ' ').toBe '50 -150 -100'
    describe 'getRadialPoint', ->
      it 'should calculate radial point', ->
        point = h.getRadialPoint
          radius: 50
          angle:  90
          center: x: 50, y: 50
        expect(point.x).toBe 100
        expect(point.y).toBe 50
      it 'should return false if 1 of 3 options missed', ->
        point = h.getRadialPoint
          radius: 50
          angle:  90
        expect(point).toBeFalsy()
      it 'should return false only if 1 of 3 options missed but not falsy', ->
        point = h.getRadialPoint
          radius: 0
          angle:  90
          center: x: 0, y: 0
        expect(point).toBeTruthy()
      it 'options should have default empty object', ->
        point = h.getRadialPoint()
        expect(point).toBeFalsy()
        expect(h.getRadialPoint).not.toThrow()

    describe 'capitalize method', ->
      it 'should capitalize strings', ->
        expect(h.capitalize 'hello there').toBe 'Hello there'
      it 'should should throw if bad string was passed', ->
        expect(-> h.capitalize()).toThrow()
      it 'should should not throw with empty strings', ->
        expect(-> h.capitalize('')).not.toThrow()
    describe 'splitEasing method', ->
      it 'should split easing string to array',->
        expect(h.splitEasing('Linear.None')[0]).toBe 'Linear'
        expect(h.splitEasing('Linear.None')[1]).toBe 'None'
      it 'should return default easing Linear.None if argument is bad', ->
        expect(h.splitEasing(4)[0]).toBe 'Linear'
        expect(h.splitEasing(4)[1]).toBe 'None'
      it 'should return default easing Linear.None if argument is bad #2', ->
        expect(h.splitEasing('')[0]).toBe 'Linear'
        expect(h.splitEasing('')[1]).toBe 'None'
      it 'should return default easing Linear.None if argument is bad #3', ->
        expect(h.splitEasing('Linear..None')[0]).toBe 'Linear'
        expect(h.splitEasing('Linear..None')[1]).toBe 'None'
      it 'should work with lovercase easing', ->
        expect(h.splitEasing('linear..none')[0]).toBe 'Linear'
        expect(h.splitEasing('linear..none')[1]).toBe 'None'

      it 'should work with function easing', ->
        easing = -> console.log 'function'
        expect(h.splitEasing(easing)+'').toBe easing+''

    describe 'color parsing - makeColorObj method', ->
      it 'should have shortColors map', ->
        expect(h.shortColors).toBeDefined()
      it 'should have div node', ->
        expect(h.div.tagName.toLowerCase()).toBe 'div'
      it 'should parse 3 hex color', ->
        colorObj = h.makeColorObj '#f0f'
        expect(colorObj.r)  .toBe 255
        expect(colorObj.g)  .toBe 0
        expect(colorObj.b)  .toBe 255
        expect(colorObj.a)  .toBe 1
      it 'should parse 6 hex color', ->
        colorObj = h.makeColorObj '#0000ff'
        expect(colorObj.r)  .toBe 0
        expect(colorObj.g)  .toBe 0
        expect(colorObj.b)  .toBe 255
        expect(colorObj.a)  .toBe 1
      it 'should parse color shorthand', ->
        colorObj = h.makeColorObj 'deeppink'
        expect(colorObj.r)  .toBe 255
        expect(colorObj.g)  .toBe 20
        expect(colorObj.b)  .toBe 147
        expect(colorObj.a)  .toBe 1
      it 'should parse rgb color', ->
        colorObj = h.makeColorObj 'rgb(200,100,0)'
        expect(colorObj.r)  .toBe 200
        expect(colorObj.g)  .toBe 100
        expect(colorObj.b)  .toBe 0
        expect(colorObj.a)  .toBe 1
      it 'should parse rgba color', ->
        colorObj  = h.makeColorObj 'rgba(0,200,100,.1)'
        expect(colorObj.r)  .toBe 0
        expect(colorObj.g)  .toBe 200
        expect(colorObj.b)  .toBe 100
        expect(colorObj.a)  .toBe .1
      it 'should parse rgba color with float starting by 0', ->
        colorObj = h.makeColorObj 'rgba(0,200,100,0.5)'
        expect(colorObj.r)  .toBe 0
        expect(colorObj.g)  .toBe 200
        expect(colorObj.b)  .toBe 100
        expect(colorObj.a)  .toBe .5
    describe 'animation loop ->', ->
      it 'should have TWEEN object', ->
        expect(h.TWEEN).toBeDefined()
      it 'update Tweens on loop', (dfr)->
        spyOn h.TWEEN, 'update'
        tween = new h.TWEEN.Tween({p:0}).to({p:1}, 120)
          .start()
        h.startAnimationLoop()
        setTimeout ->
          expect(h.TWEEN.update).toHaveBeenCalled()
          dfr()
        , 34
      it 'should start animation loop', (dfr)->
        spyOn h, 'animationLoop'
        h.startAnimationLoop()
        setTimeout ->
          expect(h.animationLoop).toHaveBeenCalled()
          dfr()
        , 160
      it 'should stop animation loop', (dfr)->
        h.stopAnimationLoop()
        setTimeout ->
          spyOn h, 'animationLoop'
          setTimeout ->
            expect(h.animationLoop).not.toHaveBeenCalled()
            dfr()
          , 34
        , 20

      it 'should stop itself if there is no tween left', (dfr)->
        tween = new h.TWEEN.Tween({p:0}).to({p:1}, 20)
          .start()
        h.startAnimationLoop()
        setTimeout ->
          spyOn h, 'animationLoop'
          setTimeout ->
            expect(h.animationLoop).not.toHaveBeenCalled()
            dfr()
          , 34
        , 34

      it 'should start only 1 concurrent loop', (dfr)->
        h.stopAnimationLoop()
        setTimeout ->
          spyOn h, 'animationLoop'
          h.isAnimateLoop = true
          h.startAnimationLoop()
          setTimeout ->
            expect(h.animationLoop).not.toHaveBeenCalled()
            h.isAnimateLoop = false
            dfr()
          , 34
        , 34






