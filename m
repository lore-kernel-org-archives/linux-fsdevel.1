Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA182233722
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780247420; cv=none; b=Fj6RBWqXPvqaiC6obn2Q76dfvUaI+AFnjyLO3uY562zRzdlth4GJceHolRk8Y7o+wfWlt+uttPGb0Ro3juB7muGXfKObMCd+ohKM+ZPuAY49/iLuTkeGvyN0WvLkYD0Chog8kfrbmo0aeIzm6ETRwpbyJpF01y1jse5w5Rcksfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780247420; c=relaxed/simple;
	bh=Q3eqBlZVrsTQsWiPXY/tj/lae5lI7oFVxls9Ev1VlLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1o3PTyh9nbQZDtMC5tVhSId/0QnlIlyFlaMKruM0EFSoAIjEtCASe76BoVjXYnWgpokE9hlE6zh1uWilVxeJbCLAmRslCQghJbcHXZMnLQa77iiyPCBxyxlHxl7hJZI6zg0N/O1qj1HYAVvOGMNuD7IfAv7jux710SNx9uGcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LviN2vFW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LviN2vFW"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c2a68d01so3692635ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780247419; x=1780852219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CqJpbwtossSFW5neyJ87RipB4IcgiOFbuX2fMHVoKDA=;
        b=LviN2vFW0Vh2IdPSp86etBiNYRD3Jj8gfHQ+acMZCqBCpsm3rArijYf1hYtQ8s8l9y
         18/4qKLtKR8jndY+q+1jo0OzaouaiwdxXLg6CgsVeGLz1xrotle78b1ApyS5p4RJMpwK
         nvSKLNTBUQ2t2WCkdNpIx9Az3IPuA5dY9/tSYBVTQ3k47PIj76jh+W40czuYW5EflzzJ
         pDOhSci1kFbwWk/M+u+2YCUYVbpJgV70qJFT3KMzLAO0BLKVroQFyTGcFRecG6jXoRUc
         bDZa4FZ9eZQtE/O/3GAg4TYuvPXV7mrOyrWA7TtA+yL+IX3gbkln1TIEqJfstSrw7fzz
         SFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780247419; x=1780852219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqJpbwtossSFW5neyJ87RipB4IcgiOFbuX2fMHVoKDA=;
        b=QaqejJ3erNdLVysHVAutyWKeoLqexHfXMLAzG+viKhSu0COJO7/0831kHUVmIxOFgo
         qsAt/7WtTWLhmYDFfqaC2IBtnKsnSQNsaJf/4xdaSTpG+N7zj3Z5IK//ago6ljgjVDqw
         BHHl7xlIqp8/V9VDbaiyeWs7Hd3Q5nQnEPvXlipX/LtgD68I6pL5JDoT86dZ5MkWr3Pc
         a4X9U3mhFawxfH+0N3UFTemFGp8mzY8UoafdzU8W+hloT5gvhAlYyw8UVYP7Rf9rbAJ/
         hvAmIMWj9J4qDQTOrm5g4SKisO5XQKuAnmUxyYz87ZhJKCnHh0EmxU2+OocTyx0OctE7
         HtmQ==
X-Gm-Message-State: AOJu0YwPpre4PWKvDnKLk7b82TeMVq3rCXZwG/eni/P8cq1sfIiB6XAJ
	BGXUKH2l3ovyLWFEx1wtX5w87MCjKMe2Tqab6DrplTodleXDq0dD453ilNPBevy3UUs=
X-Gm-Gg: Acq92OGlFOlSUIXh5YzOnVWI3NtT4QbnX01DdObQIfU657ngFaGvk8ocVWM/3P/XzFU
	+dLzA/HMTrg6bsj8Z/JPQbN4ysdTph7VH/gyNxnBNbS4f/h+3RzbxsgDDyc7SCe+QkqNJdH3rmf
	bTT8cgk+s2TVzj6o/HjYMLKiDBD1Zn5f2h8O+rintttPCQ1mmAHbsyj5U4VFp228fWTkRgFY8Bo
	+m/PEtFahmv9Jeyknv3oJtxNe1FNNuF4xRL2oBYJtYDC7z3oxHlbjfzpRJ1A3nmuE3Cn9Cy6YTa
	2FHjg7ljmxqQb5k7dWu/er2dF7oN41sIViqqqC3qYHx/dTbSpvWmPmXOY0RW6xCIRy5gbABi230
	8QrGV//gCv6Vr1r3OYkg/6eS0FAuw8/Eq/A9+PvFbhvLY6qZ/wSF/4UP+Af6Y+wILaCg4wNEqkD
	GthpikG6SWVgcFmDyjqqzc+8FugWLy63hi4p6nuh2qAmQ=
