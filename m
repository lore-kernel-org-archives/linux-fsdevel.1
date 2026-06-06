Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC8878F39;
	Sat,  6 Jun 2026 04:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780719480; cv=none; b=qlyX2GOeFxzMgU3lW/YdMhajsb2h9IMuYEGF4OoAWrtXdumz9A2jcuO1T6L2+UB/gVj0l+zabT9Qj+n9IaJzdrlWpfV4XrYmLE7nEPE5xuPAkBLoW/wssGlZnmoEFKJKRkI1buEmDt5e6UsMLzTOsL+V/vb7lahNvN4vztGM1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780719480; c=relaxed/simple;
	bh=XDLGXsCF2qkos5D4rVI5/mAGTKp9El+MAmY1Ldecn9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf0DK8XliHfycuWze4PwauiszNYtOuw3df0aglUHesNqoWCFebZy0UIc4YPpBtNtnX4PoH1xkS2tGNfXtN2ZtpzoLGh7EgS/7icH2cIFvwaECnWj+nUukw4a9GxOCi6oX5oR7R/j/tOWYjXWNK75T+CodMePfvW2O59mjjxP5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1HJoEPB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1HJoEPB"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5630C1F00893;
	Sat,  6 Jun 2026 04:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780719479;
	bh=kjUNKYpq5pjXLHnVC3ZiQ8Fa37UTFYL+RiCkut7PVYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y1HJoEPBpbUwCAV6+RrWqcoJda1TX0xm0y4FXfNTNyh0bEitF/HRhDz0p+iV72TWN
	 aFPOi5txqrjE700HRJItDvcl7Wjklj4D/M5ZJjJGl+G0jSUtgyxduR6jkrxVZPRKJu
	 Zph8vsWittgRkGGAdGeiUPqlTp9lmmX8XbeL6APtOIfCUwFXsfnKTmtM4f856nH2i+
	 xZHy9dXdrtpxdcaynCzp/2iCRzLDct3LvN9aPkWZHNMx0tZnkXy/IsET9By0tL2sLF
	 PkXcd585XGI5eu2yogPDHeAnzK1f0vPalB9xd1OWdFv9oCNOBd5E4PDZ+h07/imDZC
	 3oynQoy5X5OEw==
Date: Fri, 5 Jun 2026 21:17:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 9/9] fuse: set iomap backing device block size
Message-ID: <20260606041758.GH6095@frogsfrogsfrogs>
References: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
 <177922946372.2439242.13829037107289830266.stgit@frogsfrogsfrogs>
 <CAJnrk1ZQbvCL=ok4WHBn0gC+=k88Cejts_-_DP3epa51Wz5+5g@mail.gmail.com>
 <20260605000134.GJ6070@frogsfrogsfrogs>
 <CAJnrk1Zig5+97Qs3JiaSgLE1KJMn-mgXSFUcxM9-kv6xvpfBHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Zig5+97Qs3JiaSgLE1KJMn-mgXSFUcxM9-kv6xvpfBHA@mail.gmail.com>

On Fri, Jun 05, 2026 at 10:41:48AM -0700, Joanne Koong wrote:
> On Thu, Jun 4, 2026 at 5:01 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Fri, May 22, 2026 at 06:06:15PM -0700, Joanne Koong wrote:
> > > On Tue, May 19, 2026 at 3:33 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > >
> > > > Add a new ioctl so that an unprivileged fuse server can set the block
> > > > size of a bdev that's opened for iomap usage.
> > >
> > > If I'm understanding it correctly, doesn't the fs/iomap layer align
> > > all i/o to the fuse file inode->i_blkbits and submits bios to the
> > > underlying iomap->bdev without ever reading the bdev's
> > > inode->i_blkbits? Why do we need this fuse ioctl then for setting the
> > > block size of a bdev?
> >
> > It's not for the regular file IO, it's for the blockdev pagecache that
> > sits in front of filesystem metadata IO.  Block devices do writeback of
> > their pagecache in units of buffer heads, which is a problem if the
> > buffer head size is not aligned to the fsblock size.
> >
> > Basically, imagine a 1k-fsblock filesystem with 4k pages.  Let us
> > further assume that block 0 is a superblock, and block 1 is the only
> > file data in the whole filesystem.
> >
> > If the BLKBSZGET size is also 4k, then dirtying the superblock now means
> > that the bdev pagecache will think that the whole 4k is dirty, because
> > there's only one bh for the whole 4k.
> >
> > Now let's say iomap writes to the sole file data block.  The ondisk data
> > is newer than the bdev pagecache.  Next, the fuse server initiates
> > writeout of the dirty bdev pagecache.  It writes the whole page out to
> > disk, which means the ondisk super is newest, but the file data block
> > has just been clobbered by stale bdev pagecache!
> >
> > Ouch.
> >
> > So if we can set the bh size to 1k, we avoid the clobbering.
> 
> Thanks for the explanation.
> 
> From what I remember, fuseblk servers can pass in a size at mount time
> for what the kernel should use for filesystem inode i_blkbits size.
> imo it seems like the responsibility of the fuse server to make sure
> to pass in a value that matches the buffer head size of the block
> device it's using, or does this not suffice for what you need?

Correct, but fuseblk only works with a single block device, whereas you
can open multiple block devices, register them as iomap backing files,
and use all of them with files.  You might have sufficient privilege to
open the bdev O_EXCL, but not necessarily CAP_SYS_ADMIN to change the
blocksize.

--D

> Thanks,
> Joanne
> 
> >
> > > It seems like this ioctl is re-implementing the BLKBSZSET ioctl but
> > > bypasses the cap sys admin privilege checking that the BLKBSZSET ioctl
> > > requires, which seems like a security violation. Am I understanding
> > > this correctly?
> >
> > It is, but the assumption was that you'd only get fuse-iomap if you
> > already had CAP_SYS_RAWIO, so you have to have some privilege.  But I
> > concede that RAWIO != ADMIN.  This might be unnecessary now that fuse
> > service containers can ask the mount helper to open a bdev in O_EXCL
> > mode and set a particular blocksize.
> >
> > Though note the weird thing -- a sysadmin can use chmod to let
> > unprivileged userspace to open a bdev and it can open it O_EXCL, but it
> > can't set the block size unless they have CAP_SYS_ADMIN.
> >
> > --D
> >
