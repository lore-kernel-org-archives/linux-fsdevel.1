Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034674399F4
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775676; cv=pass; b=XlWDCqCSlkTDGp8/LbRX2VdIJZvjtChLPxHAW+/5vm979yKZ5S/DZ67e9Y4rCRcAc7bMowsiHb6CBIEam0KbUzlb6SomfYTav2nsYUf15aGxOgMU3xC2PzvQyyF2yBznFoQGBMACNY/33j9Iz6cQeMG9E4uVJ0ZK4SG1aHjGHE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775676; c=relaxed/simple;
	bh=2Ll82zU9YTcjyoerXCYANDbZSFwKQrbdnSaKvUSG0rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2gjXzPOh7Ru4V3wO1Sza2nRaJLD7mg/iqx3IZfKDsUWGgWLK+bxkkHzJIkNK5YqFFGJFSTmKtWEXSUtKR6Y0kjgzQmcT2NCpASxCvFLCsEy3Qe1QHIIosb7VzFOP4IP7/EquLkwKGntjLiW9axHtrj7fQE9IzPe2me/Ukr1SiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=f8QQ8XiX; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="f8QQ8XiX"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9c60d5so431266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 03:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788775671; cv=none;
        d=google.com; s=arc-20260327;
        b=PmecM7QZX5fxguQX3YfAneluXFt/KbDoVPKxSwHx4Gm8lEZjJBLJFqI8AfT3LaGpl4
         dZNFbUifx89iesbevc7TEm82lq3Wmn/am9K/68kxz6H+WqAbocqO5g0vg/GUmkcy9nsS
         SS6Q1crYZURiBI+CSgMeQ9+fHKPEVsCFcVTNDAwcAN98uP22J7HEazBWkyXbl0YCUxa9
         EHUG/PFaWHwXQnGkSCp8iumpltkoUHFVVlxNrOTl1cMNY+1yXUYLc1y9AkUs23fuf7Jw
         /G/YTaHsCc6hldfWABc7VJUziJQbURcr1yUY9x01n7ZAiXnEctyFHYiY0sikp2mc2+89
         Jjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BNaEPel1NdtIe+zUUZDBwTrn792D672lVbXfid2E2LE=;
        fh=kq4I5skVC+xn0mI7rlgP8OuWg5xeJV9Qob/WKEArznc=;
        b=Q7EIc3D0bdL0CXVZbmL/YWvyCc6aDITM/qFl4xzLP32Szb3o/EvX9TVJIHoMYJ+LPI
         Q5WbHYvEtmBo8ELkoKK8xBo01fjR2X8otBrp/yqBji0lgj8u7cWBHHd2o5A0pffMrJ/B
         tHfrvzkRAc8La637oyV55xpdOId254q4EGA0hGTXiFm/Jm8k8Ww++NRfZokVguufvm9z
         M1Z1hcabJXePvj9KB9PLLCnWcZ6BOGnNuLr3OooVZOoSQUe8FqAijdV273Z20TYwgfgq
         nax14pCEy11nXDB6msZhPuy6jJ1j4aZuStMNHK7drNIzTaQJtu7U+bMEmAp2qdsRVvHa
         mPjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788775671; x=1789380471; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNaEPel1NdtIe+zUUZDBwTrn792D672lVbXfid2E2LE=;
        b=f8QQ8XiX0mMbv/5/uythpObXlnDkhytxt/gKhOrPiqNNOa4Pc8Oclr5yMCj4w2vL1g
         n3OOfAaIaF6otWkrmwzZai/GAvvMCzTL/wp5sTRxZuz8Wx2hiS0JW21ryXt9HCAqLv+h
         ewYbMFqbwMw+OFrLBEuKDknPWE36bb0LGznYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788775671; x=1789380471;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BNaEPel1NdtIe+zUUZDBwTrn792D672lVbXfid2E2LE=;
        b=QXdPmNX4yYWjen/5I12lt44oCDXm0S+954BaN9zZPDBYrebY9MNt7BkyADkQHNNBR2
         L8ogFBetvw+l9BJvIlmgACkJRRBBZyEJGfunbM7L3BwcuBWNbEG6FmhcKxIGCYwOxz+4
         S2duxHM4cBMCTAMgbyC/Ez7T2h5a9xTURdxBvgT6ZXbH9oVWAo6nz8fQq3ydmZRnTzrj
         3eCcw0tYOOLPsi5+UcuGIfV3WJI60BPW0uWcUm3CXyLF85fkYq7e251YwBWadqs95utB
         JizGniAD9sqU1gdnwXgra9BZlje3tz0cTSuy3dE6p5OYYfaTqmFRMgSc3r/B6IQFlkV9
         C0CA==
