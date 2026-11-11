Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421494;
	b=Gu7hITMWT6Hk46/2c3zue3tYtMMZ6sbcVdow3YwLC0I7CfrvAvyUjK/zv1/0Ax7P9DUl
	 Nl1g1E8MRYlSQqBkvBo9hI6/5SsZerfxgfk4Bj//X7/6LvohKoP4kkewzhmvcdQldeqmZ
	 d0C+q0UHOGEaET8D2yyUwSN05tpK14mXNGgp1cp7MTLWPpKzditMKXjlU0BQ5dtS7YplC
	 xyuWz5hyUFzbJUFOJdL6blbjB9SVza1esIwfD9PH3cbkZpJsW9eq4sdn4H9xYa88VV7ig
	 Bh8MvYv9KBEWdy8J7VCMjb7qERWMxIoqLXmpeT3JW2fi2CGo1CjeHp1YRHsKp0gJOXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421494;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AH3G4Ld/Cw2YgMeAy/KmwdAu0nKPOp5SWLznGtNiRM8=;
	b=OQvuyGhOzI4gFxkVVtugL7KKM28EguUc5Z2jyfmmd8zuzYLVEY4TsuFfcjBegrSuRKtT
	 bQpVwosKQKPEGYjo8yx8QA2zIIB2W3iDm2prx9KWvsihfY1Fk676WJICj7Q21qNeILDlt
	 5HoJQmY24kFgCr2eZHkztATDKeF7xAJPTIjau1BAyoapL9NQbI7XrXxYcSQmnmnPVu6fV
	 Qb37bf34FrD7FTALgiH3F0h7J0QrwjCX6H35FAhGdA+9q1hvHYIB4qbJeSzDuat1yTrHY
	 MefmKTbh8n38HTVv9EKhgzVw3OZcQEITPK6xahcrhGvzjXHc0Ac4eBcbcpscLkB4xog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBODQap9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83B606A324;
	Wed, 11 Nov 2026 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBODQap9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0986D1F00A07;
	Wed, 11 Nov 2026 18:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794421494;
	bh=AH3G4Ld/Cw2YgMeAy/KmwdAu0nKPOp5SWLznGtNiRM8=;
	h=From:To:Cc:Subject:Date;
	b=aBODQap9Whfj8W2pMoHX8qEUEl0vwV6jfWDgC/N7NLqQkhX99X7SA7VEe8ul6+gkj
	 jQeRl06i9VN4MxVr0balWW5uM0GfC3fA+y/yzdSRshEGn+ZTlMmagNuC6HdpAy2l8f
	 7DcAPWCQ5uhrMT/G8lkDIqG3o+0Y4s7GWKNmFXL2O+XA10jWHwbgrlU1tTgkr0QMrg
	 wCaONfkUrZYOLbsAdn2O2Rco52HJSKozuzlDzutgnWKr1Q26mEfzxSffD3I9fkR3My
	 oHKWv4RSP2vZZiuPxYoiRgd/POF6+6SVCPwe8t4rV2R9//71T2hxg/8zza8DPp6iBs
	 6JQ59wW99+HhA==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.ams.internal (Postfix) with ESMTP id 2D70B198003A;
	Wed, 11 Nov 2026 13:24:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 11 Nov 2026 13:24:50 -0500
X-ME-Sender: <xms:8LL0ahgMC1sdqltW2Qo3f0WrT3MZ--3w2nI1U9MuKGqsoB3f8wN9eQ>
    <xme:8LL0avYBGHhtPvOReDD3bYzTf5BnOozVpAswS2KAuAPHR69TDO7qfk8iPXKmMPbVq
    sYPy-woYcNVcnKj4KXbm5aJxZEqXt3AR1PD1iF2ASgBp310lSWnmCjV>
