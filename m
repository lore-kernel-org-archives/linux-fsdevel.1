Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io [149.72.141.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB723C871B
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.141.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898630; cv=none; b=koODW2HquLupKRQhw5/ST41mqAK906KALgs3V2ItjBmUPKM7rCBpmXldx12nw4CmZzppQS1Ao+vf3QMFCLTJKDMeGD5TCu+C0xxk6oj6waIKBMmlIvMzeQdCYQyVV2Y7nKojP05Bfvz3Cjtr0puzH8M1ucR7h2WwwQGFwPgO4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898630; c=relaxed/simple;
	bh=LuvshFqNCoD4IL13j3PQO4E118Ca1NJNCJKV7xSioM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LN+m0jzryjpQUo98pqoIWsQxg/guCnSrdX3T4aauPmZxmg/ojKvVtXH+e32/plQIpK08JymeXXt+1PJctfsy4n/JkcUOurzhl7+POZ+kEth2bG+TGAJoKBLLg6DtLSQRQPystbnE3nc79E5QtH/783Buas5EYYKyK3vNDvsLrYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io; spf=pass smtp.mailfrom=em.honeycomb.io; dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b=JmlYPD4U; arc=none smtp.client-ip=149.72.141.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em.honeycomb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b="JmlYPD4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
	h=from:date:subject:mime-version:content-type:content-transfer-encoding:
	references:in-reply-to:to:cc:cc:content-type:date:from:subject:to;
	s=s1; t=1790898620;
	bh=whCQ9fl0eQjp5iKExakuvCYoQnjcdvda7l5h7qSqS90=;
	b=JmlYPD4UJDhVjwwrx+4YPLIWm5Hx+wk+YBuo3BgInqrx8XaLZL1QB/fD51DvjfyxStlD
	tCvGzU/QAAxrR4VfK9NWntogjRxWEr1v42OLjsTf74LRGWAgf1HIlr4mff79dS4wa1oX3B
	dsCb1nChD+C2cUtOCh8/5vvsN9dY6+h/Ihu9AX92M6ZWlJ9Dg47RFx5Bxjaez6T5v7IXSX
	BBPvcjFJHAgBBqd9nOIFDmSfmKVRluAVrXkpzPx7E6xoLIRIFUEolHs6jIICTfjx6sWY4G
	fwdVYOkZ36dDnkik2Sa0rs6kWmJxeEx6mvxRmr3gfyBlAVwhZJtEPFx67KKxIsRA==
Received: by recvd-79d8dd9bd4-m8x27 with SMTP id recvd-79d8dd9bd4-m8x27-1-6ABEF1BC-56
	2026-10-01 23:50:20.465335371 +0000 UTC m=+197336.687606404
Received: from [127.0.1.1] (unknown)
	by geopod-ismtpd-1 (SG) with ESMTP
	id XGCZYlfaSNC2o_ADWl529g
	Thu, 01 Oct 2026 23:50:20.446 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Date: Thu, 01 Oct 2026 23:50:20 +0000 (UTC)
Subject: [PATCH v5 1/3] writeback: clear the old wb's dirty IO state after
 switching inodes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-wb-dying-cgwb-flush-v5-1-8361eb8c65c6@honeycomb.io>
References: <20261001-wb-dying-cgwb-flush-v5-0-8361eb8c65c6@honeycomb.io>
In-Reply-To: <20261001-wb-dying-cgwb-flush-v5-0-8361eb8c65c6@honeycomb.io>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880; i=lizf@honeycomb.io;
 s=gpg; h=from:subject:message-id;
 bh=LuvshFqNCoD4IL13j3PQO4E118Ca1NJNCJKV7xSioM0=;
 b=owEBbQGS/pANAwAKAaXO1OOXra/CAcsmYgBqvvG7bhgoyaa8gq6TobhGVwXGsBxQxd6r7uySt
 U8QKMK/yyCJATMEAAEKAB0WIQSfW1LPQ0gyJmoTHwelztTjl62vwgUCar7xuwAKCRClztTjl62v
 wuQbB/9eVvqjaA/Nd4q3vxsxJVJDSKOSahHvcApfmb6hEw9Ps1RxId05mi18a8qDa0JFSrxAnQq
 VR6Kf4d+6Ze0VcFHmM1VIB8JYdU6JcsxPibabo3KSBlOlYFkYl8y1CDo3hKS6ikFrxPuQ+90iSF
 te2yVLH39PdXepnY1oi0W9wwguw0GOqYdU1KN6LxloeVX+vB3aHGupiNQyPXZCJ3D8NVn4Z3iEq
 TQLUdf75Vxr9QTj47MH+c/foW3MG1dkYIdK9g80gP9SvL8Ao2IT1te9sRyFWg9Oyob4Jnp9tnss
 sNs4aW+DvXFVPdlWCmBCJP0FXWpVuViLb9gExBLAQ4JuF/Oj
X-Developer-Key: i=lizf@honeycomb.io; a=openpgp;
 fpr=1F7714D7EC3441D2CECC24606A3F8B00FBDDD2A4
X-SG-EID: 
 =?us-ascii?Q?u001=2ECuH7N2XAoeMR1zrzr=2F6NZrhli2vbKPOHff5fJuZuba6ZIE8QPyIf9mn4Y?=
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmedxDdO+wTo2o?=
 =?us-ascii?Q?TPIqqmrvsGRDpWxoBtidiwVgA1SmB5ddBYcEXo2?=
 =?us-ascii?Q?Bhs1rcumCUKhl62VPgzmo3cT98d0VLvzaBb2xbv?=
 =?us-ascii?Q?uF3qMCK61c9m=2FmDG4q2gmbuuhXOiJ1N8iY8IQ6c?=
 =?us-ascii?Q?KUfE6kZerbq1qI8MVx+Bn4V3PWf9IqmmYHN8+Cg?= =?us-ascii?Q?ZP=2Fu?=
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Tejun Heo
	<tj@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
	<shakeel.butt@linux.dev>, Xin Yin <yinxin.x@bytedance.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, ian@honeycomb.io, Liz Fong-Jones
	<lizf@honeycomb.io>
X-Entity-ID: u001.GRlkmHQ+Ka/CKxmoC/CxTw==

Switching a dirty inode to another wb can leave WB_has_dirty_io set on
the old one. inode_do_switch_wbs() moves the inode onto new_wb->b_dirty
through inode_io_list_move_locked(), which only updates new_wb, and
nothing calls wb_io_lists_depopulated() on old_wb. A live wb clears the
bit on its next dirty to clean transition, but a wb that gets no more
inodes, such as a dying one, is freed with its avg_write_bandwidth still
in bdi->tot_write_bandwidth, which wb_split_bdi_pages() and
wb_min_max_ratio() divide by.

Call wb_io_lists_depopulated(old_wb) after the switch loop in
process_inode_switch_wbs(), while old_wb->list_lock is still held.

Test: a later patch in this series switches all of a replaced cgwb's
inodes, dirty ones included, to its successor. After that, with every
writer stopped and the filesystem synced, BdiWriteBandwidth in
/sys/kernel/debug/bdi/*/stats stayed at 411700 and 407820 kBps with
b_dirty, b_io and b_more_io all empty, and the replaced wb was released
with WB_has_dirty_io set. With this patch it read 0 kBps and the wb was
released clean, in 3 of 3 runs.

Suggested-by: Tejun Heo <tj@kernel.org>
Assisted-by: Claude:claude-opus-5-5 checkpatch sparse
Assisted-by: Claude:claude-fable-5-1
Signed-off-by: Liz Fong-Jones <lizf@honeycomb.io>
---
 fs/fs-writeback.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index d26b2cf05283..050d507aa554 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -566,6 +566,12 @@ static void process_inode_switch_wbs(struct bdi_writeback *new_wb,
 		}
 	}
 
+	/*
+	 * inode_do_switch_wbs() only updates @new_wb's dirty IO state.  Clear
+	 * @old_wb's if its IO lists are now empty.
+	 */
+	wb_io_lists_depopulated(old_wb);
+
 	spin_unlock(&new_wb->list_lock);
 	spin_unlock(&old_wb->list_lock);
 

-- 
2.53.0

