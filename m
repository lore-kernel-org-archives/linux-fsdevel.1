Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD0385515
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404068; cv=none; b=pFhwoFMjOFZW74tzz0NyZwPZI/vWSiMlGxu35MQTQUJtqPTPjHlB+6kAbzMnTo2Cfbp3kwHBciKFsOAd7ODpt91H1H0VOm8QizURnjXrx2cTQto8wXcOrRyXKZNHfKCBBy4B9NR0pcyz+Ubu42k7iRfkGpL7XVIdavZ16uYYYbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404068; c=relaxed/simple;
	bh=e/lP6FVbchEyJIYXq4LmYQCtDNuEWEzfKnmtuo1LUbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDaP0KFsuDxbzZG/s5wNwnAZTi81x8aIcLyyMTRtieKI3+7/LqiAODiNnDcxm+XA+VBQlsWrQg3EpYmMUI/DpZ14U3aUqtV0nxzpmk+D/OvSH1m+8B3SpahhGawwbRyoFXT9gMBLL0+IZMmtl7ZX50EGEgyg9e+68WV+K7KGBK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6i2RCfz; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6i2RCfz"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-86868f7707dso751254b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 23:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790404066; x=1791008866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fsfTPhNruT6u4HsVVzvGX6fLV7k2Eq/9mGa2xt6fTOk=;
        b=Z6i2RCfzMmqdaTNZIN2IJIZzsPQwAV8Eh7Q+KnMaWmZg09mDYIlULZMx28but88tFE
         i4wG/MfZUClN9IIP/WPAT7wb6S2UjwmWOyAIzPBBa02IgnZxF/Yp0I1XNZAc2ezs2sq1
         A0G+Le0lb/MnDQUvlvgD4vG8B6eFJ9vlv6PK3ntAUG8rwFz5pWR+2B7uX3ElgyoLMiNZ
         43EAibBal4uqQbb3O8opKyLxAa1yRYOdu2bnFyn9TI974UrJQhPXzE4GTtTCep4/YheJ
         HjqLIS0yDtptubQiz6VwumPhnOJQq3LNNt1j56C/bviU9izoLp0qzmTmVPr+yvP7x8Xb
         1SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790404066; x=1791008866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsfTPhNruT6u4HsVVzvGX6fLV7k2Eq/9mGa2xt6fTOk=;
        b=e5h2qgwuxZ45OfBLihg9S45FoGAiYZM/9pgQ1WZNx3g4A1Ev++6Khh5ZaSa/jD1l/S
         nrmqG29Vk56s4jxtjH8TAEXWlgkUsW/LC4v4ySf0xyQWipAXMR3B05f8VFqxVqr4BQIz
         fMSbaQ3TuMm42uyBnGC6hDYP1ehRJCVNfvryhDzAKpRUKHjLumKKswDhaw9s8cQvn7Ae
         95fZ4fo0Tg/GN23FXW0p4Zu7rCg1rP9jJ2urIjD425zxM6u6OKQe47YGbdjky4wTnAd1
         kCxmEBGaQkXBJTYtgukeGfycRPwDcd3V5c7r91D2LA/lFFaJPSoLPe9Bndedpm6anXsy
         mNwA==
X-Gm-Message-State: AFuF++lfRB6KpXNONthMn7TSChE2FLvrZVxug3S2AbcFlgBmkN3OsYC2
	DVhh5hmCqDCEeEnkFqONBQvigTi55s9kjfkoBdpCbesooorqmXGaR4Hv
