// app/page.tsx
'use client'

import { useState } from 'react'

export default function Home() {
  const [count, setCount] = useState(0)

  const sum = (a: number, b: number): number => {
    return a + b
  }

  const handleClick = () => {
    setCount((prev) => sum(prev, 1))
  }

  return (
    <main style={{ padding: 20 }}>
      <h1>Sum Example</h1>
      <p>Current total: {count}</p>
      <button onClick={handleClick}>Add 1</button>
    </main>
  )
}
