Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C86130EF6C
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243032; cv=pass; b=KvHPAhOtPO7ka2HNvpctn7xNwsZmX7kBnrFJERWrFmS8a1Ae2h8YLTWkqonbD20SVGTK/GN8goOqGk83SXcd/RJlhi3srdm2E9xtrlvLB+LRJeGRv+r/zlsfg8qpkMXec42nFZvri5TubR9vCEXwopEsADkYOfNWKdog5w/pAV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243032; c=relaxed/simple;
	bh=z5iFY2khC7ou01RIHrOW4R4MROI8kR7TzjrYDShiAvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bA2nbO2jIhj+C2fkkl782Pgs67TCtRjtTyYgN76Jjk98h+IK8fDd8Tn/vxLV4cdMS7pckM1M7fj7N8DezicccPS+lizl61ZDK7nivR5rc0za+S3EykKvyahSIHJTCJkQuurCHLLcLi5hNfy8EzEf+c+75+QHL1Z2DbPRCRhU+20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEQXgj4+; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEQXgj4+"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-671ff4b716cso2685119a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 01:50:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776243030; cv=none;
        d=google.com; s=arc-20240605;
        b=Yow86I40s8gCYk0uUo0mTEIfzw0xOT+xiWBgtoYS6ufJrINS8iqvxrz0qn3C3cnLHG
         LlO8UKLwASwaVgSiTvKbrBTHWQXUO97otJ9YDktRayj2UD2ysl4J9qhN3TnIJWzlU4Ws
         gvdkg15f69tHdnqJRPDCxT9+7le1eUpFClAOEglgu8fO1hRCpVgjPEyLgvGZcZUHK4M7
         /9HcjEVOvMAb8lY1jjjR6uqmqKrsIdi5h6eGpdnUc1BMWpjdxRPj6KkRVDzHKWy5piZ6
         bksgTZG0vnXkBhLgDaLlm1D1vG4Rx8lMowNsro/9vh97lC6437E4exEwEVl6cr6iYTFg
         Fw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LfQXDhDL8kE6GGuwypTVdwLFZ+2G2+Ay+ewe6ErDBf4=;
        fh=mujdLnNCoPDbIpROT9ofzjh6CXIvvHnc8Ln6npemIcc=;
        b=X1jcs8cAvYFvHx7XflLxd+SwAW6skO/vOJChGQ2ksC9OCD5vecLWP+BgsuiarK1t+v
         XmVfEBLpcNkjqCm9Q2IlAqyVVClJZWLhT/Mlqb8cA2fUFQpNvq8fMD5Do+6QFmplhZd9
         c41rmQGBfnw8cBmiGH6lZAEcIEwooJxkkZBFOFX/L/FjXgWCci512Apjn7RV7sliNeAv
         b8w1uh4huFnqtZQD2d4GC/ZzTsAZm7i/RFIAdeGonGlDXoosZ3BPlFoGoavdfbPB33ct
         CXrIGDIelMIlMsVbjFi8s7O/jQdipRwNHl+wbwz8nzelSB57FQAz2uvp50g9mcCtsnxl
         g2Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776243030; x=1776847830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfQXDhDL8kE6GGuwypTVdwLFZ+2G2+Ay+ewe6ErDBf4=;
        b=IEQXgj4+X61gTxb/OxsTOkeF2Mut13Rajb//5BK2mGtYsCszxHH8X+esSbkwacjSPS
         o68nIEGFpX9lBa+ye1qCG29ZQvmJcr9mYgQ13yBdXd7sWnJx+9gl4lW+zK2jD493zMtN
         H4rNAP4me3Gax1oANu2sGclkPPIDqF6gnGBvnCUgHAAQ9/FmRM6iOkyeRVOVd8VcxgHD
         ERTSMGg3mn8+1UkvtiboHbBv4n+pQ9TI8AcewxPvKClJYHAF4PdGOoiAi6umN+qXTO/k
         AdUqEBcEe1UuvJUIkrQu7vAy96TIiwUAI7cUWP0I+nc+5AOgoH6FgAKZVQVGfN/rGk7X
         TGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776243030; x=1776847830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LfQXDhDL8kE6GGuwypTVdwLFZ+2G2+Ay+ewe6ErDBf4=;
        b=rjLSCM+MOVbMAXB2CufQbE5/sjjd3D63iV0eTSJgKPJakO26/BvdJV/069Pz8FmTnU
         h1/85lE8c5PFTcBI9NUt7Ui/kcnNa/rdlWHOCy3WNv1cJpi0zRF2zODSzwp3AALBWi/Q
         7x4HzMNIzTs0mEn4pPteSBlt++xvx7Qo43xG3DE4hvc3r4UonC749W059KYWvzltuo0V
         2e0DKL2WCZs8jnszncbKyY7L68YLazKCJxjwZrDpcRAWwa9REC871Hr4Io3GdVEul0zX
         2M60BfZr1LXHaJ6Ze8UnATK1AgdEgWXD+RfeQsFKCAMi/J/EBtS4VlwgPFlhJHJC2K6g
         Yx5A==
X-Forwarded-Encrypted: i=1; AFNElJ8DhkD9OF4H+7KTQ0PaX49R8QbxPpU2HmW3ugIMtw5Kkms6C/pQAq+3+eC/p8MIgSm1eOk1xisc42EIyD/c@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIVsLr3jWBYcfUOf2rkJCw99RuJ6NLGouAQMjbLml6smjsulu
	kDeH6R5ZfH8BsbGr4+fYo+VDnoK+dbZ/BQJ0IcloF1EigX6Hz9VuYxAvGh6VZue3h0i47hzZ7Dp
	5sRFrtiEWfxTfHzXX5GFso4ENojPDbn0=