X-Forwarded-Encrypted: i=1; AKwUvBzzE8czalhcniUbrO+Ew9fMMXoRIQEWLtny6bJB2K4SCUjXQPRe+KFwYjtdvariJF2iVMhzLAUs5WZvGVkM@vger.kernel.org
X-Gm-Message-State: AFuF++lcKiO8AnOR4HQNKheeqd0tklTMTTx9AnXpShuQQ046kevetizc
	s/cpmgCkrD9DvYIYWXxXgtaXRddr8gWLBfS19nXl32w8bPnIvV9VLgVnetDbIUWJ3ToKS9EclLi
	RKZXPnkttW3S5ZB5blglwlChZ7GUfTrQ26OxIeVnDlWrGJgOp2KIot0mEQA==
X-Gm-Gg: AYBFou2lUF8FnDY8rTVNVuk7dCvf4h5LmL3e5VpIe6Oj85+Ibe8T0F9ZnIPDt79BxuB
	uird4E/NRr5HKnLkByKw7yotWekmSfWfuXwiMasrHZmJqvLBMvroWHvfw1YJ7djuUjHf2KHQwgC
	IYmx5JCG7EZMKz5B15NdxykBUJdPHJylR1jIvsH/M5f0rdN9qBytlfiquMxitLgT3VQVFyeJZ3X
	eMBZb9lb5LKJKfnTzr6vSYHkAFkjpD7yxkxyUZ6BhBc9oLPapJ00zaIfmOk8VF/mEEPAyRDHbAC
	wiCMSOHhQu7KAMzilOhQNlBhtvC3dO0OwV+pY9i4Rvl10EUU/i6C4WWzzzDlySiYYkYy0/XiJr9
	u
X-Received: by 2002:a17:906:f597:b0:c26:3377:752b with SMTP id
 a640c23a62f3a-c29042b7343mr2628366b.3.1788775671134; Mon, 07 Sep 2026
 03:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org> <20260831-work-unix-passpidfd-v1-1-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-1-70cbfda0c7ba@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 7 Sep 2026 12:07:39 +0200
X-Gm-Features: AcwNN1V7LPSWnyROmwcXNgMOTNDk9p2-2d_HjS0RFfSlm_TayeYshLabGwoOGk8
Message-ID: <CAJqdLrp-5zkpUOzA8WeAyTq-KqQ0f=BERy0PcniSmXYmOJ2wZw@mail.gmail.com>
Subject: Re: [PATCH 01/10] pid: add helpers to operate on a struct pid array
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mo., 31. Aug. 2026 um 13:21 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> We're about to extend af_unix sockets and coredump code with the ability
> to hand out thread-specific pidfds. Add a few simple helpers that allow
> to operate on multiple struct pids up to PIDTYPE_MAX with automatic
> bounds checking.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

