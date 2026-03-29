Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E14258EE1
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774759054; cv=none; b=WnVJQFyupJeHi3nWA8mVrtsZDgn5jrjyM9p6B6J3O6AMG1Iy16+Ux11ENiOTQ0bsvTC18+vRS9WQRxwDSi6CwOhYtby8LkrOaBlibm3GZE90c0WrrDxIZGtG2VHJwAD+ZZN29Zbis3feW11Iot1fYFhoVXiA920HN7BLa5+MCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774759054; c=relaxed/simple;
	bh=u0CFV0ho4bABiW5hrTt5sb0+z/z311Lou6Focac5ZY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdGN15vRMxXXITBbysSn/0W7WYzxnjoHO7JE64Kkmik8HU5Di0YKzkxkZ08XrsaOYDrwEHog3qTs2gtKhqvqZzeqO0ReHxnd6MxGesK43IQHEGKNCdn706LbEhZJrcWP8H/pco1GqTh/0Gv9yy2b8gKHExyoViGgeLpp3vhVJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=hEqJF/uA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="hEqJF/uA"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d95017a68so431814a91.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 21:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1774759052; x=1775363852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR9CUyvApmvn0yWA7JOocQfIYBlfpLLyGv3hbHiybeY=;
        b=hEqJF/uAsDYa3WlLW5MUcYFEcOa62VnuByZeQNvtRFsNG7hogmEzH26IfwT41OLCf9
         U/h6JrNH/OzGxM4Dqc2PQnqchScz+A2NkS5H//D72Hgj/5gMrqS3AtULviNP9FTXinms
         AlgTlibpeSo5fcB+p8gPI2i/kRqmb2vyYxOAJwI0DFnWopi6FUJL/SkLixEviq/AMzfg
         pJVu085C0lnuJxw1QEOAXm/5rg+yElZqId/NZVxREek7suJ8WuEUrCQps5xeiTPPJ+q4
         iXUd7I/NzVUEMLtflO/MNF1g+XHXjd7Y+8iHkxBMKabMJ8DZLiSDiMrFrJWJxqKNimyb
         bZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774759052; x=1775363852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JR9CUyvApmvn0yWA7JOocQfIYBlfpLLyGv3hbHiybeY=;
        b=tD2BRouKkKvtnd5zKIAHDxsZ0RMnov+WbmxnmI4gfQCPZSRQ4+SjL+VFHbLDpK6V1o
         d8QyhTyNcJ63JOgfuEbfDk0fX+eKvlYNL1JbIO4HJrQtnw3PkRcdRYJPTAg3UBxMWuNe
         xnxcXl29oWy0MHw/z21jRpOlvIhrkXOSJ/10iBUJ0rhKF+5p8E4bn171rcAXTV97HN2H
         yx8Bvi4occUXZOXuOxfNymI8y2jy60K/YK6doaR4HgJSrsjn1Y+bYiM4VEnvcmtTZitq
         k1oLjaXV3vifR4oxDsnQTFPfdivPP2jcLNv1y5K1ZSQ0GHwWfrK87EpRM6nHmCjwgGwZ
         vZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmPo4ehh2KYvVbxJk5vXxWj8riwxT622N49z7n2hYyKHyzALluUwzLt/h+x2/nuGJ0fhJ8Qd5cn4z/PJii@vger.kernel.org
X-Gm-Message-State: AOJu0YzOv7EjsnrqwB5oYLAAlaszhzHwrSX7+rJo41a3QsVp4OA14ckq
	BnaWfCV//2nLqKaXpjTD6yFXOH917rchXLUGDSwAdAQWJIzwvW5kCwORnCWZn+i8E/k=
X-Gm-Gg: ATEYQzx/nJ8cs932jNi/BVsXjF+SFAY7glMay/XVRSOUtZaFUWftH9Zrevqm4/oTug3
	rHN6aajRwIxgHujVfoE3XaOHm//R3PDamCbs0Uz3rSH5EmdqswwMqZvMSRADaREekm6ANAoh8Ks
	DjmZ/0IJ+X+9uriuIxiXhIDFbLhdRNOhoq4Lm4XGGW4eOGkvG2gcjJ0NjK5EIjlsqH9mHt/b/iY
	aGUqy2jbll5v2Rifm0IcLffOWMgrhXPyLiqVPsf7kmOnzKfhWB+Uw3VJI39VlHC8CuXrhGJ8Svh
	r/4IUo6kzHlqMNEnVveqeUqC0+LBSlGX5m9T8jB0XGbhLjA0udyOsIjy+BTObKQmj7Z+7SA9j9q
	U0v0IK3CHM327S42mEUwgtluV4wVC2jnCELHyuU/KJ5VtDp0nhGPpMRPrky35iAjawlz/2HMal6
	q3
X-Received: by 2002:a17:90b:28c7:b0:33b:b078:d6d3 with SMTP id 98e67ed59e1d1-35c3007ed0amr7400264a91.23.1774759052247;
        Sat, 28 Mar 2026 21:37:32 -0700 (PDT)
Received: from gpc ([2400:8902:e002:ded5:78c1:8178:95c1:6ca3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d94d057bbsm3385004a91.1.2026.03.28.21.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 21:37:31 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: usama.arif@linux.dev
Cc: Liam.Howlett@oracle.com,
	ajd@linux.ibm.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	david@kernel.org,
	dev.jain@arm.com,
	jack@suse.cz,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	npache@redhat.com,
	pasha.tatashin@soleen.com,
	r@hev.cc,
	rmclure@linux.ibm.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	vbabka@kernel.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH v2 3/4] elf: align ET_DYN base to max folio size for PTE coalescing
Date: Sun, 29 Mar 2026 12:37:00 +0800
Message-ID: <20260329043700.19355-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <0725ce97-b8a3-47c9-952f-7b512873cc35@linux.dev>
References: <0725ce97-b8a3-47c9-952f-7b512873cc35@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> mapping_max_folio_size() reflects what the page cache will actually
> allocate for a given filesystem, since readahead caps folio allocation
> at mapping_max_folio_order() (in page_cache_ra_order()). If btrfs
> reports PAGE_SIZE, readahead won't allocate large folios for it, so
> there are no large folios to coalesce PTEs for, aligning the binary
> beyond that would only reduce ASLR entropy for no benefit.
> 
> I don't think we should over-align binaries on filesystems that can't
> take advantage of it.

Ah, it looks like this might be overlooking another path that can create
huge page mappings for read-only code segments: even when the filesystem
(e.g. btrfs without experimental) didn't support large folios,
READ_ONLY_THP_FOR_FS still allowed read-only file-backed code segments
to be collapsed into huge page mappings via khugepaged.

As Wilcox pointed out, it may take quite some time for many filesystems
to gain full large folio support? So what I'm trying to clarify is that
using mapping_max_folio_size() on this path is not favorable for
khugepaged-based optimizations.

Thanks,
Rui
