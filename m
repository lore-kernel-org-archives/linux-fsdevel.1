Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420974;
	b=E4xrNFy/Ax34qhk2Yz7vqGdIgvkqocz6armKOZKH1YNalf0I0pn/yh78K3S7gNN3JALK
	 yc+VeoMkdIy6w6VtB21ygPbSEcwYdOIj0kj580Vl1lHkF8qyE3L70g3AklwFchdl/op8w
	 ypFM+HttprS5Jk7gXloFFKq+MkzgE/iv64LfclXRlObeJl+/fQKYosyLSh2m+UipHohN5
	 CAZMZeNHFp3Gd0g8G0V7C0aT4Pe58RpE3FFTcQqqx/7CJHB7HJ89s8PPaPIKetOBXF3TD
	 hLfh6W4qI3DaPDHF/rPBYgVBQj9Ft5P8dHLN33RdIJnGtROzdV3SpJFtgzWsyhg//WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420974;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=W5Kck5YNf4KPNvVOCAM53kpmBQSPtv2CXzpfW0fAD8g=;
	b=DhXKtU6IyUDMkvEJPl+n6NBGqWNwZ9Lh0ev9iloCZPRpH8qFE2da2DhIUsTev4P+qgvJ
	 yX3E04z2bdxqMwCcqDyWqSTlwiasMH62j2H7sx3hp1TZR7QgVhcUAXP9oe4kCxz3xjDPf
	 afg5ZGHD1TJGykCCZI6/JichiYswUGdjQZQNHz7eJkudnktlbXDr3D2qDrYjiuOLu1IqR
	 6lqZR5kR8pT/WaS7y0BsghuaQqD+l6BO4XU4GJzqSiM5XZ+paha17D832w8FEpo249gOf
	 NM6Dq2rtYqnDkM848+XoNuKZUWAJvmZsXJFKe5vZMIxzmQyaJFU8FjJlvdfacdc+Urw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcvV3dLs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF0606B7AF;
	Wed, 11 Nov 2026 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcvV3dLs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD2B1F00A06;
	Wed, 11 Nov 2026 18:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420973;
	bh=W5Kck5YNf4KPNvVOCAM53kpmBQSPtv2CXzpfW0fAD8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZcvV3dLsSQCPwYRfwfBoW9wgX+tlTKex0lW6/HkaY7UnfPnnj+6kUKMoD5rFcH2bF
	 xP4P67afZJe9pNORZivFELHciaf7tS2Z2TASh9kQDaYY3gDDva/rFJuk+i02Opp1O/
	 nkkIe2J5MmM35zITdLFLEyxWMSvV/NWY99d7kFrCEAfsLyaxvvmi63S0WTMgZwO8UR
	 7MBllNME2pvpSio2/CLGLC0oheSYfAeYEP1D4FrbfKa8/l7u0VD+BukRrPvryjEYKX
	 tHojfGafL1MrUubKAKZgcS383wZJ0qPuCx1gpNeAOLbT1hMzTfoshn4tljEaDTpNy4
	 v32YuTt84iVTA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 11 Nov 2026 18:13:27 +0000
Subject: [PATCH 13/13] percpu: queue the balance work on an unbound
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
Message-Id: <20261111-mason-migrate-et-al-fixes-v1-13-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; i=ljs@kernel.org;
 h=from:subject:message-id; bh=BxMz+HNaCub+x4LAfh02Pe+wON0sxJRzEGhBuO9wXJM=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+bMg5NH1VhvAmlnkvc+v1WVSan1o9aPq3hkM+e+XDo
 Ccd/6696ChlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEpOoZ/meIdTzfcvoJ7xa/
 f/vVvXh+J09bviTWneX55UMKIU4OdcsZGf4yL71fdMNv4dzKrcFxRfs8prTH1vzby6feJ/pmS+F
 XPxYA
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

Fixes: 1a4d76076cda ("percpu: implement asynchronous chunk population")
Signed-off-by: Chris Mason <mason@kernel.org>
[ ljs: tweaked commit message, comment ]
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

