Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770842;
	b=k5/OXGzKFPkOKowKFtwdJrh3T/ZalGYWwSmDEOPOhJRpQgS4GTCA+Lh3tJlnmJTd3v8W
	 UXm6paID663U8u5FeSx3mSI3sIqJyjIDfuDfhxDMwGp46WWk1i/hmLUItNYQDAJnQCTJI
	 vgVgz0devaIKUNEHbXPvgaxY1w8kf+tYq8FhJDDqWbNdjVaq69AJ1m7502SGskyxtud50
	 EHo+siVxCGgc/kAPxqKiBUsCYSH3xpXAW3eIMet9TZEI4I9ISC/+nMWY1BYwEgFESsoGE
	 3mOQCq4+w/wBgTBInQvmPH3FU4+Q5S2H/Mzp/3fC9e6o+ZrNTfNpx2Tm5h9VXItSHKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2kjuxamo+ARDPfXgOKJZvTzyyERo8tzr4IQwkyrTwCo=;
	b=HLDS8wjI7GGaOcNKxElBHZxkfEehpfgucFxww11eTAcFk1e+FCShSG7LQKSnlvz6dX6t
	 eXqWpAGuejllLEEQx5morQZc0IdKP2nkJwrrDdhSeEyT4X+CluxoD2p0aQTqUz7hiKYLJ
	 zJxbeJzbRg7uJFRbTkSVeuNOvlJYXfKWe7f+3qNl4kU5PtH2NoIZ3F5EJUzPOe25BdKwC
	 3Dm5Jbnfp8Tet6xZj+JhYfmjeyFHq9rS7XrqWKEy24f88oslNqyVU/CQyjWWVOQxBqUEe
	 aN1VrRTX8PvDrR2e3bPYCh6yQFr0hPA4Rah4lgjlXOQn4QZ4WXvdPI+u+ue93+CPKcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HfxsMBdy;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA8A606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 09:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AA8A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HfxsMBdy
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c511c0e2826so898410766b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 01:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770840; x=1796375640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2kjuxamo+ARDPfXgOKJZvTzyyERo8tzr4IQwkyrTwCo=;
        b=HfxsMBdy4mrgWCcKqetQG/kIRtdA9cbqj5a3Sz06/WOdhPJpjdWqsxWbcDEUCMIath
         1XRerBbusZo3mRQ+iVvG4DRY2fOtgumpQmF9W76P8onXqeGmUksb4dKXgUf6PcUukK10
         WVuWqITSBIMNAOaDqcSfZ6WYDuIbv3j2L/4hpqmNxnxxyvJ6AMgygXKPafUrN/7paQXw
         gju4o4YsghpaJ2xdrJ5chVYhlWJgMzzYYJ1LUGRN0x8Jhts2MyJz1C6DTKAv26FMsEkD
         KnTP5+J/gr3sb0TVJ9T6iIiP3AidVcNYLZpMl6VGX4Pkocr2gmiQ+8iHtpgV8tFxcPDH
         qZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770840; x=1796375640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2kjuxamo+ARDPfXgOKJZvTzyyERo8tzr4IQwkyrTwCo=;
        b=bT4da4pnUJkR/iSgvpj8GgOMbr3h6WDT5l0WIRGZLSouNMaQZPGm48CrJZ877GRn1L
         2QNLMTgkOlZOrYmMeyLqk3E0jXDl1N245ADImDzOxFSjD+Blfs7u9FIkvvS3wqbH7T4f
         soikVGxZFz4eO7TMD5dUWcgv8QbbirgOHj5X8fbrkp0ifZIGkOris4dUmVlqjyUYK29S
         h2WySUQ0PVqjI1j/+3Pt31wXfH3iW1oeYCVwwkAFZMCHI1jrufj6sz3LRvm0QvV9Jv3R
         XL3dVcTo5M3rksdzqqApoFVWakXhAKsP87+pyrVD7a7LmWvAPwcmT5aB8OBnJ8RLmR9A
         Lg3w==
