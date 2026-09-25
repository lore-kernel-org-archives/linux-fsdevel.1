Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D23840DB3F
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 05:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314242; cv=none; b=SlhiwYRpef0JsSCE/xrI0+/qLKIl7kqc0S7VyI9CSZDESbrm7bImOerWFA0wRa2jgS0I0wAH0NHlcLD9EWnCdMn0XAGIwqBMmnI3geXNuSo+yBcnwfE8CD9E/MMy9kdzVDX8OhIbuafxDaOWkPuXyWvrEhQCel7X9G2loWsA0HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314242; c=relaxed/simple;
	bh=H315FnVRlAVVUmSZZZV6y0t4NWXrwyaFgel1yCljfd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAW4w+ony9AEgs2+R2Z/Yjn5x5SKbM7fZpL2iSyAdLSaTOi2bKrjrlpU7d+yf7wIH5dCVvi5rewtu5n8fnxAja/foxQDS2gYTfIKHNQMLqrWNen1UGF70gsT+EGwo3AjXWU93LxdNK4abQS5UFIRZxa7PfFlS+fnN+HR8RoXbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=modal.com; spf=pass smtp.mailfrom=modal.com; dkim=pass (2048-bit key) header.d=modal.com header.i=@modal.com header.b=JMyw5Wtv; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=modal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=modal.com header.i=@modal.com header.b="JMyw5Wtv"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca069c8so2077475ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 22:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=modal.com; s=google; t=1790314240; x=1790919040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UlKVWQYb3wLiMbBgvNkQrBNBTWmCb5vBsI31GY2cd78=;
        b=JMyw5WtvPiZv1Un0hd+/kK6sHb8oWRvQ+BojRRItl8xxcfgYHQW+q07OnoSBjcZVde
         18cedquEEd7Sq+XYlG8An9vM8bODXgfEo2aoamv/Q51fXzyem/xriThJnU8LB5vjwiNd
         +m4z0wCM9N/TBUS+G1xHOyBPkmb6EFuCfDWYzfD0mx8XLD9WJuv06akyTaav7xwtt6Yf
         58OsfyZ5xQWJnopEX1byPHy3VoncGr7uoO7ZsYnhtsV2rXAWIJrX5RZsDWA9IUTsUhz8
         ZUbEZQLExKByhI4VdNUI6XWMGQpfQ3bJKoDeu1x790JbgZCaw2ctf8nkXhVJxBDcDodj
         dSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790314240; x=1790919040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UlKVWQYb3wLiMbBgvNkQrBNBTWmCb5vBsI31GY2cd78=;
        b=ajJIqlayMG9+gPpE8hcRhj7/N3KFfWv9YZSsPvfy13Pt2QOdIlMvCzo1uK+t6T6cPc
         MVxxRXq4II83VqZrgUKTiaUgmOEbL0e/c0lp6zfJuA1sDk9whb0fMoQK0/fiqB6hl1k4
         uo/FzaBEageYxYhPsDvRapTnPgb1U7XaGyFF73e+JhMO/nQg41pfFd8bnS9pFCysKCoO
         QFEH5yDfviIQUJDfz4GpU5YL6upSBWSRSJHAIQbeRDBmTC3qVAhuROlt9iRLSiypPqCK
         O+70cah0nm6AY3wSNGgFKJjKYA6x4zP5wVthtgZYLvg4S3dQNkpnEeRSaeeGB8V9xDej
         Auyw==
X-Forwarded-Encrypted: i=1; AKwUvBwuhdnmRSgs6yGPpA2SFX1JZCOcViorJTU4FqOKaZNj+QrrCbypPdJocCHQ7UDo+3hDhnw1BpGCwBgjwcE9@vger.kernel.org
X-Gm-Message-State: AFuF++lPRxJ3c5GjGEv4cUKZKOjHDrZyDKohhkRSJhLcBkj4U/7wLBVh
	wOL+oJ+RDXzDdT4Ws5nYENpNkBrW0eaufHu8Y7c0QSLYxDbe52FXYgTP/HvD0p/QUrM=
