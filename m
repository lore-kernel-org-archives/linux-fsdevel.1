Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32A218ADD
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Oct 2026 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790986749; cv=none; b=Nh/u+px4k0TmPOQMPV16S5pp9/YloRteG6zKuPGnAqxA5Z1ORoY0jfHvJUpePrnHm0+COa9V2QJNpD1K4QFXtf+zEsoTPWvA2zJoPLkkGTASeZ7/AWqfhP3XIdhCgF7mwzY7LP5N6ft2yx2j6sBInyuMqPQYhYcO6VaocxlnRU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790986749; c=relaxed/simple;
	bh=LejAv59+w0LmBOfRWjgurmuY2Ss610ibefUPVKzMFLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQ+7XlUwGtDgyT6sSG2kKjLhJ7vo5K/9nLyypvE2DttalEhrvsqgrQ2gVd8MTDNx0oQ675GQ7TSxZMdempxAzjmwjp82sMe4FAZ/X4RrN99yECzvok2HxFkdVMORZSdQuDB4Pt4M/mfyy7U2gSJ1/U1GRPoB4PKWRH1txA3hj4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm+wafZb; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm+wafZb"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-821a7bee9b2so321983a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 17:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790986745; x=1791591545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FS9XCl9z0DTVjd2kXBwt268wO43LTyKRy6tPTS178aI=;
        b=hm+wafZb4woFkyxDXGw1LEG6Z32OyZp1GbpdeNOCqxpSgV2y/VwdUmy0eUjnjJCIsV
         f8MerwlBI6z6j6xzkYGLsR4f67IN39HORwPm99nSCabAgNyZJBLBKCb7uza9+07jqBs9
         Tuw0g/8K3DNqILRQJ2MHe7Pn9aJLzkQ4yCeOPNn1gT25rZUsD85TNogOnPO0rgsIx9wk
         G3RDVnmvIlOxAf5FQjo4eI/Ic/3lQsKHr3NudRT86QvEAX9vNFZ3LY9HGLiSA+g+X3RY
         oFvDJdIeNoJq+uu/RALl68oQQLqvAx+vmE6w1bcasD6CBsymfmaaVqWe7OaUTqOTptuO
         ESyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790986745; x=1791591545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FS9XCl9z0DTVjd2kXBwt268wO43LTyKRy6tPTS178aI=;
        b=DnmaqQ6dUhqu4+ZCSb66Rup63ogxLd5Wt1iA9BONgqJDSrYzG1hEOJxNkk07duvXeb
         nJHK5wTwFTnu2N1XDrH/T6NNCCd1VCQ42IDsXkbwWAdqiJ1ndGk943gkqnlGPSsnQjaw
         XKn852iw7L4hy4oqBG6HKK2HaycMkV0/nqkrhf6j7CWqmcUCzipv3EceLPqiBUSRUunr
         FmYeJ2y+wCw5HySFd1MYLDhmFNjWilidXcki+gEdic8JHYrXtMwPa/AeNGREpUiIT8nf
         45ZnDPKSD22v1l9dRBE40gLQ105DH/NSad8eBmnymveB60tlz9Lmk89Okh/OiaItvhog
         ppTA==
X-Forwarded-Encrypted: i=1; AKwUvBzBjIpJdX9xuqsczUdLADvELfw9UqGy/gJu1GNWJJ25Ovo7l5no7e/W41GIYMIdQA7aL2txDSfOr29ne31u@vger.kernel.org
X-Gm-Message-State: AFuF++lhxaWRHZO7Rxd9cbs7Z9sQ5pCpGSzWhGIVZJAOg9kSPO1xNcT4
	HbdtYj03Q1cRlc9QdlwWN9LwlqJTY3HlRCQEi7M72A88sTAubbYzmIE5
X-Gm-Gg: AYBFou3+ha7cLLWaUWDH5/A3/JG3+oe48IoYJ8bbCGqwO59XyO8pSM7fnRZckOicryx
	4G2Q8JdmTM4ls6Uw4vJm4abP1FHse/K3vZE6JTGon30N9Kwz7k284kBWaDiEanv6O+A/G+Ioih5
	tjW1lSJkqXsHJ3LcPUI6pd1JK6LgoOGyWDvzkXznzf/ZVaz7XUJdjEV9oRIHxSYR8EATMnf1/1c
	upWQyAuLDn+JeIc7qSEg4KPR5RGJViBkw7p8xMD5UzrH+64v9u6nnqrqf3gSMuFpt1IvBExraSt
	TQZ8ssrCcJKbmrOxhu7NQgL6ArIYWkqMGdddUEAf09qaGsH4nqXOvnJqvuoFgOdWEMr1gCQGm62
	aY70WjxyrKCPjS6AbEimDTFNZpQRBKWDg7HWrRNiQM2SyP1c5H67BpOKc10zyIp5poeO8fU4xGk
	aXSmyrofqfNpnNF6x3b/DTjsxGOxwB8EcGncXcjbURRDnK5TwxPNe4KUgcNZQ8e7Ni5UUqFLtKG
	K6dAmk2Sr69771c0fqfz5yClms3UmbyZWtX8OFeyxnKVCsjEQ==
