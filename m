Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691B43E9CE
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512409; cv=pass; b=Qqp2Mu66Zk3r/JaA6m43J4pPenm1yMlWq7j2n9bIgL4bJSXSUu99y2vx05Jk+GGuiV8PYSdV29AyO1zJc9UVqB6ORsRc75w3gYsQAogbxRqpuUYZMgdFw/zTKukzjUA570ji+r15FV5AR6Wk1GFG8RTXHr+hMEBZ9Qz/G55iBO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512409; c=relaxed/simple;
	bh=T/ZPxZzlX3sZq/L9I8ve0ZkLUAVqVu/gDVfbfSQGf/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvMwVoNkcwNEmhrUI1VkIln0kpFivCiXwbfqHx2LdPZT2bjAzwPBymRV5lJP4InH7vGBLkndUSWLMh31n4IWECukMOJ5FJIuvIGgyrusM7v6Pyopw7/Z+WJiTBGC6d3ksXzrRLFuzODKNhhArhoZ4eTiHuTA/4zijqeRjYCL3ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZCElZPs; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZCElZPs"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68ced08613aso1877a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 11:46:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780512406; cv=none;
        d=google.com; s=arc-20240605;
        b=HOALDCtbN+BASJqWXvpfJclDvpBnGpXmLx2yJMTi5VvtF7vKRNigpkNVdoU5OMMN7F
         lcPlJ1v/J+tw+lI3iL7onAK6YTuNxrKhuvXe5EtE959NDWMa3gnRj70/ZfKsqOE9+wEY
         4ZcYswzMRdxaTwtn4MnsqZELwXX2TBmcnOj7II0edY5DZCs6eIw8IvYTheH6C6bGrcDU
         WJyQGtzopNVgvEI5LDTm89ZqpYEHveES73zBQgNI6Jn+NbqMpB7vHFV9+4udJt/HJTeK
         C0aeIVY2OuHRI5l5UhPe7t8n1gvq96cTLyRo+8LwDugsGc9R+6j+YxFZXZszVW2m1tCt
         V17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N0I/V/n5gAej83npBKjlcD3mf3nZ4PsFC7cqd9huV/c=;
        fh=EofoW3SvYSHa2dqzJhVwRwWjezhEB/wm/iUqlNO4d6k=;
        b=b/U6bnxJDCZHtOxad+id6GuAxEa2kL1bt4ce4IbUIzOKMjqPtbqTooGlwEV8omwfwe
         oYEoPVHYoFRfKuBMBuz/aLX60U6hBsv0DmTq2NJ2AQJTt1yvQeOR6ZKkP5m0nAWuCH4L
         JqzqqvV2tghs1LgtZ2RsT6cF5S5TYkiNI9s6Svw5fJoFPtaCawZjSMREx407NlnT5d3l
         fnfPREefh2VQfrgprTBoKdyLd7i1jhN9ppXtIq5hR1qLPTUUV3kkVub2t9pGp9W7g4d3
         CjC+yjeaJk+zDNSQzfcjEqQSDG1+yVFSFevz4F5FmUoKs3faKDWQN+EF0Uy/nOCf2tsS
         opRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780512406; x=1781117206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0I/V/n5gAej83npBKjlcD3mf3nZ4PsFC7cqd9huV/c=;
        b=aZCElZPsvTw9rQ9KX8qZWHsmfHgEw2D9EYNkNuLr1RCFEdJApTu1qBtkp2oAX292We
         n/1ggVIEmBLBEY9DgV/CuTQehV+6I85q700o03Vnu4dp9tiu4MkZQ8KzzpYSaBKWos4W
         feg+kPJj5Nd0syIkAYS9TdEMYz/TreTj18DZQorFFh+zoNoyhjuM26nqDPpSjFWGNG8O
         Dn/SM2nwJvNaW9iOxfTFDyFjJ57/HRqq39WvDd8BP7QYDwXE2pf4/Pk9EHKf+JF7r0E0
         Z01Exib40QPwO6uHSCsYui3PT/3feezZOCqRopAqtac6H3gfMpnwb+TF/AzRhfb2xqvQ
         6d3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512406; x=1781117206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N0I/V/n5gAej83npBKjlcD3mf3nZ4PsFC7cqd9huV/c=;
        b=KOiK7gXOkO7H5fKhNuq8IUZxqazE+wr9lrvtXtksi8xmqUdXzGSvvNE72qNA6U2a5y
         ncB5q/y8bwVTqI3rHH5HR7er0nEaQap+IeYhNAHxXhrvpZmtobA760biG1AU4i/++fzu
         7TEZ6i2Fg1eDcCaWfOTXVrqy/sVWsDx2JjyM3pke12I37SBgrUWy/NUEmsm9Yp4D1UQq
         KxIawmbvxfcz16eiRkwJx52Vzmxj8LiYmCHwYqEMtn04zJzv/RUz6xkESNXqj1GBrd4N
         fqBhaLiP7NGEetuL2FcCsE5MhmY5SlVkpU3bQuBvghUnHyxdH+ksT28Umu06IwriKENL
         Vt9A==
