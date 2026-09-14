Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392BD3914FE;
	Mon, 14 Sep 2026 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428979; cv=none; b=j75/S+oc3IH+gcCYsCAVICIx+gRlrqkQYkGHk/VJPFLVkZA8QfvZYWsy3U4K7ll4ABWNgMAwdU7u3SqQVO8DKddoRTisS1BVLFW8zI7YfWK4v9NJqAzx8nniCnIvgGFvJFcd3X88vHLRaoAO8tuLe1RlNoas2NMJFQRYvxycfuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428979; c=relaxed/simple;
	bh=0yEOZ2zm49yqhnYjPjecOuBAeUnUnX00ftqZDbWO/rs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TeJINBM54EoVssZQFNP6h857CKVOLyogF4gxEvJqySLovzzV+7pRiIiSaTNWzUR03dSgfCZ4btx+/yx+ZtuQ3pm/E/JexXOkP6aBdwCjfrMR9mVBrfAJt9Tss3cT+CQkCEivuv82rYh7xC+NYOiXq6VtPAy+CY1yRjUiujn825k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Hijzx9QI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sg9lLvBr; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Hijzx9QI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sg9lLvBr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4F3861D000F5;
	Mon, 14 Sep 2026 19:36:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 14 Sep 2026 19:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1789428976; x=1789515376; bh=r8QV0ECAL46J0Whrshlcceyn+3Dh1CqZbRd
	M9TLC4Ew=; b=Hijzx9QII0ktkv6BvAG2Y1OYto5In3tc5irR9QIrL1n56kQO7ri
	oxy9UEoMuZM0b28C8at6/5U+tSM5DecIHDfemd5i6ITwarczw48Fo3sKlAcUIXoT
	aCDYtrbfUa7632Ss381Mbo15eKZLrTDSfHq6Snr2BW4fv3L7o6hBldWE/zrYxfvs
	fbmXXKIglRIaodpdLatjwmB4xad/A4g6EMWyJqMCe4vLvppFu5WkvWSIT+aF7+Ho
	Grj6hqmEsnnJtTXf6SAw/vGWjNyh5SFqh6MvEC1+OdsaDdlgV6K8iB3muXXMnwae
	pX+ARuButhe36Us66tMCHFhVR8gXPDRV23A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789428976; x=
	1789515376; bh=r8QV0ECAL46J0Whrshlcceyn+3Dh1CqZbRdM9TLC4Ew=; b=s
	g9lLvBr7AHdphse13HLm6+/+A0+UPUwTLzyphUF/nu/Nof0R62Dak5IH0MZYTtkM
	PJuxUT3p2jEEpZGteGRo3/IwE80YWVuuS+QlOJRZuISFDTn913wUMU1uJs9ESz/3
	5TTiRdbEUVJn7u0YXnJnrvKN+tNuYrc0t3YixR4M51wLV6goIq7b6Z6L68kLwfLZ
	wjJlK9K0IiDldKtZ3GSBe40O5auqn52MSqxFc2LRA1+3H7+hLZL1rqT4mNRcKGkW
	vmHK+arINMVpEUBQKJ439KkRedDoQvAo3pr2l0RgQ4gOpTVmKJlrQqjRXa/jbGyW
	T0gvUaic6B3162f7V15Yw==
X-ME-Sender: <xms:74SoahxPj_9vieeJESDQvkrUSxV3i2rk0FTYDaADRJCnoYsMH_pVvw>
    <xme:74SoajjbtcXxWKxzpSv8rEf4r3pBeTxsNZsfsGcTn7e-9tQBkDmpJxQLyfU-X3RIP
    yhCB9k-32DdknpoM4KfFMAzpKFDlr8NxWTVzYZuBEn_qZqMbA>
X-ME-Received: <xmr:74SoatmCRiQkurez9P1Jqh_D6RhmXzWFO5mX5Ly_PFpdwnyP3EvSwwJwnj1JhxKK7Q>
X-ME-Proxy-Cause: dmFkZTGZxJgRuErApdVWjHwJlEQdYJ6koFBphUki4WbYsrGSzd21xHQ+cdSNGEQ6vSk/pJ
    pOzKzQYqa3+z+NjNdpyHMaNwQzaTAd/2ZNlhPBtNUuQgY5UBcfWn0BfCOfoLoxVGQbvF01
    Zb8/F/4gwPUFI9DA/F87gSRg+5XQO/B5H00An0PetUQv/8e04LtbOtsUYfly7KPk1KFjL5
    rwRtzj5r9RPlpsKTO6l8S42lTokGYRZcGuSo5/UmEqnLQH+0fM1O4G5L//1HT95rNKPUPq
    4MV5OKSLBD7GdzJZHrL+iM+mcjMONQ3Tf0dzN/p3x+d2vSQ8cpOzKXvujNlbGomrzNaNPf
    B4FDO4eeFlz2R6AYHvJvSluqHkm58IGryjSkAvmF/LeVxwmy+wny8ZWVlamGYzXAyA0nl9
    wBX7+/iQHuw+wbp3PEX7j2Ix00hpRZSr5RdQ2ZTk/JN6DOA5yJ6tqN51ZiKrgf4+n2WPU+
    qr3a+Yv9BDv32k7+vU4TzmlepugvcR3VcAl/YyaEvBHtx/xkof6PwEkaXF6kmSsP7HtK9R
    As4lqbihQP/vLILk3sLRIJD98juuuMPxyPzwNKXN5T+igTdOShVb93pGE6OuX+PXWtqIZZ
    GdaeH+YOH5N1cDfGY4xTFDUGi/E/61tXN6KbVBM4tR4Ha6TLi0gIz6bVvPew
