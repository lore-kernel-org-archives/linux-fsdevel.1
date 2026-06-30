Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CBE18871F;
	Tue, 30 Jun 2026 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822783; cv=none; b=Pxf3WLh1MJNA7hu7JydS60zLv0vbSQInjTZwBKSdsZJrY4bIhLb/TVM+SgCiOo+m2vAbqAsw1MjuJk6V5ITTQff6pUJTO+W00hfvpdjSnakQjbPaizd85GTHvaC5DdJzCubxKaE5bFm4/lpWMjq66dSTh6ir275h3LOEN/HXN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822783; c=relaxed/simple;
	bh=ltKDMmanMQBf+BZSMZLfcwwIQAsADTnBGEV0gsqp/cA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Xg1+b8eReVJafmSJtPyMBFW1U29TTiKUl2NZA8OinCYJYQQ1LPaN901xJuqsbh85s15XqGVGptEDQ2augzk0TYQgeIy+HvUhs3vWXMGoBsMxyifu4rDDBZW2Fzal1bnhvQ3rac2dDFtZSqNYQjz2/StVMo6Sl4n9bmydfcGffWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo+MNLNl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo+MNLNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99AA1F000E9;
	Tue, 30 Jun 2026 12:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782822782;
	bh=AZZ7fZ3UOcfzxAyRTCMWpVsYmwgIiI7s1BMxwVH9tfA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Qo+MNLNlO0MYRhbXKY36Uo8ZJjJOgNpUDOONZs2+EuzMzQRf+qTwaFkkZSAMVVYos
	 AIkuMlbwMOeBBLnTegEJU11V2pI4HAEy7/L4I0vC1s8SAFhoWr7JAQaqTzwRMJYSgE
	 eH5svw9HKZ/K/Tc0gT/8Eml1+D6a19w2qjQ+PomadUkqQr0eyXts7VG90l0GQ6ZPwf
	 lw+JUdHQpI9l68lDSObRcagIvWGhavCNeDxUi1t/5vUiWPpDTU8s9dk+iSft9ctqDV
	 upgb4iFI7HlnouTgVZP2ClhkHXoec2TxHh9muF4jYppzeJj3lWQTPMvI0uvpYqOmJQ
	 wpCnVQZeZkcsQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/3] xattrat: accept empty O_PATH file descriptors
From: Christian Brauner <brauner@kernel.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260630120641.133521-1-agruenba@redhat.com>
References: <20260630-wunsch-wichtel-ansporn-f4754acc8bcf@brauner>
 <20260607164136.2948550-1-agruenba@redhat.com>
 <20260607164136.2948550-2-agruenba@redhat.com>
 <20260630120641.133521-1-agruenba@redhat.com>
Date: Tue, 30 Jun 2026 14:32:58 +0200
Message-Id: <20260630-ochsen-neutralisieren-langzeitfolgen-f685027b7f3c@brauner>
X-Mailer: b4 0.16-dev-96101
X-Developer-Signature: v=1; a=openpgp-sha256; l=2871; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ltKDMmanMQBf+BZSMZLfcwwIQAsADTnBGEV0gsqp/cA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5b6+JtTzhU31Ee9aL73+MZ81tuXNUM9/VxHf/JnEJX
 2vv9nuHO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSoMDI0CpV7ShYW7nNUbvz
 0fxNoaelOB+tlXXPXPBDLdBwr/6Dswz/PfhnJdfM+qPi+qKFie1MqQWH13zuCV+8XVqvzbutEH6
 eFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-06-30 14:06 +0200, Andreas Gruenbacher wrote:
> On Tue, Jun 30, 2026 at 11:12 AM Christian Brauner <brauner@kernel.org> wrote:
> > > Right now, the setxattrat(), getxattrat(), listxattrat(), and removexattrat()
> > > system calls fail with -EBADF when dfd is an O_PATH file descriptor, pathname
> > > is an empty string or NULL, and the AT_EMPTY_PATH flag in at_flags is set.
> > > (Regular non-O_PATH file descriptors are accepted.)  This is inconsistent with
> > > the behavior of system calls like fstatat() and fchmodat() which do accept
> > > those file descriptors.
> > >
> > > The same operations can also be carried out indirectly by using
> > > "/proc/self/fd/<dfd>" as the pathname, but that is only more cumbersome, and
> > > for no good reason.  Fix that by changing the xattrat() system calls to accept
> > > these file descriptors directly.
> > >
> > > We stick with the existing practice of leaving the behavior of the fsetxattr(),
> > > fgetxattr(), flistxattr(), and fremovexattr() system calls unchanged: those
> > > will still reject O_PATH file descriptors.
> > >
> > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > >
> > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > index d58979115200..4737554df5fa 100644
> > > --- a/fs/xattr.c
> > > +++ b/fs/xattr.c
> > > @@ -700,7 +700,8 @@ int filename_setxattr(int dfd, struct filename *filename,
> > >
> > >  static int path_setxattrat(int dfd, const char __user *pathname,
> > >                          unsigned int at_flags, const char __user *name,
> > > -                        const void __user *value, size_t size, int flags)
> > > +                        const void __user *value, size_t size, int flags,
> > > +                        fmode_t mask)
> > >  {
> > >       struct xattr_name kname;
> > >       struct kernel_xattr_ctx ctx = {
> > > @@ -725,7 +726,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
> > >
> > >       CLASS(filename_maybe_null, filename)(pathname, at_flags);
> > >       if (!filename && dfd >= 0) {
> > > -             CLASS(fd, f)(dfd);
> > > +             CLASS(fd_except, f)(dfd, mask);
> >
> > So I can live with the O_PATH change, I guess...
> > but I really dislike fd_except. The code should never bother to pass
> > FMODE_PATH directly which is just rather ugly and we've taken pain to
> > make it work without passing it.
> >
> > I also don't yet understand why this would be necessary at all.
> 
> So we've got some system calls that should accept O_PATH file descriptors
> ({get,set,list,remove}xattrat), and others that should not
> (f{get,set,list,remove}xattr).

I'm very confused why the f*at() variants are supposed to accept O_PATH
but the f*() aren't? What's the point? glibc has in multiple cases used
the f*at() variant to implement the f*() variant.

