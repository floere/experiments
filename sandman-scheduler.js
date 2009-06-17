// Sandman schedules sleeping callbacks.
//
function Sandman() {
  
  // Saves the callbacks in the form:
  // remaining_time => [callback, callback, …]
  //
  var schedule = {};
  
  // Saves the callback to be executed in duration ticks.
  //
  // Sandman.sleep(10, function() {
  //   // code to be executed in 10 ticks.
  // });
  //
  this.sleep = function(duration, callback) {
    var callbacks = schedule[duration];
    if (callbacks) {
      // we already have an array of callbacks at that remaining time, append.
      callbacks[callbacks.length] = callback;
    } else {
      // we do not already have an array of callbacks. Thus initialize one.
      schedule[duration] = [callback];
    };
  };
  
  // Advances one tick.
  // If there are callbacks with zero time remaining, call them all.
  //
  // Sandman.tick();
  //
  // Note: Only use this method directly if you control the "main loop", i.e. in games.
  //
  this.tick = function() {
    var newSchedule = {};
    for (var key in schedule.items) {
      if (key == 0) {
        for(var callback in schedule.items[0]) {
          // execute the callback
          callback();
        }
      } else {
        // reduce the key by one
        newSchedule[key-1] = schedule.items[key];
      };
    }
    schedule = newSchedule;
  };
  
  // Wake the Sandman, let him sprinkle sand.
  // Starts the scheduling process.
  //
  // Note: This only works in a browser with setTimeout.
  //
  this.sand = function() {
    
  };
  
  // Let the Sandman vanish.
  //
  // Note: This only works in a browser with setTimeout.
  //
  this.vanish = function() {
    
  };
  
}