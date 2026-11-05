Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891474;
	b=XbO/F9rz778aDk6qXGk1NcLzwISwbZenYkLNSeLysuUzk6/Nt1/4lBcL1U3UlfAwaWBc
	 OEAFk969qV/AhFdQfDCkxOrYPd3iBZ0SgBBfLz+QdzxQ80sfqWlgL2pvr0LJxA513lxDI
	 m50IYOS+ddW6tzwXUdOwOxf6UxfyBBHZMw3b6n6TUUK2WV5yOPtZ6LtL16GXSqNeAw1Ae
	 oi/NtGZGUAK0pyOu4b3qJlYvDpU3dFDYIPXD7nTFxEN5isKpLPvEvnZ974H5k25PCARGz
	 uY0kRsJlaZx1e1nD6/eFYZ/2UwsEKL8Rf24NZfQHw51WTqoyLg+uUJkwfKN8Qvunmvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ZDQ9vvkOOiorXnWWJDI3v2nHVl2YSsMqeb/yptAg07E=;
	b=KuotuWSQLhj7XFIxSP2QbAsCWm+tCDbi3/pyCHYBlmH4tJYw67I8T1TD59/QbmqT16Dc
	 Zft6tU1jPOlk1rUsJXHT5EgvlZ0/jjCvEnLHNsCyQFWgoDNEmDXqutKOzziZmE6Qnfvtz
	 J38JCXmS5URUDowdZ4BOPrcKJ9A4lp9MTxjX72bEJrVT/Br3T6Yz81yuNMt0opoMOdS41
	 VXRMvHpgpkg/P23bGrp2IdcxnJUMZfulKglOVLlpcGzAuuCUHg1nAjQ4Lk4wBeon8B7GY
	 xpRKhPxvld9avxGgtw7hFJpVxkupMFbyUS5FiUu1VhHZ6C1oZWcU3ruOabj5S02x6/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kJzRl5Ze;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE01606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCE01606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kJzRl5Ze
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8ac9d666d4eso24259427b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891473; x=1794496273; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZDQ9vvkOOiorXnWWJDI3v2nHVl2YSsMqeb/yptAg07E=;
        b=kJzRl5Zedi7Mo2RfabE9F/YQZkkfd21Qj0Ir1G6QXa6t6eb9CXb+1DXgFVDoLiqYvZ
         U6btJEiHw33xjQG7RCN7uJvNEUqTqfZ/gxl20onfLfDCxin+7i8hHEfWzDLRgoVlhVaG
         48gz/Y0tiTZOINpeI9EKheB7zI8Z4JOLzI/4DYTC6dcHW2M+E5GthjOi+xjbAKks4isd
         khHHFLkzQy0hekKpSceGgBb84KWhlGBKx+RoKHMxJvgRG9pAJj+scXGD5kG3VV2UAfG+
         rX+wfqAbu0QLmXGIftEy8dd43RC4VMtv4LEaircYSflp6dbn1KGgtwaBcD9d61/zi57/
         j+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891473; x=1794496273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZDQ9vvkOOiorXnWWJDI3v2nHVl2YSsMqeb/yptAg07E=;
        b=pZPeigoXubL1QESvBsyk5epxWTLVAz1s7zZ+btX6cStxFiWbxmRsd4F7dPmJ6Dyi1j
         xykp6+/DffPxeGFQsSdUx/eEqj7QUicKgi59bwzt0pLuuGKVtloMjVb8zdyQzuNhN5Jk
         L7IRFrwcN/HNE+ya5vgYfihAhJjzmMBiy+KOqkFYkYDeYUhomsjbsiLsz8VOe3wJwKRn
         MY/VyrLkYj/fYR+Ta4o/3P1glDIRoBmrwWtYHSpcOIsoZp3xvFSUzPRf4NNibCYS7uaJ
         zm4u5XGW63oc5pKjO3GUqiaaw5jfZEzfVpZ1duGIXMHJauflc9VkjYQio91fkyLn1itd
         sRyw==
X-Gm-Message-State: APuU4Z8OgQtCcTPGpcMHHqiqUFqGfNuODy61diMyRIzTD3lfclz279wY
	dymnE1nyrI2CaFjNkLZEA7vOyXZy5U92PmTZtvLjcppsQMhTYQswZbNTo2t/Xs7WsUXwPyXRq3J
	ZA0XpH/4=
