Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA54AE13B;
	Wed, 16 Sep 2026 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596621; cv=none; b=fx/VGG9hllsZqYMSSyEV7+4TV5HoB4hb5qsOUJ3hGSkLhSeJefZvli42SYR1jeRo4zrlNil6akuV0t1XuxlHWQr25suv6Y1y2BGil9H87pIKtKnN2fVQ9Am44q192kLwLDOd5d1H2bHLsO0+4yuGeA5Z0Yx8nAsN+yn4GRNm76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596621; c=relaxed/simple;
	bh=ZF7qJpLjZXlL1BaXyAYTPW9nCc5yupN4XJieSt8yAbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOHg5E11wl2xbeHeQPAh/rWEJnQV4svMTpi1g4kFBxmvZ9MN9hED8k2p1xhE2QrYun/G9UwQL9TaofMZQYbsDnTtDeu+vyzRNhT7dTRmAOiPANmLbYshQmE90+DaN78xaT6twL0n5SsHKFo+/fL+/ORgxiIFxhhFOxYeBYd00AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhawZNoB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhawZNoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DC31F000FF;
	Wed, 16 Sep 2026 22:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789596614;
	bh=woRF4U7BLisY6PTyIk1Ijf+XxzogYfb21SXAKp3A0dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VhawZNoB5UJHRilP1LPvfF5h0tTPz+8hESGYkVJCxAOesduiF/LJzfWdU3OnHeFNb
	 THRUJTnD4lFjt0mpkkegHFhLgu6kni9ewoB76ysHNbbjKDtZ0Z6E6DZMywGVWUIYAv
	 RBgxvoTCu3ayVwIBsDF9Cn0DAEaVphWiINL+tNSzTix43KR2gFDXe+eyXgRGAyYXAO
	 bbFaOMVmFPgGbkQCxUq7O7ImfLXEKYzS9ZP6bNrzq2CckMsE1HNqOQpgyuMz6Q4+lR
	 IRdalDVp6/HXW206F0NP31qqZOR/HBCG+iYDvsHb3iotj8X34pSHgcHNncfpiFHsko
	 lmmTYVbPTWUJQ==
Date: Thu, 17 Sep 2026 00:10:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Chris Mason <mason@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 1/6] coredump: don't switch a dumper that has no files
 table
Message-ID: <20260917-staunen-sparsam-infusion-83238c68d21f@brauner>
References: <20260915-work-coredump-fixes-v1-1-f354ca41780c@kernel.org>
 <20260916194837.3732307-1-mason@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916194837.3732307-1-mason@kernel.org>

> When I reproduced this one, it ended up deadlocking with the fix applied.
> 
> vhost worker (the dumper)          sibling thread
> =========================          ==============
> get_signal() -> vfs_coredump()
>   coredump_close_files()
>     hands sibling a new table ---> switch_files_struct()
>     coredump_wait_inactive()         put_files_struct(old table)
>       waits for sibling's switch       last close of the vhost fd
>                                      vhost_net_release()
>                                        __vhost_worker_flush(): waits
> 
> AI suggests making the vhost thread requeue the signal for someone more
> suitable?

Afaict, this is conceptually a generic problem with letting coredump
close files for any type of user worker where the worker is the dumper
and the sibling thread closes the fd that causes it to be stopped and
waits for it to exit. So this needs thinking and we should drop coredump
closing files for now.
