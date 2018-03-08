
fun displayBorder(character: Char = '=', length: Int = 15) {
    for (i in 1..length) {
        print(character)
    }
}

fun main(args: Array<String>) {
    displayBorder(length = 5)
}
/ * When you run the program, the output will be:
=====
*/