X-Gm-Gg: AYBFou1pEha7sNOB5sppFFfQsKw+GeQa7aJwfDWrN9z180TxTVxmQQnQ7GjlkT5En/E
	lPUMmNF35RD8O6OLWprHsatTWO2XOxua2qWSEtFmvBUnEjjTq+AxWFxjPy0DAAWXTd/ovQHkCfU
	dvZvxlhFAL3ePj7hz6L1RfHK95xAsG4SudcX7Oi+vobjo9jYNLXSA0qkWZeAqCP1y5WCVg0M746
	OB2AECZ/bpU5Peehb1C8AYOAX9aO9wHf9/coNswDUus5XZZB+7UZajikJD64x6xzXuekKy7mi31
	9Cwxd5rDVVst37ESZ8kbHR0SKzgRbQrS5oJbxc2cDAoP0SMIs8fhjuCpaLX2b2tpbnqekq2hJ60
	6+WWoTKUGxxPfVJnTkcWKDseFKaxGz+EpFrc7xmFbfZ84R4uY7p2zWfPVP5QjjaHfYIrvRADrmE
	cA4y7HsvM6a6nvP8Nmlxi14lgS6t1v52SxCfwtXqwBc7S4p27S7K3z4ZFK05wKj7UYqe3LFS8gN
	SRAqDQkiSknn1GRx04YUerTDsmGDXA6it8jKdqke8Ue6kyhHdgg2tSkyGTRz0QdBcG758Upk1/e
	XFXFd40z8rZ19JahOknNtLHG0/X/xpcnHIGa62gm5TJ5Cw==
X-Received: by 2002:a05:690c:4:b0:8b0:a352:f978 with SMTP id 00721157ae682-8b2b65af008mr110796737b3.4.1793891472599;
        Thu, 05 Nov 2026 07:11:12 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3098c3408sm42512477b3.11.2026.11.05.07.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:11:09 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:22 +0000
Subject: [PATCH RFC v3 30/90] cells: lend a cell a block of ids
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
Message-Id: <20261105-b4-cells-v3-30-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890933; l=7134;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=CgPn0a0iiouXAAueU3jla24PFcMru2EtI7PX4B6YX5g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLt+/mTKG1JcXCnJ2s4uQapII6cZZ6bfoT06gFP0IjemVhUS4R8xsddiKICtjsAsuUW6o1qPOZu
 HW9IFCecQoAM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

With the value 65536 for "ids", the tasks of the cell see uids and gids 0
to 65535. These map to a block of the window that the kernel allocates.
The builder never names a kuid.

An ordinary user namespace needs a privilege check before it may map a
range of ids. Here the check is replaced by the guarantee that nobody else
holds an id of the block. The allocator enforces that guarantee rather
than assuming it:

  - A block stays allocated for as long as the user namespace that it was
    lent to exists.
  - A released block is quarantined. It returns to the pool only once the
    tables that are indexed by a bare kuid hold nothing in its range.
  - The same tables are checked again before a block is handed out,
    because nothing stops a task of the host from running with an id of
    the window.
  - Blocks are handed out round robin, so that a block is reused as late
    as possible.
  - A quarantined block counts as used. A block whose ids could not be
    removed from the budget is retired permanently.

So a leak shows up as ENOSPC, and never as one cell owning what another
cell left behind.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/cell/ids.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/kernel/cell/ids.c b/kernel/cell/ids.c
index aaf7e7ed9826..edf625fa03a1 100644
--- a/kernel/cell/ids.c
+++ b/kernel/cell/ids.c
@@ -2,10 +2,137 @@
 /*
  * Cells: the ids of a cell.
  */
+#include <linux/bitmap.h>
+#include <linux/key.h>
+#include <linux/sched/user.h>
+#include <linux/spinlock.h>
 #include <linux/user_namespace.h>
 
 #include "internal.h"
 
