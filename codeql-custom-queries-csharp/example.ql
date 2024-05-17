/**
 * @id csharp/weshigbee/unused-vars
 * @name Find unused local variables
 * @description Find local variables that are declared but never used. These can be removed and/or indicate incomplete functionality. THIS is just a simple example, I haven't bothered to validate its correctness beyond this dotnet api project!
 * @kind problem
 * @problem.severity recommendation
 * @tags maintainability, correctness
 * @precision low
 */

// Metadata Notes
// - metadata is constructed in a QLDoc comment block
//    - https://codeql.github.com/docs/ql-language-reference/ql-language-specification/#qldoc
// - metadata docs: https://codeql.github.com/docs/writing-codeql-queries/metadata-for-codeql-queries/
// - @kind choices:
//      `problem` (aka alert query) => issues w/ line(s) of code
//      `path-problem` (aka path query) => issues w/ data flows
// - @problem.severity choices: error, warning, information, hint, recommendation
// - @security.serverity (when @tags has `security`)
// - @precision choices: low, medium, high, very-high
//    - think reliability (likelihood of true results, not false results)
//
// Running Queries:
//  - https://docs.github.com/en/code-security/codeql-for-vs-code/getting-started-with-codeql-for-vs-code/running-codeql-queries#analyzing-your-projects
//
// Querying tutorials:
//   https://codeql.github.com/docs/writing-codeql-queries/ql-tutorials/
//
// import python // etc
import csharp // for query over c# language
//
// from CommentLine c
// select c, "foo"
//
// from CommentBlock b
// select b, "foo"
//
// from Assignment a
// select a, "foo"
//
// from LocalVariableAccess v
// select v, "foo"
//
// ! secondary - WORKS to detect declared only => i.e. the "int foo;" that is never used
// from LocalVariable v
// where v.getFile().getBaseName() = "Program.cs"
//   and not exists(v.getAnAccess())
// select v, "declared but never used!"
// # FYI same as compiler warning: "warning CS0168: The variable 'foo' is declared but never used"
//
// note getAnAccess() is effectively SelectMany'd to produce new rows for results (select)
//
// from Access a
// where a.getFile().getBaseName() = "Program.cs"
// select a, "test"
//
//
// ! WORKS!!!! *** FINAL QUERY ***
from LocalVariable v, int num_accesses, string message // cross product
// from => variable declarations, type describes (super)set of possible values... I say superset b/c that meshes well with what cross product is effectively doing here...
where
  // bindings => constraints on actual values of the defined variables (effectively initializes them into records of possible combinations)
  num_accesses = count(v.getAnAccess()) // count # accesses per variable
  // getAnAccess() is a relationship constraint to the VariableAccess type
  // count(expr) is an aggregation operator (think SQL COUNT())
  and num_accesses < 2 // 0 => declared, not initialized - 1 => declared, initialized, not used // 2+ => used too ...
  // FYI have not verified if this is sound logic, just works to find what I seutp in the code w/ `consistentForecasts` (1 => decl+init) and `int foo` (0 => uninitialized)
  // when I scanned powershell/powershell => I found that passing a local variable didn't count as an access, so I would need to adjust query for that too... would be nice to query the type of Access (i.e. read/write)... save for a rainy day
  and message = "Found unused local variable, accesses=" + num_accesses
select v, message
// order by v
//
//
// ! FYI creating database from local repo files:
//   brew install codeql
//   cdr
//    cd api
//    trash api-codeql-db # remove old db
//    codeql database create api-codeql-db --language=csharp --source-root=.
//       --overwrite # if db already exists
//       restart vscode (had issue after update database locally, fixed after restart)
// FYI can get codeql DB from public repos like powershell/powershell => use vscode extension to pull DB and open in Databases panel => pick the language to query) => run same custom query on diff databases
//
//
// *** codeql CLI analyze/run:
// cdr => cd api =>
//
//    codeql query run ../codeql-custom-queries-csharp/example.ql -d api-codeql-db/
//        Run query against -d DB
//        prints table of results! like table in vscode extension
//
//    codeql database analyze api-codeql-db/ ../codeql-custom-queries-csharp/example.ql --format=sarif-latest --output=results.sarif
//