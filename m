Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899342BE93;
	Thu, 10 Sep 2026 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074783; cv=none; b=tliHhTz+jbqKnjB0zqj1Ar7imFPE6xemazxGrZyAIo6VFisWi2ZcuqSEtUgZDpCLhdP3+l716Gho61jo9NEE7FZCF6nSHlpOVcsh7mXA6c6P4MuGZ1nACNnglmYitWsP13ZfJzf2dus4VH/jCFn3k01/7MmF6CbnQWx/nCAKJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074783; c=relaxed/simple;
	bh=M4R51QJHSVzLhvMmYIw9JYQUR2WnA+AVCLVgLderYWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYfoDaW+uee3ky0U46pvnLikNOVnAuWCzB2otyCJeSCzy4wP8N6+PqwY15u4pgY8yhovh41gzltS0rtAxk+tqDUbzeaItMC72vsjf+36/vLF7ryAtwdUXvlusqeCMTWVxEFswnoxMcyc/xTFOcSxfYy2tWQez8BO8AZ5are6f/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asy2wNCb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asy2wNCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9807D1F000FF;
	Thu, 10 Sep 2026 21:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789074767;
	bh=d+F7Y18Aq9h3IhViRhUjDDNa4C0U1zuwFZQNWmGjtO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=asy2wNCb2Fi54YBoM1lPrKGRaHi9dHqnZmkhFcK3rmWKtsXV5YEHXI7K3R4zp/2VB
	 dw4khYJFPtbGz4Jvmp0ui0o9l9tuUQ9iviyaw+z4KFTH5RNeg9TsbbVrJ/yCnaNoDo
	 P2Yjn/mnPDnyYIWHjhZrHD/+SH6Kd6rsOUN4Y9AZdr69eymmAiDJ3KfzMhF/U1OacH
	 EK8oA/GyuNDlKO0YxRHGsZVrtOsg33wjwwqdZAjcRJ4632+Hs2Oh0Rjvi4c1ivM53m
	 S5Bo0Isw0hDidRLLPi+tOfDDjAjqvv6DRPyNMbhqw0GAI/NOYOErLnCjVT5e3lGfBB
	 zr+6vTlSr141w==
Date: Thu, 10 Sep 2026 11:12:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <christian@brauner.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: allocate the open node outside the open file
 mutex
Message-ID: <aqMdToJ99NeqC1zj@slm.duckdns.org>
References: <20260910045433.489413-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910045433.489413-1-shakeel.butt@linux.dev>

On Wed, Sep 09, 2026 at 09:54:33PM -0700, Shakeel Butt wrote:
> kernfs_get_open_node() allocates the kernfs_open_node while holding one
> of the hashed kernfs_open_file mutexes, so opening a file nobody has open
> yet can enter reclaim with that mutex held.  The mutex is shared by every
> node that hashes to it, so unrelated opens, closes and xattr updates in
> the same bucket wait.
> 
> It is the most contended lock in kernfs on our fleet: 2.19M waiters over
> 29 days, more than two hundred times the waiters on kernfs_rwsem, and the
> highest median hold of any kernfs lock at 77ms.  Most of it is monitoring
> daemons opening cgroup control files, and the open node is freed once the
> last descriptor closes, so an open-read-close loop allocates every time.
> 
> Look at kn->attr.open before taking the mutex, and allocate then if
> nothing has the file open.  Should the peek be wrong, which needs the
> last descriptor to close inside the window, fall back to allocating under
> the mutex as before.
> 
> Eight tasks opening and closing four cgroup files 20000 times each, with
> lock_stat on the hashed mutex:
> 
>                      contentions    hold total    hold avg
>    before                    198        4.19 s     8.67 us
>    after                     119        2.31 s     4.78 us
> 
> and the same number of acquisitions either way.
> 
> This does not empty the bucket.  kernfs_fop_release() and
> kernfs_xattr_set() still sleep under the same mutex.  It stops opens
> doing it.
> 
> Assisted-by: LLM
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
