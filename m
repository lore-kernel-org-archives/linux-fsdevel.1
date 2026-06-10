Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE238E8A6;
	Wed, 10 Jun 2026 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076802; cv=none; b=dKceKOgvNGRHijv2XeB59F0mjSh/Osd9oRHHkdceN7trif/VhPO8d9Z2uRUJYK1DG2LWT3+bkAStElvvP35ocy2Sch4qtiNJ7G+mX934Hgq05DiGtNkIGlbrKHG6Pmugnz5AaXa6jwhfl909ql+4na9atd5ntz/TeGxlR8r/D98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076802; c=relaxed/simple;
	bh=O3BOtgQvEnEks7r+KONtdJBG8cSIafCkwo2UFGR4+to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPW3DIaGzHqsAgkaubsWqwwPfEYB/4bCptJzQwk8K99t/6HNW34eW6qqCsanRpVKBlMSX7UuOC1SBCepnE+8KFtsAhI/p7bSwmPm3CqYDXf+6oDWrYgy8F1Zeb+bnrBPCDGli5r4kIwceA/4tNJaPF6z9yjwCErrLgCaKyamkB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAf3COoT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAf3COoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861A71F00893;
	Wed, 10 Jun 2026 07:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781076800;
	bh=fgrvow4AKGPgGHHD9WVvCv/hrN0GL8xf9zUdSYzNk+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kAf3COoTDHV+mqx5Wh2oqUnvA/64NWsNOFrHLiOZfWRz5ZhEEjyFB+/iWNoet9zLQ
	 IXqHjIv6oaeaQZTzGupA7414cRsFqYRUx+dg9/nJbIq76YHmHuD0DfBlCflTTik3u1
	 1496iG5u0KUuFNwsSjdDiivo0DefB4+yEWinQAx8dkUZ/ZY7G/FfvPHo0iA/NDOAeZ
	 HLVJkw3OukV6TlM5qU0ysyI8kMO7g+tSwle+J+Bhwd5kN+rxuYrsq8K49LFWPYmruB
	 x706L7LZitVWxydONti248IumYs7ps1YUqP2C4SFW6PhyUwvpQE52PD/BLm8QDHgWb
	 7a7bIj4LZFULg==
Date: Wed, 10 Jun 2026 09:33:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: AnonymeMeow <anonymemeow@gmail.com>, amir73il@gmail.com, 
	repnop@google.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: register event pid for pidfd reporting
Message-ID: <20260610-vorleben-vorverlegen-pinienzapfen-14267584859e@brauner>
References: <20260530013732.50811-1-anonymemeow@gmail.com>
 <20260530105117.45792-1-anonymemeow@gmail.com>
 <dolfs6j4x4thpgluglxhlepg34l5uvvxv2sjcmuao57bxnbtjb@urx5vgczxbup>
 <20260602-patzt-sturz-segen-f1f305d61b75@brauner>
 <i2gudjbai3vbyvhbbgcppt2vexnkkjqq35n53sjpx66i5k4lg3@5wu5hvzifpnc>
 <wudpprxslydgxcbqgteyykpqw5g7fubmjhjf23qbwuvbujmggh@ots2k4gqb7uh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <wudpprxslydgxcbqgteyykpqw5g7fubmjhjf23qbwuvbujmggh@ots2k4gqb7uh>

On Mon, Jun 08, 2026 at 02:30:45PM +0200, Jan Kara wrote:
> On Mon 08-06-26 11:27:01, Jan Kara wrote:
> > On Tue 02-06-26 15:50:19, Christian Brauner wrote:
> > > On Mon, Jun 01, 2026 at 05:24:36PM +0200, Jan Kara wrote:
> > > > On Sat 30-05-26 18:51:17, AnonymeMeow wrote:
> > > > > pidfd_prepare() may still fail if userspace reads the event after the
> > > > > task has been reaped and the pid has not been registered with pidfs.
> > > > > Register the event pid with pidfs when creating the fanotify event if
> > > > > pidfd reporting was requested, so pidfd_prepare() can later create a
> > > > > pidfd for the reaped task.
> > > > > 
> > > > > Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
> > > > 
> > > > So the two patches in this series so far look good to me. This patch looks
> > > > OK to me as well and since the overhead of allocation etc. is only once per
> > > 
> > > It's a kmem cache so should not matter at all...
> > > 
> > > > registered task, I think it's fine but let's wait a bit whether Christian
> > > > agrees this is what needs to be done.
> > > 
> > > pidfs_register_pid() can only fail with ENOMEM or if the task is already
> > > dead. The latter cannot happen because even for a non-empty thread group
> > > where the thread-group leader already exited but subthreads are still
> > > alive the thread-group leader cannot be reaped. So the only error here
> > > is ENOMEM which means we should defo fail this, imho.
> > > 
> > > And yes, I think this is worth doing. Because you get a persistent
> > > handle on the task that generated that event + all the exit information
> > > even if that thask has been reaped in the meantime. I'm pretty sure if
> > > you're using fanotify that's a rather huge win for apps that need it.
> > 
> > OK, thanks for opinion. So I've somewhat massaged the error handling in the
> > patch AnonymeMeow. Attached is what I currently have in my tree (testing
> > pending).
> 
> OK, reverted that for now since I've found further versions of the series
> in my huge inbox after a few days of vacation now :).

Fsck flooded inboxes, vacation is important. :)
