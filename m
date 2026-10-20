Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502326;
	b=ukwTnrkbqoWbh0CQ9N2LvZs05DfiY3SlMLyAoe+18ALNRTeKAHee9RM/bxYTSjoRcKbQ
	 jtp6jUGDc17A8dBYlShL1cm6UxCxLsQS0Snt7v0ZhwYtkl+fcWAf6XsaI3Vfvt50mAMHK
	 bhTA3rWahznW3ocJfiyvwpHnijGd6fJzkwkqHF66BcpwQRW4M0iQXsu2U/vWSXh4IJ388
	 0U+ceyxObgeL24MfiS4GOevNZjQ+kEcD1/iHR3dBMjHHKBbEnN2qMHmX8cBkSt68JYpQ8
	 NIeYrqlG9Wa0kAe28x+7vbFlDC+DX67PoyoOlMseGJYD2fB4Tz2lyJ7HeTfH0fXIGdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502326;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nT5qVJtMsZOOQN5bDd9xQKpWcAmBmpPjDikwtQK4oYA=;
	b=re6lgBTa3FNNGwTm948cbihoCcwD2ySqob23BF0Ecy9grN2qXlssSR52ekRsRvaDq1or
	 cw3UPcyynG3ADYVW6zDuZ2q0hcHBaHIIv96G3FmphmRZdVvXlMsYuKN3T48RqvyUNrrBD
	 D0BK/ySrZGKtzl0n0MHgFwRgiAs6yoct99Fffd7EDOo7hvoB9SGlIMJlGu1+Ee0mPd+7L
	 5TUmQrV16JKyfz/I2I07PAcdL0Hcj/gRodNW5bZzT1vqs1nJfQM0XGzgFmCsL2UQf2a8s
	 EdXha81IY+ojzo6LTlvkyYoLZ8RK3tJXEyrem9he2bzv8rm4glMLChMf5lcoJDsNRGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXzD36CU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F6A606A321
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXzD36CU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C6F1F000CC
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792502325;
	bh=nT5qVJtMsZOOQN5bDd9xQKpWcAmBmpPjDikwtQK4oYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MXzD36CUho2eKSkBxRNu6P8CLs3bu7ImIjnUVFcPPTSnHTwb2gO3IhGWuNdOAkdbm
	 2S29sSWAaRcj29ziXE7wk//nIjJzXZd6DLfxdQJk2TRRY4U2TNsuOXfNeycG10RHlK
	 iZLiyy9TPE4l6RoPJtQoHoi7eJGfWfONBM/3QdgeQzCxrXPkBz2cCcfZRbhKRKDGuv
	 +xJHwtaj1gepUKm2Nr7/a+2A74IcFiYuoyX4xYaSRzplCQWoqMqmR3urW/KgK5nRdk
	 hOsyxnzgV8vvmk56GnAt+XtI+zSIfXvuga5wqsHPzScTbaXXtV6JvjbSE+hGhl/9Cw
	 nyU4eNlHto96w==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5bce4e278baso907822e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 06:18:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByzHyjjN0c5QsA6zz00h3x6pIVOpgCtYFKyEwPjcwYfz7wtAT33dq0tlzOSMKfYEdAfYW9behjYHKhe2ToV@vger.kernel.org
X-Gm-Message-State: AFq9FYIOf9xNudushd0mA+1AWr8Jt6v/3OOhW+4Gm3b/yKcZFV05Qs1j
	8VdvT7rNnSMIEek6cVkC5hYTnu83JKA8DV9MHju0T0s/VALnOJ1a8XurvqkcpXv84m/RcrLUVpr
	RLLc2wfYe4Q6cAiCKiyGJsvIqv0BEu7I=
X-Received: by 2002:a05:6512:b8f:b0:5be:44be:569f with SMTP id
 2adb3069b0e04-5be66a23859mr739003e87.2.1792502323872; Tue, 20 Oct 2026
 06:18:43 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020121159.2154649-1-sadrul@google.com>
In-Reply-To: <20261020121159.2154649-1-sadrul@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 20 Oct 2026 15:16:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hfGZWp9kWF1Fi4pYqwkukPrbw=MOiQ1yxd31mXg5zR6Q@mail.gmail.com>
X-Gm-Features: AclHuK-M3XHHa8FV_F0N1LJ5FfL6gSK9Mdl9J8PTsQYLf0xcHyilyfaYZUWI-tU
Message-ID: <CAJZ5v0hfGZWp9kWF1Fi4pYqwkukPrbw=MOiQ1yxd31mXg5zR6Q@mail.gmail.com>
Subject: Re: [RESEND 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
To: Sadrul Chowdhury <sadrul@google.com>
Cc: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 2:12=E2=80=AFPM Sadrul Chowdhury <sadrul@google.com=
> wrote:
>
> During system suspend (freeze_processes) and resume (thaw_processes),
> threads blocked in epoll_wait() sleep in TASK_INTERRUPTIBLE. When
> try_to_freeze_tasks() executes, it must wake up every sleeping thread
> with a synthetic signal so the thread can schedule, run try_to_freeze(),
> enter TASK_FROZEN, and sleep again. Upon resume, the freezer wakes them
> all up simultaneously, only for each thread to re-enter ep_poll(),
> observe no ready I/O events, and call schedule() to go back to sleep.
>
> On systems with numerous event-driven daemons (where hundreds of
> threads idle in event loops), this causes a large wakeup stampede and
> thousands of redundant context switches per suspend/resume cycle.
>
> An earlier attempt to make epoll_wait() freezable in commit 1c441e921201
> ("epoll: use freezable blocking call") was reverted in commit
> c511851de162 ("Revert "epoll: use freezable blocking call"") due to
> reports of userspace corruption (Bugzilla #61781). Under the legacy
> freezer design, freezable tasks could wake up prematurely while
> hardware and peripheral drivers were still suspended.
>
> With the 2022 core freezer rewrite (commit f5d39b020809 ("freezer,sched:
> Rewrite core freezer logic")), the legacy fake-signal mechanism was
> replaced with the TASK_FROZEN state. Tasks sleeping in TASK_FREEZABLE
> are safely frozen in-place without waking them up, and the scheduler
> guarantees they cannot be woken until thaw_processes() explicitly clears
> the frozen state.
>
> Mark sleeping tasks in ep_poll() as TASK_FREEZABLE. Benchmarks on an
> ARM64 test device demonstrate that combining this with freezable
> select/poll reduces thaw latency by 63% (from 20.64 ms down to 7.55 ms
> mean at fixed CPU frequency) and reduces context switches during
> freeze/thaw by 87%.
>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Sadrul Chowdhury <sadrul@google.com>

For both patches in the series:

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  fs/eventpoll.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 6cbef8b4c2e0..35992f6457bf 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -39,6 +39,7 @@
>  #include <linux/rculist.h>
>  #include <linux/capability.h>
>  #include <net/busy_poll.h>
> +#include <linux/freezer.h>
>
>  #include <trace/hooks/fs.h>
>
> @@ -1987,7 +1988,7 @@ static int ep_poll(struct eventpoll *ep, struct epo=
ll_event __user *events,
>                  * the same lock on wakeup ep_poll_callback() side, so it
>                  * is safe to avoid an explicit barrier.
>                  */
> -               __set_current_state(TASK_INTERRUPTIBLE);
> +               __set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
>
>                 /*
>                  * Do the final check under the lock. ep_start/done_scan(=
)
> --
> 2.56.0.212.g129ede20d9-goog
>
>
