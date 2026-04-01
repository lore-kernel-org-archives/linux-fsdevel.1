Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339F388E75
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076982; cv=none; b=SoRObxdZRDsfGPyNgGoR7+WUR730kfpy2eQ8e7M5S50DbgPgN0+kO6cDc1LEB8ptK2ZMkWmBh/uz6dJ2TVjs8PweZVzQgOtRn5rg7/LDP0ba/dUp39acP0oTfGkH91TU0j3R8fcqtbfsL7fuaFGXBXUTZZl0eidFzDUES6TWLQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076982; c=relaxed/simple;
	bh=ruhqRuTEeSnlUtb1ed9VMt41ZI3HJlzRccGuOXzsxs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ax4bCBHg8lQ16yCoDWpXkJuwNzLpV/01q9gJIbu4Yn8tiuMSq+bjELiqJYQCbLAJ/DohwfHgkVWJ3iw9QNzavOHRY/dQC9C+lQXn7OwZA6Hvwvzlao3GLwtB/cMz5D22eV0QCfRCTO/HbQCTs/ZqiARcxFu2nGRlWTKTYjnS5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hv2CxcBS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hv2CxcBS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so1032065e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 13:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1775076979; x=1775681779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4y38OjeCEJcXrt/pjxqcqwKy5B+FZ5WVvHJbYZD1e28=;
        b=hv2CxcBSwWI0fQxBjAX4erFSCMVi/VrT95xdLyT23EACOD7L97pCG7u2KHXOpLeuYB
         QU+pXYEIPXFAxtQ27fL9+uvMCtpYaLcmZq5ONvmGyr/kzqYatGcWPplIhoP+YFUCM7KN
         jovFdO9p8q8Tzax5DY3SQ82iTplcw6bqMkIg6P4oiUGE7QVycgyOcxn+Z5WlgMPNTcfs
         qrY/ctZUQW1rJfGKiDJu9xQ7OGVF6xM8yz0Gg2na3fuhl9YwnQWNo4F3gWd406l7Xi6F
         280O6FugLE7A50q03WYYtBih0mZDxd8RwLCP5Y6tOZg1zkJ4zRoj8mZTbMxC0Ss9AMzM
         Idxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775076979; x=1775681779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4y38OjeCEJcXrt/pjxqcqwKy5B+FZ5WVvHJbYZD1e28=;
        b=SPi+wrPRDD3dBavT6+cUxVHtyfO420HWVzBSbKw7fwh7ogsZYR68cVp9jEN27oVNY3
         5wFgGnFYB4X140kL9D2e5KriMDVg39ynuA5Q31SVcpJB3hViP8S7BPLV2C9HanWmoX5s
         7GsRztHJG+omjHdDWs1SlvIZ0EmxZ2TIhz/JS2Hz+AKXv6O1I6F87Az75oL+bGG4eE2j
         NS7CY7Lw6X0R0k1hh5XkcmQPyNH/+lOU5YYQfftvFNy6VFCUbYfc84lqG4bhUwNH4o9a
         sZYcfmwhjh5tkuF7x3rEbRZ1x1zV05ZNOKt5JuRACp0AqDA5dgXccBDFJlFykfw0H6LI
         BkIg==
X-Forwarded-Encrypted: i=1; AJvYcCWEQDsHgOrJzFnNgXmG9LByGp4qbg1wCs0IjvnQ1qFpmMN+RhlHpm7xV4XaxBwacAahHO0xvjqAx/Nzr9gl@vger.kernel.org
X-Gm-Message-State: AOJu0YzYEi/xVnaeSzTEs4xo0ym+gT7cy2wow9AoRAhzAOyykGtU9taI
	RwJ5LQwmxI/Sm2OSfImM9AqeYJFJUIKzQ2tu7klMhuyrNZusiX6vnu0d86+qCop/HetxwWioNVY
	82JnF
X-Gm-Gg: ATEYQzzIHh0rCGjS1RiHl6BQQheNtlRpnIFbqejMkvOwyZvjSThIcekAmvSyCKPZe+5
	W13y+vts6/wA/9kEa+7zYJGMYFXRCUBl5FbRmNAbP0eTCJJZ9mDKts+L2Z0ZD0cacVErux6coR1
	FoQjekn5P9HhlYdbU9yt0QMb+jyY9pbAGA7HYTAhKhXnT0WvMVOXmic0iboK0Rg16ZXRQBymFyC
	dr8vfdgqiUWNuewFXUTaWrvwYrVZgH+9CCCnAt3QLPJ7eYmA+Y5SMD24FReCsfBuCI+uWMVq8aa
	VG1F49HLlBy/TVDVYK5RUCvDvDLmXTQe2+mk438hgmXbk0YdsLrEJrqILhBwpnmt9v43sqwJfxd
	XYZRkFGOCTga5ekl93+PJ0//6FV4uFXttAbwDy+ji5DflUj15TkZGm0o8/yBbasxpT/R7NgFXE2
	F8nHGh7CqrA78LhKiFIKFZ8+KSrtmrjZybBejx3VrHec6eT+jXCmHC7+0V0bMnzJkFWWxrA1M4V
	/IJJw4+e2XlemRgg4KOhAtHZLM=
