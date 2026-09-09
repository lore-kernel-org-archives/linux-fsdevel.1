Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB774A68B9
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788993481; cv=none; b=lsjP4BRXjDUT9wvLLza7KCYlmbUyY4g0e1ObppQeRPFYq+/FS/hGaoZmy1acEYRudh9J/OMUR85+xlZZRfr98/j6aeyWI3ap8IoVIq5iJJ3mAZD+AqsAmUvd5nGynuxwcTRBvGNyduFOdWvGmZgV86/w5dgMdMBu5YVLnAY82GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788993481; c=relaxed/simple;
	bh=ihXT8bMmKa02HxSzdjMO+gip/imWP77+gKPln7ZyaEA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=logOjypHGU5MFWLV7y9tQcBirtnfNCc+4O+0ry9YQMUOg0TR4S5SnN/AkuEI6vd9dilJBilqlaURbXcWIMU8tuk1knI5Gzvw2g5i3fuqyA/gbjX4EsO4CZFIuWErzYAzc1F8aBBqz6qQJXSnp8aFQye5BAQcryRZTml8z9yml7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=oKtPiaCc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RpOeuKhy; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="oKtPiaCc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RpOeuKhy"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8EB6B1D000A7;
	Wed,  9 Sep 2026 18:37:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 18:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1788993431; x=1789079831; bh=Q+Ej88I1K2eOQrzE5Zl32zj36HecKnL1lQi
	vUk7Cbhc=; b=oKtPiaCczRQ9mpRBvqXgt4Bn43mgy70WC1Tt/MBPCBNop1kgepz
	RReJoHHmInwfX1dfS3iiP8lMoWKCri9oArxMnFyRGv52qNe7n4SfGQ/dB+RkAm2J
	TG3FxBhX7prEKIGhuO1Yf5eFhVndHY76r1+EP673qnMXNsWcTcN21Qkl6sPK/UzW
	t5kTjYj4ts+Jsfi/QAwYF5kx9V6Rwf7YirLYGs6N71i0my9aRsGRbZUZDeTuDQJb
	ERlOR7D/GcrWUNfGNR8yyJLTpkWxPGSQ+cHkwSkYiFFfQV5wM1liKgpZXAitzo54
	RuUfJRiT3rD4VY7eMUeUQpAOMRQTquDbaEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788993431; x=
	1789079831; bh=Q+Ej88I1K2eOQrzE5Zl32zj36HecKnL1lQivUk7Cbhc=; b=R
	pOeuKhyL0Z3KThsXjCoY242oU0jYU0Seh2r7RiE+cMg3Id34c4dml+ueLoXI15YG
	ipCEXwJ/38slDd31RotTJxa6tRDffNN9tZftxVEHXbiiozPV14iHr0AmgObLBCkG
	Ssg1jE3Y6n4SZZomVaZJckT56Xmj+9oiTErbg6zTxgWjbSAGj9Wyp3kblfGPkqRW
	plTpH1rhw2JKy9nQ6kFnTXNIJGKgJXzigIDl/7fU9NFH/KqCBbkUJzVf3xeaF9kF
	eCI89rQGXhBRF2IzKMShlM2H4LYH7+5zIENNUOzhJQ2OvjTacTLu4qaR3Lg3JBC7
	IDBZs8gUZFmwV98a5DNNQ==
X-ME-Sender: <xms:l9-hak6m2zAQgdsG_vIYKmmPPbbCzP37ACfUtSXnjPzZqJKUHWoR-A>
    <xme:l9-har5a2vFVpH73SLtxEuaxqQQ-jiIa6ZeRFIB6mogyahFqRegCJElISqYOca-Em
    5JngJP17_PAntfrrcdpf3zQBIVMo1BhseyjHcVmMz_1krtkilQq>
X-ME-Received: <xmr:l9-hauS_ZyZsH0KESEZb-7YDllb8l_aAAIdzFnorZ2RjzQ4u8ZFxJHafP1eM2RUcoCELEdtHqs0BcyP1d5knCd2OI8_Mjnk>
X-ME-Proxy-Cause: dmFkZTGsMz35IkcO+VI+THnJaO+Y7gf4ocMb1fzXwMTdrKJuk/T0u51jHdNdqBdKg5MZlD
    pUFp93gNbtuDLUpOHWtXnS/afJOLUBOHZwd2iTzC1ZyD6qVteIBc/oakC8ixbTOl4omXUD
    x/wObS3tI8YqKiYix731KPlgWqi6fBstd5b55a9cW8QLwBDI0GBYXJbyilDDJCcrlo5JHk
    IVgCifKBqiiaigFPsxORiNxAW+p3y/DqTzHMUBh+cHHJWHqqd7Aj7AyfbyOjNhE8tFbVkt
    4BZsxYFjpOQ9wqn7Lom2pB+eKLZGWzOnAOObf/YcLFXsWBhG2dHDmPTtSIC76X1RnbrYSb
    UhKQwaUXnnWoxe0isfhnApi3zpZSHJ1VqWP9kwoj9cZnGYGOlV1m7TtA/+WwXTplaKt72J
    48Eg+qlyxmw9Az6hlwrEZ2/jsS1tsPVCNucX3PN4YQpbUQ2djzrWdCafUB6e415I+SaLEX
    wcGGX8yER95KahuYGybsOd8CJ1h5avGuHuetqI4SYPH0BfxhnWsUv/LdTEkYR8F7Py6aDp
    a7yspXr5i9BYYY4pgIQ6vKaFoNj9L7b+qwDDaenMBFMqgeI4K2BdA//fytibmL+e4ogXJg
    OE5sd1a6BX4vmJ+vpdBBfdwEscYWTH8arG39qp7Opla8Or77wX3S6zzNNIOQ