X-Received: by 2002:a05:6830:7285:10b0:823:89b7:a57e with SMTP id 46e09a7af769-82389b7a603mr1114212a34.33.1790986745097;
        Fri, 02 Oct 2026 17:19:05 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8227a66c6dfsm4498434a34.23.2026.10.02.17.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 17:19:03 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	willy@infradead.org,
	jack@suse.cz
Cc: mhocko@suse.com,
	muchun.song@linux.dev,
	david@kernel.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	surenb@google.com,
	riel@surriel.com,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 2/3] mm: memcontrol: add mem_cgroup_reclaim_for_batch()
Date: Fri,  2 Oct 2026 17:15:54 -0700
Message-ID: <20261003001555.3498357-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261003001555.3498357-1-joannelkoong@gmail.com>
References: <20261003001555.3498357-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some callers charge a batch of folios one at a time, where each charge
may reclaim. At the memcg limit, each one of those charges then enters
reclaim separately. Readahead is the main example. This was observed on
Meta's fleet, where a single fault's readahead window can trigger more
than a dozen reclaim passes.

Add mem_cgroup_reclaim_for_batch() so that such callers can reclaim for
a whole batch at once instead of once per folio. Callers can then charge
without reclaim and if a charge fails, call
mem_cgroup_reclaim_for_batch() to make room for the rest of the batch.
Unlike try_charge_memcg(), it retries reclaim only once rather than up
to MAX_RECLAIM_RETRIES since failing is acceptable for the callers'
charges.

The next patch uses it for readahead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/internal.h   | 10 ++++++++
 mm/memcontrol.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index ff28b940e0cd..6d914f6a6138 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1652,4 +1652,14 @@ static inline bool can_spin_trylock(void)
 /* char-mem.c */
 bool file_is_dev_zero(const struct file *file);
 
+#ifdef CONFIG_MEMCG
+bool mem_cgroup_reclaim_for_batch(unsigned long nr_pages, gfp_t gfp);
+#else
+static inline bool mem_cgroup_reclaim_for_batch(unsigned long nr_pages,
+						gfp_t gfp)
+{
+	return false;
+}
+#endif
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1d4b603085a5..9aea684ea755 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2736,6 +2736,70 @@ static unsigned long memcg_charge_reclaim(struct mem_cgroup *memcg,
 	return nr_reclaimed;
 }
 
+/**
+ * mem_cgroup_reclaim_for_batch - make room for a batch of upcoming charges
+ * @nr_pages: number of pages about to be charged
+ * @gfp: reclaim context
+ *
+ * Reclaim is needed when a memcg's margin (limit minus usage) is less than
+ * @nr_pages. Starting from the memcg that the current task's charges go to,
+ * reclaim @nr_pages from the closest ancestor whose margin is too small, with
+ * at most one retry. This lets callers that charge a batch of folios one at a
+ * time (like readahead) reclaim @nr_pages at once instead of once per folio.
+ * Callers must be ok with the charges failing.
+ *
+ * Returns true if reclaim was needed and done or false if no reclaim was
+ * needed or if the current task may not reclaim.
+ */
+bool mem_cgroup_reclaim_for_batch(unsigned long nr_pages, gfp_t gfp)
+{
+	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
+	struct mem_cgroup *orig, *memcg;
+
+	if (mem_cgroup_disabled() || !memcg_charge_may_reclaim(gfp))
+		return false;
+
+	orig = get_mem_cgroup_from_mm(NULL);
+	for (memcg = orig; !mem_cgroup_is_root(memcg);
+	     memcg = parent_mem_cgroup(memcg))
+		if (mem_cgroup_margin(memcg) < nr_pages)
+			break;
+
+	/* No reclaim needed. No memcg up to the root lacks the margin */
+	if (mem_cgroup_is_root(memcg)) {
+		css_put(&orig->css);
+		return false;
+	}
+
+	/*
+	 * cgroup v1 can limit memory+swap together (memsw). If memsw is the
+	 * limit being hit, swapping a page out doesn't help, so reclaim without
+	 * swapping.
+	 */
+	if (do_memsw_account() &&
+	    page_counter_read(&memcg->memsw) + nr_pages >
+	    READ_ONCE(memcg->memsw.max))
+		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
+
+	memcg_charge_reclaim(memcg, nr_pages, gfp, reclaim_options);
+	/*
+	 * Like try_charge_memcg(), if reclaiming didn't make enough room, drain
+	 * the per-cpu stocks and if that doesn't help enough either, try
+	 * reclaiming again. Other tasks charging the same memcg may have used
+	 * up what was just reclaimed. Unlike try_charge_memcg(), only retry
+	 * once rather than up to MAX_RECLAIM_RETRIES times, since failing is
+	 * acceptable for the caller's charges.
+	 */
+	if (mem_cgroup_margin(memcg) < nr_pages) {
+		drain_all_stock(memcg);
+		if (mem_cgroup_margin(memcg) < nr_pages)
+			memcg_charge_reclaim(memcg, nr_pages, gfp,
+					     reclaim_options);
+	}
+	css_put(&orig->css);
+	return true;
+}
+
 static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			    unsigned int nr_pages)
 {
-- 
2.52.0