X-ME-Proxy: <xmx:74SoapgaUCj5WbXFov7PwEp48pNT5yYyENSS5pDR6bbeJPczyMQjAg>
    <xmx:74Soah231L0JY9nRzmec2zt5wbT90kO8VA1RW3TN6sifw5t2xH-gvg>
    <xmx:74SoaiJlHzcrqCQ72NsS8Tctt9yPOBKgiIQNYwKfDUGUOyZ4-3WvkQ>
    <xmx:74Soahz3bNi9eEBclrs387ZTrB3RaUH-4kNcRSUF87WxV_xWYiHLxA>
    <xmx:8ISoajJXlqpS_GXzvTWHO88k4JTnEMbhvRmSGKGLiOelI8VzfvbiAVLH>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 19:36:13 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Mateusz Guzik" <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Mateusz Guzik" <mjguzik@gmail.com>
Subject: Re: [PATCH 00/10] Towards safer path_* API
In-reply-to: <20260913144918.1606123-1-mjguzik@gmail.com>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
Date: Tue, 15 Sep 2026 09:36:09 +1000
Message-id: <178942896971.207413.7668803121120091718@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 14 Sep 2026, Mateusz Guzik wrote:
> Currently the handling is highly error-prone with consumers allowed to
> arbitrarily manipulate references, notably with path_get().
> 
> In the past this resulted in preventable bugs.

Can you provide a reference to one or two of these bugs.  That would be
useful context.  Thanks.

NeilBrown


> 
> The end goal, not yet achieved with this patchset, will provide an
> invariant that a populated 'struct path' has precisely one set of
> references on it.
> 
> While consumers can still cause leaks by neglecting to path_put(), the
> footgun of path_get() can be eliminated.
> 
> With this patchset instead of hand-rolling a path copy and issuing
> path_get() on it, callers can resort to path_clone() instead.
> 
> Almost all path_get() consumers get converted, most of which with
> coccinelle.
> 
> Few instances are left until I figure out a nice way to sort them out.
> 
> Overall almost entirety of this patchset is a NOP.
> 
> Mateusz Guzik (10):
>   fs: unexport backing_file_set_user_path() and make it take the ref on
>     its own
>   fs: add path_create(), path_move() and path_clone()
>   fs: use path_clone() in path_init()
>   fs: use path_clone() and path_move() in vfs_open*
>   fs: use path_clone() in backing_file_set_user_path()
>   Coccinelle-based conversion of path_* consumers to use the new
>     primitives
>   autofs: use path_create()
>   fsnotify: use path_clone()
>   proc: use path_clone()
>   nfsd: use path_clone()
> 
>  drivers/block/loop.c               |  3 +-
>  fs/autofs/dev-ioctl.c              |  3 +-
>  fs/autofs/expire.c                 |  4 +--
>  fs/backing-file.c                  |  2 --
>  fs/devpts/inode.c                  |  6 ++--
>  fs/failfs.c                        |  3 +-
>  fs/fhandle.c                       |  3 +-
>  fs/file_attr.c                     |  6 ++--
>  fs/file_table.c                    |  3 +-
>  fs/fs_struct.c                     |  6 ++--
>  fs/namei.c                         | 44 ++++++++++++++++++++++++------
>  fs/namespace.c                     |  3 +-
>  fs/nfsd/export.c                   |  6 ++--
>  fs/nfsd/nfs4xdr.c                  |  8 +++---
>  fs/notify/fanotify/fanotify.c      |  6 ++--
>  fs/notify/fanotify/fanotify_user.c |  3 +-
>  fs/nsfs.c                          |  3 +-
>  fs/open.c                          | 10 ++-----
>  fs/overlayfs/params.c              |  3 +-
>  fs/pidfs.c                         |  3 +-
>  fs/proc/base.c                     |  6 ++--
>  fs/proc/fd.c                       |  3 +-
>  fs/smb/server/vfs.c                |  3 +-
>  fs/xfs/xfs_handle.c                |  3 +-
>  include/linux/path.h               | 14 ++++++++--
>  kernel/trace/bpf_trace.c           |  3 +-
>  security/apparmor/task.c           |  3 +-
>  security/keys/big_key.c            |  3 +-
>  security/landlock/fs.c             |  3 +-
>  security/landlock/syscalls.c       |  3 +-
>  30 files changed, 87 insertions(+), 85 deletions(-)
> 
> -- 
> 2.53.0
> 
> 
> 

