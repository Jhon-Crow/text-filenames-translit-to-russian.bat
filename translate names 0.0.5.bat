@echo off
chcp 1251 >nul
setlocal enabledelayedexpansion

cd /d "%~dp0"

echo Текущая папка: %cd%
echo.

:: Таблица транслитерации (строчные -> строчные)
set "a=а"
set "b=б"
set "v=в"
set "g=г"
set "d=д"
set "e=е"
set "zh=ж"
set "z=з"
set "i=и"
set "y=ы"
set "k=к"
set "l=л"
set "m=м"
set "n=н"
set "o=о"
set "p=п"
set "r=р"
set "s=с"
set "t=т"
set "u=у"
set "f=ф"
set "h=х"
set "c=к"
set "ch=ч"
set "sh=ш"
set "shch=щ"
set "''=ъ"
set "y'=ы"
set "'=ь"
set "e'=э"
set "yu=ю"
set "ya=я"

:: Таблица транслитерации (заглавные -> заглавные)
set "A=А"
set "B=Б"
set "V=В"
set "G=Г"
set "D=Д"
set "E=Е"
set "Zh=Ж"
set "Z=З"
set "I=И"
set "Y=Ы"
set "K=К"
set "L=Л"
set "M=М"
set "N=Н"
set "O=О"
set "P=П"
set "R=Р"
set "S=С"
set "T=Т"
set "U=У"
set "F=Ф"
set "H=Х"
set "C=К"
set "Ch=Ч"
set "Sh=Ш"
set "Shch=Щ"
set "''=Ъ"
set "Y'=Ы"
set "'=Ь"
set "E'=Э"
set "Yu=Ю"
set "Ya=Я"

echo Обработка файлов в текущей папке...
set count=0

for %%F in (*.txt *.pdf *.fb2 *.djvu *.epub *.mobi *.doc *.docx *.rtf) do (
    set "filename=%%~nF"
    set "extension=%%~xF"
    
    if not "!filename!"=="" (
        call :transliterate "!filename!"
        set "new_name=!result!!extension!"
        
        if not "!new_name!"=="%%~nxF" (
            echo [!count!] Переименовываю: %%F
            echo          в: !new_name!
            echo.
            ren "%%F" "!new_name!" 2>nul || echo Ошибка: не удалось переименовать "%%F"
            set /a count+=1
        )
    )
)

if %count%==0 (
    echo Файлов для обработки не найдено.
) else (
    echo Обработано файлов: %count%
)

pause
exit /b

:transliterate
set "str=%~1"
set "result="
set "i=0"

:loop
if "!str!"=="" goto :cleanup

set "char=!str:~0,1!"
set "next_char=!str:~1,1!"
set "next_next_char=!str:~2,1!"
set "next3_char=!str:~3,1!"

:: Укорачиваем строку
set "str=!str:~1!"

:: Если символ - пробел, дефис, подчеркивание или точка, заменяем на пробел
if "!char!"==" " (
    set "result=!result! "
    goto loop
)
if "!char!"=="_" (
    set "result=!result! "
    goto loop
)
if "!char!"=="-" (
    set "result=!result! "
    goto loop
)
if "!char!"=="." (
    set "result=!result! "
    goto loop
)

