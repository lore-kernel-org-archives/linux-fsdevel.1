Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6CB3B6C15
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 22:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781561000; cv=pass; b=q3/OB2ppAFHufBRRWCYgFeUd2i//6W4AZ9ZdThLHt//BTj9dQPeGyTyTgW39QhV60VtN3oBp93zeDlC869CEIMBEnp8god5jWjHsctsbXgujtwC6N7NGX8XGDYFCxzPokiitvSfFD5SnOl1QgzIJlnTk/DF8S9iYORDvno+qVf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781561000; c=relaxed/simple;
	bh=EmFKaOA4oNrlRBvxBZ9rHktVxwJtkaco4eJBdSabd3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stQVeMW4ML1F484eNSW/5APQvXyj2fM/5R+5fTmdBXq3bvNW4S1bPDq+vziR0wKwua6u/84Qj0vjDkXTei29HzKT2jMg1srVBG23LXFU57uyje01tI7VVIsxi6zFFlBVTnKl7U06kuv0LqURrcTCG3SXUZ62H2Jc1WTGxk48FrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BJDCw6rF; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BJDCw6rF"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36dac5d5da0so1833935a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 15:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781560998; cv=none;
        d=google.com; s=arc-20240605;
        b=GTA1zwr2fmSZGTgwV46QEHUxHSFhQOBtFcm7GRI8dT1oSWLkNNNBEurhvN7nt2k3kE
         VwwI63BJfBojJkiyxFVucouSU9fdkcxopyUqrCXOo/GE/fwAovb19zug90P8Yx9fe8t+
         JE0PARWHd8j+sSljQxoRrEurE++MFGKw60AutL+dweUkSHYgO/3t5F3jNgZgBv6jB9WG
         3zB4RUlREK5pGayyLwlPjSJRtfkqLRJNhryxCgS1VW+KAHdje7shzmC4eniu9b9vpe7g
         IyhhPlGSRDLcJW/tMV0wItFD+uJtzt2DND8GkFCFI70stHJRqL/glACcemT2gDjEUwaN
         RFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wlUiFVf+F3ja4t9u45sKndzLjC4xR7XGyYPH3sd+NYE=;
        fh=jvD5agYJVKRlEeG0o3M5iAjugXPlCATy09nBySWS1u8=;
        b=Y8nVeYTu73Bf00w3+0ZEIdxJA+vriKlJgza5p+x8LJ6AIgVkCP5foXOSAnrKMQJqxY
         X5HlV1PeVCqN7XpcnIql5ICnWrGhMHftHCMbwBRymQUDtmfBWNbJ3yvL24VBD6pzHBWk
         rLUiOeB6BBkr0zkQHvjgAmpu3OaSJ5JEmxtoA6ZzBK7xnh6p7pnU9IMrujjtyahAFvF9
         IhoBDDAt0+yD/v1eeqzJlDt6nbW2Fuy7bzOyEneVN7UufyPA+rb8nhiPziFmiFsel37g
         ucK1m7VsDrMl/9Zu1JWktoMVCYOuxL6HJBP7+n0ShilOQQWV+iRAT5EyoGz6A7amwQTz
         p6Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781560998; x=1782165798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlUiFVf+F3ja4t9u45sKndzLjC4xR7XGyYPH3sd+NYE=;
        b=BJDCw6rFumNKx1ZbmdQRzwmpdly4t68vMzh62PCU+SCpV2yNZCUodou4EdDx/Qx/MW
         6uqjkPcrhEixJmavhk0DxWbhFDZR6Ex++CRCCuuwVmXO4Oa3rzjm3nBbdFcVNypyppAu
         b4zj7rSqzAj8uFRh0O/3B5yoknz35ttIPmwb/1KKWMah3EJkJNZutoqrUj6nPJGS3ZcG
         Cvhq67+/rF3lat4Nwclq1vhvdOUm0JkDpMEC0c8BWgcN6b9IoWnboCiqP+wWbNyVOK7d
         hkX69MERi9QInOruF7yjj8dzkr/v69LsZ8kg533CZ5rzzjIz4XNw+lzP+R5YRw7VvQVU
         bKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781560998; x=1782165798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wlUiFVf+F3ja4t9u45sKndzLjC4xR7XGyYPH3sd+NYE=;
        b=TJjyXf83/bQXL9Ct3+oavzOoDtG6ts9ooMzpOR5Pb9IueCs1Fbr41Ogdovx56q6L/2
         3i3mBA40eBik0Cn4V+wyChK2D6B0pNwuinbJB/XNeTu5Is4Sd/GxMqzN5ZwvSVKMdubw
         QmSkG8gqPshywspqCfvOHPd43p2dwJpvq3qCwN2bOFPM3a+c5nCumC8G4XJD1q+ULRfU
         /aKzbrnC8zaTBcPw4wttNlpqfadpIGzOZUYCt+oxaaYkxX9p5omlDxfAW+ikMn09PKNG
         XqczAliO2qGQK+TcY2gzK5K2zT4RnUGfEBbvdUfEd/LK/ib7Vxv4wPoxL7QvShNtXQOA
         S3xg==
