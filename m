Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0331943BDDE
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581565; cv=none; b=QStNlkm9qKkFNXnmk55Cnsc3SVTIcpFj61ItCw0MQ5mql251eM6ZIKatFIAF5tFgciU1JYWd2sRTaJRCpmxz07qYAD2gX7ooR6B3/X0zU5dOA84WZ6Wewf48/biKBRtAkRxf2YifbMzCKj2cNiK51UY6am15GwPTlr6SytH3HrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581565; c=relaxed/simple;
	bh=1gndqcwixIf69ERl83wZ/ahlq6SVahr40TbASWBQcgI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=s0oT3oHD07gZzAGfJN1gT036X4r1Y4S8fQ5tSRZI/IUGf8Xaha4xxJCBbbqtktXiFIxqOndTcuqc9Jl0C+U6AVOgvkeo3dWID0GLgVDcf4jb7Wwuue8IS4XG7pjVSZzILNvOMRmLiZjRqYRxBH+hidXg25jZznPAPNOvaXC+nXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qtyj8YcU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtyj8YcU"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81ecf499af9so48979167b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787581562; x=1788186362; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsHaeoqxnMhy2GB3rUAu2bzr8hj8izpjrzp8bJJzBnk=;
        b=qtyj8YcUWb3nhbWfFR1yFkoOzDGF3NubYDQbAGYRXxSFU9sFzPTnQXiVe1+L8Ya6Ub
         Y3ABAv8Skeh07ilRLu2LRwBRetxeZ3YjvOwJoSVd+ieEDuHymyt4KK7PyHaLFCez6/yA
         CmYhhc3hG7OddFHnmw1Zds95SnjpsFeq6aR4Wpgl5qB23W0fCz4t9iCoDsh/RU+pcBqi
         epj4aR0lPB6ForXt8ft/Mn+wYMS94Ze0kESzmtAXcUmhlDfYh9lsTD46vBBuJsMneRcq
         DsveRAU02svpn38yxs09ge518OuI/pVdkv3Knis9TnbAIvU4lDhnuCGaGoZiptRruc5f
         /2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581562; x=1788186362;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lsHaeoqxnMhy2GB3rUAu2bzr8hj8izpjrzp8bJJzBnk=;
        b=Tq+o1gTMNr9YO55lH3RHU+NEKB+lb7Hhc9gJzqFco68XfbLu0PezGY/noBVgk0OAB9
         ZlzYGmDuSDAUrFJiaB8byS3j5p304sTNrQOXVcfOkqDb/hSb4lAlexS++0HxyYocptuP
         KPpnM+YkXGzo9M0h+IaffCPpHna8wbHIb+6DOrogtZKay4/E0a3r6PZLXkwg3t4OpbwB
         rJQDkL/07y79C3N6bJugOGOAsfUmybvBnCM+GFuwjH3wf1XwKgxk4g2P18ZbX/Xi7Jfo
         WAR2yoa4KVOrjfi90wzI0nqQGZo8OLqQzo8E4cH6SM2Q6GFTa0ef/25NQQcqmkSFQb1t
         ow1g==
X-Forwarded-Encrypted: i=1; AHgh+RqE6oZQDhMOkiFKBRHYH/VmrmqXh2viDXcj1JuzQIX05//Q17oDpB4zXeqib3pjyAzIMy5z1uoOztjY8Tol@vger.kernel.org
X-Gm-Message-State: AFuF++nOaSupdfZLnmcpczLrbZM4Ogfy1yWGsiDrtUnDtxLildkizLt2
	rOjuRHoIUf//0x6zTY0829dS9wvlyoQ96AuKe0y8AU/CM/xpQpmBouRiiy1KxeC5dw==
X-Gm-Gg: AR+sD10EVJM/o4OKNLXKMZFPuErCMbcAIeM/xTLDj6zwCnvw8PbcElZ1NrhVvN9Plez
	yucdr+NKcnTH1TRa3WQJDLnk9vP7Brreh5+5ZXjDyxlKIk8B831bIXW0X4ynj7olNTrvP5ItDDi
	rJQBA0Asya/dCNs9y8ZHHVfGgd8BsA8GPda2b6lL+arBQXgkq0bepO2IGlO0ol0mV52t5oTKkTU
	Uvd2jdVMh3Jbdl4DXRkoZClBaRkpVo1HX9XrA5iiDF2rF8zLJNhxJ73BZzqIeFfQ28pPGak2DqK
	IUyUdMXRcarKz0GoGYiSD9b/DTGtblvX2vWCNDUAq3cnUk2ZV6eQjcF0CqjdRB+YtjUTp53k4zk
	gpxLlHfUV286G7EyJTCeLqtndPvfLVPf2IB6kRUyps+a5vj8vsM0Q56Q9PBBCbN8DkIsk9TOyqK
	W7sZJanT9fV26Q6/Hil2mG2A5SeG0OcwDiqWolb4QoEfSv8jz0sDTXEgoQ0RKs0urxlvmRYtZhO
	kc3K0unZA3Tw425RPcrW0TNtMlgUcsEDI8TtKaK15xtdB9P
X-Received: by 2002:a05:690c:c604:b0:821:1288:f820 with SMTP id 00721157ae682-84c95591347mr57984377b3.4.1787581561128;
        Mon, 24 Aug 2026 07:26:01 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca68c1b14sm34720667b3.21.2026.08.24.07.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:26:00 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:25:56 -0700 (PDT)
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
Subject: [PATCH 14/25] mm/fbatch: no lru_add_drain() nor _all() for
 memfd_wait_for_pins()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <4bad9833-60f5-30fd-098f-3a306722833d@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
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

