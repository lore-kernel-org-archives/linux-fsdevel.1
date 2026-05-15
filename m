Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C79C3C8C65;
	Fri, 15 May 2026 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838515; cv=none; b=sf1ZQybXWmWhLbUiIYaWTXLoXWc74srYuRoI5ruuRPEFOSLRg86uHiC4hK3KqSNLtepYNI4h3TX+oyXSDRnMK1LJqLCxW2XFTJMFc6Ql43SWPQtFEY34my0+mJYLCT1CFYl+Xt/qj06hMZFSIFa849uDpAxtR6fIUnKAdaYeSQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838515; c=relaxed/simple;
	bh=TH6ahl9ulw0pL6T5JDaH6lMv268eBsUF4xzVPOcOwdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML+tGKHF7cQfqM9yDmNIRTKnZFOpAoskGHQ5V1n9kyOPJKjyTrjMMxnOVnLf9aPOqF4jSsPkbLKnOB6g4EqLYV9QQ+a9vRt/CngikzPTtRWKvdv+JK7m3jGWkE6gebabX3h4SPlc9idPV0YyddrxzuL3edM3pteMMSzKhMexHKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hcz3fYBk; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hcz3fYBk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Al
	ESWM+x9CBZx/ibVibR9kzkEAIwGUCZhksgluuowXA=; b=hcz3fYBkFNRAnwc4mg
	6gbOq6nbAGobeo+RnyqgkioZ97HqWpMaXTrbZfUwYyQkEDrnI79hKk8BBisRqeIN
	k7R5EQc2GsuWTgspXYc2hwjwyyDo+Szb9HVzyGPQXmMbh5g46+YM3OIG6Qbmn1Xo
	Zgm9G7t0vBKZAXszc/2z+3kXA=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnVxek6wZq6RobBg--.38248S3;
	Fri, 15 May 2026 17:47:18 +0800 (CST)
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
Subject: [RFC PATCH 1/4] mm/shmem: add SGP_GET to get unlocked folio
Date: Fri, 15 May 2026 17:46:59 +0800
Message-ID: <20260515094702.1092355-2-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515094702.1092355-1-chizhiling@163.com>
References: <20260515094702.1092355-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnVxek6wZq6RobBg--.38248S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4DtF1ktw1kXrWxWFWkXrb_yoW5ZFWUpr
	ZrKF97trZ5K34xCwn7Zw48Zw1ru3s3KryUK34agr1IyFn8X3Wvkr10yr1UKF18trW3G3WF
	qw4UCa15uF1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIYLkUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3AZA3WoG66bf3wAA3m

From: Chi Zhiling <chizhiling@kylinos.cn>

Add a new sgp_type SGP_GET which is similar to SGP_READ but returns
the folio unlocked with an increased refcount. This eliminates the
lock/unlock overhead for read-only operations.

SGP_GET skips folio lock and mapping check, suitable only for
short-lived access. Caller must not rely on folio->mapping validity
as it can become invalid due to concurrent truncate. Safety relies
on refcount and uptodate flag (truncate doesn't clear content).

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 include/linux/shmem_fs.h |  3 ++-
 mm/shmem.c               | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 93a0ba872ebe..24698faea5a4 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -164,7 +164,8 @@ extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 
 /* Flag allocation requirements to shmem_get_folio */
 enum sgp_type {
-	SGP_READ,	/* don't exceed i_size, don't allocate page */
+	SGP_GET,	/* don't exceed i_size, don't allocate page, don't lock */
+	SGP_READ,	/* don't exceed i_size, don't allocate page, lock folio */
 	SGP_NOALLOC,	/* similar, but fail on hole or use fallocated page */
 	SGP_CACHE,	/* don't exceed i_size, may allocate page */
 	SGP_WRITE,	/* may exceed i_size, may allocate !Uptodate page */
diff --git a/mm/shmem.c b/mm/shmem.c
index 3b5dc21b323c..ef19968cc51c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2504,6 +2504,13 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	if (folio) {
+		if (sgp == SGP_GET) {
+			if (!folio_test_uptodate(folio)) {
+				folio_put(folio);
+				folio = NULL;
+			}
+			goto out;
+		}
 		folio_lock(folio);
 
 		/* Has the folio been truncated or swapped out? */
@@ -2524,11 +2531,11 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	/*
-	 * SGP_READ: succeed on hole, with NULL folio, letting caller zero.
+	 * SGP_READ/SGP_GET: succeed on hole, with NULL folio, letting caller zero.
 	 * SGP_NOALLOC: fail on hole, with NULL folio, letting caller fail.
 	 */
 	*foliop = NULL;
-	if (sgp == SGP_READ)
+	if (sgp == SGP_READ || sgp == SGP_GET)
 		return 0;
 	if (sgp == SGP_NOALLOC)
 		return -ENOENT;
@@ -2649,13 +2656,15 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
  * @sgp:	SGP_* flags to control behavior
  *
  * Looks up the page cache entry at @inode & @index.  If a folio is
- * present, it is returned locked with an increased refcount.
+ * present, it is returned locked with an increased refcount, except
+ * for SGP_GET which returns the folio unlocked with an increased refcount.
  *
  * If the caller modifies data in the folio, it must call folio_mark_dirty()
  * before unlocking the folio to ensure that the folio is not reclaimed.
  * There is no need to reserve space before calling folio_mark_dirty().
  *
  * When no folio is found, the behavior depends on @sgp:
+ *  - for SGP_GET, *@foliop is %NULL and 0 is returned
  *  - for SGP_READ, *@foliop is %NULL and 0 is returned
  *  - for SGP_NOALLOC, *@foliop is %NULL and -ENOENT is returned
  *  - for all other flags a new folio is allocated, inserted into the
-- 
2.43.0

