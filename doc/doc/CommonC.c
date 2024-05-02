/**
 * \defgroup keywords Schlüsselwörter
 * @{
 * \cond german
 * \brief C / C++ Schlüsselwörter
 *        eine keiner meiner
 * \endcond
 */

/**
 * \defgroup keywords_ccpp für C
 * @{
 * \cond german
 * \brief C und C++
 *        eine keiner meiner
 * \endcond
 */
struct auto         {};
struct char         {};
struct register     {};
struct return       {};
struct struct       {};
struct typedef      {};
struct void         {};

/**
 * \defgroup keywords_loops Schleifen
 * @{
 * \cond german
 * \brief Schleifen
 * \endcond
 */
/**
 * \defgroup keywords_loops_ctrl Kontrolle
 * @{
 * \cond german
 * \brief Schleifen Kontrolle
 * \endcond
 */
struct break        {};
struct continue     {};
/**
 * @}   <!-- keyords_loops_ctrl -->
 */

struct do           {};
struct for          {};
struct while        {};
/**
 * @}   <!-- keyords_loops -->
 */

/**
 * \defgroup keywords_conditions Bedingungen
 * @{
 * \cond german
 * \brief Bedingungen
 * \endcond
 */
struct case         {};
struct else         {};
struct if           {};
struct switch       {};
/**
 * @}   <!-- keyords_condiions -->
 */

/**
 * \defgroup keywords_arith arithmetisch
 * @{
 * \cond german
 * \brief arithmetische
 * \endcond
 */
struct double       {};
struct float        {};
struct int          {};
struct short        {};
struct signed       {};
struct unsigned     {};
/**
 * @}   <!-- keyords_arithm -->
 */
/**
 * @}   <!-- keyords_ccpp -->
 */

/**
 * \defgroup keywords_cpp nur C++
 * @{
 * \cond german
 * \brief nur für C++
 * \endcond
 */
/**
 * \brief In C++ sind Klassen eine der grundlegenden Bausteine der objektorientierten Programmierung (OOP).
 *        Eine Klasse ist eine Vorlage oder ein Bauplan, der beschreibt, wie ein Objekt erstellt werden soll.
 *        Sie definiert die Daten (Attribute) und Operationen (Methoden), die ein Objekt haben wird.
 *
 * \detail
 * Hier sind einige wichtige Merkmale von Klassen in C++:
 *
 * 1. Datenkapselung: Klassen ermöglichen es, Daten und Methoden zu kapseln, so dass sie zusammengefasst
 *    und als Einheit behandelt werden können. Durch den Zugriff über Schnittstellen (Methoden) können
 *    Klassen die Daten vor unbeabsichtigten Änderungen schützen.
 *
 * 2. Abstraktion: Klassen ermöglichen die Abstraktion von Daten und Verhalten. Sie erlauben es, komplexe
 *    Konzepte zu modellieren, indem sie nur relevante Details zeigen und unnötige Komplexität verbergen.
 *
 * 3. Vererbung: Vererbung ermöglicht es, Eigenschaften und Verhalten von einer Klasse auf eine andere zu
 *    übertragen. Durch die Vererbung können neue Klassen erstellt werden, die auf bestehenden Klassen basieren,
 *    und dadurch können Code-Wiederverwendung und -Erweiterbarkeit erreicht werden.
 *
 * 4. Polymorphismus: Polymorphismus ermöglicht es, Objekte verschiedener Klassen über eine gemeinsame Schnittstelle
 *    zu behandeln. Dies bedeutet, dass verschiedene Klassen Objekte auf unterschiedliche Weise implementieren
 *    können, aber trotzdem über die gleichen Methoden aufgerufen werden können.
 *
 * Hier ist ein einfaches Beispiel für eine Klasse in C++, die eine Person repräsentiert:
 *
 * \code{.cpp}
 * #include <string>
 *
 * class Person {
 * private:
 *     std::string name;
 *     int age;
 *
 * public:
 *     // Konstruktor
 *     Person(std::string n, int a) : name(n), age(a) {}
 *
 *     // Methoden zum Lesen der Attribute
 *     std::string getName() const { return name; }
 *     int getAge() const { return age; }
 *
 *     // Methode zum Ändern des Namens
 *     void setName(std::string newName) { name = newName; }
 *
 *     // Methode zum Ändern des Alters
 *     void setAge(int newAge) { age = newAge; }
 * };
 * \endcode
 *
 * In diesem Beispiel definiert die Klasse Person Daten (Attribut name und age) und Methoden (getName(),
 * getAge(), setName(), setAge()), um auf diese Daten zuzugreifen und sie zu verändern. Damit ist die
 * Klasse Person eine Vorlage, die beschreibt, wie ein Objekt einer Person aussehen und wie es manipuliert
 * werden kann.
 */
struct class        {};
struct friend       {};

struct private      {};
struct protected    {};
struct public       {};

struct template     {};
/**
 * @}   <!-- keywords c++ -->
 */

/**
 * \defgroup keywords_operatoren Operatoren
 * @{
 * \cond german
 * \brief Operatoren von C++
 *        eine keiner meiner
 * \endcond
 */
cc operator == (int test) const;
cc operator <= (int test) const;
cc operator >= (int test) const;
cc operator != (int test) const;
cc operator << (int test) const;
cc operator >> (int test) const;
/**
 * @}   <!-- keyords_operatoren -->
 */

/**
 * @}   <!-- keyords -->
 */
