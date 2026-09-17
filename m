Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D5E5437C3;
	Thu, 17 Sep 2026 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652509; cv=none; b=gcYJxEzQm+gfBQw9f6Jz+l8uDxAoKL3Kh/mCn3vlFXdDq4lPHJdjfNcc8T4ul1zqHzF5vI4u1zyg6PQjIdYzjv86X+G6sZ4Pfpad5dJF9fEC/sLqKrWamHts+NH/naFx54nV0iRQKbvOgX7zR8w1P+l96lUPlDyU9zJyEzYZ4mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652509; c=relaxed/simple;
	bh=YI0Cx9FvUZnYWYzPP97nAy2utmrPlLGd7dgg7AClPbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijHD0AdgbjWoMosKaBHm2fhFmXnzHc7Om65voFSO8ziz+nMBYzm3g5Rf/KhGUWRzoxkYaVBJ6YCgw1YK6RC11BqEYvQgr6O5bRbEtJz0bD3SAL7Sn5+kxbeIyI2H4GMYnRNBXQ5GI5UlPwZL/Z484l8fWEAG8jLzYue0Py+nT4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wy3eSw+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy3eSw+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555721F000FF;
	Thu, 17 Sep 2026 13:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789652499;
	bh=gJ22yo9yCHiTXjQt3n/IT8A61LRmT2xZHkkP6dqqJbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wy3eSw+cphvrauiuGoyldhXvf7dTZCpK3rKwqtp0JAWVVm3P3NLsp1Lwa0B7G/xuS
	 QSWIumVrZdhPKhHEmKcf8Njq+Z6Gp/XcS8NpMicg85jz1k9CJgo6kpS3LKxzpoMh08
	 ICEq1gyddBKAfpkHta1eq76wXUdiyP01Ip1Q5P9FF8TLtN3d6IP4uYAWbQJwRQ74ZS
	 ouTl1lGBs+dFokm0AEYJcOeiB4hLRtn3ElLqR9MNxRmG+uifl26VgAhZWTIwfnN5KB
	 +ieGv4LbFp2tQ+PGXmCwp2hXPZKFEAoH7Lk6OnCUeMXpZFPRtW29xwk81/fOsDSTmm
	 Y9iUBFD3Yh3GA==
Date: Thu, 17 Sep 2026 15:41:35 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v1 17/30] sysctl: net: use sysctl_field in SCTP
 sysctls
Message-ID: <aqvuD9PwPkzDP2_i@example.org>
References: <CAHk-=wjUmLrJd4KM4xvJHUN4P0r8oSu5LyvG4JipnhxizBrE9Q@mail.gmail.com>
 <cover.1788018958.git.legion@kernel.org>
 <2ywlit7st4wqghx2lav6qc5bbcxbaln445fghjnwj5n7dg2w4v@ajhrrgm5ck4r>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ywlit7st4wqghx2lav6qc5bbcxbaln445fghjnwj5n7dg2w4v@ajhrrgm5ck4r>