X-ME-Proxy: <xmx:l9-har-cNfFpdyN1H65ueymjN-myAePUctzfROAmUOumCRnSQHwjKw>
    <xmx:l9-hanYZNoo3K9gtOFegQ1Io3funw6M53rSlZ6RpJqOrBDazu13QXA>
    <xmx:l9-hakphKaPBXMb2l4t8tRRHQY4mezffSPu868cBeZV-Zkv5vu2hYA>
    <xmx:l9-hajQsjXnet64E4OfhS_lx9GMWljZ7EUe628n2wY8A_WcOhCC8Qw>
    <xmx:l9-hatnE-oJh6NVHuOlOcnyPTtOkh6fyJ4zdfKg5E0Z2nEIPidBw8zoM>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 18:37:07 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Oleg Nesterov" <oleg@redhat.com>, linux-fsdevel@vger.kernel.org,
 "Jann Horn" <jannh@google.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jan Kara" <jack@suse.cz>, "Xin Zhao" <jackzxcui1989@163.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>,
 "Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH RFC v3 10/15] coredump: s/startup/done/g
In-reply-to:
 <20260909-work-coredump-unlock-self-v3-10-04f907687563@kernel.org>
References: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
  <20260909-work-coredump-unlock-self-v3-10-04f907687563@kernel.org>
Date: Thu, 10 Sep 2026 08:37:03 +1000
Message-id: <178899342391.207413.9942867009865917301@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 10 Sep 2026, Christian Brauner wrote:
> We're going to use that in a bit. Rename it to something easier to
> understand.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/coredump.c                | 4 ++--
>  include/linux/sched/signal.h | 3 ++-
>  kernel/exit.c                | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 9addd2d59b7b..545a6df48ea8 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -523,7 +523,7 @@ static int coredump_wait(int exit_code, struct core_sta=
te *core_state)
>  	struct task_struct *tsk =3D current;
>  	int core_waiters =3D -EBUSY;
> =20
> -	init_completion(&core_state->startup);
> +	init_completion(&core_state->done);
>  	core_state->dumper.task =3D tsk;
>  	core_state->dumper.next =3D NULL;
> =20
> @@ -531,7 +531,7 @@ static int coredump_wait(int exit_code, struct core_sta=
te *core_state)
>  	if (core_waiters > 0) {
>  		struct core_thread *ptr;
> =20
> -		wait_for_completion_state(&core_state->startup,
> +		wait_for_completion_state(&core_state->done,
>  					  TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
>  		/*
>  		 * Wait for all the threads to become inactive, so that
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index d45a5476b97d..1c1e280a25a1 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -81,7 +81,8 @@ struct core_thread {
>  struct core_state {
>  	atomic_t nr_threads;
>  	struct core_thread dumper;
> -	struct completion startup;
> +	/* Completed by the last thread to park. */
> +	struct completion done;

It isn't clear that "done" is a whole lot better than "startup".
"What is done?" is the same question as "what did we start up?".
Given the comment (which is the best part of this patch), maybe
call the completion "all_parked".  But "parked" make my think of
kthreads which can be parked and unparked ... but maybe that is=20
just me.

It appears the wait is for all tasks to have registered themselves on the
core_state->dumper list of tasks.  Why is the list called "dumper"?
Maybe the first task on the list is the task which will perform the
dump?  Blending the two concepts doesn't aid clarity...  I was thinking
of referencing the list in the name of the completion, but that might be
confusing.

I'm leaning towards "threads_listed" as a good name.

But naming is hard...

NeilBrown



>  };
> =20
>  /*
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 4e028f157597..affee30bcbca 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -443,7 +443,7 @@ static void coredump_task_exit(struct task_struct *tsk,
>  	 * to core_state->dumper.
>  	 */
>  	if (atomic_dec_and_test(&core_state->nr_threads))
> -		complete(&core_state->startup);
> +		complete(&core_state->done);
> =20
>  	for (;;) {
>  		set_current_state(TASK_IDLE|TASK_FREEZABLE);
>=20
> --=20
> 2.53.0
>=20
>=20

