(* Copyright (C) 2017 Authors of BuckleScript
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * In addition to the permissions granted to you by the LGPL, you may combine
 * or link a "work that uses the Library" with a publicly distributed version
 * of this file to produce a combined library or application, then distribute
 * that combined work under the terms of your choosing, with no requirement
 * to comply with the obligations normally placed on you by section 4 of the
 * LGPL version 3 (or the corresponding section of a later version of the LGPL
 * should you choose to use a later version).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *)

#ifdef TYPE_STRING
type key = string
#elif defined TYPE_INT
type key = int
#else
[%error "unknown type"]
#endif  
type 'a t


val empty: unit -> 'a t
val isEmpty: 'a t -> bool
val singleton: key -> 'a -> 'a t
val mem:  'a t -> key -> bool
val cmp:  'a t -> 'a t -> ('a -> 'a -> int [@bs]) -> int
(** [cmp m1 m2 cmp]
    First compare by size, if size is the same,
    compare by key, value pair
*)
val eq: 'a t -> 'a t -> ('a -> 'a -> bool [@bs]) -> bool
(** [eq m1 m2 cmp] *)
  
val iter: 'a t -> (key -> 'a -> unit [@bs]) ->  unit
(** [iter m f] applies [f] to all bindings in map [m].
   [f] receives the key as first argument, and the associated value
   as second argument.
   The application order of [f]  is in increasing order. *)

val fold:  'a t -> 'b -> ('b -> key -> 'a -> 'b [@bs]) -> 'b
(** [fold m a f] computes [(f kN dN ... (f k1 d1 a)...)],
   where [k1 ... kN] are the keys of all bindings in [m]
   (in increasing order), and [d1 ... dN] are the associated data. *)

val forAll:  'a t -> (key -> 'a -> bool [@bs]) -> bool
(** [forAll m p] checks if all the bindings of the map
    satisfy the predicate [p].
    The application order of [p] is unspecified. 
 *)

val exists:  'a t -> (key -> 'a -> bool [@bs]) -> bool
(** [exists m p] checks if at least one binding of the map
    satisfy the predicate [p].
    The application order of [p] is unspecified. 
 *)




val length: 'a t -> int
val toList: 'a t -> (key * 'a) list
(** In increasing order *)
val toArray: 'a t -> (key * 'a) array   
val ofArray: (key * 'a) array -> 'a t 
val keysToArray: 'a t -> key array 
val valuesToArray: 'a t -> 'a array
val minKeyOpt: _ t -> key option 
val minKeyNull: _ t -> key Js.null
val maxKeyOpt: _ t -> key option 
val maxKeyNull: _ t -> key Js.null    
val minimum: 'a t -> (key * 'a) option
val minNull: 'a t -> (key * 'a) Js.null
val maximum: 'a t -> (key * 'a) option
val maxNull: 'a t -> (key * 'a) Js.null
val get: 'a t ->  key -> 'a option
val getNull: 'a t -> key -> 'a Js.null
val getWithDefault:  'a t -> key -> 'a  -> 'a
val getExn: 'a t -> key -> 'a
val checkInvariant: _ t -> bool   
(****************************************************************************)

(*TODO: add functional [merge, partition, filter, split]*)

val removeDone: 'a t -> key -> unit  
val remove: 'a t ->  key -> 'a t
(** [remove m x] do the in-place modification, return [m] for chaining *)
val removeArrayDone: 'a t -> key array -> unit
val removeArray: 'a t -> key array -> 'a t
    
val setDone: 'a t -> key -> 'a -> unit  
val set: 'a t ->  key -> 'a -> 'a t
(** [add m x y] do the in-place modification, return
    [m] for chaining. If [x] was already bound
   in [m], its previous binding disappears. *)

val updateDone: 'a t -> key -> ('a option -> 'a option [@bs]) -> unit
val update: 'a t ->  key ->  ('a option -> 'a option [@bs]) -> 'a t 

val map: 'a t -> ('a -> 'b [@bs]) ->  'b t
(** [map m f] returns a map with same domain as [m], where the
   associated value [a] of all bindings of [m] has been
   replaced by the result of the application of [f] to [a].
   The bindings are passed to [f] in increasing order
   with respect to the ordering over the type of the keys. *)

val mapi: 'a t -> (key -> 'a -> 'b [@bs]) -> 'b t



