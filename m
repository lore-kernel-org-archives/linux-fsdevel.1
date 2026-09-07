Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030746DFF1
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778768; cv=pass; b=NqABobrfoEBj+jbPPBt47oM4NUVAxWZ+ykpof0UmigulIPNQ1+x/M25nyhBGh5WC1ZcdzK2htLNqpMSBFguq0L3OLFaSwMZlAH1we1ixwgLqBWL0IwoOM6kIx9t13Pe1GnaiAKG8mItvBJ8kkysmqxvbe7QYokWwSTn/T8FQmRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778768; c=relaxed/simple;
	bh=X62nhmJb9WbKAvRTAFiqwCbXKzcaidhj4nTbLOE1G+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ha3Pi0y0yfVkmkCVgK7cdNAitS45arMOV0sTYWO3JRGG5pNNGlKTBgrw77dBWK1QRGNht9sh3ktJUeWj8zgI1j+RihkY8u+JhKXwgV73NRyJ6mzUA8TBI+8LcRQd0ewHZcFABxo8Dur2PraQK4anZtBRhcSyeMGiJzJ2kas+RLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=JWzcZz4h; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="JWzcZz4h"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a7f27637d6so4467640a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 03:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788778764; cv=none;
        d=google.com; s=arc-20260327;
        b=O4jIw5a13ErhBGRcbFVGwOtetriJa9xT4MGkMNGnCjvr5QXZ/9tovl9sQNAHbUkRTO
         eOgMpS+Uq3V7HvX9yYb8nLMtFGCffU72OFTZvXUN8LAofnf+c5JLMt2M1S6E+FJygSXJ
         uQsOgdC5oqQ+wjW5N0PRv0GLglT/egYfLfUNld1NebeE2TNB6ZA+1ZB1cG/PsAQb2iMr
         00dkoeTxChsESXwNgLzGvsIEzWHCbt9zmj86nybqRoUPN08Sxn27u7NiLXk0Z92ZpV7d
         A6mcTGqbKXU+gzujnlFde0KKlWP2tqEjnFbD8CS3TL/2ml6nUe109eD+iaYWBKXO33a+
         iY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MbExSQ9FoZY9t8VR3AEn0egDax+aEYlzeOz7ZAlCuSY=;
        fh=6pmlk4TCSzsFIWJuhPgiqhzMqmIVK2T65i2ofBbJgIg=;
        b=l3K9NYdt8PjI65DlVTnU4lcgbpO4RsYH3Mq7OrBBcwgIGANiES3xHOiM3sSx4rK3z+
         IPzGuj5ADJcI1hWVfHJ9JPBgAFdXbameYy4SExmEcpALC42QxHwBvOUhzeMfWmTv0cSf
         esZBRWDdNaeVWoq2OLF+zX84hquS6Ygo89sfwfyvfM8ilghJ9ALelOBC9kvn23WESdOv
         goI3cQ6WHjWNT8jERUt4TVurMR94tOXIJJkDxt1nDkpzW6/AbvJT9TNT2MNQEy6KHi7J
         4W8pYQ/70/mUxiSKfoKsUFWT2N/zkmTSsUN08DyIX0fk25GeJt9ESeQnovcao9cu3sTb
         puQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788778764; x=1789383564; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MbExSQ9FoZY9t8VR3AEn0egDax+aEYlzeOz7ZAlCuSY=;
        b=JWzcZz4hCMmPIVL01Q6H6mbVP+lrRq84c/PkmjxxObN+TXFijYupJ950JURNRcwdIz
         5zU7ZQVI+XHyL4q/lZbjCegSKBS6pgLZyjsb/RAP6ma96iZjTAtkBaz91pW3AzGFuuXt
         XEXZrEy/4MqzkNoNuU+gEl6KXf+lMl0s8x00E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788778764; x=1789383564;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MbExSQ9FoZY9t8VR3AEn0egDax+aEYlzeOz7ZAlCuSY=;
        b=E8cqN/ng7wSKB1hCjD+AJkMI+b1Ty/et7+n+fQ7HTpvX08POXZZtaDPsFDPRkhAzkx
         gywQJpl6eMXopl2jhsxnT9e9g1fvGuBcY1sE2LpbqL/vbshVubLxPiOOuFmuImvtUK2F
         eag35OhJoXa//hR+v12b/1zWzxArqDN+sOzOsfwaphSnpCCRCMnzpt4LTylar6Zt2P01
         TccMcFeHb/4a1NZ5YDVWk2OeacaaC9z1KenzSjFg5mq3trKf8wL0SqdfaKXqImU1opNN
         nnj2R3XgB0bodYRavmxZGNM8tBGQgdA4kR1IQG+jYEKpy1CTwkZA6Q3UXYn5KhTcsMuY
         aIQw==