X-Gm-Gg: AYBFou0vuEcvXUb0w9aa+wiYXyithqKCWKmlXom7q1PjEt3UkNFBsN5BUl6yixRNz+f
	fEcxPYvAXVZql/uUwLfflYG+hgWyBVuB1lcsb1p/tB1BzPKtzvF/xjrDBhVlLm4XerjDqSq4QyE
	vMWvUXmcRzSWWxpf7eqlpHfUOTlk8pudo0mY+Kdx2cHzkLL0+IcRySm99h3NzI26FUBMdRVH2+j
	UahXRP9n+GXM2o1z3Er4c7uEKA6K4aNyLNeLu7TXxYjGxt5b+EdBduikp1NSD7UNBEKTPTLSSxl
	F0QHB7IxYO/zWQEptO2oyxqG2ebVb8SL3sknEa/HNOmjRljGNLbyj8pBo0Y7GOoPeJMXqwmzxyl
	zm33z2ROcd3emKysk63duxZ2VgI1t9XrmLjwaitLluUHaNDOwEnA4G52VCU2A7h31NedHKCXdBQ
	gKE0PDjdMmYWgtv1cofc+fpmP8Hi5MVHDyMzgxnvPyQzfc1CYBD84XcowI0AkGG5poxQ1+FsqyR
	PPrSi9Z7cccoZPxqY0pRdbCFcKGKuJcHB8NewykizKoaR0GR/QPgyKGQG5Tkm7gVszL3k1VMNFK
	aUb01ayvf5RlRdDiubkgKLypeIFy5pp85oIoexy4hx4doVNr
X-Received: by 2002:a17:90b:1652:b0:3a0:9640:8043 with SMTP id 98e67ed59e1d1-3a098ccdd41mr4157923a91.15.1790314240096;
        Thu, 24 Sep 2026 22:30:40 -0700 (PDT)
