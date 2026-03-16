Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698FA313E33
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627589; cv=none; b=b7rh6rLof+JMfxARogrv+sGUYW/F4EbTAU2ZkxJBzA05NhcTMt6PNdnhDDw1BzHV4O6OwJP/nC27o+u2iDm2TB4sMe1yTYeqcafUGJvH8xQzDvX5VlWyn5Ht4sGTGITJx2zSvnKb3S6f60g2WdStiMnKj3hDCKyW3WYT7U2fvVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627589; c=relaxed/simple;
	bh=qR5tnEEdLpXI5HKcoreSvyHCB6aHKCRxVhcL1le7WNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHKU1WOtsbHsXScemOWgZxM7SX/U8dGjQgGUysfR/9y3lQq6Q64O9GVuy9syN7G7hKfrGOmm90G+TeuayMLxOn1wanOYhj71K96tPD5eAvBMo9gA+iCJ+yFyqrVJokLSnRZ95xcHE1Vo/r+dmyEVSyX0BKC1/Fb6bx+691yo9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=DoO+AyHi; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="DoO+AyHi"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a51edef1fso3246397b3.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627585; x=1774232385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg1hihKZu3gGsoWKiZkcFBOQxEvKgiFXJphdOnRn9xQ=;
        b=DoO+AyHiHciLgjUNsrqgU7bfGh/rNBLzepEGOoZrG9L1erQmZUCDabqi564zNjwMSY
         gHghEjCRP/n1dj2KdbfePpVpJmSKnbS8kqlHea451VKbR4ryJ4zhVT/l0uFmftCmmopi
         h6CW6MNtd6v7pu/TaA2YS9jnBnkcXoLj3vuwwUBzg6EVL3zwiZRW8uO5WGA2fb8M13Xu
         CBXGF6xLpYro8Umvfrz487fwTEMHQHP8lzKiKiHRnDD6xS/sdAJ4MGeXlqbFqtw30rbK
         UuRSzCq/PFyXBBR1XJhoUZpjQIjdenjLbANVP8dvyj4l4KQV0NbOE+sthTZXNlcti2lK
         ENRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627585; x=1774232385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bg1hihKZu3gGsoWKiZkcFBOQxEvKgiFXJphdOnRn9xQ=;
        b=oAeNkaDVBwSSRhx0U9q4Ya4DDRCHCm9YijSXUt2KCXLAYZJhR0I4uaPg9B9ofrAr5o
         Z8dEJRDWWXXtghECnC+ZAFElIeC5E+FIQWYebRfOJG6llNIwo03u4G7Mc7DcAnVI80vb
         kEXhluvtKGjPqng067X0o1QvGmnLI2m9us3cJ/5s5wkk0jpi4OXLbdMmAWT0eDWFzLvh
         Kvx5rCKukzUM6EyUpEUZ4G/nplX2k3gjCUPwPA4iDjdijwK35kq5hMtBWrRElZ81qdD4
         MAb5nXt1Wa1WTAycq99/qgzHlWB4S8Zaowctx1KmyuKIwuyst0y28HUvuZ7OE+VUr8CQ
         z2EA==
X-Gm-Message-State: AOJu0YzVGb0M6bbgXTeHTNyPbOYT4AsyBmzNPXYbKEQFTyi0aGmr2puY
	X3sJLBLpe42gagNdjX1wTCBcuYXZenwJYN4KsAV/Ciqf3tLQJt+RE02T/APsJOLS+OdWFRqNj5Z
	JZILi
X-Gm-Gg: ATEYQzz2KyQWOjgsMDl1VqWmf2VAiZoUHxH6StLfgwFaDMECfVH5ZL/Vszgn6Dm4Wui
	mbbd9+cQhLOgtwY2OG+1G2Q0k6EKKkNeyjCoM1awu+/IP9ozyGnU/cQC4rUuG4D86DmspCWcPQP
	tFNQw4El71i21+HvwyIGhNH08ohv5wUIVESpOJFDzARPYqvtgizulU1j5YinSKRQ1EXNXo1KbI1
	5gS8wHm/9aI5ChavWZ854wf0eoLTX0NvehvtGwT4HfG+BkOYEC9EdG10q1kJ+BnOgQ9rGiHNf5s
	PvVUPrCBZS5XhuKkVIGv5aO7gqaYbZGSMQYE2vtKUUvWqqqQmBrNHcHgWG0h2lH5TmhfYW7fowv
	rttZyhLPmmolDup7aVwHeOvrUFn5E/vEzOtC/1jJs7Flf+ib2qwwVfbDyWuqWB6otI2RAVYlm1A
	q1b30rwmvUjNzRAPYoJhvlNuPi7ai1xNBXvefqBW8Kjix9dkonkUh9lz43JhRTf63JSnWC7rmx8
	iENYJpyjt38IVhTXHy91isW