X-Forwarded-Encrypted: i=1; AKwUvBwr72miit1twhwmDEb2tYh1kFutGpTbjTQ9geompFF2lXJmZE/bbA0cOPnAcveM7MB5PZ+RxyYYqV3YPgNG@vger.kernel.org
X-Gm-Message-State: AFuF++nlsx4qOus1ZF021OWNvT662NlMgF2KIp6YRrCU+U+A6M/bTbrF
	cFlY3E7zHHgVdZki0ojQVzFBzlxUyBBY5Hey0SjFbnBs3Td9hosRNllxaPNc55a2VnEPM6wMwq7
	wGJseZYN02/GrGjBUNqSkj9wc02fc7M8coyR7sJvhKA==
X-Gm-Gg: AYBFou2IaxsINYdCTDf0VmBPBlnamUm8NNLMp7+0KyFJAmcDy7HNm18GxK8/AA3vbXH
	we+ouk+hCOd8RjHIlYzYJQc0JPY1/ZupD63fuu6xpeT8XsKgITMA+Q7c72eGDvO61cbokbZvLYA
	YyHGtbqvmK3ozXVNmkjgvMZM+0vnv0OcMeRZMfEKVoVWnzc1BEgnSPDNfcCIij0WmAEecX7QoWr
	cUa5k+35nhyXJS6bScCydjGGD2ZvK9oe2q6PSPt17LE6ozemp+YYq7Ycs/JKWxGHKmmglqUiV09
	M2qY0Xndq+dJo6gcYcbifSLTtipPPzbAyQuB8bLMXxFBev0BQPL7o5Me4D+FSJ6hB1QrExSwG3s
	362eM3XBL7g==
X-Received: by 2002:a17:907:3e1a:b0:c24:87e5:6491 with SMTP id
 a640c23a62f3a-c260c971f12mr1413746366b.2.1788778764003; Mon, 07 Sep 2026
 03:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org> <20260831-work-unix-passpidfd-v1-9-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-9-70cbfda0c7ba@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 7 Sep 2026 12:59:12 +0200
X-Gm-Features: AcwNN1Vx-Y23Xmb_efJJLNqRBHN_dmcZQwnSFqUbNzzKkLXuOfCIfHCVcoWksEs
Message-ID: <CAJqdLrozRL7jaKPzmF1ksjVNz11Qyn2V9-xAQ342yDVJP76-+w@mail.gmail.com>
Subject: Re: [PATCH 09/10] pidfs: record the coredump on the dumping thread's
 pid too
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mo., 31. Aug. 2026 um 13:22 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> If a thread-group coredumps only the thread-group leader pidfd will
> return coredump information. A pidfd for the thread that took the fatal
> signal cannot be used to retrieve it.
>
> Record both the thread-group leader and the specific thread that took
> the signal and register both in pidfs. Mark both the thread-group leader
> and the specific thread with the coredump information so retrieval works
> for both pidfds.
>
> Now that both SO_PEERPIDFD and SO_PEERPIDFD_THREAD are available it's
> easy to get the coredump information for the specific thread.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

