Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B6143E489;
	Fri, 15 May 2026 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838519; cv=none; b=SEz1sMPP6cW0NQQAo5fjFgd8xBt7Kya8pVMq/CuRi89q9OTz2JlFqivoGUzmwiNnv0dPrc8B9Orhwtg8mGbyJF0GDfgZF4xqfO5B9hdV3K82eqAO9a3c153rabC7JWGqjjG4XGRikEokaz8OjHlPveJs3FPTSy+7IDtZEd34jxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838519; c=relaxed/simple;
	bh=tDf6ql0D3RBr8ZAXctd+C2GXmKGRkUn1BnE9L++6R0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HsiwNYEdubrcVyIkXxKEiibG39TdlT05mUSh0c3NSpmbynQCQHVBSMuxd70+s9gmJ9uoPIMyIZ9XTDcQmLuWaePzsRvcy9cgintrb+tlgOTTLuX+DaYUWMeVqBx2ex6c2FCtHUEoFI33jdT8D6EvTeflUO2FSjfXhaUQYPcn6QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XHWLYlG7; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XHWLYlG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3h
	62kitl08ea3beBtgH0dYPBq1vKLHYc6O3MIHUEOS8=; b=XHWLYlG7+KqOBkTKp/
	KruqlCrsicnfTiSCXpoZ9ULV2gVGB+JZgrSnGKThIvV89lD5iBAEP5QnFm9MmXFp
	B2MuF57F7gFhmiKBLsXu4Hnp2+WD+H+s1aCWt7g20+p4fvRsJFlxLoQPrWuI7EFb
	I9UIH1Y80mrABb9zwQ35QwkpE=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnVxek6wZq6RobBg--.38248S2;
	Fri, 15 May 2026 17:47:17 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [RFC PATCH 0/4] mm/shmem: optimize read performance with folio batching
Date: Fri, 15 May 2026 17:46:58 +0800
Message-ID: <20260515094702.1092355-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnVxek6wZq6RobBg--.38248S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyfGw47tF18KrW3Wr15Jwb_yoW8XFWrpF
	yDWas3tr92q34xCasxC3yvgrWrX3y8Kr4vqrWft3Z8XF4Yyr1FyFn7Jr48W3yUCr1fJF17
	XFyfAw129w4j93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ja89NUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2wVA3WoG66XMJQAA3I

From: Chi Zhiling <chizhiling@kylinos.cn>

This series optimizes shmem read performance by implementing folio
batching in the read path and eliminating unnecessary lock operations.

Performance testing with fio:
(--ioengine=sync --rw=read --size=1G --runtime=120)

shmem (THP disabled):
  bs=1M:   11.4 GiB/s
  bs=64k:  11.1 GiB/s
  bs=4k:   3814 MiB/s

shmem (THP disabled) + fbatch:
  bs=1M:   12.8 GiB/s (+12%)
  bs=64k:  12.3 GiB/s (+11%)
  bs=4k:   3783 MiB/s (-0.8%)

shmem (THP enabled):
  bs=1M:   13.8 GiB/s
  bs=64k:  13.1 GiB/s
  bs=4k:   3851 MiB/s

shmem (THP enabled) + fbatch:
  bs=1M:   14.0 GiB/s (+1%)
  bs=64k:  13.4 GiB/s (+2%)
  bs=4k:   3811 MiB/s (-1%)

shmem preallocated via fallocate (THP disabled):
  bs=1M:   24.0 GiB/s
  bs=64k:  22.5 GiB/s
  bs=4k:   4670 MiB/s

shmem preallocated via fallocate (THP disabled) + fbatch:
  bs=1M:   29.3 GiB/s (+22%)
  bs=64k:  26.7 GiB/s (+19%)
  bs=4k:   4654 MiB/s (-0.3%)

shmem preallocated via fallocate (THP enabled):
  bs=1M:   24.0 GiB/s
  bs=64k:  22.9 GiB/s
  bs=4k:   4698 MiB/s

shmem preallocated via fallocate (THP enabled) + fbatch:
  bs=1M:   34.3 GiB/s (+43%)
  bs=64k:  31.5 GiB/s (+38%)
  bs=4k:   4689 MiB/s (-0.2%)


Chi Zhiling (4):
  mm/shmem: add SGP_GET to get unlocked folio
  mm/shmem: use SGP_GET in read operations
  mm/shmem: optimize file read with folio batching
  mm/shmem: make SGP_NOALLOC succeed on hole like SGP_READ

 include/linux/shmem_fs.h |   5 +-
 mm/khugepaged.c          |   2 +-
 mm/shmem.c               | 132 ++++++++++++++++++++++++++++++++-------
 3 files changed, 112 insertions(+), 27 deletions(-)

-- 
2.43.0

