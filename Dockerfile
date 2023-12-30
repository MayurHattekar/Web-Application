FROM node:14
EXPOSE 3000
COPY index.js .
CMD ["node", "index.js"]
