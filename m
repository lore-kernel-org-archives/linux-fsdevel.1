Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180266;
	b=Stws8Owbi2x2t4W+UZZii6CN/mCmjHjUD41WRHnbEjsR7GfJI4DINsbjZenKSfpumjLB
	 3Fku9FNGNNpXQ05wFOkTbN6R2T7MHgdf1OcfMYpN7nBsIaVT0KfphlTgvwPPKy4mFGUUO
	 UurDn6igl7xgUxTljxR+7wkWsNymWmYTuphAiSqCkixcpygLHq2KVsDj3l5NEiVlVyaVV
	 z/qzedt6yWiLnzsI+BZ6TFrtcJRj7KaSEmoixtaV3RZaAF24vC28+cI2N+Kfup9sohdA5
	 FyqrOidW/OfrcmFMl1OYDM8hcNOwGs9ngWEy8M7akfOE4WKF8MxRNloAArmv4T5bdTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180266;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4BfmwT5HwmtAheFgYIlEkMUQ63GV05El6mVs5kObkQ0=;
	b=G4V0uXrO+B4LWbtWStCEzSdrr9BU+A3I75xcas4LTU+ds0NKVOebMydIvvmCMsw6Nbkj
	 O4XCTe4dTHyFDadrMiw7MfTqwBI88sd/5DApjIe2+STz46//fPIlQDBiFkNienSdDR3/C
	 kIyh3GOottMdL2m7Nh8RIO2b4ssoTbH3NZQQQucQ/tytPwIKGI65f7NWsgp67JtO9ZR13
	 DlSpbh/eovUuYjN3xmq6+cUhdkRLB8vsZTdsuWIbUzfqBs7hGvs2UY7XHDkl7X0Xw/Lmy
	 iT+7qaiTHCPZK/nBjZDfc314zau7I4Hqu8WbyIA37Os/tViHsQhvyY29XRG8uxtVbbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3re072U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B2606A326;
	Fri, 20 Nov 2026 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3re072U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4C01F000C4;
	Fri, 20 Nov 2026 13:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795180265;
	bh=4BfmwT5HwmtAheFgYIlEkMUQ63GV05El6mVs5kObkQ0=;
	h=From:Subject:Date:To:Cc;
	b=K3re072U/JtpTkV5CUity3yLkPfxYNthAICuBafScdewG/9R2iw5OiW2pO1AGauzi
	 +shBDaiOudEMMKbDPNhxr6NI17b/uEZ3DHsZx6oNn7OjhfFmNr/Q8/kHoJfcgV1gt6
	 V0MFs7D66CwcQKU9bel2RZ6nymblb8Fzc1nDy7lrwPDEjPq3u/f+gUiKeqLEErX+7E
	 SX0Xo9EeMBGD1HJwRma485TEGa8V5QLGOjHiGPNrLlTGzYKaYyBM/iAsQHsjEefVgN
	 GjTNNHqdtDUltymXSU5sIJC4idUzxGcYFqn1HYyg3emhEDfpOgWRWodIFuFzmfCu01
	 ILEOktYtwhMww==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v6 00/12] rust: xarray: add entry API with preloading
Date: Fri, 20 Nov 2026 14:10:11 +0100
Message-Id: <20261120-xarray-entry-send-v6-0-1f69d7385f70@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALRGAGsC/33OTWrDMBAF4KsErasyGv3ZXfUepQvVGiWiRQ6jY
 GKC7145UNJi0+V7MN+bm6jEmap4OdwE05RrHksL7ukghlMoR5I5tiwQ0CoELa+BOcySyoVnWal
 ECYAaEnhjyIl2d2ZK+Xo3395bPuV6GXm+T0xqbf/TJiVB9mRTipb0kOD1k7jQ1/PIR7FyE/4QD
 hDcHoEroQajnNcp6i2hfxP9HqEbkbz3g7MfXSDcEOZBODB7hFm/cDa1jc73QBvCPogecI+wjYi
 qCzGQAQ/dH2JZlm/y7CDgvwEAAA==
