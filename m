Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF5C36AB49
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607537; cv=pass; b=JbsNUtGcUOfYC6gCD2aJ4YYUXN3jGh1cUld6D24jVDBCi4wZmK6JkWNUPXn7KW/UP+x0aPRVYwmBMS5SUI9d8MEuSMbYj+W+2nmp6WoTI0wbBdOEZC6nK77Qj54m6H8rSADJRw3usyZ+MuGqFKhI2Ltik5ifTHN4/4pB4kQfIVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607537; c=relaxed/simple;
	bh=V+vuL0j1CDdaZ4B2w4C4rlJ2/cn1tosD1AB7fGsK18g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXZZ2pAGs5cFk+ZGQy1LBYvorufBhdN1g2TKdQ2cHw8r3P0dtp1R5d18qicX/kC4RTh8CBcMf5c5M3J5nB6R+33ahBHc93mm/r87GfhUYA71UMGZV7m1Xyyau3UT+Aq9MwdRLzQI9OWA18iO25RQ2HUMW9vhPSSrjLcKcwR1xSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7/KyWE+; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7/KyWE+"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so668865a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 07:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783607534; cv=none;
        d=google.com; s=arc-20260327;
        b=q2rH/YxN1dUZj/qQPdzRLO7YDpeMBmC5Mk8l3MxFK7O7IsYXcgJG8pnEsGkhuPwFKz
         fnCOBAQ7arF9g/qq4pSqXkCyT6h3uy/eZ9Vahx4dXZM2H8VAtvKHnn8Ns6/LBorBbED0
         sS1cvLK67k5IZr85i6jjKi0h2a552533hPQWGEvahSHIbGgf1W97GmzxqlV1TaLAp/DA
         qewSEPjHGthfDbMi7RXd6M5enfGKSer0DotkB6SjePUc+TYVFPU/buoUV+z4sJEjo6H+
         Mx2lomfa5cswaSqewo7mF9Y52++Fbkud/7SHUwes5vQ8GVgXWqvtKM5laD9O4A1NG09l
         fNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xhzYe1XjtaTfQ052TLMa/MvT2DI4Z/2XBeyITmqTEjM=;
        fh=2NmvW5wnWvn7S6dD/4InCv6XwvMlkv+YJ/PInfrbmCo=;
        b=ZqUhHhcivaGBeGbDqhfo77Isoxt6KIumrtfrbLmv+lLP+IPyIQJSWVJM8siC41qc2T
         V6bWOiL5i0AgS7W6EZ1o85Ey0356Jsqb1WMLE6Lc7/5ym1sPJZ7hx7ys8QqDbNeng9fu
         GL4EC3LDzp/NPFdhst3QPMgIoLkJofry5OZKwo4T7NoeCeWR1xm5ybZGdGro5zJcn2wt
         LK4/DU2e/s8ypi0k3H7LHldK2BMIRh9SRTUINxeW9C6IfNq+nHjoZv+G712JEsEnK65D
         9tEfG37gmS4Ad4+VCKt7V5qODEOVH7s4cVhJufXi3RdlpUr6QS/YcOLIwqbfZcCap1+R
         mKDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783607534; x=1784212334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xhzYe1XjtaTfQ052TLMa/MvT2DI4Z/2XBeyITmqTEjM=;
        b=O7/KyWE+y6ah8SKUEau4X6rsSTeI5LcfWGUIzU8Wtion9C+SD1nmIODKPpmIsoKrrh
         HiSEn6TwdZctQyMb1yv7aitw6jSRILjMFYXiPixTwm2kN6DfG8ZkA0lA429KmYiByvcy
         UXN6l82m+94NDmsWERpSpMAgwM+BwADhyLL54J1ONR1aDbXNA16dPET4SfPD4onl0pcp
         1SeEC9NP7fpx1jAHFnMOGVH+jMIPA2NFxdRZnqDUawg6tyQJTgkqa6z9mqigZLBqSRUU
         bdct+sGe/pZlqZI53bS0gEKjUAC1bvzg+PtQRm9n+WWg7a/qlK8Ps1jNLpIhjl+r22+G
         MJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607534; x=1784212334;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xhzYe1XjtaTfQ052TLMa/MvT2DI4Z/2XBeyITmqTEjM=;
        b=sWvn5daaJyTaXX4Hg8ypI8Ul00faTycJOZ3pCWuq6V6UziBT1FwJIXJTNW7QyOVFeQ
         vh76VdCPdHzMfUupHF1soB097qrCq4g7M4LH0k/NHdHoOL4kDdDeyXtJGzIV6b90nOAZ
         HaCgkWakIeP+iOUlMKvzr4e3SqRv1P1r+oD84sQQIMYigXILlFr0C2CGVkzptO3tpSMJ
         W0dqe3ssoXu78zyf1oU+rVxWwBP7HG+B1RoL6CgIBPsRhYKMob/BMCFKWxzOsCUnDQMS
         KAabp0DEuBndmRrSxI8kA+e26d49Yr7LMLInlmwrf2SS01UiiXxvF4PbS3EmFP3P8f/W
         Crkw==
