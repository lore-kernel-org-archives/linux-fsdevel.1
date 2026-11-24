Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795525703;
	b=1esG+2yThKLAfNb8AbfXrPZHwrIkmipOo/nIEFiigDxjqcjScpf0PfNfLdxl+Y/l9p1o
	 9WjZtEgt5J7hTGAitxPd5V4uj1UbTKNzV3IK/IKsLaFhV9j4/hSUBlo6jSsDLkfJwbZK8
	 y9h5RwZikjkWMTftrnOrAxe1o811cVWEK0Xp02fF6zU8VzU0YcDrWdDhgiShELlAXko9Q
	 TwOlo4wM780Slsa0xhfGeofv7AVcn+92xo+V9rHAio1DnfTesiByyNpbjns7EJmLHaBQB
	 QWxAjCR07hLyXcg9rxOeyzlH+PZ3ifdt0sDsUZvTDfFORfS8UaWHgNNAalDUShrYatw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525703;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AkNAAAtF4o2icxeAY7gUNPpfbhQGP8DAKlQu3i/mLV4=;
	b=iq2QWAoAGRJYdu6poqi5DczbMDy++5Fd+u+9FDQ75vwpJJRA8pX7vGrazwKUUqGXG7Oy
	 FezobRZWcS/n1hED5BuZ0QW+V5H2vqWNvNQNoQUOfVMpOQ1ZTJFRByMLpivg93T5yyDoX
	 EgxlhZy8k6cSN4Z0hwmNpLhqMjNIDWHAM5kf32fBxAhkTyhwB4K5r8gja9+z+JzZMAdC2
	 DukAF7OvvLxwOabk6i35q53dCTSQFlKagfQAArgCLIzpkStlmggYvO7yNv1h7PtaBkSwC
	 W9S/6iQeS7RUsa/JVFXXg/R2g3Smo5KhH0TqzvkoGpNvpB0AaOaIOKxc9ZeGomRzLaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SlpgVcv5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DDF606A327
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 13:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8DDF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SlpgVcv5
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4d427836e9so612308066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 05:08:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795525701; cv=none;
        d=google.com; s=arc-20260327;
        b=oelZA8VWVq4ps1RzwBVWXlHj0SqZTqI5UIZEp17DkxsrExST0mY044HWszHcJbJKVh
         8FGZ9erBd5U1m1XUCo70Tz96x3DZeg3M6L1zz0sdizk6NZDUKHthFAcZerLw4MpCm8sz
         GsSKpPKfMqdr2g/0qM9CIpWN1CxVuXiI5cL5zuIa2htmUp67d2KHTtKrkImy0zMDfSdl
         8RBUhTwkS+T+tUVYC1fs+ZGXY6O+s6GBLytr6E20eFYvId36wf++pz8Uue5aKgbabZOD
         0o0o5qoDvAdn42p2lLefOHsLkyN6WSGdRT4V3o04QKdrwy9VXLgyzqzR5P9Wnq3wosZC
         BIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AkNAAAtF4o2icxeAY7gUNPpfbhQGP8DAKlQu3i/mLV4=;
        fh=3OYetiHFUncF9g5KFTYV2EyG6Vsw0EI1GWSvKVkJQ/I=;
        b=VkeTCbhTkTQnPoNSEHJx4MCuPWov563+6Xdo8rbW4iXzioaPctRYy++N2qEfUqQaRG
         ORWD1QBA5HW2tFjSDZTePqOcQdcQqDq3SBqzHe/ogjkqKnT7x38Eq62MQ2/fnpeZWf7x
         NlBDdHn1WPQcrK+qSbyd5CKVWKOut64qWp2zEmvQRCpI+1iXhMjMvLzH97QE0fjtVjrQ
         N4v8HdZsIY0tlTyNDeRxLYkD1EihFy21hOE2hzDdgpVRUlJEUHVxkh1ZQgUeF4nh6x4f
         39DXO0KA0bq5dEcOEXai9vKrKk3AwSiRxIOegwhCvqDt+aFji5Xwe1VBxLRsPT81JOje
         D9Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795525701; x=1796130501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AkNAAAtF4o2icxeAY7gUNPpfbhQGP8DAKlQu3i/mLV4=;
        b=SlpgVcv5gR/UyiZZogcnbsDTFUQAIQrCDAY7YiGvkitjvIjVAnWIz0UUxJuMo2tf4N
         WB385B/+2VrE9MW3isq9qNWUjB4aS3p/hPVI58rZlqXdRWFOHGElnFD84m5r36FHp34V
         adiqehJVLWSp1oaCRXR1YpOCxm8z6/23MK9LvpHUtKiCx5sUMaTuevSnN1ZNJ8NttHQ4
         BYsPx28LyL3o//fK6ckzKE+DKBzvxgoKObS8E/b5UjopZKndW4lUeaf3ZdModShnwlF0
         3fOopA5oxWIjssOWmS0+ptRm0epVU/DCPaQvKOsx5OLRw3n+UJoG8VSK+bHni0dSyAlr
         vYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795525701; x=1796130501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkNAAAtF4o2icxeAY7gUNPpfbhQGP8DAKlQu3i/mLV4=;
        b=WC31YIFrdvOmawNbZMtIYif9Nz81LZ/r7SiNf0JJqkpVUbdduga7Df6pkqRZdaYVXV
         s+fr3MWFQWzTY6ppt2tS8GxotJgdQltai2TA89vFsAbhNCXpCBj1yRweoZkPAyts6ijX
         XaU8bURDCAsu9Oity19qui1jobKSKvoegNKEibP+qsiJMY/Wcx5Zy5czX41RLfNS9gG4
         YxCSS0bSveSm6GMEgqEt6Pn4NDkPN/lgjhcIzAyPPXqovwjs9L8ZwiR6v+UNw5Z620x/
         Diu5Cs80HQRlze04qvFgCoFH4OVKzxVvn7Qc+rhjfXhdi3Cu5/UPU4M4Pa0yKHe21uUD
         gamQ==
