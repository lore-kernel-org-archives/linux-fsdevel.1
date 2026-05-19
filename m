Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC332B10D
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212910; cv=none; b=U1UoImQmjab7N0JyH5JqyA1HRXQSZodBbEQ/j1E7s23uDl1T58GxZmDJzBJBgmGhCNNbJ7JspyoVMDeSo0YFphq2X/d2G4/GIwpAHQEhQJ/PEgzsK0F/ET/ogOnDCt4ZdN3IJ7bvdRSLMOtkiuO7A8/QFJS5yzXWWbs6N07hD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212910; c=relaxed/simple;
	bh=JKne1dBLa7FzCCy78inKoxP0nBg3Ro/HwFau2hSNvE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBKEuA2jIqfZ+a1FYh16TtNl2oTamniqo1/m5if+EIZaN6+FQudVnLJzsR/qs/dPDOspUX69hdsZF1yvrN2AtATYcDipduApUOI1g3znvAWPmF69ihuu86PD+7l3NWBUxClA/FJ/CCKeDOcjZceYRjvbLXlJ7dLo4pP38iM2FM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wp5hW1Zy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp5hW1Zy"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8f97c626aaso778711766b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779212905; x=1779817705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuqPpYNItKvbmM3JkB0XkVVRp2zvwe7MMuOyTFq6M7E=;
        b=Wp5hW1ZynbDrZG2MBIyp0Ko/z1z6LLw9LnYoNYqXztpJ9vUagKjKCo6KmWECVNq+Ro
         d4dQ8zgAjGyeJq1MfxT50ZaChKivAmWts6x7MW9jQ2SB6ZdO9Ieg1xK7q//KsFQzo5vq
         Nq7LxscVP7DuBrY+08ZS3SzRW0yjub2T7yUpGiJPWfwDnNWQPCYNj8gCOO4zCseaDv0u
         cYEZjjacROdO98zmLS0sSIeuLqLE10rubE6oJn/eUQ6KP13b6LejlAajCQnPVzlap1t+
         wWzV0g6KP6NDxPRua1O4VsA2jn2hBssfw7kQWCEvO24M71JhfvE5RB7sRiR05A/hF80z
         321g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779212905; x=1779817705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AuqPpYNItKvbmM3JkB0XkVVRp2zvwe7MMuOyTFq6M7E=;
        b=tQN0fOfnSjACzILE8T68sPUxageynTaRxuZW/pq+Ykr/cgY26dXpxdoDHmIzk5hqAp
         negEUnrPDoUChr7tGlclXP7GytfKaT6mHXQ8HQ8ZYqevaUjzO6nIZz48+vww7Lkkf/wT
         7TKr/OKCWvU4F3kNCi8P3f4HGaXs3BtXMBgCqNG2XcLk43XiCAVe+qUT4dTdB03JhKIV
         t7dPQb024eYTD7SH05lrcER1XHmBWr+TZsh9enV5Xo8bZJVWhUafHq7m7OaKdti8SC0m
         +/T042q8KoWfH0gPed2pXoXEHgokw9TWg8jdwLZbVV3bY+3GfVBQSUTEyxss3imE8hbY
         ZyiA==
X-Forwarded-Encrypted: i=1; AFNElJ+KZx+q6MaTHg/JzwQk32sJF0mmTl1TWNiZKFCLzScZMZNmJIY2HGbhfeZzIbd7j/xKFwOOAsI/S1MJjKqV@vger.kernel.org
X-Gm-Message-State: AOJu0YwLNrDkLk89W5Ln2BnEzWNxkdAsDNorfH3/s6sCwFQLFJ4PPToy
	V0KyUpp7/pjxFOsFroebXkR5PFcKGPmzKIB2JOKRPhd6CTrixdTqVXpo
X-Gm-Gg: Acq92OGA27ibKhfZ07qzBOLnOK6AHlvMCN0570IB+vPTAOzeZtu4ufU9jSzAOL3/n50
	40lVRNsKnNZEU/Z8TTix/c2LofufewpGhDnQjuN2PMa/hSHwxxA/kt66bSKWU7udvAfPzt8KajP
	2pW179OLdUfNu2YvJM32NujUysooDN/17ncHA4HjxSiS9yW9Eo6cZFJ4H1Eh5bXHSYextF3Jfa6
	u6PbMeePNfgKJTC/bLRB0SN3uGEmaGwvninkUSf4aqdjzcdzKiJpIVQiH34o2kVl5bL/JVXC+Nx
	hFnwpZ+Xer7ymrthttCZmiDs04dDzsUIi4pSSTlTz/44OKhH0Ra2SmmSUOghZHDexoMi/ljd5mL
	xX+3skUUErM6yXkvZTAqaQleA+/KY4q9wcwL3iiD91i7CvgUIihNm2mzoHuqyL/l8eq3zZmNT0S
	2mb2WLuahoe/GTQpkS
