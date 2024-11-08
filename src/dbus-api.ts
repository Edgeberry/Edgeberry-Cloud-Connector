/*
 *  Edgeberry Cloud Connector D-Bus API
 *
 */

var dbus = require('dbus-native');      // No TypeScript implementation (!)

const serviceName = 'io.edgeberry.CloudConnect';
const objectPath = '/io/edgeberry/CloudConnect';
const interfaceName = 'io.edgeberry.CloudConnect';

// Connect to the session bus
const systemBus = dbus.systemBus();

if(systemBus)
    console.log('\x1b[32mD-Bus client connected to system bus\x1b[30m');
else
    console.log('\x1b[31mD-Bus client could not connect to system bus\x1b[30m');

// Request a unique service name (io.edgeberry.Service)
systemBus.requestName(serviceName,0, (err:string|null, res:number|null)=>{
    if(err)
        return console.log('\x1b[31mD-Bus service name aquisition failed: '+err+'\x1b[30m');
    else if( res )
        return console.log('\x1b[32mD-Bus service name "'+serviceName+'" successfully aquired \x1b[30m');
});

// Create the service object
const serviceObject = {
    Message:(arg:string)=>{
        try{
            console.log("TODO: send to the cloud: "+arg);
            return 'ok';
        }
        catch(err){
            return 'err';
        }
    }
}

// Register the service object
systemBus.exportInterface( serviceObject, objectPath, {
    name: interfaceName,
    methods: {
        Message:['s','s']
    },
    signals: {}
});


