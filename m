Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7CD35DA68
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784774792; cv=none; b=qwZmgo0tcFiZzCDcjdrGSVA0s0Swa0x2CNdUcZIFPW+UsGcOxFzE1eO1jlV1Z5yXvMDB8yXwuI31yWhtc8gE9qmaW4ZzuI5PyIKwerJmyLERGBukDF/Y8S9M6WKfQzwQvVZsMG7FASPtmqEFQIX+cODnXgVBefrtEIT+fxKRX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784774792; c=relaxed/simple;
	bh=d3L2V6nh+JrQJVrcctRD6BzD4rjO44Y3KV9LnP7t6fI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A1tmJT3xGYHrucVOkIKXOerEDD3Y9XaslBFJ9QF3gUMDP1KLu7LiaEXDZNgw3F93rn+2QikyZBLMFL3bhNYMGtH9mT1jd8MCHB67qMZ7xDUp/6drfkQHmFgkmncyuDJA/w4vThxDtXMH1AMz1J8Oi3BymGIFI/r2lc1iwHDQ3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcvSogbQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcvSogbQ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso111073a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 19:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784774787; x=1785379587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Si8wKsJ7OZH8AFm088arDM3rFGkqQRF41Hdi0sqAHg=;
        b=PcvSogbQUDeeF54TFmgJChbfHjtKVcz4oEOKqFXxjdE5w516KSj0lv5gGeohcZIVRl
         cYpY6BHBVWzqY2cYtkzR0Uner80diHeFWB70chGTGywPOfcb7lfCDRXvaFPN/vImvd8s
         lkM2YIU59p4sANTmhKTNFw1Tm9ivFQs1f8anWTyCLiyT4bHNLTXFdw0n3mXnTXS+s9qu
         u2T+F853SL5rUvyRhIfKXZrGeVpkpMilxhhfBz6B14TWOsL5AZjyrGijSgUGvR3+hL7U
         Gc0lB5f6m6gQmYokBeYcXrWBgPwfQEcJQigvmqk3IF2CuyiBmEOkktb3BOBlrmy6Vlbk
         +9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784774787; x=1785379587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Si8wKsJ7OZH8AFm088arDM3rFGkqQRF41Hdi0sqAHg=;
        b=d6qGVGVFooDZrW0uMRpfOt0vYXK7QNh7p0A7ov8jZoZ0sirn2/nn0OwB71dimA5aBh
         pS0fE6od96sPph/snRG3/kWViPNvW/aIgevBMVdDbQQvePcujV0TvlF9wKbAg0Z52sFv
         c1asNfK308exTIY9ZSs07VBP2diQSBWIEjENT/O7c1QlpyrnHuSBrWOx+wtYR81QYWZY
         O1BX+YSGcwiWASFSvohNE5SfTEL3BIsEfljglo/iIA/MoIAhA07kD69REoxttPwYn+jz
         YBIHt8Tsz6Xjc39yt4iKcRwDNiWNDYczmQI7dkQY8KxaJifbxe0sle2Y2lcooocTgg9s
         mOMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJ1Prpq3DYrDugRCK0LvfghI28qDLudWVZs4s5bj/jGXdqECzj76rK3iY/w+vkUBdP/NW6FjHX0PcVZY6C@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4uqHSDSR0hbSHnRJEFA67Qq514PkOtnlGRoBqn/Rkz+ztn67o
	UnDG6K2KuEhBbc5ykXSSwW8T8iTSLuSxtDosTcnFQq/UAf1mLTYo7llH
X-Gm-Gg: AR+sD12koRsV4w5zDzQB4hlUF5EmCHafc25NJNr0i1Z5BUFXCuoTTEE5lywSd1Thoa/
	FDuPHlMeVmNdQTnzE+k8yXH17ot4avpEpqjM/Fi5LLgS6EKH9NY63Prm7G5xxrZ01ITW/EM1ca2
	jUc1dTFDv9PK4CVuWAahjCpGDfxe7D37Up83SCjEwfk0UttYEwgr0Mx/st/1bc2PaekuXmCpF7z
	J1rNSyG4ndqg7dy61+XleKXMiQpU16htZI5q3arj7N/55JfE1MnIxW7ve32R1WLH7J4v/RUqBaR
	wMiuBMalpyidOa7tohMTI28WMdgVdBb1Eg6lslgkAJB0z+HtJ06E29UmDC3GU3bpw6Rf7En4e21
	gExzT/4g0r0DQCtEDhIXwZVfPw2kzcBSYb9bj+W8+HgS58L2bzC5ZyhAQT/sQeOUPsEkEvoEbJN
	qLbZVnPAkeCDezEt5Euxw=
