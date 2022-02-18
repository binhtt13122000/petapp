module.exports = {
  apps: [
    {
      name: "fcode-storybook-backend",
      script: "./dist/main.js",
      watch: ["./dist"],
      // Delay between restart
      watch_delay: 1000,
      ignore_watch: ["node_modules"],
      watch_options: {
        usePolling: true,
      },
    },
  ],
};
