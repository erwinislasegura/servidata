<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Twilio\Rest\Client;
class MensajeController extends Controller
{
    public function sendMessage(Request $request)
    {
        $request->validate([
            'to' => 'required|string',
            'message' => 'required|string',
        ]);

        $sid = env('TWILIO_SID');
        $token = env('TWILIO_AUTH_TOKEN');
        $from = env('TWILIO_WHATSAPP_FROM');

        try {
            $client = new Client($sid, $token);

            $message = $client->messages->create(
                "whatsapp:" . $request->input('to'), // Número de destino
                [
                    'from' => $from,
                    'body' => $request->input('message'),
                ]
            );

            return response()->json([
                'success' => true,
                'message' => 'Mensaje enviado correctamente.',
                'sid' => $message->sid,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ], 500);
        }
    }
    public function msg()
    {
        // Update the path below to your autoload.php,
        // see https://getcomposer.org/doc/01-basic-usage.md
        require_once './vendor/autoload.php';
        // require_once __DIR__ . '/vendor/autoload.php';
        // use Twilio\Rest\Client;

        $sid = "AC430b670cf68ce4c1eab8327af546e31d";
        $token = "fc994f119bbeb1e56743be6c81226dff";
        $twilio = new Client($sid, $token);

        $message = $twilio->messages
            ->create(
                "whatsapp:+51935667172", // to
                array(
                    "from" => "whatsapp:+14155238886",
                    "contentSid" => "HXb5b62575e6e4ff6129ad7c8efe1f983e",
                    "contentVariables" => json_encode(["1" => "12/1", "2" => "3pm"]),

                    "body" => "Your Message"
                )
            );

        print ($message->sid);
    }
}