X-ME-Received: <xmr:8LL0apkXw6bL8ewsmZAqDvkZ5_s2ijQFQkolTjm5HTtDw_5FakQDWxTF46Y>
X-ME-Proxy-Cause: dmFkZTG2wF4Dcbvhh7gz8ExlXKwNmF/VlJm9jIhvBywTJn4RMzX60KMrFIt260tiGp3huV
    9loRqotF8zi7MdcgMxVqASC12iSUZLWUGDdCWc9jof5PS1StOs6DX3KySpf23UHeCSfyyG
    E5DWQfJRHn46Jdw2Th1Vk0cLz0xJsVv7gt9a/Au7ONtW2Yq3ff74pd/XkKxGiJ/ik5TogK
    UDNtQajjfl+Pp9mSMi05yIt+KwLx/h972BRj/zMDCbhijKgzvjTsL9I0o1vS5bDIPKQLqb
    r+IuBJHBy4S53FF5o0bRQse+zPwebOp5sbw1Oqv3bRoexrLIuj1sw2XO10iVxqypbt4cDx
    EWj9i5/lWdJIBZRe7s8Yyz8BykkURsWo471Qx48Bx8wPKiKqjtDqdofxT8Qm0LFgrWbHvB
    SNMLnQWTltAC6Lzzjw5wuFOsaECoQxtoqdTrWG7mNJAWU9zpscPr4a03UYnigCJHNd5CeG
    CbIDaERAAbxRYBn9o66xgZ1GoDFNFzGz1QFrs4o/lCA12Ls6E4Nt0vcF66Y/Bob1HwuxC8
    tI69DRgQAnD/OrkW+/PVE2iaLSYOV8Ms3gTUG8djydzX+puuokedYPb7Hq7Wldzygm1dWQ
    xAQJvih+ljNWUNAcmgjO1l1jQ8bNfyBEYZuBOqXVQdSlBUf2R5FVbQwUxuEw
X-ME-Proxy: <xmx:8LL0alwAifPlbgw1trr7V5-hkxLfzXtYFLUvvY6_flQbJg3_cuESpw>
    <xmx:8LL0av_UJMOuM9gr7u5epFKeLP8ZtjxuXgxpHy8EKThUcK7tYpxb2w>
    <xmx:8LL0aoCUoVhow7ddQF0-izevA-QRLVwf0C5blCDSMLeQS3vtbEEMHQ>
    <xmx:8LL0aurcLIg-kluuma3o9aAfH0gugxHXlkXoTb12W0QPlbH7zsXDAg>
    <xmx:8LL0aokKkSYlX_7tltQzCEV4H5NhoTdRgh_8qWKkpnVARBzW8STPJ7N1>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 13:24:48 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Chris Mason <mason@kernel.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3] mm/memory: refuse to map page cache folios that are not uptodate
Date: Wed, 11 Nov 2026 18:24:43 +0000
Message-ID: <20261111182445.656620-1-kas@kernel.org>
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
in or cleared. shmem fallocate(2), for one, adds such folios and clears
them only on first use. Mapping one hands userspace whatever the memory
held before.

Each path that maps page cache checks for this itself: fault-around in
next_uptodate_folio(), a fault in filemap_fault() or shmem_get_folio().
Nothing in the mapping code does, so a caller that misses the check
leaks stale memory silently. MADV_COLLAPSE did exactly that with
fallocated shmem THPs until recently.

Warn and refuse the mapping in __do_fault() and do_set_pmd().

__do_fault() checks the folio ->fault() returned while it is still
locked. For CoW, that is the page cache folio that do_cow_fault()
copies from. do_set_pmd() covers MADV_COLLAPSE, which maps without a
fault.

do_shared_fault() then unlocks the folio for ->page_mkwrite(). A
filesystem that clears PG_uptodate on a folio in the page cache is
buggy, so that window gets no check of its own.

The fault gets SIGBUS, as for a folio that fails to read in.
MADV_COLLAPSE fails and leaves the range to be faulted in.

Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
v3:
 - Drop "mm/memory: recheck PG_uptodate after ->page_mkwrite()": a
   filesystem that clears PG_uptodate on a cached folio is buggy (Matthew)
 - Move file_folio_not_uptodate() into this patch, assert it never sees
   an anon folio, reword its comment and drop likely() (Lorenzo)
 - Rebase on mm/core.git for-next, which has the MADV_COLLAPSE fix

v2: https://lore.kernel.org/all/20261109120403.82361-1-kas@kernel.org/
v1: https://lore.kernel.org/all/20261106144323.3634477-1-kirill@shutemov.name/

 mm/memory.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index fcc7ea2a00d1..c79c1c6f6141 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5641,6 +5641,22 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	return VM_FAULT_OOM;
 }
 
