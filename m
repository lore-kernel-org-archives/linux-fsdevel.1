Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7338A719;
	Tue, 10 Mar 2026 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142173; cv=none; b=EBV2LGnnk+/NYkrqg1U3toyMIuKRKFUsQJlSVQ3vRRExBQaa0c9MZDzPISfcfVzuL9TC/wS7MG2MG6L9+1mR0uoH/ev+8RovX8Z6KPPlXJrQY1H+bmXXrqlFKpqYl4JJD0SNdcpwvk5wooIPeKoARLWDvsMYKcrjqHe3GplsIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142173; c=relaxed/simple;
	bh=7xDHHwqOfJhmNPLsEe0sHOHQe8Dwfhoh1y7I1oKVwC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMIXifCDJNhEklS242sepIo4BvZnAALSD3GZqSulrTE7Yk9T4iOCn3dJCOe8VQcq+UkiaE+q6rjvmyTnpfhgkMCygq75lBXMhil0kWoMHEpVe8RKBkOZRR2/FyjL0JUOPuvdKh/GrAich528eKdudssm3N4xAK6g227zeKZxkV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmOMEhW8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmOMEhW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B594C19423;
	Tue, 10 Mar 2026 11:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142173;
	bh=7xDHHwqOfJhmNPLsEe0sHOHQe8Dwfhoh1y7I1oKVwC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmOMEhW87ORt4YVboRYKuyjLYWjHEXO14ojxV8sqxjYEYHTwqTQDRk1IcuCOPpfH0
	 d4SpvYe/0kIUMH4QbLdzYcK6FGGzKcLaK+GFXjN3g5gmMoqfdOGTDhGvCmUgWmp25g
	 qsIZtj1E8O3DvDRPGLQ/gza+FMOEw/CGImb3O+BMdAuvD4HI5UoFU0VeCmk5DNt54O
	 fZAFSwXHmbLBjZw/WKzRT/qSx4JebQyyaWBlU6KPpFMH0ryQzccYi2tO9qi/q38pml
	 XfDrJB/7LpWOMAAdwUxbxMFR/JBTsJoL8oGFL43+i9R6p+atuOqOC+8D3DfuiWXcW1
	 idkGdhauG5mqA==
Date: Tue, 10 Mar 2026 12:29:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC v2 15/23] fs: add real_fs to track task's actual
 fs_struct
Message-ID: <20260310-siedler-umnutzung-d3b17bd3228a@brauner>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
 <20260306-work-kthread-nullfs-v2-15-ad1b4bed7d3e@kernel.org>
 <CAG48ez1Zsau1zjm0CnKO3sMMRHExcucemFW4o=rdurz2y6cV2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1Zsau1zjm0CnKO3sMMRHExcucemFW4o=rdurz2y6cV2w@mail.gmail.com>

On Mon, Mar 09, 2026 at 04:14:57PM +0100, Jann Horn wrote:
> On Fri, Mar 6, 2026 at 12:31 AM Christian Brauner <brauner@kernel.org> wrote:
> > Add a real_fs field to task_struct that always mirrors the fs field.
> > This lays the groundwork for distinguishing between a task's permanent
> > fs_struct and one that is temporarily overridden via scoped_with_init_fs().
> >
> > When a kthread temporarily overrides current->fs for path lookup, we
> > need to know the original fs_struct for operations like exit_fs() and
> > unshare_fs_struct() that must operate on the real, permanent fs.
> 
> Note that there are remote accesses to ->fs from procfs, including
> (idk if there are more, I didn't look closely):
> 
>  - mounts_open_common
>  - get_task_root
>  - proc_cwd_link
> 
> These expect that task_lock() keeps the task_struct::fs pointer
> stable, and I don't see anything that prevents them operating on
> kthreads.
> 
> You should probably ensure that remote accesses to task_struct::fs all
> use task_struct::real_fs, just like how there are no remote accesses
> to task_struct::cred - that makes logical sense since when userspace
> queries a task's file system root/cwd/mounts, what the task is
> currently doing probably shouldn't affect the result.
> 
> Then you could also change the locking rules such that task_struct::fs
> has no locking while task_lock() protects modifications of, and remote
> access to, task_struct::real_fs.

Yes, I have included those changes in the new revision I haven't yet sent out. :)
