Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AEB126BF7
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783729835; cv=none; b=S1pkTClqDHh5YtgXTNyteSWwNPcALLEgOSbYuC6fOXDfQ5/hsMV8v2dJycMpUdGd5TAncY0bA/C7AH3Lj67aG2DyWiKWy5ceQ5XjrXIvpzidYrjx7W+Ar1iWm5Wbjq8bl+qcRUpV+zWG7GWx3iChac4CjKvKzMPXZfl+r7GZOH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783729835; c=relaxed/simple;
	bh=KEDmZM4IrNHXGCDiHDk3vV0ZDaHCLuzCwXUitBjEriI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5V2llMbb1JMFRYOq7TKTLwgNBa19U3anMFx4aPibI10wsEgjylGODRqt3zZo/D3ZoIfEkWXVjRPAlTDGT6Vh0Q/JcqhAkBfFg5kI3J3bfTbK7ap+Qu9dEdDBLN8Z2M9TcjUi6fOhGtTBOCAn2dFWGxa8W/XeqJ+XdI+okW4w/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxmgVCvy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxmgVCvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF581F00A3D;
	Sat, 11 Jul 2026 00:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783729834;
	bh=6LR54JkI1wcdPn4TYH3MPkmAVyt83QkA9jWX8tzyKsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UxmgVCvyLy6wkoRskmyF+t0F3RCURmBOx44P9ekTXyJmSZ4IsKkR2xXwWsNk6qmts
	 lZAqU0G4E60wp3Bu0ZacwcHC9KHOuMQbn6NH13YYAQezsjLFjHqTJt3EjY0020oE/r
	 WnUGAl5z4SSsrgBGa86B0akxQ6GBn3V5qxPC2FyjE3B4KaerNrZeXPoQ/D7LMLoQQ+
	 6pB3pKRgQhTfIsMWRBYG2jU9cfb9RT0HXRgNYIXzurTEFfuxbANp1s6uNF7o8XRSqN
	 i7nMxp0p9646Q1cyRYucGLDmH0fBRsSngbLcJsZ1UHJZDsbwswQ9PMEXOdg2Euk30o
	 f46iVs0usXMgA==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id DD13EF40209;
	Fri, 10 Jul 2026 20:30:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 10 Jul 2026 20:30:32 -0400
X-ME-Sender: <xms:qI5Rau7iosLVGLVhV3WyIOqYVr04lFJ7jPTCZFJWkbml6GSyJjUlVA>
    <xme:qI5RapQKvzASprxGzysENlXGh4RzOQV0OAW-OeDVGIiC5KhP_dLEb6VdFjrV9QefJ
    Nd2tfSg7A1wSUNjRv-iSD4iOqj1UD3YaQ7vx32HsGGhzPBqi0cbug>
X-ME-Received: <xmr:qI5Rams4_xgY6zFyOekAs3h3EWyLApGIN1FVId7Ahor0gyn_JizLGVwVduaPDW3jz911lV7XiK4obdCJFRsqevgy9n4kr6K8>
X-ME-Proxy-Cause: dmFkZTE1wogYAXUlAItxu9XMcKS5y1+B3bLvfb7lwvCZriS0O2piokV6KE2UfbD09eXK4H
    WD93Qu0eiDEhbbtJo4a7XCd7u6mAs/gHF0ycvnZyWm7Xf4xH/GmRCUIXLpWro28TO9eFYD
    j6LcIYas+j7oqEHy2P7gLcqSbnzQDKc2iRdwdexdMxA0eHS8zpsaqzz/O/dUvDjjDQk96T
    vhQiPepuWvNqP4w5gF37I7caJY0IsvNMHiHTgy0cFzX3gKbOjy5JFIiUtLeHI9B70JH8SL
    gI+jbU5uABUU5w/EQcxPp2tFlqvLWzQAXmMivjdCBZFZpXN/BnDTancADnhuYazUDLzoY2
    TuHxa6xHuM/TNLuTc+3L5ApE51BNUJMIfAb20jWL/jh3pvuQR64po9PGIDYHh5bt5EBPEc
    8XMOzpw+vlqXQbdack+fZfllhYzLeP/ReaUcnEc1CxbvIHZKEXg82m7uYsJ63V/T+SuTCi
    QzI8HRjg0q6xHuouywCUbtuprAox0lXewrOPYUIfDCt3slL71hcAVSiZBjXVYs0dqHhG4u
    cBrmI3oISldMNHZkb1W9sbxH7KenKHkLZ5u7LlXqraAimDMle8o+fkoBiIrstFfeeZHtCT
    udjriDWIsj47+TxzbeYVTqZMJPkH+A2e/27cNpCGIuPxUtbY98PNvRkd8riw
