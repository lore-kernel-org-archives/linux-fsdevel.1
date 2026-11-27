Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770838;
	b=dCuRUY8vH1W/3otK0YhkksEUFxKNEizhFIXHHdgbkDMhnJNZADhBlVUB7a0F7Uu3U9Dh
	 D4lT8Xp3NO6Uwy5jNH0P7uzMlESNUwQSN/ksKIdzJ/mnXUelCu4dL+qkpjlAszzw/o364
	 PFDTbSVbZ7+ryTw4GDWS+/HxNGUQ7NZcKWT2gxNfmLQlAtxF1eX3j5R6XgV8+GtpSqnRv
	 65mLenguUGOzd4KvhXP0n3G4V4FDiKXBDsRZsrlXdkwD0ntzGf6Xy5gMNhe8LwkBmsIv/
	 zhzlammgAsYSbb07mEz6rYgiY4HEOEzrmDA6e+UwSBhNt3EyCxjYSMypR/PwK30zJKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PbpBQncRyADmzwyT+DIGCOcxAB+kyUykQ1z1tEvlyxs=;
	b=x1MfykD+a9bJ8i90M+9XB70dy69hmTyR/F+h8fqObL3Ivmmrc3PpAKUoMf38QcwHyfvC
	 tL82GSRk4p6/ZHPj1kELoqM1K+BLDp0nvLrEKXI/hOjrmCN/UOKOzDZvsSVij7g6xU0ZE
	 /ioSvxPI6/T24v36rCgGlIGb3FtkmrnMfFsFDINNeZfMnNyfYhMMD7y2fSF+A+5youTNl
	 e38/ZxRstMTw2YHZdmNMeTj46SKHWgcXb3ZzajUOwPn2UjTVKkwtOk0j02o/GMf81W7Jn
	 kQok6Vvjamxtx2uKLe/FNMpbm32zKAM1xBiOuLn6T8uCO+r04Byj4CZjqS4curoadsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vl+mrKI2;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D366606A327
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 09:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D366606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vl+mrKI2
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b8a1f59d5eso10387064a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 01:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770837; x=1796375637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PbpBQncRyADmzwyT+DIGCOcxAB+kyUykQ1z1tEvlyxs=;
        b=Vl+mrKI2phVb7UBD2dDnwkcEm87oSwu2TJUA7Kzq4ru9ChmjHJzW+FlRFTb3JMhj4F
         yUL0obJ+90rI/BLxv1rHWKrPppQvB8RxNKJ60L78UJO0oZaH66xfiuc+2w7fvgNtpufk
         k9QZ6TNp6dIL0BCw0J/iaIlHIudROlBinGhEHPb+yGoDpCYxpTsToKCIGYvcXWUhVSPr
         GR6IxROwrCu4GiHJx9r4leWega28tGch5vhv5tDFrdK6Hp9gCY6to8M4xLTSpPUc9CTn
         5KvIzDDHrZlmhMIbmMjNKc7FEHnr9pbD6GdYPm7tBjuw3rmTEfVLFYncH8MPBo66K+9e
         p8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770837; x=1796375637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PbpBQncRyADmzwyT+DIGCOcxAB+kyUykQ1z1tEvlyxs=;
        b=bqcHeVTvVtWyD9T43erjQZqyHBpOkn+RAik4zPdE/EQxVIhC3/4SxLEm989/nYoliZ
         vU9Mnv9taU75EyAlE91Y+YwmM+DhHsD/x/xTenQFH1T8sOSwH/N7LDJAxqy3rGy/rOvY
         KL633y+OsBRteejMva/uqiS2Em0vApjU6cQUgSOXZKbO+Snu+/pZs4Mlav1HQGwe9Cnd
         RzHolnwV+Sl+dYq8aqZd0ftXvf9aeKZl8rvaqq2c11P+Otp8AxxAwBqiNORdvME465E+
         sBT79AP08J//H4pkpqQNFtOb5Hb0TPvuM72IHcwr7lysR7QpOVZR3POFFpcRAuTUj0Kg
         HbkA==
X-Forwarded-Encrypted: i=1; AL+hErHKyLF48ff56VaMa9zisxOgBURsoVV2LmBLbKeek71vRKFOfQoyb/H1WcbF+E/46XlJzDyMy7aJy/r2PNqK@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ah53JUoEI+J1i7EfbY7G/z+KakzuU69m2pYFhBWA5viPNrGbF
	eav8mSQ6XfnEk292xO5TL2/2eFvAKGaJzQWPSdY1GSo3Euj+/U51Xlec
