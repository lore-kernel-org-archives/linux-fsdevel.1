Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5BC43FD06;
	Fri,  4 Sep 2026 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513768; cv=none; b=HIUUPypPSp5VBZzi8i1Ot+9b2l2YVjYxz2pdtzqHNSsfiuPqppR82ggA77ndl8+AcPnWs7x+8MY9b18aBBfO12ZzpUSta9ZMoeJ8B1V14w9x0c4T1AKXOohm8Wdk23J/lfGD8KXu6ibm/z3/sZ2/E9/OMe8fDxSrdqydcXmP150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513768; c=relaxed/simple;
	bh=GKU6pGPgWNvvIDBVwgi9urL1ptmWQbWY5sLdsyVOTlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKwDhJtZnT+R5SIjFUGbMSzKcEpfMpD2SqxWdoLAQIUUkhVoOhYz5y/V3RjzRAedY9wWhtsZidT7gWdw7DiH6rArv9+5rZKk9zQT6irZWgKlwRMn0bKqnb3pNVfrthHTEkwJA/hCk4eZkZhzm2ZBOep8CUn3PK3h8137dwLbCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nnyf4jhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nnyf4jhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8B41F00A3D;
	Fri,  4 Sep 2026 09:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788513758;
	bh=vID5EID0YCuBYaR+0VVIol8Ipj98elZ+LfLBM7mQ4Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nnyf4jhAsDMK/uWU4FAVFgX/Zu05soB7mn0uEllItoL9EGzcoFkhR7TzfhQxMI/C7
	 PrI0J+WMwxdEwdZBaSO8kI5A3dY/R4gxSGRmJJ2VYZ7zLaTky6XWqHopWy/la9NiJi
	 HeIGvZCN7ifYWk3Fqgqm8wyc1H4/UHxRS7jIyTpSSZyDML1sIoaGbH2hV0Q9jjP9O9
	 2Osol+AwPNUQzgbwnFMH63NJ7OjYxUjJzHrnmyHxt68ySy7saEvwBU2s5GkSXNvVUI
	 BL0jF61IeVv3jATQP5JsUZ4qezVF7hRJn0W68gTSPwyhnWuB5f4UlSoBnOufu4BjFt
	 aunVolAOt+vvA==
Date: Fri, 4 Sep 2026 10:22:32 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	"David Hildenbrand (arm)" <david@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Ye Liu <liuye@kylinos.cn>, 
	Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, 
	Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/8] fs: convert process/thread iterators to
 for_each_*_rcu
Message-ID: <apqMmyhslEFx8EjT@gremlin>
References: <20260904083001.553587-1-ye.liu@linux.dev>
 <20260904083001.553587-7-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904083001.553587-7-ye.liu@linux.dev>

Please cc everybody on every patch in the series :) it makes it incredible hard
for me to see context otherwise.

I can already see a comment I'd like to leave on another patch in the series but
it's a total pain for me go retrieve that to do it.

And I worry about acking one bit only to find out a horrible flaw in another
part :P

Can you please make sure to do that on any respin?...

On Fri, Sep 04, 2026 at 04:29:58PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs combined
> with for_each_process() and for_each_process_thread() loops in fs/
> with the for_each_*_rcu() macros.

Probably worth mentioning that they hold the RCU lock in a scoped guard over the
operation.

>
> No functional change.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

In general it looks reasonable to me, but I wonder if you're correctly including
linux/cleanup.h to have the scope guard available...

Anyway can check that on respin with the right cc ;)

> ---
>  fs/proc/base.c        | 4 +---
>  fs/resctrl/rdtgroup.c | 8 ++------
>  2 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 6a39de424f62..da36ba73dc17 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1160,8 +1160,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)

Side-note - I wonder if this really belongs in mm/oom_kill.c? Seems really odd
to have it here.

>  	if (mm) {
>  		struct task_struct *p;
>
> -		rcu_read_lock();
> -		for_each_process(p) {
> +		for_each_process_rcu(p) {
>  			if (same_thread_group(task, p))
>  				continue;
>
> @@ -1177,7 +1176,6 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  			}
>  			task_unlock(p);
>  		}
> -		rcu_read_unlock();
>  		mmdrop(mm);
>  	}
>  err_unlock:
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 5dcbb0a964e8..3f96d21b84ab 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -709,14 +709,12 @@ int rdtgroup_tasks_assigned(struct rdtgroup *r)
>
>  	lockdep_assert_held(&rdtgroup_mutex);
>
> -	rcu_read_lock();
> -	for_each_process_thread(p, t) {
> +	for_each_process_thread_rcu(p, t) {
>  		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
>  			ret = 1;
>  			break;
>  		}
>  	}
> -	rcu_read_unlock();
>
>  	return ret;
>  }
> @@ -826,15 +824,13 @@ static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
>  	struct task_struct *p, *t;
>  	pid_t pid;
>
> -	rcu_read_lock();
> -	for_each_process_thread(p, t) {
> +	for_each_process_thread_rcu(p, t) {
>  		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
>  			pid = task_pid_vnr(t);
>  			if (pid)
>  				seq_printf(s, "%d\n", pid);
>  		}
>  	}
> -	rcu_read_unlock();
>  }
>
>  static int rdtgroup_tasks_show(struct kernfs_open_file *of,
> --
> 2.25.1
>

--
Cheers, Lorenzo
