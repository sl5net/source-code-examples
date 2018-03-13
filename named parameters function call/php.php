// from https://philsturgeon.uk/php/2013/09/01/named-parameters-in-php/
<?php
function getFriends($args) {
    $args += [ # set default values
    	'user_id' => null,
    	'screen_name' => null,
    	'cursor' => -1,
    	'skip_status' => false,
    	'include_user_entities' => false,
    ];
    extract($args);
    echo "<pre>
        user_id = $user_id,
    	screen_name = $screen_name,
    	cursor = $cursor,
    	skip_status=$skip_status = false,
    	include_user_entities = $include_user_entities,
\n";
}
getFriends(['screen_name' => 'phpdrama', 'include_user_entities' => true]);