X-Received: by 2002:a05:600c:1551:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-488835a15d2mr88248075e9.10.1775076979136;
        Wed, 01 Apr 2026 13:56:19 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f2b4400023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2b:4400:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a567bfasm53369835e9.0.2026.04.01.13.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 13:56:18 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	pc@manguebit.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] ceph: do not fill fscache for RWF_DONTCACHE writeback
Date: Wed,  1 Apr 2026 22:56:13 +0200
Message-ID: <20260401205613.2095623-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid populating the local fscache with writeback from dropbehind
folios.

At the moment, buffered RWF_DONTCACHE writes still go through the
usual Ceph writeback path, which mirrors the written data into
fscache.  The data is dropped from the page cache, but we still spend
local I/O and local cache space to retain a copy in fscache.

The DONTCACHE documentation is only about the page cache and the
intent is to avoid caching data that will not be needed again soon.
I believe skipping fscache writes during Ceph writeback on such pages
would follow the same spirit: commit the write to permanent storage,
but otherwise get it out of the way quickly.

Use folio_test_dropbehind() to treat such folios as non-cacheable for
the purposes of Ceph's write-side fscache population.  This skips both
ceph_set_page_fscache() and the corresponding write-to-cache operation
for dropbehind folios.

The writepages path can batch together folios with different cacheability,
so track cacheable subranges separately and only submit fscache writes
for contiguous non-dropbehind spans.

This keeps normal buffered writeback unchanged, while making
RWF_DONTCACHE a better match for its intended "don't retain this
locally" behavior and avoiding unnecessary local cache traffic.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
Note: this is an additional feature on top of my Ceph-DONTCACHE patch,
see https://lore.kernel.org/ceph-devel/20260401053109.1861724-1-max.kellermann@ionos.com/
---
 fs/ceph/addr.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2090fc78529c..9612a1d8ccb2 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -576,6 +576,21 @@ static inline void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64
 }
 #endif /* CONFIG_CEPH_FSCACHE */
 
+static inline bool ceph_folio_is_cacheable(const struct folio *folio, bool caching)
+{
+	/* Dropbehind writeback should not populate the local fscache. */
+	return caching && !folio_test_dropbehind(folio);
+}
+
+static inline void ceph_flush_fscache_write(struct inode *inode, u64 off, u64 *len)
+{
+	if (!*len)
+		return;
+
+	ceph_fscache_write_to_cache(inode, off, *len, true);
+	*len = 0;
+}
+
 struct ceph_writeback_ctl
 {
 	loff_t i_size;
@@ -730,7 +745,7 @@ static int write_folio_nounlock(struct folio *folio,
 	struct ceph_writeback_ctl ceph_wbc;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_osd_request *req;
-	bool caching = ceph_is_cache_enabled(inode);
+	bool caching = ceph_folio_is_cacheable(folio, ceph_is_cache_enabled(inode));
 	struct page *bounce_page = NULL;
 
 	doutc(cl, "%llx.%llx folio %p idx %lu\n", ceph_vinop(inode), folio,
@@ -1412,11 +1427,14 @@ int ceph_submit_write(struct address_space *mapping,
 	bool caching = ceph_is_cache_enabled(inode);
 	u64 offset;
 	u64 len;
+	u64 cache_offset, cache_len;
 	unsigned i;
 
 new_request:
 	offset = ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
 	len = ceph_wbc->wsize;
+	cache_offset = 0;
+	cache_len = 0;
 
 	req = ceph_osdc_new_request(&fsc->client->osdc,
 				    &ci->i_layout, vino,
@@ -1477,9 +1495,11 @@ int ceph_submit_write(struct address_space *mapping,
 	ceph_wbc->op_idx = 0;
 	for (i = 0; i < ceph_wbc->locked_pages; i++) {
 		u64 cur_offset;
+		bool cache_page;
 
 		page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
 		cur_offset = page_offset(page);
+		cache_page = ceph_folio_is_cacheable(page_folio(page), caching);
 
 		/*
 		 * Discontinuity in page range? Ceph can handle that by just passing
@@ -1491,7 +1511,7 @@ int ceph_submit_write(struct address_space *mapping,
 				break;
 
 			/* Kick off an fscache write with what we have so far. */
-			ceph_fscache_write_to_cache(inode, offset, len, caching);
+			ceph_flush_fscache_write(inode, cache_offset, &cache_len);
 
 			/* Start a new extent */
 			osd_req_op_extent_dup_last(req, ceph_wbc->op_idx,
@@ -1514,13 +1534,19 @@ int ceph_submit_write(struct address_space *mapping,
 
 		set_page_writeback(page);
 
-		if (caching)
+		if (cache_page) {
+			if (!cache_len)
+				cache_offset = cur_offset;
 			ceph_set_page_fscache(page);
+			cache_len += thp_size(page);
+		} else {
+			ceph_flush_fscache_write(inode, cache_offset, &cache_len);
+		}
 
 		len += thp_size(page);
 	}
 
-	ceph_fscache_write_to_cache(inode, offset, len, caching);
+	ceph_flush_fscache_write(inode, cache_offset, &cache_len);
 
 	if (ceph_wbc->size_stable) {
 		len = min(len, ceph_wbc->i_size - offset);
-- 
2.47.3

