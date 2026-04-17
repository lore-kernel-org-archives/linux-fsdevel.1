Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5237F00A
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776466650; cv=none; b=YMfFd+9VUFykY3zg1CVqxx1DYQYwa1iHvpWUWz9G0E0VHrQlwg6WCzrQOOCsXbg6/fIbuvZTdJWe8p9rgukMOgvyT0UfLjpnyf9sBZWnpXGCLkNNrdnR0wLRKmC+U95pfZlhr9Bb3nKyE5Ke60BAxttN2vJdgpXZBHS+F6lkQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776466650; c=relaxed/simple;
	bh=sPqyP5bAWRLVQUQ1xHjl8LHnserzJPjwHB0RoAyAe1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKjyuCOY95rkD3GOqNGAK5ubRnBmOzICIpVZ2ARg5tfqo+WfBEA5h67uwzMOG5WgstiUt5elS2DmE5GwYsOXseNCj5zNKgQusVakUox2fC/HGHgjfsJcqOvCHn1rSXYq1KPVp6guyJFMt2akt7VgRxmn6GL6VF8X7paW7bZi7NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1gAGGYT; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1gAGGYT"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8acb7f2586bso12792626d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776466646; x=1777071446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8lfDYWV8wgoMG9u/N/hKMSAzR1cznOubbXPV8IlRC8=;
        b=L1gAGGYTSJDa7OHzBmSP6td0m8QVMYBxKLit49AgRe/Lygh6VnIzDO8/FcCBX22KYl
         e2n3MdTj/QCXe0XqW+xoruoIKqk8OHwrk/1uO4bQJDFIwyMBN5V5mjjvvtYGx1bTCNTW
         PaVmZdvR8hh+WkQ9VJ4zepCJ3yFUubMxhD+jv9RKqMe2p6kcQNvoWnaGfOvt6Gf0GMq4
         +IRN3Ar2nlEh4ER7y/wBbUTpZD4Lpd8LINbSNbqqUY79ISS5P4IWPE7S51h/oOgfkoY9
         lrzTWtNVk3s4qV8huBE6Aw00h5nH2iWM9r0UlVne/3+HEoX7a4+t9HRPKYGQwDS5EdAu
         1FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776466646; x=1777071446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8lfDYWV8wgoMG9u/N/hKMSAzR1cznOubbXPV8IlRC8=;
        b=KXIB04XYQaOH5EHbASaGA6HityXhmm0DlvUKBAinf80yjC+xLE40ptQm58OoJQzbhX
         8h6DFQI2xdGPtqSMofivHWHQvAXpXlF0rvsIRqsxVgqx5fkJnlcasKAG9jeZnC6kZzb/
         3iEicJlPZC8VqjR6BtqiCsqYtZVx6Lem1ZiWT4PVS0iNjXjXKO9Go2XwYu6VIaiThVGS
         vt45LlKYB9fCd3qfAuh3rlLkE89gWysQK+W8wlt+8wh+s6hr80BL+pioMEvWFkJeQ20X
         p1AgcdpsTkJ1XIfkDzBua8RIPsNv1VjGguitTMKzEKPInVn5Sebej2qqkY+y3hItOEum
         y4wg==
X-Forwarded-Encrypted: i=1; AFNElJ8Bk/6u7AcTfr9m6LzMlFYtBnmZzm4w1+HSAA+BpYL7XRw+o2Heo6WW161JbMze7ivfrHsfcnajrR1COCBM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqo8EGgzIBPntWAncYWifI7SnUJ4DOIiavwHla/bGnqf1PJYSd
	VPhBNOqAD70K424R2wtNbXSTYsJom/e19w7/keVkabHfLjchE/r7ghJp
X-Gm-Gg: AeBDieuf1Pt028koKsi5kdsLumuafQVFr5iFNku09uQ2H+OPnyfRa8NbyoLrl35sTzU
	eztJQu+NYdG2aep9z6EZp++ucoe0qlOhVHRZrNt2w3GxIEGLZX8lheaXnpjsHc/66ayuM0xoo6s
	VVMaqTfq4YJn2nRqzHuHDL1DNBcjHFytAXyIpNw93++mvuYsGtIaNv8M0ZrSIhyJ3vYKnXfBtep
	uz+GzkUammYyHRsfd8wTOCae/Ur0nmgP2UKFH2FkyuY1MM6U5XS/ayM6cm3pr29iur3x51t1LCU
	jal5acBfKzrbYvZ8f5mAHuud8xNX/Yp7ELOiWVfAkE8wDara6gr7pjpWblfxI/tf2K37kNKO6rI
	IKTG5f41FIxDpfpkA+IXT2Sh9nZXs6CuoPdN7HpL5CCLzRkwfn0A/7Y4X1bKHwZO+EE9ZVvub8t
	gLLN3z4exEgDzfJZffNpmB+ethk18dhmyCg/nHtuNMoVcClFoQk8Q4laZeCaoAM5I7NA3lY/uob
	w1QkLPS58mM2FAKCENLoz6lXa66fyvEuAP9qSkBEJEQsXVKptS9Yq4v8Q7cM6m+
