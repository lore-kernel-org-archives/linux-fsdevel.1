Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CED57C9F
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788837862; cv=none; b=tDqjHO5K06FhP4TguPbSgrHufe1uUyHyPs1MY9WPFWrkkLv0PpJXvoHML4uYjH6aGEBXCOpG5imtNokQ4pyCDksJcPxTQylF7LS8aLakL9Il28271W0mOvA6xa3qpwRGF8JjgpdMx1otB4h2jQ+mN5l2XKiLgmIPpqx4JCGZVnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788837862; c=relaxed/simple;
	bh=y8QlePMZdJXz/z/+wh8CunwTD3f02z/lFSiAENwxgIw=;
	h=Message-Id:Content-Type:Date:Subject:From:Mime-Version:To:Cc; b=SgBk73NlSnD2LsZ6qvEwy6fYWCqLnWQJQ2Fohc8ZDzIuxAdVp2GCuQyDZY3TSLdfGgrGhWQcB+MI/sTyfwLUwRyxKEF+/ilKj6HjGXYj/jAYumSSKpVHX6pJnvlQO6C1s5dQKi647ORmcH784eEGXvBtxnmsTVhhz839h/6ridM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WVo90ddi; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WVo90ddi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788837854; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ytwLHyeLtwFV5SWbH8/EwgEVylNoSTr9PUVdaF9Z+L8=;
 b=WVo90ddiRMoFS4yafT/iVHRw5amt9KQxn9ERORlbIw6rUHgDdls2Em7CHsr16zwUcHoKVR
 Oya0pG/ln+06zThZ9spZ6u15pXW7pIWdEFJUq/JF7b33n4NmeybBHjhq0Gk3CV42Q4p9p3
 dqA7JIvCiVnzcAQTx7qyEQ5eWrHc2jNMbGQDAbcAOo936Q3EC0EOafZTJixXSZ/1uDAwC3
 AhyLPtUkoQ2QEcDE1Zs/R8+4AUXrezTZg34L1IDilAsvohjeb4Pco0cgduICOcgWSqRMml
 azUaL1oREIXqpl6wCkMUEiPF6z0OoN63TD3wRZUObuA+8XbAncFYaPmVJPydpg==
Message-Id: <cover.1788836830.git.yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Date: Tue,  8 Sep 2026 11:23:50 +0800
Subject: [PATCH v1 0/2] writeback: bound foreign dirty flushing
From: "Xin Yin" <yinxin.x@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a9f7fdc+22d2af+vger.kernel.org+yinxin.x@bytedance.com>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>, 
	"Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
X-Original-From: Xin Yin <yinxin.x@bytedance.com>
Cc: "Tejun Heo" <tj@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Xin Yin" <yinxin.x@bytedance.com>

Hi,

We have seen production stalls where syncfs() and other writeback waiters
are blocked behind long-running WB_REASON_FOREIGN_FLUSH work on the same
bdi_writeback.  The foreign work is best-effort writeback for memcg
foreign dirtying, but on busy multi-device systems it can be much larger
or longer-lived than the dirty pages that are actually relevant to the
selected target wb.

There are two parts to the problem.  First, the foreign flush budget is
currently sized from the target memcg's global dirty counter, while the
queued work writes only one target wb.  This can over-size a single-bdi
flush when the target memcg has dirty pages on other devices, or under-size
it when dirty pages on the target wb are charged to other memcgs.

Second, the work can keep extending itself under sustained dirtying.  Even
though foreign flushes are best-effort WB_SYNC_NONE work, a large budget
plus continued dirtying can keep the target wb busy long enough to delay
later writeback work, including syncfs() on the same backing device.

This series keeps foreign flushing aligned with its best-effort reclaim
role:

  1. size the work from the selected wb's reclaimable pages, with the
     existing 25% headroom;
  2. make each foreign flush operate on a bounded snapshot of dirty
     inodes/pages, while preserving WB_SYNC_NONE semantics and the finite
     work budget.

Later dirtying remains the responsibility of later foreign flushes, kupdate,
or background writeback.  The changes are intended to bound one
foreign-flush work item without turning it into a data-integrity operation.

Xin Yin (2):
  writeback: size foreign flushes by target wb dirty pages
  writeback: snapshot foreign flush pages

 fs/fs-writeback.c         | 74 +++++++++++++++++++++++++++------------
 include/linux/writeback.h |  1 +
 2 files changed, 52 insertions(+), 23 deletions(-)


base-commit: 46b513250491a7bfc97d98791dbe6a10bcc8129d
-- 
2.20.1
