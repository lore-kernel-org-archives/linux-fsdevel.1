Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618473;
	b=5Fn/BF5JGvk6bziTYebYvfdiN8maYPFW58w0sZzN3xhpoEv8YJiVRR8UNg0+dqaM1UVB
	 MRM/avaBnyRQK/noPJdGdt3KuYRRMqvNIhjohQzwx1V4nFYzjBL7ZaWcsECuO8WAmxYE5
	 KT1X/R6o42J9eMROa+q9zeaKbQClY6pD2NJr55UEqZSFLAunau8HDWKab1sb5Zmdqe9XG
	 EShqShPPAtMRsDx5uhvK1UoRzsd+1hR5ctP2Ez6EnnbtF/j2gcI+ps31tKZzzF9ujYZDZ
	 hq7ZRO8sD8kaws32yxDIgkNHveS+bx1x9GaHuxJS1gYLA2RU5OJ6NQ9qJFI4x7AMaig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618473;
	h=DMARC-Filter:Received:From:Date:To:Cc:Subject:Message-ID;
	bh=a31bzpObHyvbvXgMSMXfTZt04v+YPDVnHR6JE7u15h8=;
	b=2AyQ8KZsxezjBiDZF9I2ZajoWwthWniRJyBVHaPZ6OXkWvSl8yHBGD7zZxHM9gpWGYxI
	 7v+Ev2UnWqY6KqMav6aYhXOWuRoHiOplxV4Vfdu6yPE+ltJds5WWdubtlxc68RpzzB3+R
	 crFABJicE0NNsw56Se7Gxm6U7aoy7pqxPmVzfx+6FF6d4brZWaI48zdnJvaEGJ/HaoIbG
	 qNRj1BYcqRohWWpGMC3jtHCXX1dLda1hRsfW1VndyNurb0kmB1TRKEhpzZtQ+5q9aAm8t
	 DKUzYGCy58h3LeeZaFF5WFsRafbMpPbOm4xBAqtOO/NVpuXlDvMFI+fUCFJ4D0xrfKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBE0606A327;
	Wed, 25 Nov 2026 14:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EBE0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id 4DF5FC9314; Wed, 25 Nov 2026 23:54:32 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Date: Wed, 25 Nov 2026 23:54:14 +0900
To: Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH] ufs: add readahead
Message-ID: <20261126-ufs-07-v1@snowrabbit.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

ufs has no ->readahead(), so readahead reads one folio at a time
through ->read_folio().  Use mpage_readahead(), as ext2 does.

Reading 128 MiB with dd from virtio-blk after dropping the caches, five
times, in MB/s: 635-667 before and 1063-1193 after with 1K fragments,
1135-1216 before and 1457-1506 after with 4K fragments.

Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index c9ff8673f..fc3d2ec77 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -457,6 +457,11 @@ static int ufs_read_folio(struct file *file, struct folio *folio)
 	return block_read_full_folio(folio, ufs_getfrag_block);
 }
 
+static void ufs_readahead(struct readahead_control *rac)
+{
+	mpage_readahead(rac, ufs_getfrag_block);
+}
+
 int ufs_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
 {
 	return __block_write_begin(folio, pos, len, ufs_getfrag_block);
@@ -510,6 +515,7 @@ const struct address_space_operations ufs_aops = {
 	.dirty_folio = block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio = ufs_read_folio,
+	.readahead = ufs_readahead,
 	.writepages = ufs_writepages,
 	.write_begin = ufs_write_begin,
 	.write_end = ufs_write_end,

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
