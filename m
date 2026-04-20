Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647923A7F41
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708480; cv=pass; b=kEmRfSnOSwfBpP8LcZVTxBmrIti7GlaBC9ntrA5vWzeG8bjPvdiFZcSgDoDYxCigp6YKnNadbrgkVdX+yq+8Q5IN3Xb8ML5noS6Gkhm07eWuivR/grSxi+1wfOz553yQt2GqpA7LjUI7EuCKov7CxA8HogUcSRUJ4Wyvb0rYW1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708480; c=relaxed/simple;
	bh=g1cSBntokv7YkBe6TqEdHX6PPUkQz5GmhJar7ugLnOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hV65IHW/A95DoaMR/FrbSAlyJiKjHSV5qlIC6x0zWLCPql+2xucaxWrT1ZA62+ywcsEO/fdN/qNB7i2lQR4JfjApbV8JVQmla/9goM2nNu/kvFc7hrFWErKg1KhYkliksD6H9tNwZLti7qdpRz7Z6x6fKVQsqwec5poYH7FKJvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxIN7tuh; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxIN7tuh"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ba6b39871a3so285373866b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 11:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776708478; cv=none;
        d=google.com; s=arc-20240605;
        b=iElgJrSVFZmEhKMvDhKKPl7aKOkBSNL/N0QC2N8eJSBX7hH/Zx1zOcEDWDpxEFkiM7
         94uEvbRms5V7wWEDaEEWzPqfeHZtXSbSMFvy3n9a6Ifdj+5WpF/QI07CS8Z0LMetRx+D
         Os03T4juqPr38y3u8sGasBpjl197JEj2ZFPStpRcq8FPzh5kIdbSGGQ3VZqagXnAfiaa
         m22/MSG+ftyZzqWaPmA9mQEMI9eVX6Qh6ZCW8LpV7ay8TB2y0GsQyvcX89ggVGxoWYLE
         kYhf0Bb3EKw9nQVP8kedk5jYoO6Gjyc5IMeziJEwkFWq5H3LhLaMHivYH/1I7u2mnYPf
         P/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dmS7Tw7YTF9ARk3bJQRKz0o4tmykVgNuBd5wVNu5wZ4=;
        fh=BjbMrW6/J5S6DoGXXiP3VUNq0Zc/1Tzirgb4Dnjs7NA=;
        b=B1yTdumulQErdnfVmYolyOgzUU0/mggCB77fG/X3enGD54DSgyTP9CbGUmfp+sWR9k
         ynWAJCusGc5Dwj5a/Rg7BYb7HNdnXbnmV/S3WzOxTVEw3rZ+4lEUU6t5QsVJwq1zH5aP
         X9FlYGxAYm+3WUvVsNuhDLDeDIAid786BHJO9g1WZ4vAdUk7wzDqWaWQ3c/h2uqrI1iU
         1pt9i2uYf8YzhUZ4nA4o+FFjopEE7gKqt/ta4ZYKhmcsmtu80JxSllK0s1nV/etCR8oi
         rGz8CZM046fdaBK3zsZa7LZ42IAe3eDSs+jkMRnO3GzDKQsd1z7MWwfinVqWBGT1iGm8
         Linw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776708478; x=1777313278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmS7Tw7YTF9ARk3bJQRKz0o4tmykVgNuBd5wVNu5wZ4=;
        b=oxIN7tuho2kRV8IbVMxygXnCXQ21xJaVNWI+XMHBRmkbU/elJtcc2x30AX983FVaEq
         XdOBaqWE0zrDYBhUkWOMaY0AtDtuqUs8EG25io0GjSiWYKDHPPx+neq1227w0PWbOhYU
         0zwBr6BcSI4abJ64Mzyu9XdXBUtpMz+tuPcP4qGQMoyOOqlBoU0XPTxMYnWvQURTGywJ
         SgtYJpqGG/hKwshzP/TbQpSAPlz/nXjg5iKnvmRUr2D5lgO+Ej8qRQ9QyggUyhfB8Ynq
         an+cSwA+UQeOc4XNmw1CsyHj+9PiIau9aO4tGpu3AvavnF8XFhj/wFsTOHDTwDmqKecR
         IUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776708478; x=1777313278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dmS7Tw7YTF9ARk3bJQRKz0o4tmykVgNuBd5wVNu5wZ4=;
        b=DwchqBKQn8g3CuSuCvD+EIy//jQRW/LsKKrBM22HiuO+E5SJWmFptq6aZPzNZjpS9x
         Pzrc6NeRcTsHt2C6e04gklTArfr0dj2az3d1d60FZ3D5tK5fZkkJMFbpyusa0R6Gx71T
         YVbzW+WUcwixMUpWDtKHUDmwCBYy6e+FWQEyPgrY9k/hB3Ac04Pk6O67VhJuCxiZj1I4
         7l4TYV5rslu/6+uweUXR+XtaGf2uePadgeY5tVWJtbwLmtkuXsqRrCZHvFAgCyDh4Myl
         qPxN4HKsj9pz/huFUbUiLSCRWRUGl+HG3Hb1ko0H4dhLi5A8dSoACPm1FYczqfD9pkIb
         KVhQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Xw2GLWeEy6ElKjEx8bjkvNojxPESbtbFjVxuzNoTowIIjBTqqnxFPnM46oi+1f/0O+sp3bYDHKMAT2am9@vger.kernel.org