X-Gm-Gg: AZFdTZenG/dLwsZOm+GxjMQbxU8+oWyPjvr9uHwZ/NDsBkaf+SGLkkH6XLgBl10FIcY
	nomc1jTQGq8l5M6Kxvzw7ZHLGbLZaUJOIyqZnO1vZaADqREjYD3nkYHhebX7YJsLnWv6ischxqi
	3zBp4PRKbGfKpk8S/J/2SxH9sYcsNoKOt0B5j1VTf55n33F9q5mz7/NIqxjWYv/Oa8js2Zp7K15
	1mqWd9quR/7OAU8hi1gVXRIJ8N/PiU4sN5BKcCiw08o3KT0104OJzHK9icgDFXtXm3hhepUn4Xc
	HUuPAtnLbk4JdMkwSXIIY+vTpNAFRUrvcU2eo8q1RywzCOraazEfMKC3KW9lGpW4y74raECaWnG
	T0P4iGUY8ejeTSUjNUf7CBFuahjTTPmpLOxQCCoRr2GTb9kv25266uunnHivUmrqd9HRXcexHCw
	XaBaNQCqc9fE9Ls3nNTsqd80uZOzX1DDJQQraNzvM7c/9lDKcJ0GiW2pwyKZtAoAV5x6KFQhtwU
	xc/kTHFx3ROGQG3XUJ2pdDMvUuO9gOBFmjdfMCS22E803VAfhgOUOKz6CpGEarT6Igj3nRAsOhX
	LOyUKjMkjtOZHqrdfLJv7VHZusGaRvSf5tA=
X-Received: by 2002:a05:6402:2744:b0:6ba:4ca9:86b7 with SMTP id 4fb4d7f45d1cf-6ba4ca994e3mr17362328a12.21.1795770836265;
        Fri, 27 Nov 2026 01:13:56 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b1ed8b6a05sm26067087f8f.43.2026.11.27.01.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:13:55 -0800 (PST)
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
Subject: [PATCH v2 2/3] mm/khugepaged: allocate page tables with NOFS in set_huge_pmd()
Date: Fri, 27 Nov 2026 10:12:15 +0100
Message-ID: <20261127091344.113688-3-azpijr@gmail.com>
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

try_collapse_pte_mapped_thp() calls set_huge_pmd() with the folio
locked. When there is no PMD table, set_huge_pmd() allocates the
missing p4d/pud/pmd tables there.

Allocating with __GFP_FS while holding a folio lock can deadlock in
reclaim. For example, memcg reclaim on cgroup v1 waits for writeback
that may be waiting for the folio lock we hold.

Allocate these page tables in a NOFS scope.

Fixes: f8a01513f574 ("mm/khugepaged: do not fail collapse_pte_mapped_thp() on SCAN_PMD_NULL")
Cc: stable@vger.kernel.org
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
Changes in v2:
- allocate in a NOFS scope instead of before locking the folio (David)
- the deposit table is handled in do_set_pmd() now
- new subject, was "mm/khugepaged: allocate page tables before locking
  the folio"

v1: https://lore.kernel.org/20261125100058.15200-2-azpijr@gmail.com

 mm/khugepaged.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 93d4a6f159e8..2ac8b5621db0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1839,14 +1839,18 @@ static enum scan_result set_huge_pmd(struct vm_area_struct *vma, unsigned long a
 	mmap_assert_locked(vma->vm_mm);
 
 	if (!pmdp) {
+		unsigned int nofs_flags;
+
+		/*
+		 * The folio is locked, and reclaim or compaction with __GFP_FS
+		 * could deadlock on it.
+		 */
+		nofs_flags = memalloc_nofs_save();
 		pgdp = pgd_offset(mm, addr);
 		p4dp = p4d_alloc(mm, pgdp, addr);
-		if (!p4dp)
-			return SCAN_FAIL;
-		pudp = pud_alloc(mm, p4dp, addr);
-		if (!pudp)
-			return SCAN_FAIL;
-		pmdp = pmd_alloc(mm, pudp, addr);
+		pudp = p4dp ? pud_alloc(mm, p4dp, addr) : NULL;
+		pmdp = pudp ? pmd_alloc(mm, pudp, addr) : NULL;
+		memalloc_nofs_restore(nofs_flags);
 		if (!pmdp)
 			return SCAN_FAIL;
 	}
-- 
2.56.1

