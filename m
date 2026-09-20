Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD31379EDA;
	Sun, 20 Sep 2026 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889540; cv=none; b=Fn1iwOTMPPo1U8mPfbdZefeenHTbzveujAqqpCINuJmFtmAMp47zO7wiSbzYR7yUI8TZ5Odwt6gjN3XZr0ZiytvcYTVImlFzlMmwGnev5fFZnhgdq85SKFbtYGuAXO8nkrCoSzHe00uQA27QurbGEDo83cLE5Mj8IFEYIVw61zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889540; c=relaxed/simple;
	bh=/AZJWN61dYa9iudJVU/NcJv7GUx3e4HXR3dAeMOZVjU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pxOgMSGHTFPLKGGSi0n2Dl2qykL/HxxL9Prk4tLjvtoiuKnYWf0rPhQqgkpDEUEfcdLtnbo726m5K7q2zZ5uMqV5Dmc2J2qcr3Hnbet7Dum6LrzZnoFUxroszWzGcL9KQSIcTHesXFbXZGzaHaDyVbNykSQi65gnpCvKtIOQylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hndNG1Km2zTSdj;
	Sun, 20 Sep 2026 15:31:58 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hndNF1lWdzTSdj;
	Sun, 20 Sep 2026 15:31:57 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 6F1073027FCF;
	Sun, 20 Sep 2026 15:27:32 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sun, 20 Sep 2026 15:31:54 +0800
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
Subject: [RFC PATCH v2 0/3] fs/proc: split the inode list for procfs
Date: Sun, 20 Sep 2026 15:28:08 +0800
Message-ID: <20260920072811.2064247-1-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
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
    patch 1: "fs/drop_caches: skip filesystems without page cache"
 	add a new flag for filesystems without page cache.
    patch 2: Add a new helper to detect the empty inode list    
    patch 3: split the inode list.


After this patch set, the above TestDFSIO can get over 50% better performance
in exec time. And the procfs lock hotspot becomes nearly 1%.

Huang Shijie (3):
  fs/drop_caches: skip filesystems without page cache
  fs/super: introduce a helper sb_inodes_empty()
  fs/proc: split the inode list

 fs/drop_caches.c               |   3 +
 fs/inode.c                     |  79 ++++++++++------
 fs/proc/inode.c                |  53 +++++++++++
 fs/proc/internal.h             |   2 +
 fs/proc/root.c                 |   8 +-
 fs/super.c                     |  45 +++++++--
 include/linux/fs/super_types.h |  17 ++++
 include/linux/proc_fs.h        |   1 +
 security/landlock/fs.c         | 162 ++++++++++++++++++---------------
 9 files changed, 260 insertions(+), 110 deletions(-)

-- 
2.53.0