X-Forwarded-Encrypted: i=1; AFNElJ+agDcox5hofZ2dgVtLPl4swFqmjBG74BFoxwFAQCTCGIc9k1RZWpmg2Vsa4qUMCK4l6TTJpDBqGpamWdu3@vger.kernel.org
X-Gm-Message-State: AOJu0YxOAGpNET4qR7gcpgMmueoCKtZpSIQ+qohigJOTZvIoefdgGQDz
	Tw9BzK51HB8saEK3s4IjIF1rxOef8ZPeFaWEqP/zz6mXRSXZpWl6Er+9TFQNC0uM+Pjq0XO+aKV
	s0b4o+VOX68bRvaGYIIDA1zp9t8WfIO+M2vWvtE7o
X-Gm-Gg: Acq92OEyueodUzvHG83qxRJDcze2xfY+7WpWDhBBhZX1pckEQCMa+r70SvsCKxstJfy
	bXF36Cz2rEksRUOjbQ34cvHbSr/NS9sfV8b6nhrglfOjCX51+SkU/wX0LClmq6+rMG8RcAoDtf1
	Uaxkwc80YnD00feQwN3hjRyfrvrLcBjO+gRhqdiAdy0131wDJadZj0HrhXrLd2Zs0b5FlaUtBsS
	LvjvBmBdxea2WqaZIaPWfuSXY9cuY/JOgb0pzYkEC+SW9fCmWWWf4LsrodGQgA8+zsF9gs13IGN
	zDkV2Wk=
X-Received: by 2002:a17:90b:6cc:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-37c5280310fmr980748a91.1.1781560998051; Mon, 15 Jun 2026
 15:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526142838.774711-1-atomlin@atomlin.com> <20260527085221.GQ3126523@noisy.programming.kicks-ass.net>
 <bgjagepcfb7gz6jawatu6kpfmecw46gwg5cvb6r7dl3dn7bt4l@rtymdaslx7ef>
 <20260527155404.GV3126523@noisy.programming.kicks-ass.net>
 <ov33cu2wosubbfufcmfyoinfatecskjgmkvqyit33komlcla2d@2qgj45724bql>
 <20260527195858.GC3493090@noisy.programming.kicks-ass.net>
 <6hqq5oxvlcpmjvyns42dy2vtfvvixy7q4xyyjrrn46jrvsx5ar@gkmjsteqlpzd> <exlgb3dg2kwxgna6gx2qixexvwjjul7z2ya7npal2gz4jjtr7m@h4oxgd74gsbp>
In-Reply-To: <exlgb3dg2kwxgna6gx2qixexvwjjul7z2ya7npal2gz4jjtr7m@h4oxgd74gsbp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Jun 2026 18:03:06 -0400
X-Gm-Features: AVVi8CfvZsjFK88VKetzhE6sTJzGZThz-uSnhi3jqg2JCvabtyn_WzFIJ4i1dgo
Message-ID: <CAHC9VhSROg6RGUN4_ZVBoEwYjRnKvyjnkbx2D88c09KiTgY3KQ@mail.gmail.com>
Subject: Re: [PATCH v3] security: Expand task_setscheduler LSM hook to include
 CPU affinity mask
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tsbogend@alpha.franken.de, jmorris@namei.org, serge@hallyn.com, 
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	stephen.smalley.work@gmail.com, casey@schaufler-ca.com, longman@redhat.com, 
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	chenridong@huaweicloud.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, omosnace@redhat.com, kees@kernel.org, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, cgroups@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 11:22=E2=80=AFAM Aaron Tomlin <atomlin@atomlin.com>=
 wrote:
> On Wed, May 27, 2026 at 09:19:11PM -0400, Aaron Tomlin wrote:
> > On Wed, May 27, 2026 at 09:58:58PM +0200, Peter Zijlstra wrote:
> > > On Wed, May 27, 2026 at 01:41:52PM -0400, Aaron Tomlin wrote:
> > >
> > > > > > The actual use case here is multi-tenant workload isolation and=
 visibility.
