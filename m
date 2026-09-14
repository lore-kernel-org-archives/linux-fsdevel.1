Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35EA355055;
	Mon, 14 Sep 2026 06:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789366553; cv=none; b=DLaRUFx3fLnThNN67jxcY+MaxyXGR3FSxM/i0z49jwD4jf+LXnUclGMOhYUStFfei2UyCNTw8RKRJOUGvhoKrB/UQEGiTHtEsQ8Jbr7MuhiVx/1T7ZN4SDoaEd/n/9SSp++HaSHdemnYzfyGmaP6rKoWl4r/c9hy8KZgEaPNr1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789366553; c=relaxed/simple;
	bh=uxFPncMJSlfX0+1IkqxfA/i8Q1CWpT50fLXYeiYXtqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WTGxVIlA6k/wkEtV+KtMHPSLR+WcssgxYo6FgUJetbCHMCVOoAnr2I9q9kBo8zN3aNqMxn/T/ZX42xN+00z77YVCG0rfPzQDZhssBMINW8+FFOnw6JlV1kvptMpQxtMwgusowd5URqlc9yyeEi8+qXIlJtSR70g7KsPakOVZKNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hjvyn6rZZz2CZMN;
	Mon, 14 Sep 2026 14:15:29 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hjvym3Wj1z2CZMN;
	Mon, 14 Sep 2026 14:15:28 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id D5E9016CF;
	Mon, 14 Sep 2026 14:15:25 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 14 Sep 2026 14:15:27 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<jack@suse.cz>, <dev.jain@arm.com>, <ljs@kernel.org>, <adobriyan@gmail.com>,
	<akpm@linux-foundation.org>, <hpa@zytor.com>, <ryan.roberts@arm.com>,
	<mjguzik@gmail.com>, <joel.granados@kernel.org>, <jannh@google.com>,
	<oleg@redhat.com>, <aleksa@amutable.com>, <legion@kernel.org>,
	<kees@kernel.org>, <joannelkoong@gmail.com>, <tj@kernel.org>,
	<libaokun@linux.alibaba.com>, <ebiggers@kernel.org>, <sandeen@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Shijie
	<huangsj@hygon.cn>
Subject: [RFC PATCH 0/3] fs/proc: split the inode list for procfs
Date: Mon, 14 Sep 2026 14:14:46 +0800
Message-ID: <20260914061449.4024632-1-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

The global s_inode_list_lock is heavily contended in procfs
on a 384-CPU, 12-NUMA-node Hygon machine running Hadoop TestDFSIO:
  #hadoop jar xxxx.jar TestDFSIO -read -nrFiles 1000 -size 100MB

The hadoop will create lot of threads during the test.
The perf shows it consuming ~90% of the lock hotspot in procfs.
The lock is hit from both directions:
   -- inode creation (~49%) :
           getdents64 ->
              proc_readfd_common ->
	         new_inode ->
		   inode_sb_list_add()

   -- inode eviction (~41%):
           process exit ->
	      release_task ->
	         proc_invalidate_siblings_dcache ->
		     evict ->
		        inode_sb_list_del()

This patch set tries to resolve this issue by:
    patch 1: "fs/drop_caches: do not scan procfs in drop_pagecache_sb()"
       This patch skips the scan for procfs in drop caches.

    patch 2: Add a new helper to detect the empty inode list    

    patch 3: split the inode list.


After this patch, the above TestDFSIO can get over 50% better performance
in exec time. And the procfs lock hotspot becomes nearly 1%.

Huang Shijie (3):
  fs/drop_caches: do not scan procfs in drop_pagecache_sb()
  fs/super: introduce a helper sb_inodes_empty()
  fs/proc: split the inode list

 fs/drop_caches.c               |  4 ++
 fs/inode.c                     | 80 ++++++++++++++++++++++------------
 fs/proc/inode.c                | 53 ++++++++++++++++++++++
 fs/proc/internal.h             |  2 +
 fs/proc/root.c                 |  6 +++
 fs/super.c                     | 45 +++++++++++++++----
 include/linux/fs/super_types.h | 22 +++++++++-
 include/linux/proc_fs.h        |  1 +
 8 files changed, 176 insertions(+), 37 deletions(-)

-- 
2.53.0


