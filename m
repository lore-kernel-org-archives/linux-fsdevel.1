Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3621037F8AD
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842318; cv=none; b=XU1mjIlTXRcy3NxyaiZQDK2BhK7ennUZGOt5Tr/1CYrDtCIblg7CTdJHili409/KNefpQ4n9F2u6QRkg8yEsicYNkMN8lUtPGRuBF317KQ60J2N1nM/YsaoJOVpFajE60TMcbBs39EsefxrLUjCdQ9cgGcqQID74HLvckvRHIY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842318; c=relaxed/simple;
	bh=k+ydTk0QaLJCjAG849vjhESxzvDKjxhiYt6Vpq47zB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1IKtcPwHtUohCLv51VJLZjnT82EOSmPjreAw2u2IVysUz10bD7ML6IOP/1L2dPVd5tGTaB0kaeC4Ldx+IZeayGOj0aB58ePSeqqSOvCf8bNhNhBYpL7f58UNw3WN/9pp2Q0VlMbiqjqpuV/SqGe6U+P9f2rl3Ukeh1YwqN91PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NvBHs058; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NvBHs058"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9d6c8871c7so276785366b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 10:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775842315; x=1776447115; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zo96QMZY3HeBUL4WoxLY2GyuuMY0rjzgz+AjqTICWwY=;
        b=NvBHs058sXjQazeMFF4VNOntiZ7XhOWlM/vQ96qsS0iADOernwvLiAistyocSq+crg
         wgT3FfRS2O1/+Io8BElaf3VRoL+ybTFdhHqGR+56Qx+cdK6zBtb0AwLmnDBw3DPcrrUi
         5naZ++4WzWuO5R6OIQjWtzSkdibwvN0854z1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775842315; x=1776447115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo96QMZY3HeBUL4WoxLY2GyuuMY0rjzgz+AjqTICWwY=;
        b=D7b7A+22MJ/0IsBHvkEfYlxIOzbiQoERXa0aj1CutA+kvDq9Iv7DiZL8aK4N6UAbpi
         NmQwkW6wdsEV1J3UkWjf2L2VJPI+jNX7TZ0hEHYgbgjBPRXZtCv/Kw2XMuIoiV4fPTyl
         9rJvRgLINada/IzoguBGQMt6gp1eE+qltFAeDwZtj7Y0S63XBLOU86cJOirW7Tlx14H3
         iuqTrQJjQJ5IEcvtKM6HgcrdrgJSnsu9OTvZ7EXf1VnGaFzI18vfW7qfVc5mjW4G0EVv
         toGAePWLXLDcUE2lf789ymBVLKUYLmJJSTIkmsOYP/0mcNLTn0dFcFp5akI8pXfO+Xfe
         WLBg==
X-Forwarded-Encrypted: i=1; AJvYcCVlHGsIQH+kfzXLPHYHzAV0QxI32y70CE0s1kn7WrSilnmebic5OFzhlobjer865XCwI5K099vktnI4nLPh@vger.kernel.org
X-Gm-Message-State: AOJu0YxWJf8+9CFospeN1HXQ64DVUiIdI4QNAmgy/AdOPOsLWhZVTxD1
	jDzCn1qszopAaycPuOTdEiHZ3UJRaOe8zLE7HEb24loK6d9/wk8k1WEQOFosnWHZ1hkZToBhXkp
	1FUOCh7DE/w==
