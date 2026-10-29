Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793241774;
	b=jCunnGYru9gre/bYrvfNVlzqpIKLyCpMH6rbxky3e2HMAA7/zvjorIk3Tk7vFRQA53Yo
	 vbBIY1tV6QUaU5CJmNqytCLehCyPPuacVcG5MTMvQ1DjZwo48axOTd8vMhhRnSK7Ql/50
	 g7o+zqS8icxjhMPnsjJwmhIqY8uQZHF+AfuqZBfdMJdJ6OdjsJG/NdPPRHBSbpRxwZd6p
	 X+uvAZ5fkhqFa5ltyxVlbYIKdjivjyykNJxMVPeztGFN5HKCIc1wv+/t8Wz/qAW8EvsYG
	 k6U1saYcId/08sz3Fmf7vWcjAm9T5iWPljDsrzpehcDCE3ZiEZsis+/Hw33hALwD7rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793241774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=li6JwHU0iWRxuOXLh3ZiIpZVFgZFIl6/9VTBe15UUWc=;
	b=D/270UkmVJAWqPpzrzckO/5EE9RCdyTZ0RUGkTkfshl5s92F/q/OE/GRTpzv5s6j8zrh
	 Gd6MybdyAJTc5ls1XUAhDRq2jtqmHCgns+0YQaV8WJA+W2NkyMY5RooIiffNKcVedNIuz
	 iV03Ki3xKsxmYBZen3j139MjAtVKXXOovZV11KnrxAb/sR1CWJLFAm5aEIzUQRqHtEB9z
	 0iNJUB9IKGmQrWXtLgaSmeIfT7OxcUIVIO9kxFn4ToFHYqHFnOlxV/y57OjAF8Zl5PLtU
	 ht++ukIqZQZOUjukM36arzltAfHd0BW3dV8Id7s3SIPVWAS0azkB6g6cUq1JHEI5kow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KWY6elZz;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D9E606A320
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 02:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8D9E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KWY6elZz
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eac01ff101so594884e0c.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 19:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793241773; x=1793846573; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=li6JwHU0iWRxuOXLh3ZiIpZVFgZFIl6/9VTBe15UUWc=;
        b=KWY6elZzkkw4orAxy35St8JuB6yvMwapHJuKAW272znFbnFoivbkGo2XjN5xVX6g07
         o8/4fhJMNmMUeatblP2+DoaAt5kd/A46jDfu/YN6lGHSeA5czAnAnZTABnlNVxegP/8O
         oS0/ZrZBvEBtGq7s9oyQMc2/P7N9QvR3YPI2rtMdX91e7Mp8rrx2xIMqIiZ9wH1iuIB3
         YQ5QvN2uOI03h96G15Vs/xouBlaWxcedU7qx0kt2RuBB61dXR4T9IvDfS2lbd32f1fcV
         pFar0iqcz1TowmlrW0p+oawG/BAzpNMBcw/j+JXVksyRyaDsuYIwKgaWflat09mwF7To
         oRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793241773; x=1793846573;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=li6JwHU0iWRxuOXLh3ZiIpZVFgZFIl6/9VTBe15UUWc=;
        b=rhBO3mVmcp3nKVX5vZYahl/fFXELB/GXPt0LpSrecaapj1D7zm5ElTNkLwYvOJJjD6
         VramFWxdRDe2BjqXBzB1ss3BDz/wsfQ/s2MUnxSO5LUfPoPQcw3lcB03dNNDBhsQTKQL
         WLR6PLdW+Z0MvERP+/YNHYJCRIABxUSrxAiTOH+D57iKS/kzwTh122tOy0dojkHwh+gK
         tUWYpOuoWnu5WVGNkOqD+fCmvwG3gS4jWHgv+3/cq/1vXwNov/e1xeVKH3h99YfbRPKw
         AEdwMcR8yNo4FHJ+S0aeALErK/toClebAh3G581d7MEkDMAGf9kCHo9Pml2LCDY2EPM3
         Aaww==
X-Forwarded-Encrypted: i=1; AKwUvBxOimTEhPxRx1h2IMXZwuYFDXamVAt8Sm86XESI93WXKZ7wK/ENfUizkYCDvk3rkJRo74PcJjWucSWiuGAY@vger.kernel.org
X-Gm-Message-State: AFq9FYLk7XwpqvqMVZA0fKfGeGp0LV+TOSqPp9mfHZIKhKQhKI4cLrDV
	TkhIHN/AXM9jv8x71o2cSdVZOL9kNeVWLmuk211d2amvIyvp1tKGwiG3
X-Gm-Gg: AYBFou33wf7ma84QFCPRjZSzh9JccSYyw0vrIh83lYCkNYkPuP9yQMokKj1LqtepGZG
	W/EmfAYTgS4DYeXZCezsfw6rq/bsaYH80uX9g6TDeVCHB6stpQHpLawymR02NKA1vRr3tGnqZBN
	d3avNTqPAqiSuillVcR6zPxNk5rUMeA+Ow3CVZGwwkFFVSr/EqFWz2AIiSJWBjXKWtVJjIjh3aH
	800+AoblP1eN1z6NVCG0bmYPBaEcv68kAONwUnDoDOG0InbiLMUgEwEJLn+q+dmbL9q6MiDk+vk
	m1vsD59MLNW+RDYWrhbWDHjPpw/k2X3lkFCCYi601uEuimUMgDlwtkUjft0kqU111GpGjF/Md/C
	u1oWmyk2a+gaaZjM+VapeWWw10IP0OR1Ekuiduqm6zVnfkGjWPTpWdMrlNCODXfZeRjLRQ2B1xd
	76KYEQdogXN+ayvW8DF8tNWYBSGG3wFTMrTl5jqZ4XsZFXMrAozpEI+YIynJHLhlbVO7kPvDULI
	XI6Qf36FVIeLZahl82H1edUu5xZWV9GMa1qb+pfhfZlTR/+QM43zwFoQySyM07WO72Ty0cI7Mg/
	8ZSnQgDpZPIxYY2x2PVzHZ+fkxUJG5MC5ZQtmow+RrWHvq58NvN47jrgl7SzVnoKzLYPMfQFtXw
	8PrCa1TpmTo3Zn8P8UcLKTlja+SRL
