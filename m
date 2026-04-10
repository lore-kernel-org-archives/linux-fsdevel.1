Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0613DA7FC
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834748; cv=none; b=Pge7v8tdtXVVpBM31G7BqdEWQhPwFMh1wNjZ2YseTF0RDVhtrXZWO7PvJQ3dzEBzbaaLw4JJLffajTbrbw6BKRTnlqU03ownl22idALgaMwrNjHBH4f5wwUk00XnBAXUIA5mIVZCTE4PRTGATNkkkGdFH90yMgpzYRd3p39WZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834748; c=relaxed/simple;
	bh=jt5MzRJcqmBJIw0S1eoAyOdkcbsRtUQRClHrQFFbxM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DT0g/4GhPA9VIcnapnIatmaHbEwF+YQVp4jn/jK+wGkOOWQSnW7YGGozviXmTqgRAtHf7bElaeSv1svDvnSTLIC9natxK2jrp6D8squEciGyqSmJXqI5GkI3j0G5vTPZe6uWN+9axNkdWi06MWVAnOgD6sCy2KQKnT4FiDXlNhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aihF3Zbd; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aihF3Zbd"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b97f9587e6eso292517266b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775834745; x=1776439545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EFxrNom+LGBTWSdIx2yRNYx5a7fsFD6dDJITglxXB68=;
        b=aihF3ZbdWss/0GumeKphVCvczNfT2OD9PFmGGayvLk0A+JAyJSHcxMRBs8UubbbX3a
         RG+rSUaKtFNfVLKtWned21QPptlCW2DswuZoO3TBhzwNxzqAaqXqiqorcBtnwK0AqXCk
         v7IGDtT4qN0mdQLyGkNX3s/dWeHwazaSUJISQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775834745; x=1776439545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFxrNom+LGBTWSdIx2yRNYx5a7fsFD6dDJITglxXB68=;
        b=H4QGHI45xoMUBA3rjuL8jS8akUVvpbLFbPH7r2cQgJw1xrAYTn/Va2/HYMfjwGRxhr
         9CHYlhusj2i7Ybcfsn56QJXPmNVeOxSu6B6n8864DNFDgtEFTlvjEEBU3BhR4Svi+HE2
         uBDpbPT+dIadpoYS/4/VO3hwg21Qrd20Ml8E3MVzpm8NjB2UY7Q4jGJPKG7CUfzUHoCj
         EgQUo+QAZAOTiJ3d+D+UpvhR3biXvs/FcdnOsjyJY19AiIylNj2t7nO6LWkiRBpCHa9G
         oSY4gd6POqyPXc8vykx24ENH3V8f+6ZS7lEDtEx2R+M3WbIUj3x/mD7H0Z7vrCZgPdu8
         ATqg==
X-Forwarded-Encrypted: i=1; AJvYcCWxFmdBHG3wuJOIICXTQuEn4p6OXAfe06gzC+iLCulwJji1U7km3dBQm0HuAibks+rax/WnTcpHom44YW7O@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/HAKBqD5GNf54giAn0uXDASijx/ENTgCOWeAI3Q2Al3WDmWca
	SNW1pyQBX0tBPmj6BYgIHQKcodLKg8rhV3vLHOLfr5/qGQ8/Uht75aHuy2UZtvnEgIAEoowp+he
	8kt4Zhs8HZw==
X-Gm-Gg: AeBDietJm1sclj5MUpEcayqnO6ndWtvif9SLdco4duj5DqN4nKokL5zTNFoGd1O2h5+
	oeYK0M7XtdL1UeXEdjGX19UOoBMiOmzuzSMIqcChw+kEOnGkkIlHN/s9ZDps+oJ3yj0BiHjPjap
	djmWASrpM8F5eFQB0FA/H3Ae9T+3dRApjUz6YQv7opbbRrfrJAEucJVYjLJh4zgKdsK4yHy0U/Q
	kZz1+iWa8HE6DgeI/ERXjEDl5bNoXp4vF6D+ihMdzm7D6z36mcZ279L1erqwkx8VR012R+nA837
	fTPg3vTFFWz3Vc0MWAeNVgO3EFUMuSInVwxs1o3s/AJLD5yJYCxlBgVQs9sD2dkT7cADRZxiJcZ
	gK0LTfI6FCXzvVUZVPJDkkBF6FtsMWMhMBth1I6zhJ+KRl0QLiulQVEWKLsO+cHBfQURxyrURcG
	1bD2fyL8xWnSHG3ZqLWo8Jv26rGqNAgOJb9l2mB2Z6thoYDYTowyhBcuz5ClkyzadDw2xgLsy5Q
	VeBEX5krj8=
