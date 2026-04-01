Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775A43E9C3;
	Wed,  1 Apr 2026 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051486; cv=none; b=ZEktdzLfAktMBoIZxzQwLvoa9Q6sKNS7qRBcI6C1t11H1TWsgI8Y/0MD4g/g+SfpD5YB13RCbEnUiv7zoZ71CEe45HFDohNX2z9MaJ1C7w1P7aoWxFX1ZfZ0LcyBXveVQ2baVC8i+aElyYlnLA6AZciqcf0ch87/yDVwYa8H+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051486; c=relaxed/simple;
	bh=X/d2PosDUAExXPqBsoUWknNlPUawSE6HRdJbSf18SYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE3Ilq11H55K21aaLiixPk5EZLiiwzwzFZNgQSTlNd/2j9dfjdN0kEO/O9gbcCqTPFQA1USCOMt1uuD/eloD0aMBgsGf/+q/cMlBqOGqZb7YgBpMt/Qe4XsXSiSGEpWM0qxMSrYJgkPxYnjBlBHsHU6m3z18mu9zaQhgW4f9Syc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSwT57dE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSwT57dE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69F0C4CEF7;
	Wed,  1 Apr 2026 13:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775051485;
	bh=X/d2PosDUAExXPqBsoUWknNlPUawSE6HRdJbSf18SYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSwT57dEWwdKmTY0q7yCGcONE1OSYzMDDVsy/Ik0eHr/fWk+osJtIOdobrn/H2850
	 MbxBLzSPKyU01p+6vXtG2vNJi2MeYC1qn596aYDTCDKrgbbue3JQP2KA+22lyg0Vjw
	 lJ5w3wBzHk3iC7OA/BdMWAlbqPpo9Wv6dvRueKDYIakzg6IxYgrbnNqdnELJw4rNia
	 wX/HcuvYHq481bimDiU1KNGMQOh+kAtvjLd8kBGoM3kT2mRTDw1D46ibZtUZYSgw+U
	 PJjQeFuOmQDZjO3+SaU/VfGvT8wZk5VbW3+kKx0eyq8TkbzRN6sU3aa5JBBZl6mDyt
	 5mFBixBXkGu8A==
Date: Wed, 1 Apr 2026 06:51:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vfs: require verified birth date for file creation
Message-ID: <20260401135125.GK6202@frogsfrogsfrogs>
References: <20260401-i-hope-someone-believes-this-is-real-04f24e03944e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-i-hope-someone-believes-this-is-real-04f24e03944e@brauner>

On Wed, Apr 01, 2026 at 02:43:21PM +0200, Christian Brauner wrote:
> New regulation mandates that all digital content
> creation operations must be performed by verified adults. As file
> creation is the most fundamental content creation primitive in any
> operating system, the kernel must enforce age verification at the VFS
> layer.
> 
> This patch introduces CONFIG_VFS_AGE_VERIFICATION which, when enabled,
> requires every process to register a valid birth date via
> prctl(PR_SET_BIRTHDATE) before being permitted to create files. The
> birth date is stored in struct task_struct and inherited across fork().

I assume that starting a new session with setsid() won't clear it
either, then.  Do you think it would be useful to introduce a new
"btime" cgroup controller so that these decisions could be propagated to
entire groups of processes?

> File creation will fail with the new ETOOYOUNG error code if:
>   (a) no birth date has been registered, or
>   (b) the registered birth date indicates the user is under 18 years
>       of age.

This is more properly implemented as an LSM since we /are/ implementing
security policy here.  While we're on the topic of LSMs, do you think it
would be useful to have a LSM to filter write() calls to mounted block
devices?  Though that might be easier to do via blk_holder_ops.

> A new errno, ETOOYOUNG (134), has been added. Userspace is expected to
> handle this error by displaying a calming message and suggesting the
> user ask a parent or guardian to create the file on their behalf.
> 
> The birth date is deliberately NOT cleared across execve() to avoid
> the obvious loophole of spawning a new shell to bypass verification.
> Some may argue this violates the principle of least privilege. Those
> people are probably too young to create files anyway.
> 
> Note: setting a birth date that makes the caller appear older than 150
> years is rejected with EINVAL, as the kernel does not support vampires
> or other immortal entities at this time. Patches to add undead process
> support are welcome but will require a separate Kconfig option.