X-Received: by 2002:a05:6122:e20c:b0:5ea:9218:eac1 with SMTP id 71dfb90a1353d-5ec4cccdb04mr1920518e0c.20.1793241772644;
        Wed, 28 Oct 2026 19:42:52 -0700 (PDT)
Received: from macbook-pro-de-joas.local ([2804:7f0:b101:c5e8:7d75:cb37:7054:6d4b])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec57fa451csm1790680e0c.13.2026.10.28.19.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 19:42:50 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hongbo Li <lihongbo22@huawei.com>,
 syzbot+91e1fc35f51774c479b2@syzkaller.appspotmail.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hugetlbfs: emit hugetlbfs_free_inode from ->destroy_inode()
Date: Wed, 28 Oct 2026 23:42:45 -0300
Message-ID: <179324176522.32673.7602596908234555806@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

hugetlbfs_free_inode() calls trace_hugetlbfs_free_inode(), and the
hugetlbfs__inode event class records inode->i_sb->s_dev.  ->free_inode()
runs from an RCU callback (destroy_inode() queues i_callback() with
call_rcu()), and Documentation/filesystems/porting.rst says that this
callback "is *NOT* ordered wrt superblock destruction; as the matter of
fact, the superblock and all associated structures might be already
gone".  put_super() frees the superblock with call_rcu() followed by a
workqueue item (destroy_super_rcu() -> destroy_super_work()).  syzbot
hit this with the event enabled:

  BUG: KASAN: slab-use-after-free in trace_event_raw_event_hugetlbfs__inode+0x45b/0x4c0 include/trace/events/hugetlbfs.h:36
  Read of size 4 at addr ffff888038850010 by task syz-executor952/6134
   hugetlbfs_free_inode+0x15e/0x1f0 fs/hugetlbfs/inode.c:1182
   i_callback+0x46/0x80 fs/inode.c:317
   rcu_do_batch kernel/rcu/tree.c:2650 [inline]
   rcu_core+0x5f0/0x1220 kernel/rcu/tree.c:2919
  Allocated by task 6134:
   alloc_super fs/super.c:326 [inline]
   sget_fc+0x1ba/0x1f60 fs/super.c:874
   hugetlbfs_get_tree+0x1e7/0x2b0 fs/hugetlbfs/inode.c:1431
  Freed by task 855:
   kfree+0x22b/0x6d0 mm/slub.c:6923
   process_one_work+0xac7/0x1b10 kernel/workqueue.c:3495

Emit the event from hugetlbfs_destroy_inode() instead.  destroy_inode()
calls ->destroy_inode() synchronously, before it queues the RCU
callback, while the superblock is still alive; hugetlbfs_destroy_inode()
already dereferences inode->i_sb there.  ->free_inode() is left with
only the kmem_cache_free().

Fixes: 014ad7c42a69 ("hugetlbfs: use tracepoints in hugetlbfs functions.")
Reported-by: syzbot+91e1fc35f51774c479b2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6ae27525.5451848c.f7707.0001.GAE@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
Tested on net/main 94cea342e891 (arm64, QEMU, generic KASAN, tracing
enabled) with the syzbot C reproducer, which enables
events/hugetlbfs/hugetlbfs_free_inode and races hugetlbfs mounts and
lazy unmounts with open + unlink.  Without this patch KASAN reports the
slab-use-after-free in trace_event_raw_event_hugetlbfs__inode() from
hugetlbfs_free_inode() <- i_callback() during the first 10 second run,
on 3 of 3 boots.  With it, 12 runs over 2 boots are clean, and the trace
buffer still holds the hugetlbfs_free_inode events (about 46k per boot)
with valid dev numbers.  fs/hugetlbfs/inode.o builds cleanly with W=1.

The event now fires when the inode is destroyed instead of when its
memory goes back to the slab cache, one RCU grace period earlier; the
recorded fields are the same.

 fs/hugetlbfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 6656807..27a3937 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1179,12 +1179,16 @@ static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
 
 static void hugetlbfs_free_inode(struct inode *inode)
 {
-	trace_hugetlbfs_free_inode(inode);
 	kmem_cache_free(hugetlbfs_inode_cachep, HUGETLBFS_I(inode));
 }
 
 static void hugetlbfs_destroy_inode(struct inode *inode)
 {
+	/*
+	 * Not in ->free_inode(): that runs from an RCU callback, when the
+	 * superblock the event reads may already be freed.
+	 */
+	trace_hugetlbfs_free_inode(inode);
 	hugetlbfs_inc_free_inodes(HUGETLBFS_SB(inode->i_sb));
 }
 
-- 
2.39.5
