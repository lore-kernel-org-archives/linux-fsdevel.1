Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.215.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793203172;
	b=kgylzVAyi+ZYygGJqGFttxGPDBgmZrzMtdzp6i9bAa0GybsLDYTbTzLLt4dMtpyP0fTT
	 Dh76V9dljm0FRWvt7je16FeMeUL/P/YINqTFr2FFa993HVf1uVqm8zFVNlWpUmE0/4oXA
	 2gSUk9rJnNSlj2e1YIr1YyL+8dbco6ZvK7BNT8OO2erNj0xvd8uYwBByPwA3ZWoBHH2+J
	 6OtgZfCO2yYzt4WwCviV7bukDXZ6hB8XOx3fz4Sme3sGoDxRoQQ2Dy5XCH7hZX9SqIKTQ
	 6AZZJls69xmAazc3JuYMGtg7/rXjTpiViksfjSgZ29fV0K6igaC+mWzGnJyygbQqNQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Dc4rW2+COMGPVHylYkAJkFpZ/yamBpz19LqtcOFzV+Y=;
	b=EqnfkiWtsVnxA2dAWNdSqYwAKB+BY+OsOYzxErJ0WNnMAPuKArTnydihNXLQWokmGtsK
	 5gj8QPF3QoAk3JDsYrTMi/PnP0kmVZyqoWeMV5vgEfDpyc05RWSaRUBbbXZh0RdxIQw7e
	 XfNBw79teKfSg93yVi/U5uv7iNEYBb4f+CGs2bVH2IV/lVzRYEVFqCPZkyxqI4vd860h9
	 J11iOs3mhS1HytJ6iabfPQQW29Nw9GPpkp9Ddp1PLQcNs6+Ucy+RG5Y4PgFI+GYKE7Pzw
	 8+Y3qP3AdReLqJ7tT2GL/q51cJDUwo827HU491mrfnWujs2OHoEfaK3xeasIlJ56lRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	arc=fail smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2721606A335
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 15:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2721606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso601911a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 08:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793203164; cv=none;
        d=google.com; s=arc-20260327;
        b=fVSEXa1v0PKm+2qvurvYimzT4TvdA6DzE319lX3kTr5R3Hd1j/pmNoxnRREINgzAOt
         KTyWVDrWFny0V+mX8c6GgshfkLECqCFnElzqcEN+8wOAr5jhFTC1cngirgw5Py40W11e
         NYo/kWRZzuMnl9j3YBJRMMzkzixV6QYR2jyYieX1MQzbzqGcyYUOayCiXJzbFeoV6CZf
         K5HoILZnbInZKppb1fBWtKcsysP9pQK/Szda1vA5gdcf5xQvQyWhQ8ZupbHx8sP368qW
         lJL7iC80bH438gZdFmanmp01xbycDIuP1zYXaEGGXgpiqRjVSwLrHVEXsBgmDTHCcnOL
         QN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dc4rW2+COMGPVHylYkAJkFpZ/yamBpz19LqtcOFzV+Y=;
        fh=1WmpHqfGel3saYL8IkGloA2UC8FN75qHw6pS694jYtc=;
        b=RVq7vNxmISqvtCh8S/OyZTzxY27oU3iN39+2sH+0MCBTNZBYB0+5fsLRXd7nYM3kgT
         f14/rDOXuGxKum3hYIBj9Lplzo/lePEuF2SfT44Hxks/DjzXbnjghZC/5Md6s7bM7qVl
         XEVdzcNbL0edkN5pryAvwbEkOz/7qTsylMjR26G7mdw+mgsurE655Nfb4h6+kfqXMXFX
         mFJKhzRhWDNMhQ9lK4AgSUpYbR5Zk8TY8Hq4gj5bnNfLVthO8KI0TJeYHeRVMg5ha2DZ
         2urh+1lEjXbVHAvvcj5R3NSE+bhE2soUfvRcIbp6Hgwevis0Rr2l2ZnaMib6F6j8I/GA
         4T/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793203164; x=1793807964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dc4rW2+COMGPVHylYkAJkFpZ/yamBpz19LqtcOFzV+Y=;
        b=Xde8kH+cqlVOr/NMR7Wf2JCxAomM8iaA+yOKnEWQdervZ/w503T0qYZZ6aOIBygAsC
         qij7djXE5tgEJO6Fg3dvN+llLaU0wfp5K3TXaIKEKfXug0iTHDU8r1pyoHvQ8B8Z6qgt
         UeXRTBxIPcUoikJFSeVCrlsd1QdQ1PIEIALNNtqalm4GbfnAzTbkILoS8EoRXI+ENlGT
         pCWcFvtvfNhYIGcmjkVaouZPomu9dr/9De7n53N+UKBzQxVuhbAHnVl9cFD2L8k5xutY
         S8PhqXCysvqF5qkcIRiApTxBmbXvToeiuo/7lzQYkr6Titoid+3/IYz90R+gzsrC9Oe+
         jeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203164; x=1793807964;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dc4rW2+COMGPVHylYkAJkFpZ/yamBpz19LqtcOFzV+Y=;
        b=FqmMQJkKoI/0I2XPgBhifo+tTpI/ywDTLbBoCOnCVY9vKXxiwyV62fFeH5Anzxmp/k
         SNJgp3AlFlFosuGtz4FrhBJZnvUcXT6uGPTMBAlsps90N5BX1gzpZU0RFmuR1tBPUHpz
         l/+/4VVHwVjFmyRnIgKmlMy0lO63uxC48uVFUwRE+q5DDZu93luSDJx+QKSFBvcJzflB
         2x5hjFbq8ByQUP89lpQIRnQfFbCSeQwRcxYREzs+b0Zkv9LmEKMCB37F3iuN3GRWeMHO
         njp7UO+Ax88sTnT+vleUtwX4Wdkc/guNWnYnONgg2xmWUVYN9AhilPp21m+YhVLhjM6/
         xUEA==
