Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF653C13EE;
	Fri, 29 May 2026 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050218; cv=none; b=urmlrDhmujkRinMHjOAaPdIX26Zv/JzpUeR3fDi+p/6zIyMVvYJUbaASFPcXjmKO8TwVUQwoReunTSQkDeN9/hq/4vNQwdwvQNLsuqzNHB2r0scl/yxxAnpSZxLgA2pyoHc4I96+JhBRKGnQa29eeK7PwDC3f+S6JWSmfbMiPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050218; c=relaxed/simple;
	bh=F6+VZnu0iBmyrsgrd3JF4aCIpKKe07AeqPvqPXZp3uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlxM8J0QRcqPSuGS0OG2ihGq0cag+BtGyYx8T019XnR/AHChpLWQBVJ8jasOUtRrDrGJidDS42jSLUvE8oT8arXM98lBErD1ytljRdIKguDiBCOSdYkLVR6k6ZykWkHbkPC0eZJqtIry455Np/UTjOTqD/wp25PbDXA6ABbos8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrF44h/U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrF44h/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9691F00899;
	Fri, 29 May 2026 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780050217;
	bh=DVR+PRvexVhn/AQ4dOK1V6K3n7bptmZUVzht4dn7aVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lrF44h/Uv3YyOcZOAEtk9R1e7QkXnnBEPx73MfqusEXY1ZTMoAEKQ+gsYpMeYUn+B
	 hSQPNkYmf97XF+j/K6Hlf//iNt7Y3hVD15kDXxkSBR4EJT0Hl45/L/c//h6cjg1Abg
	 IgQhy+GXa68NbujXBusKgQI8oSxDTHuw6ww56bjsXZgW0av1Zq39g4RNbK0m8M6VZ+
	 jRL5dwWN+MBDT9cdr/2hp0jAF+N9lyT8fQVSk5EfNoNy90YGnwEyMLYrCLJM/6kVYz
	 MiDUZZ9XbFCSgFV5Wlkdt3oYOzGyd6Kb5vV9jXF1W4rV9BFYPqMPNpKrBoFwulPmoT
	 iPrIXkOWXXbBg==
Date: Fri, 29 May 2026 12:23:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] fs/namespace: notify pollers of legacy propagation
 changes
Message-ID: <20260529-herzbrechend-kondor-zahnersatz-3152709a3b47@brauner>
References: <20260529095441.1744006-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529095441.1744006-1-guopeng.zhang@linux.dev>

On Fri, May 29, 2026 at 05:54:41PM +0800, Guopeng Zhang wrote:
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> Changing mount propagation through the legacy mount API changes
> user-visible mountinfo contents, including the shared: and master:
> optional fields.
> 
> The mount_setattr() path already touches the mount namespace after
> change_mnt_propagation(), so pollers of /proc/<pid>/mountinfo are woken
> when the namespace event changes.
> 
> The legacy mount --make-* path also changes propagation through
> change_mnt_propagation(), and MOVE_MOUNT_SET_GROUP updates the
> propagation relationship of the target mount. Both paths currently
> return without touching the affected mount namespace.
> 
> As a result, userspace polling /proc/<pid>/mountinfo can miss these
> propagation-only changes even though mountinfo has changed.
> 
> A simple reproducer that polls /proc/self/mountinfo while changing
> propagation shows the inconsistency.
> 
> Before this change:
> 
>   legacy MS_SHARED: poll ret=0 revents=0x0
>   mount_setattr MS_SHARED: poll ret=1 revents=0xa
> 
> After this change:
> 
>   legacy MS_SHARED: poll ret=1 revents=0xa
>   mount_setattr MS_SHARED: poll ret=1 revents=0xa
> 
> Touch the affected mount namespace after successfully changing
> propagation state in do_change_type() and do_set_group(). Take the
> vfsmount lock for write around touch_mnt_namespace(), as required by
> its locking rules.
> 
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>  fs/namespace.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 9a66a806a9b8..f871c7bf3bc8 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2908,6 +2908,10 @@ static int do_change_type(const struct path *path, int ms_flags)
>  	for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
>  		change_mnt_propagation(m, type);
>  
> +	lock_mount_hash();
> +	touch_mnt_namespace(mnt->mnt_ns);
> +	unlock_mount_hash();
> +
>  	return 0;
>  }
>  
> @@ -3479,6 +3483,11 @@ static int do_set_group(const struct path *from_path, const struct path *to_path
>  		list_add(&to->mnt_share, &from->mnt_share);
>  		set_mnt_shared(to);
>  	}
> +
> +	lock_mount_hash();
> +	touch_mnt_namespace(to->mnt_ns);
> +	unlock_mount_hash();

Doing this would cause seqcount readers to retry on mount propagation
changes when all of them really only care about mount topology changes.
So this can likely use:

guard(mount_locked_reader)();
touch_mnt_namespace(mnt_ns);

Even today, observing an unchanged seqcount across mnt->mnt_flags reads
doesn't guarantee that it really wasn't changed.