:: Проверка на латинские буквы (строчные)
if "!char!"=="a" set "result=!result!а" && goto loop
if "!char!"=="b" set "result=!result!б" && goto loop
if "!char!"=="c" (
    if "!next_char!"=="h" (
        set "result=!result!ч"
        set "str=!str:~1!"
    ) else (
        set "result=!result!к"
    )
    goto loop
)
if "!char!"=="d" set "result=!result!д" && goto loop
if "!char!"=="e" set "result=!result!е" && goto loop
if "!char!"=="f" set "result=!result!ф" && goto loop
if "!char!"=="g" set "result=!result!г" && goto loop
if "!char!"=="h" set "result=!result!х" && goto loop
if "!char!"=="i" set "result=!result!и" && goto loop
if "!char!"=="j" set "result=!result!дж" && goto loop
if "!char!"=="k" set "result=!result!к" && goto loop
if "!char!"=="l" set "result=!result!л" && goto loop
if "!char!"=="m" set "result=!result!м" && goto loop
if "!char!"=="n" set "result=!result!н" && goto loop
if "!char!"=="o" set "result=!result!о" && goto loop
if "!char!"=="p" set "result=!result!п" && goto loop
if "!char!"=="q" set "result=!result!к" && goto loop
if "!char!"=="r" set "result=!result!р" && goto loop
if "!char!"=="s" (
    if "!next_char!"=="h" (
        set "result=!result!ш"
        set "str=!str:~1!"
    ) else (
        set "result=!result!с"
    )
    goto loop
)
if "!char!"=="t" set "result=!result!т" && goto loop
if "!char!"=="u" set "result=!result!у" && goto loop
if "!char!"=="v" set "result=!result!в" && goto loop
if "!char!"=="w" set "result=!result!в" && goto loop
if "!char!"=="x" set "result=!result!кс" && goto loop
if "!char!"=="y" set "result=!result!ы" && goto loop
if "!char!"=="z" (
    if "!next_char!"=="h" (
        set "result=!result!ж"
        set "str=!str:~1!"
    ) else (
        set "result=!result!з"
    )
    goto loop
)

:: Проверка на латинские буквы (заглавные)
if "!char!"=="A" set "result=!result!А" && goto loop
if "!char!"=="B" set "result=!result!Б" && goto loop
if "!char!"=="C" (
    if "!next_char!"=="h" (
        set "result=!result!Ч"
        set "str=!str:~1!"
    ) else (
        set "result=!result!К"
    )
    goto loop
)
if "!char!"=="D" set "result=!result!Д" && goto loop
if "!char!"=="E" set "result=!result!Е" && goto loop
if "!char!"=="F" set "result=!result!Ф" && goto loop
if "!char!"=="G" set "result=!result!Г" && goto loop
if "!char!"=="H" set "result=!result!Х" && goto loop
if "!char!"=="I" set "result=!result!И" && goto loop
if "!char!"=="J" set "result=!result!Дж" && goto loop
if "!char!"=="K" set "result=!result!К" && goto loop
if "!char!"=="L" set "result=!result!Л" && goto loop
if "!char!"=="M" set "result=!result!М" && goto loop
if "!char!"=="N" set "result=!result!Н" && goto loop
if "!char!"=="O" set "result=!result!О" && goto loop
if "!char!"=="P" set "result=!result!П" && goto loop
if "!char!"=="Q" set "result=!result!К" && goto loop
if "!char!"=="R" set "result=!result!Р" && goto loop
if "!char!"=="S" (
    if "!next_char!"=="h" (
        set "result=!result!Ш"
        set "str=!str:~1!"
    ) else (
        set "result=!result!С"
    )
    goto loop
)
if "!char!"=="T" set "result=!result!Т" && goto loop
if "!char!"=="U" set "result=!result!У" && goto loop
if "!char!"=="V" set "result=!result!В" && goto loop
if "!char!"=="W" set "result=!result!В" && goto loop
if "!char!"=="X" set "result=!result!Кс" && goto loop
if "!char!"=="Y" set "result=!result!Ы" && goto loop
if "!char!"=="Z" (
    if "!next_char!"=="h" (
        set "result=!result!Ж"
        set "str=!str:~1!"
    ) else (
        set "result=!result!З"
    )
    goto loop
)

:: Если символ не латинская буква, оставляем как есть (кириллица, цифры, символы)
set "result=!result!!char!"
goto loop

:cleanup
:: Убираем лишние пробелы (заменяем двойные пробелы на одинарные)
:clean_spaces
if "!result:  = !" neq "!result!" (
    set "result=!result:  = !"
    goto clean_spaces
)

:: Убираем пробелы в начале и конце строки
:trim_start
if "!result:~0,1!"==" " (
    set "result=!result:~1!"
    goto trim_start
)

:trim_end
if not "!result!"=="" (
    if "!result:~-1!"==" " (
        set "result=!result:~0,-1!"
        goto trim_end
    )
)

exit /b