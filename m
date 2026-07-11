Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2DD231A3B;
	Sat, 11 Jul 2026 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783777038; cv=none; b=byS3IM4osfe5ZbiUSpwFqEo0Ne6nIQBag9FKzsV47hF/Zy++fdRFCWVbnkpt18qagR+ZayIC2XDOF+N40dj0ldlrTj2EzqzlQEPil2vZSoTO/+gMKKvTYTfLHaCWRp7OEIf5Gx0V5LKGh2L1/8m5DgorAnU4eljGXqCzrkhSWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783777038; c=relaxed/simple;
	bh=oCO25h/qzA7JWr1F0G05dCEWeqfzbAVi3ewe79pUxjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tswfM0KWu9Gnjc1SoF7tv0OUbCJeIcmkv3KciBLY4DAELDpTBgIpHbS2gtvPM/ZbNtWFyL5EE3R0WFRTAhWQ9TPYv+Sr25NrLwPabDoX/2bn6QVKCwGFPGjMYSRRKfqWCNdrVzL8Iu8VE/Ok1qXbdZc42qgFL+LLThiik2sdVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buQNiCI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buQNiCI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25DC1F00A3D;
	Sat, 11 Jul 2026 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783777037;
	bh=kQ2YPpQ+OKvGSxsbGYyc/HdCPslmjSZOQRyttjloA7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=buQNiCI8AypAeRcAop1S4vytzZRqznSNXHeJUvhibY3OxByKSy7eX8nZOO8rU4FI6
	 4L40NfBZgqbaTwTQnRvDUAEHHWjZ6Ghm1rM+D2u8AzGvOErrSUmQ7ItxRYcmBaExon
	 15y6FFIH35x1VnC2YDrKXmktVOBTU/s1MehPXSiPNFrKyPodNnFWvVoFzfe7LhhSms
	 kVh3+8qYu569zXbtD5U4Z9uh3aYZhqW7yb53SDNTpbwfEIH8Q6aGqNOaccW+tSeof9
	 N+qPkYCZuONaudPo/RYZto89q9WDOjR+sg6r56cuhUbdpob7lzLLLly3snGVW8rS31
	 P/VEHD6CB521Q==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id F25E0F40072;
	Sat, 11 Jul 2026 09:37:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sat, 11 Jul 2026 09:37:16 -0400
X-ME-Sender: <xms:C0dSakSjmJY3jj3jOU6_Q1J64Y_8v5h4OwzvYx8obOf58tS6VqjZew>
    <xme:C0dSajIzdx5MMZLJ9TNUb2oFYQasiUZdlxC9EQ_z0CgQgFuqrG-5xyo_3PvNTwyHX
    CsczMYk6Pa6PcMgO1B22Wmz-1ekhZH3KERekBA4kvx53alkCkSI>
X-ME-Received: <xmr:C0dSarF3jjownAopmEMb7m6fNztLZESBWgpaPeOS6HSPo-zQkUPHAwLTlxiexvCoGsfsZhHicfsa1vD_CGTen3BenDATyLQc>
X-ME-Proxy-Cause: dmFkZTG3277EaB1eFkbvu0Arda0XdgidpS9HPvv+ZYx54fD/qgK/J54VA/lzP9EBo5m6EK
    z/YtoFDRFaMwToALFQ5J/32YmBsI4xP/QMM1OBCfc2IgQULQ67VlzIJgL0izRdUbIaQePa
    qzoRSyebCe9N6Y2saHTWQXpPuDFMu76iPeoSfZ8fGQwHFixWx5dWLYpqpQawkozRSJryRL
    8K9+iFLNwNFtO+4QdeNXNW90C99mmP3SdRiI7BUKZKRSTiBx1zBbtM0236jJ6AmH/pwlm2
    /ckBQHzXmj1X2X21YBnlSbO7nAkPdRmivWFHCAwY8bdwp5eyQ6Q2VOsW6A9f//Mf39THZM
    Y/kD2zxkNO2mDY12ddFLT+hf6/dEFPdDsYxMCu3rxM4rxOQkP5QltC8QfCTCEltnV1WSnh
    i1wh3kvcwq708wg6O6MsADzVKvSmvGn6FGY3Gn6we/MKnHIx35wR2pHzLyzcyQGExK+pA4
    7ZLZmgzDw0g+g36NFJIfi910pqqcdwp9wIJyMx9sJQeEHaOjGEMAWPT55+vtFOTtvGKYo4
    wiGXItorRjSahV+x4pM+KI3PM4/Ib8Ucyjd4QFfTxX9FcSmWNlnsXZ/z0UNqyePo51ZZr8
    H4oWIGGzqYbF9C9STr7l4VTfWag74YkysG3QsLfThKaCILWutjLKUDefqs7A
