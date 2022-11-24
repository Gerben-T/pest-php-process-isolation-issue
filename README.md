Run
```shell
docker-compose up --build
```
and notice that the test fails.

---

When running PHP Pest with the option `--process-isolation` (see `startup.sh`) it crashes with the following error

```shell

   FAIL  Tests\ExampleTest
  â¨¯ example

  ---

  â€¢ Tests\ExampleTest > example
   PHPUnit\Framework\Exception 

  Parse error: syntax error, unexpected 'd' (T_STRING) in Standard input code on line 215

  at vendor/phpunit/phpunit/src/Util/PHP/AbstractPhpProcess.php:305
    301â–•                 $childResult = false;
    302â–• 
    303â–•                 $result->addError(
    304â–•                     $test,
  âžœ 305â–•                     new Exception(trim($stdout), 0, $e),
    306â–•                     $time
    307â–•                 );
    308â–•             }
    309â–•

  1   vendor/phpunit/phpunit/src/Util/PHP/AbstractPhpProcess.php:289
      ErrorException::("unserialize(): Error at offset 0 of 89 bytes")

  2   vendor/phpunit/phpunit/src/Util/PHP/AbstractPhpProcess.php:289
      unserialize("
Parse error: syntax error, unexpected 'd' (T_STRING) in Standard input code on line 215
")

  3   vendor/phpunit/phpunit/src/Util/PHP/AbstractPhpProcess.php:187
      PHPUnit\Util\PHP\AbstractPhpProcess::processChildResult(Object(P\Tests\ExampleTest), Object(PHPUnit\Framework\TestResult), "
Parse error: syntax error, unexpected 'd' (T_STRING) in Standard input code on line 215
", "")

  4   vendor/phpunit/phpunit/src/Framework/TestCase.php:902
      PHPUnit\Util\PHP\AbstractPhpProcess::runTestJob("<?php
use PHPUnit\Framework\TestCase;
use SebastianBergmann\CodeCoverage\CodeCoverage;
use SebastianBergmann\CodeCoverage\Driver\Selector;
use PHPUnit\TextUI\XmlConfiguration\Loader;
use PHPUnit\TextUI\XmlConfiguration\PhpHandler;

if (!defined('STDOUT')) {
    // php://stdout does not obey output buffering. Any output would break
    // unserialization of child process results in the parent process.
    define('STDOUT', fopen('php://temp', 'w+b'));
    define('STDERR', fopen('php://stderr', 'wb'));
}

@ini_set('allow_url_fopen', '1');
@ini_set('allow_url_include', '0');
@ini_set('arg_separator.input', '&');
@ini_set('arg_separator.output', '&');
@ini_set('assert.active', '1');
@ini_set('assert.bail', '0');
@ini_set('assert.callback', '');
@ini_set('assert.exception', '0');
@ini_set('assert.quiet_eval', '0');
@ini_set('assert.warning', '1');
@ini_set('auto_append_file', '');
@ini_set('auto_detect_line_endings', '0');
@ini_set('auto_globals_jit', '1');
@ini_set('auto_prepend_file', '');...", Object(P\Tests\ExampleTest), Object(PHPUnit\Framework\TestResult))

  5   vendor/phpunit/phpunit/src/Framework/TestSuite.php:673
      PHPUnit\Framework\TestCase::run(Object(PHPUnit\Framework\TestResult))

  6   vendor/phpunit/phpunit/src/Framework/TestSuite.php:673
      PHPUnit\Framework\TestSuite::run(Object(PHPUnit\Framework\TestResult))

  7   vendor/phpunit/phpunit/src/TextUI/TestRunner.php:661
      PHPUnit\Framework\TestSuite::run(Object(PHPUnit\Framework\TestResult))

  8   vendor/phpunit/phpunit/src/TextUI/Command.php:144
      PHPUnit\TextUI\TestRunner::run(Object(PHPUnit\Framework\TestSuite), [])

  9   vendor/pestphp/pest/src/Console/Command.php:119
      PHPUnit\TextUI\Command::run()

  10  vendor/pestphp/pest/bin/pest:61
      Pest\Console\Command::run()

  11  vendor/pestphp/pest/bin/pest:62
      {closure}()

  12  vendor/bin/pest:115
      include("/home/dev/vendor/pestphp/pest/bin/pest")


  Tests:  1 failed
  Time:   1.15s
```

It has something to do with `string(84) "/home/dev/vendor/pestphp/pest/src/Factories/TestCaseFactory.php(223) : eval()'d code"`
, i think PHP Unit is trying to validate the filename `/home/dev/vendor/pestphp/pest/src/Factories/TestCaseFactory.php(223) : eval()'d code`
which is incorrect due to `(223) : eval()'d code`.