X-Change-ID: 20251203-xarray-entry-send-00230f0744e6
To: Tamir Duberstein <tamird@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 Daniel Gomez <da.gomez@samsung.com>, 
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, 
 Sashiko <sashiko-bot@kernel.org>, Tamir Duberstein <tamird@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9483; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=5xnL2+/1G3RJlbCVQDxV1k1/UK21NajORP5wc0Ttlmo=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBrAEbA7SIl3L0sxQmVeuvbUu7x+E0XkhER2fpl4
 JE2vj4UbD+JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCawBGwAAKCRD6UCkIqsW9
 0JEED/950bGF5w/sOYpPRxlmKNZV4SlstXn3LQ/FlilNVoRmU8hBygFzf1/yyczySAIReq1d6yq
 dL+J0RDLemAsBVacmoeWbN35L8W7J4kvym4wLwZh/zbcrAMCgnysVZjlyffTirhRJA8wp4Q15rZ
 yKJPMW/nNm3SvYD6PnDeEMKdGEoQxYPKmem+woobJq+pfcfQ9154f0xvV/6yDlJ/IemvyllMAsX
 jNrudTRgtXfeNo0PLSg9YlSjNBE4qt4vpGSf8lWmKDWXwmCiMADNYjz1Z/sVfrI+xbikwn8fe1F
 KVgC/mjWWfsw3KuYfglSHXaOYMqbjrCzl9tPA/Xul1laKyM0OSlxjzQ/q/j7Gp0deRx7VD1+cJ4
 4jfZVrM7AkZEx7E4/GVtDXeQH0rALGpCFMttpr7sC8cq8AO5cM8OXpKHqB11iedRVNTb4IUos93
 IzzZgR7RBVwzH1CA2WVJJRagFIKCzVT00Zzq9INgeInH7iF1T2GvjZgxnQhiSY4uPfRPAqjyRS0
 TTocdHKObP9wG2xv2n/cSeRyxPWlOPXqKMMu2M9JQIHokiclsfEmxPE2OnVwv4fsOIZ7jcJVgT3
 bZ3iaQmluLV0XsaIFwHOV17g1RAG5U8MKJu2tTL+Fhk0hpHKr4RSuvQb6hQFBfQrJs3XL4uYawm
 T88EwTtY6doIBkw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This patch series is a mashup of cleanups and feature additions for the
Rust XArray abstractions.

 - Patch 1 starts by fixing minor formatting issues and bringing use
   statements up to date with the new coding guidelines.

 - Patch 2 adds some minor convenience functionality.

 - Patch 3 moves two static C helper functions to the xarray header so
   that they can be called from Rust helpers.

 - Patch 4 adds an abstraction for the C `xa_state` structure and uses
   it in `xarray::Guard::load`, removing an unnecessary rcu lock. This
   is a prerequisite for all the subsequent patches.

 - Patch 5 is a simplifying refactor of `xarray::Guard::load`.

 - Patch 6 adds two new methods for finding items with keys that are larger
   than a given integer.

 - Patch 7 adds an entry API.

 - Patches 8-9 add support for sheaf-based object caches.

 - Patch 10 enables sheaf support for the xarray kmem_cache.

 - Patch 11 adds preloading to the new entry API.

 - Patch 12 documents that `Guard::store` may temporarily drop the
   xarray lock.

The feature additions in this series are dependencies for the rust null
block driver, most of which is still downstream.

Best regards,
Andreas

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v6:
- Rebase on v7.4-rc2.
- Assert pointer alignment when inserting through the entry API (Sashiko).
- Correct the documentation of the sheaf capacity: the requested capacity
  is a minimum, and requesting a larger sheaf yields an oversize sheaf
  rather than a warning (Vlastimil, Sashiko).
- Describe static and dynamic caches by whether they are destroyed, rather
  than by the language creating them, in the sheaf documentation and commit
  message (Vlastimil).
- Document that dropping a `Sheaf` never destroys its cache (Sashiko).
- Document the reference counting done when allocating from a dynamic cache
  (Sashiko).
- Merge the two identical `Sheaf::alloc` implementations.
- Add missing `#[inline]` annotations to small forwarding functions
  (Sashiko).
- Move the trailing empty comment to the last item of the import list and
  mention the `crate` to `kernel` change in the commit message (Sashiko).
- Remove the `drop` call from the `Entry::is_occupied` example until `Drop`
  is implemented for `XArrayState`, to keep each patch clippy clean.
- Link to v5: https://msgid.link/20260902-xarray-entry-send-v5-0-d18adae40708@kernel.org

Changes in v5:
- Rebase on v7.2.
- Update the cover letter.
- Adapt the entry API to the new lifetime bounds on `ForeignOwnable::Borrowed` and `ForeignOwnable::BorrowedMut`.
- Squash the `xas_load` conversion into the `XArrayState` patch (Tamir).
- Replace the `GuardRef` trait with a `Deref` bound on `XArrayState` (Tamir).
- Filter internal `XA_ZERO_ENTRY` entries in `XArrayState::load` and `load_next` (Sashiko).
- Add a new patch moving `xas_result()` and `xa_zero_to_null()` to the xarray header instead of duplicating them in the Rust helpers (Tamir).
- Require an exclusive guard reference for `XArrayState::insert`.
- Add `XArrayState::replace` and `XArrayState::restart_at` helpers and use them in the entry code (Daniel).
- Clear `XA_FREE_MARK` when inserting through the entry API (Sashiko).
- Reset the `xa_state` cursor before retrying a failed store in `XArrayState::insert` (Sashiko).
- Check for NULL before running the object initializer in `Sheaf::alloc` (Sashiko).
- Set cache object alignment to the alignment of `T` in `KMemCacheHandle::new` (Sashiko).
- Restrict the `SBox` raw pointer round trip to static caches (Sashiko).
- Implement `Send` and `Sync` for the sheaf types and `Send` for `XArrayNode` where sound (Sashiko).
- Add `#[repr(transparent)]` to `XArrayNode` (Sashiko).
- Document that dropping the last `KMemCacheHandle` reference may sleep (Sashiko).
- Add a new patch documenting that `Guard::store` may temporarily drop the lock (Sashiko).
- Import `kernel::fmt` in the `StoreError` `Debug` implementation (Tamir).
- Add the `__rust_helper` attribute to the new C helpers (Sashiko).
- Add `#[inline]` to small forwarding functions in the xarray and sheaf abstractions (Sashiko).
- Fix the SAFETY comment in `OccupiedEntry::insert` (Sashiko).
- Fix the `KMemCacheInit::init` documentation (Sashiko).
- Update the `Guard::load` simplification commit message to note it establishes the untyped pointer style for the rest of the series (Tamir).
- Remove a stray blank line in `Guard::get_mut` (Tamir).
- Expand the entry API commit message to describe and motivate the added API surface (Tamir).
- Collect Daniel's Reviewed-by tags. The tag for the `XArrayState` patch is dropped due to substantial rework of the patch.
- Link to v4: https://msgid.link/20260604-xarray-entry-send-v4-0-965f6028790e@kernel.org

