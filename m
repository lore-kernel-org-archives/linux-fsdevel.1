Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770834;
	b=0dgQApWumfir1wEV3TlyL0x+Zw+aJ2dkBk7NZbQIbjjkRtL8mSuZ8BhIyYDFXo0qy2dj
	 4gBqFgVO90vQyhGFPH9Lc26UCojDFQDO0qA9SfmOgFgH+s6v2FSDgeECpKvO9SzJ2Rw4V
	 tg6cD11/ErurD8FLUuIyoePQKoRjYAy6QZw1fwhU3+VrzMpNanmHyBm/lvw5vJCD/uJlM
	 3iytBldu1N10MhxrxloCBijjgYBUX/dM6Dy3AIVz10D4Sv8YqcU34qy2vsYTy/feZV9zi
	 lXHlQrrDEIKJzb6Kkoo2sLtmv9a5WVNLSqzSreNcrqjDjdYBcnzhlEbqeLCpYpyD19Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=v9lbr4TFxiuuucypBBOqCbJsUUDeJTCLXV6XHKdyrTE=;
	b=WqwEVUxf68xPGDCQyRbPFcockm3VaNIHKLdoAwbSrcnLz5LarI3TAhZJZlVx/V30rUXw
	 3GbhgB3xL21r/qlheSqyKGMDUOhg4tugj55DkYSiCyZyt3Y4gM3okQTumXWCBrkw/IFGq
	 Rp0NK3lX4Wysy3QD7NKwqZQtcdHNvnnpto6AEmMcBuqOPh280c4Cljw33f8kQAGOSfpk3
	 ivT/i1quoKGYWVc/zmUOC6/oSKwG146qeThQILMjRRfln5H49x18pCx2s77iw2PBcnhfR
	 7GvozB7wMxoEedf+TB13NKJGY1C/jjIApQ5TJLYVl+g9uO3VTu5QktSLyJ5SNxX6H5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mkJ9aTNJ;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D227606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 09:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D227606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mkJ9aTNJ
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-491971ac844so6958277f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 01:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770833; x=1796375633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v9lbr4TFxiuuucypBBOqCbJsUUDeJTCLXV6XHKdyrTE=;
        b=mkJ9aTNJ0BoYHPiFyUJ7deP/ehR5ZFMHYEhr6Y1uxGN9DL/TAvf1Wgg5pfJZAQhamg
         Zfp99owmJjBOThHinbfT/rLf9OJfjYLSHj0ml6eCQrEu2DyOHST/AQXwEnjS9Bw9Jhph
         WiggT5e5sutI5LTtyki8TAVxI2FiHoqkoSQQQBfz2AN5IfBpe3WMz/twfn8P6b4cxOki
         noBIoHREG9/SSWUuGFNfIypgViVyejqE2p27AzHcbT+KE03Ps/QEcjdnNIm5p9moxMRS
         FhM/Nw2MirNSrExJjQ9JHb9e3U08/sHEAtFGF0huyA2N6I76UfIFYBndgS99lwHGN0Dw
         nwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770833; x=1796375633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v9lbr4TFxiuuucypBBOqCbJsUUDeJTCLXV6XHKdyrTE=;
        b=ojV5CktxMeCtDYZQn1za9mUt877e3hERPmWHWLeW6b4Ebjxql1GZcNS6dzLykgiqSs
         0rP/4EOc+t4QuKicuOhKFQl1C3ZGgpXQ4ZHBhkMlLlNLLNHNeuN4e31qnFnGY1AT+D6b
         FFeXaM0UB/BcaGGCYkKUWlHef+6RS3G1OjMD03qGdzJvN0UfrKIQb80mmEPWIf164ynb
         B1zT4ic1fFqg6Paj0Sr4usz5Kh154lobzsvAN/8VdZIslVMToWPLJi+DQXHkrl76fFu8
         omwmdT5NXZJfV7W2N65xZmoqY6amTIEhfhPKlKSdyUygwS4QkoKdrhz4Vjfo7TO5Qils
         rzlw==
X-Forwarded-Encrypted: i=1; AL+hErE8e0TGTdw3qw8XlGBGaMZuJm6MVliFfTwsz2/YjKR9LEpmtyHPn/oTYRub8rxfOn957WqChNF3o+YtIRBt@vger.kernel.org
X-Gm-Message-State: APuU4Z8P0KFSgz4xjzF7O/IXyRbuCB6ySa6lrE1RrBJn1S4BdnJ+0fLr
	q0jby1hs/wEEctj3TgMiBfMsTBbokh3Kc/j0zrnD9DOctYj/dpRjvkZd