X-Gm-Gg: AeBDieukOUXgRM6LZcdVlC7yGABW8YzpK2y8BpVoK71o6bOg8WyE7smAtdc6jne1la6
	muGccpnrEbRxnEb176Q6ZtD7sS28xmaOYKfhtiEWu2foh+FeDbTP+tQnZ7I1iVQjwTLXIQiGX3Y
	Yslhb/1sSdV3hNB5EYAnJvgr9VEa6OwoG+P7kfarvn1+GG8S8pbWRQ7UhEbWcb5vH5gQKjpSnUk
	7NTTiJhDAkpkToET+1F3sHd1ItWgqkec1PmFp2CePV/wp8d7txQtAdq7j2jjJ+3ZWuJyWql+FWT
	YZ985ZBf3Hevhv4YGMQT590AuzbxnRE0o4B5S3hsEfMuC/sn04XUjGz56a/wzQ==
X-Received: by 2002:a17:907:e113:b0:b9c:6ef1:ed18 with SMTP id
 a640c23a62f3a-b9d727aa4fdmr817355766b.25.1776243027719; Wed, 15 Apr 2026
 01:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414185037.3541089-1-ibrahimjirdeh@meta.com> <20260414185037.3541089-2-ibrahimjirdeh@meta.com>
In-Reply-To: <20260414185037.3541089-2-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 15 Apr 2026 10:50:16 +0200
X-Gm-Features: AQROBzBdLoUzCpOHcTdckUA-kE8mcaJI1AmcPM8lfa-HqKHJ7rg3UD6nS_V-mxA
Message-ID: <CAOQ4uxiZEX72_qefLrfwjULuPyhvX3bsy7z-7U1VE8bnbYOEGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fanotify: add restart infrastructure for pending
 permission events
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 8:51=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> Add fsnotify_restart_event() which reinserts an event at the head of
> the notification queue for reprocessing, without merge, insert, or
> overflow handling. This is used by fanotify to restart permission
> events when a queue fd is released.
>
> Add fanotify_restart_pending_events() helper that walks the
> access_list and reinserts each pending permission event back into
> the notification queue using fsnotify_restart_event().
>
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/linux-fsdevel/sx5g7pmkchjqucfbzi77xh7wx4wua=
5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn/
> Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 27 +++++++++++++++++++++++++++
>  fs/notify/notification.c           | 25 +++++++++++++++++++++++++
>  include/linux/fsnotify_backend.h   |  4 ++++
>  3 files changed, 56 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index d0b9b984002f..8203ecf5ea39 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1095,6 +1095,33 @@ static ssize_t fanotify_write(struct file *file, c=
onst char __user *buf, size_t
>         return count;
>  }
>
> +static void fanotify_restart_pending_events(struct fsnotify_group *group=
)
> +{
> +       spin_lock(&group->notification_lock);
> +       while (!list_empty(&group->fanotify_data.access_list)) {
> +               struct fanotify_perm_event *event;
> +               int ret;
> +
> +               event =3D list_first_entry(&group->fanotify_data.access_l=
ist,
> +                                        struct fanotify_perm_event,
> +                                        fae.fse.list);
> +               list_del_init(&event->fae.fse.list);
> +               spin_unlock(&group->notification_lock);
> +

Do we really need to release the lock?
Do we even need a helper?
wouldn't open coding fsnotify_restart_event() be simpler
without the dubious return 2.

> +               ret =3D fsnotify_restart_event(group, &event->fae.fse);
> +               if (ret) {
> +                       /*
> +                        * Group is being shut down. Reply ALLOW for the =
event.
> +                        */
> +                       spin_lock(&group->notification_lock);
> +                       finish_permission_event(group, event, FAN_ALLOW, =
NULL);
> +               }
> +
> +               spin_lock(&group->notification_lock);

looks like a double lock in the shutdown case.

> +       }
> +       spin_unlock(&group->notification_lock);

How about just one wakeup here?

> +}
> +
>  static int fanotify_release(struct inode *ignored, struct file *file)
>  {
>         struct fsnotify_group *group =3D file->private_data;
> diff --git a/fs/notify/notification.c b/fs/notify/notification.c
> index 9022ae650cf8..2d377122c904 100644
> --- a/fs/notify/notification.c
> +++ b/fs/notify/notification.c
> @@ -129,6 +129,31 @@ int fsnotify_insert_event(struct fsnotify_group *gro=
up,
>         return ret;
>  }
>
> +/*
> + * Reinsert an event to the head of the notification queue for reprocess=
ing.
> + * No merge or overflow handling.
> + * The function returns:
> + * 0 if the event was added to a queue
> + * 2 if the event was not queued - the group is shutting down.
> + */
> +int fsnotify_restart_event(struct fsnotify_group *group,
> +                          struct fsnotify_event *event)
> +{
> +       spin_lock(&group->notification_lock);
> +
> +       if (group->shutdown) {
> +               spin_unlock(&group->notification_lock);
> +               return 2;
> +       }
> +
> +       group->q_len++;
> +       list_add(&event->list, &group->notification_list);
> +       spin_unlock(&group->notification_lock);
> +
> +       wake_up(&group->notification_waitq);
> +       return 0;
> +}
> +

Not convinced that a generic unlocked helper is needed
considering that  fanotify_restart_pending_events() is likely to remain
the only user?

Thanks,
Amir.
