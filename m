Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974F43CE50;
	Wed, 16 Sep 2026 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588136; cv=none; b=bx8hvWZOCiWGhrnLOA+KvzY0PZ4cJKjR6NZr6oxBzgLkllTzLlyTxPnTzMM89g4WZIcE2NbsTj1gtRUbaJXHeB/5MYAWWg+8F2N8x09SUCeC04xCaJ0hLWAccL8ziumOrmUCoX8tT+E2iNQA5npG3uwxIkFzwamWSGr1Ni7UY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588136; c=relaxed/simple;
	bh=iWMv/ShJ2WITtNizhzSZ+KDY0NmyFTI3bONWWzbIksw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1gGKvFOHrxVtffVREWZ0srlk8gg1xIOVTVaclpiYCyb7Pw6d1xtxGzeqgvkG1znrUmFxz+0RaVawYKWA6ET39qi2kPt2anD6cWk9oxGmayf0x9wPuXLy74EwRb4eALi+ENab57DWqZmomONqsJpFOR++KpqVyxZuk72/hmmFQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+TcsGVv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+TcsGVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F031F000FF;
	Wed, 16 Sep 2026 19:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789588121;
	bh=7lUJSxEgNohuUAfwQ6ykoq54FcKmmAc0TQEIhkx3s6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G+TcsGVvyTZUrzt4jNFU/fFzltaz3jcKlTCvOTDtO4Ct3FmuHHvRDBXQMWItqnbFA
	 9/1/aI+IQhhfYqtkR2wldq2H3fRmzhNPxNT+euOaJBpOU41PBbax6N5ErcxGjTMVAW
	 gESrX+MtDRgAU/lSLfx/LWR8/yoBWWLx60/Tz0D3A+yryguIXeS0gkX/C2leh7eAlJ
	 O09RuJaQ3K2i+o4TYwM73wlm4sAnr9sX12wQDYe2pWH6mmcqy/w6vOIdpXjFretJev
	 cQjdcTDwGpn4LgRbdXviWzGuU3yd+Q96Laz8dceamz1pv1/PhB8FxVrLIiI4UsPLf3
	 VQfpe33Q9cQ7A==
From: Chris Mason <mason@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Chris Mason <mason@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-mm@kvack.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH 1/6] coredump: don't switch a dumper that has no files table
Date: Wed, 16 Sep 2026 19:48:34 +0000
Message-ID: <20260916194837.3732307-1-mason@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260915-work-coredump-fixes-v1-1-f354ca41780c@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 12:22:16 +0200 Christian Brauner <brauner@kernel.org> wrote:

> Tasks without an fdtable are skipped in coredump_close_files(). The
> coredump client itself doesn't use the same check. Since
> put_files_struct() doesn't tolerate NULL it will oops for such tasks
> without an fdtable. The prime suspect for this behavior are vhost
> workers. Skip the switch for a coredump client without a table.
>
> Fixes: b2b36bcb13ea ("coredump: add COREDUMP_CLOSE_FILES")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/coredump.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 1fba3fed1a07..791a9268ed96 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -579,7 +579,11 @@ static bool coredump_close_files(struct core_state *core_state)
>  	/* Use the dumper's real creds not the overridden ones. */
>  	scoped_with_creds(current_real_cred()) {
>  		io_uring_task_cancel();
> -		switch_files_struct(current, files);
> +		/* The dumper itself may be a vhost worker without a table. */
> +		if (current->files)
> +			switch_files_struct(current, files);
> +		else
> +			put_files_struct(files);
>  	}
>
>  	coredump_wait_inactive(core_state);

When I reproduced this one, it ended up deadlocking with the fix applied.

vhost worker (the dumper)          sibling thread
=========================          ==============
get_signal() -> vfs_coredump()
  coredump_close_files()
    hands sibling a new table ---> switch_files_struct()
    coredump_wait_inactive()         put_files_struct(old table)
      waits for sibling's switch       last close of the vhost fd
                                     vhost_net_release()
                                       __vhost_worker_flush(): waits

AI suggests making the vhost thread requeue the signal for someone more
suitable?

-chris
