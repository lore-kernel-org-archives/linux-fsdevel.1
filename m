Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4634B404
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658232; cv=pass; b=Sw+yJK7MahlSdCLDMmD9v2VeSIrJXvuF88mwl+cDuN7qROHGeoAtGLCJxhrLz1BpigJZLO/X8V0VXd/s/YDnvlRgmpvsPTUIMv9Pl20IQRJNQVWkcrwApkxJcxBm8xLUdRhLkQwMZiVSgfDOeokfI2sWVzYKFq6tOyAuHnCTRKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658232; c=relaxed/simple;
	bh=NwpX9l+EACTk9zl6T0f95KS67DnbD2p5nIHifFAszVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGOqzeHg9KPI/VxYsyG6oT5yWdMSnyRFDNAYlSs4S1rJc/aHojoGwrWGBpXWQ7zNwH8g4dO8W35PodFYAFVLT7AMVzdFnnrkTQUh+P2uVo9KiDTutmo2Kb6cT6SkZLmQoDTXP1q/K+XKDd3aDFfXog6mQDTk6gDnZtVauRAFv/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VkknzKH6; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VkknzKH6"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cd78a4ce8dso631648685a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 03:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773658229; cv=none;
        d=google.com; s=arc-20240605;
        b=evBNJjwf1UzjRygR0F2hiuL/9V1txyDuuR4+9A06/opQzJDb/XaBNAoKuvrjH1G1Ep
         CDZBYfubFwKFCFwFLQ5eRHi61acdOii46jkWhDbsFv/J9rX8OVftacM5b2qc4a7vJNdF
         CJvNOBd/KJe23zsFKAHn2GywM851G6vIQF09P0XKu/w1W5M3fLiJr7jXyggaaq3t2nDT
         danMY8nmA6DWicXmOzXq1VJJzGFMgh9DqU1twBzU6LHt4ugKHTFwrjGvyiqYSVLQGIYv
         69dzloMHhlbkRxP1+B0Iot3tteNDsJdQozCfmG/4gEuAR77ZNsuPM+ti9xc+coDfGYTi
         Kwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Jajt5K0Wxh0uaGzvGhidlbwupunJ0S+BEGj6jJykRg0=;
        fh=Wwqbeo5Mm2WcU1oLJMZzQ347upBxnq9aFb8tIJTq5aU=;
        b=YGNbbU0cJraWqf1wN+8hZjN+DugR2I4Q4d8evnueqbXbr6u4eYwjaDl3ZAtwogKots
         D39yeeELJIEb8diSZcdEel+Ty9o+V//0CjYjrW60bAmLZuPZ3VC/mdyRmgVTnqn429I5
         NV9Bh9Zeuqfgib2AI4PuoV2MjbEfKfGdahoEreaBxLw9bKM6VXLiM1/xK3LweOThXSBR
         6MwLkTJ9LSf/497n3dsQu5P3i2CtzCDXkkO5E4LoScj9EG1TzGHf9GyT4+cAm53dS6zi
         xmYoH8fYPQ0L8cZ582cd+NGl6LgW5+1BFNQVFpuixm5QXAxZwd0sfANWEf0692ZZeMd7
         dnVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1773658229; x=1774263029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jajt5K0Wxh0uaGzvGhidlbwupunJ0S+BEGj6jJykRg0=;
        b=VkknzKH6jrALBHwk8j1OKCAu6C3mhpLX1SmCK+XjKC+yS8M6Vbzr/B8VucsftrUsQr
         fzLM9SL6TAjMWOSNTRpBqWkqNyPTbtvJNNy1YG7rVuOiWjXQNGU4Hs5p9E9GIeeIvynV
         n2aGMLgox9H6vEfGTtz3IKWc6cvSS/GhgzMg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658229; x=1774263029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jajt5K0Wxh0uaGzvGhidlbwupunJ0S+BEGj6jJykRg0=;
        b=bHD1vwbAIM3R0Y+e6rrNqptMV4vSYUx7Aqj2kYLUd4dzda4x8KHHjtJAnYd14iHyMJ
         oEdviFsqcScetAYC1NWMQRt9PY5K43nF5dGs/MDrL5zCDdQpT4myQiregFM1HAOrKdDx
         xFxoygosESZahV3/IEMEmMWvxaMsQlhr28aDKEE11eRAwCzwVJDksD64JX4AWH46iC5n
         4JqM+RRrR3fnrshR78P5OzNnVx7bIWBhETfexh/BdrXflkgy8n2HPWuepxYXBEY/wRDe
         TlvqCH8jSyOighdZodOREh9jDQ2AYSv41MwGpS9yOF7Xf0MTgsgzX2Q+HpZNGC1okEvq
         QtCw==
