Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B01399345
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770269; cv=pass; b=utktCE4aPyVgjIAHv6bo8nNmJ+fCS0KW8wyJCpoZIyEuMA/jm4Q4tJBI2LWEqip6jEos1nUeTe1TE34cciWJrPvRrV9Rea7pmhkRQVrZvtzX0q7h9grAF5H19dgw82i9jwoH5zFLgmdKAMK0a0WiXIG9Y5TPvSKjiOzw/YPtYYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770269; c=relaxed/simple;
	bh=ePy+65LwHtpadmQB8IRLTSgwYKUeWXNIN+sEiEUTMhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKt0ulOGfdOuUsJl0K2OEKxjqHh1TXzDPH35c4K7AlswpEVH3IVof4PWwGEvGP5v08XhMbTs6NUZ/oPM4GmW8VWVlnMoIcbm+5x5SxmEnY096eh/glFF+cJJywFTnLblC79orbTwWAi+X4SUHeLEqDqKARbaUudBL1PFciJ+G7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFXZ5xp+; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFXZ5xp+"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66e8cf72a93so4887798a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 04:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776770266; cv=none;
        d=google.com; s=arc-20240605;
        b=HDwKCmGOWwmLJgS5ZGgtp9+ttRFheLLgwrx4XwNy341dhkm752WHjHy4PCaKvLAfFb
         0kgDBhgOCUvbDJQSihNc33zFSlDLD1quUp5YLx1vqLTv8SLGF9UoLqlO5zZmEDid20BO
         jFByZCsEia3eF0sCTPkFP6A/JEdj/tW9SUAu1joE6/cPMWAkSD+g/st+Td8P6OdgycP1
         BAIz3h4ERqZxaJ80XaPFweuridQmNXsS6sVUj58k3mdbsaNougtH3KQVGuVI8cqG4S6g
         qc/sI/L8jQ4RCsha6WNJjZ6qYaukKn97gHnsKUDaXY0sSERR7kT2wt8CzxT5qlR5QOyI
         Nefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hgYesHF911J8oYm/LCuiWDmIFhG8PZk/XtlS4JH5Njw=;
        fh=f16hpU4LTCDGXypSBKY0qhDhLQzTOB7CS56wscDEys4=;
        b=JxUa73pzumj7bIl4eoXmyehsqhF0nYnbJ6uwZ/+RBT+Ah22uK+jqcXz0USd2ca56vs
         nO7PMNow6Px3+o+Lhm7ZjU+3qkSv5VcYy7tVRPLOHWO+hmY1qBhrwGsCerzWuaxMdZwa
         GNZ8b92PA7GTKq0KJNl0faijb0xGjYvrSgIQ4SG8PrVwOX8oscgABP6eyP6gGQ7onagW
         ireT4HGAYKqlqFbt/YqpvCj6GvP+DCC6/0BGsiYz1oZx7F7oanP1a/k8QW6rX5Ep1nJ+
         tTBqirEa38HmL65PdVpqjUZ2XnGnHcxrKsCeXcdJKepVG4I84kROQsnXJw5pVqig8BjK
         +R5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776770266; x=1777375066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgYesHF911J8oYm/LCuiWDmIFhG8PZk/XtlS4JH5Njw=;
        b=GFXZ5xp+bDGZVld/coLr/fu+N/e2/Yg1fLIFICyKUwu1hAYt4PTKgvy0eGTa07Skpv
         svNZvEO4zidcH/3yQkDLBec/yA2S6QZy2eH8w5OdxWna8/Zl9wqvWA5isBBp5PkEQM/m
         UCAYL9A4L6AeYYtOaM0hKQBm5oXF00oBJ4A324Nd6FOJTeDKgvX4Iub1l+Qc4Ih+JPXX
         g/8LDA6HpKx8rAE8bHpqHTaLmpDjiF9Do05kqg202Nz2DoTfIiPWCiUnas5o/1FM3Jhc
         DwDmJ/SjbHSn/Z3u4wSXxkrPG4TH5eVCrHjktvzMxUeKzPjvLaXG36sFwUl17aygc75m
         d6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776770266; x=1777375066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgYesHF911J8oYm/LCuiWDmIFhG8PZk/XtlS4JH5Njw=;
        b=XKGMBbEqBEIbUit/OgJEwXbrFaDTKy6LlVhK3Fa4IoU4Z19AAS1g/COHbs2e1n6mdT
         r2TPR5osrlxmcAW7NDZd+TWu0p4THHpWpDserLe0tMC/61B38UHK2duQpBc2Ekff43Ol
         PlsiKcDhuYXX1woTJaMBLdVz2Vo5BSF1lg4OaIWWa7eR0lwwuQRUzHPrtOnhtqMdXsA1
         dpouKsSXD8GdnIgyBd+ceuARGoRwdausdv1bA1g299lKknoV3ajaRfKLG7SBBgYCBj+X
         OADGRneIUWjm+RWdK77Kkhy3ljdLf/RS7fCbrkRwu/CeLM0Th4hObrHqx9TGczRhjjKh
         0H5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Mg5Qi2QZ3++E/+EYEFrasgoG8QyUmupj4xiiGijqpRl9WKKVTJ9NCAhqv3YpfZr0DTa9ZlCZhQSDkgsaA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcw7OBN3kOXfc45+68NXyzaBA9gB74siKyJ4JBASaLt1J9yNXm
	6hWIVnY+wKXYKyXNhs6NSYmiFnBBAolntQDYYgCfcTR/vfKhO1x3SvV0+NUluqKnzPbGlR1E6fZ
	11rcZi4db4D70TlPkMc2fz86XnTbg3Ltie/toSzo=