+/*
+ * A page cache folio that is not uptodate holds data that was never read in
+ * or cleared, and mapping it leaks stale memory to userspace.
+ */
+static bool file_folio_not_uptodate(struct folio *folio)
+{
+	VM_WARN_ON_ONCE_FOLIO(folio_test_anon(folio), folio);
+	if (folio_test_uptodate(folio))
+		return false;
+	/*
+	 * ->fault() can also return driver memory that is not in the page
+	 * cache. It never gets PG_uptodate.
+	 */
+	return folio->mapping;
+}
+
 /*
  * Either the VMA lock or the mmap_lock must have been held on entry
  * (see FAULT_FLAG_VMA_LOCK) and may have been released depending on
@@ -5700,6 +5716,13 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	else
 		VM_BUG_ON_PAGE(!folio_test_locked(folio), vmf->page);
 
+	if (WARN_ON_ONCE(file_folio_not_uptodate(folio))) {
+		folio_unlock(folio);
+		folio_put(folio);
+		vmf->page = NULL;
+		return VM_FAULT_SIGBUS;
+	}
+
 	return ret;
 }
 
@@ -5745,6 +5768,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 		return ret;
 	page = &folio->page;
 
+	if (WARN_ON_ONCE(file_folio_not_uptodate(folio)))
+		return VM_FAULT_SIGBUS;
+
 	/*
 	 * Just backoff if any subpage of a THP is corrupted otherwise
 	 * the corrupted page may mapped by PMD silently to escape the

Range-diff against v2:
1:  632ab50e643d < -:  ------------ mm/memory: recheck PG_uptodate after ->page_mkwrite()
2:  1e329f330c41 ! 1:  50ea9bc46c05 mm/memory: refuse to map page cache folios that are not uptodate
    @@ Commit message
         Warn and refuse the mapping in __do_fault() and do_set_pmd().
     
         __do_fault() checks the folio ->fault() returned while it is still
    -    locked. do_shared_fault() unlocks it for ->page_mkwrite(), and a
    -    writeback error can clear PG_uptodate after that; that case retries the
    -    fault instead. For CoW, __do_fault() sees the page cache folio that
    -    do_cow_fault() copies from. do_set_pmd() covers MADV_COLLAPSE, which
    -    maps without a fault.
    +    locked. For CoW, that is the page cache folio that do_cow_fault()
    +    copies from. do_set_pmd() covers MADV_COLLAPSE, which maps without a
    +    fault.
    +
    +    do_shared_fault() then unlocks the folio for ->page_mkwrite(). A
    +    filesystem that clears PG_uptodate on a folio in the page cache is
    +    buggy, so that window gets no check of its own.
     
         The fault gets SIGBUS, as for a folio that fails to read in.
         MADV_COLLAPSE fails and leaves the range to be faulted in.
    @@ Commit message
         Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
     
      ## mm/memory.c ##
    +@@ mm/memory.c: static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
    + 	return VM_FAULT_OOM;
    + }
    + 
    ++/*
    ++ * A page cache folio that is not uptodate holds data that was never read in
    ++ * or cleared, and mapping it leaks stale memory to userspace.
    ++ */
    ++static bool file_folio_not_uptodate(struct folio *folio)
    ++{
    ++	VM_WARN_ON_ONCE_FOLIO(folio_test_anon(folio), folio);
    ++	if (folio_test_uptodate(folio))
    ++		return false;
    ++	/*
    ++	 * ->fault() can also return driver memory that is not in the page
    ++	 * cache. It never gets PG_uptodate.
    ++	 */
    ++	return folio->mapping;
    ++}
    ++
    + /*
    +  * Either the VMA lock or the mmap_lock must have been held on entry
    +  * (see FAULT_FLAG_VMA_LOCK) and may have been released depending on
     @@ mm/memory.c: static vm_fault_t __do_fault(struct vm_fault *vmf)
      	else
      		VM_BUG_ON_PAGE(!folio_test_locked(folio), vmf->page);

base-commit: 8d21e3d3faf19f461f6d0380fe8a1f5bdba97f25
-- 
2.54.0

