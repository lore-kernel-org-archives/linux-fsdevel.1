Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A053AB26D
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787301334; cv=none; b=oT5xuUCCPytyR5PJD4J5TTfmz1914+7SXjM2ZmJAQz09RseuSkXPDEWT4SqxPmAafmZoUQrXzyIvHLt9zqL+JEblxLiQSBBKmDv6ritNUpm4vYe+vBnZF7mxU9wbyn16HvApe0Bx1eizVQNuihclzQQY80olRmMNMCmhgfAofps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787301334; c=relaxed/simple;
	bh=youOxFVddrhWr74tg/MLalhJaYF6HucpgLWmoRiHfYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7PW4iZo307481YpFEnNMhZqxnvU7T78RW+BAK4p2GFlkoCtuVACt9iGK0UABZR/SzmGo+L4KKvj4X0XWbAYJ4jQSrhP0dNFiOwh1rIRKLDsqxMDAWBQRox5D1ThJyNikh7cJXpnFCh76fR0rWYCzUV7BvWy48MEwWKsJVNRnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxamdwQ/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxamdwQ/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d560775ca2so6216095ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 01:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787301332; x=1787906132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LJo+VFODNoZcuVrRZgNruXYVosZL9AlBhzltP1KWSy4=;
        b=RxamdwQ/o+iHZjf2cbDgYvTLBo6TSCw2/7spKkeYqNvOceWan8F8W0Kl41ww2Bd6jw
         u9ujmZn+fgZrPL/zjnZKyHAHU8EPIj2E6fld7HiJn4jWQq4LjwZSe6tQfmvzPlUfs/74
         C388uu3AlWESftK3e2FpN2lXQnaHjtlZPKEwen1UuJIygHRZQBENXYD/5Lj+sqvZSI18
         8+ahjloOvV/BwlwrjVodQO5/7Irpis39NcFdBJP9B8XhxytlGNmicX6ACRL8lorfnJRg
         l2QSvLnZh72uyjf+ps5OmJd3IDkGcmLRHUyS6/ypftT1wOoEHcsNXlC1as9vyce+UX8M
         9xoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787301332; x=1787906132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LJo+VFODNoZcuVrRZgNruXYVosZL9AlBhzltP1KWSy4=;
        b=MHj87JUSN7IJpoOdMMuMFFdXUUXAxmncVfUYl9Kh3CE0EEfUw9cIlQmgTIx4FIyvGz
         Fg88PLw+JXHTA2ct3D58WD9Zt322tjBKsTtHzjhLrkjOYJv1koIj/UK8tB7QWDjoDwKx
         +ZslxrZpmHLTtERa0bGUlrXb3Rp1sBkbI59DYJQY+fc5r9WGIJDSflOqjki83KV1YkdB
         Th/xkYvsuct4OtDZvtghxdhW555at/8xKPLnslSnJni1NVK0EptQt4ZlM6mcE3WpFpjF
         LKI0aVE7g7FV9QaNfySnmkmOcdvA7kJg4hO7JURCXlden+ekbaFSsmWGFW/gIJAWDvK8
         M4vw==
X-Forwarded-Encrypted: i=1; AHgh+RrslN1MzKKW76WGm9V40TGVWGmZ7ojF/HtIZCHCYRsDHfAXS2MbEg7W6zCJWDhjCEt29G1cwPghwID7uY2Y@vger.kernel.org
X-Gm-Message-State: AFuF++l/G6K5CpcPrv5CwxTHpl/+EuzRvrJKG4DfX1kTivQAVA3nBMIH
	pCpqsntQ8tJG3fBjV0Orf7D4W1PKHjuHlV/OW5YBAtcDNMwf5HnhCMoouW3gcw==
