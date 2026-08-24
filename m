Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED13EDAB3
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560584; cv=pass; b=jfBotpHHl9p45fOlVKBk4V7p2op2I7hdahJeCuxFOGYr4GjIAfik0gQ6z36Ddx1lnhjNYb8ZKF1s1j0p+LHrdQ0rT2Vmw7MGoAd9sWLhaFVngnBhcRu3grvzsSFIOORSg57bzuT+id6VemHj3rzIDZd2tStUWCEteMl/p0SrZdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560584; c=relaxed/simple;
	bh=tabZVc34j8IumhCwsfaTRLF3MfP3CF3MKY2fkomDg10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lC9KmSMOd8PjP6chDo0JZD37Rij3NxnW/L8Hh7i33zV/wXz1AGh7zTYHFkz52eMorLW0Pb2EOwPVmtiHCj1Xpv/VqsiHcuqt8q+n3+tCfQ2r6u70x8UBmjhliKCZizqNERzYaz9a2nAGhhWjprsMrM1+QaVreeCFMniw8vBWqDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxjOxEzh; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxjOxEzh"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so6054900a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 01:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787560580; cv=none;
        d=google.com; s=arc-20260327;
        b=OTjSQDfBWo7jOTutavUjWsTszWYuWEGBqCRThmInLLSEVX5ZiX98NxvSPNELEeK51+
         ifmSEtzgVeG0LfQ9l3+hVzpShaLbWBuIUdPj45pzOe0KjwfrXe3lgUokegOi0GAFZII5
         pceCYqIetJ/BKBTeiqsP0gTxobVkvvnbY45E0erJ63zxkBhcxoyl65ektG5bxnmRCngu
         ugUeaYLKIH+R35e7isr1sAPhPzPn3HlnPQNaVnLhIIXD/hK7a2tVE1QIRLYDrOd/fL7k
         lCwkxJI/7z2iRC95zXjlbvJdH+qTkBZ/Ac9fbgo1GFRL412XenjpYQtvC/SanOPnxVzQ
         MEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YsrEM68gz5Ntl2SZWVPwBml/ICqiBorzNsDyRtB7G9g=;
        fh=4Uz9DRvwy3RZbRwktX7eIUfmCkAZKx5rcZpXr7iIg0w=;
        b=pJuyqA0ZJQm9QuvxoRmKX8OTgFuG+4Del9ubcxtoJ0YRwoD69SEDv8XznqRQ5FFgib
         mSHSND/mY+nx0AjqxPErCa8WrGGc4M1BE7GYvo7EyIcrSLLlR3xIhBnkmVvU7BTTeQYy
         U+PUaa5+sNMsm4tgjOk2N+TtzgBgQHL+qVKtzgbtYsCjJsnRCzW7lc09IuqT5SoREv5a
         BgnHvUwnA/US9LRNs6w6+9itsOVdqbDZLpN3I6tXa2JoOi+/XMgbjjRfTPjblGBeTmkf
         6GxVeWhLvCQc4yHQ11+PgDN/ItyZ6RpipTZmpBLXVpFrWzfsFIFASBCu9wbHZRLCe23U
         Ex5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787560580; x=1788165380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YsrEM68gz5Ntl2SZWVPwBml/ICqiBorzNsDyRtB7G9g=;
        b=UxjOxEzh7qZXH9FXfOFAMJILYY6gZdcHFjOll96505kRuCYah27cYh6X80YPDkXjPL
         u9wFFrzNW4VG2gGghYnRGxpbpfv3Xr/1kZGKXnHcL2AmjHmTYm0yjzsoNz/UkB1f+zEF
         yRsIV+tX06P4z4zkm3lETGDcm1YdunEYTssCR2DeGZrEtJnFIGphdNbz6yG3SSGn+FS+
         PhfUMncy6caHgum5IdtL3u9rszswhRpvd4kKKw7OHqUFlFhOsSFYILQgXYDWxN6aLtt5
         OHGluBvVJW+8XmNJPQrdCwL+87bn38xKTkaNkHfws5brj713+/Ve7ktwNWMuHKmPMNIo
         Pmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787560580; x=1788165380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YsrEM68gz5Ntl2SZWVPwBml/ICqiBorzNsDyRtB7G9g=;
        b=IibzG7VVGp1bUHfyoDMQ/0bZGrNa7uw16KP4jbx+SpRpcBCgVtydQuHvrI5XhQIZEd
         ZptIb4jtYvQuFWwbRzWbU0rFyEein+6gAgjYcl2tz8qbV1BDOqeP/hW6LCy/fi/HMZ0K
         ElLV5ssHWNYPDH7U5Ygm0Koopl7pID95PN8P3AYzlUeOLaxFNiXWVEa9H4FYn+04IakB
         x5bgjG7Sh2X/RKvA732L4RxSF11wYPQ3xV0gjZigsrGo5l6+pUJyTgEGT3ThAEB7V6N4
         rK4Yw119i+7eJRp4ZNkEk4b+gm7oZIg00SmrOPny2wsReGbCEK4Xn7Uye89Q4WnOs1J3
         Ln5Q==