X-Gm-Gg: AYBFou3ROdoxLPiFVY769PTRIwJF7kuekheUdOMsSrVYXhIJQqKCVVHo7DOiCUPuJz5
	kq7FWyEhf4KjlH8c11Zarw1YBzKz022dRefdo5wv6iF54uq7uEo96DYZDDo9Kjal6oErWzrwapP
	BpWMko0SwcMgwdQnVa4S3AUSjxYoVNsRD9JqNAJfAgjJFqFk0OQbTfLFxvxXBJLfbYECDSPNUem
	HD+3SGB8G3dpJrNYPXJJkuA0fknHvsQ+FUEbGC1efxzetG52kwFKxdzBJcgSvsPypxQJSBuvJ6t
	sXCkLWHXQf70Fpg2/f8IPs4IC3idrEwx0+2BfNR1TGoLyJEuO6Qcpl60A3tmxW7UDU5brjvnpiz
	qHEcx4EJeQ1hkb/5I34vykzAqNY0ngezQ3+V7oURo57wekEzvLpWkY1xcvrruz7fmdMv3ZFCNHo
	hg0tnbnE1J+LyN1veGk7AGPDSfj3INOoMrAXRfQ7DIK5L7h3ljBo1tyGo67UI9QgiTwu+mn1igy
	CazC9selaWJLyZXBi/H9vnQ5ieWBCxB1Sm3R+DCnJrDK0p7m+jq+WnIXuEtb/7ojNxNHtNKypT2
	+/gcCKE9clcamdCXRk6bo/ahw4M72F4CV0FVWkknIE/ZV6Z69w37H2S7Njk=
X-Received: by 2002:a05:6a00:66cb:b0:87a:346f:d032 with SMTP id d2e1a72fcca58-8804b592218mr2424395b3a.47.1790404066266;
        Fri, 25 Sep 2026 23:27:46 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87feba7c6e8sm2053529b3a.56.2026.09.25.23.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:27:45 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] affs: compact the linear extension cache, not the associative one
Date: Sat, 26 Sep 2026 14:27:42 +0800
Message-ID: <20260926062742.3874033-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a file's extension-block count outgrows the linear cache,
affs_grow_extcache() raises i_lc_shift and then "shrinks the old cache
to make more space":

    off = 1 << (lc_shift - AFFS_I(inode)->i_lc_shift);
    for (i = 1, j = off; j < AFFS_LC_SIZE; i++, j += off)
        AFFS_I(inode)->i_ac[i] = AFFS_I(inode)->i_ac[j];

That loop is the compaction of the linear cache i_lc, which is indexed
by ext >> i_lc_shift and has AFFS_LC_SIZE entries.  The associative
cache i_ac is keyed by the extension number stored in each entry and
needs no compaction.  Applying the loop to i_ac has two effects:

- i_ac has AFFS_AC_SIZE entries, half of AFFS_LC_SIZE, so the loop
  reads up to about 2 KiB past the end of the cache page.

- i_lc is never compacted, so after the shift changes, lookups through
  it return the wrong extension block, and reads return wrong data.

This happens once an open file grows past AFFS_LC_SIZE extension blocks
(512 with 4K pages, about 18 MB with 512-byte blocks).

Compact i_lc instead; the bound stays the same.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
Reproduced under QEMU with KASAN on a crafted 45 MiB FFS image with
512-byte blocks: after an open file grows from 320 to 700 extension
blocks, KASAN reports a slab-use-after-free read of 8 bytes in
affs_get_extblock_slow() at the shift change, and 3990 of 4000 random
reads return data from the wrong block.  With this patch, KASAN reports
nothing in affs and all 4000 reads are correct.  Image generator, test
program and QEMU runner:

  https://github.com/matthiasgoergens/linux/tree/reproducer/2026-09-26-affs-extcache

 fs/affs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index 23e088a7ed4f..4fd9ec3b3d79 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -82,7 +82,7 @@ affs_grow_extcache(struct inode *inode, u32 lc_idx)
 		/* first shrink old cache to make more space */
 		off = 1 << (lc_shift - AFFS_I(inode)->i_lc_shift);
 		for (i = 1, j = off; j < AFFS_LC_SIZE; i++, j += off)
-			AFFS_I(inode)->i_ac[i] = AFFS_I(inode)->i_ac[j];
+			AFFS_I(inode)->i_lc[i] = AFFS_I(inode)->i_lc[j];
 
 		AFFS_I(inode)->i_lc_shift = lc_shift;
 		AFFS_I(inode)->i_lc_mask = lc_mask;

base-commit: 6812ce4e4379ffc99c52401ec28f0d7ffbc36206
-- 
2.55.0

