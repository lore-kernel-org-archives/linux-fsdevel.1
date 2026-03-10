Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310C839DBD9;
	Tue, 10 Mar 2026 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143927; cv=none; b=YSn2qLo4caYg9EpsisB20PQKIyql2GpCFmpLIT81SsCR5skD3ISFC56e9QFzn4x+yjuvlwTUIRKORk+wHz0BICPaMNBOAjUoWQ3gzMYV+qHDKBl3ji1dL6NYXQrKWObopp/XMcMeBeqq0CXOMt2+dDW4cPFHGwx9q7O8RJxX2b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143927; c=relaxed/simple;
	bh=8KeK2FERi/dmfgYLBG6RVzd3fsNTTb0T5AdY7sw+4jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8qpEH/XI/EjwfoEpHMFsoTeCRPLiTOGFcgaaW4LTxMlUA1Bvphj1NuHfQ4/HU/sspxXhTi+3jpTS71Sks7pWkExkAgZlMD2dOCVvp7FT75E0pJKDA0lgWRWV0RqlzYuLCWYMts16AlH6PS1zQTpUpaQ/TdXkI4PkTgtatt0YJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=big884u2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="big884u2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6196C19423;
	Tue, 10 Mar 2026 11:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773143926;
	bh=8KeK2FERi/dmfgYLBG6RVzd3fsNTTb0T5AdY7sw+4jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=big884u2EA2Ufs3DTcZUW0wrnwLQk3RJ4ie1EeB4YpJ4UL43H+2mtCote/NdxuaMZ
	 wuh76c7aDqMvoa1K5lCyYqounysmYLEcZk/dQuw9ivmTOdIZ576U5g4561VGgrgIxO
	 4n4fVP1brxdOZiEMNnpww36bw5cexNa0dDPd1d3KkuV/Sn33HAEw0lLAwE+64vVNCM
	 vLwGuWyZSxU/62tK5kgKxrDd/lQkVGS/83JUbdl9MaYBaOwtmmsF82D7Yll7QzNltY
	 fYQjbpxRn4G1z6W9IU0FZbkGTgGV16aNwf+0gAqeVTNJgKEatpIKo4geGyjHkiciKM
	 r475BKzF/OgFg==
Date: Tue, 10 Mar 2026 12:58:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC v2 18/23] fs: add umh argument to struct
 kernel_clone_args
Message-ID: <20260310-attest-bemerken-1a3ba981e917@brauner>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
 <20260306-work-kthread-nullfs-v2-18-ad1b4bed7d3e@kernel.org>
 <CAG48ez3Oei55q_b4Wbh5Z4R81ZjOvfKcJhZe1QVudbxMw3TAsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3Oei55q_b4Wbh5Z4R81ZjOvfKcJhZe1QVudbxMw3TAsQ@mail.gmail.com>

On Mon, Mar 09, 2026 at 05:06:24PM +0100, Jann Horn wrote:
> On Fri, Mar 6, 2026 at 12:31 AM Christian Brauner <brauner@kernel.org> wrote:
> > Add a umh field to struct kernel_clone_args. When set, copy_fs() copies
> > from pid 1's fs_struct instead of the kthread's fs_struct. This ensures
> > usermodehelper threads always get init's filesystem state regardless of
> > their parent's (kthreadd's) fs.
> >
> > Usermodehelper threads are not allowed to create mount namespaces
> > (CLONE_NEWNS), share filesystem state (CLONE_FS), or be started from
> > a non-initial mount namespace. No usermodehelper currently does this so
> > we don't need to worry about this restriction.
> >
> > Set .umh = 1 in user_mode_thread(). At this stage pid 1's fs points to
> > rootfs which is the same as kthreadd's fs, so this is functionally
> > equivalent.
> [...]
> > -static int copy_fs(u64 clone_flags, struct task_struct *tsk)
> > +static int copy_fs(u64 clone_flags, struct task_struct *tsk, bool umh)
> >  {
> > -       struct fs_struct *fs = current->fs;
> > +       struct fs_struct *fs;
> > +
> > +       /*
> > +        * Usermodehelper may use userspace_init_fs filesystem state but
> > +        * they don't get to create mount namespaces, share the
> > +        * filesystem state, or be started from a non-initial mount
> > +        * namespace.
> > +        */
> > +       if (umh) {
> > +               if (clone_flags & (CLONE_NEWNS | CLONE_FS))
> > +                       return -EINVAL;
> > +               if (current->nsproxy->mnt_ns != &init_mnt_ns)
> > +                       return -EINVAL;
> > +               fs = userspace_init_fs;
> > +       } else {
> > +               fs = current->fs;
> > +       }
> >
> >         VFS_WARN_ON_ONCE(current->fs != current->real_fs);
> 
> Should that VFS_WARN_ON_ONCE() be in the else {} block?

I think in spirit the placement you suggest makes more sense.

> I don't know if it could happen that a VFS operation that happens with
> overwritten current->fs calls back into firmware loading or such, or
> if that is anyway impossible for locking reasons or such...

Usermodehelper are terrible hybrids that always go through workqueue
dispatch. So let's say somehow someone ends up triggering a
usermodehelper under scoped_with_init_fs() - no matter if regular task
or kthread - what would actually happen is:

INIT_WORK(&sub_info->work, call_usermodehelper_exec_work)

which means all usermodehelper creations are done from some other
kthread and never by the caller. IOW, even if the caller has overridden
current->fs the usermodehelper would be created from a pristine kthread
context.
