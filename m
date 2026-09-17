Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24E4D37DB
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644496; cv=none; b=BnxcXIrmfC/CkoDMoHiILRrXJXhYzXZVouzpYoDIAcxyLw1b5sKirCt5Gozwltwkl36NFfiE6q8LkKcI7uFHDwDrbuDYDMA+LfXjJO+mpMXvL6k8oNGsLIzcaR4a02zgVMEckazdnptdCc/CLgIWFd6+JANMVb28362YvezfDGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644496; c=relaxed/simple;
	bh=rkbgMLuM3vm0QjSeOouBx6sDtJtxGAt8tN51h/k1Emg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ka7T++7KliafTPRAd5K38U1K+JlRsdPOK7JOT32qg/GsHzUUHZtoNCV6jaCB17aQcecPBU6MfcLA4lpnqnPtMy2YNL/rC/GjODozqWt/NwySUvkTG082krrMFQ3jYgzw6W6kFpSq2HOX3qAromnKjF4Y/sqNMxYkVViy7Eiy+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cBiVsMop; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cBiVsMop"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so3897025e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 04:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789644493; x=1790249293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cPQWIr4fS6DSXVaIcQLRpggCO3UERblx+k2pBWKEiyY=;
        b=cBiVsMopEYxIp2v4ZQ0BZHIhPOhv1WkhfZIuu4HsqqQK2T4j917iiq1KN5c/fsjADH
         Lb/DrZRbp2YE8jKyKg5brHB8Ei8fXa9RRsZYJOu9PUMNXzPqiuM3h4y48c4CxnqggowI
         n9DZLWnAay7DQn4gweYncMCfKk8vjh+xGoxaFlpQF5t1SeWlXGSrVkG/lR8LmI6At+OT
         csDVDcxzQJx+0jpORA4Dm24qTlXpudp0AMa3Giks29Rq7Zdn7cEI92OQDOoXbs34Nl4U
         nIxCQyu9PJWh+fO+c4nhXpeAdIWHLIegu4mkkX+nSSnf5HlFlhml2wWtXm6vKZBOhzmk
         RjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789644493; x=1790249293;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPQWIr4fS6DSXVaIcQLRpggCO3UERblx+k2pBWKEiyY=;
        b=SGOK9cIx99rXu3ykqtWWKtWc+/j82/Bw9lFWSWjEwpJtwotgjRMMmDrVk+WbGNqQZ9
         dBwo1y2liAY+NOAEwzA3Z0RMYISWNe689WH68DX9+ik1+0IVJP9aWw4u9pXGKWN7KYo0
         6JlukCTxsiEnHArffDwXhixkB51Qu3qPk2yqRWjTtzQFACUobP41ITFaMgKthLNdHd2J
         9MmGRirDYZNBYb5PqDfcspskLTgjG0GHg9wq3P/rGwuHhnhLtP9B/PUgrOk73kPLcTjH
         ZhkVng8UhyDCYC9QVL5lLYZohGCnq4pMA/ISmOSYesqXkbnNvXm2tCStHdatzSz5usy9
         9vMA==
X-Forwarded-Encrypted: i=1; AKwUvBxB2cvSOEcmIznGpuo5qBZWoKj9J9Yh+Up3l3Zq98/KLARE3391FGIvtbyflCKm07XQtFxYjEU+MfIpUvw/@vger.kernel.org
X-Gm-Message-State: AFuF++lqBstiZ+oqdDGQhbOLGH/aAW027sTX7ZVDIOEWTxRlZ6WWuYRK
	wlImNmPtFFJjosTp/rF9Yx/YQ8zgVO0/+2nFP2RV6esabWvFMYnK+BtMXxpU2dQeZbU=
X-Gm-Gg: AYBFou2Sk5v23Bz3ZllBomiOInUQFiYYcjLX9GyG7RLnjDLFz2qvGq5VNeSucNlaWDU
	qaQlcR8c62N+wsEfG9psMWd4cDcy6obhDJnnZsm+PDRcb4LGxgJ+t8oLSbIoP0psBD0UuqztHub
	q/MAwklmKlnqcJC9/xd/000ZB43dxVCuGheHq3hf4HrWpFsDcAaAGuYfpzYoD9PLX9VEl65Wl2I
	wf8z1N9cXBojw68GOV9pB8Ga2Ald8cj4RdQjmgThZ5xmCjqgaxRd/AM/ffGyZN2t85gd90ro+fN
	1U10rB1eRLV8xvYjJgk7ZpTaIE3xnFqfQLUcKCdRcP5NNx4mhDgyKTnLAyYPDsv54uSQXlZigT5
	rh9MRtn1V54zOSUuQ9KCwWe0Rji6XsWONv+wQiWIUt++FMHIPTlcRDWJqdiU8zl9o16+UEZ4OMg
	A5eaGuq9L+imVIOXdQU4c3m9RvUXiv3vzIbGoEo4m9edTeaRDD57qwa3I3rvh3jPqZVyj+vbK51
	w==
X-Received: by 2002:a05:600c:8a17:20b0:49f:bd0d:59f5 with SMTP id 5b1f17b1804b1-49fbd0d59fbmr28486785e9.18.1789644492945;
        Thu, 17 Sep 2026 04:28:12 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf34440sm14542597f8f.25.2026.09.17.04.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:28:12 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:28:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bcrl@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, yi.zhang@huawei.com, sforshee@kernel.org,
	akpm@linux-foundation.org, rostedt@goodmis.org,
	andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
	senozhatsky@chromium.org, kees@kernel.org, tglx@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 2/8] lib/vsprintf: Use acquire/release for ptr_key
 publication
Message-ID: <aqvOybiwt5ZTBjAG@pathway.suse.cz>
References: <20260902074805.398540-1-ruanjinjie@huawei.com>
 <20260902074805.398540-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902074805.398540-3-ruanjinjie@huawei.com>

On Wed 2026-09-02 15:47:59, Jinjie Ruan wrote:
> Replace the smp_wmb() + WRITE_ONCE() and READ_ONCE() + smp_rmb() barrier
> pair with smp_store_release()/smp_load_acquire() on filled_random_ptr_key.
> 
> This expresses the publish/subscribe pattern more clearly and allows
> architectures with native acquire/release instructions (e.g. arm64's
> STLR/LDAR) to avoid the cost of full one-way barriers (DMB ISHST/ISHLD).
> 
> No functional change intended.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Assisted-by: DeepSeek:DeepSeek-V3
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

JFYI, this patch has been committed into printk/linux.git,
branch for-7.3.

Best Regards,
Petr
