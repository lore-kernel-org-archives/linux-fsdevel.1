Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA14756CB
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252474; cv=pass; b=J8F8YF6IUeOx9Gh+8pxtRN2UXUsupTHV/K0ROGE2oU9WvdeSorVLLUpgVHm27WLjZuT4QnsrS7Iar1Em5nTEJYjM1ueBAA/CQDy77+etDxSVn/aaT+JZffx3krobndNMBJ4RMkQhkQeXOswal24WVbjY7GEEaEF5UoFIx2xKxaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252474; c=relaxed/simple;
	bh=K9ufhPEWTbcGbUWPnsFi5tG5G32ivdBgHbHB+/9JtVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeLlsUZR4DxG7m7IFT4OY7iQYupt2y1OdXI4bOr5W7mpbYA6V6BOxQwmPNYFoVbV2KJW2DWnDp1Q6usFCh4a8sxwJ8pJyMG0x+nO4UW4zcYz2y+6bLWTp7dR6TU94/fL/4zePcjgeOvJgzr7+T9/yc2IrI+w8ZKC+g5tuEf3g+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxOLFp8z; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxOLFp8z"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-530e8c6fb80so215901cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 05:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790252472; cv=none;
        d=google.com; s=arc-20260327;
        b=aQi0XwzCJ9MwzmBfMsX2GX/20eUmfAg/LziBZ1c2jdE3aLdkanb5RfKuS8H85Y4ZRe
         z7UbZ0WsAM36SXD2mXHtfEifcnhsj5UatANqjjdSk/UFa17WCtdY4Kwdd5JJkLm8Apam
         do1vilzxnXFr6y/f4pqCaUNX932c7MDw0zAAeveBk6VO306uwziVOq4pHxqkEb7f1D4G
         MDnd/5lcwwM7FPp0p0EEhKUxjg/phOfkCkiHtfH7gSlGTdTVPoXNa8BUJ0dCK8StHD6h
         yXPG1/+joTFoQuOdZ9N/ItUYjqMDD92rDfMdW2NvWJsBd6fkHP+V2P0E7Zl81ybg+X7Q
         7xTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NkGH7LeMJDJfHMf9D0brPKFR1SEB0UnnB2ab6h95oe4=;
        fh=/rWFCT/ltQZSf/xBnjmCiYjwofHHeXv3SJV4S05gaDg=;
        b=cfGIYebYp8LYa0x0ttW7bCxckoAa9IM772N2r/pdLdl1HmJSlHDwW5AM2BsyyZjupE
         JSFksuI/TA4hkOQihG4Tr5WjMEelPfixS+EktaB8NYc0Zn7qo+5qxGfMpEdd/vxmO0wg
         GjBojP1c+vPx/QPiH8XmwrynNlvFqIspOUkfBzYxw9ToaDsD6sRxxzeqv9dVDSw9fOgH
         goP4efJ/F/8vZ8ru4qoECr4BUlWNQQhGnTRX/sVIfy2HOCRUBqnncPXF6JHrUz1EXMdR
         dsROkzUbdDwkQJ5sP3MrSh6QMaUYJGeLzyu3Ef6a5cZC21sDyrjd1fGGAIJ5VvWpDsLG
         ek2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790252472; x=1790857272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NkGH7LeMJDJfHMf9D0brPKFR1SEB0UnnB2ab6h95oe4=;
        b=RxOLFp8zns9PebEfZOT5KCV4HOlHPO51bVjqJXi77VlNxbLzELm0H3mDLQ0YG5FSbP
         iHnwm+NSqxJ6fMldJbBXqaoBzY68es+RwxdL1ReKIX/wWGPpQsaLPH71d6bmCOiCn6l9
         UrbDCzYsyF0jPJE0prMOVEUbVQqjAy2TKax/yaCQVXqQra4x38ey9+i3CTpaD+pOizwV
         CDMvzkDNQBIB2RnIZvX663wd8SAJ5W0bgdUnvLnzjPllJ3qiTF1IcO/N9B8KhX6PUMaU
         lE8o10voXt4eKcpDKrx6JTPn2hnLMemEJ/Lya/Ay6apKDtceIncTxBlInsqPK9sf72dq
         setg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252472; x=1790857272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NkGH7LeMJDJfHMf9D0brPKFR1SEB0UnnB2ab6h95oe4=;
        b=RzhhxQbS7WGESnlplowOH4ADsjEZIZh/R9KqPjDZdfdw4MEDhLwvffr3cELUuL/RsG
         t4rLXVrQYdddKKDC4/jdS9O6bQNl4y2g4soZsnlGS1NXZtqOp18aAUjhXUTzW3ivtSQu
         mUkUffm+a0lytjfoKEsZNVLWvkzK8Mp3rEFOd/9uYUEvWPXJcivtWtmx8Dk1AlXJx5KJ
         KeihI1Ad2IKLN7RZ5KpBDUbsvBAHXHP95WmJe7oC9yvjtVbcAHUZUJR+GEtLP8xyM35p
         igJrn1BUMJmksYKbE47n0IBdMLCap4Vm+mfk67hz4t/DP/8vXagUh7dPnIqsglC2s2iK
         xljQ==