X-Forwarded-Encrypted: i=1; AL+hErHDsR3/RDn5cZ72AWn4MvIQkUwFVpP5Oxtt9uuXkAqDLPBCZxezVzXhIvncnIXp34KEkkN6p9vvyEZAPcvM@vger.kernel.org
X-Gm-Message-State: APuU4Z++i+a8ynAeqqVg4UC2YX/BepC8USINZFKLWXtY5h1fFsCGfZBN
	4L9NlU14B3EHqBQfMdBaXZAViPTY46oB01ycULJDAa0DCiE30PxunCYsS9TGrJFUK8Zqw57McNc
	WzWc1gcbAwtUZAHDuylRtuCqloEByNrw=
X-Gm-Gg: AZFdTZcYs99S6cKFIbn2a/4LaMxtDQURR/BopDrtq1epvxzGD2VUVfQcqp4rISiGnbw
	uotsGpR75OPEfleVp57Yh73NKPBavaDTRKiBIQY3yqIFAUWF1uTeI2BGgypRiS4JY2YgpBmQlpe
	KrT0F/R1EKQbwWAzb6EwuV0lXXw9n+8DUEv2bz6OFkRtujdaErTrqoAdAFfWHu/Jt7tiBlpUmtS
	mZLZD94CNB4x7lHCDV7qF/uEbuUf13adJ9dpK/0tM5c6eoHreAAHpvig/rS+AH7ySQIVS/a/x9S
	yCnigpZWBzD/jytnUKUF7AGpICqn/8eywGx3dBwz3HDQtcKdBnA3wrE/hzbkHiqvpT177dbsqj5
	/5EnTJk6uC11d7OSpb9i1p3rptQ5LA4nJmtGeZYlE6k0zxJDvLgdyeqBdVBVmGh6m/MvaLA==
X-Received: by 2002:a17:907:2d13:b0:c41:21ef:26ef with SMTP id
 a640c23a62f3a-c513aac43a9mr1237205966b.20.1795525700904; Tue, 24 Nov 2026
 05:08:20 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123221410.3328780-1-neilb@ownmail.net> <179550252639.1728055.4014817916838632741@noble.neil.brown.name>
In-Reply-To: <179550252639.1728055.4014817916838632741@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Nov 2026 14:08:07 +0100
X-Gm-Features: Aa3M54oq4vsQoqGSpoehVE3NGO0KC8qZD269kouvxmZ9wJzsMqau8bWxyLk-dzU
Message-ID: <CAOQ4uxgF6=QoD9RoAOPmxtvkq1jWf+gG1AsJzR=Kt3ROMA=X0g@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Fix easy bits of the negative dentry problem
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Kent <raven@themaw.net>, Jake Edge <jake@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 7:42=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Tue, 24 Nov 2026, NeilBrown wrote:
> > This v6:
> >  - fixes the autofs changes in 1/5
>
> Sashiko says this is racy.  I think it is but the original code was just
> as racy.  Maybe the race isn't relevant.  I haven't properly understood
> it yet.
>
> >  - updates d_duplicate() in 1/5
>
> The fix was seriously broken.  Sorry.
>
> >  - uses a new version of 2/5 from Amir
>
> Sashiko has something to say about this
>
>     Can clearing FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN and dropping conn->lo=
ck
>     before fsnotify_set_children_dentry_flags() finishes allow a concurre=
nt
>     watch-adding syscall to return to userspace before the children's
>     DCACHE_FSNOTIFY_PARENT_WATCHED flags have been set?
>
> Thoughts?

Sashiko is right, but this race is not new.
The same window exists upstream: if another thread's recalc observes
the 0->watching transition and does the walk, fanotify_mark() can return
to userspace before all children have DCACHE_FSNOTIFY_PARENT_WATCHED set.

What changes with this series is that the walk is sleepable, so the
window is longer, and in some workloads it could go from rare to
plausible. OTOH, skipping negative dentries may shorten the walk.

The more important question is whether a child can be left without
PARENT_WATCHED permanently. Upstream it can: the transition can be
observed by a recalc from the mark destroy path, which never walks.
With FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN that cannot happen.
Every transition sets the flag, and every caller that can add a watch
consumes it,
so a walk that started after the transition always runs and fixes the flags=
.
What remains is the transient window above.

I think a proper fix for the transient window needs a sequence counter
of scans in the connector. Each caller would wait until a scan that
started after its transition has completed, no matter which thread ran it.

I think we can live with this v6 patch for your series and deal with
the remaining race later if we want to, but I am not sure and would
like to hear what Jan thinks.

If you want, I can implement the sequence counter for v7.

Thanks,
Amir.
