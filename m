Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175E0322527
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583082; cv=none; b=cWFxrG6Ha2DNmLvad9XuoaTCzsv7qK5lYLkjMrkL50rutbAizViNBbJWDce6rkFzaRyrMetYWYm7dEpJrC747kZFDwC3g5U//cyxOa2FPxXjoQPgyZgvDASbw6L80fWG2FwzjcIc+2yVKi+hKPkV+vxw5fu7NtNWGYpow2OmdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583082; c=relaxed/simple;
	bh=7NJT4klpwyNAMnizim7gBiFUSAGUskks23qiOn/LHJk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BNH6ZhDGL0GJ9hsCATqyj5+FEIWPf99MWqhTJKff7CLxUPCaUxeTgldsdGU9uFuNOoWGtrX5GuqGINOef+DrNPcBr2WBYgG1ABHWKAEHJHIqOaRowIkvC2t04CVDs1bbhww//kXCN9zk3I/YSFgYnnW4ok9Ys7ir0BTPfOsN6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S6ki/Kff; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6ki/Kff"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66c9995ca60so7414755d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787583080; x=1788187880; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBC/SAP50I4KxaPevcH0bVL/Jm4cuaV8N0/RCICjbNo=;
        b=S6ki/KffP0CvW4GdH1OievddahR9ZfFf8YPANe+JjHk1n5WhyjAXSp2eLSrrF81MS0
         vewun7rPdck7G1hU9NpG7nNY167RPfM1oK02Yvkx/obU985dXLQ4KuMUrZylgGAtAsRE
         BdgUc1mSGWpwfTcTETXOExnNb2IQXWIA9t16VebWo3C1cjx1tpxC9KJ/QaGsyXVQyU86
         63RPry+8FEZ+a7ZkTh4+JnbYefZf4LH92gCAcbfMDzflxBOzD9DD+EE6XWDDUN6TwYbo
         plugGwqaZYZJ+gm9flXqaCswhY89IaRl09bCJ1PGT4/tskvt4wx1XxeJwFWCT/DQw9Ed
         QUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583080; x=1788187880;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oBC/SAP50I4KxaPevcH0bVL/Jm4cuaV8N0/RCICjbNo=;
        b=R5y0M+AdpP/XwI+V8uj46hmhEZo85nw+MT3tLtmGfyadJJ5g/peFUbVK46h7eFC10T
         HyV42vZwNhDtYRxvBkUjWcQPOaIdIwbA9S+AvI2uhwgPRvgle54Cd6nWCI8MxBL00MZJ
         Uzccu+fJ1N91sk14A3VffIoJeUsvsWQ/erAK43AdC+7Lz8GwvUYEiBorCgG+/AOGTf9C
         EN+DFTJvWd2LCdzzsiYbtgL4F9D36pDvBjlpQ3rIgUKHt26FihBFqACT8KnS6sBSZaP7
         1fjyJBsqOJSegnnvgSSSsI+9jDmQSJIkC5MzjCrKtZVLWrVYYwuUFWVw9Nm/GLh8w07z
         BIxQ==
X-Forwarded-Encrypted: i=1; AHgh+RrAhgs1VZ7rqJPX3y3niIXNK0aYJkToKXHYkz+FSQMXa5uVqQFBd6u3KKaLNMv6OdJ7tQe1adepqvYCm3C9@vger.kernel.org
X-Gm-Message-State: AFuF++kO1JdZG0QrrZKEl6VM4FlcofZLH+RkqDSic5/uJzVPDEgtZopJ
	4saC+UH6BKTSNQxSUipzROcZ5JaN2yNBr66IiwclFJ99+b6mp5HEKGFfBFx+5Sj3Mg==
X-Gm-Gg: AR+sD13RoBZusXGoqS4+p2+rgOP0f9SdGdcKtu16dlfevULk6U2cCKL/RX6e19LNuf7
	EaSbRSCwRSi/TluoX/lFSned4BSUUqLqrcR2tpmIMEQjSoldZra/9U8TbFL2VVMObiifRSCPEit
	wuB/cAxdjMxkkwgyQQyC496KZ8/Ojxa2Ym5ClFRxVP9jdJSkZXakMBzLqKtriUFCuJRp/2i//gp
	u9TbhUTrwtwmljj2P/s0QHV7jv6/Com2Uo3BYV5DiB9ij2Owx28QzBH2HhY59S07Q67JdQqAgRU
	Tj/nUtCPf2tWIif9UOPnoT+WXCS7O7S3FsA5PjjKECMBgtMTCfxi1tg3hlvci9bg3kqTZ21L0d9
	I0XiODoxnTxvJLxnjS797CNok6bsjnG5bHP7chwhQ6/cghhRxs/I1iznwagRub+fFU+n4QEASyQ
	P5PINpdxjDPWlpQHYZoftZkz+/odhCQIgFO5+W8ycW1hSONS3VDtDX1vJ1lAdtqv7QpjX1PqaUs
	8fJXFfvjLTrJpnxDC/ntpKbJDslRYVLCWeRNCgo2nbplsPwhMVtB0r1qKA=
X-Received: by 2002:a05:690e:4843:b0:66c:e378:bd2 with SMTP id 956f58d0204a3-66ce3780eecmr7793232d50.22.1787583079315;
        Mon, 24 Aug 2026 07:51:19 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cac01868dsm34817937b3.42.2026.08.24.07.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:51:18 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:51:12 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
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
Subject: [PATCH 25/25] mm/fbatch: move lru_add_drain_all() declaration to
 mm/internal.h
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <552d4644-995b-e605-175d-3268b67adb66@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Only mm now uses lru_add_drain_all(), in forced reclaim and in memory
hotremoval: help to keep it that way by moving its declaration alongside
that of lru_add_drain() in mm/internal.h.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/swap.h | 1 -
 mm/internal.h        | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ddfd9b7bb861..94b694328ee7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -300,7 +300,6 @@ static inline void folio_add_lru(struct folio *folio)
 	__folio_add_lru(folio, false);
 }
 void folio_mark_accessed(struct folio *folio);
-void lru_add_drain_all(void);
 
 /* linux/mm/folio-compat.c */
 void mark_page_accessed(struct page *page);
diff --git a/mm/internal.h b/mm/internal.h
index 7a301c401d39..73d618254a3b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -57,6 +57,7 @@ static inline bool folio_may_be_lru_cached(struct folio *folio)
 }
 
 void lru_add_drain(void);
+void lru_add_drain_all(void);
 void lru_add_drain_cpu(int cpu);
 void lru_add_drain_cpu_zone(struct zone *zone);
 void folio_deactivate(struct folio *folio);
-- 
2.51.0

