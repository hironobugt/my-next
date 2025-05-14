'use client'

import { useState } from 'react'
import { sum } from '../lib/sum'

export function SumCounter() {
  const [count, setCount] = useState(0)

  const handleClick = () => {
    setCount((prev) => sum(prev, 1))
  }

  return (
    <div>
      <h1>Sum Example</h1>
      <p>Current total: {count}</p>
      <button onClick={handleClick}>Add 1</button>
    </div>
  )
}