That's pretty ageist, don't you think?  I might not be 200 years old yet
but after the events of yesterday I certainly feel as though I am.

> Tested-by: Someone's nephew/niece (confirmed they cannot create files)
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/Kconfig                        |  17 ++++++++
>  fs/namei.c                        |  45 +++++++++++++++++++++
>  include/linux/sched.h             |   8 ++++
>  include/uapi/asm-generic/errno.h  |   2 +
>  include/uapi/linux/prctl.h        |   4 ++
>  kernel/sys.c                      |  42 ++++++++++++++++++++
>  6 files changed, 118 insertions(+)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 1c2036..424242 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -42,6 +42,23 @@ source "fs/crypto/Kconfig"
>  source "fs/verity/Kconfig"
>  source "fs/notify/Kconfig"
> 
> +config VFS_AGE_VERIFICATION
> +	bool "Require birth date verification for file creation"
> +	default y
> +	help
> +	  When enabled, every process must register a valid birth date via
> +	  prctl(PR_SET_BIRTHDATE, day, month, year) before being allowed to
> +	  create files. Processes that have not registered a birth date or
> +	  whose registered birth date indicates they are under 18 years of
> +	  age will receive -ETOOYOUNG on any file creation attempt.
> +
> +	  If unsure, say Y. Failure to comply may result in stern letters
> +	  from lawyers. You don't want that. Trust us. Say Y.
> +
>  source "fs/quota/Kconfig"
> 
>  source "fs/autofs/Kconfig"
> diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
> index 1..2 100644
> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -20,4 +20,6 @@
> 
>  #define EHWPOISON	133	/* Memory page has hardware error */
> 
> +#define ETOOYOUNG	134	/* Process too young to create content */
> +
>  #endif
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 3..4 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -328,4 +328,8 @@
> 
>  #define PR_LOCK_INDIR_BR_LP_STATUS      82
> 
> +/* age verification for file creation */
> +#define PR_SET_BIRTHDATE		83
> +#define PR_GET_BIRTHDATE		84
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 5..6 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1215,6 +1215,14 @@ struct task_struct {
>  #endif
>  	struct seccomp			seccomp;
>  	struct syscall_user_dispatch	syscall_dispatch;
> +
> +#ifdef CONFIG_VFS_AGE_VERIFICATION
> +	/* compliance - birth date for age verification */
> +	u8				birthdate_day;
> +	u8				birthdate_month;
> +	u16				birthdate_year;

You could perhaps express this as a s32 birthdate measuring days since
the Unix epoch, which would enlarge the range to handle lanthanites.

> +	bool				birthdate_verified;

Legally required now, so there's no need to waste memory on a bool. :/

> +#endif
> 
>  	/* Thread group tracking: */
>  	u64				parent_exec_id;
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 7..8 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2345,6 +2345,48 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		break;
> +
> +#ifdef CONFIG_VFS_AGE_VERIFICATION
> +	case PR_SET_BIRTHDATE:
> +	{
> +		u8 day = (u8)arg2;
> +		u8 month = (u8)arg3;
> +		u16 year = (u16)arg4;

The uapi really ought to be a pointer to a struct timespec.

> +		struct tm now;
> +		int age;
> +
> +		/* Basic date validation */
> +		if (month < 1 || month > 12)
> +			return -EINVAL;
> +		if (day < 1 || day > 31)
> +			return -EINVAL;
> +		if (year < 1900)
> +			return -EINVAL;

No, don't open-code date handling, use a library that's already been
debugged.  Why do you allow 2/31/1904?

> +
> +		time64_to_tm(ktime_get_real_seconds(), 0, &now);
> +
> +		/* The kernel does not support vampires or immortal entities */
> +		if ((now.tm_year + 1900) - year > 150)
> +			return -EINVAL;
> +
> +		/* No time travelers either */
> +		if (year > (now.tm_year + 1900))

Pretty sure there's some addition overflow possibilities here.
check_add_overflow?

> +			return -EINVAL;
> +
> +		me->birthdate_day = day;
> +		me->birthdate_month = month;
> +		me->birthdate_year = year;
> +		me->birthdate_verified = true;
> +
> +		age = (now.tm_year + 1900) - year;
> +		if (now.tm_mon + 1 < month ||
> +		    (now.tm_mon + 1 == month && now.tm_mday < day))
> +			age--;
> +
> +		if (age < 18)
> +			pr_info_ratelimited("Process %d (comm: %s) registered as minor (age %d). "
> +				"File creation will be denied. Please ask a "
> +				"parent or guardian for assistance.\n",
> +				task_pid_nr(me), me->comm, age);
> +		break;
> +	}
> +	case PR_GET_BIRTHDATE:
> +		if (!me->birthdate_verified)
> +			return -EINVAL;
> +		if (put_user(me->birthdate_day, (u8 __user *)arg2) ||
> +		    put_user(me->birthdate_month, (u8 __user *)arg3) ||
> +		    put_user(me->birthdate_year, (u16 __user *)arg4))
> +			return -EFAULT;
> +		break;
> +#endif /* CONFIG_VFS_AGE_VERIFICATION */
> +
>  	default:
>  		error = -EINVAL;
>  		break;
> diff --git a/fs/namei.c b/fs/namei.c
> index 9..10 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4148,6 +4148,45 @@ static int vfs_mknodat(struct mnt_idmap *idmap, struct dentry *dentry,
>  		       umode_t mode, dev_t dev);
> 
> +#ifdef CONFIG_VFS_AGE_VERIFICATION
> +/**
> + * check_age_verification - verify the calling process has registered a valid
> + *                          birth date and is old enough to create files.
> + *
> + * Returns 0 if the caller is verified as an adult (>= 18 years old).
> + * Returns -ETOOYOUNG if the caller is a minor or has not registered a
> + * birth date.
> + *
> + * This function exists because the fundamental UNIX
> + * principle of "everything is a file" was insufficiently regulated.
> + */
> +static int check_age_verification(void)
> +{
> +	struct task_struct *tsk = current;
> +	struct tm now;
> +	int age;
> +
> +	if (!tsk->birthdate_verified) {
> +		pr_warn_ratelimited(
> +			"Process %d (comm: %s) attempted to create a file "
> +			"without age verification. Set birth date via "
> +			"prctl(PR_SET_BIRTHDATE, day, month, year).\n",
> +			task_pid_nr(tsk), tsk->comm);
> +		return -ETOOYOUNG;
> +	}
> +
> +	time64_to_tm(ktime_get_real_seconds(), 0, &now);
> +
> +	age = (now.tm_year + 1900) - tsk->birthdate_year;
> +	if (now.tm_mon + 1 < tsk->birthdate_month ||
> +	    (now.tm_mon + 1 == tsk->birthdate_month &&
> +	     now.tm_mday < tsk->birthdate_day))
> +		age--;
> +
> +	if (age < 18) {
> +		pr_warn_ratelimited(
> +			"Process %d (comm: %s) is only %d years old. "
> +			"Must be 18 or older to create files. "
> +			"Ask a parent or guardian for help.\n",
> +			task_pid_nr(tsk), tsk->comm, age);
> +		return -ETOOYOUNG;

Yeah, this really looks like material for an LSM.

--D

> +	}
> +
> +	return 0;
> +}
> +#endif /* CONFIG_VFS_AGE_VERIFICATION */
> +
>  /**
>   * vfs_create - create new file
>   * @idmap:	idmap of the mount the inode was found from
> @@ -4170,6 +4209,12 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
>  	if (error)
>  		return error;
> 
> +#ifdef CONFIG_VFS_AGE_VERIFICATION
> +	error = check_age_verification();
> +	if (error)
> +		return error;
> +#endif
> +
>  	if (!dir->i_op->create)
>  		return -EACCES;	/* shouldn't it be ENOSYS? */
> 
> --
> 2.49.0
> 
