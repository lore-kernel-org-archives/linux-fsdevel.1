Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795808776;
	b=FIP9G1jDkl0sucOQ2Cyf9qAglQgg8KCGwXSwqlndwpSqCPFRC3S964gevj2M3Fe0ncby
	 lben88xH7Y7dGyTSTnaSrdrmbhdqc3WQ4TTBFq8NVdfTW4hIa8eFSQmvxJyTna0o2ASAP
	 vhIo2LIJ8irNgIRfDPfxV5Loomo1EoHvm7qMUXz5WMLQjEtMoWw02I+MgWz9Vbb8lZB5+
	 1on5L1wRPy4Y7Z0ImKWpxII18J53i379YoCgMXrkFE98VL9hcuJY5KtMbhA3nGZbl2vb8
	 18lRP2fb0UvvLqUolz9JRfesCoLI3+jMxuRskML62Rb7iCTqi4Wsun22Zzrumk7GEhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795808776;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NovJGN266ut6F/KwSsg/fm2bkFyGHYseOOEgSUk+sW4=;
	b=swhYU3/I2bYItPSDO4MQ1ZEyTfu8kAKxtvqvwI1CPhaoHIdpRh47NsnXiB5VoEnTsLY/
	 xygC869csD6oS4j/OLeppm+6vUY0GZ5l9oglHmCTyd7N+GHWM3JP90XTpo/vfEy0Hls08
	 ZSomgrbybWEhn2t/tV0kjF4joXYS/2UwBeFbdjtH9tFmCua4N7XHknFZA8IhKQFEuCxFI
	 c7y+qUzIh7rSdoG5sONN16zSGCuLbr/E0OfjdHTi+kyIwVFp1of7PdnLuC5li2fYoYT/k
	 rCDBKD0Hc87xm/yMXPkiLQKeLT+pTuWgAi+STuCcYolWnjQ1e/DqjCESYAaUVkdlYvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lg7sNeNI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E4606A333;
	Fri, 27 Nov 2026 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lg7sNeNI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F3E1F0092A;
	Fri, 27 Nov 2026 19:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795808776;
	bh=NovJGN266ut6F/KwSsg/fm2bkFyGHYseOOEgSUk+sW4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lg7sNeNIUPTLyrjv0EQC1PBspEKQpD6mwCDWSe0TIl8OUTaKxrQvTa9oZn8m0lEPt
	 LG7WqcGDK7P76nO6qXoIpjrAV9Wu8GQD9UOzldNpMNdbQgvnhiL/D9vsQ4KOxJU4VO
	 sdjsmG9WORMUEVCJmPdXPr5PYReDHbOeZxsdHZqYJ0VdrnY3fabVPkHuD5vbsT///r
	 NIQUxNbxj0aW36HlFkBkXp0ehzOYK7F3HVaDu1VYXQ6QQszr4GLlktKdl2AFALoL/l
	 GJPoG6h1d1ImoSzzaBOpvl5bPS53BnGEfQMMgQw7W15ijNUqU/Fnh042AV0kWlVHUE
	 3kpW9Ym3iSoUw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 27 Nov 2026 19:45:42 +0000
Subject: [PATCH 3/4] mm/mprotect: fix unpaired notifier start at address 0
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-mlock-madvise-mprotect-ai-fixes-v1-3-e46b2b1eb435@kernel.org>
References: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
In-Reply-To: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Rheinsberg <david@readahead.eu>, Hugh Dickins <hughd@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Alex Shi <alexs@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
 Rik van Riel <riel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: codalist@coda.cs.cmu.edu, linux-mm@kvack.org, 
 Andrei Vagin <avagin@gmail.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Chris Mason <mason@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583; i=ljs@kernel.org;
 h=from:subject:message-id; bh=hFazDhUle6ZFh0ivxxT92eZdFw5uAZSRMAka/e6BWSg=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI57758919GLy626I2RXH9E5e29tXOMJRsnuL3coLEl6
 +qUWSZfOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRtNMM/2uy/9Tt3HfOrNvH
 XCOF437Wm9SnbhqfI3nTtde1XhH7sIThn74pb+xRjcsX9oVf5NhvmvrgzMEVbvOXz9iwi1Pi+5u
 iNAYA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Chris Mason <mason@kernel.org>

A protection change on a VMA that starts at address 0 can leave an MMU
notifier invalidation open forever.

Waiters for its end, such as kvm_swap_active_memslots() and
mmu_interval_read_begin(), then sleep uninterruptibly and never wake up.

Fix by using a boolean value to track this instead of the start address of
the range.

Fixes: a5338093bfb4 ("mm: move mmu notifier call from change_protection to change_pmd_range")
Signed-off-by: Chris Mason <mason@kernel.org>
[ ljs: commit msg tweak ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/mprotect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index e18d4e12fc34..0f94b0287895 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -579,8 +579,7 @@ static inline long change_pud_range(struct mmu_gather *tlb,
 	pud_t *pudp, pud;
 	unsigned long next;
 	long pages = 0, ret;
-
-	range.start = 0;
+	bool notified = false;
 
 	pudp = pud_offset(p4d, addr);
 	do {
@@ -596,7 +595,8 @@ static inline long change_pud_range(struct mmu_gather *tlb,
 		if (pud_none(pud))
 			continue;
 
-		if (!range.start) {
+		if (!notified) {
+			notified = true;
 			mmu_notifier_range_init(&range,
 						MMU_NOTIFY_PROTECTION_VMA, 0,
 						vma->vm_mm, addr, end);
@@ -624,7 +624,7 @@ static inline long change_pud_range(struct mmu_gather *tlb,
 					  cp_flags);
 	} while (pudp++, addr = next, addr != end);
 
-	if (range.start)
+	if (notified)
 		mmu_notifier_invalidate_range_end(&range);
 
 	return pages;

-- 
2.56.1