X-Gm-Gg: AZFdTZcMOeVz70ZVoQrHwZTmr47bYb6jcVrpioYi3pbUoEsEwDqWKmqsI6aYty226E2
	yi1inigQiiKTHfXoLA2g219jA8ht1rIjbTBU2M79CwqN0wSapUziCwIaTxILQB8dMKfJTqaaizc
	KlPl1Np5Lb9dtWU2cwPb8zNRhQUN4WX4Fs4HqjMlQqzeZHk4UsI/qB73QmT6G9+uz485qccXa2o
	ShqNE9f6Dl9J3ekbr3B9KBaUkRdjzHjUZuhR+mAmtSSy61TmwnsFNeeSJlWF3Xco3y17vxt+lqe
	4aMI1Mfqv0FT91XeHlE1SM5ffgr1zlryWwMw1rhu3NKa+a3oZn3a7hRQ8sXuQexUjNm/1rfAxYo
	6e9RBzRkbYBw+7Njh/J9pTOQBYbZsachN9GWWg4EfTgKJ3FcXHZlrJOsBDxZ03DFk0fy2oZ8dl0
	W9Fa72yuBfMqc1ghxOvQiEUSBFaXXr56addR9RxiYja7/y6Qyiqke46qpK4YPcbRVi5Kqq4TBAf
	7OyfXZVBsI/xM2aqKJC2D+VWUkRc+6bNpCw7OLKUBN6zayOrweRSRcSa7m4XxEQLZzPspHwsPiL
	lCIkqbxOTmSwoEoUW146XcPPQsbfbCGXk1w=
X-Received: by 2002:a05:6000:4211:b0:4a6:4862:28fc with SMTP id ffacd0b85a97d-4abaa9764b7mr46243092f8f.7.1795770832771;
        Fri, 27 Nov 2026 01:13:52 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b1ed8b6a05sm26067087f8f.43.2026.11.27.01.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:13:52 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Zach O'Keefe" <zokeefe@google.com>,
	Hugh Dickins <hughd@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Dev Jain <dev.jain@arm.com>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Rik van Riel <riel@surriel.com>,
	Song Liu <songliubraving@fb.com>,
	linux-fsdevel@vger.kernel.org,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] mm/memory: allocate the deposit page table with NOFS in do_set_pmd()
Date: Fri, 27 Nov 2026 10:12:14 +0100
Message-ID: <20261127091344.113688-2-azpijr@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127091344.113688-1-azpijr@gmail.com>
References: <20261127091344.113688-1-azpijr@gmail.com>
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

On ppc64 with the hash MMU, do_set_pmd() allocates the page table to
deposit when the caller did not preallocate one. Both callers that let
it allocate hold the folio lock: set_huge_pmd() in khugepaged never
preallocates, and finish_fault() has no preallocated table when the
page table was removed after __do_fault() checked the PMD.

Allocating with __GFP_FS while holding a folio lock can deadlock in
reclaim, for example the memcg reclaim deadlock on cgroup v1 described
in commit 63f3655f9501 ("mm, memcg: fix reclaim deadlock with
writeback").

pte_alloc_one() takes no gfp flags, so allocate the table in a NOFS
scope.

Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
Cc: stable@vger.kernel.org
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
Changes in v2:
- new, replaces v1 3/4 "mm/memory: never allocate a page table in
  do_set_pmd()" (David)

v1: https://lore.kernel.org/20261125100058.15200-4-azpijr@gmail.com

 mm/memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index dfa307a9228c..05d03b32ce52 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5806,9 +5806,17 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	 * related to pte entry. Use the preallocated table for that.
 	 */
 	if (arch_needs_pgtable_deposit() && !vmf->prealloc_pte) {
+		unsigned int nofs_flags;
+
 		if (!may_alloc)
 			return VM_FAULT_FALLBACK;
+		/*
+		 * The folio is locked, and reclaim or compaction with __GFP_FS
+		 * could deadlock on it. pte_alloc_one() takes no gfp flags.
+		 */
+		nofs_flags = memalloc_nofs_save();
 		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
+		memalloc_nofs_restore(nofs_flags);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
 		pgtable_allocated = true;
-- 
2.56.1