X-Forwarded-Encrypted: i=1; AKwUvBxlYnbAXvPxgqNsb3m1mVDaj+2q2u8TxNw6+AvFVPVNFGH4YHqXUVj9+UE1UDROUpuWBZYLQp48MXHiot9C@vger.kernel.org
X-Gm-Message-State: AFq9FYKXg/F3zap9c4lS5wGOwgwju1N4yMTzfEBi03/U7b+GU8zUJhjj
	87N08CitNPqSr0TLlABA5bE0cBxmbX2LyB81LeDCmZflbtCbWX9BGwgTGfCd6NVNLa3cxnXoQmE
	DwBX1IfcLgu8krr21IuPK3tjwGzJ1SH8Uo7nX1MP7
X-Gm-Gg: AYBFou1/c6w4E+o7/RFtoUo+YERbknNThlCH3VzfO31KckNrOvmO9oIjXjsE3WDy6Ew
	FgJVqwgbc6102GyhZhDn1K96V0PIwzGvF7thXKlafcdRvdJ3YGM5XUQc9GGWCkEP73QgDTFSQBe
	yZMUh685oJiyMVURC+iIkaZyhdbfWcEOAE25aeM1LPPQoYAFd8Qf3X+Cij2rLHGEmRPnQETPhH3
	koibsagKPhBX3w6092MsshR0xwnydUpEFAVIeTpUZdoXU7BQNhCcHQ6mvzGyR3ndbv3uJmHbWzn
	NEtmKe1EthLPoVnkDrapKoaGOm3esnnQY1Se9Sr0RUN+fzHEHVmsT5lOUcB/FWPp3yRifaFmLqA
	4iwOVqHgKo7dzOlnod6cIa1IzyolLWvkjhIq0qawqMtvJC5K3gAhuh1B8HhcvnzACsNhPmPxlgy
	O6A9f9htybtPSayw==
X-Received: by 2002:a05:6a21:6f16:b0:3e2:1823:2b4a with SMTP id
 adf61e73a8af0-3e901e829e8mr2186510637.0.1793203163924; Wed, 28 Oct 2026
 08:59:23 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
 <CAHC9VhR4rMydWiD-RFv-ABiYSG_txJuyrtdaowEXPY=CHEvFXA@mail.gmail.com>
 <20261027-heckklappe-halbmarathon-vorsorgen-849ffdc42aac@brauner>
 <CAHC9VhSJMPOY4X78ENEkAiNeVTCpvP76PgVDqTQfwaYfwnYwAQ@mail.gmail.com> <20261028-treiben-probanden-nachkam-e986afed3902@brauner>
