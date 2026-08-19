Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9662B443E39
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133828; cv=pass; b=VpGp2ct2agZLDdTC32fu0kgewMlGzK9gSPXm6u3WYKIKixUEOUuA6sVHKEQe7BDuuZlBQX/HPjRYyQ4GgTpxy5VrFcJLIxFxPSgI12AqH76jrm4hgxr9+l0vUvjZYvtHZZLPQ5Q3I8kXeinOxMU6jfCo+ON48X9h+z3ptu5N7ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133828; c=relaxed/simple;
	bh=cmJLDyS/SK90TDLRktAH1/ZrTfQnZNGxg9EDC6cUuMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlUYwvE6fzx3FxcUoD5khNZYk9bB5/2miRUNredenhnN2HQ6mXtWMleB6w2DvzoJDMwblSKBxzFb1NmY5vqZdXEZJYgequWXPKXS+0YgoG7PqYQhyOyR0V87jQDzlfUB5bbcjdo/WQ7cQXow6H2tDSDhssmYrmJCo3usW31HJmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DVyQeDgD; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DVyQeDgD"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-517dc520840so5568741cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 03:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787133824; cv=none;
        d=google.com; s=arc-20260327;
        b=Dskn68b2s2PHd64C4ssuNcNDtWf+X4X/69ljNTWy8UxeM6PG/i0HJfIwzNDcknq7xv
         MSKKIIMBkDjkkRBC9oi6+QJuzHRUag8BZ5RbxzLwRqD19tbRNf5xPanQIa9ytCtM0Ipd
         XsZ7vpxdIlq2gGwez4jsSDLaN6qMDYx1GVsExAC0YcnFFrPoHo1AM1GgyBkS7tuLobwx
         i9o0sKbbQNeryICbCr5LSjVhe0PuBPMlfie3hjZizhU0MgnQDBT/kNHf6aKoTR6FfECN
         E0AzexX6kcFayMbo467xdnZ9Vyepb0WVTjGsoxp7FR86fNrmAil2UTKmdux/YyD8FRAI
         0UOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VpL0J+1FV2Yhgw5JBJ00bespL89ifkpTpt7Ktp55GTY=;
        fh=cafADzHGkpzZBugaVdmvit0uIITCuBF8nBvdj9BSmRs=;
        b=RF3ZWb5mw6AEn+apdKsKO2LdkM7dn+uroG1UG0RlAIoKidVX0/lpMqltGIUKl8kpNQ
         8Nuvq3N4A+mCE6mH/bCyZFLSJ7iZRd9l368ez/gAyGMQAItUuTZxZezIcH6q96pWec6y
         UpIQ/MXQoz/hzmj+H8I/JlW5h8xdBCnSw4J1Dtcu/LTOtChNIb1bwU5Jh5nOuoPkKLyT
         n3AYlJzE/BHrW4RRgRecotFFOnD12tNPVJElLIG1C9hA0gOhngWSWvxgCsuE3v+IU+e+
         GsWQ5TvmWvwH0dJ9P5N6SSZNpFG/b4btyy8u4rZTBruSR6XWUPYFftOyPsL9xa8fXsL4
         r34Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787133824; x=1787738624; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VpL0J+1FV2Yhgw5JBJ00bespL89ifkpTpt7Ktp55GTY=;
        b=DVyQeDgDvtf0jt0JhhLWfYRsZyTRXo3uXqIvdKMqm5OLaPX3sNjXcjWH/aPhqDVVzj
         iDkufScnVSRejfH+59Oh4ttQBD0IYG7tiYXMlNOi/ogOLmStz4rNF0hTY5+7JcpI93I+
         1Ini8Ivwnhb1pcWrWlm0/U8wR6FHikzZpvbXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787133824; x=1787738624;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VpL0J+1FV2Yhgw5JBJ00bespL89ifkpTpt7Ktp55GTY=;
        b=O9vzBPoS8jIQXRN/Bt5OtCWyF3YStHbiog/Eif7kZBFcMkxwOLyzl9c+in5n5Eyjn6
         0sC2p3Vj3sqfftWsGH1F686ncDUh7eqYEaIbHiqH7n55jMnR2eersTxfgDhsPL0pdwxB
         Nddg1O+Sda1L+sY1xg+NRBrwyJs8dAMKiN1m3P1PERTR8dxMuVrdIRItTLneNBPa9VYM
         Ua6U2U7KXvKly9drZqRBhCQods1TQTEz+FNS3oyGpmCCOejk8Mea7d/sqj4c7t7fHOeW
         LxNMvYid/qLBvRwtOgnF6Lm5hFzGWP+OfrIL60jLANgzBUi1MImdSEkxjZANT7mDmLAD
         vq3g==
