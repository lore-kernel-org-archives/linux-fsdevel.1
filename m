Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D933AD8B;
	Sat, 18 Apr 2026 06:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776493162; cv=none; b=QjLbiSKWJs5y7j9Xjn+2NWzA9x2WB3UIZA5MEpUzcavJbR6NFt/jHyghFArOLii9BJQhn8fj6A9Wgz+A6Rpd5Z0vgkkqq7vABiSDUZUKhTgSWyGuW8NcRfwinnEmUBIeOqCOKO+LoBsQv3MOyotqxgqNC2N/p0ro+nE4TZzNI9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776493162; c=relaxed/simple;
	bh=iSrVP99yfbGx5vvoO4Vcxpy3Ufy+R5BC2IcalLfv/T4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RMH7ciuxZtBlqoR/wUHiqP/Q5qq5vqny2LBB9PQsVt71kmgonmLq0q4h4Glh0s7BtP69cxF64Oy5KmDdN1tUfbYeMOoMPfZjfRLN/e5QKEdGFz1AYVHqTphvJnnSDgREidU4Y2WuMw6JMxK8snu44Jp/3BtbrRO+qB751E1b2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fyM5W1rhyzKHMK6;
	Sat, 18 Apr 2026 14:18:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 40AE440601;
	Sat, 18 Apr 2026 14:19:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP3 (Coremail) with SMTP id _Ch0CgAHtL1aIuNpBjFHAw--.47133S4;
	Sat, 18 Apr 2026 14:19:07 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	jack@suse.com,
	brauner@kernel.org,
	bcrl@kvack.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-aio@kvack.org,
	linux-kernel@vger.kernel.org
Cc: wozizhi@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com
Subject: [PATCH] fs: aio: reject partial mremap to avoid Null-pointer-dereference error
Date: Sat, 18 Apr 2026 14:06:34 +0800
Message-Id: <20260418060634.3713620-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHtL1aIuNpBjFHAw--.47133S4
X-Coremail-Antispam: 1UD129KBjvJXoWxArWDAryxXrWkAw1DKw1UAwb_yoW5tF1UpF
	WfKF13KF1kXr17uF4DXF4UJFW0vFs3Ja15Grn5Gw1fZws8ZF1UKrWfKFW8ZryUArykJr10
	qr4UAa4YvF15Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07ULdbbUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

[BUG]
Recently, our internal syzkaller testing uncovered a null pointer
dereference issue:
BUG: kernel NULL pointer dereference, address: 0000000000000000
...
[   51.111664]  filemap_read_folio+0x25/0xe0
[   51.112410]  filemap_fault+0xad7/0x1250
[   51.113112]  __do_fault+0x4b/0x460
[   51.113699]  do_pte_missing+0x5bc/0x1db0
[   51.114250]  ? __pte_offset_map+0x23/0x170
[   51.114822]  __handle_mm_fault+0x9f8/0x1680
...
Crash analysis showed the file involved was an AIO ring file. The
phenomenon triggered is the same as the issue described in [1].

[CAUSE]
Consider the following scenario: userspace sets up an AIO context via
io_setup(), which creates a VMA covering the entire ring buffer. Then
userspace calls mremap() with the AIO ring address as the source, a smaller
old_len (less than the full ring size), MREMAP_MAYMOVE set, and without
MREMAP_DONTUNMAP. The kernel will relocate the requested portion to a new
destination address.

During this move, __split_vma() splits the original AIO ring VMA. The
requested portion is unmapped from the source and re-established at the
destination, while the remainder stays at the original source address as
an orphan VMA. The aio_ring_mremap() callback fires on the new destination
VMA, updating ctx->mmap_base to the destination address. But the callback
is unaware that only a partial region was moved and that an orphan VMA
still exists at the source:

  source(AIO):
  +-------------------+---------------------+
  |  moved to dest    |  orphan VMA (AIO)   |
  +-------------------+---------------------+
  A                 A+partial_len        A+ctx->mmap_size

  dest:
  +-------------------+
  |  moved VMA (AIO)  |
  +-------------------+
  B                 B+partial_len

Later, io_destroy() calls vm_munmap(ctx->mmap_base, ctx->mmap_size), which
unmaps the destination. This not only fails to unmap the orphan VMA at the
source, but also overshoots the destination VMA and may unmap unrelated
mappings adjacent to it! After put_aio_ring_file() calls truncate_setsize()
to remove all pages from the pagecache, any subsequent access to the orphan
VMA triggers filemap_fault(), which calls a_ops->read_folio(). Since aio
does not implement read_folio, this results in a NULL pointer dereference.

[FIX]
Note that expanding mremap (new_len > old_len) is already rejected because
AIO ring VMAs are created with VM_DONTEXPAND. The only problematic case is
a partial move where "old_len == new_len" but both are smaller than the
full ring size.

Fix this by checking in aio_ring_mremap() that the new VMA covers the
entire ring. This ensures the AIO ring is always moved as a whole,
preventing orphan VMAs and the subsequent crash.

[1]: https://lore.kernel.org/all/20260413010814.548568-1-wozizhi@huawei.com/

Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
---
 fs/aio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index a07bdd1aaaa6..48d049ff5267 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -369,7 +369,8 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 
 		ctx = rcu_dereference(table->table[i]);
 		if (ctx && ctx->aio_ring_file == file) {
-			if (!atomic_read(&ctx->dead)) {
+			if (!atomic_read(&ctx->dead) &&
+			    (ctx->mmap_size == (vma->vm_end - vma->vm_start))) {
 				ctx->user_id = ctx->mmap_base = vma->vm_start;
 				res = 0;
 			}
-- 
2.39.2