X-Forwarded-Encrypted: i=1; AL+hErGqp8ZKLwvhY+LkCLcu8ja57Kd022uvEMrwkgiLEK2083JvZGJTb6/Pv7C3NoA55Ma7/mCWkbbxWtLxKJKK@vger.kernel.org
X-Gm-Message-State: APuU4Z/A0s5pCfFldG2Ajd7xP3bap8rwRgtbINxn5v1Epq1LiPDSz8gw
	Envz7fl44IPfm8erJGoRl2yYX7g+DlvGy/t3MmfA20EXkkXoLHWYdW8B
X-Gm-Gg: AZFdTZerQYjXqPnkJmxbCM5tl/zlG3r0FiL7zKxRKCjimRQ7EgJ7xeHb7AZ+bbRLOyM
	6Oi3rV2wvVvtuxLNo5sfwKAAdeL8x8CLnTYNg+P1DjrJaMTPCpzoZmF/Yv2WjqEJPurWgRDzP2O
	mUzxVEAxtcDNb6ARxZOoy4nsLrqiQ750jpyPIGyhhI6zGHQcG0Ofgd5YQMJX1rfkgNorUt9Wbb6
	jcetVLE7ok0S+vpxfFK0HhHoUQ5ccnzVQ2+7aariiCRVbaFo+G1Asqvl5kHUjl28oa8Se7yc+V8
	prTwBAmJDiqfelx8pGvLGGYIMyTuh5MZHt1Pr0ral6dbM49XiiHCabgcDDf2TUiQhDnJjkL4awq
	zwcvhXrZmnlr1NDNZ4Yc+qDQSGVEdB3pRAcAGdHB+93id/o+iTbZyqqRfGFwM2u3xHaxTzN9lQv
	8+frKVHAcBVn2CVi3XNOCXpbSXywA6mF+qzed3fVgw82o8T4ZPEW/0QEnwBPidXEOb+350YxCM3
	Hf0/y+zcnHnIqejQI8ZKTtuwl4L+yeM5WMSuNq6aSTLFa7BUeeLbx2u4MFpyGB3XLDxmGONrv29
	I0XNO8On4KZ+uw==
X-Received: by 2002:a17:906:f5a5:b0:c36:7579:fe6d with SMTP id a640c23a62f3a-c513a88a87cmr2056869566b.11.1795770840460;
        Fri, 27 Nov 2026 01:14:00 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b1ed8b6a05sm26067087f8f.43.2026.11.27.01.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:14:00 -0800 (PST)
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
Subject: [PATCH v2 3/3] mm/memory: don't allocate in finish_fault() with the folio locked
Date: Fri, 27 Nov 2026 10:12:16 +0100
Message-ID: <20261127091344.113688-4-azpijr@gmail.com>
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

__do_fault() preallocates a page table only when the PMD is empty, so
that finish_fault() does not have to allocate one with the folio locked.

Since retract_page_tables() no longer takes the mmap and VMA locks, the
page table can be removed while the fault waits in ->fault().
finish_fault() then finds an empty PMD without a preallocated table, and
calls pte_alloc() with the folio locked.

Allocating with __GFP_FS while holding a folio lock can deadlock in
reclaim, for example the memcg reclaim deadlock on cgroup v1 described
in commit 63f3655f9501 ("mm, memcg: fix reclaim deadlock with
writeback").

If the folio can't be mapped with a PMD, return VM_FAULT_NOPAGE instead,
as we already do when pte_offset_map_lock() fails. The retried fault
preallocates the page table before locking the folio.

Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
Cc: stable@vger.kernel.org
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
Changes in v2:
- return VM_FAULT_NOPAGE after trying do_set_pmd() (David)
- drop the ppc64 sentence, do_set_pmd() is handled on its own now

v1: https://lore.kernel.org/20261125100058.15200-3-azpijr@gmail.com

 mm/memory.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 05d03b32ce52..dd0cb09ba7ef 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6000,10 +6000,14 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 				return ret;
 		}
 
-		if (vmf->prealloc_pte)
-			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
-		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
-			return VM_FAULT_OOM;
+		/*
+		 * The page table was removed after __do_fault() found it, so
+		 * nothing was preallocated. Allocating with the folio locked
+		 * can deadlock in reclaim, so retry the fault instead.
+		 */
+		if (!vmf->prealloc_pte)
+			return VM_FAULT_NOPAGE;
+		pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
 	}
 
 	nr_pages = folio_nr_pages(folio);
-- 
2.56.1

