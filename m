Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3B37DABD;
	Thu,  4 Jun 2026 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780617186; cv=none; b=oVQgF9V8eG1eMUSdvVbh8p7dIhb/x5iwI9ODJjj/obPN/E5B5Ib9yClnanxhjnHZEHAZV6M6wtXpbMe5Mip7kBtvuhJN6jH/S/99VOaeGbAPBYGaLkH4/tQZqEtoTUG/kN78k4/76JKHctPB51BhKXhjML81vsy0FSbNOw5w4q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780617186; c=relaxed/simple;
	bh=lzUk6+IkfaUFIPrRan8VxzLSiBPqcDLHFnVGad3sYWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg7s5r5KDCW0adVG7MTjzzr8sNCuo6yFeOhrA0v5Y56J/glwjPaLGWF0/60PlxTBqgbfTOsirpKRkHqgRNSmNkabEc3CDioz79FMICeD2zECzmvt0CpHI6TuwN/DTkesI9zXmI8nOz777fxV+SbNcCfXBacdL5qeeeV+cSJG1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol74zvr/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol74zvr/"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E85021F00893;
	Thu,  4 Jun 2026 23:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780617185;
	bh=VHbgz0QwZN/zOLRIWgY5Oe6T4qPzxPNlSugj1GEgaQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ol74zvr/3DIXvqVSPCcl9xYrvFwX+dSDJgjnQICCP95K01pVNyUizrWbpAdyy8vI6
	 7ny/7xO93S88+FccVXPdTsX4pzcfBAreqQrBqVwAMO57Y4Qf3HJRw509R20y82NV/A
	 7WOK91i3yPvwbnC62P7DS3cpm2+OORX/IyqGwmfnX2GcKwdrrCRjeBEOibAptiQL4F
	 a7LcpvyCpa3Md+MRUVplA1M1J2xO4KBBVmlVfW95j3VJRWr3+c6F/T5dUPVnLHbTPl
	 NBFtlxhZLo6Fn0HGa2u0GiqGoCR6aG6Mfemp9NTJO0gwlWCGM+dteglVc857qI6jWY
	 yBgFQA/NrGWbg==
Date: Thu, 4 Jun 2026 16:53:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 7/9] fuse: invalidate ranges of backing devices being
 used for iomap
Message-ID: <20260604235304.GI6070@frogsfrogsfrogs>
References: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
 <177922946329.2439242.17189876954349215664.stgit@frogsfrogsfrogs>
 <CAJnrk1bvmZ0htacx8sqZ+aBVVS_x+7kap77SEctwwB_F6ttsSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bvmZ0htacx8sqZ+aBVVS_x+7kap77SEctwwB_F6ttsSw@mail.gmail.com>

On Fri, May 22, 2026 at 06:29:16PM -0700, Joanne Koong wrote:
> On Tue, May 19, 2026 at 3:32 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Make it easier to invalidate the page cache for a block device that is
> > being used in conjunction with iomap.  This allows a fuse server to kill
> > all cached data for a block that is being freed, so that block reuse
> > doesn't result in file corruption.  Right now, the only way to do this
> > is with fadvise, which ignores and doesn't wait for pages undergoing
> > writeback.
> 
> imo this would be cleaner going through the ioctl backing interface
> instead of through notifications.
> 
> I was thinking of something similar in idea for this for passthrough
> where you're able to dynamically update or invalidate a mapping
> corresponding to a backing id. It'd be great if we could both use the
> same uapi.

What do you mean by update a mapping?

FWIW the functionality here is a lot like POSIX_FADV_DONTNEED, except
that we actually want to wait for writeback and tear down all the folios
in the range because it's mandatory, not advisory.

(TBH it's more like what filesystems do to the pagecache prior to a
fallocate punch-hole operation).

> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_iomap.h      |    3 ++
> >  include/uapi/linux/fuse.h |   20 ++++++++++++++++
> >  fs/fuse/dev.c             |   28 +++++++++++++++++++++++
> >  fs/fuse/fuse_iomap.c      |   56 +++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 107 insertions(+)
> >
> >
> > diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
> > index c4b98123072a37..f40d202c64c822 100644
> > --- a/fs/fuse/fuse_iomap.h
> > +++ b/fs/fuse/fuse_iomap.h
> > @@ -67,6 +67,8 @@ int fuse_dev_ioctl_add_iomap(struct file *file);
> >  int fuse_dev_ioctl_iomap_support(struct file *file,
> >                                  struct fuse_iomap_support __user *argp);
> >  int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
> > +int fuse_iomap_backing_inval(struct fuse_conn *fc,
> > +                            const struct fuse_iomap_backing_inval_out *arg);
> >  #else
> >  # define fuse_iomap_enabled(...)               (false)
> >  # define fuse_has_iomap(...)                   (false)
> > @@ -94,6 +96,7 @@ int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
> >  # define fuse_dev_ioctl_add_iomap(...)         (-EOPNOTSUPP)
> >  # define fuse_dev_ioctl_iomap_support(...)     (-EOPNOTSUPP)
> >  # define fuse_dev_ioctl_iomap_set_nofs(...)    (-EOPNOTSUPP)
> > +# define fuse_iomap_backing_inval(...)         (-ENOSYS)
> >  #endif /* CONFIG_FUSE_IOMAP */
> >
> >  #endif /* _FS_FUSE_IOMAP_H */
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 0366101be3a321..899964f8d6616a 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -247,6 +247,7 @@
> >   *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
> >   *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
> >   *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
> > + *  - add FUSE_NOTIFY_IOMAP_BACKING_INVAL to invalidate iomap bdev ranges
> >   */
> >
> >  #ifndef _LINUX_FUSE_H
> > @@ -706,6 +707,8 @@ enum fuse_notify_code {
> >         FUSE_NOTIFY_RESEND = 7,
> >         FUSE_NOTIFY_INC_EPOCH = 8,
> >         FUSE_NOTIFY_PRUNE = 9,
> > +       FUSE_NOTIFY_IOMAP_BACKING_INVAL = 99,
> > +       FUSE_NOTIFY_CODE_MAX,
> 
> Could you explain why this is 99 and not just 10? Btw, I don't think

More of me just making it obvious where my development tree starts. :)

> we can define the max enum code like this in uapi, as I think that
> will break backwards compatibilty when upgrading to a new kernel if
> new opcodes get added in the future. I don't see this getting used
> anywhere in the series anyways though so maybe best to just delete it?

Yeah, Miklos already said up-thread to remove the _MAX constants from
the UABI.

--D

> Thanks,
> Joanne
> 
