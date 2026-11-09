Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225851;
	b=XD6D1vChjjDz/kV793uvtSNPra3lGUmhwKUgO1CSuRSl0V2wZUhqIrHpz71kasZM/SNr
	 Y+qA8YixmocDVBGdKz3HaV2Xnybmk4AZnM2ttWALa5DrAtsd2za5y/EAEN08d4sv+Y+X3
	 bZIbEtt8OyCZ2F4XmJSqjDHkp/ScKk5ly0ePHJfWJMXUVVZHzwfCzvhSDbKVcPZG3tAQI
	 mW1mDWJqjsOeHCaxGltX64TwzXfEwQoUxC8lPg1+fMLoSNXKw7Z3QcyEh+Il2sXcyGWEJ
	 hZNvF15UcLlSnRvXoWJ+vfeYkKnDWQwIzMxbnPlPNqYgp+B8jqu+uj94ppDVxT8c0RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225851;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WjpWwRoUxqORiuW5H8xBd+5jmlpNuL8fp0DqP1kmC84=;
	b=qD74yo1Ik0pAgKIebStl8zBEnVFeFdfgve4VFz5EMaeXcd56a6HrsEMpFaFumwZX8JC+
	 VQcwQJ6+HoXulx+BgncHJuDeUqEgYsvIf5BZGtxD+DoJgz0FBiHSnfsa55ZSc7PNaEXDC
	 Ld1+XsytUDjZhIHQvW8evYxMJCRal0hvWRMgTqLcBTL36l9b30auc++0VFunvGqUGBXid
	 B5GkLzyhGjx9XycyIOGcupfjf9Zbo3Rh2x5ktUHvfwprbDgUZywj1Z+lwt0dCPSx78DpM
	 P/L4/2zOWGuQ3gZVYZ1iJfNEhuu9vWPZ06FbjkNbsziAyL1NwnKgtyBrnGPDEsl4auA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETwjozXJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E97606A31C;
	Mon,  9 Nov 2026 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETwjozXJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843F81F008A1;
	Mon,  9 Nov 2026 12:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794225850;
	bh=WjpWwRoUxqORiuW5H8xBd+5jmlpNuL8fp0DqP1kmC84=;
	h=From:To:Cc:Subject:Date;
	b=ETwjozXJSSOvcdyCj2pca63oXADmvVfEFkctq61Ao83RAD/OLMfK4ujCSerswmmUC
	 7yrrrWzyxUUyROaKUdklIZlLvFq6Un3l/CFpU0GUvSk17zZw627jgxlyt0Zb1cLnrw
	 X1BEVKKCfTe4IufBNBnifE9/xTCLmUpFlwxVGULaQ6Y8ov3f3jsYFfJhGwJC5EuP1m
	 yshAEdCUITxALtPt7SUgK99yws/hv9UKS/pDwBvccgSRYzCetiq7n8/FmHFMhw7OVu
	 BNHi6LxiY+rsBPzCf88iUQhyl0BJjdIbykvSGIxzqEalKwnfhvb/a/fVHDef542/08
	 guRWu66IZ77IQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 9AAC8198003A;
	Mon,  9 Nov 2026 07:04:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 09 Nov 2026 07:04:07 -0500
X-ME-Sender: <xms:trbxatRLoPBG1NeqH7ioJIPFldkF3zaIzKST2oagIS7LoKeDw494ug>
    <xme:trbxagINNwnSDYYW55zgX8WRGGtQUsABhIs683B7DptccrfUYs9eyG7Onc78lF0lu
    Ij59lrev_QNpryq_bRAtmKsAqF4cPVzUbcSa_xMuUm4mN-hD-otI7Q>