X-ME-Proxy: <xmx:C0dSagSzVMf82prpulOnZUjXNOp0-8naazdHFhZld1jtOc0midP86A>
    <xmx:C0dSakXaO42VLrJzn0xuXuMwTM8AXv6o1ch4tttQoagpYtLhFmPx_Q>
    <xmx:C0dSavhKFQsTjpf_TnD8ZrAZPM4rHqbN75-ApyNLi1ycTI2CXUXx3A>
    <xmx:C0dSatcN-7fmlAPMQrNiwqIWAu4kbPTc8Em32-MtlA43EJ3NsQ_ApA>
    <xmx:C0dSaqdGPj0ZPq_K8nDuImUJotjPzByJOoKHW5WyW1XBXCU_66m0sNUX>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 09:37:15 -0400 (EDT)
Date: Sat, 11 Jul 2026 06:37:14 -0700
From: Boqun Feng <boqun@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Llamas <cmllamas@google.com>,
	Christian Brauner <brauner@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] rust_binder: move (e)poll wait queue to Process
Message-ID: <alJHCkMIcnXYPNoJ@tardis.local>
References: <20260707-upgrade-poll-v6-0-4b8fae7bf1d9@google.com>
 <20260707-upgrade-poll-v6-2-4b8fae7bf1d9@google.com>
 <alGOptAAFXuHscmG@tardis.local>
 <alIbx8oav01VLarX@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alIbx8oav01VLarX@google.com>

On Sat, Jul 11, 2026 at 10:32:39AM +0000, Alice Ryhl wrote:
> On Fri, Jul 10, 2026 at 05:30:30PM -0700, Boqun Feng wrote:
> > On Tue, Jul 07, 2026 at 10:43:13AM +0000, Alice Ryhl wrote:
> > > +        {
> > > +            let poll = loop {
> > > +                if let Some(poll) = this.poll.as_ref() {
> > > +                    break poll;
> > > +                }
> > > +
> > > +                let poll = PollCondVarBox::new(c"Process::poll", kernel::static_lock_class!())?;
> > > +                // Reuse our existing lock to synchronize callers initializing.
> > > +                let _guard = this.node_refs.lock();
> > > +                this.poll.populate(poll);
> > > +            };
> > 
> > Note sure whether this lock is needed? SetOnce::populate() should be
> > atomic, i.e. only one populate() would win?
> > 
> > Also seems we should have a SetOnce::as_ref_or_populate(&self, default:
> > T).
> 
> I'm taking this lock because I want to ensure that losers only loop
> once. The problem is that just because you lost the race in populate(),

Then probably you could add some comment explaining this. For example:

    // Reuse our existing lock to synchronize callers initializing to
    // make sure in the next iteration `as_ref()` will return `Some`.

> it's not guaranteed that as_ref() will return Some on the next
> iteration, since the winner of the race may still be busy executing
> populate(). Taking the loop avoids this possibility.
> 
> With regards to as_ref_or_populate(), I point you to this discussion for
> reasons why this is hard:
> https://lore.kernel.org/all/aZLZbN5C3wXgt3kL@google.com/
> 

Seems to me you really want OnceLock behavior here, and other code may
have the same requirement in the future. So maybe we just add OnceLock
for it? If the space cost is the concern, we can add a 
SetOnce::populate_with_lock(&self, lock: &Lock<..>) to provide users an
option. I think it's better than open-code here.

Thoughts?

Regards,
Boqun

> > The rest looks good to me. FWIW,
> > 
> > Reviewed-by: Boqun Feng <boqun@kernel.org>
> 
> Thanks!
> 
> Alice