LGTM

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  fs/pidfs.c                   | 16 +++++++++++++
>  include/linux/pid.h          | 53 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pid_types.h    |  8 +++++++
>  include/linux/pidfs.h        |  5 +++++
>  include/linux/sched/signal.h | 18 +++++++++++++++
>  5 files changed, 100 insertions(+)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index a6a643f15d08..586af2e5811c 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -1070,6 +1070,22 @@ int pidfs_register_pid_gfp(struct pid *pid, gfp_t gfp)
>         return 0;
>  }
>
> +/* Register the pids up to pid type @last of @pids in pidfs. */
> +int __pidfs_register_pids(struct pid *const *pids, enum pid_type last)
> +{
> +       if (WARN_ON_ONCE(last >= PIDTYPE_MAX))
> +               return -EINVAL;
> +
> +       for (enum pid_type type = PIDTYPE_PID; type <= last; type++) {
> +               int ret = pidfs_register_pid(pids[type]);
> +
> +               if (unlikely(ret))
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static struct dentry *pidfs_stash_dentry(struct dentry **stashed,
>                                          struct dentry *dentry)
>  {
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index ddaef0bbc8ba..87635d0cc1f7 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -2,6 +2,9 @@
>  #ifndef _LINUX_PID_H
>  #define _LINUX_PID_H
>
> +#include <linux/array_size.h>
> +#include <linux/build_bug.h>
> +#include <linux/minmax.h>
>  #include <linux/pid_types.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
> @@ -92,6 +95,56 @@ static inline struct pid *get_pid(struct pid *pid)
>  }
>
>  extern void put_pid(struct pid *pid);
> +
> +/*
> + * Helpers for arrays of struct pid indexed by pid type declared with
> + * DECLARE_PIDS(). The array covers PIDTYPE_PID up to the pid type it
> + * was declared with and the helpers take that bound from the array.
> + */
> +static inline void __get_pids(struct pid **dst, struct pid *const *src,
> +                             enum pid_type last)
> +{
> +       for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
> +               dst[type] = get_pid(src[type]);
> +}
> +
> +static inline void __put_pids(struct pid **pids, enum pid_type last)
> +{
> +       for (enum pid_type type = PIDTYPE_PID; type <= last; type++) {
> +               put_pid(pids[type]);
> +               pids[type] = NULL;
> +       }
> +}
> +
> +static inline void __swap_pids(struct pid **a, struct pid **b,
> +                              enum pid_type last)
> +{
> +       for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
> +               swap(a[type], b[type]);
> +}
> +
> +static inline bool __pids_equal(struct pid *const *a, struct pid *const *b,
> +                               enum pid_type last)
> +{
> +       for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
> +               if (a[type] != b[type])
> +                       return false;
> +       return true;
> +}
> +
> +/* The last pid type an array declared with DECLARE_PIDS() covers. */
> +#define pids_last(pids)                                                        \
> +       ((enum pid_type)(ARRAY_SIZE(pids) - 1 +                         \
> +                        BUILD_BUG_ON_ZERO(ARRAY_SIZE(pids) > PIDTYPE_MAX)))
> +
> +#define __pids_last2(a, b)                                             \
> +       (pids_last(a) + BUILD_BUG_ON_ZERO(ARRAY_SIZE(a) != ARRAY_SIZE(b)))
> +
> +#define get_pids(dst, src)     __get_pids(dst, src, __pids_last2(dst, src))
> +#define put_pids(pids)         __put_pids(pids, pids_last(pids))
> +#define swap_pids(a, b)                __swap_pids(a, b, __pids_last2(a, b))
> +#define pids_equal(a, b)       __pids_equal(a, b, __pids_last2(a, b))
> +
>  extern struct task_struct *pid_task(struct pid *pid, enum pid_type);
>  static inline bool pid_has_task(struct pid *pid, enum pid_type type)
>  {
> diff --git a/include/linux/pid_types.h b/include/linux/pid_types.h
> index c2aee1d91dcf..3302690a2a28 100644
> --- a/include/linux/pid_types.h
> +++ b/include/linux/pid_types.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_PID_TYPES_H
>  #define _LINUX_PID_TYPES_H
>
> +#include <linux/build_bug.h>
> +
>  enum pid_type {
>         PIDTYPE_PID,
>         PIDTYPE_TGID,
> @@ -10,6 +12,12 @@ enum pid_type {
>         PIDTYPE_MAX,
>  };
>
> +struct pid;
> +
> +/* An array of struct pid indexed by pid type, PIDTYPE_PID up to @last. */
> +#define DECLARE_PIDS(name, last)                                       \
> +       struct pid *name[(last) + 1 + BUILD_BUG_ON_ZERO((last) >= PIDTYPE_MAX)]
> +
>  struct pid_namespace;
>  extern struct pid_namespace init_pid_ns;
>
> diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
> index 0abf7da9ab23..3c1e82f1a369 100644
> --- a/include/linux/pidfs.h
> +++ b/include/linux/pidfs.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_PID_FS_H
>
>  #include <linux/gfp_types.h>
> +#include <linux/pid.h>
>
>  struct coredump_params;
>
> @@ -32,5 +33,9 @@ static inline int pidfs_register_pid(struct pid *pid)
>  }
>
>  void pidfs_free_pid(struct pid *pid);
> +int __pidfs_register_pids(struct pid *const *pids, enum pid_type last);
> +
> +/* Register the pids of an array declared with DECLARE_PIDS(). */
> +#define pidfs_register_pids(pids)      __pidfs_register_pids(pids, pids_last(pids))
>
>  #endif /* _LINUX_PID_FS_H */
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 584ae88b435e..9444b47789a0 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -677,6 +677,24 @@ struct pid *task_pid_type(struct task_struct *task, enum pid_type type)
>         return pid;
>  }
>
> +/* Fill @pids with the pid types of @task up to @last, without references. */
> +static inline void __task_pids(struct pid **pids, enum pid_type last,
> +                              struct task_struct *task)
> +{
> +       for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
> +               pids[type] = task_pid_type(task, type);
> +}
> +
> +static inline void __get_task_pids(struct pid **pids, enum pid_type last,
> +                                  struct task_struct *task)
> +{
> +       for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
> +               pids[type] = get_pid(task_pid_type(task, type));
> +}
> +
> +#define task_pids(pids, task)          __task_pids(pids, pids_last(pids), task)
> +#define get_task_pids(pids, task)      __get_task_pids(pids, pids_last(pids), task)
> +
>  static inline struct pid *task_tgid(struct task_struct *task)
>  {
>         return task->signal->pids[PIDTYPE_TGID];
>
> --
> 2.53.0
>
