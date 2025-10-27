export default function Home() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-gradient-to-br from-blue-50 via-indigo-50 to-purple-50 font-sans dark:from-gray-900 dark:via-blue-900 dark:to-purple-900">
      <main className="flex min-h-screen w-full max-w-4xl flex-col items-center justify-center gap-8 py-16 px-8">
        <div className="flex flex-col items-center gap-6 text-center">
          <h1 className="text-6xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent dark:from-blue-400 dark:to-purple-400">
            Azure Sora 2 UI
          </h1>
          <p className="max-w-2xl text-xl leading-8 text-gray-700 dark:text-gray-300">
            Next-generation video generation interface powered by Azure
          </p>
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 w-full mt-8">
          <div className="p-6 bg-white dark:bg-gray-800 rounded-lg shadow-lg">
            <h3 className="text-xl font-semibold mb-2 text-gray-900 dark:text-white">🎬 Video Generation</h3>
            <p className="text-gray-600 dark:text-gray-400">Create stunning videos from text prompts with AI</p>
          </div>
          
          <div className="p-6 bg-white dark:bg-gray-800 rounded-lg shadow-lg">
            <h3 className="text-xl font-semibold mb-2 text-gray-900 dark:text-white">☁️ Azure Powered</h3>
            <p className="text-gray-600 dark:text-gray-400">Scalable deployment on Azure App Service</p>
          </div>
          
          <div className="p-6 bg-white dark:bg-gray-800 rounded-lg shadow-lg">
            <h3 className="text-xl font-semibold mb-2 text-gray-900 dark:text-white">⚡ Fast & Modern</h3>
            <p className="text-gray-600 dark:text-gray-400">Built with Next.js and TypeScript</p>
          </div>
        </div>

        <div className="flex flex-col gap-4 text-base font-medium sm:flex-row mt-8">
          <button className="flex h-12 w-full items-center justify-center gap-2 rounded-full bg-blue-600 px-8 text-white transition-colors hover:bg-blue-700 dark:bg-blue-500 dark:hover:bg-blue-600 md:w-auto">
            Get Started
          </button>
          <button className="flex h-12 w-full items-center justify-center rounded-full border-2 border-blue-600 px-8 text-blue-600 transition-colors hover:bg-blue-50 dark:border-blue-400 dark:text-blue-400 dark:hover:bg-blue-950 md:w-auto">
            Learn More
          </button>
        </div>
      </main>
    </div>
  );
}
