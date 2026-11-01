Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552465;
	b=jqy3tPo4lHCa4tqtesrzPjMorkEXikFjr3o6L/BEuAn18JtqvkYORdNRicTSuNdAshpM
	 +F+zQK+bkBuJ0vAYcY+jbCQGRx8zC874m3O2aPXYwppA6H/RDmIk8R1OoWnxeVMrp2UBW
	 VvW0UOIVDA5CHgVAd5P3FSbFz5jsWBn2Ybo/lY9jXUJlhJ+6RRI5EKUW/Keh0WZZuf7bR
	 OlEHymxg0Q4iZUOexTsSOfV1XdC9S8NKEygDrHb+qJC+MhhpIjubdMEcsTu0itFYMI5NI
	 ClsD93E60iZvW8bydzKa/l9ZDXOcaLAHAtathcksD51mzPs1aMEllc52TfJSwxpSkFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ROsDDi/peHhOy6BynZJX3N2nHlHF3d+geUaRBvCkIfc=;
	b=mmr7cKFICat1IpEuyYg2hSlvY+mye4DVr289hXSYPaZt19+50FnKlw0xLVbYG45NBzPi
	 YL01UXCI3W+8pYEDHLpHmR8gRYNDHCCCDyWxSgwydLdmULX1jUieJIZiXnRz2GSXA7M2j
	 M4w3IEnVgcPRAMJrEbxJoTRihD/+mFDEcTP5M45/4zNk54o8EVUNC1ZE4h/yo9JDfA86k
	 1zeVOMe9mCrAXubCnaPS2piUB83YjIKjOfTFdWs3oxcD5SK9TN2MXUGP3arbomXCYpaJF
	 ppnKKSJ6LLQh1ZYPNmC1/tFKdolJtE1Tpeea/o1pSg0xPtOXWukJRrKAR5GcXlZXKig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F1TsPBwM;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDCB606A326
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 17:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEDCB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F1TsPBwM
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-369f33df08eso4585200eec.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 09:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793552464; x=1794157264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ROsDDi/peHhOy6BynZJX3N2nHlHF3d+geUaRBvCkIfc=;
        b=F1TsPBwMoLjgBx5CuDe4M/U6iY84TGXhDM8ujtQ+4MsBnfzmb67AOTiiRi9DcLBoxD
         VzIQ7xBJLUolpKZBW3gzsaA1dOtO4FahVvzIU9PW1nI8MqM8jAN8xHWQMbAjiK1/4Rnu
         POPpuVhrhLvoksaEiEkhCxYqyvh9+8iXxmhY6BkPneTHenqbg1HCFYjF54eArH+HK+mw
         y5IkOonyGBExt2XlJHdeTp8Bkq/R2w59rbVEqiaFxXsVOmS3ZkJO2MvyereEc9OuHdcE
         zlzgK05D3i5izmXqsDBUAOe9+3iCXFLgbqSu2jkilq25RSAggW5yA/W31bsLX9VqbwHw
         Shzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793552464; x=1794157264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ROsDDi/peHhOy6BynZJX3N2nHlHF3d+geUaRBvCkIfc=;
        b=PNxEnc7dJ014NaYxqppFUxtfHyiRjJXfvBB9Imb3mhh0IXfAui4MeHRQHO+iZm5D4c
         kLVku892MAempiYmOnioeX5Dkg2gi+7lje+jS49A8W6x4dgOl3PnTr8mzUq8moHtFSmh
         Owb+0+/tLZyXp5jXplLQSLu7Alev85WXP1PEIrI5LDWDD8X08YiHUT8j+iNFEFF3cKBr
         B8y0mwzqARaHhdQafMjop2vdDLMnQQ4LW6mC0lKc33toWOZBoAec+a4mBpLPGT9iEGoC
         fv/y7uzAIDjouecEd8+FX5T9m8nN1aWcg0CJpu/II/qtcEBYzpymQuo9MPA/9tmV+XS9
         zO2g==
X-Forwarded-Encrypted: i=1; AKwUvByAELwnab0rxH9yazkbDc9NNdcnrU1N2CssrOmZs8GrbVC8g3VQv2F1WsohyLvidh4fC2h0zSWWuDaZUiXf@vger.kernel.org
X-Gm-Message-State: AFq9FYKDYe2mCj2mRswJjGiiJgC1S0CrFVeKhpdrepOxs1ybHUXog+H4
	Lqh/oMduM8uLKb7vd9lW52jwAD1iC3cJ+Anm2JRoV/OJ4bsgtEzc9MeA