X-Forwarded-Encrypted: i=1; AHgh+RroWGcHMCuf63+dt4+tYMG0E5cqjffMBwXonQk4ne1wZ4qM/aQf1yV89Yo0R8YaitviEs73oBd4wZSWha9+@vger.kernel.org
X-Gm-Message-State: AFuF++lUfjAGjCToxqBTWhg8wDMRm2iVQ+lWNLcKxKf7IKVtxyOhEsBD
	JZl4HX8UrBKiSqU7xX/VukOBE98MI/ATZbjbq9mnDCflYeZ5GmzvQ+4Jca3+diCNfCZE12rS5T2
	x61/sBF9UWmCbrRPMiZaPPV+MwCZNwOk=
X-Gm-Gg: AR+sD11D9gxcHc8txSmPqasEJCZX/qiRkgTXaE44df4GXdYGrGl5+ScxsLPjZBsf6Gm
	tl+1sWNRZZBgasGgZ3pwiUDIniU8L6KwM4QtnSQtnXYwutsRQi1jL81u0nrnRvP8FJT4W8PuqhB
	MjTMY/nkTNK2wyRAX7MsXPtpJgTkRUussvhfuuOfQtAUQISnpFIlQGnKkmNxfzFuEUXfmV+UF8Q
	s3wjd1p/A/4hWtCH/ujuZ2JBliQ7sW4vh7/rYdDvOZ3nCezuv4wYt6MEobzE0VluTS7rviWTi1v
	e49Zvt8TUH7YohndWn+PjWLMREnpFAnId6fdk8xW3Uhrcw==
X-Received: by 2002:a05:6402:21d7:b0:698:5610:76e5 with SMTP id
 4fb4d7f45d1cf-6a42f1a7996mr25338353a12.6.1787560580503; Mon, 24 Aug 2026
 01:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818225715.572140-1-ameer.hamza@truenas.com>
 <aoVHBkmPNSRakbYW@infradead.org> <9ad95194-983d-427d-9a07-c9eb0891d1a0@app.fastmail.com>
 <CAOQ4uxgUOqFv6pVmdT_+4DjA0KQoQDCzN2Xz=xm1FyumewHZXg@mail.gmail.com> <5fb0315d-636c-44ff-8dcc-b4403e3be7c3@app.fastmail.com>
In-Reply-To: <5fb0315d-636c-44ff-8dcc-b4403e3be7c3@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 24 Aug 2026 10:36:09 +0200
X-Gm-Features: AcwNN1WbUUrdIhE63ctkhUNUI50-KXFxOZ9whJCv-sw8tICCqnP6sVVvcLZEnP0
Message-ID: <CAOQ4uxiVHcu2BUZejjS+YPuyyFWcsMwkpd+GxoZfxE_WKumY_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] NFSD: Fix duplicate fsnotify access events for
 iterator READs
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Ameer Hamza <ameer.hamza@truenas.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 6:21=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Sat, Aug 22, 2026, at 6:21 AM, Amir Goldstein wrote:
> > (1) In this series
> > https://lore.kernel.org/linux-fsdevel/20231122122715.2561213-1-amir73il=
@gmail.com/
> > we intentionally moved the permission hook outside
> > of the splice iterators because we wanted to avoid calling them
> > with freeze protection held and also there were some duplicate calls
> > for this work.
> >
> > At this point in time, the fsnotify_{access,modify} post hooks are
> > usually called
> > from the same context as the matching permission/security hooks.
> > It doesn't have to be this way, but it's a good mental model IMO.
> >
> > (2) emitting many READ events from an iterator instead of one event for
> > the user's READ request is more noisy and serves no purpose to users.
> > In most cases (but not always) those events could be merged, but at the
> > cost of futile CPU cycles.
> >
> > From a quick inspection of the code, it looks like:
> > - fsnotify_access() is missing in vfs_splice_read()
> > - the naming convention for splice_ do_splice_ vfs_splice_ is a horror
> > - we could make the low level splice_direct_to_actor() static and possi=
bly
> >   rename it to splice_direct_to_actor_sd() or something
> > - we could export vfs_splice_direct_to_actor() for nfsd which wraps
> >   splice_direct_to_actor() with permission hook and fsnotify_access
>
> IIUC this last bullet seems like clean layering to me. Do
> you want to propose a patch or shall I?

Be my guest.
Maybe Ameer will want to post it for v2.

Thanks,
Amir.
