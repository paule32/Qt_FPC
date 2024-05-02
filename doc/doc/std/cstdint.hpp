/**
 * \file      cstdint.hpp
 * \namespace std
 * \cond german
 * \brief Der STL (Standard Template Library) std Namensbereich.
 * \endcond
 */
namespace std {
/**
 * \cond german
 * \defgroup datatypes Datentypen
 * @{
 * \brief Es gibt zwei Arten von Integer (Ganzzahl-Objekte) in C/C++.
 *        Einmal die Objekte mit Vorzeichen - worunter man die negativen wie auch die positive Objekte
 *        zusammen fassen kann, und einmal die Objekte ohne Vorzeichen, worunter man nur die positiven
 *        Objekte zählen.
 *
 *        Im Diagramm können Sie sehen, wie man die Integer Datentypen aufteilen könnte:
 *        \dotimg{datentypen.png}{\ref datatypes}{\ref datatypes_unsigned}{\ref datatypes_signed}
 *        Klicken Sie mit der Maus auf eine Box, um nähere Informationen anzuzeigen.
 * \endcond
 */
/**
 * \cond german
 * \defgroup datatypes_signed mit Vorzeichen
 * @{
 * \brief Eine Auflistung der in der STL verfügbaren Integer-Datentypen mit Vorzeichen
 * \name Beschreibung für std::int8_t:
 * @{
 * \typedef int8_t
 * \brief int8_t ist ein vorzeichenbelasteter Ganzzahl-Typ, der genau 8 Bits breit ist.
 *        Er wird in der Regel in der Headerdatei
 *        \fcolor{cyan}{\<cstdint\>} definiert, die Teil der
 *        C/C++ Standardbibliothek ist.
 *
 *        Die genaue Definition von int8_t variiert je nach Platform und Compiler.
 *        In der Regel wird es jedoch als Alias für einen vorzeichenlosen 8-Bit
 *        Ganzzahl-Typ definiert.
 *
 *        Eine typische Definition in der Headerdatei \fcolor{cyan}{\<cstdint\>} könnte wie folgt
 *        aussehen:
 * \code{.cpp}
 * typedef signed char int8_t;
 * \endcode
 * \see uint8_t
 * @}
 * \endcond
 */
typedef signed char int8_t;
/**
 * \cond german
 * \name Beschreibung für std::int16_t:
 * @{
 * \typedef int16_t
 * \brief int16_t ist ein vorzeichenbehafteter Ganzzahl-Typ, der genau 16 Bits breit ist.
 *        Er wird in der Regel in der Headerdatei \fcolor{cyan}{\<cstdint\>} definiert, die Teil der
 *        C/C++ Standardbibliothek ist.
 *
 *        Die genaue Definition von int16_t variiert je nach Platform und Compiler.
 *        In der Regel wird es jedoch als Alias für einen vorzeichenbelasteter 16-Bit
 *        Ganzzahl-Typ definiert.
 *
 *        Eine typische Definition in der Headerdatei \fcolor{cyan}{\<cstdint\>} könnte wie folgt
 *        aussehen:
 * \code{.cpp}
 * typedef signed short int16_t;
 * \endcode
 * \see uint16_t
 * @}
 * \endcond
 */
typedef signed short int16_t;
/**
 * \cond german
 * \name Beschreibung für std::int32_t:
 * @{
 * \typedef int32_t
 * \brief int32_t ist ein vorzeichenbehafteter Ganzzahl-Typ, der genau 32 Bits breit ist.
 *        Er wird in der Regel in der Headerdatei \fcolor{cyan}{\<cstdint\>} definiert, die Teil der
 *        C/C++ Standardbibliothek ist.
 *
 *        Die genaue Definition von int32_t variiert je nach Platform und Compiler.
 *        In der Regel wird es jedoch als Alias für einen vorzeichenbehafteten 32-Bit
 *        Ganzzahl-Typ definiert.
 *
 *        Eine typische Definition in der Headerdatei \fcolor{cyan}{\<cstdint\>} könnte wie folgt
 *        aussehen:
 * \code{.cpp}
 * typedef signed int int32_t;
 * \endcode
 * \see uint32_t
 * @}
 * \endcond
 */
typedef signed int int32_t;
/**
 * @}  <!-- datatypes_signed -->
 */

/**
 * \cond german
 * \defgroup datatypes_unsigned ohne Vorzeichen
 * @{
 * \brief Eine Auflistung der in der STL verfügbaren Integer-Datentypen ohne Vorzeichen
 * \name Beschreibung für std::uint8_t:
 * @{
 * \typedef uint8_t
 * \brief uint8_t ist ein vorzeichenloser Ganzzahl-Typ, der genau 8 Bits breit ist.
 *        Er wird in der Regel in der Headerdatei \fcolor{cyan}{\<cstdint\>} definiert, die Teil der
 *        C/C++ Standardbibliothek ist.
 *
 *        Die genaue Definition von int8_t variiert je nach Platform und Compiler.
 *        In der Regel wird es jedoch als Alias für einen vorzeichenlosen 8-Bit
 *        Ganzzahl-Typ definiert.
 *
 *        Eine typische Definition in der Headerdatei \fcolor{cyan}{\<cstdint\>} könnte wie folgt
 *        aussehen:
 * \code{.cpp}
 * typedef unsigned char uint8_t;
 * \endcode
 * \see int8_t
 * @}
 * \endcond
 */
typedef unsigned char uint8_t;
/**
 * \cond german
 * \name Beschreibung für std::uint16_t:
 * @{
 * \typedef uint16_t
 * \brief uint16_t ist ein vorzeichenloser Ganzzahl-Typ, der genau 16 Bits breit ist.
 *        Er wird in der Regel in der Headerdatei \fcolor{cyan}{\<cstdint\>} definiert, die Teil der
 *        C/C++ Standardbibliothek ist.
 *
 *        Die genaue Definition von uint16_t variiert je nach Platform und Compiler.
 *        In der Regel wird es jedoch als Alias für einen vorzeichenlosen 16-Bit
 *        Ganzzahl-Typ definiert.
 *
 *        Eine typische Definition in der Headerdatei \fcolor{cyan}{\<cstdint\>} könnte wie folgt
 *        aussehen:
 * \code{.cpp}
 * typedef unsigned short uint16_t;
 * \endcode
 * \see int16_t
 * @}
 * \endcond
 */
typedef unsigned short uint16_t;

/**
 * \cond german
 * \name Beschreibung für std::uint32_t:
 * @{
 * \typedef uint32_t
 * \brief uint32_t ist ein vorzeichenloser Ganzzahl-Typ, der genau 32 Bits breit ist.
 *        Er wird in der Regel in der Headerdatei \fcolor{cyan}{\<cstdint\>} definiert, die Teil der
 *        C/C++ Standardbibliothek ist.
 *
 *        Die genaue Definition von uint32_t variiert je nach Platform und Compiler.
 *        In der Regel wird es jedoch als Alias für einen vorzeichenlosen 32-Bit
 *        Ganzzahl-Typ definiert.
 *
 *        Eine typische Definition in der Headerdatei \fcolor{cyan}{\<cstdint\>} könnte wie folgt
 *        aussehen:
 * \code{.cpp}
 * typedef unsigned short uint32_t;
 * \endcode
 * \see int32_t
 * @}
 * \endcond
 */
typedef unsigned int uint32_t;
/**
 * @}  <!-- datatypes_unsigned -->
 */

/**
 * @}  <!-- datatypes -->
 */
}   // namespace: std
