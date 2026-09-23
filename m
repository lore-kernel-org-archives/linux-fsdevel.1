Received: from mail-qv2-f40.google.com (mail-qv2-f40.google.com [74.125.230.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C648C8AE
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201394; cv=none; b=J79nEw4ofrLRB1KnMTJBMc7LaNtVkd4otPhg5skO5q+1kHzfg8R8+hAKMOc4voC8BMuyNJTJ6vyQaSrJs9HsyxpXRXPn5UimK+Qe5Z4P6pAEWaiDJQvImmUCVDFdMnR8oipzHMqJsigPJ6EM64MiynAwpEul+eXnwXO4uRl4GrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201394; c=relaxed/simple;
	bh=qUgi28KzXa/rBYmuGnRdzm2GomdlzkFdVTAERTef4fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0Lhu22aL65i98rprEmRbLfqKkVAHUUoyylB+EZixJxraglr03oSi9fUilDvAiJzOl71RhD8hwmpwOdw1NHb5R13tOC3XXHp67RE2KvJQNoitbeeCl73Fm6mBoO69bx0geRaBpM5X+RaudxPIXlT1/brz6bYb+Ea2wBM3emZGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dC8ANaOc; arc=none smtp.client-ip=74.125.230.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dC8ANaOc"
Received: by mail-qv2-f40.google.com with SMTP id 6a1803df08f44-90cdfe57a3bso10209516d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 15:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790201392; x=1790806192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K1Hvo7RTbP2R7EwaTKGv+PaU0aoOQ9FZzhpnXlX0iSg=;
        b=dC8ANaOcdlcw/hXF1QtFu+9WETRasZcor4Ac6D/KFt7/MedNJypEA5cZk7imdnxG1G
         G6p2hJyVnTaL7anDY7cri5ZnsKER3/n/fB32R2FPrA9LP11g+CpEQt1ym5dMH1YkTNmp
         3flOiq3iWFdZ+sxTWw5nYLLWkU+bC9Xqu2fs3MAgEKCXssxcwiood5434KHrf8+kcTez
         9UXFDAawjUs1FpCzk6fNCiMlhcSioNrZsXMU6gt79QlmL8IfzHDlmktVAWgZD5lJsTst
         sl0jAx0K9BxCjvICsgVv4SOz6W7eA1lT1eAH8p2tHWrCWkef3Zo93nw95ALLfzX/yZfH
         GaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201392; x=1790806192;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1Hvo7RTbP2R7EwaTKGv+PaU0aoOQ9FZzhpnXlX0iSg=;
        b=WfmwXIEpT9r84khnzIXi3/h7DgAp+QkX9DCqTVhcpzuneIEBflVVnJAVYSsGiRsUwy
         kKwiESWLZAy5B7sOUjSYaZ1MTxyBpkWzIqoQmRS6HLIU+dqAdgetemebe4kJhTo6UvPS
         eReN5oc9VwdHzKkEnxJJPytNxz/SLdH7J2Xu2HUIT7ErrXquBsESp0Wu/HU35CP/M75w
         bn4dTAJ1HA7DqjwbAojCf5Vu3E/3ba3byczsVXDJeSeW7ybZv07aq0/Ix8mdYbypjBh/
         Obho+lNr09DabF5sKY/dC7WigQMoDGmCIUzT5C+K272KClBCvlQE9Y0SX7wtYzSi3bb9
         6M2A==
X-Forwarded-Encrypted: i=1; AKwUvBz+XpopeNWdryTkeSuHDH6Y59UGX9jFNjy3Nymot23V2wkBZHceSgxn/btvRv+9sesxtbRFrJSS/SSmNIB5@vger.kernel.org
X-Gm-Message-State: AFuF++keMwzBWxe6uK74JrI/BLw5VPUc3CtSCzPiuc34qZ4rj7zhHmJR
	eLSM32cOxMXDhMUsphibolNMqCHCFohqFugsm8nxKc35URZF1ysInxwuqvY8PIdjKv8=
X-Gm-Gg: AYBFou0vkA7FEpOWpdxuCTfcXdueO5yDw0pstXvLaKsgx+qj4AUDeOt1wjvQAoYI1KW
	0mCez4pz7PcvHiuLmBQI5Nao0J2IUuDD6Z4XmiYWIQ2nhSfjW4yv4rrPmAmLkpc0zvxei50RR7Q
	zkxr1PioildA22QxbDtTHDU7OzQc6UY5wnog9ytjs7Xk77m+ek63gJrjlr/0OCvCy2nuAJiQoE4
	bIOLb2Cb4HF9d2OqzQ7iYQXsH4vj2mFYWLvCvVdBRbttH50nxsYmgfZaQvJmctIFllFgTKREUu5
	wZ5ImrCP8eT0wSwy0I2ZmMW1L46co743Nwvfw2eXS4ZcksMm8fzkMgtiOfOl305liWM6X/EBSdt
	yLs4b0dI/VhCa7aC0gRyeAbNr8Iq6HD8lsQWTb/DxAbIwhb0oJ6qkeCOWhCKMMrb5xRP8upv3Nt
	iLYECvX5Xr5Z3nypATUUgkc8G37OQfudluOLt8d01kGUubduNPXN7ZSizQyCMychDmNvX6HGvGb
	fQi+CNbRM7PvzXmD3anbtgWntHx3xh12FrOC7iM0L2+wIs5ZPMU27ljV5TPOAZdrww=
X-Received: by 2002:a05:6214:3282:b0:912:517b:9753 with SMTP id 6a1803df08f44-9141e966f4dmr9008456d6.45.1790201391865;
        Wed, 23 Sep 2026 15:09:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e217944sm3890176d6.9.2026.09.23.15.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:09:51 -0700 (PDT)
Date: Wed, 23 Sep 2026 18:09:49 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, jack@suse.cz, akpm@linux-foundation.org, 
	david@kernel.org, ziy@nvidia.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	ying.huang@linux.alibaba.com, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, 
	brendan.jackman@linux.dev, hannes@cmpxchg.org
Subject: Re: [RFC PATCH 0/6] mm: pass alloc_flags through folio, filemap, and
 bulk allocators
Message-ID: <arRM9qUFLfP04YUB@gourry-fedora-PF4VCD3F>
References: <20260923211041.3127588-1-gourry@gourry.net>
 <arRHr05gy_eu4WVA@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arRHr05gy_eu4WVA@casper.infradead.org>

On Wed, Sep 23, 2026 at 10:42:07PM +0100, Matthew Wilcox wrote:
> On Wed, Sep 23, 2026 at 05:10:34PM -0400, Gregory Price wrote:
> > The folio, filemap, and bulk allocation interfaces currently hard-code
> > ALLOC_DEFAULT before reaching the page allocator. Multiple MM series
> > need to select allocator behavior through these paths, so pulling these
> > changes out ahead helps both series avoid conflicts.
> 
> I really think this 'expose ALLOC flags' idea is wrong.

It is mm/ internal only - to be clear.

It's also already been partially exposed, this just brings the rest of
the interfaces with it.

There are use cases.  I initially only wanted to expose a zonelist
selection rather than alloc flags, but given ALLOC_UNMAPPED was
in-flight it seemed better not to propose different solutions when there
are existing possibilities.

I'm open to options.

~Gregory
