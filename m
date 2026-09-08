Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82777594819;
	Tue,  8 Sep 2026 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887425; cv=none; b=dq1xCJ2BoMzFV6cLI0v0n0c3BcXZuVhJOcCccqS22/Z3HFsBMRjskYrMltg75/Owd257PXtZHAuQMIJFW4IFrgiMU8aZIUycBGTFj0tGW1BMtWWROR784X8QshhlntfhY6NyOZ3PzHqG7fqAbq11z8RU4o+wsonYUhhx7I5Zahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887425; c=relaxed/simple;
	bh=oM8MJEueButtTgSqwWUVnv5geNPCevq/+X+xQxkr7BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sATmGhe2SMis1b4X47E/dmr2g4E/Qj3L0B/ED5zFbAPKdD1NiZu7EfT+DyQAXcnqUAluNAutv2vOimQfrdseG6fqz8lFOxZ31oxyZmWvF2MDy0b/pBxqPGAhhiao1VYhPjo2g+lVH+GZoPvt+pBvnyizxqO9mYBaZX8ISASwrzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5oiwr4R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5oiwr4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A091F00A3A;
	Tue,  8 Sep 2026 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788887424;
	bh=QBX/pKxFcPxpJofmfbbuTaHd+mrutz9WoIjUgUoP3cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n5oiwr4RomhJv7hXMRp0RL2vzze64B5EHzRITdpRirryQ0HcuqLfw3H51QSopX/wL
	 YWrmXNDwx+2bKNTHhVfdrd+hhF2Z3xnB9iv/yCXoQTiM5D9ZSWtFKY1F9Hd9dz8Q4L
	 u1/wR73xB3JNKVqF+DUPJIK97c6ERiwm5TD0MOyeQrrBHDKD76qfJcbjRx8c5yvBpE
	 VuR08MQ5bm70WIvto6ZUDHvn4X9b5q4Zj3qWxcJaBXkDLMlmNUrpVn2Y3b4SQZIqFU
	 SjplWejYr3WPQg+ffoAKJ4aip2YsIAB9dlGae+h2xW+wOFKz9t+9PV6WFRqNe1HKum
	 tUlnTkNmXbdnw==
Date: Tue, 8 Sep 2026 18:10:17 +0100
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
Message-ID: <aqBBFAiMG1NQITkz@gremlin>
References: <20260904083001.553587-1-ye.liu@linux.dev>
 <20260904083001.553587-7-ye.liu@linux.dev>
 <662ade9d-d662-4f6f-869f-08c41da53170@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662ade9d-d662-4f6f-869f-08c41da53170@p183>

On Tue, Sep 08, 2026 at 07:45:15PM +0300, Alexey Dobriyan wrote:
> On Fri, Sep 04, 2026 at 04:29:58PM +0800, Ye Liu wrote:
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -1160,8 +1160,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> >  	if (mm) {
> >  		struct task_struct *p;
> >
> > -		rcu_read_lock();
> > -		for_each_process(p) {
> > +		for_each_process_rcu(p) {
> >  			if (same_thread_group(task, p))
> >  				continue;
> >
> > @@ -1177,7 +1176,6 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> >  			}
> >  			task_unlock(p);
> >  		}
> > -		rcu_read_unlock();
> >  		mmdrop(mm);
> >  	}
> >  err_unlock:
>
> What's going on here?
> Now it's RCU unlock after mmdrop().

No it's not, scoped_guard() is scoped to the for_each_process_rcu() block which
ends before mmdrop(), i.e. the exact same scope as before.

That closing '}' is attached to the if (mm).

>
> These scoped guards kind of suck unless you allow infinite line length.
>
> 	A

--
Cheers, Lorenzo
