Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169C33556B
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970341; cv=none; b=JPbd4RvyTSfPoqn73a8hmxHm8+PlTG8Z7d2APQRgwX4snHU8/DmfgMZygc+3F3vvb+OXVdIx/3asnbRRSTv3vbtYTL1s/W+oOzDVmMX4OOuEc7LR6l7Rx0tzRE8GlSegqtNVC6jMOgdKkdmoYVQClFWpCA90OhyS+8/fiGUYjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970341; c=relaxed/simple;
	bh=XpZYgAKF6Bfy79RxlkKPvcOO0II0yYMHazQzvE59K6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2VfGz5kqHJInD+cpHp6sTgqJZf22z+un6ZinuHw40qTATCV7z1Cg2V8XfYYBTlLFhvjaU4k/i29RLrL+Hxo3a8krvSlsKHteE4Pyv24wNUUt21N/7PyAxu96CbW6tBnEfdzdkYx18HeTBDKHVMDV9AjLwe6q48oPpu+1woU5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I4q+bTV0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I4q+bTV0"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso50434145e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791970333; x=1792575133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qbp1OaXo+QOhXfEK2yTqfOOSMPB/aU27i+I9ooebTqo=;
        b=I4q+bTV0w61+lNEBRyb2T7sPDBJg4/3FLkQbbbx+7LYtPkxNQRd7IDsWq1LWP41wFF
         34ygerVeTcPw9zctqCauUbprahmMPWKzcYJNb64pW8FDLjc0ILmvshkWS0h1yk/SJ97w
         3illbiN/ZoxUGorSJTRpljTQy25x9zVJ1X+X4R0BikZfH9MVk+YUCysYg8LR+O0CVVQX
         Ic+zKeq70uh2WLDyzc3G339E/i9rqUTK6JX6tHCWhJ/zO5Vmui2QIXLOZyXoAOV29D25
         hHXim7bwdWZnT9m4nESBiswtvsPW3aE4FH+b+tCD1u8ArMQlQskIY0Wh0zqLWBWzAYF5
         oSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970333; x=1792575133;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qbp1OaXo+QOhXfEK2yTqfOOSMPB/aU27i+I9ooebTqo=;
        b=gEbPwMsQxOXDzqTx7eNKLwjHkKitQPqIBTb7Qa2pMB/vYmeZTlWw2y8eu5wJ4XVT/P
         rkk7N5gZlWCTfv9YFfpPHplEx6P4g0PbpcTT23QXEap3BARk9KUR0mtD7SXia6VTxUPa
         3EAxuUfOVdSRfUZcKLBXLtu+wbDC4qRxx57tlhRCUhhySTrJ3CEwUA7LzfBLwLOruO78
         Ays+IlhLyLqtflErpxRQnI7plSVHfYkgde8Td7xHvs2scLqhxWOHSoLR7d9RwhIaTJRw
         7JHQs1I3/wU0kulgkYUTJJJPKtNFS4Juv2pTxsvErAFL/CwAl7muMJjrH6B9uujhE/jV
         PB9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxdw+1gKNpklv397SoTubKAZ9t2Pu15R1a6BVDgklUXwGZGgEx1hjaagwG9xlZZawnsKetM41YlMa41N02U@vger.kernel.org
X-Gm-Message-State: AFq9FYJCC3c6FaYMzrUqkfuaFQHEn0zVSNunPdrnHnfuJR4hu5GEYkEz
	qhpa1VPeQ9Ep0g7GHEdzx7L63AyR1sINl85b/CkhUbhHG/iPV4asOOBkPEhu4UbUZNw=
