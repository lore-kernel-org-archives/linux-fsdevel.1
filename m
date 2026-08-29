Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C104119E4;
	Sat, 29 Aug 2026 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020108; cv=none; b=BPFrWaXeoY9wRffHxra+nhQv+x+PQU3fhDVmxwZNZN/JpM1HM+tjMbvtXxeCxYCjaC6xYd8PFBCfQRpJGiW69J7trIpmoZIu5dnL5xQKKLmQj01f8CX39ZAazm55Z4mXbHV/y0l9aXx00bfuMRJ/5+pykRU5ulljLKqDRLj68tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020108; c=relaxed/simple;
	bh=pZ3SLpqiCS+OOI3tRoR2gWsnZCSru2tNElsyfGcSbQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=St82nwaykWyilMEw3d4vtMuo9vCYl7KY+wbgOo8q20Vl7r/95F2BBBTAT0jvms7qtGxztrDmir3dI5RuDYu+p6oUMajlCqJf98pxnLVOtQas0AhBSfmFn7hmaBWCF0AHt+wfdUzfMKz+PHqYHvLQ8x4g87S1QemuAC4ao3k5rpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drb5GDYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drb5GDYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9356D1F000E9;
	Sat, 29 Aug 2026 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788020105;
	bh=xc0dshg3icHa4t1hcy+a6/4dL2k18cPTkAmU4zs69Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=drb5GDYwaBggoPBWIv0Of5e52CjZcMsiD37+jUCO9Yd8Ii5fdj5tBUCRaXn+3u5Uw
	 hKiraCi4jrS3BrFGSaZUpwwDjax+PDs+Jrt7gWAAbfQbjGPLORFiWdw2vYvj7ZBpSF
	 2pqQ3UZpD6n6RqkWL0ieiAM9CyDnbSC+llErbdloP9XA8JKojNDNn7ZWDny+KKpWMD
	 hQziTUNCAEmm+NH5tDlMSIYN+hvMTex9lhr2n8V/kTah1jGOe9IhwBODB9rj0M0a0r
	 0iu6deqBENxmL/fzTcHNUh8vqQIeAlG/tf3GZNwuF04fMNtaajK/mrNeHSpnCAPiX/
	 zYn2qlrWV/y6A==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v1 17/30] sysctl: net: use sysctl_field in SCTP sysctls
Date: Sat, 29 Aug 2026 18:14:43 +0200
Message-ID: <cover.1788018958.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAHk-=wjUmLrJd4KM4xvJHUN4P0r8oSu5LyvG4JipnhxizBrE9Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 26, 2026 at 01:29:00PM -0700, Linus Torvalds wrote:
> I detest this series.
> 
> Maybe it makes technical sense, but as long as it makes no human
> visual sense, I'm NAK'ing it as being garbage.

You are right that my approach added too many macros and made the tables
harder to read. Sorry.

