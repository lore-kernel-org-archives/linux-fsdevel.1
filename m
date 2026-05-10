Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D6286A4
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778417138; cv=none; b=Klrzh3MYiMFcROGu7fc/oV/VJ8Ph/pcwKrqmL5rR3zTnv/26xQjJcslXQZhHFVHAaYRCiB4YvO/n+2aqsW0ZKZX7gn/hi02Px/V6ut9CtDrY+Q7rdCnnzEcnqnpg0iH3xzD/EnK7ijdBFwBh0ZbLPZkJu1+QfRQp7VRirfutFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778417138; c=relaxed/simple;
	bh=X/hFAuublZo3137FXmtleJGVotYYNrBYRLCfqdxFdXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eihoGcK50d1wHr6P7tsuuAe1MePcJJBb6qyx5fcFnHL7g8Nf7ktHqMPSbqo7nmQm/tMoKPxuRxS99t+ITxynvVwJzz9EeyBo1GTeORfqfZnTsHVxyBjM/uAJIEIAxzEii6E7szb6uS7nicnFsvMsRdh+HJWwfcrozdXRX+Ec6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKb4u5/f; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKb4u5/f"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0046078so27896735e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 05:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778417135; x=1779021935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdhWyaWXzaWwO4E5O8KkAS5mbQAZBKf8kRalyM8PNnw=;
        b=bKb4u5/fLKbqRpG3iQrNaE6bt+UKYRAsMmCVWsgU51dSdH6K/yHBXipeR1gwX0aOGO
         0nFOnceXnd+pHZYkZsnwLiXXBgGKeXESG3rv7H+zzCTYR3S5Ftus4HK6czh98KLlok7l
         kR+P57y9DrPv82p1j2JgB4pLQagJik5HDCAi1e9JHQBcLRpsZqEzzNuYfZGUqjtgrgzr
         xcGxVXASLzYfRE/Qf5hyS+zGPvwQj1HYKmcMQY8Uk3PpHjJHNHH4mkj5YxaHFO3rMlHl
         GZbD5B4JZH5DQ5ldlUk/T5CKF/PuBO8+LrnUF54ehgSCLp4xgU9NviZcvWLf2/b+ZJzz
         w92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778417135; x=1779021935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdhWyaWXzaWwO4E5O8KkAS5mbQAZBKf8kRalyM8PNnw=;
        b=A99B+45na40bwCCMcU3tjlw6WE89AmeyrhdFJ/XRbg0MEeZnVMSBNsUDcZdswKRGIu
         Gxm8QH3ZLWq0/eUFziZs7LMsQURXt6sZPKMEOrPUocI2ei9x7zqHPQ+eusj63V+B/Rgd
         nJ+J37yfVB9GhGtMtWFI0DrZOkxksRKW2QBQfbJzWRvftH9oBWZCVHmeDvcCpNGttoAb
         TssgyTg8OglSA0KTrBiyx0kk4mAfWubl1wZHmD6AXIPpv7CZ20h9UOCVmh6bkAOuYu8O
         8DHtadstjkJj3oAL22vkNnVY1jgOoB4zeA71C1mc8uSMky42NFobyF2nqICkVgBnyqxw
         UIUg==
X-Forwarded-Encrypted: i=1; AFNElJ8Oq35A6j9/tlc724i2aBg3IgafiGNNeQeHwugCZtGvDxaGYEr8rfd5JiLLUyfACzjS1LP2xkFX9t+NxYvH@vger.kernel.org
X-Gm-Message-State: AOJu0YzVO44ENL0r1e92KNl6TOkU1PBwjGe8mrL+oFXbd8XmpL9RFW+D
	NKglqDHjOzKoG8CuPO5Q5jTK59NzXKjcs3l+hC+zoKPO1L9pl0iZvu9t
X-Gm-Gg: Acq92OEJlu908+EYrxPAeqkwdZe30edCSy9XG7Hg1EHhifwbfsOGChYndhqNLLnueMf
	hJUoTVrRjEbivRGNXup/9bZ83F7JhF6Ly1KKmRyfGH+u0endJ3NHNtCe8i1T3OvPeqPUICOD4AZ
	22NyoacfIXxk+EZUt9d2D+5rTOwq5OKkWVIO2fOmLDyilGU8rbBBPa+nmWzWrcw4sWgTITu0kyB
	Q2PEr0CS8yqwUgEsQX3D2oVJLpnTdbKvo8bu0fYfkj/HvnsVnHbIMBmYDEmKI/8ZfWHnvmt86L1
	FaNNULC3YBgc0r+ERUgNbqTsurNmrSVdcHYbgErlntneaGyM3bZIVmvO5tJsLmdBKKwUsZmsZNl
	/p+s0j9mSW0PqbZW59iYdFl6XBPya4kcjPxtsi5JrlOazLRRVWSq0F1+RoYFP7YSS38afyc5de+
	82r9/WAdhMDQQdFtJEezYnRfwDEjxhh1vZ6s56bbwOy4Tjodcn
X-Received: by 2002:a05:600c:4695:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-48e706b26fdmr93427255e9.17.1778417135052;
        Sun, 10 May 2026 05:45:35 -0700 (PDT)
Received: from fedora ([94.119.44.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491bae13csm18186868f8f.29.2026.05.10.05.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 05:45:34 -0700 (PDT)
Date: Sun, 10 May 2026 13:45:32 +0100
From: Vishal Moola <vishal.moola@gmail.com>
To: fujunjie <fujunjie1@qq.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Haoran Zhu <zhr1502@sjtu.edu.cn>
Subject: Re: [PATCH v3 1/2] mm/filemap: count only the faulting address as a
 mmap hit
Message-ID: <agB97DSWxaS-z093@fedora>
References: <tencent_AA501E9A238337BD167E5C2ACF948A1AF308@qq.com>
 <tencent_756F151FE66F3D80479A6F982C0AB8569F09@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_756F151FE66F3D80479A6F982C0AB8569F09@qq.com>

On Tue, Apr 28, 2026 at 01:59:43AM +0000, fujunjie wrote:
> filemap_map_pages() reduces file->f_ra.mmap_miss when fault-around maps
> folios that are already present in the page cache.  That hit accounting
> is too generous because fault-around can install PTEs around the
> faulting address even though the fault only proves that the faulting
> address was accessed.
> 
> Move the mmap_miss update back into filemap_map_pages(), drop the
> mmap_miss argument from the helper functions, and decrement mmap_miss
> only when the helper return value shows that the faulting address was
> mapped.  Keep the existing workingset-folio behavior unchanged.
> 
> Signed-off-by: fujunjie <fujunjie1@qq.com>
> ---

Reviewed-by: Vishal Moola <vishal.moola@gmail.com>