X-Received: by 2002:a05:6214:4019:b0:89c:da2b:4903 with SMTP id 6a1803df08f44-8b02822c9cfmr76690446d6.46.1776466645910;
        Fri, 17 Apr 2026 15:57:25 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c4b9sm28948896d6.28.2026.04.17.15.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 15:57:25 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ntfs3: validate split-point offset in indx_insert_into_buffer
Date: Fri, 17 Apr 2026 18:57:12 -0400
Message-ID: <20260417225712.1736320-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

indx_insert_into_buffer() computes

    used = used1 - to_copy - sp_size;
    memmove(de_t, Add2Ptr(sp, sp_size), used - le32_to_cpu(hdr1->de_off));

where sp and sp_size come from hdr_find_split().  hdr_find_split()
walks entries by le16_to_cpu(e->size) without validating that each
step stays within hdr->used or that the size field is at least
sizeof(struct NTFS_DE).  index_hdr_check(), the on-load gatekeeper,
only validates header-level fields (used, total, de_off) and does
not walk per-entry sizes.

A crafted NTFS image whose leaf INDEX_HDR reports used == total but
contains one interior NTFS_DE with size = 0xFFF0 therefore passes
validation, descends to indx_insert_into_buffer() through the
ntfs_create() -> indx_insert_entry() path, and makes hdr_find_split()
return an sp whose sp_size (0xFFF0) greatly exceeds the remaining
bytes in the buffer.  The u32 subtraction underflows and the memmove
count becomes a near-4-GiB value, producing an out-of-bounds kernel
write that corrupts adjacent allocations and panics the kernel.

Reproduced on 7.0.0-rc7 with UML + KASAN via a crafted image and a
single 'touch' inside the mounted directory; crash site resolves to
fs/ntfs3/index.c at the memmove.  Trigger requires only local mount
of an attacker-supplied filesystem image (USB, loopback, or removable
media auto-mount).

Reject the split whenever the chosen sp plus its declared size
already extends past hdr1->used.  This is the minimal fix; it
preserves the existing hdr_find_split() contract and relies on the
same out: cleanup path as the pre-existing error returns.

A prior OOB read in the very same indx_insert_into_buffer() memmove
was fixed in commit b8c44949044e ("fs/ntfs3: Fix OOB read in
indx_insert_into_buffer") by tightening hdr_find_e(), but that fix
does not cover the split-point size field path addressed here: sp is
returned by hdr_find_split(), not hdr_find_e(), and the underflow is
driven by sp->size rather than hdr->used exceeding hdr->total.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Cc: stable@vger.kernel.org
Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---

 - FYI, I have a larger refactor variant that migrates
   hdr_find_split() to the validated hdr_next_de() helper and closes
   the whole per-entry size-read class for that walker.  Happy to
   send it as v2 if you prefer the wider change; otherwise this
   minimal guard is scoped to the actual memmove underflow site and
   is easier to backport.

 fs/ntfs3/index.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 2c43e7c27861..24add048b4b5 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1844,6 +1844,20 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	memcpy(up_e, sp, sp_size);
 
 	used1 = le32_to_cpu(hdr1->used);
+
+	/*
+	 * hdr_find_split does not validate per-entry sizes, so a crafted
+	 * NTFS_DE whose le16 size field is out of range can place sp such
+	 * that (PtrOffset(hdr1, sp) + sp_size) exceeds used1. Without this
+	 * guard the u32 'used = used1 - to_copy - sp_size' underflows and
+	 * the subsequent memmove count becomes a near-4-GiB value,
+	 * triggering an out-of-bounds kernel write.
+	 */
+	if (PtrOffset(hdr1, sp) + sp_size > used1) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	hdr1_saved = kmemdup(hdr1, used1, GFP_NOFS);
 	if (!hdr1_saved) {
 		err = -ENOMEM;
-- 
2.53.0

