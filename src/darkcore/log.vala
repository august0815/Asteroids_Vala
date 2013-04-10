namespace Darkcore { class Log : Object {
    public static void write (string txt) {
        try {
            var file = File.new_for_path ("log.txt");

            {
                var file_stream = file.create (FileCreateFlags.NONE);

                if (file.query_exists ()) {
                    var data_stream = new DataOutputStream (file_stream);
                    data_stream.put_string (txt + "\n");
                }
            }
        } catch (Error e) {
            // Just do nothing
        }

        print(txt + "\n");
    }
}}