X-Forwarded-Encrypted: i=1; AHgh+RoWws+J04LtcWtr9mo1GMs5nScxLlNxVcq7tkv2hj6FfZk2AuNMhDidiqRA0TIMSDvCZhqBrWjxznvMSWPI@vger.kernel.org
X-Gm-Message-State: AOJu0YyFALT1g1ipCFkYWk6/9TKdA5zYK/89igtvjP6UtX9p830qXr8g
	l24Ofc3b1moiHCah6dgzfmJZNf5v43EHPJd4SX7MYNcQWeY9M/7hSkI4aWxUW2+iwfIHssdfxCZ
	cGDNwkm63M0hi4djDidbl7yIRX+gAzAU=
X-Gm-Gg: AfdE7cnI+Oh0CD/uWCjrmI3VGtH5bz1XO+PLBAdsij5y+1/2/W1UYBccncLm1ISGBuO
	MaUGlpsB+oBqWjIZ8IiI1GmiAz4Tw1+JZIGr60WcUCoZ8q0FQ0UXmNtTywwU2QgW+6sys67S2BM
	Yor23Nj0TJ90y5uCK5zaG/RYfP4FVmwMgc5/ZxTyrelKYGRyMx6F3LZLMN+BItm1IcKReE9+cSF
	3B6nDNf+wge7JlRv5dYYXBpP6Ojcz1AshRL4rbdTIQQb7p8Nzz2SDlElds7x9j9TlDlOdhbsA==
X-Received: by 2002:a05:6402:4512:b0:697:8136:6d85 with SMTP id
 4fb4d7f45d1cf-69ab445d5b3mr3087023a12.3.1783607533539; Thu, 09 Jul 2026
 07:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com> <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
 <87wlv57dt1.fsf@redhat.com> <CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
 <87o6gh79yi.fsf@redhat.com> <CAJfpegvUEEbFnCa1N9k3gMXpw46YFpWuta=G6brON1=xU36bgw@mail.gmail.com>
In-Reply-To: <CAJfpegvUEEbFnCa1N9k3gMXpw46YFpWuta=G6brON1=xU36bgw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 Jul 2026 16:32:02 +0200
X-Gm-Features: AVVi8Ce_W-yxg-OnXjZQCWKXwRdUfH6E4eFRwx41VYV2twepSkLr2IZMZq1JXHI
Message-ID: <CAOQ4uxgZuJ+=RQDh3577H7PFAfYyF=wRJ55aPuuUW814Htrmbw@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 9:45=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Wed, 8 Jul 2026 at 17:55, Giuseppe Scrivano <gscrivan@redhat.com> wrot=
e:
> >
> > Miklos Szeredi <miklos@szeredi.hu> writes:
> >
> > > On Wed, 8 Jul 2026 at 16:32, Giuseppe Scrivano <gscrivan@redhat.com> =
wrote:
> > >
> > >> Amir suggested to add that functionality when I've asked for some
> > >> feedback before sending the patch here.  I am fine to drop it if thi=
s is
> > >> the consensus although I see its utility from user space.
> > >
> > > How about a completely different interface:
> > >
> > > int get_fd_opt(const char *name, unsigned int index, unsigned int fla=
gs);
> > >
> > > Enumerating layers would be as easy as passing an index stating from
> > > zero and stopping when -ERANGE is received.
> > >
> > > It would work for all filesystems that use files as options.  No more
> > > fs specific ioctls.
> >
> > Is a new syscall really justified for such a narrow use case?
>
> That's the reason I advocate pseudo fs based solutions.  Let's see, we
> had a proposal to use openat(), something. like:
>
> openat(base_fd, "mount/options/lowerdir+/0", O_ALT | O_PATH);
>

Ack for this, but please don't use mount/options/... it's a bit ugly
because most mount options are not opan-able.

Please stick to something logical like "fs/layers/N" corresponding to
ovl_fs::layers, where layer 0 is reserved for upper.
We could also support opening by aliases fs/layers/upper->0 etc,
but no rush IMO.

What I am contemplating is whether we should implement
introspection of the ovl_entry stack for merge dirs in addition or instead
introspection of fs/layers.

IIRC, the root dir stack does NOT hold references to lowerdata dirs,
so support for "fs/layers/N" is still needed.

For directories we could implement "real/0..N" with aliases
real/upper->0 real/origin->1.

For a regular file we could have constant aliases real/upper->0
real/lower->1 real/lowerdata->2 and/or dynamic aliases
real/data->{0,1,2}, real/metadata->{0,1}, real/origin->{0,1}.

Those could be used to implement "revert to origin".
Specifically, I think Daan asked for it during the last LSFMM.
Although I don't think we currently store the original lowerdata
in ovl_entry when lookup is done post data copy up.

Thanks,
Amir.
