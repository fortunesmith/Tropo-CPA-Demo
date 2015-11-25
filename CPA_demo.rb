def ask_vm (user)
	ask "Press one at any time to hear your message, or stand by and it will begin momentarily", {
		:timeout => 2,
		:choices => "1",
		:mode => "dtmf",
		:voice => "Tom",
		:onChoice => lambda {|event|
			user = "HUMAN"
			human_answer(user) },
		:onTimeout => lambda {|event|
			beep_listen()
			vm_answer(user) }}
end

def beep_listen ()
	record ".", {
		:beep => false,
		:timeout => 1,
		:silenceTimeout => 1,
		:maxTime => 15,
		:terminator => "#" }
end

def human_answer (user)
	log "value returned from the machine detection  ==  " + user
	say $message , {:voice => "Tom"}
	ask "to opt out of future reminders, please press 1", {
		:choices => "1",
		:mode => "dtmf",
		:voice => "Tom" }
	say "Thank you, good bye" , {:voice => "Tom"}
end


def vm_answer (user)
	log "value returned from the machine detection  ==  " + user
	say $message , {:voice => "Tom"}
end

 
call $numberToDial , {        
	:callerID => "14072420001",
	:timeout => 60,Tom
	:machineDetection => {"introduction" => "Hello...", "voice" => "Tom" },
	:onAnswer => lambda {|event|	
		if event.value.userType.nil?
			log "This was NIL   "
			user = "MACHINE"
		else
			user = event.value.userType
		end
		if user == "HUMAN"
			human_answer(user)
		else
			ask_vm(user)
		end	}}


hangup					