> > > > > > Passing the evaluated cpumask to the BPF LSM allows operators t=
o write a
> > > > > > simple eBPF program to detect spatial boundary overlaps (e.g., =
logging an
> > > > > > event if a requested mask intersects with platform-reserved cor=
es).
> > >
> > > Why isn't cgroups good enough to enforce this? If you create a cgroup
> > > hierarchy per tenant, and constrain them using the cpuset controller,
> > > they should not be able to escape, rendering this event impossible.
> >
> > Hi Peter,
> >
> > You raise a very fair point. The cpuset cgroup controller is indeed the
> > kernel's primary vehicle for spatial enforcement, and under normal
> > circumstances, it successfully prevents a tenant from escaping their
> > designated cores.
> >
> > The cpuset controller does govern resource limits, but does not audit
> > intent. When __sched_setaffinity() is invoked, the kernel compares the
> > requested in_mask against the task's allowed cpuset. If there is only a
> > partial intersection, the kernel silently truncates the requested mask =
to
> > fit the cpuset, without raising any alarm.
> >
> > The BPF LSM hook, conversely, receives the raw, untruncated in_mask,
> > affording operators the visibility to detect, audit, and even reject th=
ese
> > violations of intent before the kernel silently sanitises the input.
> >
> > This patch does not seek to replace the cpuset controller, but rather t=
o
> > complement it by providing auditing capabilities.
> >
> > > > We are not creating a bespoke BPF hook here; rather, we are rectify=
ing a
> > > > historical blind spot within the API. The existing LSM hook is invo=
ked
> > > > during sched_setaffinity(), yet it presently receives only the task=
_struct
> > > > pointer. Consequently, the security module is essentially asked, "S=
hould
> > > > Process A be permitted to alter Process B's affinity?" without bein=
g
> > > > informed of the proposed affinity itself. Providing in_mask simply
> > > > furnishes the existing hook with the requisite payload to make an i=
nformed
> > > > decision.
> > >
> > > It occurs to me that this same argument would require to also pass in
> > > the new sched_attr, no? That way the LSM can inspect the new policy
> > > before it becomes effective.
> >
> > I agree, the underlying logic does indeed extend perfectly to sched_att=
r.
> >
> > Presently, the LSM is equally oblivious as to whether a process is
> > requesting a benign transition to SCHED_BATCH, or attempting to escalat=
e
> > its privileges by requesting a real-time policy such as SCHED_FIFO with
> > maximum priority. Just as with the CPU mask, providing the sched_attr
> > payload would rectify this parallel blind spot, allowing BPF policies t=
o
> > inspect and mediate scheduling attributes before they become effective.
> >
> > If you are amenable, I should be more than happy to expand the scope of=
 the
> > forthcoming patch to include this. Alternatively, we could address the
> > sched_attr expansion in a separate, subsequent patch. Personally, I wou=
ld
> > favour the latter approach, but please do let me know your preference.
> >
> > I very much look forward to hearing Paul's thoughts on whether this ali=
gns
> > with the broader LSM vision.
>
> Hi Paul,
>
> I am writing to politely follow up on the discussion above regarding the
> proposed enhancement to the sched_setaffinity LSM hook.

Generally speaking I wait until all dependencies land in Linus' tree.
I've lost a lot of time in the past sorting out issues only to have
one of the dependencies rejected.

> As you will see from the thread, Peter Zijlstra and I have discussed the
> architectural justification for this change. While the cpuset cgroup
> controller effectively handles spatial enforcement, it silently truncates
> requested affinity masks. Passing the raw in_mask to the LSM hook enables
> security modules (such as the BPF LSM) to audit and mediate the actual
> intent of the request before the kernel sanitises the input, a capability
> that cgroups inherently lack.

The issue of resource control comes up from time to time within the
context of LSMs, and my general comment is that we likely need to see
a more comprehensive approach to what access control on resource
limits would look like from a LSM perspective.  We've seen a lot of
quick changes to solve very specific problems, but I have yet to see a
good proposal of what it would look like for a more comprehensive
approach.

There is also another issue to consider: none of the in-tree LSMs
currently use these new parameters, raising questions about their
purpose, maintainability, etc.  While this is not necessarily a deal
breaker, it does go along with my comment above about taking a more
holistic view of LSM resource controls.

To summarize, I haven't thought about this too much yet because there
are other fires/patches that don't (currently) have the dependency
issues of this patch.  I would also feel a lot better if there was an
in-tree user of this parameter and some discussion of how this might
fit into a more holistic approach to controlling resource limits in
the LSM subsystem.

--=20
paul-moore.com