X-Gm-Gg: AeBDieur+Yaf9dzj/g9E1b/d9dAn8B+laJ69hwqEtUGvD53iIT+d6gZME9vvx6SlQMg
	C+kTW01v4SNitndnwWh+j832jHudZ5Weg/ej2jjG1VT9Kqqyrz6cmycPzqw2/dPIrphqLvJJjxZ
	dNgOh13Pin4b5st3o7HVBYIBHnGknwTjo9Uf/h9gYTzDwx5w5N0EIvOWl/E/4oTZA29sEtqR3KU
	d8w2qqfgCayOCpEgDQdZaT++ONFZEmReUbg6v4glC027WC5jX13Gw2fYNHUUvw8JcX0xOfK+Mcr
	ernK/SmJFLjLJKYVk6wB3QHnvxdRQ3S1uNR6PEV+8hGLglkJWBDY1PmlFWk9gufR7Nm91cVEB+M
	NDgRLIv5m9qQtcpAdZlqyIDVdv9JkThImWk1keEf/FODqlHDoEai47EuLaQq77wGporc2Np+S4U
	5VuJH/20K3KNsR6DAWkI5Wokn8Z8Q6Icb9OG+rbg49VqI8hDhleTWrXnxBNOCSOuJ9wev8Nun6
X-Received: by 2002:a17:906:2081:b0:b9b:1511:a865 with SMTP id a640c23a62f3a-b9d7279d515mr192512666b.51.1775842315354;
        Fri, 10 Apr 2026 10:31:55 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6de97e9esm100069866b.11.2026.04.10.10.31.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 10:31:54 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66d24c6963bso4042878a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 10:31:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiY+fwe7IA5zYQwtE8SZzlxenKLTQQC3zBy7I1nGXUgehU2Qd3TlqXfqGBKxsIQ/KV5UyBWmWMZu3b1TPG@vger.kernel.org
X-Received: by 2002:a05:6402:3506:b0:66b:f154:2e81 with SMTP id
 4fb4d7f45d1cf-6707af159a4mr2185050a12.20.1775842309724; Fri, 10 Apr 2026
 10:31:49 -0700 (PDT)
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
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com> <adkk8FiLHnVx1Bup@tardis.local>
In-Reply-To: <adkk8FiLHnVx1Bup@tardis.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 Apr 2026 10:31:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuOm+AGHtjF15Zx8cxJwYwbzJgi28EQ6KW=Ze-4YjN+g@mail.gmail.com>
X-Gm-Features: AQROBzAh8JMnVxiM1A24Kuzu-JuK8Y1egm9AYkA0yrNK9eVAAzXDyfwYlkrQckM
Message-ID: <CAHk-=wjuOm+AGHtjF15Zx8cxJwYwbzJgi28EQ6KW=Ze-4YjN+g@mail.gmail.com>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
To: Boqun Feng <boqun@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nikolay Borisov <nik.borisov@suse.com>, Max Kellermann <max.kellermann@ionos.com>, 
	Eric Sandeen <sandeen@redhat.com>, Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 09:27, Boqun Feng <boqun@kernel.org> wrote:
>
> Notice in rcu_read_unlock_special(), atomicity/preemption count is
> checked in two ways:

Yeah, I didn't go that deep ... That code is inscrutable.

Raising a softirq looks pretty strangein there, since there's
absolutely no reason to believe that the preemption-off region has
ended before the softirq is triggered. It makes sense for the "we're
in hardirq context", but it also does it for that (needs_exp &&
!irqs_were_disabled()) case

So then it depends on the softirq checking it *again*. That all seems
a bit strange.

But it looks like rcu_core_si() does do that, and then falls back to

        if (rcu_preempt_need_deferred_qs())
                set_need_resched_current();

and it feels like maybe the rcu_read_unlock_special() should just have
done that itself instead of playing softirq games.

Maybe it's some off optimization, but going through the softirq code
doesn't _feel_ like it's the right thing to do.

I don't know this code well enough to judge.

Let's wait to see if Al's patch actually makes any difference. It
*shouldn't* make any difference, and maybe it doesn't. No need to
start chasing RCU bugs that may not even be there.

Jeff?

> @Jeff, just want to confirm, this UAF can be reproduced without
> PREEMPT_RT=y, right?

I haven't seen Jeff's config, but some of the syzbot reports that
*may* be related have configs that look pretty normal and didn't have
PREEMPT_RT.

               Linus