In-Reply-To: <20261028-treiben-probanden-nachkam-e986afed3902@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 28 Oct 2026 11:59:12 -0400
X-Gm-Features: AclHuK-yJIwoCb3oIYP-IBqXnljTJgelOwPOEoH9t42fOb1qZ8AgXGe1E7dzuKE
Message-ID: <CAHC9VhQm+swDGvP31aNefwx6qCCy2mk-CjD4i=4kE74eA+e2zQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, netdev@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 6:45=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Tue, Oct 27, 2026 at 06:37:43PM -0400, Paul Moore wrote:
> > The hooks were merged into the LSM tree on August 31st, and due to
> > timing I'm guessing they appeared in linux-next the next day,
> > September 1st.  Considering the merge window opened on October
> > 18th/19th, that's conservatively a month and a half during which
> > testing could have uncovered this issue and the behavior of the hook
> > could have been changed to accommodate your use-case.
>
> That's what the rc cycle is for.

I believe the understanding is that basic functional testing occurs
before the RC cycle.  Considering the NULL check causing problems for
your use case was present in your first RFC posting back in February,
it's unlikely that you, or anyone in the BPF LSM space, tested this
prior to the merge window.

> I'm not asking for changes to behavior
> of the hooks to accommodate anything.

The LSM changes in this patchset do change the behavior, that's the
point.  The security_namespace_free() hook does not call into the
individual LSM callbacks if no LSM blobs have been requested; what you
are proposing now is that we change the hook so that the callback is
always called, regardless of the LSM blob state.

> > I know the
> > Landlock folks were testing the hooks for their usage, but I've gone
> > back through my inbox and I don't see any reports of BPF LSM failures
> > using these new hooks in v7.4 until you posted this patchset during
> > the merge window.
>
> Because I sent fixes instead of a bug report.

... which you sent *after* the merge window opened.  Once again, I see
no indication that the use case you are concerned about was ever
tested prior to the merge window.

> > The LSM namespace hooks are new to Linux v7.4, they did not exist in
> > Linus' tree prior to this merge window which is why I consider both
> > the BPF LSM and Landlock usage of these hooks to be "new".
>
> Yes, they're new. That's the argument for fixing them now. Not against
> it. No released kernel has these hooks. Once v7.4 is out every one of
> these fixes is a behavior change in a released kernel, needs a stable
> backport that by your own rules doesn't qualify.
>
> And on top of that nonsense, userspace has to probe for it forever.

It's a one line change in kernel/bpf/bpf_lsm.c to add the
security_namespace_free() to the existing list of disabled BPF LSM
callbacks.  No need for a patchset spanning 16 files and over 350
lines of changes; the BPF LSM callback can be enabled in Linux v7.5
after it has been properly tested.

It is probably also worth mentioning again to casual observers that
the LSM hooks, and their associated callbacks, are intentionally not a
stable API.  LSMs are advised to implement abstractions before
exposing the hook/callback API directly to user-visible interfaces
such as configuration policy, policy as code, etc.

> > As mentioned previously, I'm pretty consistent about what goes up to
> > Linus once the merge window opens: there is the initial pull-request
> > with the changes from the last development cycle and then after that
> > I'm pretty strict about only serious bugs/panics and regressions.
>
> Your README says "serious problems", not panics.

Are we really going to argue about how one defines "serious problems"
and "panics"?  You'll notice that I've used "serious problems" and
"panic" somewhat loosely in this email thread because the distinction
doesn't really apply to our discussion.  The issue you've brought up
is that a use case that was never tested prior to the merge window
doesn't work like you want it to work.  There is no kernel panic nor
any functional regression from previous kernel releases (user visible
or otherwise).  We'll change how the security_namespace_free() LSM
hook works for the next release which should give you plenty of time
to test that it works properly.

> A hook that is
> exported to bpf as an attach point and never called is a serious
> problem for an API.

I'll repeat myself again, a little louder for those in the back: the
LSM hooks and callbacks are not a stable API, if an individual LSM
needs a stable API to expose to userspace it needs to provide its own
abstraction layer.

