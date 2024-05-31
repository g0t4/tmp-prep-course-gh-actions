const { Octokit } = require("@octokit/rest");
const process = require("process");

const octokit = new Octokit({
  auth: process.env.GH_TOKEN,
});

(async () => {

  // const { data: root } = await octokit.request("GET /");
  // console.log(root);

  const repo = "tmp-prep-course-gh-actions";
  const owner = "g0t4";
  const issue_number = 4;

  const result = await octokit.rest.issues.listForRepo({
    repo, owner
  });
  //console.debug(result);
  console.log('issues: ' + result.data.length)
  result.data.forEach(issue => { console.log("  ", issue.title, issue.number) });
  console.log();

  const pull_number = 8; // malicious pull
  // const { data: pull_request } = await octokit.rest.pulls.get({
  //   repo, owner, pull_number
  // });
  // // FYI pull_request.diff_url => 'https://github.com/g0t4/tmp-prep-course-gh-actions/pull/8.diff',
  // //console.log(pull_request)

  const pr_diff = await await octokit.rest.pulls.get({
    repo, owner, pull_number,
    mediaType: {
      format: 'diff'
    }
  });
  // pr_diff.data (has the diff)
  console.log(pr_diff);

  return

  const issue1 = await octokit.rest.issues.get({
    repo, owner, issue_number
  });
  // console.log(issue1.data);
  console.log(`issue: ${issue1.data.title}`);
  console.log();

  const comments = await octokit.rest.issues.listComments({
    repo, owner, issue_number
  });
  // console.log(comments.data);
  console.log('comments: ' + comments.data.length)
  comments.data.forEach(comment => { console.log("  ", comment.body) });
  console.log();

  const comment = await octokit.rest.issues.createComment({
    repo, owner, issue_number,
    body: "Hello1"
  });
  console.log('new comment:');
  console.log(comment.data);



})()
