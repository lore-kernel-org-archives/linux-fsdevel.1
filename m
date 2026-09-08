Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631C33A9C4;
	Tue,  8 Sep 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889320; cv=none; b=INmf8ngYYFtcxYiI8qCyIcVLaU2JIXmZJpwKLBTE/TAxeL+pbY4971FdBEJcXwgeBJYQ1CVG9Ane7X4p30mYCpemP8FGatLisQP1Z0xK5fHNbq7M5HT94cIS9R8ZOfM5ozdj0X/QZHPDQS744m5Hk4G8cupRaWEHJ4b5DBEUjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889320; c=relaxed/simple;
	bh=H4ohnJrsJFMQaK2ZW36pVWRHCkO6lqkXMXCtOoZedb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K497VaH8bl0zsMOSicwOJJjs7LMjAwPCnY+3PTt5kew5hDLcyvYx6csrZrMHWx0VLxeVN3TeA1/vJny5iM7gV+XdVd2C2ISj3oBwdR2XU4T9SvaUXyJtw80jAzUGvx2vSTp51c6uAnEB4Mr76JEjXQWdY+0ZlVR1qrgyM0knBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVRHoa7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVRHoa7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A774A1F00A3A;
	Tue,  8 Sep 2026 17:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788889319;
	bh=b1X4r9h7hx5Jvlv1tWU2dbSGEQ+QGTJqKoDaL8tIDYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IVRHoa7giwOleSsS7rcxEpAstoTe1yxRPl+AGjbifWN/oCAWuX0mlavKseGe/+6/B
	 P5qQ8i41nfWHSb9snqKI+vWBALbQISqpRPbD39mvwfQmdm5UzNm+CXtJ2b9KMgJCs6
	 40DIq5MkAYN+Mh/p38ujjm0tG08Y26+u2axZq9HNNtJRQxZa7MxYPXvIrvd3Ipiaub
	 GwA1xJ+xxzJXpiMq2xHccrphTsAwN9K0bubi/Xzs1+TfIaN4Z08GWtoVCuXqX/1EeB
	 GYB+GdC7tpIYY+pgZARAp9Wwlmvs40vPHyRk2fpdnnenAFB6oTEcTdiuGvhw6xiBj5
	 MuMmu7EdVGuxQ==
Date: Tue, 8 Sep 2026 18:41:52 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Ye Liu <ye.liu@linux.dev>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	"David Hildenbrand (arm)" <david@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Ye Liu <liuye@kylinos.cn>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/8] fs: convert process/thread iterators to
 for_each_*_rcu
Message-ID: <aqBH54KFSylcLmIV@gremlin>
References: <20260904083001.553587-1-ye.liu@linux.dev>
 <20260904083001.553587-7-ye.liu@linux.dev>
 <662ade9d-d662-4f6f-869f-08c41da53170@p183>
 <aqBBFAiMG1NQITkz@gremlin>
 <16df546d-46b5-42c1-a8ca-24cde0051a97@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16df546d-46b5-42c1-a8ca-24cde0051a97@p183>

On Tue, Sep 08, 2026 at 08:26:54PM +0300, Alexey Dobriyan wrote:
> On Tue, Sep 08, 2026 at 06:10:17PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Sep 08, 2026 at 07:45:15PM +0300, Alexey Dobriyan wrote:
> > > On Fri, Sep 04, 2026 at 04:29:58PM +0800, Ye Liu wrote:
> > > > --- a/fs/proc/base.c
> > > > +++ b/fs/proc/base.c
> > > > @@ -1160,8 +1160,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> > > >  	if (mm) {
> > > >  		struct task_struct *p;
> > > >
> > > > -		rcu_read_lock();
> > > > -		for_each_process(p) {
> > > > +		for_each_process_rcu(p) {
> > > >  			if (same_thread_group(task, p))
> > > >  				continue;
> > > >
> > > > @@ -1177,7 +1176,6 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> > > >  			}
> > > >  			task_unlock(p);
> > > >  		}
> > > > -		rcu_read_unlock();
> > > >  		mmdrop(mm);
> > > >  	}
> > > >  err_unlock:
> > >
> > > What's going on here?
> > > Now it's RCU unlock after mmdrop().
> >
> > No it's not, scoped_guard() is scoped to the for_each_process_rcu() block which
> > ends before mmdrop(), i.e. the exact same scope as before.
> >
> > That closing '}' is attached to the if (mm).
>
> OK.
>
> I think naming (and macro) are misguided:
> * _rcu means "use under RCU section opened elsewhere",
>   this one is "I open and close RCU section myself".

You're replying to a v1 of a series that has a v2 which changes the naming.

>
> * not every 2 lines should be combined into new interface.

Nobody is suggesting every 2 lines should be combined into a new interface.

They're suggesting that explicitly tying lock lifetime to block scope is a
really good idea.

And having debugged lots of locking issues, I agree.

Anyway the v2 is at:

https://lore.kernel.org/all/20260907081334.1152889-1-ye.liu@linux.dev/


--
Cheers, Lorenzo
