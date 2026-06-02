Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE302441B8;
	Tue,  2 Jun 2026 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406055; cv=none; b=j/TZtNihWJVBLtjtyi6C7NtGYqDmanHVESdlIs8ipxu0kuQH3tS5ZITe8o14yGSnjhh3eylvcnGbmN9/KBisCR41DzH3pjxmJ1UGCL4ZFuxxuKqn/V2iEFhbgC35bhb51p8QnrgRQUV8T46VZuDXRywmnt1a85Icqgj8+4id6zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406055; c=relaxed/simple;
	bh=FPxWpeou7tmXApJuo4Y6PHMUbCndAexPTUj0mT/qUrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZrfDLuZkPJhSHiN8qPb68xp5T6Ajwye9vbKDsZjkX0QPHcw7aGo1l78Y7yPxWlCx8qHXeggpIAQUNccjoFbeiZ6lucZ4qLum/JHBIElnfKRLctpWvxICZAJ6ossbSMyyYYxCQKkpGpPNTztBI3BOUXMyIEYX8P63N98/P1zdPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgHqnfA5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgHqnfA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCF71F00893;
	Tue,  2 Jun 2026 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780406053;
	bh=rOrksVHuBmhsxaRnHPZ9ei/O8kXtWgGMPtbui1fmkv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NgHqnfA5LrUuhhpNclazUqKdW6wN7HlxLtO71+VtfXv7lxeoMUAO6Q/bjESHRARmi
	 ERPuZQVYH2aQaYGuQgpbtuXR83cSERZDcFHzZ1oxpnnq/PYu/aaXERVOW9/O+LywpG
	 zMqPj8tkPHDP6v80r3g1Dp1xoeHdT1tiVSA0cbUcuH6x+XuBWag92Psi/j1cnH51xt
	 n6zeupwfeVfnxo0REzGATFMJehZwqV9KdxhYCmuvyt/X4lv9ogGqTsrUsYzcigUyoI
	 3Z06LdfAyFTeo4CvQjF2QkX/I0Gs2sq5gwx7xZ7z3gcYXPQy36PUhkmlPSwarDtzGC
	 BsmJ6QUcx4huw==
Date: Tue, 2 Jun 2026 15:14:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: document locking for mnt_notify_add()
Message-ID: <20260602-rudel-zerstochen-fahrdienst-22b9860144b5@brauner>
References: <20260529-vfs-mnt-notify-comment-v1-1-5becd17a15c3@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529-vfs-mnt-notify-comment-v1-1-5becd17a15c3@google.com>

On Fri, May 29, 2026 at 09:38:08PM +0200, Jann Horn wrote:
> The locking in mnt_notify_add(), which was introduced in commit
> bf630c401641 ("vfs: add notifications for mount attach and detach"), is a
> bit gnarly.
> notify_list is protected by namespace_lock, but there are cases where
> mnt_notify_add() is called without holding namespace_lock, for example:
> 
>     __do_sys_fsmount -> mnt_add_to_ns -> mnt_notify_add
> 
> Luckily, in cases where the namespace_lock isn't held, the namespace is
> always freshly created and can't have any fsnotify marks yet, which means
> the notify_list isn't actually accessed.

When fsmount() is called it creates an anonymous mount namespace. Such
anonymous mount namespaces are pure containers for a mount trees. They
can never actually appear as namespaces to userspace. Nothing can be
registered on them and they can't be setns()'d into. So it is impossible
to ever register any mount notification watch on them.

In general modifying mount notification objects require namespace_sem to
be held (read-side - we downgrade when possible).

> 
> The existing comment claims that not accessing the notify_list in these
> cases is merely an optimization, which is wrong. Fix the comment, and add a
> locking assertion.

I don't think this is what the comment intended to communicate but I
guess it can be misread.

> 
> To allow mnt_notify_add() to reference the namespace_sem, move it into
> fs/namespace.c.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I'm sending this patch because I spent some time staring at this
> trying to figure out if this was buggy or not.
> 
> I don't know if this is working as intended or working by accident,
> and it might be nice if this was cleaned up to have simpler locking;

The locking is rather simple: namespace_sem. But maybe I misunderstand.
It just piggy-backs on the same logic as mnt_add_to_ns() in that
mnt_add_to_ns() may be called to add mount into a newly allocated
namespaces without namespace semaphore held. So the locking context is
guaranteed by mnt_add_to_ns(). To put another way: if you have quarrels
with mnt_notify_add() you likely also have quarrels with the contextual
locking of mnt_add_to_ns().