X-Forwarded-Encrypted: i=1; AFNElJ+1+Bohs/JzGHb1F4EJjJ/w8ixCIvE4M9wAs+tcHeV1oE1BqMC/1w//LNKHKIkIRFOJSbtvvt06vmeYCQQG@vger.kernel.org
X-Gm-Message-State: AOJu0YyR+/QWKxXTqER8KDCft/nrGsYgtadvo9fw87DWk7ChE+l/xKFA
	unT6flGxQIAK3OXWZsQ4CuGb5GzTQD7nMolRocn34oQiRKl8HpoT2s/MnvI7vF48K7iqi+RkPQB
	0IcfkGIS+7SZopFvr32qbEcYVuRPjN3rqJu6wKNEU
X-Gm-Gg: Acq92OEQXv5U6gQlCHrLKI37C9hBNoS7x422uIZ+DHqU/7Wo2lmE//thG18YCXimrSU
	cpOJvlIP+mv29YA2HqtBt5jFysz8wxDm6hzrn3c2d5pmdBjzs+RP/figMFXWfpsuk1i786hwGvc
	0JLUA/SMkwDhKS83vt6GZH6GMTyyyFQDtZMeTFeKvzfHZJweCwGwVG+aCwCZ8Qm3KoS8VHTIIY5
	Hs2770wJTgDVEp9Uxbkri1WInkYJ3OGq/J8b5v0aefrXtmJXOMHbfrDcVtCBF3OIIClDPzENfsm
	M3n5NjJqX3UTkNjJDyC5QKtlLVTQJxugm8dMPyrsM9p5E1qrP+nWnTdK0/8=
X-Received: by 2002:a05:6402:10cd:b0:68a:7046:e64 with SMTP id
 4fb4d7f45d1cf-68f12aaf42cmr15325a12.3.1780512406065; Wed, 03 Jun 2026
 11:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com>
 <20260603181523.GW2636677@ZenIV> <20260603182454.GX2636677@ZenIV>
In-Reply-To: <20260603182454.GX2636677@ZenIV>
From: Jann Horn <jannh@google.com>
Date: Wed, 3 Jun 2026 20:46:07 +0200
X-Gm-Features: AVHnY4IOIf990_8GL-GvEPTAuAhu-9aAisHbx6iJzPDbVrDL-pH0XXeLuXuhWf0
Message-ID: <CAG48ez0Jte3UE8wn9Ljs3o2uVDFB24Zbp9zBdaj+D5c4R0+TSQ@mail.gmail.com>
Subject: Re: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 8:24=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Wed, Jun 03, 2026 at 07:15:23PM +0100, Al Viro wrote:
> > On Wed, Jun 03, 2026 at 07:38:06PM +0200, Jann Horn wrote:
> >
> > > Fix it by taking rcu_read_lock() around the mount::mnt_ns access, lik=
e
> > > in __prepend_path().
> >
> > > +   /*
> > > +    * Containing namespace.
> > > +    * Normally protected by namespace_sem, but there are also lockle=
ss
> > > +    * readers (which must use RCU to guard against the namespace bei=
ng
> > > +    * freed).
> > > +    */
> > > +   struct mnt_namespace *mnt_ns;
> >
> > Umm...  It's somewhat subtle - at the very least you need to explain wh=
y
> > there will be an RCU delay between umount_tree() clearing that and
> > having the sucker freed.
>
> Something along the lines of "removals from namespace are serialized on
> namespace_sem and guaranteed to happen no later than the active
> refcount on namespace reaches zero; freeing of namespace happens only
> after the passive refcount hitting zero and there's an RCU delay between
> dropping the last active ref and dropping the passive one that had been
> implicitly held by the fact of having actives", perhaps?  Only in
> more readable form than that, please...

Hm, like this?

Containing namespace (active).
Normally protected by namespace_sem.
Can also be accessed locklessly under RCU. RCU readers can't rely on
the namespace still being active, but implicitly hold a passive
reference (because an RCU delay happens between a namespace no longer
being active and the corresponding passive refcount drop).