> And it's not how you've handled this before: lsm_get_self_attr() was new
> in v6.8 and got fixed for apparmor and selinux at v6.8-rc7 (cf. [2]).
> v7.1-rc5 took Stephen's cred_guard_mutex change for lsm_set_self_attr()
> without a crash see (cf. [3]).

There is an important difference between those issues and the one
you've identified with this patchset: lsm_get_self_attr() and
lsm_set_self_attr() are syscalls while security_namespace_free() is a
LSM hook.  Linux syscalls are subject to the Linux kernel stable API,
LSM hooks are not.  Linux syscalls are directly accessible from
userspace, LSM hooks are not.  We could dive into other minutiae about
the differences between those issues, but the distinction between
syscalls and LSM hooks is really the only one that should matter here.

> > Disabling the BPF LSM support for the new hooks in Linux v7.4 should
> > be relatively easy, much simpler than this patchset, and eliminate any
> > claimed harm.
>
> No. That's a change to kernel/bpf/bpf_lsm.c which you don't maintain
> and the people who do have acked the fixes and asked for the whole
> series in v7.4.

 :D

Instead you're asking someone else to accept your changes in a
subsystem you don't maintain and when they push back due to lack of
testing and existing conventions you decide the proper approach is to
bully them and force the issue with Linus?  I'm used to dealing with
hypocrisy but this is truly something else ...

> You're proposing to rip working functionality out of someone else's code
> so you don't have to take a three line deletion. namespace_init and
> namespace_install work fine for bpf.
>
> It's also not simpler. The LSM part of this series is deleting three
> lines I wrote in security.c. The rest is my code and bpf's code with
> acks. Your version needs a revert in v7.5 so it's two cross-tree changes
> instead of one.

Adding security_namespace_free() the the disabled BPF LSM hook list
should be a one line change in Linux v7.4 (maybe three if you need a
Kconfig conditional for something) and then a one (maybe three) line
change in Linux v7.5 to allow it again.  Two patches, each at most
three lines, all contained within the BPF subsystem.

> > Also, as the ongoing friction between the LSM and BPF developers was
> > brought up, I want to point out that SELinux support for the new LSM
> > namespace hooks was delayed to Linux v7.5 due to issues uncovered with
> > these new hooks during the Linux v7.4 development cycle (well before
> > the merge window opened).
>
> That's not what happened. Stephen posted the fix on September 16, v3 on
> September 18. I reviewed it on September 25 and offered to carry it in
> the namespace tree for v7.4.
>
> On September 29 you said you'd rather take it through lsm/dev. It's not
> in lsm/dev. It's not in v7.4. A reviewed fix that was ready three weeks
> before the merge window didn't get applied. That's the same decision
> you're making now and it's not a precedent for it.

If you look at that thread, you'll notice I ended my last mail with a
"Are we all okay with that for this patch?" because I wanted to make
sure everyone was okay with the patch, and the process before merging
it.  Stephen answered that he was okay with the approach and you never
responded; I held the patch back exactly because you never explicitly
okay'd the approach.  I suspect one could make a lot of interesting
observations both about how that patch was handled, and how that
handling is now viewed from different perspectives.

> > I told you "next merge window", which is far from "no".
>
> For v7.4 it is "no". That's the release these hooks go out in. It means
> v7.4 ships with a namespace_free hook that never fires and v7.4.y stays
> that way because by your own rules the fix doesn't qualify for stable.
>
> > I'll admit to finding it odd that you seem to keep inserting yourself
> > into that friction point
>
> A large portion of code where new security functionality is added or
> modified all of the time is maintained by me and others.

... and when it suits you, or the BPF developers, you override or
otherwise steal ownership from the LSM space.  We obviously see things
different here, but if you're trying to convince me that you are doing
the Right Thing by inserting yourself into some of these discussions,
e.g. the recent LSM kfunc discussion, you are wasting your time.  To
borrow a phrase from Alexei's last email on that subject, "I don't
feel we will converge here".

> You're objection is noted and I'll mention it to Linus and then he can
> decide.

Please CC the LSM list and me.  I would also encourage you to disclose
the lack of testing you have done prior to the merge window as well as
your insistence that the LSM hooks become a stable API; if Linus is
going to change any of these policies it would be good to know.

--
paul-moore.com