X-Gm-Gg: AYBFou3FimCNnIzTZ4Ix6Kf8cCw2USjg5C593ifqS0xbM+vDFvDA4gLC2lGC/lSCqP3
	X1yyayWhmmaN2Z7h4ZLEJ6hWKEx2XjI8WXYjXfGfrOGI3iIZWV1Az6SclcjfgVon7sHAKoJCpoG
	70fv326oNtwgpUrRn2nLbqNQgx351m6A6+YtHcLFhoodsI6dtJXl6yOevDfbHdyW9HH+6OE4FXW
	5UXF5pBtupl8Ac7EK7B9eVXG+C9zFZZpJI6WIIo3UkVAXGZVZ+ddKWV8xjMILx2pNIiO2lzNfRU
	FqJ66eBErZjteJcLN2yK/zWegMd4/P+IA6DST9TB5OhDmOFnb1lHXedqY4wu6sriRBhBmxwuYqd
	bgbm0a3LHFj8EcuYpVtIWD9eF055XgxRgovddjVbK4aSzUj4cfwJx8u3F7EMNrcPx4KtYvxB7w1
	srYa8BrV3eY1ESPz+qHsLc90sk3zfwfPoS4gKRRkXfuPoPimr5BSatJTLnYYkxxNZ3XRki7OcSD
	NXv3IcldLUI
X-Received: by 2002:a05:600c:8a09:20b0:4a1:9c98:b9b8 with SMTP id 5b1f17b1804b1-4a19c98c153mr160639475e9.11.1791970333205;
        Wed, 14 Oct 2026 02:32:13 -0700 (PDT)
