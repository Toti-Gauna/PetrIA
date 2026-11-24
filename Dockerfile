# PLACEHOLDER for the web app (Next.js). It only proves that the image builds.
# The real build steps (install, next build, run) arrive with the map, batch 1.6.
FROM node:22-slim

# Never run as root inside the container.
USER node
WORKDIR /home/node/app

CMD ["node", "-e", "console.log('PetrIA web: placeholder image, no app yet')"]
