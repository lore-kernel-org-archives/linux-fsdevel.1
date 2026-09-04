Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B764457A3;
	Fri,  4 Sep 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514808; cv=none; b=sDTLNy5Qi1EMoHlXDAUxgwIDIM7VeYVSzpI4vEmgfqPt3uhbEHcqxW+cWZCWGvbvn8VtYUONSMI2VOfbu1DfdN//HzKfK+wG+9fsk5CIsckZ3HmVPElrlc9BLwzscqJO805Ipiz9gCaMfdfG1KUjGnT43SF4MYTasUzNMpqTjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514808; c=relaxed/simple;
	bh=8cq1SyG4CiKJy2jqYIRh9FXnJfo/t8IzNgo/+dKlNS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4tyv5T89XiWd0zbw/KpwBBw/5KKjbWBzww477HKHl1kozyAU3ehcCIvDi0C/BcvV/mzT6JDN98q+VbJ7KyXVBo69gjkdWch7art9Y/15P4WEgrGHqNVq78hW50Gn/reWNE/+Nxi9+VX5AnTqSOvTegG5BwhBGTwnb3HaUgXAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDhS9etO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDhS9etO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDBE1F00A3D;
	Fri,  4 Sep 2026 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788514806;
	bh=irtB4Gphur0hq/oa9u72227e10mQv5+zJ7j9flQSWKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CDhS9etOg+i38SyDTYcp5f0Q79Eb+8hx9Zh53eDFMB/7tj3ZjjB+qaPd6T9w1Z7rg
	 PMNhFVE8akcng0zh8eKSZBLqj54pag+ihQFA0SuLayr6bQVNV3Dpb9pYOtuhiJJc72
	 Q9qQ/GTUOiSLIZXWih69N+pFbZz2J15NN4ApLyUOQpw/5+LudOT6zynLohfB5kVhsL
	 JWZHpw7MeTNeH+yP3YOCRjdITc0ILwlx3/vA2tkvu/AcG8YtBSDBoZodtlWj0wPKnA
	 2p2LsHQ9kOkEFWb3KKyE3LqBxt8HVcevJSeM39Zc8gPRlGYlM/4AwxUMKu1NB2m8QL
	 JG2xsT8NMrnKQ==
Date: Fri, 4 Sep 2026 11:40:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Daehyeon Ko <4ncienth@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com, syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] exit: hold a reference to thread_pid across
 proc_flush_pid
Message-ID: <20260904-absehbar-dissident-rackern-b030022aa84e@brauner>
References: <20260831001221.3755948-1-4ncienth@gmail.com>
 <apWWsqOzJny1v4ab@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apWWsqOzJny1v4ab@redhat.com>

On Mon, Aug 31, 2026 at 04:58:58PM +0200, Oleg Nesterov wrote:
> On 08/31, Daehyeon Ko wrote:
> >
> > Commit 0a36bad01731 ("release_task: kill the no longer needed
> > get/put_pid(thread_pid)") removed the reference around proc_flush_pid().
> > It assumed that free_pids(post.pids) at the end of release_task() would
> > keep thread_pid alive until then.
> >
> > That assumption is wrong.  __change_pid() only records a detached PID in
> > post.pids when pid_has_task() is false for every PIDTYPE.  If another task
> > still uses the exiting task's PID as its process group or session ID,
> > __unhash_process() removes the exiting task's PIDTYPE_PID link but leaves
> > the PID out of post.pids.  release_task() therefore holds no reference to
> > it after dropping tasklist_lock.
> >
> > The other task can then remove the remaining PIDTYPE links.  Its
> > free_pids() call schedules delayed_put_pid(), and the RCU callback can free
> > the PID before the first release_task() reaches proc_flush_pid().
> 
> Much better, thanks. The comment above get_pid(task_pid(p)) looks better too.
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 
> 
> > A tested source reproducer is available privately on request.  No
> > controlled read or write, information leak, or privilege escalation is
> > claimed.  The mainline patch applies directly to v6.19.y and newer;
> > v6.16.y through v6.18.y need a context-adjusted backport.
> 
> Up to you and Christian (I am hoping we can take your fix), but I think

Snatching it up, thanks!
