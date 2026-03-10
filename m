Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0466239937E;
	Tue, 10 Mar 2026 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147258; cv=none; b=EnDL3E85SjCe33qV1u1gdcNdLfSZur8JFA0/nx9QMkpmkmh/pUZQzdTC8tjS9Hw60wLf7Ma4CSrDdU1dnW+tdy0SigJAh5VsJswZVDJiq2mXXaovv9x97p1eZhmFjVtKLhmmUwOLsf8OktAoiSaI3X4LyKhjwk3aMGE6PiULBkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147258; c=relaxed/simple;
	bh=Xw1mVQtvhVoNrJBDYR12XC0/Wogw2F1Mt9WBKlhiOM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hb6ZMw6SIzo4ZeQGBpZLUZhAd3sfoXDJw7eBuNs68fxJ2oeGsuFJPDng0fjehUcBpWOQHVxuPVBftSYCxB6V2rvffy+S7X2dZ8Td/Xwj1D51OQwIxacbHP9S87OropBx6Nylj3iSwBAS0YaeYj5a58zZ9OihYuzOIoAyAChkk20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt0BoOi+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt0BoOi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A3FC19423;
	Tue, 10 Mar 2026 12:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773147257;
	bh=Xw1mVQtvhVoNrJBDYR12XC0/Wogw2F1Mt9WBKlhiOM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gt0BoOi+nVV9jKU8Qbyp0Fri3VZe+y4MkbP5j69llEa2HO7GApC/ZIMS82EMmXnd5
	 FtZkS/31wANexEn3LooDVX6DptaF6ZyZeFAbcAnOPRDbGOGE7I87HA6daxDpMxmTw0
	 jTnQN+VmOOes8jS5VgsxBYqZoH1Y72qUBVycm7X9GTEL58o3VmfolLYJnrytM2oJjO
	 d3jiBzauNer8IK+C40ZZco7Su3xLva8L/cyJhf/nO13oPv6ya8dbwJuU+8UPffMDxE
	 pngaOqWODgcVa2jDPOvj7pqob8eEry1CSFBRhsCitFIka5Wr4HtGUbrkCqzthkyNrL
	 N+ReJTltfQaBw==
Date: Tue, 10 Mar 2026 13:54:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC v2 00/23] fs,kthread: start all kthreads in nullfs
Message-ID: <20260310-schummeln-akkord-db58004d6f59@brauner>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
 <CAG48ez1CN4hrYVi3dGYY-4vJgSeib-pb19qCNs7Gjkb2mrjKuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1CN4hrYVi3dGYY-4vJgSeib-pb19qCNs7Gjkb2mrjKuA@mail.gmail.com>

On Mon, Mar 09, 2026 at 05:50:36PM +0100, Jann Horn wrote:
> On Fri, Mar 6, 2026 at 12:30 AM Christian Brauner <brauner@kernel.org> wrote:
> > The places that need to perform lookup in init's filesystem state may
> > use scoped_with_init_fs() which will temporarily override the caller's
> > fs_struct with init's fs_struct.
> 
> One small concern I have about the overall approach is that the use of
> scoped_with_init_fs() in non-kernel tasks reminds me a _little_ bit of
> the set_fs(KERNEL_DS) mechanism that was removed a few years ago:
> There is state in the task that controls whether some argument is
> interpreted as a user-supplied, untrusted value or a kernel-supplied
> value that is interpreted in some more privileged scope. I think there
> were occasionally security issues where userspace-supplied pointers
> were accidentally accessed under KERNEL_DS, allowing userspace to
> cause accesses to arbitrary kernel addresses - in particular,
> performance interrupts could occur in KERNEL_DS sections and attempt
> to access userspace stack memory, see
> <https://project-zero.issues.chromium.org/42452355>.
> 
> I think switching task_struct::fs is much less problematic - path
> walks shouldn't happen in IRQ context or such, scoped_with_init_fs()
> will likely only be used when accessing paths that unprivileged
> userspace has no influence over, and VFS operations normally don't
> operate on multiple logically unrelated file paths; but it means we'll
> have to keep in mind that filesystem handlers for some operations like
> lookup/open can run with weird task_struct::fs.
> 
> To be clear, I think what you're doing is fine; it's just something to
> keep in mind.

Just for some background. I think as it currently stands we have a 1:1
sharing between all kthreads and pid 1. So effectively a kthread is in a
permanent scope_with_init_fs() block. Any driver can just do:

file = filp_open("/proc/sys/kernel/core_pattern")
kernel_write(file, "/usr/bin/systemctl poweroff")

which is ofc nonsense but still.

But my wider point is that this implicit lookup context is probably in
very few people's mind.

Some people who are aware of this then end up with brilliant ideas such
as writing kernel modules that perform mountains of actual path lookup
work from kthread context because it's just so easy to do and lets them
avoid having to do any real conceptual work to come up with a better
solution.

Offloading fs work to kthreads is really nasty... And we've relearned
that lesson not too long ago when io_uring was still based on kthreads
with custom credential overrides. It's a broken concept.

scoped_with_init_fs() forces the users that do this to acknowledge that
they are now performing lookup work within PID 1's filesystem state. We
have few of those and this will make it harder to gain more.
