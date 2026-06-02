Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E1E2517A5;
	Tue,  2 Jun 2026 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406495; cv=none; b=iuhHdAUJ/K/SMgzH4rHK3Ix/C4EsN8MX0MEPcO0KQDnMllZnUMWXiRncXPwYzQmuHCcM2NaUxVPqcDCYlglxPCqHH2ClZlGLrDQIZVVDs3L5t79DhCSTd3HASCqsh+iVDS7YCb8rJTJptKe1jy4cO/7nUfJSfLrHndjbOWlBwm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406495; c=relaxed/simple;
	bh=k1SJZNDz2Xdi+z/Mh9pgClNFhxcR43VyRzQ6BTlsxzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTvtHCrw0l37LZUtwEY0IP+5T5GkDUF9PnF6jUo6t3tYc5KQ/fDAMgr+t4xzcvVRfCS/4nI3Fs5KFOjk8o4fDTth5DiO/S13TTqB5ODLFDASjr1FTwVtvEvdQEz7yguvNxR0DysFLTXFJQ4Thh1Ra9onSbHHSWLMUHMisNBXd24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRAOgWyw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRAOgWyw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A471F00899;
	Tue,  2 Jun 2026 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780406494;
	bh=jJ+RWimZ/mwf4VUSWN9H2gT29J4VTFtMkgSG2vIIILI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iRAOgWywXuHtUux7kx7aNScQ6xiJWuWyjNt8xwcGJhV8ZY2QRZz0bhI+2aBkIttno
	 QYtGInP9D8GLD0So9LuFhwEG9+T2lAEbKXVe1A6cAQD1S9ZbeqMvnR/46FcV/nn7jo
	 sgQvCLKbsTp0n0KIrRlXABZ72er2fZSagDZx5yQ9d2XElfETP7zPcEmT8xISLTZJK9
	 xZv1Fa121fZRD4wkLw7IKV2wvLEh9WvcouT5jhts7Fl1fS56BvFcNFzEKLXCrMVOo1
	 2KgL20RvTbd4IOc3uTj+CjYVajORnNOfh5lOP1u5LMY2vdpTiiP2Bj2GUBZ9kwi1Px
	 wAYaGm+1A3Y2g==
Date: Tue, 2 Jun 2026 15:21:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Philipp Matthias Hahn <pmhahn@pmhahn.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Proper error-handling of cdev_add() after cdev_alloc() ?
Message-ID: <20260602-gleiten-tontechnik-kalender-d506d306d6ea@brauner>
References: <agLivEl8W_gjAi51@birdy.pmhahn.de>
 <ahb5O4PqQd51u8Ke@birdy.pmhahn.de>
 <f64qxrwhhfrxxcp4z7kaeudoz5x7irzu5tjhcu2qarzdhtf6e3@g4g3ytghcyoe>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f64qxrwhhfrxxcp4z7kaeudoz5x7irzu5tjhcu2qarzdhtf6e3@g4g3ytghcyoe>

On Sat, May 30, 2026 at 01:15:37PM +0200, Jan Kara wrote:
> Hello!
> 
> On Wed 27-05-26 16:01:31, Philipp Matthias Hahn wrote:
> > > How should errors of `cdev_add()` after `cdev_alloc()` be handled?
> > 
> > sorry for ping-ing you directly, but so far got no answer and I would
> > like to get a definitive answer on this before I spend more time on this
> > to create and send patches. Thank you.
> 
> So I don't really feel like chrdev specialist but based on reading the
> code:
> 
> > Am Tue, May 12, 2026 at 10:20:13AM +0200 schrieb Philipp Matthias Hahn:
> > > The basic schema seems to be like this:
> > > 
> > > 	cdev = cdev_alloc();
> > > 	if (!cdev)
> > > 		return -ENOMEM;
> > > 	...
> > > 	ret = cdev_add(cdev, ...);
> > > 	if (ret < 0) {
> > > 		/* WHAT HERE ??? */
> > > 		return ret;
> > > 	}
> > > 	...
> > > 	return 0;  // success
> > > 
> > > I found 5 case of how errors are handled:
> > > 
> > > 1.  kfree(cdev);
> > > 	drivers/media/v4l2-core/v4l2-dev.c:1060
> > > 
> > > 2.  kobject_put(&cdev->kobj);
> > > 	drivers/char/xillybus/xillybus_class.c:107
> > > 	fs/char_dev.c:293
> > > 	drivers/s390/char/vmlogrdr.c:780
> > > 	drivers/tty/tty_io.c:3171
> > > 	drivers/uio/uio.c:925
> > > 
> > > 3.  cdev_del(cdev);
> > > 	drivers/char/virtio_console.c:1435
> > > 	fs/fuse/cuse.c:419
> > > 	drivers/misc/mei/main.c:1318
> > > 	drivers/s390/char/tape_class.c:92
> > > 	drivers/s390/char/vmur.c:928
> > > 	drivers/scsi/sg.c:1560
> > > 	drivers/scsi/st.c:4307
> > > 	drivers/staging/vme_user/vme_user.c:694
> > > 
> > > 4.  No error handling at all.
> > > 	arch/sh/boards/mach-landisk/gio.c:145
> > > 
> > > 5.  panic()
> > > 
> > > Currently I'm unsure of what's the correct way.
> > > My current understanding is, that `cdev_del()` should only be called if
> > > `cdev_add()` succeeded, so those findings above should be fixed. But
> > > to what?
> > 
> > I guess __register_chrdev() from fs/char_dev.c:293 is correct and
> > 	kobject_put(&cdev->kobj);
> > should be used.
> 
> This indeed looks like proper handling of the failure.

Yes, sorry, I forgot to reply to this mail... Thanks, Jan!