LGTM

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  fs/coredump.c            | 22 +++++++++++++---------
>  fs/pidfs.c               | 11 +++++++++--
>  include/linux/coredump.h |  4 +++-
>  3 files changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 71a0093ada1b..b5ff4b3e1831 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -454,7 +454,7 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
>                                  * leader we know that the thread-group leader
>                                  * cannot be reaped until @current has exited.
>                                  */
> -                               cprm->pid = task_tgid(current);
> +                               task_pids(cprm->pid, current);
>                                 err = cn_printf(cn, "%d", COREDUMP_PIDFD_NUMBER);
>                                 break;
>                         }
> @@ -626,13 +626,17 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
>         struct coredump_params *cp = (struct coredump_params *)info->data;
>         int err;
>
> -       if (cp->pid) {
> +       if (cp->pid[PIDTYPE_TGID]) {
>                 struct file *pidfs_file __free(fput) = NULL;
>
> -               pidfs_file = pidfs_alloc_file(cp->pid, 0);
> +               pidfs_file = pidfs_alloc_file(cp->pid[PIDTYPE_TGID], 0);
>                 if (IS_ERR(pidfs_file))
>                         return PTR_ERR(pidfs_file);
>
> +               err = pidfs_register_pids(cp->pid);
> +               if (err)
> +                       return err;
> +
>                 pidfs_coredump(cp);
>
>                 /*
> @@ -695,12 +699,12 @@ static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *
>                 return false;
>
>         /*
> -        * Set the thread-group leader pid which is used for the peer
> -        * credentials during connect() below. Then immediately register
> -        * it in pidfs...
> +        * Set the pids of the dumping thread and its thread-group leader
> +        * which are used for the peer credentials during connect() below.
> +        * Then immediately register them in pidfs...
>          */
> -       cprm->pid = task_tgid(current);
> -       retval = pidfs_register_pid(cprm->pid);
> +       task_pids(cprm->pid, current);
> +       retval = pidfs_register_pids(cprm->pid);
>         if (retval)
>                 return false;
>
> @@ -722,7 +726,7 @@ static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *
>         }
>
>         /* ... and validate that @sk_peer_pid matches @cprm.pid. */
> -       if (WARN_ON_ONCE(unix_peer(socket->sk)->sk_peer_pid[PIDTYPE_TGID] != cprm->pid))
> +       if (WARN_ON_ONCE(!pids_equal(unix_peer(socket->sk)->sk_peer_pid, cprm->pid)))
>                 return false;
>
>         cprm->limit = RLIM_INFINITY;
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 586af2e5811c..29299b2c7ca7 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -793,9 +793,9 @@ void pidfs_exit(struct task_struct *tsk)
>  }
>
>  #ifdef CONFIG_COREDUMP
> -void pidfs_coredump(const struct coredump_params *cprm)
> +static void pidfs_coredump_pid(struct pid *pid,
> +                              const struct coredump_params *cprm)
>  {
> -       struct pid *pid = cprm->pid;
>         struct pidfs_attr *attr;
>
>         attr = READ_ONCE(pid->attr);
> @@ -814,6 +814,13 @@ void pidfs_coredump(const struct coredump_params *cprm)
>         smp_wmb();
>         set_bit(PIDFS_ATTR_BIT_COREDUMP, &attr->attr_mask);
>  }
> +
> +void pidfs_coredump(const struct coredump_params *cprm)
> +{
> +       /* The dumping thread's pidfd reports the coredump as well. */
> +       for (enum pid_type type = PIDTYPE_PID; type <= pids_last(cprm->pid); type++)
> +               pidfs_coredump_pid(cprm->pid[type], cprm);
> +}
>  #endif
>
>  static struct vfsmount *pidfs_mnt __ro_after_init;
> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> index 7b38ee2e7913..0bbb7de6a402 100644
> --- a/include/linux/coredump.h
> +++ b/include/linux/coredump.h
> @@ -5,6 +5,7 @@
>  #include <linux/types.h>
>  #include <linux/mm.h>
>  #include <linux/fs.h>
> +#include <linux/pid_types.h>
>  #include <linux/sched/coredump.h>
>  #include <asm/siginfo.h>
>
> @@ -32,7 +33,8 @@ struct coredump_params {
>         int vma_count;
>         size_t vma_data_size;
>         struct core_vma_metadata *vma_meta;
> -       struct pid *pid;
> +       /* Dumping thread and its thread-group leader by pid type. */
> +       DECLARE_PIDS(pid, PIDTYPE_TGID);
>  };
>
>  extern unsigned int core_file_note_size_limit;
>
> --
> 2.53.0
>