X-Gm-Gg: AeBDietD16DxrD9Q9gwon+OFlh9IiM/bRulhMRNi64QB4wcihz/joWJdJTtKM6KnI5Y
	DqUZTej25LiWxzh74Daz9gbS5ZhFtUURsegwLHYwSMnbzomGeKPZyK7IGpIlEmuguZJ1JtLyC5v
	1SK5vWGRtXgxpimQVX9o4tnpnXJ04n1QaPfvn4wrc0yz8ttaJhLY2+PMkruaV7UjIYu1l+SVUiN
	c9ydq5DvmDQzE6Bn41FL8YL7nPNthJujTGo+5YS6zMnpSURqm8cvfdJrq5tMo0iFEcU4Tn9q3AV
	EJbZF30nqDEtlroftae78+FkLNw96QQYyeT3eXFfADiWh4VYCy5o
X-Received: by 2002:a17:907:7ba7:b0:b98:5648:e68a with SMTP id
 a640c23a62f3a-ba41adfb426mr848138166b.36.1776770265885; Tue, 21 Apr 2026
 04:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417142503.1436446-1-amir73il@gmail.com> <u2scvjd522tdhb35r7ge2fqclt2qo3y4x5nxwprwcritxir2wj@5u4zhohrv6aw>
 <CAOQ4uxj1guVDXNrSmWUVS+6_meYPGBe8kBSDjfe8PkopTd79fA@mail.gmail.com> <5zc4j4nrfvxr56rvtgazaxojbpnd54ok2bx46xvhe3swn5g7dv@lzbnm44acpbn>
In-Reply-To: <5zc4j4nrfvxr56rvtgazaxojbpnd54ok2bx46xvhe3swn5g7dv@lzbnm44acpbn>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Apr 2026 13:17:34 +0200
X-Gm-Features: AQROBzDjNvEX7pawaNVVkNW06dgdan83CjIfBTGn9yYdfHV25a77VpfHWJRLLxk
Message-ID: <CAOQ4uxhUU0D89P_ZfOyDPpvGD5wy8VoU-o2i8iBjU-HmJyWuDA@mail.gmail.com>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 12:16=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 20-04-26 20:14:58, Amir Goldstein wrote:
> > On Mon, Apr 20, 2026 at 4:37=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 17-04-26 16:25:03, Amir Goldstein wrote:
> > > > + - Handle security issues promptly.  Filesystems parse complex on-=
disk
> > > > +   structures from potentially untrusted media and must treat secu=
rity
> > > > +   reports with urgency.
> > >
> > > I've commented on this in reply to Matthew. I agree syzbot results mu=
st be
> > > reviewed and identified security issues treated in a timely manner. H=
owever
> > > dealing with maliciously corrupted on-disk data isn't (IMO) a serious
> > > attack vector. Even current well maintained filesystems (e.g. ext4 an=
d
> > > others) have some issues in this area so it seems unfair to ask this =
from a
> > > new filesystem.
> > >
> >
> > This is what I posted in v2:
> >
> >  - Handle security issues promptly.  Filesystems parse complex on-disk
> >    structures from potentially untrusted media and must treat security
> >    reports with urgency.  Expect the filesystem to be subjected to fuzz=
ing
> >    of both syscalls and filesystem images.  The filesystem must handle
> >    corrupted input gracefully without hanging or crashing the kernel.
> >
> > Are you saying that ext4 and others do not react to crash reports from
> > image fuzzing which result in crash/hang?
>
> We are reacting to them, but not with such an urgency this paragraph seem=
s
> to suggest :).
>
> > Can you suggest a more relaxed clause or should I remove it altogether?
>
> I definitely want to keep a clause like this. Maybe I'd just reformulate =
it
> like:
>
>   - Handle security issues promptly.  Both those reported by ordinary use=
rs
>     as well as those reported by fuzzing tools. Expect that your filesyst=
em
>     will be subject to syscall fuzzing as well as filesystem image fuzzin=
g.
>     Dealing with maliciously corrupted filesystem images is not generally
>     considered a high severity security issue but still it is considered =
a
>     quality-of-implementation issue that should be fixed.
>

I can take this version, but tbh feels like debating this clause misses
the main goal of the doc, so I'd rather go with something a lot shorter:

- Handle security issues and regression promptly.  Both those reported
  by ordinary users as well as those reported by test bots.

IMO, getting into more details doesn't really add much value to the
prospect reader of the doc before submitting a new filesystem nor to
the filesystem reviewer.

Thanks,
Amir.