X-Received: by 2002:a17:903:986:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2bf3682a21bmr82919535ad.25.1780247418899;
        Sun, 31 May 2026 10:10:18 -0700 (PDT)
Received: from ubuntu24.lan ([14.219.52.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e71cbsm78487495ad.15.2026.05.31.10.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 10:10:18 -0700 (PDT)
From: Yiyang Chen <cyyzero16@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-devel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: tracepoints expose s_dev of kernel-internal superblocks -- no generic resolution interface
Date: Mon,  1 Jun 2026 01:10:13 +0800
Message-ID: <20260531171013.289131-1-cyyzero16@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

While tracing page cache activity via mm_filemap_add_to_page_cache, I
noticed s_dev values that do not appear in /proc/*/mountinfo:

  mm_filemap_add_to_page_cache: dev 0:18 ino dea89 pfn=0x13ba00 ofs=0 order=9

Using a kernel module to enumerate all active superblocks, I confirmed
this is the hugetlbfs internal mount created by hugetlbfs_init() ->
kern_mount().  The actual s_dev value is dynamically allocated via
get_anon_bdev() and varies across systems (0:18 on my test machine).
Because kern_mount() attaches the mount to MNT_NS_INTERNAL, it is
invisible to all mount namespaces.

Each internal filesystem requires its own trick to discover the
s_dev -> fs_type mapping:

  - shmem:      create a memfd, call fstatfs() -> TMPFS_MAGIC
  - bdev:       open a block device, call fstatfs()
  - hugetlbfs: memfd_create(MFD_HUGETLB) creates a file
    on the internal mount itself, so fstat() gives s_dev and
    fstatfs() returns HUGETLBFS_MAGIC

None of these are a general, authoritative interface -- each requires
filesystem-specific knowledge of which object to create and which
syscall to call.

The question is: should there be a single stable interface that exposes
the s_dev -> fs_type mapping for all active superblocks, including
internal ones? Here are some options:

  - Add fs_type to the affected tracepoints.
  - Provide a generic interface (BPF iterator, /proc, /sys) that
    exposes s_dev + fs_type for all active superblocks including
    internal ones.


Reproduce steps:

s_dev is dynamically allocated via get_anon_bdev(), values vary.

--- test_hugetlb_sdev.c ---
#include <sys/mman.h>
#include <string.h>
int main(void) {
    void *p = mmap(NULL, 2<<20, PROT_READ|PROT_WRITE,
                   MAP_SHARED|MAP_ANONYMOUS|MAP_HUGETLB, -1, 0);
    if (p == MAP_FAILED) return 1;
    memset(p, 0, 2<<20);
    munmap(p, 2<<20);
    return 0;
}

  gcc -o test_hugetlb_sdev test_hugetlb_sdev.c
  # precondition:
  cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages   # must be > 0

--- trace script (run with sudo) ---
  TP=/sys/kernel/tracing
  DEVS=$(awk '{print $3}' /proc/self/mountinfo | sort -u)

  echo 1 > $TP/events/filemap/mm_filemap_add_to_page_cache/enable
  echo 1 > $TP/events/hugetlbfs/hugetlbfs_alloc_inode/enable
  echo > $TP/trace

  ./test_hugetlb_sdev
  sleep 1

  echo "=== s_dev from tracepoint, NOT in mountinfo ==="
  # filemap uses "dev X:Y", hugetlbfs uses "dev X,Y"
  grep -v '^#' $TP/trace | grep -oP 'dev[= ]\K\d+[:,]\d+' | tr ',' ':' | sort -u \
      | while read d; do echo "$DEVS" | grep -qx "$d" || echo "  $d"; done

  echo 0 > $TP/events/filemap/enable
  echo 0 > $TP/events/hugetlbfs/enable
  echo > $TP/trace


You will see hugetlbfs s_dev which is not present in any mountinfo.


Thanks.
