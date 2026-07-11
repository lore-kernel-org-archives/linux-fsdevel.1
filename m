Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6192BE03C
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783784776; cv=none; b=LfcW079O8LZjH8IiPrW/Jyh1detH0zdjJF6Hg0oMAmSICSLAFEEtdWIzFGbaryXdXo2Kfp10NUo/ElHKY+Jywdspfq5BakKMNwIeRkOg3Iu/EW1r06NiyuknjPCbJ/UxIeA+aMtpnwLxjMiuS8H0jRJK0KAYsJxZKFepkFNT4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783784776; c=relaxed/simple;
	bh=IMlHLsqa76DQv38CtqxVW1r80PfJXYDuVLnGnDDB4hw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HIkS9EK11AsL8IN+D9f/fLc3Tol7867zolm/uohKd8xkTOsaYdvmkaeALFgYnG4TtAxHcdOX8uxKS/UE8TZNzy3sgDWrLQfvPQ9ahF611c9RV5+6JQLxrP/DM5THK5upbLbhneJlzxKDuDk2BfmyfVQ4tr1+5q+PXCaJeeuDoeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qj21sLV+; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qj21sLV+"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4926fa2cb17so16748295e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783784773; x=1784389573; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ur7NKTJlZDhSFyUo4h9vpOo4v6UgyOoJcKjM9alIk7s=;
        b=Qj21sLV+p2TtKAFUog4bwoVrpyQ7M6HXcR4fOmVSBsffaZHLqeLOx77mOdNPrqArAi
         csI/v3f1/Dc7nslG1/3206WMo2nx/dtpnajJnnaElehRSYAs43kNbrBMsgX39rKPI+wM
         fhjCap6LA5RBueM1WTi/2/VcdQW3JtlbbVBnLDDtYx0IgO080LVqHOT7GQYaFzPQ8zxU
         zLTpLr4I0f3QIBEBB6cVZb3m391kZofBypIEogvJnfgjKA/rVP97ULHa4ZcnAaQPKhgO
         FRpTuIhzX23o/V4Z2mj0ZYSdaHrEKzh6/ogb9Y09Cnkys8L5B+GfzbHwjjMXzjxPKxcG
         hldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783784773; x=1784389573;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ur7NKTJlZDhSFyUo4h9vpOo4v6UgyOoJcKjM9alIk7s=;
        b=OxqnX3rOtDV9OaHeLNdTv2iR6pqBlMr10+PZbd92zwfq+NfmhbNzlj78+BxlUepFDD
         LnmFEL8mVsgnRq5ROJn86EEX+85YhX2BhzT5slVtUW+4aeFg0KId0vULWUOu8sxVdDuw
         890DwMwFH6N2mz8zyhvAHYocXU1WtrehlUO7O06FFl4P6F1/iY803Ja0iyg6pl33/NAV
         HmMPXPvoIAUf3CVXXGCFdFokU3DykS6kk8Lr6FKfvAG7tdsR0YAv1zmaeWem4yvCIaU/
         QmR1i9lG2DnWNNrf49su0CSX7+Pa1VtTHOGqH0QpU08JTIdloRxSneNU7UCEzdoyCj09
         6uUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0iqEv+7UKFTxA10vJy1f/FF9gfMxr1Q4jLnh7TVyntEKyHnoa/Ghas7LiQ15QZE6QDd3eHEI58WWggfiH@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7wd7JEbBoqeLKCi2y2Ur+n46rCkjneTcBWZ6Q3SSYHDMCfuX
	gFeIJ3x9veagBSZxhkvZspiUXWrBlwHOU3qbsllyosMcu/XEqgc1J140WwMm16K9/lNn3nq1AHS
	D7kSTwrSvX6RqkDcsOg==
X-Received: from wmpo42.prod.google.com ([2002:a05:600c:33aa:b0:493:d884:f722])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b53:b0:493:f13c:9c03 with SMTP id 5b1f17b1804b1-493f88dc201mr26395515e9.19.1783784773040;
 Sat, 11 Jul 2026 08:46:13 -0700 (PDT)
Date: Sat, 11 Jul 2026 15:46:12 +0000
In-Reply-To: <alJHCkMIcnXYPNoJ@tardis.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707-upgrade-poll-v6-0-4b8fae7bf1d9@google.com>
 <20260707-upgrade-poll-v6-2-4b8fae7bf1d9@google.com> <alGOptAAFXuHscmG@tardis.local>
 <alIbx8oav01VLarX@google.com> <alJHCkMIcnXYPNoJ@tardis.local>
Message-ID: <alJlRDfrvdEhUxX7@google.com>
Subject: Re: [PATCH v6 2/2] rust_binder: move (e)poll wait queue to Process
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Christian Brauner <brauner@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, Jul 11, 2026 at 06:37:14AM -0700, Boqun Feng wrote:
> On Sat, Jul 11, 2026 at 10:32:39AM +0000, Alice Ryhl wrote:
> > On Fri, Jul 10, 2026 at 05:30:30PM -0700, Boqun Feng wrote:
> > > On Tue, Jul 07, 2026 at 10:43:13AM +0000, Alice Ryhl wrote:
> > > > +        {
> > > > +            let poll = loop {
> > > > +                if let Some(poll) = this.poll.as_ref() {
> > > > +                    break poll;
> > > > +                }
> > > > +
> > > > +                let poll = PollCondVarBox::new(c"Process::poll", kernel::static_lock_class!())?;
> > > > +                // Reuse our existing lock to synchronize callers initializing.
> > > > +                let _guard = this.node_refs.lock();
> > > > +                this.poll.populate(poll);
> > > > +            };
> > > 
> > > Note sure whether this lock is needed? SetOnce::populate() should be
> > > atomic, i.e. only one populate() would win?
> > > 
> > > Also seems we should have a SetOnce::as_ref_or_populate(&self, default:
> > > T).
> > 
> > I'm taking this lock because I want to ensure that losers only loop
> > once. The problem is that just because you lost the race in populate(),
> 
> Then probably you could add some comment explaining this. For example:
> 
>     // Reuse our existing lock to synchronize callers initializing to
>     // make sure in the next iteration `as_ref()` will return `Some`.

I don't mind adding the comment.

> > it's not guaranteed that as_ref() will return Some on the next
> > iteration, since the winner of the race may still be busy executing
> > populate(). Taking the loop avoids this possibility.
> > 
> > With regards to as_ref_or_populate(), I point you to this discussion for
> > reasons why this is hard:
> > https://lore.kernel.org/all/aZLZbN5C3wXgt3kL@google.com/
> > 
> 
> Seems to me you really want OnceLock behavior here, and other code may
> have the same requirement in the future. So maybe we just add OnceLock
> for it? If the space cost is the concern, we can add a 
> SetOnce::populate_with_lock(&self, lock: &Lock<..>) to provide users an
> option. I think it's better than open-code here.
> 
> Thoughts?

Well, I don't think it's a bad idea.

The current code drops the value under the spinlock if populate() loses
the race, and a populate_with_lock() could help avoid that, so that
seems like a reasonable idea. It's not a big problem in this case (it's
just a kfree_rcu() call after all), but could be a problem for other
SetOnce users.

I mean, it'd be ideal if SetOnce could just properly support this, but
like I discussed on the thread, there are a bunch of things to keep in
mind if we want to actually do that. You want preemption disabled while
you memcpy() in the value in populate(). I guess preemption doesn't
matter for as_ref(), though. Not sure how that would interact with
PREEMPT_RT.

Alice