X-Forwarded-Encrypted: i=1; AKwUvBywIPT3afBi3kawTgOr7pXPmy/Q3x7yh1XnABL62KmuF8IlTrysVwOikP0EP6T+EkXVm8NfZdfRHvfQjcOp@vger.kernel.org
X-Gm-Message-State: AFuF++l+/CkSafcaOF9+YrhTh8F4wJUI5/bmpdPeYsHfT41BScglRfX3
	OHNePtBlUqsQETcRPlbxp22PVMTRqvcVWj5ZulZzlA2JeYJWw4d6byKtrl8KvAlU2F5LadaFv6B
	1LUc6GQ5SvsIctgNRrofHDrowm5K6HxBYc3FYddhr
X-Gm-Gg: AYBFou3NfUjBZ40JRGQhCT1zC118yPOxycABG0VwrTWb6hSHQY8QrwZPIasPTL+JzAD
	WpKB+NX+NdH2NujQapFGU/UfzMfQ9QbeSKuIYFThXxgK73Q1bv1Du/mO1bT8Tflg1czD7I/MCDr
	SRKkRzHAIgiq6DPPNT5j4speaq4G0sc+H7eUfMEFbsSoqWKB/pazkYsKlM17VPII9D9WwB0O5U0
	Ic8RrssNfmdYauhozpzzxwnJRugRAv3tzmDBubnsaycUOmXH4nPtrxawGCcZkjBMyK3MQFCEO26
	SMJg6MlVM42YQoO8dXYqDYfiZEO7ldguEFQUbJhfM0G4avT3rdP/XJJzoBk8AHzw+KekzgOeIuG
	I5Y5IOT43
X-Received: by 2002:a05:622a:5507:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-532fe9f468dmr9310531cf.1.1790252471121; Thu, 24 Sep 2026
 05:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922211559.3633398-1-sadrul@google.com> <sqmmgjre63ltp2m6y5ui35hijnnwfljnzjscceunvzmzd5rh6i@us2amzhvtkw7>
In-Reply-To: <sqmmgjre63ltp2m6y5ui35hijnnwfljnzjscceunvzmzd5rh6i@us2amzhvtkw7>
From: Sadrul Chowdhury <sadrul@google.com>
Date: Thu, 24 Sep 2026 08:21:00 -0400
X-Gm-Features: AclHuK89lBo3kLTsEvW7wqXIE_9vbscPCVVxotToLaOHDgnCk-gw32aXdN6iQ4M
Message-ID: <CAKgcGXgfr-hbBj+tc--uD5t3J6Q7zhnSsm17JwU0ZdVhb1ai+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 7:24=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 22-09-26 21:15:58, Sadrul Chowdhury wrote:
> > During system suspend (freeze_processes) and resume (thaw_processes),
> > threads blocked in epoll_wait() sleep in TASK_INTERRUPTIBLE. When
> > try_to_freeze_tasks() executes, it must wake up every sleeping thread
> > with a synthetic signal so the thread can schedule, run try_to_freeze()=
,
> > enter TASK_FROZEN, and sleep again. Upon resume, the freezer wakes them
> > all up simultaneously, only for each thread to re-enter ep_poll(),
> > observe no ready I/O events, and call schedule() to go back to sleep.
> >
> > On systems with numerous event-driven daemons (where hundreds of
> > threads idle in event loops), this causes a large wakeup stampede and
> > thousands of redundant context switches per suspend/resume cycle.
> >
> > An earlier attempt to make epoll_wait() freezable in commit 1c441e92120=
1
> > ("epoll: use freezable blocking call") was reverted in commit
> > c511851de162 ("Revert "epoll: use freezable blocking call"") due to
> > reports of userspace corruption (Bugzilla #61781). Under the legacy
> > freezer design, freezable tasks could wake up prematurely while
> > hardware and peripheral drivers were still suspended.
> >
> > With the 2022 core freezer rewrite (commit f5d39b020809 ("freezer,sched=
:
> > Rewrite core freezer logic")), the legacy fake-signal mechanism was
> > replaced with the TASK_FROZEN state. Tasks sleeping in TASK_FREEZABLE
> > are safely frozen in-place without waking them up, and the scheduler
> > guarantees they cannot be woken until thaw_processes() explicitly clear=
s
> > the frozen state.
> >
> > Mark sleeping tasks in ep_poll() as TASK_FREEZABLE. Benchmarks on an
> > ARM64 test device demonstrate that combining this with freezable
> > select/poll reduces thaw latency by 63% (from 20.64 ms down to 7.55 ms
> > mean at fixed CPU frequency) and reduces context switches during
> > freeze/thaw by 87%.
> >
> > Signed-off-by: Sadrul Chowdhury <sadrul@google.com>
>
> With similar caveat as on patch 2/2 feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>

Thank you for the review!

Regards,
Sadrul

>                                                                 Honza
>
> > ---
> >  fs/eventpoll.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 6cbef8b4c2e0..35992f6457bf 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/rculist.h>
> >  #include <linux/capability.h>
> >  #include <net/busy_poll.h>
> > +#include <linux/freezer.h>
> >
> >  #include <trace/hooks/fs.h>
> >
> > @@ -1987,7 +1988,7 @@ static int ep_poll(struct eventpoll *ep, struct e=
poll_event __user *events,
> >                * the same lock on wakeup ep_poll_callback() side, so it
> >                * is safe to avoid an explicit barrier.
> >                */
> > -             __set_current_state(TASK_INTERRUPTIBLE);
> > +             __set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
> >
> >               /*
> >                * Do the final check under the lock. ep_start/done_scan(=
)
> > --
> > 2.55.0.1082.g2b9226bbc0-goog
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
