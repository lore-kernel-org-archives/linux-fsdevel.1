Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22181862
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289261; cv=none; b=U7ARbOaVt6x/lXGV3pCIeFcp1exci/fwTJWl40bABpVDUAdUzWoZIlPAY+nHQ/MBGY3rrZGIVYf/6XHMoXPpEdfWn5kE57wOwrPq3AUOqZ5/KQMUzSZOW9wvONudDE6cSPhhMKaD7TVjbm2GMkeNBNCeDppC3CyDU+z0bYE4+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289261; c=relaxed/simple;
	bh=dKWfOrNOdooXVUFriZLoo1epZ2snEFkUhlnT78QsUhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwvjvrfzR98AMuj+TNX3wjAFxWrqyIb2oTYwqEBcIWa3GdJzMszuAIQq/Ubxiul59D1ZXPT6ivYmgZt4ay7H0+OvbdUuk3gPLSzFDr6EAoHWSoKWmHXeRJfUJBaXSnCK92TrhejLZyBQZrHJMH2+0BVfcV9u4tm0HOcwqIhxGQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bvyay/4z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bvyay/4z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4263A1F000E9;
	Wed, 29 Jul 2026 01:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785289259;
	bh=vSxpuTUnCBd3tEjZ9vGZIvSxtQcrtVHhUia2u95b0SQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bvyay/4zv6y0+LYaxUeZIzdEn5Tte9w49t0pPpP2+ev2yNY+MPRYbuRvzLj57O6kS
	 Z4CU/jfd+s1y35xAsVb6XcICTT2Lqo5B1zOIMEVIUOp7WEQOS/lsqHqxplfL3Jj2Yo
	 JUYwYiH5VV7JTSMa66C+S1IezhQIa3q3TsueIPjWVzxxlLPQRt74vjV/2s98dh6N7w
	 Pg4u87+EYfFjYV6WlkFeWdEY3qAgFnTkcoObFUTocn9urTmk+mvBkZuGvdej8xJjIJ
	 qfk+NHHQTwy/k5EAqAr7L+9dRPduHFibcIfsxi7/zkuj5vUPorIv+mBYjXutiCfdVo
	 xDJKH7L3vy7cw==
Date: Wed, 29 Jul 2026 09:40:50 +0800
From: Gao Xiang <xiang@kernel.org>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, cyphar@cyphar.com,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5] erofs: accept source file descriptor via fsconfig
Message-ID: <amlaIt8jjy_mSK-j@XiangdeMacBook-Pro.local>
Mail-Followup-To: Giuseppe Scrivano <gscrivan@redhat.com>,
	linux-erofs@lists.ozlabs.org, cyphar@cyphar.com,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20260728160619.853924-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728160619.853924-1-gscrivan@redhat.com>

On Tue, Jul 28, 2026 at 06:05:32PM +0200, Giuseppe Scrivano wrote:
> Allow userspace to pass an already-opened file descriptor as the mount
> source instead of a path string.  This is useful for tools that already
> hold an fd to the image, such as composefs reusing an existing erofs
> backing file.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
> v4: https://lore.kernel.org/linux-fsdevel/20260717134147.1602735-1-gscrivan@redhat.com/
> v3: https://lore.kernel.org/linux-fsdevel/20260714154917.489993-1-gscrivan@redhat.com/
> v2: https://lore.kernel.org/linux-fsdevel/20260711071137.4130824-1-gscrivan@redhat.com/
> v1: https://lore.kernel.org/linux-fsdevel/ak5GfvVfWLJU1EwK@debian/
> 
>  Documentation/filesystems/erofs.rst | 15 ++++++
>  fs/erofs/super.c                    | 73 ++++++++++++++++++++++++-----
>  2 files changed, 77 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 4230884fb359..774e8b236d09 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -139,6 +139,21 @@ inode_share            Enable inode page sharing for this filesystem.  Inodes wi
>                         page cache.
>  ===================    =========================================================
>  
> +File-backed mounts
> +==================
> +
> +When CONFIG_EROFS_FS_BACKED_BY_FILE is enabled, EROFS file-backed images
> +can be mounted directly without a loopback block device.  The backing file
> +can be given either as a path, or as an already-opened file descriptor.
> +
> +When a file descriptor is used, the kernel resolves its path and records it
> +so that /proc/mounts and similar interfaces can still report the mount
> +source.
> +
> +Only regular files are accepted as backing files; to mount an image that
> +resides on a block device, use the traditional block device mount path
> +instead.

Reviewed-by: Gao Xiang <xiang@kernel.org>

Hi Christian, Jan, could you ack this (`fc->source` filling when
`source_fd` is used) if possible? I wish this behavior can be
consistent even vfs source_fd is implemented later.

Thanks,
Gao Xiang
