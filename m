Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A424B4865
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948627; cv=none; b=bhxtJmplDlxmYNcu/1PRTCxnq7ODqjpAqbEdjy3LE8nAUvDo05I7iDrZIejQM171EM+jpTqLX2TRx6fcK6ZVSZBmcp37OQoZSPuE4lWF8Flw3aqY7w5UF27cl/oBBz4BIos8L/scwxvenZ5PTxlV5x+EO2pW3Ui51jjJWHAYLfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948627; c=relaxed/simple;
	bh=1gndqcwixIf69ERl83wZ/ahlq6SVahr40TbASWBQcgI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L7ZYfFOM6Ni20urEsr0Quyr5zkl9+KapkEO6ZN+HGWKcb5yeomzRWoc5foGJFhc4PLDr2Pw5ePeEzPgMVJYEEgq2rDU9i3nvaYZMtAremMRapR2/4BIEKbs87rRjRZKztZ0pDqy6DK3gPvs/AtOj6W/d+b6C/3mSPiwRoUMl/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bgff6UGd; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bgff6UGd"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66fcf87897fso4320175d50.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 03:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788948625; x=1789553425; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsHaeoqxnMhy2GB3rUAu2bzr8hj8izpjrzp8bJJzBnk=;
        b=Bgff6UGd6F/BxFyng4Kl/LyCtan7qCWYfurAm16dHjBKg/yW/+EtIiHOldFnUPsRy9
         LaK3d/O6kMKriCN/VVi/dvv+tdmDyzQJdGzAk+Jue4tQkTS3ABctBnM8dev21qLBxlev
         UliqiGTMuPygDF7R613arm5jJYiO4tVpEoUWk2V1CSrw94a8RFIqnhttpr4AflIQbk/Z
         NoGUgHHTEoDXU4DAU7Y81b6VuqZnehJY5C1AIOlh3KQseylO9XxUIpZvO1RpgvWw2TEV
         qiIrxuhxLDHpL5q+jGjTFzLrMdInp6PfYEz2zvvhYvsDoZ+vtg3xKiP+amY+WOI3s0BC
         pwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948625; x=1789553425;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lsHaeoqxnMhy2GB3rUAu2bzr8hj8izpjrzp8bJJzBnk=;
        b=RSu8vNNNWyxLRtRR+e95m92nOb4YmakG+oFC9wpWfXeo9kgyUFTis8LSecDQIOashS
         rqedpRzHPrpfPM9l4SQT/+7oHKwDMUrx8MQGsKlbVEWgWC6bRGS3GRWUro3zpyCtFpEK
         uWXzwtvlqrHTARVTEv9xxyLpF32g1kyNZXnZesIT634RXrW5wt8fFvxx5jmkcK0JgJBS
         hfYiRhTTdebWdvB4DlhfWK7hohSFQR2acSDxr9+HUDgG9qGPfZayIA4weLurtw5L2RmV
         UqHkYIQUprJMw6oA3kei2a2bLXEXZegewDHzl9AgAdq6NDiNovUV3ueciAoyvz4PKHxY
         WvCA==
X-Forwarded-Encrypted: i=1; AKwUvBx0JyCG+A8nz3sLrNzjps0uAysO+LwYQEENjXtiPDSRaJzKd9OxX9tHMYgk1fYYcFyjDowDc7aaohfliSu5@vger.kernel.org
X-Gm-Message-State: AFuF++n0wW/EinMYLUqhLDwEStebNSq4i8A9EJqqJ6PTMW6phwHtAeAB
	dgpMDFJXCzYhd6PimtlFNgAqgGqjZuO2KT65ytdPuVI/0F55ZIBYZHqtH7AXexeaxg==
X-Gm-Gg: AYBFou0NUs0+3lBiJHFDNj8tUETCZPmCfutn/55S87Rx1Kt40/mXW7zVU3b1aKkgSMC
	gBDhcStlOvjJNt8+LIcmEMIP+cpqYc+/ZF5uGhi/BlQ9S8uCQPE8zljPiALB9tHb5a32hgkjs6l
	2S0YnuRKBLuD59G4S5ja5dUL1PIwQObk4Sv/c7Ueql/0SOysis6Uv/S+egWrYciy/cFanf3JvCr
	ntG2VpUX0tQtuQHeQ+cBYvXchvUah9cl9BgfHsGqEygWFOrwIMcWPpKLRxlTc28gr6dJW4Ghu22
	vJ+UVmQF4tVyZWLGdXSN9xvYENg8PDldJPMatynMbfpOX4aou6xehStATKPFoAuTuW086n81Fxl
	DTlgHZ2BAvhePmCDvk03TDSdui3cb7sK0jV0o4MUzeAEB7o3TITe004lmTJEfTWXi+jHVtVIm3P
	lG1dSlrFm8lO0Tv3drNulKVmWKygBLx86QXBz9ipmv83iKkqpYp4ymHKoVQtr49sae24nPMiZqI
	ZjLocE/WNNMEZzwVmzX103AyYhKrSZ86TRCF5MfAN72DbDqBDf8kga0FWc=
X-Received: by 2002:a53:ad49:0:b0:66f:c1bc:4095 with SMTP id 956f58d0204a3-66fc1bc4852mr7414444d50.88.1788948624105;
        Wed, 09 Sep 2026 03:10:24 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48b374bsm12096623d50.3.2026.09.09.03.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:10:22 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:10:17 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 14/26] mm/fbatch: no lru_add_drain() nor _all() for
 memfd_wait_for_pins()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <5b393933-b097-9d70-be09-2d00c8d62f6b@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

memfd_tag_pins() used lru_add_drain(), memfd_wait_for_pins() then used
lru_add_drain_all(): remove those calls, no longer useful now that the
per-cpu fbatch references are gone.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/memfd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index c708d92533f4..064f24dcddaa 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -40,8 +40,6 @@ static void memfd_tag_pins(struct xa_state *xas)
 	struct folio *folio;
 	int latency = 0;
 
-	lru_add_drain();
-
 	xas_lock_irq(xas);
 	xas_for_each(xas, folio, ULONG_MAX) {
 		if (!xa_is_value(folio) && memfd_folio_has_extra_refs(folio))
@@ -168,9 +166,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 		if (!xas_marked(&xas, MEMFD_TAG_PINNED))
 			break;
 
-		if (!scan)
-			lru_add_drain_all();
-		else if (schedule_timeout_killable((HZ << scan) / 200))
+		if (scan && schedule_timeout_killable((HZ << scan) / 200))
 			scan = LAST_SCAN;
 
 		xas_set(&xas, 0);
-- 
2.51.0