X-Gm-Message-State: AOJu0YxGqXP0Ohthdkk8e5JqP+a0MokgIDpxkZnZkst8nXQLZBELffVq
	A81eVbKVCl8J9aeQHioR7+cmnzbinTx7m18YfsF0kmtFg3MARh0tq691nW9mtx5M3EnP+p0Wnw7
	GiaVRIl09T2ppv96roE+aDkuIgAxGyho=
X-Gm-Gg: AeBDieunZl4XsIIgrXmOBWWAbVfnkJ4HWhL++w2bmyoDrtwCt3kRNBv56bYAQY3/mlc
	FmsIeT9PWbxalEnUlPJEuVTIfDLK8Zm1E29nUcqDC3PbQLomo3IFzZnha6aEKC/p7qERuFpDo9T
	ZQiKn7BDqiCjTrYUdPh4pXdMmXUVw5h6KCVnGAzBq3ZOjP68t0uCUnv1cd7yDVnQu0YUDNa3kvu
	FsiRu92s/jKkHwd8j/sw7zNyoOjMeHqBopvNcims3wlzRIA4WCyNfK8vmvzSO8pZAYK4jrkJQsN
	v4Mwaecvf48R7zVsmuot5lKFM7QCm3bq+NW9UptC80DkXlmVObF8
X-Received: by 2002:a17:907:3f17:b0:ba3:7d65:c373 with SMTP id
 a640c23a62f3a-ba4218ef69amr777395866b.10.1776708477248; Mon, 20 Apr 2026
 11:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
 <20260416194844.3874004-3-ibrahimjirdeh@meta.com> <bcodsu6plppnwotjuisi7kvwkftpennowemslxur33qhtmd4qp@wc536gzxu53m>
In-Reply-To: <bcodsu6plppnwotjuisi7kvwkftpennowemslxur33qhtmd4qp@wc536gzxu53m>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Apr 2026 20:07:45 +0200
X-Gm-Features: AQROBzBifSUZn2OnkUGOfPHbZA543jsz9VYQGc0DX5AHxgVeUco7Ru8tDL6KUNU
Message-ID: <CAOQ4uxjXLXOc=peppj705C+PfR32102VCthCufeRNXTLqQfOuw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fanotify: introduce restartable permission events
To: Jan Kara <jack@suse.cz>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 4:37=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 16-04-26 12:48:44, Ibrahim Jirdeh wrote:
> > This adds support for restarting permission events. The main goal of
> > the change is to provide better handling for pending events for lazy
> > file loading use cases which may back fanotify events by a long-lived
> > daemon. For prior discussion of approaches see [1][2].
> >
> > In terms of implementation, we add a new control-fd/queue-fd api.
> > Control fd returned by fanotify_init keeps fanotify group alive and
> > supports operations like fanotify_mark as well as a new ioctl
> > FAN_IOC_OPEN_QUEUE_FD to open a queue fd. Queue fd is used
> > for reading events and writing back responses. Upon release of
> > queue fd, pending permission events are reinserted back into
> > notification queue for reprocessing.
> >
> > Control-fd/queue-fd api is guarded by FAN_RESTARTABLE_EVENTS flag.
> > In addition FAN_RESTARTABLE_EVENTS can only be used in conjunction
> > with FAN_CLASS_CONTENT or FAN_CLASS_PRE_CONTENT, and only permission
> > events can be added to the mark mask if a group is initialized with
> > FAN_RESTARTABLE_EVENTS.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi=
6bi44canfsg2aajgkialt@c3ujlrjzkppr
> > [2] https://lore.kernel.org/linux-fsdevel/20250623192503.2673076-1-ibra=
himjirdeh@meta.com
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhN6ok6BCBGbxeUt9ULq6=
g=3DqL6=3D_2_QGi8MqTHv5ZN7Vg@mail.gmail.com
> > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
>
...

> > +
> >  static int fanotify_find_path(int dfd, const char __user *filename,
> >                             struct path *path, unsigned int flags, __u6=
4 mask,
> >                             unsigned int obj_type)
> > @@ -1640,6 +1730,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
> >       int f_flags, fd;
> >       unsigned int fid_mode =3D flags & FANOTIFY_FID_BITS;
> >       unsigned int class =3D flags & FANOTIFY_CLASS_BITS;
> > +     unsigned int restartable_events =3D flags & FAN_RESTARTABLE_EVENT=
S;
>                                                   ^^^ Can we perhaps call
> this FAN_EVENT_FD or something like that? Because I can forsee we will fi=
nd
> other interesting ways how to use the scheme with two fds and not all of
> them tied to restarting of permission events. So FAN_RESTARTABLE_EVENTS
> will become confusing at that point.
>

FAN_EVENT_FD sounds too close to event->fd and to FANOTIFY_FD_EVENTS
Maybe FAN_CONTROL_FD, which is what is requested from fanotify_init()?

Thanks,
Amir.
