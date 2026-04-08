Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44D2441A6;
	Wed,  8 Apr 2026 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630351; cv=none; b=FMkYsNtdg5M4KsBaBxcH6EezU9VB56npMYssNV9941+VKW07UWrJ87/a+HuO1WtrdGDxiPUyFTHUqE96ex00SLSgepprbWuOfWY4AZKllckMYYphhsquHaHt2eH4wI/J2ry2jR5CytZ5GDrcvtuRIQvWkQWU4pQzEx3Z4DGDCCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630351; c=relaxed/simple;
	bh=TuFPzZPLh7gl4lgbHWUOzSdZxb2SuVdzSbwhmvGnV+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRrXjqZUEb1SfEIYs03KTPEvanl4g27igrDhwtNlcpz+DKjVteNf9V3aHcJ+k9HlGS2LGkuRgkStqKZGYAeA7ioWcjGrE5S3NgqhYSn8ItUuBbkg9/F9XMgaA9FiCE2gpxmONcGqx2cgl0TLHB9Na6y6qpeHQ0lCaoZvYHM/t+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CJk0qk7T; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CJk0qk7T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+MhzxVPKGLSawao6MgKplZ6P/pBuDnj3Ocp8nmtVtk4=; b=CJk0qk7Th9C9ovQJI9rPwUZjbF
	uQv2mQ50atcwwYu6eAwHayVzKr1LrOfBJS7rfT4Ryoa8CxHtQMhiZTBoV9/f3N+R9Ry4SzYIGaawe
	qtD9PHgUwTjddTGScVyxUf2wTP27GWzGDVqD/tvDoOD31XLlaEOVyC6mqsayO2s54FYv0xZtqdQVS
	8cAXE0QgpPIEeUuRqfCEL8iVr+g7ddAgFeFitrbmOPuiIxXYv4iKGyNkAvYobxREu47CuR0qXOgw/
	sqr6q+8so1pXv7um9oQnxz6ye6EQGgO+UPwWnF34oQ52MlEwIfbVdgODYfLpeTEaZ8JqhKR9hoJme
	r4dkSZig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wAMcl-0000000H4q5-2Vm2;
	Wed, 08 Apr 2026 06:42:51 +0000
Date: Wed, 8 Apr 2026 07:42:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: warn when a dentry is freed with a non-empty
 ->d_lru
Message-ID: <20260408064251.GE3836593@ZenIV>
References: <20260406-dcache-warn-v1-1-c665efbc005f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406-dcache-warn-v1-1-c665efbc005f@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 06, 2026 at 12:44:13PM -0400, Jeff Layton wrote:
> We've had a number of panics that seem to occur on hosts with heavy
> process churn. The symptoms are a panic when invalidating /proc entries
> as a task is exiting:
> 
> queued_spin_lock_slowpath+0x153/0x270
> shrink_dentry_list+0x11d/0x220
> shrink_dcache_parent+0x68/0x110
> d_invalidate+0x90/0x170
> proc_invalidate_siblings_dcache+0xc8/0x140
> release_task+0x41b/0x510
> do_exit+0x3d8/0x9d0
> do_group_exit+0x7d/0xa0
> get_signal+0x2a9/0x6a0
> arch_do_signal_or_restart+0x1a/0x1c0
> syscall_exit_to_user_mode+0xe6/0x1c0
> do_syscall_64+0x74/0x130
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> The problem appears to be a UAF. It's freeing a shrink list of
> dentries, but one of the dentries on it has already been freed.

That, or dentry pointer passed to shrink_dcache_parent() is a
complete garbage - e.g. due to struct pid having already been
freed.  Might make sense to try and get a crash dump and poke
around...

Which kernels have you seen it on?
