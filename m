Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC26B67A;
	Fri,  6 Feb 2026 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770380356; cv=none; b=Glsg2E5BVi2uLIi9XXrEWDgznOCmNXYIRO+Md+7vesJocovRARm67tZyBHI9BCdSlKT64hxq2JheGvdN1M0eVRe82FP4EwCjkO3u35pU3HRkjt7ulyiSqUpSm4buRu7Ajg+2bGTJQY9g+RNjtAnOMaVMxeavM4DOJePa5Z5cWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770380356; c=relaxed/simple;
	bh=Poc5cAnYUIssufkI0ij0bqMKpaXqwWa/aHj6tRakBiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BI895YzjYekaC6I5mi1FoHIdQB8BcZp0TDcKxaEFbORsoGuhgfLgO8XFFaMnXvllPNdkMW6bMQ692IsSuM1b4eOi9G15XNWg9VYUSu/77MU3TrbnL5GPQyhuxdQpp2EK+crvlaLoUFcm8x6sC9/t6g/1Mtuu407zaQ88ow8hiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAEiQIgE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAEiQIgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AA8C116C6;
	Fri,  6 Feb 2026 12:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770380356;
	bh=Poc5cAnYUIssufkI0ij0bqMKpaXqwWa/aHj6tRakBiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lAEiQIgEKz5XInQTQn6inDrZzts40QRkprLw2DAfLkwbudlzI02xrutJ8+XupPpOZ
	 bhyBxgXCwqYPrb2IKxC7KyWP7pvkqNhFsgl/Ybej707GvENG+wD5zVWLqWmww9fP4Q
	 W5OzlQgbcLYhaCHYG4ny2M5uIAu53PP312NLPVrYFsPavncSl4VMG0hPOjFMaCaiWR
	 Jy/ArY/z62+1h+4T6oBWlFhZNkRePjveQxV0SKq42L6IN4e2wT1EVqiy/HbUth5YOz
	 W1fA0zxt+BEhvIvSfXhu9riuFEaDJvxYsmEBV3sKSlQuiE+HvCb7n01vEGQfOXkaml
	 6AmptaKtKz29A==
Date: Fri, 6 Feb 2026 13:19:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20260206-euter-weilen-610fef8cb79a@brauner>
References: <aXilaLSzB1xsGWCb@sirena.org.uk>
 <f9afaed3-9db5-4725-a0e5-cb6d6873b3c6@sirena.org.uk>
 <ef58e561-b366-4eb8-bad6-9d0e748f49c1@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef58e561-b366-4eb8-bad6-9d0e748f49c1@sirena.org.uk>

On Wed, Feb 04, 2026 at 02:31:06PM +0000, Mark Brown wrote:
> On Mon, Feb 02, 2026 at 02:58:35PM +0000, Mark Brown wrote:
> > On Tue, Jan 27, 2026 at 11:45:44AM +0000, Mark Brown wrote:
> > > Hi all,
> > > 
> > > After merging the vfs-brauner tree, today's linux-next build
> > > (arm64 kselftest) failed like this:
> > 
> > This issue is still present in today's -next.
> 
> This means that vfs-brauner is still held at the version from
> next-20260126 and none of the below commits have been in -next:

This should've been fixed. Not sure what happened.
I've reassembled vfs.all completely just to be sure.

> 
> Amir Goldstein (4):
>       fs: add helpers name_is_dot{,dot,_dotdot}
>       ovl: use name_is_dot* helpers in readdir code
>       exportfs: clarify the documentation of open()/permission() expotrfs ops
>       nfsd: do not allow exporting of special kernel filesystems
> 
> Andrey Albershteyn (3):
>       fs: reset read-only fsflags together with xflags
>       fs: add FS_XFLAG_VERITY for fs-verity files
>       fsverity: add tracepoints
> 
> Chelsy Ratnawat (1):
>       fs: dcache: fix typo in enum d_walk_ret comment
> 
> Christian Brauner (6):
>       mount: start iterating from start of rbtree
>       mount: simplify __do_loopback()
>       mount: add FSMOUNT_NAMESPACE
>       tools: update mount.h header
>       selftests/statmount: add statmount_alloc() helper
>       selftests: add FSMOUNT_NAMESPACE tests
> 
> Joanne Koong (1):
>       iomap: fix invalid folio access after folio_end_read()
> 
> Qiliang Yuan (1):
>       fs/file: optimize close_range() complexity from O(N) to O(Sparse)
> 
> Qing Wang (1):
>       ovl: Fix uninit-value in ovl_fill_real
> 
> Tamir Duberstein (1):
>       rust: seq_file: replace `kernel::c_str!` with C-Strings
> 


