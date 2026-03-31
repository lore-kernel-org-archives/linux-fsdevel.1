Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E053D811D;
	Tue, 31 Mar 2026 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956719; cv=none; b=NjFDvcBLh/DokZx4hRY+fRe03nhnqJtSzhy0aV7YS/MPQICA7GJJtH/YpgHpzzvYB8W8xwzpQS8Z2SkiJmijGZBRTH1/SlTdoF09O040Gg4nBLfj+lopgS95kji8A5n+7Vy9pq+mVfgI8al8BRFoEytV9Osiam3tuqRCnXL714g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956719; c=relaxed/simple;
	bh=Nc8yfoyrbv/2oVgQICx1c/p3lzHyTL4xrRglEk07WKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBQPS/mDZ2hmyfqy2ZJCustl3SLhmMlnDWu2SrVc7sj3Xd7eDLDJAxtwGOD2vtqPqwnmB4Juik5zWLkZjBE8QH8MhdYriF0oubFjeoRULZd7likL/zsot1PcKKxuSn4dHV/tyI6ZiQFMKSiniA6nHKJiesaVKBJ7/JE8tAlzXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQ3Tocmg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQ3Tocmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B5AC2BC9E;
	Tue, 31 Mar 2026 11:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774956719;
	bh=Nc8yfoyrbv/2oVgQICx1c/p3lzHyTL4xrRglEk07WKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQ3Tocmgq2Qw3+VLZSqPQlVBUBgH6MIahNCF2fjzKHUXK+kiy18oyB87KSq3oWF7I
	 QICQ6K318CNHabP5yWoezein9etSOUV7kvgB9wSxPrXW4nd7vRWKpvzjX5bEr4KW53
	 Rgw8nHcI79g117jTGSJxT70jr+v3WKmHgtSWbcZrXvKZmTJJ8O/xuzMF1ToKcOnBxj
	 y66Mxgoj/d+FegCfnjnplEGNHLKSYcVkg66gyl7fMvuDxHmdeEBivglxQ8hCZIwoF+
	 H7v33qR/2+Ralo5L7pCDXKSBeONdCIJkORqLLKWpRwLjBNdRtXddNbxDJkRycpoos5
	 YWuGkNSKxU4mQ==
Date: Tue, 31 Mar 2026 13:31:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] assorted ->i_count changes + extension of
 lockless handling
Message-ID: <20260331-knebel-stilmittel-e384aae1d046@brauner>
References: <20260329172002.3557801-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260329172002.3557801-1-mjguzik@gmail.com>

On Sun, Mar 29, 2026 at 07:19:55PM +0200, Mateusz Guzik wrote:
> The stock kernel support partial lockless in handling in that iput() can
> decrement any value > 1. Any ref acquire however requires the spinlock.
> 
> With this patchset ref acquires when the value was already at least 1
> also become lockless. That is, only transitions 0->1 and 1->0 take the
> lock.
> 
> I verified when nfs calls into the hash taking the lock is typically
> avoided. Similarly, btrfs likes to igrab() and avoids the lock.
> However, I have to fully admit I did not perform any benchmarks. While
> cleaning stuff up I noticed lockless operation is almost readily
> available so I went for it.
> 
> Clean-up wise, the icount_read_once() stuff lines up with inode_state_read_once().
> The prefix is different but I opted to not change it due to igrab(), ihold() et al.
> 
> There is a future-proofing change in iput_final(). I am not going to
> strongly insist on it, but at the very least the problem needs to be
> noted in a comment.

Seems overall good to me aside from the bdev_file_open_by_dev() splat
ofc.