X-ME-Proxy: <xmx:qI5Rajbe9cHs1Nifb6srCDucDUs-jhPUroL1X5LuBvDYS1gr2dczGQ>
    <xmx:qI5Rao8qwj6vQfSZ5kcT6SUqQ3mApGwz1EOmTq7duKiDg3N2nHlBWA>
    <xmx:qI5Ranr2n30-63lqToNyIInh6WosSVatf7JjN9s5mY3JbZ1_r973kQ>
    <xmx:qI5RajHg9Oow3ihW_SahVpldIQdYGT999iQmhzFvIwgqdkfnRzU_kA>
    <xmx:qI5RavmykVuZBaCuOznGqRh7DVOeDlBGjQzcSnQ2nFQEiGqzglfu5WH->
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 20:30:32 -0400 (EDT)
Date: Fri, 10 Jul 2026 17:30:30 -0700
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
Message-ID: <alGOptAAFXuHscmG@tardis.local>
References: <20260707-upgrade-poll-v6-0-4b8fae7bf1d9@google.com>
 <20260707-upgrade-poll-v6-2-4b8fae7bf1d9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-upgrade-poll-v6-2-4b8fae7bf1d9@google.com>

On Tue, Jul 07, 2026 at 10:43:13AM +0000, Alice Ryhl wrote:
> Most processes do not use Rust Binder with epoll, so avoid paying the
> synchronize_rcu() cost in drop for those that don't need it. For those
> that do, we also manage to replace synchronize_rcu() with kfree_rcu(),
> though we introduce an extra allocation.
> 
> In case the last ref to an Arc<Thread> is dropped outside of
> deferred_release(), this also ensures that synchronize_rcu() is not
> called in destructor of Arc<Thread> in other places. Theoretically that
> could lead to jank by making other syscalls slow, which would be
> problematic.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
[...]
> diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
> index 0555c4bd503e..f855d8d9818c 100644
> --- a/drivers/android/binder/process.rs
> +++ b/drivers/android/binder/process.rs
[...]
>              }
>          }
>      }
> +
> +    pub(crate) fn notify_poll(&self, sync: bool) {
> +        if let Some(poll) = self.poll.as_ref() {
> +            if sync {
> +                poll.notify_sync();
> +            }
> +            poll.notify_all();
> +        }
> +    }
>  }
>  
>  fn get_frozen_status(data: UserSlice) -> Result {
> @@ -1726,7 +1743,21 @@ pub(crate) fn poll(
>          table: PollTable<'_>,
>      ) -> Result<u32> {
>          let thread = this.get_current_thread()?;
> -        let (from_proc, mut mask) = thread.poll(file, table);
> +        {
> +            let poll = loop {
> +                if let Some(poll) = this.poll.as_ref() {
> +                    break poll;
> +                }
> +
> +                let poll = PollCondVarBox::new(c"Process::poll", kernel::static_lock_class!())?;
> +                // Reuse our existing lock to synchronize callers initializing.
> +                let _guard = this.node_refs.lock();

Note sure whether this lock is needed? SetOnce::populate() should be
atomic, i.e. only one populate() would win?

Also seems we should have a SetOnce::as_ref_or_populate(&self, default:
T).

The rest looks good to me. FWIW,

Reviewed-by: Boqun Feng <boqun@kernel.org>

Regards,
Boqun

> +                this.poll.populate(poll);
> +            };
> +
> +            table.register_wait(file, poll);
> +        }
> +        let (from_proc, mut mask) = thread.poll()?;
>          if mask == 0 && from_proc && !this.inner.lock().work.is_empty() {
>              mask |= bindings::POLLIN;
>          }
[..]

