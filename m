Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7948F03F
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949233; cv=none; b=CiPvVnqiNahKmD+GwZJja7O2aaAWXuUiJ3nPQilJELbkOv4j7df7wRjVZEod8Rv+W37sb1zvT/XfYWOsiRL68RQ/9B6P3kPhUkNbJtMAWS1p2bOdtqfcD8GGEempfMTSkhWtwpmSngpPrsc2RvdUzoSpiGHmze773V1TCwRaOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949233; c=relaxed/simple;
	bh=rPfdB3AFtBKPw/1Uy2omaI9Rtdatgf/EWcjp6PUwumw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RyPE5fAC3z+fUa+2sR+KFHJCOQTqaVbq8Too2k1GV41YPeAh2jhhVEcXNzDlQ9F2Wzs9dDHwygvBa2SWNxo/TEYRuMcxXEkknGaQ4dP7HKv5kvkT/cCT8CasdnY6CjoeR7fF+7GdOhtbB1/da5kvNdrjQueSiIotsM+NaOukpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tT9Fz2UG; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tT9Fz2UG"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-861f30636f9so85091387b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788949231; x=1789554031; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4U3+AfBAvn6B1ULZHKx9lvgAuWRYBVO83SclUxbDGr8=;
        b=tT9Fz2UGnxETlTmbyHAwZYaiPWS5B0cx5KG3uw+zIkiDXB4fxFV8HteHjg1CMJvcNE
         9Bv0QNlYapPVNxSE1zPdcr2zLNj/dQrH48dgU4rjjuv8PSeMBv3uc3+aKfxjwcnAFTTx
         Frgio4lW8raBbVZkfM5QT2i9GZaj2Miey2MReEoWuQfgvVOa9CsxC/HeLX0MzmYlWq06
         IGFKtqqJMntut2fy7aSV8czLI24+O+PB5sKQxQxtcI+Ge3ATfkB+jB1htGM7dGQPG2vS
         vn9BkOnMOIGre7A5K/55B2TwyQQA65k8AFHVQIpF/B1FUOiztBt1LXVQZ9BBca79zezB
         5L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788949231; x=1789554031;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4U3+AfBAvn6B1ULZHKx9lvgAuWRYBVO83SclUxbDGr8=;
        b=OcnWS7GYp7JJpUwvTVPVNt427DYWhsK89CavsinUW/7bgZqgYAx48tTnQnpm6Y6xhY
         1g/dkRgGQV0YLsLpTJ8bo7rHYfzOFWDFs9vSnwZx14J42Eqx0x1r73kBeN1wGh5LFH7O
         nOU+moTMndyaSgCu0bypOTIzt5G+4PZAHuPGy4MrVZbHSIDLPPIFEXfL5aHJ77YQTJZQ
         NzcQiB9gVrNHZ7PjnqY/cGsOopNmbroFeXKWZP+BY7yT4wrf4pkm6afDpkjFn8gT9dBb
         9sc3ugOkPY/Vp30rldh/f4FHkpln16XLzFuQBie0QNfY1KNdBwCeH+HO5M8DPoVPuFuX
         VOHA==
X-Forwarded-Encrypted: i=1; AKwUvBwx5YmBUBBuXuP9hhOLEPQRPrj5LaVMh+mGDn0JOyxcwfP64icmNULtZxNUwmHfsBrRUvakKU3UNTg7w4mX@vger.kernel.org
X-Gm-Message-State: AFuF++n9t0m4jcMljUOFv/5qt98PzoTe8dDN75iTdKuGxaggJNNVdpVy
	hjoC66tXt+1obMwe59YhHqYlRLNh2vnfKF+BO/0YnMEqDqBVitzANFGJDcjRN5osiA==
X-Gm-Gg: AYBFou1U2S9yWgx/L8xopLr7phG675duXYkeOzcB5wTyMe4wE4g1vBdd5+GvwXR+al1
	4XGq7ntfxsiGKvk/v3Q9EGB2Bjer/N+CYeYFC6fNL73DGaRoUuZ9FirtF+FTucOweptYZ+d30ml
	CSKYxsW213lKzBnOyo1e54XJPVutkL1pd/zr7zb+3Epc0LifSJ9CA1Snun7/nOxf0/qLwaXTZ+p
	G4WKg+78q2qPbUBWq249oDUr6VpTPLmh9Gld94e4J3G7QrQkvFD2h6tQUBOWamfj/m0xulqqqB0
	6316/BjmHp1SMxXnWUlrDC1m5SO94depe1becBz75RHhUbgmVWDWndSGkJ1vaqDHNbEgxCs8pfS
	l778d2sMrM6hT1BF/vDdRktZNsfHfYtxhroQBq9FyGH3Ic4JOCzkwDdJo8bt4K/Ygr24iWkzT8w
	88v1BkyUaM8J7VI7zDtZ6zQoAzSfnzoJCyXmhY4qg324p4G/e92hxa/eFn80liHnK4UYJ2qIUNc
	7cbWO4Svh0c5+dQ7uSbrBBZagrSnKW+FIDVrKhTh5MqR2u8bLKUqbjIIl0=
X-Received: by 2002:a05:690c:e3ec:b0:877:e47:f399 with SMTP id 00721157ae682-8770e480a9bmr69779907b3.23.1788949230466;
        Wed, 09 Sep 2026 03:20:30 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714a0b6179sm106432667b3.23.2026.09.09.03.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:20:29 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:20:24 -0700 (PDT)
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
Subject: [PATCH v2 19/26] mm/fbatch: vm/stat_refresh include lru_add_drain()
 on each cpu
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <48e09d89-27d7-60cb-a0ef-d2a5ea74d90f@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Reading or writing /proc/sys/vm/stat_refresh has long been a way for
testing to force an immediate refresh of /proc/vmstat numbers: it seems
appropriate that it should also call lru_add_drain() on each cpu that it
visits, before collecting that processor's diffs.

Add that in refresh_vm_stats(). I wanted it in refresh_cpu_vm_stats(),
which would include it in the regular (default HZ) vmstat_update() too:
which might be a wise precaution when proposing to eliminate almost all
the old calls to lru_add_drain_all(). However, that would go against its
"strives to only access node local memory" cacheline care, and bring it
into lruvec lock contention: which would probably displease its authors.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/vmstat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index cb57714539fb..d66cb67f55ce 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1990,6 +1990,7 @@ static int vmstat_late_init_done;
 #ifdef CONFIG_PROC_FS
 static void refresh_vm_stats(struct work_struct *work)
 {
+	lru_add_drain();
 	refresh_cpu_vm_stats(true);
 }
 
-- 
2.51.0