> On Wed, 26 Aug 2026 at 12:43, Alexey Gladkov <legion@kernel.org> wrote:
> >
>  [..]
> 
> The whole series is full of complete illegible noise like this:
> 
> > +static const struct sysctl_field sctp_net_table[] = {
> > +       SYSCTL_FIELD_CUSTOM("rto_min", 0644, sizeof(unsigned int),
> > +                        sctp_rto_min_data, proc_sctp_do_rto_min),
> > +       SYSCTL_FIELD_CUSTOM("rto_max", 0644, sizeof(unsigned int),
> > +                        sctp_rto_max_data, proc_sctp_do_rto_max),
> > +       SYSCTL_FIELD_INT_MINMAX("pf_retrans", 0644, sctp_pf_retrans_data,
> > +                            SYSCTL_ZERO, sctp_ps_retrans_data),
> > +       SYSCTL_FIELD_INT_MINMAX("ps_retrans", 0644, sctp_ps_retrans_data,
> > +                            sctp_pf_retrans_data, sctp_ps_retrans_max_data),
> > +       SYSCTL_FIELD_STATIC_UINT_MINMAX("rto_initial", 0644,
> > +                                    sctp_rto_initial_data,
> > +                                    SYSCTL_UINT_ONE, &timer_max),
> [...]
> 
> where apparently the indentation has been decided by a rodent on crack
> who was given an Ouija board and instructed to ask his dead ancestors
> what indentation to use.
> 
> So no.
> 
> That kind of complete random code is simply not acceptable.
> 
> I don't know what the correct answer is, but it is *not* this series.
> It needs to be consistent and visually parseable by humans *without*
> asking your dead ancestors for help.
> 
> And it's not just the indentation. That SYSCTL_FIELD_CUSTOM() thing
> needs to be usable and able to do some minimal type checking - not
> just passed a random sizeof() in a random argumentt. I'd suggest
> passing the actual type, and then checking that the type *matches* the
> data pointer it is passed too.
> 
> The old code may be ugly too, and have various other warts, but at
> least it had somewhat legible and understandable initializers:
> 
>         {
>                 .procname       = "prsctp_enable",
>                 .data           = &init_net.sctp.prsctp_enable,
>                 .maxlen         = sizeof(int),
>                 .mode           = 0644,
>                 .proc_handler   = proc_dointvec,
>         },
> 
> is at least something that can be read by a human and those things had
> consistent whitespace rather than some quantum randomness.
> 
> And this is also just complete line noise that only makes the code worse:
> 
>     +#define SCTP_DATA(type, field)                                         \
>     +static type *sctp_ ## field ## _data(const struct sysctl_context *ctx) \
>     +{                                                                      \
>     +       return &ctx->ns.net_ns->sctp.field;                             \
>     +}
>     +
>     +#define SCTP_CUSTOM_DATA(field)
>              \
>     +static void *sctp_ ## field ## _data(const struct sysctl_context *ctx) \
>     +{                                                                      \
>     +       return &ctx->ns.net_ns->sctp.field;                             \
>     +}
>     +
>     +SCTP_CUSTOM_DATA(rto_min)
>     +SCTP_CUSTOM_DATA(rto_max)
>     +SCTP_DATA(int, pf_retrans)
>     +SCTP_DATA(int, ps_retrans)
>     +SCTP_DATA(unsigned int, rto_initial)
>     [...]
> 
> If we're doing these kinds of changes, the end result has to look
> *BETTER* than the thing it replaces, not worse.
> 
> Yes, a few of the patches did look better. But the majority of them
> only looked worse. Some of it should be easy to fix: use consistent
> whitespace, and use sane argument ordering.
> 
> But honestly, the old setup didn't *rely* on argument ordering, and
> used named initializers to make things more legible and robust.
> 
> So I suspect that should be what you should aim for in the new setup
> too, and that probably means "completely different approach".
> 
>                Linus
> 

I tried an alternative based on offsets. The following four patches add the
infrastructure and convert IPC, SCTP, and MPLS as examples.

The remaining macros are short wrappers around offsetof() and are only used for
compile-time type checking. If they still hurt readability, I can drop that
checking and use plain offsetof() instead.

Does this look better for you, or should I just stop?


Alexey Gladkov (4):
  sysctl: add typed field descriptors
  sysctl: ipc: use typed fields for IPC namespace sysctls
  sctp: use typed fields for per-net sysctls
  mpls: use typed fields for per-device sysctls

 fs/proc/proc_sysctl.c  | 282 ++++++++++++++++++++++++++---
 include/linux/sysctl.h | 134 +++++++++++++-
 ipc/ipc_sysctl.c       | 188 +++++++++----------
 net/mpls/af_mpls.c     |  66 ++++---
 net/sctp/sysctl.c      | 398 +++++++++++++++++++++--------------------
 5 files changed, 703 insertions(+), 365 deletions(-)

-- 
Rgrds, legion