X-Received: by 2002:a17:90b:2ecd:b0:381:9028:5945 with SMTP id 98e67ed59e1d1-38ec64dc738mr1269231a91.14.1784774787060;
        Wed, 22 Jul 2026 19:46:27 -0700 (PDT)
Received: from zhangbo56-PC.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ecab80efdsm114436a91.6.2026.07.22.19.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 19:46:26 -0700 (PDT)
From: Bo Zhang <zhangbo0325@gmail.com>
X-Google-Original-From: Bo Zhang <zhangbo56@xiaomi.com>
To: oliver.sang@intel.com
Cc: jack@suse.cz,
	akpm@linux-foundation.org,
	david@kernel.org,
	fmayle@google.com,
	kaleshsingh@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	surenb@google.com,
	willy@infradead.org,
	baohua@kernel.org,
	zhangbo56 <zhangbo56@xiaomi.com>
Subject: Re: [linux-next:master] [mm] 7b32f64bc5: pts.svt-av1.Preset13.Bosphorus4K.frames_per_second 45.8% regression
Date: Thu, 23 Jul 2026 10:45:27 +0800
Message-Id: <20260723024527.2822383-1-zhangbo56@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202606181547.617a6967-lkp@intel.com>
References: <202606181547.617a6967-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhangbo56 <zhangbo56@xiaomi.com>

On Thu 18-06-26 16:00:42, kernel test robot wrote:
> kernel test robot noticed a 45.8% regression of
> pts.svt-av1.Preset13.Bosphorus4K.frames_per_second on:
>
> commit: 7b32f64bc512b40b268776c5ac4d354b325b3197
> ("mm: limit filemap_fault readahead to VMA boundaries")
>
>     169.95 +/- 6%     -45.8%      92.15 +/- 10%  pts.svt-av1.Preset13.Bosphorus4K.frames_per_second
>     220.57 +/- 3%    +870.9%       2141        pts.time.major_page_faults

Hi Oliver,

Could you help test if the below patch fixes the regression?

The 870% increase in major faults suggests that readahead is being cut
short too aggressively. The current approach unconditionally sets
_max_index on every fault, which likely prevents readahead from
prefetching ahead effectively for sequential access patterns.

The fix: only limit readahead when the fault is close to the VMA end --
if there are fewer pages remaining in the VMA than ra_pages, set
_max_index. Otherwise, do nothing.

For a 4MB VMA with ra_pages=32, only faults in the last 32 pages (128KB)
trigger the limit. The other 99.9% of faults see no change at all.

Similarly, only clamp the read-around start when the fault is near the
VMA beginning.

This applies on top of 7b32f64bc512 and can be applied with git am.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Bo Zhang <zhangbo56@xiaomi.com>
---
 mm/filemap.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 97772a05a18e..9f1e1c9ea6df 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3313,8 +3313,11 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	vm_flags_t vm_flags = vmf->vma->vm_flags;
 	bool force_thp_readahead = false;
 	unsigned short mmap_miss;
+	unsigned long vma_end_pgoff = vmf->vma->vm_pgoff + vma_pages(vmf->vma);
+	unsigned long vma_pages_left = vma_end_pgoff - vmf->pgoff;
 
-	ractl._max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
+	if (vma_pages_left < ra->ra_pages)
+		ractl._max_index = vma_end_pgoff - 1;
 
 	/* Use the readahead code, even if readahead is disabled */
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
@@ -3398,7 +3401,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		 * mmap read-around
 		 */
 		ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
-		ra->start = max(ra->start, vmf->vma->vm_pgoff);
+		if (vmf->pgoff - vmf->vma->vm_pgoff < ra->ra_pages / 2)
+			ra->start = max(ra->start, vmf->vma->vm_pgoff);
 		ra->size = ra->ra_pages;
 		ra->async_size = ra->ra_pages / 4;
 		ra->order = 0;
@@ -3441,7 +3445,12 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	}
 
 	if (folio_test_readahead(folio)) {
-		ractl._max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
+		unsigned long vma_end_pgoff = vmf->vma->vm_pgoff +
+					     vma_pages(vmf->vma);
+		unsigned long vma_pages_left = vma_end_pgoff - vmf->pgoff;
+
+		if (vma_pages_left < ra->ra_pages)
+			ractl._max_index = vma_end_pgoff - 1;
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_async_ra(&ractl, folio, ra->ra_pages);
 	}
-- 
2.34.1