+/*
+ * The kuid block allocator.
+ *
+ * "Nobody else holds an id of this block" is what stands in for the privilege
+ * check a legacy user namespace needs before it may map a range. So it is
+ * enforced rather than assumed:
+ *
+ *  - a block lives as long as the user namespace object it was given to, which
+ *    every credential, and every object owned by the namespace, pins;
+ *  - no create, chown or ACL stores an id of the window in a filesystem the cell
+ *    does not own, see kuid_storable();
+ *  - a legacy user namespace cannot map into the window, see map_write();
+ *  - an idmapping of a mount that was made for the cell pins the namespace too,
+ *    see alloc_mnt_idmap();
+ *  - a released block is quarantined, and goes back to the pool only once the
+ *    tables that are keyed by bare kuid hold nothing in its range. The same is
+ *    asked before a block is handed out.
+ *
+ * Blocks are handed out round robin so that reuse comes as late as it can. A
+ * quarantined block counts as used: a leak shows up as -ENOSPC, never as one
+ * tenant owning what another left behind.
+ */
+static DEFINE_SPINLOCK(cell_block_lock);
+static DECLARE_BITMAP(cell_block_used, CELL_ID_NR_BLOCKS);
+static DECLARE_BITMAP(cell_block_quarantine, CELL_ID_NR_BLOCKS);
+static unsigned int cell_block_cursor;
+
+static void cell_block_sweep(struct work_struct *work);
+static DECLARE_DELAYED_WORK(cell_block_sweep_work, cell_block_sweep);
+
+static inline u32 cell_block_first(u32 block)
+{
+	return CELL_ID_WINDOW_FIRST + block * CELL_ID_BLOCK_SIZE;
+}
+
+static int cell_block_take(void)
+{
+	unsigned int block;
+
+	guard(spinlock)(&cell_block_lock);
+
+	block = find_next_zero_bit(cell_block_used, CELL_ID_NR_BLOCKS,
+				   cell_block_cursor);
+	if (block >= CELL_ID_NR_BLOCKS)
+		block = find_first_zero_bit(cell_block_used, CELL_ID_NR_BLOCKS);
+	if (block >= CELL_ID_NR_BLOCKS)
+		return -ENOSPC;
+
+	__set_bit(block, cell_block_used);
+	cell_block_cursor = (block + 1) % CELL_ID_NR_BLOCKS;
+	return block;
+}
+
+/* Does anything that is keyed by a bare kuid still name an id of @block? */
+static bool cell_block_busy(u32 block)
+{
+	kuid_t first = KUIDT_INIT(cell_block_first(block));
+	kuid_t last = KUIDT_INIT(cell_block_first(block) + CELL_ID_BLOCK_SIZE - 1);
+
+	return uid_range_in_use(first, last) || key_user_range_in_use(first, last);
+}
+
+/* Returns a block number, or a negative error. */
+static int cell_block_alloc(void)
+{
+	int block, tries;
+
+	for (tries = 0; tries < 64; tries++) {
+		block = cell_block_take();
+		if (block < 0 || !cell_block_busy(block))
+			return block;
+		/*
+		 * Nothing keeps a task of the host from running on an id of the
+		 * window. A block it does that in is not for lending.
+		 */
+		cell_block_release(block);
+	}
+	return -ENOSPC;
+}
+
+static void cell_block_sweep(struct work_struct *work)
+{
+	bool again = false;
+	unsigned int block;
+
+	for_each_set_bit(block, cell_block_quarantine, CELL_ID_NR_BLOCKS) {
+		if (cell_block_busy(block)) {
+			again = true;
+			continue;
+		}
+		guard(spinlock)(&cell_block_lock);
+		__clear_bit(block, cell_block_quarantine);
+		__clear_bit(block, cell_block_used);
+	}
+
+	if (again)
+		schedule_delayed_work(&cell_block_sweep_work, 10 * HZ);
+}
+
+/**
+ * cell_block_release - the user namespace that was lent a block is gone
+ * @block: the number of the block
+ *
+ * The block goes into quarantine. It returns to the pool once the sweep finds
+ * nothing left that names one of its ids.
+ *
+ * Context: Process context.
+ */
+void cell_block_release(u32 block)
+{
+	scoped_guard(spinlock, &cell_block_lock)
+		__set_bit(block, cell_block_quarantine);
+	schedule_delayed_work(&cell_block_sweep_work, 0);
+}
+
+static int __init cell_init(void)
+{
+	/* No one user gets to use up the window. */
+	init_user_ns.ucount_max[UCOUNT_CELL_ID_BLOCKS] = CELL_ID_NR_BLOCKS / 8;
+	return 0;
+}
+late_initcall(cell_init);
+
 /* The id of whoever made the cell, under its own number. */
 static int cell_set_one_id(struct cell *cell)
 {
@@ -31,6 +158,32 @@ static int cell_set_one_id(struct cell *cell)
 	return userns_set_cell_map(ns, &uids, &gids, 0, NULL);
 }
 
+/* A block gives access to nothing, but there are only so many. */
+static int cell_set_id_block(struct cell *cell)
+{
+	struct user_namespace *ns = cell->user_ns;
+	struct uid_gid_extent ids = { .count = CELL_ID_BLOCK_SIZE };
+	struct ucounts *ucounts;
+	int block, ret;
+
+	ucounts = inc_ucount(ns->parent, ns->owner, UCOUNT_CELL_ID_BLOCKS);
+	if (!ucounts)
+		return -ENOSPC;
+	block = cell_block_alloc();
+	if (block < 0) {
+		dec_ucount(ucounts, UCOUNT_CELL_ID_BLOCKS);
+		return block;
+	}
+	/* From 0 up on the inside, uids and gids alike. */
+	ids.lower_first = cell_block_first(block);
+	ret = userns_set_cell_map(ns, &ids, &ids, block + 1, ucounts);
+	if (ret) {
+		cell_block_release(block);
+		dec_ucount(ucounts, UCOUNT_CELL_ID_BLOCKS);
+	}
+	return ret;
+}
+
 /**
  * cell_set_ids - fill the "ids" slot
  * @cell:  a cell that is being built
@@ -52,6 +205,9 @@ int cell_set_ids(struct cell *cell, u32 count)
 	case 1:
 		ret = cell_set_one_id(cell);
 		break;
+	case CELL_ID_BLOCK_SIZE:
+		ret = cell_set_id_block(cell);
+		break;
 	default:
 		return -EINVAL;
 	}

-- 
2.55.0