Changes in v4:
- Rebase on v7.1-rc2.
- Drop `contains_index` patch (Tamir).
- Use `kernel::fmt::*` rather than `core::fmt::*` (Tamir).
- Add `into_guard` to `VacantEntry` and `OccupiedEntry` for releasing the entry borrow while keeping the lock guard (Alice).
- Refactor `XArrayState` over a new `GuardRef` trait to support both `&Guard` and `&mut Guard` borrows.
- Improve the `XArrayState` type invariant and update SAFETY comments.
- Document the `(size_t)XAS_RESTART` cast in `bindings_helper.h` (Tamir).
- Use GFP_ATOMIC when allocating under spinlock in the examples.
- Link to v3: https://msgid.link/20260209-xarray-entry-send-v3-0-f777c65b8ae2@kernel.org

Changes in v3:
- Fix a misconception about sheaf availablility under `CONFIG_SLUB_TINY` and `CONFIG_SLUB_DEBUG`.
- Add missing patch to enable sheaf support in xarray kmem_cache.
- Update commit messages for last 3 patches.
- Link to v2: https://msgid.link/20260206-xarray-entry-send-v2-0-91c41673fd30@kernel.org

Changes in v2:
- Rebase on v6.19-rc8.
- Update the cover letter.
- Implement preloading with sheafs.
- Investigate generating RUST_CONST_HELPER_XAS_RESTART as pointer -> Not possible.
- Correct wording of commit message for patch "rust: xarray: use `xas_load` instead of `xa_load` in `Guard::load`".
- Correct wording of commit message for patch "rust: xarray: add `find_next` and `find_next_mut`".
- Remove last patch (lockdep static key fix) from series, to be sent separately.
- Expand note on why store to occupied slot cannot fail.
- Change signature of `OccupiedEntry::swap` to match core::mem::swap.
- Move // NOTEs about storing NULL closer to relevant checks.
- Move `insert_internal` to `XArrayState`.
- Share logic between `find_next` and `find_next_entry`.
- Rename `XArray::get_entry` to `XArray::entry`.
- Make `load_next` a method on `XArrayState`.
- Move load logic to `XArrayState`.
- Use `PhantomData` to capture lifetime of `Guard` for `XArrayState`.
- Link to v1: https://lore.kernel.org/r/20251203-xarray-entry-send-v1-0-9e5ffd5e3cf0@kernel.org

To: Tamir Duberstein <tamird@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Trevor Gross <tmgross@umich.edu>
To: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
To: Alexandre Courbot <acourbot@nvidia.com>
To: Onur Özkan <work@onurozkan.dev>
To: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Harry Yoo <harry@kernel.org>
To: Hao Li <hao.li@linux.dev>
To: Christoph Lameter <cl@gentwo.org>
To: David Rientjes <rientjes@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org

---
Andreas Hindborg (12):
      rust: xarray: minor formatting fixes
      rust: xarray: add debug format for `StoreError`
      xarray: move xas_result() and xa_zero_to_null() to the header
      rust: xarray: add `XArrayState`
      rust: xarray: simplify `Guard::load`
      rust: xarray: add `find_next` and `find_next_mut`
      rust: xarray: add entry API
      rust: mm: add abstractions for allocating from a `sheaf`
      rust: mm: sheaf: allow use of C initialized static caches
      xarray, radix-tree: enable sheaf support for kmem_cache
      rust: xarray: add preload API
      rust: xarray: document `Guard` lock drop semantics

 MAINTAINERS                     |   1 +
 include/linux/radix-tree.h      |   3 +
 include/linux/xarray.h          |  26 ++
 lib/radix-tree.c                |  19 +-
 lib/xarray.c                    |  12 -
 mm/slub.c                       |   4 +
 rust/bindings/bindings_helper.h |  11 +
 rust/helpers/xarray.c           |  15 +
 rust/kernel/mm.rs               |   1 +
 rust/kernel/mm/sheaf.rs         | 762 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/xarray.rs           | 605 +++++++++++++++++++++++++++++--
 rust/kernel/xarray/entry.rs     | 381 ++++++++++++++++++++
 12 files changed, 1791 insertions(+), 49 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20251203-xarray-entry-send-00230f0744e6

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>