X-Received: by 2002:a05:690c:c513:b0:798:c633:d13b with SMTP id 00721157ae682-79a1bd16c8dmr100300827b3.24.1773627584774;
        Sun, 15 Mar 2026 19:19:44 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:43 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 40/79] ssdfs: introduce PEB mapping table cache
Date: Sun, 15 Mar 2026 19:17:43 -0700
Message-ID: <20260316021800.1694650-17-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316021800.1694650-1-slava@dubeyko.com>
References: <20260316021800.1694650-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Complete patchset is available here:
https://github.com/dubeyko/ssdfs-driver/tree/master/patchset/linux-kernel-6.18.0

"Physical" Erase Block (PEB) mapping table is enhanced by special
cache is stored in the payload of superblock segment’s log.
Generally speaking, the cache stores the copy of records of
PEBs’ state. The goal of PEB mapping table’s cache is to resolve
the case when a PEB’s descriptor is associated with a LEB of
PEB mapping table itself, for example. If unmount operation
triggers the flush of PEB mapping table then there are the cases
when the PEB mapping table could be modified during the flush
operation’s activity. As a result, actual PEB’s state is stored
only into PEB mapping table’s cache. Such record is marked as
inconsistent and the inconsistency has to be resolved during
the next mount operation by means of storing the actual PEB’s state
into the PEB mapping table by specialized thread. Moreover, the cache
plays another very important role. Namely, PEB mapping table’s cache
is used for conversion the LEB ID into PEB ID for the case of
basic metadata structures (PEB mapping table, segment bitmap,
for example) before the finishing of PEB mapping table initialization
during the mount operation.

PEB mapping table’s cache starts from the header that precedes
to: (1) LEB ID / PEB ID pairs, (2) PEB state records. The pairs’ area
associates the LEB IDs with PEB IDs. Additionally, PEB state records’ area
contains information about the last actual state of PEBs for every
record in the pairs’ area. It makes sense to point out that the most
important fields in PEB state area are: (1) consistency, (2) PEB state,
and (3) PEB flags. Generally speaking, the consistency field simply
shows that a record in the cache and mapping table is identical or not.
If some record in the cache has marked as inconsistent then it means
that the PEB mapping table has to be modified with the goal to keep
the actual value of the cache. As a result, finally, the value in the table
and the cache will be consistent.

"Physical" Erase Block (PEB) mapping table cache supports
operations:
(1) convert LEB to PEB - convert LEB to PEB if mapping table
                         is not initialized yet
(2) map LEB to PEB - cache information about LEB to PEB mapping
(3) forget LEB to PEB - exclude information about LEB to PEB mapping
                        from the cache
(4) change PEB state - update cached information about LEB to PEB mapping
(5) add migration PEB - cache information about migration destination
(6) exclude migration PEB - exclude information about migration destination

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/peb_mapping_table_cache.h | 120 +++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 fs/ssdfs/peb_mapping_table_cache.h

