/**
 * PANDA 3D SOFTWARE
 * Copyright (c) Carnegie Mellon University.  All rights reserved.
 *
 * All use of this software is subject to the terms of the revised BSD
 * license.  You should have received a copy of this license along
 * with this source code in a file named "LICENSE."
 *
 * @file conditionVarFull.I
 * @author drose
 * @date 2006-08-28
 */

/**
 * You must pass in a Mutex to the condition variable constructor.  This mutex
 * may be shared by other condition variables, if desired.  It is the caller's
 * responsibility to ensure the Mutex object does not destruct during the
 * lifetime of the condition variable.
 */
INLINE ConditionVarFull::
ConditionVarFull(Mutex &mutex) :
#ifdef DEBUG_THREADS
  ConditionVarFullDebug(mutex)
#else
  ConditionVarFullDirect(mutex)
#endif  // DEBUG_THREADS
{
}

/**
 *
 */
INLINE ConditionVarFull::
~ConditionVarFull() {
}

/**
 * Do not attempt to copy condition variables.
 */
INLINE ConditionVarFull::
ConditionVarFull(const ConditionVarFull &copy) :
#ifdef DEBUG_THREADS
  ConditionVarFullDebug(copy.get_mutex())
#else
  ConditionVarFullDirect(copy.get_mutex())
#endif  // DEBUG_THREADS
{
  nassertv(false);
}

/**
 * Do not attempt to copy condition variables.
 */
INLINE void ConditionVarFull::
operator = (const ConditionVarFull &copy) {
  nassertv(false);
}

/**
 * Returns the mutex associated with this condition variable.
 */
INLINE Mutex &ConditionVarFull::
get_mutex() const {
#ifdef DEBUG_THREADS
  return (Mutex &)ConditionVarFullDebug::get_mutex();
#else
  return (Mutex &)ConditionVarFullDirect::get_mutex();
#endif  // DEBUG_THREADS
}