X-Gm-Gg: AR+sD10Oz2Z69QYr99Dvxapd9CQonw7JXB6MTFO/1T/f3wzJ+fiAyvCy0X/MTsCn0TR
	h56q/rmqnYiRe7/bJDPYntnEnMik+3t+lUmEboRUZJtuL1vMNswbmnjqO/tfM5/BPu+5zlVA+Zy
	WdtzQg1FNo7Ptg6w3icxuu9734nA1YLQujKiphg+ILM1hcNFO48cxlYtK8DwjPcpbwGkrwaif/M
	diOao+uwwQxyD1Kbhjr1znAgjAdm1DNJBYiC44z6hBeLmoc5zLPbgmB0BYnJNc1n1N55+uZ1FH/
	ViC4p5775SZmaXaElWTU8TNVavwxfMwI4nw4ylIEar3FH9EOXcHBTMvWRYQr7zv2z7pZ8qsfz55
	hkJ4+1tsgifpa9ASpGqRUGOmYTdhXzefLk81r46LgVuv6IBkcpe6Bkh0os0StEn0d5Up1oL7zqE
	2Y4wx7/4hS7/KS7oAl3X4cjzm/05uHXafn0TvDw8TebTCnZwwLyT8yRek7oftueacqXP4CZuji0
	OrteVM=
X-Received: by 2002:a17:90b:2f0d:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-395c3561a6dmr9048161a91.10.1787301331934;
        Fri, 21 Aug 2026 01:35:31 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm599575a91.1.2026.08.21.01.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:35:31 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kairui Song <ryncsn@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm: swap: drop dropbehind swap cache folios on writeback completion
Date: Fri, 21 Aug 2026 16:34:50 +0800
Message-ID: <20260821083500.856970-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818163221.589352-3-alex@ghiti.fr>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Alexandre,

I have a question about the reference ownership/lifetime model in the
synchronous-IO case.

Consider the synchronous writeback path in Patch 3:

  zswap_writeback_entry()
    folio = __swap_cache_alloc_folio(...);
    ...
    __swap_writepage(folio, NULL);
    folio_put(folio);

During writeback completion, Patch 2 does:

  folio_end_writeback(folio)
    folio_get(folio);
    ...
    swap_writeback_dropbehind_folio(folio);
      llist_add()
      queue_work()

With synchronous I/O, is it possible for the dropbehind worker to run
before zswap_writeback_entry() drops its reference after
__swap_writepage() returns?

If so, the worker will attempt:

  swap_dropbehind_drop_folio(folio)
    ...
    remove_mapping(swap_address_space(folio->swap), folio, true, memcg)

while the caller's reference is still held.  Looking at
__remove_mapping() in mm/vmscan.c, it expects a refcount of
1 + folio_nr_pages(folio), but the extra reference still held by
zswap_writeback_entry() would make the actual refcount one higher.
It therefore looks like folio_ref_freeze() will fail in this case.
Is that the intended behavior here?

If the removal can fail, the fallback is:

    folio_clear_dropbehind(folio);
    folio_add_lru(folio);

This appears semantically safe, but it means that the dropbehind
optimization is lost for that writeback: the cold folio goes back onto
the LRU and has to be found by reclaim later.

This seems particularly worth checking because v3 intentionally removes
the synchronous-I/O special case from v2.  The cover letter describes
that special case as an optimization that was not worth the extra code,
which I agree is a reasonable direction if the generic path is
sufficiently effective.

Could you measure the corresponding fallback rate on a synchronous
backend (e.g. zram)?  The 99.996% success rate in the cover letter is for
asynchronous NVMe, so it does not tell us how often this particular race
occurs with synchronous completion.

More generally, I'd like the reference ownership across
__swap_writepage(), folio_end_writeback(), and the deferred worker to be
made explicit.  If the caller's reference can overlap with the worker's
reference, I'd also like to understand whether that is an intentional
and acceptable trade-off, or whether the overlap can be avoided without
reintroducing the synchronous-I/O special case that v3 is trying to
remove.

Thanks,
KunWu
