Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517761D798E;
	Mon, 13 Apr 2026 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043240; cv=none; b=SVS5KQfwJFvP0to71tODANApTw52lSJ7kBjp7UYKKu3p+VGkY1rO38i8zsXSVIvFxb2AUxceLvhWLyHjIDtWJ38g/CQtzf5aW2C5JdOUh++E3TtbqbM60O7jXtc6w0O9hMD+hlwgIJLViySM9/e8OSNH11ny8FuDVBYw0m0Qp0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043240; c=relaxed/simple;
	bh=gHv8EurdnR2M89vIBOLJFuk6PI3dwM0tzY2ikdH8W7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qWqq1ujUHAjfFqRh7Qdl2Ss/HaRubYFuM6wtns6zMy6Rb1hWfbMKUBNBhica1Gkq7hysw1N6vGktOJZczBy7lI6u9u+G+AlxCqks89hYHgGkvp9t8SnTF9bDhvs+xWlS6vaK8cvIS7PsFd4eLRrF8/6XRTOi++cE9dO41tk31us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=I+4FBnhk; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="I+4FBnhk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Nab4JFj3gjnZrt72+cRNOZ5Q4mhAZwI9Xu1s/Jte8+k=;
	b=I+4FBnhkc/NdaPPv5TdqM+HB2Qblgyx7ZeJ4xf9xU3XeRy+uOmiLBM58tTNW4lHT5+ETAt8Wu
	vlPjscP5G95hO//CQ+RDy0UC1LpDzfg+zO81sd99i67xTsobFyc63Vv1QihmhLus8olfr5vwY9L
	2M7SAWlln2Fcl89iA2v+duw=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fv8ZD4NrvzLlrY;
	Mon, 13 Apr 2026 09:14:12 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id BC78140562;
	Mon, 13 Apr 2026 09:20:28 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemf100017.china.huawei.com
 (7.202.181.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 13 Apr
 2026 09:20:27 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <viro@zeniv.linux.org.uk>, <jack@suse.com>, <brauner@kernel.org>,
	<bcrl@kvack.org>, <linux-fsdevel@vger.kernel.org>, <linux-aio@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <wozizhi@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>
Subject: [PATCH] fs: aio: set VMA_DONTCOPY_BIT in mmap to fix NULL-pointer-dereference error
Date: Mon, 13 Apr 2026 09:08:14 +0800
Message-ID: <20260413010814.548568-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100017.china.huawei.com (7.202.181.16)

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
[   51.115408]  handle_mm_fault+0x24c/0x570
[   51.115958]  do_user_addr_fault+0x226/0xa50
...
Crash analysis showed the file involved was an AIO ring file.

[CAUSE]
	PARENT process		CHILD process
t=0	io_setup(1, &ctx)
	[access ctx addr]
	fork()
	io_destroy
	  vm_munmap // not affect child vma
	  percpu_ref_put
	  ...
	    put_aio_ring_file
t=1				[access ctx addr]	// pagefault
				...
				  __do_fault
				    filemap_fault
				      max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE)
t=2	      truncate_setsize
	        truncate_pagecache
t=3				      filemap_get_folio	// no folio, create folio
				      __filemap_get_folio(..., FGP_CREAT, ...)	// page_not_uptodate
				      filemap_read_folio(file, mapping->a_ops->read_folio, folio) // oops!

At t=0, the parent process calls io_setup and then fork. The child process
gets its own VMA but without any PTEs. The parent then calls io_destroy.
Before i_size is truncated to 0, at t=1 the child process accesses this AIO
ctx address and triggers a pagefault. After the max_idx check passes, at
t=2 the parent calls truncate_setsize and truncate_pagecache. At t=3 the
child fails to obtain the folio, falls into the "page_not_uptodate" path,
and hits this problem because AIO does not implement "read_folio".

[Fix]
Fix this by marking the AIO ring buffer VMA with VM_DONTCOPY so
that fork()'s dup_mmap() skips it entirely. This is the correct
semantic because:

1) The child's ioctx_table is already reset to NULL by mm_init_aio() during
fork(), so the child has no AIO context and no way to perform any AIO
operations on this mapping.
2) The AIO ring VMA is only meaningful in conjunction with its associated
kioctx, which is never inherited across fork(). So child process with no
AIO context has no legitimate reason to access the ring buffer. Delivering
SIGSEGV on such an erroneous access is preferable to a kernel crash.

Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 4fe163b8bf67..74e0e40b9636 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -397,11 +397,11 @@ static const struct vm_operations_struct aio_ring_vm_ops = {
 #endif
 };
 
 static int aio_ring_mmap_prepare(struct vm_area_desc *desc)
 {
-	vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT);
+	vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT, VMA_DONTCOPY_BIT);
 	desc->vm_ops = &aio_ring_vm_ops;
 	return 0;
 }
 
 static const struct file_operations aio_ring_fops = {
-- 
2.39.2

