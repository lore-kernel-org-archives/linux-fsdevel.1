Received: from birdy.pmhahn.de (birdy.pmhahn.de [88.198.22.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1FC18A6D4;
	Wed, 27 May 2026 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.22.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890906; cv=none; b=C5J17RtsMBwOPij5WZ4gmTBi5gGc55eELL+vxRLyyG8YNMHF2J+YbUutDyKitpUztHf4oUrqvS1G0EwZjy8vdMYxYKEmKyhspOOpKXb75S1DbhdshEVqgEjlo4nvZDvfgCOhT/1WLEMBG6dDmd5ZaZO2o7utSnWCG6d0LH7lIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890906; c=relaxed/simple;
	bh=rnvPlY7SKQat4XqjTKrPe6m37pte20Tp9Jd5r0LlGbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/3Xz7SSozAOC1Lk/fz9C1ursCRoOrPjdj52JvaSzy0aQnkyPyvcWx0yuXmcG6wy79N7sWG04FFXmbkp/c+IhfoTqbiaBW2m1xQVMJtcF2ckCowUqukMyvlo0MgjokuTyO2PPLcsTg5r2b9SU5ZJvqUb4Ph0hOLlieD3/TTiW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pmhahn.de; spf=pass smtp.mailfrom=pmhahn.de; dkim=fail (2048-bit key) header.d=pmhahn.de header.i=@pmhahn.de header.b=hp82dTcs reason="signature verification failed"; arc=none smtp.client-ip=88.198.22.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pmhahn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmhahn.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pmhahn.de header.i=@pmhahn.de header.b="hp82dTcs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmhahn.de; s=202501;
	t=1779890492; bh=fqnybA+AhkDSoSNFV2pJQ4jb2qbNqk+p3TKkA5krk7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hp82dTcsVLKnPKstgfVWdlVIYVOPYxRaYY1SYJvB1goNLjklQePdkE2DJKJmG+KuS
	 ZN5GFvT/eQ29OxoX5qFJW6c0VphvVSj8OW+2wGvEhw+s5uGulNEo0hZqC7A+eCiXHF
	 bppHYzbMjvZIbOv2/LPSr2t7gnkdMYy6nnL59XhqzI2FaMr0NRtRVsr7zISkPBM730
	 +/QLoJ8pHCTb692VdrzD3PLzagVOYbMFwkmkb+kh70zDvqzefDIpWzg6FWEbWVBugJ
	 4SqWLxMRVqifVaFN2Ns8HgxogJwtnc87Mf8hty39O6hyopggtzb5CiRK/WZnLD8V4n
	 XnVejxB9G2f3Q==
Received: from birdy.pmhahn.de (p200300e27741c70018b982d1b498410b.dip0.t-ipconnect.de [IPv6:2003:e2:7741:c700:18b9:82d1:b498:410b])
	by birdy.pmhahn.de (Postfix) with ESMTPSA id 7A3762215801;
	Wed, 27 May 2026 16:01:32 +0200 (CEST)
Date: Wed, 27 May 2026 16:01:31 +0200
From: Philipp Matthias Hahn <pmhahn@pmhahn.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Proper error-handling of cdev_add() after cdev_alloc() ?
Message-ID: <ahb5O4PqQd51u8Ke@birdy.pmhahn.de>
Mail-Followup-To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <agLivEl8W_gjAi51@birdy.pmhahn.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agLivEl8W_gjAi51@birdy.pmhahn.de>

Hello,

> How should errors of `cdev_add()` after `cdev_alloc()` be handled?

sorry for ping-ing you directly, but so far got no answer and I would
like to get a definitive answer on this before I spend more time on this
to create and send patches. Thank you.

Am Tue, May 12, 2026 at 10:20:13AM +0200 schrieb Philipp Matthias Hahn:
> The basic schema seems to be like this:
> 
> 	cdev = cdev_alloc();
> 	if (!cdev)
> 		return -ENOMEM;
> 	...
> 	ret = cdev_add(cdev, ...);
> 	if (ret < 0) {
> 		/* WHAT HERE ??? */
> 		return ret;
> 	}
> 	...
> 	return 0;  // success
> 
> I found 5 case of how errors are handled:
> 
> 1.  kfree(cdev);
> 	drivers/media/v4l2-core/v4l2-dev.c:1060
> 
> 2.  kobject_put(&cdev->kobj);
> 	drivers/char/xillybus/xillybus_class.c:107
> 	fs/char_dev.c:293
> 	drivers/s390/char/vmlogrdr.c:780
> 	drivers/tty/tty_io.c:3171
> 	drivers/uio/uio.c:925
> 
> 3.  cdev_del(cdev);
> 	drivers/char/virtio_console.c:1435
> 	fs/fuse/cuse.c:419
> 	drivers/misc/mei/main.c:1318
> 	drivers/s390/char/tape_class.c:92
> 	drivers/s390/char/vmur.c:928
> 	drivers/scsi/sg.c:1560
> 	drivers/scsi/st.c:4307
> 	drivers/staging/vme_user/vme_user.c:694
> 
> 4.  No error handling at all.
> 	arch/sh/boards/mach-landisk/gio.c:145
> 
> 5.  panic()
> 
> Currently I'm unsure of what's the correct way.
> My current understanding is, that `cdev_del()` should only be called if
> `cdev_add()` succeeded, so those findings above should be fixed. But
> to what?

I guess __register_chrdev() from fs/char_dev.c:293 is correct and
	kobject_put(&cdev->kobj);
should be used.

Thank you in advance
Philipp