diff --git a/fs/ssdfs/peb_mapping_table_cache.h b/fs/ssdfs/peb_mapping_table_cache.h
new file mode 100644
index 000000000000..0e738660eac2
--- /dev/null
+++ b/fs/ssdfs/peb_mapping_table_cache.h
@@ -0,0 +1,120 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_mapping_table_cache.h - PEB mapping table cache declarations.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#ifndef _SSDFS_PEB_MAPPING_TABLE_CACHE_H
+#define _SSDFS_PEB_MAPPING_TABLE_CACHE_H
+
+#include <linux/ssdfs_fs.h>
+
+/*
+ * struct ssdfs_maptbl_cache - maptbl cache
+ * @lock: lock of maptbl cache
+ * @batch: memory folios of maptbl cache
+ * @bytes_count: count of bytes in maptbl cache
+ * @pm_queue: PEB mappings queue
+ */
+struct ssdfs_maptbl_cache {
+	struct rw_semaphore lock;
+	struct folio_batch batch;
+	atomic_t bytes_count;
+
+	struct ssdfs_peb_mapping_queue pm_queue;
+};
+
+/*
+ * struct ssdfs_maptbl_cache_item - cache item descriptor
+ * @folio_index: index of the found memory folio
+ * @item_index: item of found index
+ * @found: found LEB2PEB pair
+ */
+struct ssdfs_maptbl_cache_item {
+#define SSDFS_MAPTBL_CACHE_ITEM_UNKNOWN		(0)
+#define SSDFS_MAPTBL_CACHE_ITEM_FOUND		(1)
+#define SSDFS_MAPTBL_CACHE_ITEM_ABSENT		(2)
+#define SSDFS_MAPTBL_CACHE_SEARCH_ERROR		(3)
+#define SSDFS_MAPTBL_CACHE_SEARCH_MAX		(4)
+	int state;
+	unsigned folio_index;
+	u16 item_index;
+	struct ssdfs_leb2peb_pair found;
+};
+
+#define SSDFS_MAPTBL_MAIN_INDEX		(0)
+#define SSDFS_MAPTBL_RELATION_INDEX	(1)
+#define SSDFS_MAPTBL_RELATION_MAX	(2)
+
+/*
+ * struct ssdfs_maptbl_cache_search_result - PEBs association
+ * @pebs: array of PEB descriptors
+ */
+struct ssdfs_maptbl_cache_search_result {
+	struct ssdfs_maptbl_cache_item pebs[SSDFS_MAPTBL_RELATION_MAX];
+};
+
+struct ssdfs_maptbl_peb_relation;
+
+/*
+ * PEB mapping table cache's API
+ */
+void ssdfs_maptbl_cache_init(struct ssdfs_maptbl_cache *cache);
+void ssdfs_maptbl_cache_destroy(struct ssdfs_maptbl_cache *cache);
+
+int ssdfs_maptbl_cache_convert_leb2peb(struct ssdfs_maptbl_cache *cache,
+					u64 leb_id,
+					struct ssdfs_maptbl_peb_relation *pebr);
+int ssdfs_maptbl_cache_map_leb2peb(struct ssdfs_maptbl_cache *cache,
+				   u64 leb_id,
+				   struct ssdfs_maptbl_peb_relation *pebr,
+				   int consistency);
+int ssdfs_maptbl_cache_forget_leb2peb(struct ssdfs_maptbl_cache *cache,
+				      u64 leb_id,
+				      int consistency);
+int ssdfs_maptbl_cache_change_peb_state(struct ssdfs_maptbl_cache *cache,
+					u64 leb_id, int peb_state,
+					int consistency);
+int ssdfs_maptbl_cache_add_migration_peb(struct ssdfs_maptbl_cache *cache,
+					u64 leb_id,
+					struct ssdfs_maptbl_peb_relation *pebr,
+					int consistency);
+int ssdfs_maptbl_cache_exclude_migration_peb(struct ssdfs_maptbl_cache *cache,
+					     u64 leb_id,
+					     int consistency);
+
+/*
+ * PEB mapping table cache's internal API
+ */
+struct folio *
+ssdfs_maptbl_cache_add_batch_folio(struct ssdfs_maptbl_cache *cache);
+int ssdfs_maptbl_cache_convert_leb2peb_nolock(struct ssdfs_maptbl_cache *cache,
+					 u64 leb_id,
+					 struct ssdfs_maptbl_peb_relation *pebr);
+int __ssdfs_maptbl_cache_convert_leb2peb(struct ssdfs_maptbl_cache *cache,
+					 u64 leb_id,
+					 struct ssdfs_maptbl_peb_relation *pebr);
+int ssdfs_maptbl_cache_change_peb_state_nolock(struct ssdfs_maptbl_cache *cache,
+						u64 leb_id, int peb_state,
+						int consistency);
+int ssdfs_maptbl_cache_forget_leb2peb_nolock(struct ssdfs_maptbl_cache *cache,
+					     u64 leb_id,
+					     int consistency);
+
+#endif /* _SSDFS_PEB_MAPPING_TABLE_CACHE_H */
-- 
2.34.1

