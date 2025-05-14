'use client'

import { useState } from 'react'
import { sum } from '../lib/sum'
import { subtract } from '../lib/subtract'

export function SumCounter() {
  const [count, setCount] = useState(0)
 const handleAdd = () => {
    setCount((prev) => sum(prev, 1))
  }

  const handleSubtract = () => {
    setCount((prev) => subtract(prev, 1))
  }

  return (
    <div>
      <h1>Sum Example</h1>
      <p>Current total: {count}</p>
      <button onClick={handleAdd}>Add 1</button>
      <button onClick={handleSubtract} style={{ marginLeft: 8 }}>
        Subtract 1
      </button>
    </div>
  )
}