X-Received: by 2002:a17:907:160a:b0:baa:1d9:66ff with SMTP id a640c23a62f3a-bd5177f4e85mr1371009866b.20.1779212905008;
        Tue, 19 May 2026 10:48:25 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e21b1esm737917666b.44.2026.05.19.10.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:48:24 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org,
	leitao@debian.org
Subject: [PATCH 6.18.y v2] fuse: avoid 0x10 fault in fuse_readahead when max_pages == 0
Date: Tue, 19 May 2026 10:48:16 -0700
Message-ID: <20260519174816.3983940-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260518182602.3107764-1-vlad.wing@gmail.com>
References: <20260518182602.3107764-1-vlad.wing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 4ea907108a5c ("fuse: use iomap for readahead") ]

The upstream fix is the iomap conversion in commit 4ea907108a5c
("fuse: use iomap for readahead"), which rewrote fuse_readahead()
entirely and removed the buggy loop along with it.  That refactor
is too invasive to backport to the pre-iomap readahead path still
used by 6.18.y (and earlier stable branches), so this is a minimal,
equivalent fix to the same bug on those branches.

When fc->max_read is smaller than PAGE_SIZE (common on aarch64 with
64K base pages if the FUSE server advertises a small max_read in INIT),
max_pages = min(fc->max_pages, fc->max_read / PAGE_SIZE) is 0, so
cur_pages is 0 on every outer iteration.

fuse_io_alloc(NULL, 0) then calls fuse_folios_alloc(0, ...), which
calls kzalloc(0, ...) and gets back ZERO_SIZE_PTR == (void *)16.
The "if (!ia->ap.folios)" guard in fuse_io_alloc does not catch
ZERO_SIZE_PTR, so fuse_io_alloc happily returns an ia whose
ap.folios is 0x10.

The inner "while (pages < cur_pages)" loop runs zero times, then
fuse_send_readpages(ia, ...) dereferences ap->folios[0] in
folio_pos(), faulting at virtual address 0x10:

  Unable to handle kernel NULL pointer dereference at virtual address
  0000000000000010
   fuse_readahead+0x14c/0x490
   read_pages+0x80/0x318
   page_cache_ra_unbounded+0x1c0/0x2b0
   page_cache_ra_order+0xb8/0x368
   page_cache_sync_ra+0x210/0x320
   filemap_get_pages+0x290/0xdb0
   generic_file_read_iter+0xd0/0x540
   fuse_file_read_iter+0x8c/0x158
   __arm64_sys_read+0x1a0/0x488

addr2line on the aarch64 vmlinux maps fuse_readahead+0x14c to
fs/fuse/file.c:897 inlined into :999, i.e. "folio_pos(ap->folios[0])"
inside fuse_send_readpages.  The faulting instruction "ldr x8, [x8]"
loads ap->folios[0]; ap->folios was previously loaded as 0x10
(ZERO_SIZE_PTR).

Without this fix the function would also spin forever, since
"nr_pages -= pages" makes no progress when pages stays 0; in practice
the NULL deref masks the spin.

Bail out of the outer loop if cur_pages is 0 -- there is no work we
can issue via FUSE in this iteration, and remaining folios will be
handled by read_pages() falling back to ->read_folio.

Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
Reported-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
v1: https://lore.kernel.org/all/20260518182602.3107764-1-vlad.wing@gmail.com/

Changes since v1:
 - Add "[ Upstream commit 4ea907108a5c ... ]" anchor.
 - No code changes.

 fs/fuse/file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6014d588845c..782178124512 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -974,6 +974,16 @@ static void fuse_readahead(struct readahead_control *rac)
 		unsigned cur_pages = min(max_pages, nr_pages);
 		unsigned int pages = 0;
 
+		/*
+		 * If max_pages == 0 (e.g. fc->max_read < PAGE_SIZE on a
+		 * 64K-page kernel), cur_pages is 0 and we cannot make
+		 * progress.  Bailing here avoids passing 0 to fuse_io_alloc,
+		 * which would return an ia whose ap.folios is ZERO_SIZE_PTR
+		 * (0x10) -- later dereferenced by fuse_send_readpages.
+		 */
+		if (!cur_pages)
+			break;
+
 		if (fc->num_background >= fc->congestion_threshold &&
 		    rac->ra->async_size >= readahead_count(rac))
 			/*
-- 
2.53.0-Meta