X-Received: by 2002:a17:907:9607:b0:b96:e0b1:ccf4 with SMTP id a640c23a62f3a-b9d72832431mr256961666b.47.1775834744681;
        Fri, 10 Apr 2026 08:25:44 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c5457sm89137966b.35.2026.04.10.08.25.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 08:25:44 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9c1da7ac63so345105566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 08:25:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3890lkYkxwY9HwH3NDiJsVej+WkuC4aqwk2aSh7z0QTITJIwbC4MIBb1wqmqVVSEfT0W5OvmlUPoJoz9U@vger.kernel.org
X-Received: by 2002:a17:907:6ea7:b0:b9d:61c7:2343 with SMTP id
 a640c23a62f3a-b9d724ec21cmr225511166b.10.1775834743689; Fri, 10 Apr 2026
 08:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122202025.GG3183987@ZenIV> <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
 <20260409190213.GQ3836593@ZenIV> <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV> <20260410084839.GA1310153@ZenIV>
In-Reply-To: <20260410084839.GA1310153@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 Apr 2026 08:25:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
X-Gm-Features: AQROBzAw5_1m8N9UOtFfbuoTikEZLlqc2pE01Y69a0tpciID5MStGTJKRW8xwM8
Message-ID: <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
To: Al Viro <viro@zeniv.linux.org.uk>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nikolay Borisov <nik.borisov@suse.com>, Max Kellermann <max.kellermann@ionos.com>, 
	Eric Sandeen <sandeen@redhat.com>, Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"

[ Adding RCU maintainers to the participants: see

  https://lore.kernel.org/all/20260410084839.GA1310153@ZenIV/

 and the fairly long thread associated with it  for context ]

On Fri, 10 Apr 2026 at 01:44, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> [this may or may not be the source of UAFs caught by Jeff and by Helge]

Hmm.

I think this patch may indeed fix the problem, and I don't mind how it looks.

But while I think the patch looks fine, I am still quite unhappy about
it if it matters - because we have very much documented that spinlocks
in themselves are also RCU read locks:

        Note that anything that disables bottom halves, preemption,
        or interrupts also enters an RCU read-side critical section.
        Acquiring a spinlock also enters an RCU read-side critical
        sections, even for spinlocks that do not disable preemption,
        as is the case in kernels built with CONFIG_PREEMPT_RT=y.
        Sleeplocks do *not* enter RCU read-side critical sections.

so *if* this makes a difference, I think it's actually implying that
there's something wrong with our "rcu_read_unlock()" implementation,
and that it doesn't nest properly.

Because our documentation also makes it very clear that this should
all work as-is, and your patch should be a complete no-op. Just a few
lines later in that core RCU doc, we have

        Note that RCU read-side critical sections may be nested and/or
        overlapping.

so the order of the spin_unlock() and the rcu_read_unlock() *should*
be entirely immaterial, and the order of unlocking simply shouldn't
matter.

So it may indeed be that relying on the ordering of RCU read unlock
matters for the case of explicit unlocks and the implicit unlocks by a
spinlock, but that's not great.

Does the rcu_read_unlock() code perhaps only check the RCU count, not
the atomicity count? That would explain it, and looking at
__rcu_read_unlock() in kernel/rcu/tree_plugin.h that may indeed be the
case (rcu_preempt_read_exit() seems to only check
rcu_read_lock_nesting).

This is most likely dependent on kernel config options, and it may all
be unavoidable becasue RCU might not even have a way to tell that it's
still in a critical region without preemption counts etc.

But if it's unavoidable, we need to update the docs about this gotcha,
and we need to have some tooling scan our existing code for this
documentation change.

RCU people - what do you think?

          Linus