On Wed, Sep 16, 2026 at 02:26:01PM +0200, Joel Granados wrote:
> On Sat, Aug 29, 2026 at 06:14:43PM +0200, Alexey Gladkov wrote:
> > On Wed, Aug 26, 2026 at 01:29:00PM -0700, Linus Torvalds wrote:
> > > I detest this series.
> > > 
> > > Maybe it makes technical sense, but as long as it makes no human
> > > visual sense, I'm NAK'ing it as being garbage.
> > 
> > You are right that my approach added too many macros and made the tables
> > harder to read. Sorry.
> > 
> > > On Wed, 26 Aug 2026 at 12:43, Alexey Gladkov <legion@kernel.org> wrote:
> > > >
> > >  [..]
> > > 
> > > The whole series is full of complete illegible noise like this:
> > > 
> > > > +static const struct sysctl_field sctp_net_table[] = {
> > > > +       SYSCTL_FIELD_CUSTOM("rto_min", 0644, sizeof(unsigned int),
> > > > +                        sctp_rto_min_data, proc_sctp_do_rto_min),
> > > > +       SYSCTL_FIELD_CUSTOM("rto_max", 0644, sizeof(unsigned int),
> > > > +                        sctp_rto_max_data, proc_sctp_do_rto_max),
> > > > +       SYSCTL_FIELD_INT_MINMAX("pf_retrans", 0644, sctp_pf_retrans_data,
> > > > +                            SYSCTL_ZERO, sctp_ps_retrans_data),
> > > > +       SYSCTL_FIELD_INT_MINMAX("ps_retrans", 0644, sctp_ps_retrans_data,
> > > > +                            sctp_pf_retrans_data, sctp_ps_retrans_max_data),
> > > > +       SYSCTL_FIELD_STATIC_UINT_MINMAX("rto_initial", 0644,
> > > > +                                    sctp_rto_initial_data,
> > > > +                                    SYSCTL_UINT_ONE, &timer_max),
> > > [...]
> > > 
> > > where apparently the indentation has been decided by a rodent on crack
> > > who was given an Ouija board and instructed to ask his dead ancestors
> > > what indentation to use.
> > > 
> > > So no.
> > > 
> > > That kind of complete random code is simply not acceptable.
> > > 
> > > I don't know what the correct answer is, but it is *not* this series.
> > > It needs to be consistent and visually parseable by humans *without*
> > > asking your dead ancestors for help.
> > > 
> > > And it's not just the indentation. That SYSCTL_FIELD_CUSTOM() thing
> > > needs to be usable and able to do some minimal type checking - not
> > > just passed a random sizeof() in a random argumentt. I'd suggest
> > > passing the actual type, and then checking that the type *matches* the
> > > data pointer it is passed too.
> > > 
> > > The old code may be ugly too, and have various other warts, but at
> > > least it had somewhat legible and understandable initializers:
> > > 
> > >         {
> > >                 .procname       = "prsctp_enable",
> > >                 .data           = &init_net.sctp.prsctp_enable,
> > >                 .maxlen         = sizeof(int),
> > >                 .mode           = 0644,
> > >                 .proc_handler   = proc_dointvec,
> > >         },
> > > 
> > > is at least something that can be read by a human and those things had
> > > consistent whitespace rather than some quantum randomness.
> > > 
> > > And this is also just complete line noise that only makes the code worse:
> > > 
> > >     +#define SCTP_DATA(type, field)                                         \
> > >     +static type *sctp_ ## field ## _data(const struct sysctl_context *ctx) \
> > >     +{                                                                      \
> > >     +       return &ctx->ns.net_ns->sctp.field;                             \
> > >     +}
> > >     +
> > >     +#define SCTP_CUSTOM_DATA(field)
> > >              \
> > >     +static void *sctp_ ## field ## _data(const struct sysctl_context *ctx) \
> > >     +{                                                                      \
> > >     +       return &ctx->ns.net_ns->sctp.field;                             \
> > >     +}
> > >     +
> > >     +SCTP_CUSTOM_DATA(rto_min)
> > >     +SCTP_CUSTOM_DATA(rto_max)
> > >     +SCTP_DATA(int, pf_retrans)
> > >     +SCTP_DATA(int, ps_retrans)
> > >     +SCTP_DATA(unsigned int, rto_initial)
> > >     [...]
> > > 
> > > If we're doing these kinds of changes, the end result has to look
> > > *BETTER* than the thing it replaces, not worse.
> > > 
> > > Yes, a few of the patches did look better. But the majority of them
> > > only looked worse. Some of it should be easy to fix: use consistent
> > > whitespace, and use sane argument ordering.
> > > 
> > > But honestly, the old setup didn't *rely* on argument ordering, and
> > > used named initializers to make things more legible and robust.
> > > 
> > > So I suspect that should be what you should aim for in the new setup
> > > too, and that probably means "completely different approach".
> > > 
> > >                Linus
> > > 
> > 
> > I tried an alternative based on offsets. The following four patches add the
> > infrastructure and convert IPC, SCTP, and MPLS as examples.
> 
> The last 4 patches landed intertwined with the initial 30+ that you sent. Will
> you send a V2 with just the latest 4?

Yes, I want to prepare a patchset with a new implementation this weekend.

I want to split the patchset into several parts to make the review easier.
First, I want to create patches for proc_sysctls that add a new mechanism
and a few simple users, such as ipc_sysctls and mq_sysctls. Then I’ll
create a patchset for the network subsystem, ucounts and other large users
of dynamic sysctls.

I need to rebase to the current master branch because sashiko can't verify
my patches.

-- 
Rgrds, legion