X-ME-Received: <xmr:trbxarWT9-sax744EaZlXii62cem9i0gq81u8oa8W1-2zG6nMaMR4g0QW3M>
X-ME-Proxy-Cause: dmFkZTEHeVVHUfqtfb1dOm5TRDKriBPa5Y3nL88tgXPkdBA7ZkCSLFFLB1zgEH9NW+5VLm
    BnGFV8AzpWanjsQgMjRDtL18fRWfmrbvT9Kq2tGBzg4BxhKbogbw/s4weXCjKe6qd3bpN+
    19tWGmXIt8/jlzlfW5T01rycYM+poyjxXPXXvUkQYbyyIhx8zEwqLRbSHzFk5BNOfeJBWw
    6Dl6gN+UoYmUlwHIklPkb8ESWEeArFhT7NLRcBXkc+cGkaj8QFVR7LTs1IsTKBSDnLo4Kg
    0Sw5chq6FO3hykb7WRjq/pROrmX7qm/w1Xuuvh5P8ajT/IOdb6norFFHtza+dsflcYBEi0
    rHd+hAfE+D3SpifmKvOcV0vpU2e2B+fG/49SFeZhLZZ/3y1Veg4VpgTa+D6sKgITEWbZ28
    OrXMDHgZucK2dnv9fp09KHyltF+ipGp2B25beRSmKMVY55TCwle4C9Nly1OKuwOVfLsxwo
    5iwKlE7K6H6xeS/ra1r74DJwxeoYQoGW1K7EylVfeMTVunyt1A5xqLpIHX2S0ZJ/nI56PA
    0hbe3pcCWwppcAAp8pHGoGkE8ylIUFsIpHMSlsmhnFi8unnwl+ive3I4kVsU+yasZ2jhcq
    aA30ViCngLwfiAk4dTU3uerJP00sHIwdzWeN4ZrT+8DqmcLNSC/P1bMSahZw
X-ME-Proxy: <xmx:trbxakgAM0RPlCx0UdziTwvAftHHjQWxkKNsDX4anSOpzz0GuV0qRw>
    <xmx:trbxanvUBG0bMZ3ZxIborj2NynTjwa75DUlEFlGlnEMsrGg8s1LpwQ>
    <xmx:trbxakzE2vpwa_nS6ssxfVBVllD97ylsl4VgTmZdp4XReaqDh4rG0Q>
    <xmx:trbxasZ-h_Pv52opcJWwwTzQXd_pU7eIZQpotN4gsiQDBz7TnepZ7w>
    <xmx:trbxajWdY0gr-VitKbxAqKwY09yE4ClbQYMp03R_4-U3auKAW62XfCji>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 07:04:05 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Mason <mason@kernel.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 0/2] mm/memory: refuse to map page cache folios that are not uptodate
Date: Mon,  9 Nov 2026 12:04:00 +0000
Message-ID: <20261109120403.82361-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A page cache folio that is not uptodate holds data that was never read
in or cleared. Each path that maps page cache checks for this itself,
and a path that misses the check leaks stale memory to userspace.
MADV_COLLAPSE did exactly that with fallocated shmem THPs.

Patch 2 adds a backstop: warn and refuse the mapping in __do_fault()
and do_set_pmd().

Patch 1 fixes a race the backstop would trip over. do_shared_fault()
unlocks the folio around ->page_mkwrite(), and a writeback error can
clear PG_uptodate in that window. The fault goes on to map the folio,
and stores through the mapping can be lost when it is read in again.
Retry the fault instead.

v2:
 - New patch 1: recheck PG_uptodate after ->page_mkwrite() (Sashiko)
 - Check in __do_fault(), before the folio is unlocked, instead of in
   finish_fault()
 - WARN_ON_ONCE() without a message
 - Rebase on current mm-new

v1: https://lore.kernel.org/all/20261106144323.3634477-1-kirill@shutemov.name/

Kiryl Shutsemau (Meta) (2):
  mm/memory: recheck PG_uptodate after ->page_mkwrite()
  mm/memory: refuse to map page cache folios that are not uptodate

 mm/memory.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

