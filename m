Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821CE457E5C
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 06:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792044928; cv=none; b=MpekupP9742zlreCc/cE5xPLz+aUSLoSx2KDP4qT0Rr6FCyjkgWMjoFDtqWsC7ZGOD9oInciPNxMx6Q/ZGPbbMyqGqejFuras2+6ebHOuqHg5AdYDHcdEzsNc6rjmkOmadhmoNfdKS6pCBf08rYskMV8hXDff2oxeRwPVpA3KkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792044928; c=relaxed/simple;
	bh=smY6yBPbHEvgEFgKewvO2VX1mQwpxkybfqc6pFJnwSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyjlUqVs81LU3lZJ7TYTt2H/sKrpv9Ue+xL2xxe9/vk1xcqsZZuJJ7tJ81L9FbqI3QTYdhkx8R9KCVhF6Z62XjrcTVhcDC43ynhYIdiVKSC7e4vduLYO1EYHPEmsa3uhQ0A0pC4gIUlXBFSrHEVmMOX0JQ+fobthJ4vWQ+KRQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQqMXMPD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQqMXMPD"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c02782159so2943927f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 23:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792044919; x=1792649719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ar2lIaXGZYKNwi8B1Llnt5LR3QyG4oiCO9BSq6FLNgc=;
        b=rQqMXMPD+ndLFK7DAlWSIS3ZNoAKO4xigZr6Bcsh1bZh7MJ2vl/5ax6QV+n9ez56AQ
         NQv/A+mq2ci1ZpzJvGnQQChiHw2lJNMBN7H9CnHrJ4ghDI6he57GK55W4uzmTxi6lvo8
         HOHR6Nt5PmWwwzeR90qu17Q05pWWzJSWDNLYoxjE76OcfXZ5IQ06VP3tAsRbTp/9hfqs
         ktsUhxRgqbLM9DLEtks91U9BQw9qzHa2EqBiXCthAfjy4jQlyMaPCtG879elpPIN8vUj
         GHdKXEhK/V/CMpdaxHBaXgXrREQ4bUHgoY4fyeL3XAmeqMEuGuoEj/n4y0wV2i/ISKcd
         QEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792044919; x=1792649719;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ar2lIaXGZYKNwi8B1Llnt5LR3QyG4oiCO9BSq6FLNgc=;
        b=k3A8XhP18vXDViCnmWiFg06K3FE9S7fZlraqUClB1L7dNWyCtoj7JXAqo1DwQUw1qs
         Ul03zoWv+mtgHXWzlknQdRcznab/00wNmtr716dNKFtzY+ROA2QgMewTx332IuyMSVsC
         L8PruO0UiLfbXf7ERyFzUY6BTUNu1xy0/LVYuourxjFxWhJi5+3mfRBVDMrY7J8ERf2A
         dvshMjAKiSIv62ILEx4sz3H5ifvqW/zeM/Qz5E5jhuiO8Qgsrc6BlCcAsA4oUOGx6u/E
         1lxvDPb7bzMhY3fDGZX6pmROjX01PNnhM/IxMhfKV9WGrXs1dnBB9kgBCdTaWdXrNQSl
         0KmA==
X-Forwarded-Encrypted: i=1; AKwUvByHSIV5GLVbS+K7ppTvpiOBAKHVwPfozBpJWaaWXFI4i/0IKWexXbZanIzG6eZbm6XlKg7onMdK0kPDiUXL@vger.kernel.org
X-Gm-Message-State: AFq9FYJIdlHDNIB0DHxqG+YM/+bieJKhNg7+no6cRbiVgOyGy1+3MxaT
	B5HkcZk06LEgqYQb0o9wIJNtx0TkCz+JqZ/CG7tVqPyaHfA/3nnN8YIu
X-Gm-Gg: AYBFou2O7WM9XAFa1G6sK5lJQ2909bS456G7Aw2PY9gA7nxFH8CcomU5WtI/43/RFby
	36HjlY6mHNdu0JqeS0QBFPqkevd7FbWMIefm1baLtcjMNDMYoouqJW7fy/kagkR3WsNwSDj8l6g
	Oni1UVdGxp+DfLmCoY5qaQNT+AErjGN9tVKtSsonbeZmwVw8X7gntkzt+E3JyF+yr3mRPvKdbWx
	5a4/sCRPv1OujNacTnkEO3xQLOrlWZl5jM/PibzY8pwJ75vlN/o0dj5/tvFic099ibFnsGbvL1Z
	iduIzeZLxurn7s5CJtw93s+vYnRdeDbp938dhhtan0gW6SKKnbh9WyJAI36iNbqBxdQJ0lWcVxg
	k13DuC/98HBIIikymmPWlRRkmlpdu5X/ksL9vn4P/1uRAtxxchWvXyV3ljtGU1/8lUuUg0P9cXK
	L/6FMSeQNd3GptddSBFQgb8yJ1DuuqABOIK6DEq3OWgkLaQgPvGFOUVDLfwmGrnYAtsZLVodYpt
	2/lwI7vmcXxuFFiDlu3HBcqEoCUuw7UzLBfKp75zXVIZIaIJ1i6Q4x+O5Rb6xEBsfEu8/ITW04J
	F5qsKWxDZ4Usy95YPg6Qi7tkKphMhCaoZu00z5tPHGYDMJk3XRnyZ8Zr0h1ZBqlBrPxhQfFLtdI
	=
X-Received: by 2002:a5d:6f1c:0:b0:48d:f855:d1e0 with SMTP id ffacd0b85a97d-48df855d30emr211551f8f.57.1792044918908;
        Wed, 14 Oct 2026 23:15:18 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-aeb3-cd01-f139-812c-65df-b930.310.pool.telefonica.de. [2a02:3100:aeb3:cd01:f139:812c:65df:b930])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bd733fsm16578043f8f.58.2026.10.14.23.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:15:17 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:15:15 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Restore selective debug mask handling
Message-ID: <atBvT7c8ZF4szPae@gmail.com>
References: <20260905051738.11317-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905051738.11317-1-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 07:17:38AM +0100, Karl Mehltretter wrote:
> The netfs debug macros test only whether netfs_debug is nonzero.
> Consequently, selecting one debug point enables every entry, exit and
> general debug message.
> 
> Documentation/filesystems/caching/fscache.rst and the NETFS_DEBUG
> Kconfig help still describe /sys/module/netfs/parameters/debug as a
> bitmask of per-stream function entry, exit and general debugging
> points, and the fscache_*.c files still define FSCACHE_DEBUG_LEVEL,
> but nothing has decoded either since the mask handling was dropped
> when FS-Cache was folded into netfs.
> 
> Restore the per-level and per-point mask decoding.  Files that do not
> define FSCACHE_DEBUG_LEVEL, which includes the netfs core, fall under
> the cache management stream, the same default the FS-Cache macros had.
> 
> Fixes: 915cd30cdea8 ("netfs, fscache: Combine fscache with netfs")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

A friendly ping on this debug-mask fix.

Thanks,
Karl
