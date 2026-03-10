Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2F13BF66B;
	Tue, 10 Mar 2026 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158741; cv=none; b=OS9pKKgI1QNlw9bw/Dn99M4QzVq7+KDDLOs2132XMOU9IL3F9e2iWB1f42g3Kwb1P3U+KPs8O1AVw0QFRu1WbKlS8Tf6lxHH7NTuSMH69vRu8kCID6ZpgE00FPnJ7HYASEUp4fThFnbB5GuTcLoubRtPPWc8kj1hklp8Mw4fEFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158741; c=relaxed/simple;
	bh=UstQY80J8u9/r87ZRVHGNetdIGXlJV1gMDpJn5C6mNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izITya01nK35V3AJ848nPRF3Kviat9CQsnup5u30byVRCRvg8EiTmie+IwOOaZUg7KPdwiXhi8O+DISKnRdurmprAAJQsdDFIW+IULJLkUlZ1b5ZJCyReCGgnKvtlqs0sCEMws6aN5T7uyQ3ndRmVe9CKs2nzJkfJ6znW4if5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLPiODC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLPiODC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FBEC19425;
	Tue, 10 Mar 2026 16:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773158740;
	bh=UstQY80J8u9/r87ZRVHGNetdIGXlJV1gMDpJn5C6mNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLPiODC5wh1bkYxoXnceCYjNL2t2ycYKrU4NkztlmWBzaCBfb/jxXsdA3MP3bilRH
	 96Ljb1qJY0D2xtOXDIEBxILbwIaaltU5uBuwveJZlH8S2rfQGGBqtHRs+fB/1DSGoj
	 T59xtn5gEigq7CRIbT22dfTHR9h8yt2QiK0KVK1cOjdicz016FoCVpATJE0VBhBukD
	 L9iEfEPrZ5vB4P69AdCTA3ysi/g6aJFFEqQV1PxaSdaLb7aY/f0Ze3rvZ4glxImvA/
	 F+GWsgTFYH6Sr+qBFZqsQP5V4cupKzlP8LMfbGcCc3vS4a+nJvm2hBIaYnGvrIcBJp
	 Jr2hUUmS6e8Sw==
Date: Tue, 10 Mar 2026 17:05:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC v2 15/23] fs: add real_fs to track task's actual
 fs_struct
Message-ID: <20260310-gemahl-zertreten-61a4ccd27266@brauner>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
 <20260306-work-kthread-nullfs-v2-15-ad1b4bed7d3e@kernel.org>
 <CAG48ez1Zsau1zjm0CnKO3sMMRHExcucemFW4o=rdurz2y6cV2w@mail.gmail.com>
 <20260310-siedler-umnutzung-d3b17bd3228a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310-siedler-umnutzung-d3b17bd3228a@brauner>

On Tue, Mar 10, 2026 at 12:29:28PM +0100, Christian Brauner wrote:
> On Mon, Mar 09, 2026 at 04:14:57PM +0100, Jann Horn wrote:
> > On Fri, Mar 6, 2026 at 12:31 AM Christian Brauner <brauner@kernel.org> wrote:
> > > Add a real_fs field to task_struct that always mirrors the fs field.
> > > This lays the groundwork for distinguishing between a task's permanent
> > > fs_struct and one that is temporarily overridden via scoped_with_init_fs().
> > >
> > > When a kthread temporarily overrides current->fs for path lookup, we
> > > need to know the original fs_struct for operations like exit_fs() and
> > > unshare_fs_struct() that must operate on the real, permanent fs.
> > 
> > Note that there are remote accesses to ->fs from procfs, including
> > (idk if there are more, I didn't look closely):
> > 
> >  - mounts_open_common
> >  - get_task_root
> >  - proc_cwd_link
> > 
> > These expect that task_lock() keeps the task_struct::fs pointer
> > stable, and I don't see anything that prevents them operating on
> > kthreads.
> > 
> > You should probably ensure that remote accesses to task_struct::fs all
> > use task_struct::real_fs, just like how there are no remote accesses
> > to task_struct::cred - that makes logical sense since when userspace
> > queries a task's file system root/cwd/mounts, what the task is
> > currently doing probably shouldn't affect the result.
> > 
> > Then you could also change the locking rules such that task_struct::fs
> > has no locking while task_lock() protects modifications of, and remote
> > access to, task_struct::real_fs.
> 
> Yes, I have included those changes in the new revision I haven't yet sent out. :)

- umask access in task_state()