X-Forwarded-Encrypted: i=1; AHgh+RrhsaGvJKzj/D1OMpRy32aW2UkBcyrO0K3xVzZlf+Rg9RZS9bj3g+IkUQ9ZA8ki4XAvcqN0rrtYUvxCHue0@vger.kernel.org
X-Gm-Message-State: AOJu0YxNG6uw7hL/gVsoE0u9rn7uyCxEdN6iYIrZhi1I08WyYoruI6Xt
	NwAQo5Pu2AsPi0ATr6fPIt4eLI1pcEjNfspdNzODm0cy51WQmL7lcbCdOP483DvcfrfHi8U53Oc
	V0B41+7SjVJg2Y9SM0zdkQUXwe64Vx5nseUSR0UbTZA==
X-Gm-Gg: AR+sD10ApUa1lW4G/khlueF1JRk9OLXjKv9K36crrlDh/aqw5nZ1zH+rx/mKSCV5v2o
	1VbcIMy9fpznGmooUM/Km6OsbEUe1CENMi5H6TvbApeT48z4yxDr6FdPkT8dHChuncZOgGa4zaH
	Ckb1ZBSi+uzYFIF7CbvD/gKTNZiH9fLQkoT2P7Nm8UrgU7aDp3RWUk9bVkObYUqvh5OyZ6GZ/uX
	H10K6DLOKl5ME0SDIzqzyRcRv4LXWg92gyrnFLExOlavopaTdGTMOTYU6Ls0eVmahf14H7i8jDH
	7BEFR0UDTg9V8Xtq+AZe5ggfeThkB9bmNwUcBRXLSmp9B6yX+Mmq2hrZYnwX5yr0hk1EwFTLMKY
	o
X-Received: by 2002:a05:622a:cc:b0:52d:78c9:9377 with SMTP id
 d75a77b69052e-52dd5cd88a0mr20375901cf.36.1787133824268; Wed, 19 Aug 2026
 03:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819023542.561653-1-senozhatsky@chromium.org>
In-Reply-To: <20260819023542.561653-1-senozhatsky@chromium.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 19 Aug 2026 12:03:32 +0200
X-Gm-Features: AcwNN1VSkBZXpXiJZbM7YAi7AdJBmXmHJpLQ_iikKMzrlDoXgsNzziLuV_-j2Rw
Message-ID: <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[Cc: fsdevel, Peter Z., Rafael]

On Wed, 19 Aug 2026 at 04:35, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Suspend freezes tasks in random order and doesn't take into
> consideration producer-consumer dependency that may exist
> between tasks.  One example where this can cause issues is:
> fuse server getting frozen ahead of clients, which then get
> stuck waiting for req answers that never come (the server
> is already frozen).
>
> Make all wait-event calls in request_wait_answer() freezer-friendly.
>
> This, however, doesn't address all cases.  E.g. in-place
> PM-freeze of a request_wait_answer() task holding a contended
> VFS lock still will block suspend.
>
> Note: this uses TASK_FREEZABLE, not TASK_FREEZABLE_UNSAFE,
> which may trigger debug_locks warning during suspend (if
> request_wait_answer() task holds some locks at the time
> of freeze.)

This is not okay.  I see the "no new users" warning on
TASK_FREEZABLE_UNSAFE, but this needs further discussion.

Existing users of the _UNSAFE variant are NFS and samba.   I haven't
checked the context where these are called.

Apparently __sb_start_write() uses the safe variant, yet I'm quite
sure it will be called in various locking contexts.

Why is this unsafe exactly?  Does that unsafeness apply to
filesystems?  If so why do we allow freezing while blocked on
sb_start_write()?

Thanks,
Miklos

>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>
>  fs/fuse/dev.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 34106f6e66a0..42098ddc2587 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -701,8 +701,9 @@ static void request_wait_answer(struct fuse_req *req)
>
>         if (!fch->no_interrupt) {
>                 /* Any signal may interrupt this */
> -               err = wait_event_interruptible(req->waitq,
> -                                       test_bit(FR_FINISHED, &req->flags));
> +               err = wait_event_state(req->waitq,
> +                                      test_bit(FR_FINISHED, &req->flags),
> +                                      (TASK_INTERRUPTIBLE | TASK_FREEZABLE));
>                 if (!err)
>                         return;
>
> @@ -717,8 +718,9 @@ static void request_wait_answer(struct fuse_req *req)
>                 bool removed;
>
>                 /* Only fatal signals may interrupt this */
> -               err = wait_event_killable(req->waitq,
> -                                       test_bit(FR_FINISHED, &req->flags));
> +               err = wait_event_state(req->waitq,
> +                                      test_bit(FR_FINISHED, &req->flags),
> +                                      (TASK_KILLABLE | TASK_FREEZABLE));
>                 if (!err)
>                         return;
>
> @@ -740,7 +742,8 @@ static void request_wait_answer(struct fuse_req *req)
>          * Either request is already in userspace, or it was forced.
>          * Wait it out.
>          */
> -       wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
> +       wait_event_state(req->waitq, test_bit(FR_FINISHED, &req->flags),
> +                        (TASK_UNINTERRUPTIBLE | TASK_FREEZABLE));
>  }
>
>  static void __fuse_request_send(struct fuse_req *req)
> --
> 2.55.0.737.g08866a6d13-goog
>