Received: from devbox-ayushr-01ed.tail5292b.ts.net (ec2-44-242-192-44.us-west-2.compute.amazonaws.com. [44.242.192.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b998dbf2sm2199443a91.12.2026.09.24.22.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 22:30:39 -0700 (PDT)
From: Ayush Ranjan <ayushr@modal.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Ayush Ranjan <ayushr@modal.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kara <jack@suse.cz>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts page cache / rss counters
Date: Fri, 25 Sep 2026 05:30:19 +0000
Message-ID: <20260925053027.1998394-1-ayushr@modal.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net>
References: <20260924061708.1645968-1-ayushr@modal.com> <arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Sep 24, 2026 at 08:34 +0000, Pedro Falcato wrote:
> (please use the email I actually use for work, thanks; not sure how
> you got to that one)

Sorry about that. I put the Cc list together with the help of an AI
assistant, and it filled in the gmail address from your older list
postings; I should have checked it against MAINTAINERS. Using this
one from now on.

> >   - filemap_map_pages() samples mm_counter_file(folio) once per batch
> >     and applies it with add_mm_counter() after mapping; if the
> >     folio's swapbacked state changes while it is concurrently torn
>
> But that cannot happen? We hold the folio lock in filemap_map_pages().
> The folio (naturally) cannot be torn down while we have the folio lock.
[...]
> No, I don't think this paragraph is true. Page cache truncation (via
> truncate, or fallocate PUNCH_HOLE) takes the folio lock for each folio
> that is about to be truncated out. Mapping folios takes the folio lock
> as well, except in the fork() case where a myriad of weird interval tree
> + PTE lock interactions make it safe (AIUI).

You're right... Thanks for the correction.

One empirical hint that may help: the reproducer strictly requires
khugepaged to be re-collapsing the punched ranges (it never trips with
the default 10s scan interval), so the large-folio / partial-truncation
angle Jan raised elsewhere in the thread may be the more promising one.

> Awesome that you have a reproducer! Have you reproduced this on a
> mainline kernel? Enterprise kernels are not supported upstream.

Partially. The production workload trips both BUGs on:

  - 6.12.96 (Ubuntu 24.04, mainline stable build)
  - 6.18.46 + two writeback backports (31c1d19ead2c "writeback: use a
    per-sb counter to drain inode wb switches at umount" and
    f6988c90671e "writeback: bound cleanup_offline_cgwb() rescans by
    rotating scanned inodes") (Ubuntu 24.04)
  - 6.12.0-204.92.4.4.3.el9uek (Oracle Linux 9, UEK8)

The standalone reproducer, however, has so far only triggered the
rss-counter one, and only on the UEK8 kernel. Not on our 6.18.46
hosts, and it has never triggered the "Bad page cache" one for me.
So it clearly does not capture everything the production workload
does. The production workload which triggers this is gVisor, which
heavily utilizes memfd to implement application memory for the
sandboxed application and punches holes into it to decommit/release
memory on the host.

For completeness, here is a production capture of the "still mapped
when deleted" bug on the 6.18.46 kernel (the gVisor workload
mentioned in the report; the taint is from our out-of-tree module which
was not being used here):

  BUG: Bad page cache in process exe  pfn:1be0e380
  page: refcount:17 mapcount:1 mapping:00000000ceb7a77f index:0x153980 pfn:0x1be0e380
  head: order:3 mapcount:8 entire_mapcount:0 nr_pages_mapped:8 pincount:0
  memcg:ff25c58e86be5480
  aops:shmem_aops ino:3180f dentry name(?):"memfd:runsc-memory"
  flags: 0x57ffffd802006d(locked|referenced|uptodate|lru|head|swapbacked|node=1|zone=2|lastcpupid=0x1fffff)
  raw: 0057ffffd802006d ff8c38e33838e208 ff8c38e33838a008 ff25c5f1950be208
  raw: 0000000000153980 0000000000000000 0000001100000000 ff25c58e86be5480
  head: 0057ffffd802006d ff8c38e33838e208 ff8c38e33838a008 ff25c5f1950be208
  head: 0000000000153980 0000000000000000 0000001100000000 ff25c58e86be5480
  head: 0057ffffc0000203 ff8c38e33838e001 0000000800000007 00000000ffffffff
  head: ffffffff00000007 00000000000000d4 0000000000000000 0000000000000008
  page dumped because: still mapped when deleted
  CPU: 170 UID: 0 PID: 947113 Comm: exe Kdump: loaded Tainted: G           OE       6.18.46-modal2 #2 PREEMPT(voluntary)
  Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
  Hardware name: Oracle Corporation ORACLE SERVER E6-2c/Asm,MB+Tray,E6-2c, BIOS 89070200 04/03/2026
  Call Trace:
   <TASK>
   dump_stack_lvl+0x76/0xa0
   dump_stack+0x10/0x20
   filemap_unaccount_folio+0xf7/0x240
   __filemap_remove_folio+0x3c/0x1e0
   ? vma_interval_tree_iter_next+0xaa/0xc0
   ? unmap_mapping_folio+0x70/0x130
   ? __folio_cancel_dirty+0x29/0x110
   filemap_remove_folio+0x47/0xf0
   truncate_inode_partial_folio+0x15e/0x2d0
   shmem_undo_range+0x6bb/0x930
   shmem_fallocate+0x1ab/0x530
   vfs_fallocate+0x17b/0x3b0
   __x64_sys_fallocate+0x4a/0xc0
   x64_sys_call+0x1fe1/0x26a0
   do_syscall_64+0x82/0xf80
   ? seccomp_notify_ioctl+0x3dd/0x7a0
   ? __seccomp_filter+0x10b/0x610
   ? __x64_sys_ioctl+0xbf/0x100
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x40d00e
   </TASK>

followed later, when that process exited, by:

  BUG: Bad rss-counter state mm:00000000283589c7 type:MM_SHMEMPAGES val:40 Comm:exe Pid:939691

Thanks for taking a look.

Thanks,
Ayush