Range-diff against v1:
-:  ------------ > 1:  632ab50e643d mm/memory: recheck PG_uptodate after ->page_mkwrite()
1:  af1dd44c0e1b ! 2:  1e329f330c41 mm/memory: refuse to map page cache folios that are not uptodate
    @@ Commit message
         leaks stale memory silently. MADV_COLLAPSE did exactly that with
         fallocated shmem THPs until recently.
     
    -    Warn and refuse the mapping in finish_fault() and do_set_pmd().
    -    finish_fault() checks the folio ->fault() returned rather than the one
    -    it maps: for CoW, do_cow_fault() copies the page cache folio and maps
    -    the copy. do_set_pmd() covers MADV_COLLAPSE, which maps without a
    -    fault.
    +    Warn and refuse the mapping in __do_fault() and do_set_pmd().
    +
    +    __do_fault() checks the folio ->fault() returned while it is still
    +    locked. do_shared_fault() unlocks it for ->page_mkwrite(), and a
    +    writeback error can clear PG_uptodate after that; that case retries the
    +    fault instead. For CoW, __do_fault() sees the page cache folio that
    +    do_cow_fault() copies from. do_set_pmd() covers MADV_COLLAPSE, which
    +    maps without a fault.
     
         The fault gets SIGBUS, as for a folio that fails to read in.
         MADV_COLLAPSE fails and leaves the range to be faulted in.
    @@ Commit message
     
      ## mm/memory.c ##
     @@ mm/memory.c: static vm_fault_t __do_fault(struct vm_fault *vmf)
    + 	else
    + 		VM_BUG_ON_PAGE(!folio_test_locked(folio), vmf->page);
    + 
    ++	if (WARN_ON_ONCE(file_folio_not_uptodate(folio))) {
    ++		folio_unlock(folio);
    ++		folio_put(folio);
    ++		vmf->page = NULL;
    ++		return VM_FAULT_SIGBUS;
    ++	}
    ++
      	return ret;
      }
      
    -+/*
    -+ * A page cache folio that is not uptodate holds data that was never read in
    -+ * or cleared, and mapping it leaks stale memory to userspace. The callers are
    -+ * expected to check, so treat a hit as a kernel bug and refuse the mapping.
    -+ */
    -+static bool file_folio_not_uptodate(struct folio *folio)
    -+{
    -+	if (likely(folio_test_uptodate(folio)))
    -+		return false;
    -+	/* Driver pages from ->fault() never get PG_uptodate */
    -+	if (folio_test_anon(folio) || !folio->mapping)
    -+		return false;
    -+	WARN_ONCE(1, "refusing to map a page cache folio that is not uptodate\n");
    -+	return true;
    -+}
    -+
    - #ifdef CONFIG_TRANSPARENT_HUGEPAGE
    - static void deposit_prealloc_pte(struct vm_fault *vmf)
    - {
     @@ mm/memory.c: vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
      		return ret;
      	page = &folio->page;
      
    -+	if (file_folio_not_uptodate(folio))
    ++	if (WARN_ON_ONCE(file_folio_not_uptodate(folio)))
     +		return VM_FAULT_SIGBUS;
     +
      	/*
      	 * Just backoff if any subpage of a THP is corrupted otherwise
      	 * the corrupted page may mapped by PMD silently to escape the
    -@@ mm/memory.c: vm_fault_t finish_fault(struct vm_fault *vmf)
    - 	unsigned long addr;
    - 	bool needs_fallback = false;
    - 
    -+	/*
    -+	 * Check the folio ->fault() returned. For CoW that is the source of the
    -+	 * copy; DAX CoW has none.
    -+	 */
    -+	if (vmf->page) {
    -+		folio = page_folio(vmf->page);
    -+		if (file_folio_not_uptodate(folio))
    -+			return VM_FAULT_SIGBUS;
    -+	}
    -+
    - fallback:
    - 	addr = vmf->address;
    - 

base-commit: b95f8bb86713c860ce8536d22a988b949b884d5f
-- 
2.54.0

