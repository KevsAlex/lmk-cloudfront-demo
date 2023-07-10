const fetch = require("node-fetch");

const IN_PROGRESS_IMAGE = "data:image/jpeg;base64,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";
const SUCCEEDED_IMAGE = "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAYABgAAD/4QBmRXhpZgAATU0AKgAAAAgABAEaAAUAAAABAAAAPgEbAAUAAAABAAAARgEoAAMAAAABAAIAAAExAAIAAAAQAAAATgAAAAAAAABgAAAAAQAAAGAAAAABcGFpbnQubmV0IDQuMi44AP/bAEMABgQFBgUEBgYFBgcHBggKEAoKCQkKFA4PDBAXFBgYFxQWFhodJR8aGyMcFhYgLCAjJicpKikZHy0wLSgwJSgpKP/bAEMBBwcHCggKEwoKEygaFhooKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKP/AABEIACgAKAMBIgACEQEDEQH/xAAfAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgv/xAC1EAACAQMDAgQDBQUEBAAAAX0BAgMABBEFEiExQQYTUWEHInEUMoGRoQgjQrHBFVLR8CQzYnKCCQoWFxgZGiUmJygpKjQ1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4eLj5OXm5+jp6vHy8/T19vf4+fr/xAAfAQADAQEBAQEBAQEBAAAAAAAAAQIDBAUGBwgJCgv/xAC1EQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APpPxNr1n4e01ru9YnJ2xxr96RvQf414n4g8c61rErf6S9pbHgQ27FRj3PU/y9qPiPrT6x4nucNm2tWMEQB4wDyfxOfwxXL15levKUuWOx+d51nVXEVZUqUrQWmnXzJPPl8zf5sm/wDvbjmuk8P+Oda0eVf9Je7thwYbhiwx7HqP5e1cvXo/gXwXAbNtb8TBYrBU3xxSHaGH95vb0Hf+eVJTcvcPOy2GKq1ksNJp7t30S7vyPTfDOvWfiHTVu7JiMHbJG33o29D/AI0V494N1q20fxz/AMS1pRpV1L5GJTztJ+Un6H9M0V6VGrzx13PvspzNYyjeo1zRdn2fmvU5uz+zf21H/a/m/ZfO/f8AlfexnnFdx468FwCzXW/DIWWwZN8kUZ3BR/eX29R2/lgfEjRX0fxPc4XFtdMZ4iBxgnkfgc/hip/APjKbw7c/Z7rdLpkjfOnUxn+8v9R3rgjyxbpz+8+JoRoUalTBYyNrv4uqfR+hteAfBsKW39veJNsVlGvmRRS8Bh/fb29B3+nXF8feMpvEVz9ntd0WmRt8idDIf7zf0Hajx94ym8RXP2e13RaZG3yJ0Mh/vN/Qdq5CipUUVyQ2/MMbjadKn9Twfwfal1k/8uyJLbd9oi8v7+8bfrmiuk+G+ivrHie2yuba1YTykjjAPA/E4/DNFXQoOcb3OrJ8mqYyk6vNyq/3ntnibQbPxDprWl6pGDujkX70beo/wrxPxB4G1rR5W/0Z7u2HImt1LDHuOo/l70UV1V6UZrme59NnWV4fE03WmrSS3X6nN+RL5mzypN/93ac10nh/wNrWsSrm2e0tjyZrhSox7Dqf5e9FFcVClGcrM+SyfLqWMr8lW9ke2eGdBs/D2mraWSk5O6SRvvSN6n/CiiivUSSVkfo9OnClBU6askf/2Q==";
const FAILED_IMAGE = "data:image/jpeg;base64,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";

const detectSourceType = (source) => {
  const branch = source || '';

  const shaRegex = /(\w|\d){40}/;
  const prRegex = /pr\/(\d+)/

  if (branch.match(shaRegex)) {
    return `/commit/${branch}`;
  }

  if (branch.match(prRegex)) {
    return `/pull/${branch.replace(prRegex, '$1')}`;
  }

  return `/tree/${branch}`
}

exports.handler = async (event, context, callback) => {
  const webhook_url = process.env.TEAMS_WEBHOOK_URL;

  if (event && event.Records && event.Records.length) {
    event.Records.map(async record => {
      const raw_msg = record && record.Sns && record.Sns.Message;
      const msg = JSON.parse(raw_msg);

      const detail = msg && msg.detail;
      const time = msg && msg.time;

      if (detail) {
        console.log('CodeBuild Event payload.\n', JSON.stringify(detail, null, 2))
        
        const status = detail["build-status"];
        const themeColor = status === "SUCCEEDED" ? "#CEDB56" : status === "IN_PROGRESS" ? "#76CDD8" : "#D35D47";
        const buildId = detail["build-id"].split('/')[1];
        const region = 'us-east-1';
        const project = detail["project-name"];
        const summary = `[Build [${project}] notification](https://console.aws.amazon.com/codesuite/codebuild/projects/${project}/build/${buildId}/log?region=${region})`;
        const additional = detail["additional-information"];
        const branch = additional && additional["source-version"];
        const branch_url = (additional.source && additional.source.location && additional.source.location.replace(".git", detectSourceType(branch))) || "#";
        const environment = additional && additional.environment;
        const variables = environment && environment['environment-variables'];
        const env = variables.filter(x => x.name === 'env_name')[0].value

        const image = status === "SUCCEEDED" ? SUCCEEDED_IMAGE : status === "IN_PROGRESS" ? IN_PROGRESS_IMAGE : FAILED_IMAGE;

        const webhook_payload = {
          "@type": "MessageCard",
          "@context": "http://schema.org/extensions",
          themeColor,
          summary,
          sections: [
            {
              activityTitle: summary,
              activitySubtitle: `On project [${project}]`,
              activityImage: image,
              facts: [
                {
                  name: "Status",
                  value: status
                },
                {
                  name: "Date",
                  value: time.replace("Z", " UTC")
                },
                {
                  name: "Source Branch",
                  value: `[${branch}](${branch_url})`
                },
                {
                  name: "Target Env",
                  value: env
                }
              ],
              markdown: true
            }
          ]
        };

        try {
          const response = await fetch(webhook_url, {
            method: "post",
            body: JSON.stringify(webhook_payload),
            headers: { "Content-Type": "application/json" }
          });

          const data = await response.text();

          console.log(`Successfully send message to MS Teams\n`, data);
        } catch (error) {
          console.error(`Unexpected error happened while sending message to MS Teams.\n`, error);
        }
      } else {
        console.warn("Sns record doesn't contain details");
      }
    });
  }

  callback(null, "Success");
};