X-Gm-Gg: AYBFou0rKzhLwXKmvbinEp+THOifsB5j3R2mhPOvOBhAezl/qQ7mqllHbUp7xMXi+T0
	35+YXgvk6+rS38/pamY5NtdJ9i8fC9BO74Usfxbu+YJ49mFXL/A0PBldLD3M9PojSQKa3kl487Z
	lAn5ws/bSY3miKRRHI9ojcLrI9uTwyiu6L00HwSSnJjwUiJLB4URrkgCSaE7kcazbDKnb97VraA
	F+2LG5m7qC5BdGBw0x/vC/XF5zxAzU68XNa9nJffcQGVxZ6A5iAtOEJCHv8a9SU+kOaLXALcTus
	WjYnw92KL4A6enE5/vLypQzL9N9mRDLnphZcehPxY0kiMZJITMPrizTRAE8N8FQiwQi6V1+Tk53
	Txnr+5IvFmMO2mdAGVn7TDFn1WbtkNd8f3+ovbCBf59DIBvi1OEczIAzJ/TumTh1ONalFMS2pO6
	YDU5vgPc4VzIxPHWjERpGVY6GCwNpaAVwR4eOHU7NlB20X52IX1OsIU0P1nO/lTnKerdjAdy08/
	0BRoqObozXn9RnR4PDfZIAhVcOGyPw/DR7cYIoisRU1tQgaY/kY/h4ri21hc17j1YqOrrBbsO0+
	wK7EGywzCSSVjzJwBdm4+/mZ3N7NPG8ihFCOojjfL73a/31k/788i9ET
X-Received: by 2002:a05:7022:f50a:b0:144:eb46:be0 with SMTP id a92af1059eb24-1ac5cb19684mr9393895c88.13.1793552463413;
        Sun, 01 Nov 2026 09:01:03 -0800 (PST)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:b5a0:ac44:5583:ef02])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm25456350c88.8.2026.11.01.09.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 09:01:02 -0800 (PST)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: Kelvin Zhang <zhangxp1998@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Kalesh Singh <kaleshsingh@google.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs/proc/task_mmu: check THP exclusivity for each subpage
Date: Sun,  1 Nov 2026 09:01:00 -0800
Message-ID: <4c1b393a4b04bd94e4f1c7879ae04e1793eb0931.1793552446.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
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

A PMD-mapped THP can contain subpages with different mapcounts. For
example, after fork(), the child can unmap only part of the THP. The
parent retains its PMD mapping, while the remaining child mappings
are PTE mappings.

pagemap_pmd_range_thp() passes the same initial page to
__folio_page_mapped_exclusively() for every pagemap entry. With
CONFIG_PAGE_MAPCOUNT=y, this applies the first subpage's exclusivity
to all entries, falsely setting or clearing PM_MMAP_EXCLUSIVE for
subpages with different sharing.

Pass page + idx to check the subpage corresponding to each entry, as
was done before converting to __folio_page_mapped_exclusively(). The
index already accounts for reads starting partway through the PMD.
The conservative whole-folio check without CONFIG_PAGE_MAPCOUNT is
unchanged.

Fixes: eb16876971ea ("fs/proc/task_mmu: remove per-page mapcount dependency for PM_MMAP_EXCLUSIVE (CONFIG_NO_PAGE_MAPCOUNT)")
Cc: stable@vger.kernel.org # 6.15+
Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
Tested on x86-64 under QEMU/KVM with CONFIG_TRANSPARENT_HUGEPAGE=y
and CONFIG_PAGE_MAPCOUNT=y, using the same test binary before and after
this change. After fork(), the child unmaps the first, second, middle,
or last 4 KiB subpage, while the parent retains a PMD mapping. Both
bulk pagemap reads and reads starting inside the PMD are checked.

Across three repetitions (12 cases), the unmodified kernel fails 24 of
84 assertions; with this change all 84 pass. Fully private and fully
shared PMD controls pass before and after the fix.

 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b87d3e86442d..da4319d972e4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2038,7 +2038,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 		pagemap_entry_t pme;
 
 		if (folio && (flags & PM_PRESENT) &&
-		    __folio_page_mapped_exclusively(folio, page))
+		    __folio_page_mapped_exclusively(folio, page + idx))
 			cur_flags |= PM_MMAP_EXCLUSIVE;
 
 		pme = make_pme(frame, cur_flags);

base-commit: 64703f0fee7421f0ddfcbd8ee1bfa53b25ffc4ca
-- 
2.53.0