Received: from localhost (109-81-25-183.rct.o2.cz. [109.81.25.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaaebsm10999272f8f.14.2026.10.14.02.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:32:12 -0700 (PDT)
Date: Wed, 14 Oct 2026 11:32:11 +0200
From: Michal Hocko <mhocko@suse.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Ye Liu <liuye@kylinos.cn>
Subject: Re: [PATCH] proc: Move OOM-related procfs code to fs/proc/oom.c
Message-ID: <as9MG_BtepLV6DsC@tiehlicka>
References: <20261014-oom_procfs-v1-1-f2d75e73571e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-oom_procfs-v1-1-f2d75e73571e@linux.dev>

On Wed 14-10-26 16:54:12, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> fs/proc/base.c is a large file (~3700 lines) handling all per-process
> procfs entries. The OOM score, oom_adj, and oom_score_adj interface
> code is self-contained and has no dependencies on other parts of
> base.c, so move it into a dedicated fs/proc/oom.c following the same
> pattern as fs/proc/fd.c and fs/proc/task_mmu.c.
> 
> This makes both files easier to read and keeps OOM-related procfs
> entries together in one place.

Are there plans to separate other functionality or is this one off
thing?
In general I am not against of moving stuff to more specialized files.
An obvious downside is a review as it is quite easy to overlook a subtle
change when moving so much code. Something worth undertaking if there
is a bigger goal. Not so sure if this is just a one of and fs/proc/base.c
still keeps other random stuff in.

> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>  MAINTAINERS        |   1 +
>  fs/proc/Makefile   |   1 +
>  fs/proc/base.c     | 232 -------------------------------------------------
>  fs/proc/internal.h |   8 ++
>  fs/proc/oom.c      | 249 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 259 insertions(+), 232 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1da3623e77ce..4b1c13a65136 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17676,6 +17676,7 @@ R:	David Rientjes <rientjes@google.com>
>  R:	Shakeel Butt <shakeel.butt@linux.dev>
>  L:	linux-mm@kvack.org
>  S:	Maintained
> +F:	fs/proc/oom.c
>  F:	include/linux/oom.h
>  F:	include/trace/events/oom.h
>  F:	include/uapi/linux/oom.h
> diff --git a/fs/proc/Makefile b/fs/proc/Makefile
> index 27e2b26b2d42..68e65866b5df 100644
> --- a/fs/proc/Makefile
> +++ b/fs/proc/Makefile
> @@ -21,6 +21,7 @@ proc-y += interrupts.o
>  endif
>  proc-y	+= loadavg.o
>  proc-y	+= meminfo.o
> +proc-y	+= oom.o
>  proc-y	+= stat.o
>  proc-y	+= uptime.o
>  proc-y	+= util.o
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 8c04fcd436d2..26ccc05a50ff 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -80,7 +80,6 @@
>  #include <linux/audit.h>
>  #include <linux/poll.h>
>  #include <linux/nsproxy.h>
> -#include <linux/oom.h>
>  #include <linux/elf.h>
>  #include <linux/pid_namespace.h>
>  #include <linux/user_namespace.h>
> @@ -99,7 +98,6 @@
>  #include <linux/cn_proc.h>
>  #include <linux/ksm.h>
>  #include <uapi/linux/lsm.h>
> -#include <trace/events/oom.h>
>  #include "internal.h"
>  #include "fd.h"
>  
> @@ -580,28 +578,6 @@ static const struct file_operations proc_lstats_operations = {
>  
>  #endif
>  
> -static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
> -			  struct pid *pid, struct task_struct *task)
> -{
> -	unsigned long totalpages = totalram_pages() + total_swap_pages;
> -	unsigned long points = 0;
> -	long badness;
> -
> -	badness = oom_badness(task, totalpages);
> -	/*
> -	 * Special case OOM_SCORE_ADJ_MIN for all others scale the
> -	 * badness value into [0, 2000] range which we have been
> -	 * exporting for a long time so userspace might depend on it.
> -	 */
> -	if (badness != LONG_MIN)
> -		points = (OOM_SCORE_ADJ_MAX +
> -			  badness * OOM_SCORE_ADJ_MAX / (long)totalpages) * 2 / 3;
> -
> -	seq_printf(m, "%lu\n", points);
> -
> -	return 0;
> -}
> -
>  struct limit_names {
>  	const char *name;
>  	const char *unit;
> @@ -1115,214 +1091,6 @@ static const struct file_operations proc_auxv_operations = {
>  	.release	= mem_release,
>  };
>  
> -static ssize_t oom_adj_read(struct file *file, char __user *buf, size_t count,
> -			    loff_t *ppos)
> -{
> -	struct task_struct *task = get_proc_task(file_inode(file));
> -	char buffer[PROC_NUMBUF];
> -	int oom_adj = OOM_ADJUST_MIN;
> -	size_t len;
> -
> -	if (!task)
> -		return -ESRCH;
> -	if (task->signal->oom_score_adj == OOM_SCORE_ADJ_MAX)
> -		oom_adj = OOM_ADJUST_MAX;
> -	else
> -		oom_adj = (task->signal->oom_score_adj * -OOM_DISABLE) /
> -			  OOM_SCORE_ADJ_MAX;
> -	put_task_struct(task);
> -	if (oom_adj > OOM_ADJUST_MAX)
> -		oom_adj = OOM_ADJUST_MAX;
> -	len = snprintf(buffer, sizeof(buffer), "%d\n", oom_adj);
> -	return simple_read_from_buffer(buf, count, ppos, buffer, len);
> -}
> -
> -static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> -{
> -	struct mm_struct *mm = NULL;
> -	struct task_struct *task;
> -	int err = 0;
> -
> -	task = get_proc_task(file_inode(file));
> -	if (!task)
> -		return -ESRCH;
> -
> -	mutex_lock(&oom_adj_mutex);
> -	if (legacy) {
> -		if (oom_adj < task->signal->oom_score_adj &&
> -				!capable(CAP_SYS_RESOURCE)) {
> -			err = -EACCES;
> -			goto err_unlock;
> -		}
> -		/*
> -		 * /proc/pid/oom_adj is provided for legacy purposes, ask users to use
> -		 * /proc/pid/oom_score_adj instead.
> -		 */
> -		pr_warn_once("%s (%d): /proc/%d/oom_adj is deprecated, please use /proc/%d/oom_score_adj instead.\n",
> -			  current->comm, task_pid_nr(current), task_pid_nr(task),
> -			  task_pid_nr(task));
> -	} else {
> -		if ((short)oom_adj < task->signal->oom_score_adj_min &&
> -				!capable(CAP_SYS_RESOURCE)) {
> -			err = -EACCES;
> -			goto err_unlock;
> -		}
> -	}
> -
> -	/*
> -	 * Make sure we will check other processes sharing the mm if this is
> -	 * not vfrok which wants its own oom_score_adj.
> -	 * pin the mm so it doesn't go away and get reused after task_unlock
> -	 */
> -	if (!task->vfork_done) {
> -		struct task_struct *p = find_lock_task_mm(task);
> -
> -		if (p) {
> -			if (mm_flags_test(MMF_MULTIPROCESS, p->mm)) {
> -				mm = p->mm;
> -				mmgrab(mm);
> -			}
> -			task_unlock(p);
> -		}
> -	}
> -
> -	task->signal->oom_score_adj = oom_adj;
> -	if (!legacy && has_capability_noaudit(current, CAP_SYS_RESOURCE))
> -		task->signal->oom_score_adj_min = (short)oom_adj;
> -	trace_oom_score_adj_update(task);
> -
> -	if (mm) {
> -		struct task_struct *p;
> -
> -		rcu_read_lock();
> -		for_each_process(p) {
> -			if (same_thread_group(task, p))
> -				continue;
> -
> -			/* do not touch kernel threads or the global init */
> -			if (p->flags & PF_KTHREAD || is_global_init(p))
> -				continue;
> -
> -			task_lock(p);
> -			if (!p->vfork_done && process_shares_mm(p, mm)) {
> -				p->signal->oom_score_adj = oom_adj;
> -				if (!legacy && has_capability_noaudit(current, CAP_SYS_RESOURCE))
> -					p->signal->oom_score_adj_min = (short)oom_adj;
> -			}
> -			task_unlock(p);
> -		}
> -		rcu_read_unlock();
> -		mmdrop(mm);
> -	}
> -err_unlock:
> -	mutex_unlock(&oom_adj_mutex);
> -	put_task_struct(task);
> -	return err;
> -}
> -
> -/*
> - * /proc/pid/oom_adj exists solely for backwards compatibility with previous
> - * kernels.  The effective policy is defined by oom_score_adj, which has a
> - * different scale: oom_adj grew exponentially and oom_score_adj grows linearly.
> - * Values written to oom_adj are simply mapped linearly to oom_score_adj.
> - * Processes that become oom disabled via oom_adj will still be oom disabled
> - * with this implementation.
> - *
> - * oom_adj cannot be removed since existing userspace binaries use it.
> - */
> -static ssize_t oom_adj_write(struct file *file, const char __user *buf,
> -			     size_t count, loff_t *ppos)
> -{
> -	char buffer[PROC_NUMBUF] = {};
> -	int oom_adj;
> -	int err;
> -
> -	if (count > sizeof(buffer) - 1)
> -		count = sizeof(buffer) - 1;
> -	if (copy_from_user(buffer, buf, count)) {
> -		err = -EFAULT;
> -		goto out;
> -	}
> -
> -	err = kstrtoint(strstrip(buffer), 0, &oom_adj);
> -	if (err)
> -		goto out;
> -	if ((oom_adj < OOM_ADJUST_MIN || oom_adj > OOM_ADJUST_MAX) &&
> -	     oom_adj != OOM_DISABLE) {
> -		err = -EINVAL;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Scale /proc/pid/oom_score_adj appropriately ensuring that a maximum
> -	 * value is always attainable.
> -	 */
> -	if (oom_adj == OOM_ADJUST_MAX)
> -		oom_adj = OOM_SCORE_ADJ_MAX;
> -	else
> -		oom_adj = (oom_adj * OOM_SCORE_ADJ_MAX) / -OOM_DISABLE;
> -
> -	err = __set_oom_adj(file, oom_adj, true);
> -out:
> -	return err < 0 ? err : count;
> -}
> -
> -static const struct file_operations proc_oom_adj_operations = {
> -	.read		= oom_adj_read,
> -	.write		= oom_adj_write,
> -	.llseek		= generic_file_llseek,
> -};
> -
> -static ssize_t oom_score_adj_read(struct file *file, char __user *buf,
> -					size_t count, loff_t *ppos)
> -{
> -	struct task_struct *task = get_proc_task(file_inode(file));
> -	char buffer[PROC_NUMBUF];
> -	short oom_score_adj = OOM_SCORE_ADJ_MIN;
> -	size_t len;
> -
> -	if (!task)
> -		return -ESRCH;
> -	oom_score_adj = task->signal->oom_score_adj;
> -	put_task_struct(task);
> -	len = snprintf(buffer, sizeof(buffer), "%hd\n", oom_score_adj);
> -	return simple_read_from_buffer(buf, count, ppos, buffer, len);
> -}
> -
> -static ssize_t oom_score_adj_write(struct file *file, const char __user *buf,
> -					size_t count, loff_t *ppos)
> -{
> -	char buffer[PROC_NUMBUF] = {};
> -	int oom_score_adj;
> -	int err;
> -
> -	if (count > sizeof(buffer) - 1)
> -		count = sizeof(buffer) - 1;
> -	if (copy_from_user(buffer, buf, count)) {
> -		err = -EFAULT;
> -		goto out;
> -	}
> -
> -	err = kstrtoint(strstrip(buffer), 0, &oom_score_adj);
> -	if (err)
> -		goto out;
> -	if (oom_score_adj < OOM_SCORE_ADJ_MIN ||
> -			oom_score_adj > OOM_SCORE_ADJ_MAX) {
> -		err = -EINVAL;
> -		goto out;
> -	}
> -
> -	err = __set_oom_adj(file, oom_score_adj, false);
> -out:
> -	return err < 0 ? err : count;
> -}
> -
> -static const struct file_operations proc_oom_score_adj_operations = {
> -	.read		= oom_score_adj_read,
> -	.write		= oom_score_adj_write,
> -	.llseek		= default_llseek,
> -};
> -
>  #ifdef CONFIG_AUDIT
>  #define TMPBUFLEN 11
>  static ssize_t proc_loginuid_read(struct file * file, char __user * buf,
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index df873df9afc5..b72a2bd604ed 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -238,6 +238,14 @@ static inline int folio_average_page_mapcount(struct folio *folio)
>  	/* ... but return at least 1. */
>  	return max_t(int, avg + entire_mapcount, 1);
>  }
> +/*
> + * oom.c
> + */
> +int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
> +		   struct pid *pid, struct task_struct *task);
> +extern const struct file_operations proc_oom_adj_operations;
> +extern const struct file_operations proc_oom_score_adj_operations;
> +
>  /*
>   * array.c
>   */
> diff --git a/fs/proc/oom.c b/fs/proc/oom.c
> new file mode 100644
> index 000000000000..5f22ec4a4a6e
> --- /dev/null
> +++ b/fs/proc/oom.c
> @@ -0,0 +1,249 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * OOM-related procfs entries
> + *
> + * This file handles the OOM score, oom_adj, and oom_score_adj interfaces
> + * in /proc/<pid>/.
> + */
> +
> +#include <linux/proc_fs.h>
> +#include <linux/oom.h>
> +#include <linux/seq_file.h>
> +#include <linux/capability.h>
> +#include <linux/mm.h>
> +#include <linux/swap.h>
> +#include <linux/sched/signal.h>
> +#include <linux/pid_namespace.h>
> +#include <trace/events/oom.h>
> +
> +#include "internal.h"
> +
> +int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
> +		   struct pid *pid, struct task_struct *task)
> +{
> +	unsigned long totalpages = totalram_pages() + total_swap_pages;
> +	unsigned long points = 0;
> +	long badness;
> +
> +	badness = oom_badness(task, totalpages);
> +	/*
> +	 * Special case OOM_SCORE_ADJ_MIN for all others scale the
> +	 * badness value into [0, 2000] range which we have been
> +	 * exporting for a long time so userspace might depend on it.
> +	 */
> +	if (badness != LONG_MIN)
> +		points = (OOM_SCORE_ADJ_MAX +
> +			  badness * OOM_SCORE_ADJ_MAX / (long)totalpages) * 2 / 3;
> +
> +	seq_printf(m, "%lu\n", points);
> +
> +	return 0;
> +}
> +
> +static ssize_t oom_adj_read(struct file *file, char __user *buf, size_t count,
> +			    loff_t *ppos)
> +{
> +	struct task_struct *task = get_proc_task(file_inode(file));
> +	char buffer[PROC_NUMBUF];
> +	int oom_adj = OOM_ADJUST_MIN;
> +	size_t len;
> +
> +	if (!task)
> +		return -ESRCH;
> +	if (task->signal->oom_score_adj == OOM_SCORE_ADJ_MAX)
> +		oom_adj = OOM_ADJUST_MAX;
> +	else
> +		oom_adj = (task->signal->oom_score_adj * -OOM_DISABLE) /
> +			  OOM_SCORE_ADJ_MAX;
> +	put_task_struct(task);
> +	if (oom_adj > OOM_ADJUST_MAX)
> +		oom_adj = OOM_ADJUST_MAX;
> +	len = snprintf(buffer, sizeof(buffer), "%d\n", oom_adj);
> +	return simple_read_from_buffer(buf, count, ppos, buffer, len);
> +}
> +
> +static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> +{
> +	struct mm_struct *mm = NULL;
> +	struct task_struct *task;
> +	int err = 0;
> +
> +	task = get_proc_task(file_inode(file));
> +	if (!task)
> +		return -ESRCH;
> +
> +	mutex_lock(&oom_adj_mutex);
> +	if (legacy) {
> +		if (oom_adj < task->signal->oom_score_adj &&
> +				!capable(CAP_SYS_RESOURCE)) {
> +			err = -EACCES;
> +			goto err_unlock;
> +		}
> +		/*
> +		 * /proc/pid/oom_adj is provided for legacy purposes, ask users to use
> +		 * /proc/pid/oom_score_adj instead.
> +		 */
> +		pr_warn_once("%s (%d): /proc/%d/oom_adj is deprecated, please use /proc/%d/oom_score_adj instead.\n",
> +			  current->comm, task_pid_nr(current), task_pid_nr(task),
> +			  task_pid_nr(task));
> +	} else {
> +		if ((short)oom_adj < task->signal->oom_score_adj_min &&
> +				!capable(CAP_SYS_RESOURCE)) {
> +			err = -EACCES;
> +			goto err_unlock;
> +		}
> +	}
> +
> +	/*
> +	 * Make sure we will check other processes sharing the mm if this is
> +	 * not vfrok which wants its own oom_score_adj.
> +	 * pin the mm so it doesn't go away and get reused after task_unlock
> +	 */
> +	if (!task->vfork_done) {
> +		struct task_struct *p = find_lock_task_mm(task);
> +
> +		if (p) {
> +			if (mm_flags_test(MMF_MULTIPROCESS, p->mm)) {
> +				mm = p->mm;
> +				mmgrab(mm);
> +			}
> +			task_unlock(p);
> +		}
> +	}
> +
> +	task->signal->oom_score_adj = oom_adj;
> +	if (!legacy && has_capability_noaudit(current, CAP_SYS_RESOURCE))
> +		task->signal->oom_score_adj_min = (short)oom_adj;
> +	trace_oom_score_adj_update(task);
> +
> +	if (mm) {
> +		struct task_struct *p;
> +
> +		rcu_read_lock();
> +		for_each_process(p) {
> +			if (same_thread_group(task, p))
> +				continue;
> +
> +			/* do not touch kernel threads or the global init */
> +			if (p->flags & PF_KTHREAD || is_global_init(p))
> +				continue;
> +
> +			task_lock(p);
> +			if (!p->vfork_done && process_shares_mm(p, mm)) {
> +				p->signal->oom_score_adj = oom_adj;
> +				if (!legacy && has_capability_noaudit(current, CAP_SYS_RESOURCE))
> +					p->signal->oom_score_adj_min = (short)oom_adj;
> +			}
> +			task_unlock(p);
> +		}
> +		rcu_read_unlock();
> +		mmdrop(mm);
> +	}
> +err_unlock:
> +	mutex_unlock(&oom_adj_mutex);
> +	put_task_struct(task);
> +	return err;
> +}
> +
> +/*
> + * /proc/pid/oom_adj exists solely for backwards compatibility with previous
> + * kernels.  The effective policy is defined by oom_score_adj, which has a
> + * different scale: oom_adj grew exponentially and oom_score_adj grows linearly.
> + * Values written to oom_adj are simply mapped linearly to oom_score_adj.
> + * Processes that become oom disabled via oom_adj will still be oom disabled
> + * with this implementation.
> + *
> + * oom_adj cannot be removed since existing userspace binaries use it.
> + */
> +static ssize_t oom_adj_write(struct file *file, const char __user *buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	char buffer[PROC_NUMBUF] = {};
> +	int oom_adj;
> +	int err;
> +
> +	if (count > sizeof(buffer) - 1)
> +		count = sizeof(buffer) - 1;
> +	if (copy_from_user(buffer, buf, count)) {
> +		err = -EFAULT;
> +		goto out;
> +	}
> +
> +	err = kstrtoint(strstrip(buffer), 0, &oom_adj);
> +	if (err)
> +		goto out;
> +	if ((oom_adj < OOM_ADJUST_MIN || oom_adj > OOM_ADJUST_MAX) &&
> +	     oom_adj != OOM_DISABLE) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Scale /proc/pid/oom_score_adj appropriately ensuring that a maximum
> +	 * value is always attainable.
> +	 */
> +	if (oom_adj == OOM_ADJUST_MAX)
> +		oom_adj = OOM_SCORE_ADJ_MAX;
> +	else
> +		oom_adj = (oom_adj * OOM_SCORE_ADJ_MAX) / -OOM_DISABLE;
> +
> +	err = __set_oom_adj(file, oom_adj, true);
> +out:
> +	return err < 0 ? err : count;
> +}
> +
> +const struct file_operations proc_oom_adj_operations = {
> +	.read		= oom_adj_read,
> +	.write		= oom_adj_write,
> +	.llseek		= generic_file_llseek,
> +};
> +
> +static ssize_t oom_score_adj_read(struct file *file, char __user *buf,
> +					size_t count, loff_t *ppos)
> +{
> +	struct task_struct *task = get_proc_task(file_inode(file));
> +	char buffer[PROC_NUMBUF];
> +	short oom_score_adj = OOM_SCORE_ADJ_MIN;
> +	size_t len;
> +
> +	if (!task)
> +		return -ESRCH;
> +	oom_score_adj = task->signal->oom_score_adj;
> +	put_task_struct(task);
> +	len = snprintf(buffer, sizeof(buffer), "%hd\n", oom_score_adj);
> +	return simple_read_from_buffer(buf, count, ppos, buffer, len);
> +}
> +
> +static ssize_t oom_score_adj_write(struct file *file, const char __user *buf,
> +					size_t count, loff_t *ppos)
> +{
> +	char buffer[PROC_NUMBUF] = {};
> +	int oom_score_adj;
> +	int err;
> +
> +	if (count > sizeof(buffer) - 1)
> +		count = sizeof(buffer) - 1;
> +	if (copy_from_user(buffer, buf, count)) {
> +		err = -EFAULT;
> +		goto out;
> +	}
> +
> +	err = kstrtoint(strstrip(buffer), 0, &oom_score_adj);
> +	if (err)
> +		goto out;
> +	if (oom_score_adj < OOM_SCORE_ADJ_MIN ||
> +			oom_score_adj > OOM_SCORE_ADJ_MAX) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	err = __set_oom_adj(file, oom_score_adj, false);
> +out:
> +	return err < 0 ? err : count;
> +}
> +
> +const struct file_operations proc_oom_score_adj_operations = {
> +	.read		= oom_score_adj_read,
> +	.write		= oom_score_adj_write,
> +	.llseek		= default_llseek,
> +};
> 
> ---
> base-commit: 1fffefb00cc0b0da1f2ae24e3d33364530ea6515
> base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> change-id: 20261014-oom_procfs-f74a922f73f1
> 
> Best regards,
> --  
> Ye Liu <ye.liu@linux.dev>

-- 
Michal Hocko
SUSE Labs