X-Forwarded-Encrypted: i=1; AJvYcCW51NpfNbIdjV69tcgvZGJ+g68P+wqdAkbRA3ORRTQjvrpxP3WTkSqElKOxtaD7ABQeQATo0ev3eqdQTOLM@vger.kernel.org
X-Gm-Message-State: AOJu0YwoW4F+aQilfqa7PiLcb2Ue4CBXjb0TJlPuctXFXbG6xNGcZjmD
	oqdo4GGQ4vkghpxwPP0MKVQwZplrhV/mfne3fnUp8oqJMKITCAH5hrCWpxfQqhEy7FJ4TQaQIXc
	Nqc0aahKvERZtCyb+k0GS8fIWK30YQu35ZytI9SSGNQVrbCr0zWp9hTw=
X-Gm-Gg: ATEYQzyjKP5HAsgv9ryP5yZHvX3gH97z+4ipaBOAjGPche6hMzxlDKwYS5gzdj9bfJk
	CpvvlpIJbjbZbAasPwtSeepfV+uQoTQbWTGMmJky/dutN+0g703VGztyqp1iIpw1/fk6428xg8V
	TBaOTeRyMa6GvjWWMDYwVTYLfN/FNMeuO7136HDtjvu6eo7Sda0zVD32h4aJl1XjacYWtbi+mo2
	8R/SGGO5pa3OIqn6z8uIOfyned4sNn+JZUQyctrwaOtd50RkALaFDxOr5/h3nn2QEGho8WHMyBc
	rpycYw==
X-Received: by 2002:a05:620a:19a0:b0:8cd:b38b:7390 with SMTP id
 af79cd13be357-8cdb5b5afafmr1707589385a.47.1773658229486; Mon, 16 Mar 2026
 03:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312194019.3077902-1-mszeredi@redhat.com> <20260312194019.3077902-3-mszeredi@redhat.com>
 <20260313222818.GF1742010@frogsfrogsfrogs>
In-Reply-To: <20260313222818.GF1742010@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 16 Mar 2026 11:50:18 +0100
X-Gm-Features: AaiRm51Hmx6UDDTu7JucMDpjm2VFu-o3YDPMSv3ThxI7M7CqC49ktjghVrez_HI
Message-ID: <CAJfpegtfG5Eapda2h9uKRa-ibvi-1hatWKdLDKxakij8B6N1RQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] fuse: add refcount to fuse_dev
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Mar 2026 at 23:28, Darrick J. Wong <djwong@kernel.org> wrote:

> Humm.  The previous patch introduced code that does things based on the
> null-ness of the return value of fuse_dev_fc_get().  I /think/ code like
> this from fuse_device_clone:
>
>         if (fuse_dev_fc_get(new_fud))
>                 return -EINVAL
>
> is ok as long as you can't clone a disconnected fuse_dev file, right?
> But then there's __fuse_get_dev, which does:
>
>         struct fuse_dev *fud = fuse_file_to_fud(file);
>
>         if (!fuse_dev_fc_get(fud))
>                 return NULL;
>         return fud;
>
> at which point a disconnected fud could in theory leak out to other
> parts of fuse.  Is there something to prevent other code from
> dereferencing fud->fc (which is 0x1) and blowing up?

These take a struct file so ->release() must not have been called.

> I guess the answer might be that you've closed /dev/fuse so there aren't
> going to be more requests coming in from userspace and all we're doing
> is tearing down the fud?  But why not set fud->fc to NULL on
> disconnection?

close(devfd) being called before or concurrently with fsconfig(fs_fd,
FSCONFIG_CMD_CREATE, ...).   This is not a practical scenario, no sane
fuse server would do this, but it still needs to be handled.

I'd love to simplify this, but it's either the xchg magic, or a new
spin lock and a status flag.  The latter is arguably less subtle, so
I'm amenable in that direction.

> >       if (fc) {
>
> BTW, is there a chance that we can race here?  I think the answer is
> 'no' because only one thread can ->release the fuse device file, right?

Yes, ->release() can only be called once, so we are sure that fud->fc
is either a fully set up connection or NULL.

> > -void fuse_dev_free(struct fuse_dev *fud)
> > +void fuse_dev_put(struct fuse_dev *fud)
> >  {
> > -     struct fuse_conn *fc = fuse_dev_fc_get(fud);
> > +     struct fuse_conn *fc;
> >
> > -     if (fc) {
> > +     if (!refcount_dec_and_test(&fud->ref))
> > +             return;
> > +
> > +     fc = fuse_dev_fc_get(fud);
> > +     if (fc && fc != FUSE_DEV_FC_DISCONNECTED) {
>
> AFAICT this is the only place in the whole patchset that even looks for
> _DISCONNECTED, which makes me wonder even more what distinguishes it
> from plain old NULL?

fuse_dev_install() is where it matters.

Here we are testing FUSE_DEV_FC_DISCONNECTED, because virtiofs will
get here without fuse_dev_release() being called previously, so need
to clean up fuse_conn.

Added a comments.

Thanks,
Miklos
