Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606469;
	b=gQWTZj4Ili+6wzDAmEB/j+G2tbS0wIoX7P+vQ3ZV73XAzwzD1kOBH9wFnlSvOrCcYa9C
	 vzjtI5WunBy+ayNdTExA7yxrF8i5Atzp85/79s74jhW8ZUeMNuVFlkFbJAHJ+HcxzZnyW
	 4/bRXpM0PAkN9dAllQjLhOmxqLK96JYr9Zl8joJVtg26PcoYSNdtTQw91FhwckDgLIXqs
	 lDXus5BiQLMxiFHZeIxWp4H3lDulBj/s78HlxPvt0MSps4h0PD+Ho06JUwlk31MuVnA1o
	 mr34/1lp/FXJ6BUQCFc+ufJekECzXgTBjTCG2WgW0irm6XYNTUY/iSDTuZxAfojzblQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606469;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=FTr0n6c29l3InOG/A3dk9VOH2uR0C7v9ShMZ2yynIoo=;
	b=tZPiMyl0zNx7Nrkix4/3wJDkUz6AESQ8rWI9U0TNHyol3oz8UxrtPcID45ND+QBxIkpr
	 RtxKMHJGAXyJLZxS24oO2r6L3VFFcFDDyhqdFXaZ/8J7wR+7RlDw0SZ31N5cH8sINQ3bK
	 IXrJaIQmOSRs9oNGSKGr6bCd0ey5fiOxUYIfNx9MSo6+St6jWL/rHQepUA1Bmn1elLCMH
	 AmaIwbJsfTGnu3juzgk4Vz5uDJDleloZV82+mtrb/Y5o6epmVviCBP+pEFL2F126J1zAA
	 jmVakqqmmg1RuJw7utGImHjBhLb6zHS/6Fw1uG6pBNWtDPmtWE7sEat1SEIFZwunfjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PGMr+Sv7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06673606A332;
	Fri, 13 Nov 2026 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PGMr+Sv7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B23D1F000C4;
	Fri, 13 Nov 2026 21:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606468;
	bh=FTr0n6c29l3InOG/A3dk9VOH2uR0C7v9ShMZ2yynIoo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PGMr+Sv7EKT07nEz9+xiAvd2xjXbw2gGgreuP2uxHhLFmrncYctNU0RdOvNWWZ6oJ
	 ZYu6/Qs7GEXrIuzVpn5qohKdIDVcuD4uoj+y2ONv+pNq74BS6go/1IbjyOpStAeUqG
	 RiGKryzWW+DylAag4v76099Dv75sFjorL8TWLmoQpr8jc90AuLcfhqW0MmF5KmSZmz
	 ow5VDD44nXB55deU738LYpqZOxYLRQCQnTkCntGoxD0OOZyV3k9B23fajP4/JEkihC
	 7ZIdYqrpmOfvGQu/DajITrN56yg6zO0YXw2V244DbW8IJb24JUYfeQX357Vp1fW5/f
	 HBhcITENOpPBw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 13 Nov 2026 21:45:31 +0000
Subject: [PATCH v2 13/13] percpu: queue the balance work on an unbound
 workqueue
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-mason-migrate-et-al-fixes-v2-13-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
To: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
 Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2547; i=ljs@kernel.org;
 h=from:subject:message-id; bh=MLkStZW7X9iFR6kCDpPJLu2W2JH8H1JWN4YejVC+cws=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+t/xSnTCZx/uE9/Jt6v/TeHX8biz5lvzmrKXqRONNp
 0U7MtPudZSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAi3WGMDLtWaec127+d73tw
 07oz5uo6m8qzrdmbPY/zfDHy9fFobWX4xRzjV7gzvJ6xWJV/scB9FvMarcdM++OWP+SK1o981mr
 ABwA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Chris Mason <mason@kernel.org>

A burst of small atomic per-CPU allocations can fail with -ENOMEM while the
machine has free memory and idle CPUs, as atomic per-CPU allocations are
only served from pages that are already populated, and those can be used up
before a worker gets to populate more.

Consider:

    caller on CPU 1                     kworker bound to CPU 1
    ===============                     ======================
    allocates 8 bytes, which leaves
    one empty page and 4088 bytes
      schedule_work()                   woken, waits for CPU 1
    allocates 8 bytes, 1023 times
    next allocation: "no space left"
    gives up CPU 1                      populates pages

The allocator keeps a few empty populated pages in reserve, and the work
item pcpu_balance_work refills them.

pcpu_alloc_noprof() queues the work item using schedule_work(), so only a
worker bound to the CPU of the caller can run the work item.

The issue is that the caller keeps that CPU - a task keeps it for the rest
of its time slice, and a softirq keeps it until the softirq ends.

In that time the caller can use up the reserve, resulting in an atomic
per-CPU allocation failing.

Fix the issue by queueing the work item on an unbound workqueue so that
another CPU can populate pages while the caller keeps allocating.

Gregory Price hammered atomic per-CPU allocations from one CPU with
preemption disabled for about a second, with and without this series:

                           Before     After
    Successful allocs       1,188   131,072
    Failed allocs           4,097         0
    Balance worker runs         0       169
    Successful retries          0     4,096

Fixes: 1a4d76076cda ("percpu: implement asynchronous chunk population")
Signed-off-by: Chris Mason <mason@kernel.org>
[ ljs: tweaked commit message, comment ]
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/percpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index f87813e6ad73..39cba1710383 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -200,8 +200,9 @@ static bool pcpu_atomic_alloc_failed;
 
 static void pcpu_schedule_balance_work(void)
 {
+	/* Unbound, so another CPU can populate pgs if caller keeps this one. */
 	if (pcpu_async_enabled)
-		schedule_work(&pcpu_balance_work);
+		queue_work(system_dfl_wq, &pcpu_balance_work);
 }
 
 /**

-- 
2.56.0

