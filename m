Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2913112C0;
	Sun, 17 May 2026 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779062118; cv=none; b=CijxVqQ+9OvVb3usSIZtha+/WG0BKdBNgGHMQMQL8ecS537a9Yj4UaBagRTgk8x306a999YPzv23faku453evVdKEtqrBJ3emmoxabFbJOysvrvbNcvbdVzIPUXQC26IZZU0/U8xkzs1gTEyxuR1jyyfNbvcbnqeVMJbFDpgSVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779062118; c=relaxed/simple;
	bh=CzXUiEvLMBWsLyxtLgr9tpYEBtT+S3JnPmrwJawVRd0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=D+HVGT717G7kVcfA4IgxU38kapaNw7HlA60HYWGHE4amh6ceMmG6v6wA8H3SVBod2KI5j1TMtRjqFdO3MY/a3FDug005x7TSehftxNgs5H0wCRD83cOnV40bh2iRIF2Frn2TQiW1LpqnrYx0kkLtfQZTitkveFmKM3aRj8Ke3EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=cyNOXOyQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WV4rypcJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="cyNOXOyQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WV4rypcJ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 840441400106;
	Sun, 17 May 2026 19:55:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 17 May 2026 19:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1779062114; x=1779148514; bh=NhX75Q7H7a6IJGPuAKBEee/fROmmj9KEEje
	uJnSfFe0=; b=cyNOXOyQiox2UoT3DFmOl4+PsknDlCAtVs5vm44nH+5kWlXXCEW
	ymB0FKCX2H5oXSDDuAhgvBgMBDpxY+NDENqWwCJ6RADE4J9SQlB/+IaCktXsxbzO
	vEdqyWblhjU5E9uKbPiph2HOeAX85SrdcEOhkqRQMcy3hyh/VAzvBcMPjDSmnzsN
	vdu9HcQYWbgffFfYtKqXt+sc485Elvdwxm0pkgIfkvnWTwUVenQ/zIY5GE50xQh4
	4OCgkxxrZlm00uCJ3lpmNS26MQGwpO6zy/3Kkrvw28b0lQ6B+j3XgP4g/MlTu0Qx
	8xlJcq0CvixE3EikX9rvsE4Rtb/zou9jv2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779062114; x=
	1779148514; bh=NhX75Q7H7a6IJGPuAKBEee/fROmmj9KEEjeuJnSfFe0=; b=W
	V4rypcJziPS5eeS825daugMixS7Z2timjBaogpEh25LRI6uZQzWIwK6ZH5RA//ai
	HZ/PQBgC3sBGA3bFNG+5VxDxyx2DzYL+EjBDGwc8zVMZjqrP3O3/Bi6N8tKLYuml
	v7M/2/60oQItlE97/zwjHsCUVYIqb1UaN8qCadKLngrJuOie5V2mwlF23j2d8L60
	ZHhqmx8HouWtMsfGLbwBinzwqIvCWYGjPxtx79A1vo3tb0SVmyc7WX9X9ruwf3Vq
	DVtwiBamdHgb37n/Gqn25K8ZwNDqOWsDMfzA84lU8h0hS9Dr0KY1ww6fcMEE+B12
	hluP/M09fTRc7idbruwNA==
X-ME-Sender: <xms:YVUKagVLvAvTkta9wvGxU5iTGSnjSN4SvcDc9u9hrFIf_6Q0uhYcFA>
    <xme:YVUKamKs3NuM3hRf_itnQsK6NMd7tOQnwCeVFC8D3CmdsdDez0PbNpxINEv_6Fxbi
    TUTw5zt0sJSLNQ2XRVXhUr4UOKx6B-Fy-2KBMTBpQKn8XEtYRg>
X-ME-Received: <xmr:YVUKajoIuAyjDGq6IEA5vZWWn7mx7p8oKk3_wAGS3Op5gytPiMG0RHZdbdnVxnsoW5yzuuOs5LGQZdcJY1mM_ANe588XK9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhose
    iivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfsh
    guvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    ughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshessh
    iivghrvgguihdrhhhupdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthht
    oheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepshhkhhgrnheslhhinhhugi
    hfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:YVUKalxuNs7lIvcz7zM2-r_nhSEAPDzA4uJpDbE23dAun3_IOzIu0A>
    <xmx:YVUKavuyvAIhu2PF7hJjGTSINnmG-dDaMJ14mU41DFXveFRN4UZjSQ>
    <xmx:YVUKam019K4Sfr3ZNrlrgsUPdK26FFMMNqhLFFDfmhGwMWAtAyTiwQ>
    <xmx:YVUKavDOZil0QGcWgcd25TsuhKxOYBqSIAKw6578NmjeJXCsZlqDiQ>
    <xmx:YlUKan9suiJN1sVMbuNK3V-FN9bxUJqfoP56q-xx-4Mwabt0dRhxoeFs>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 May 2026 19:55:09 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Horst Birthelmer" <horst@birthelmer.com>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Horst Birthelmer" <hbirthelmer@ddn.com>
Subject:
 Re: [PATCH] dcache: add fs.dentry-limit sysctl with negative-first reaper
In-reply-to: <20260514-limit-dentries-cache-v1-1-431b9eb0c530@ddn.com>
References: <20260514-limit-dentries-cache-v1-1-431b9eb0c530@ddn.com>
Date: Mon, 18 May 2026 09:55:05 +1000
Message-id: <177906210551.3947082.4313294634549021141@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 15 May 2026, Horst Birthelmer wrote:
> From: Horst Birthelmer <hbirthelmer@ddn.com>
>=20
> The dcache only shrinks under memory pressure, which is rarely reached
> on machines with ample RAM, so cached negative dentries can accumulate
> without bound.  Give administrators a soft cap they can set,
> and a background worker that prefers negative dentries when reclaiming.
>=20
> Two new sysctls under /proc/sys/fs/:
>=20
>   dentry-limit             -- soft cap on nr_dentry.  0 (default)
>                               disables the feature; behaviour is then
>                               identical to before.

Is a system-wide cap really a suitable tool?  What guidance would you
give to sysadmins who are considering setting a number?

Is there a better approach?

According to the email you linked, a problem arises when a directory has
a great many negative children.  Code which walks the list of children
(such as fsnotify) while holding a lock can suffer unpredictable delays
and result in long lock-hold times.  So maybe a limit on negative
dentries for any parent is what we really want.  That would be clumsy to
implement I imagine.

But what if we move dentries to the end of the list when they become
negative, and to the start of the list when they become positive?  Then
code which walks the child list could simply abort on the first
negative.

I doubt that would be quite as easy as it sounds, but it would at least
be more focused on the observed symptom rather than some whole-system
number which only vaguely correlates with the observed symptom.

Maybe a completely different approach: change children-walking code to
drop and retake the lock (with appropriate validation) periodically.
What too would address the specific symptom.

Thanks for attempting to resolve this issue, but I'm not convinced that
you have found a good solution yet.

NeilBrown



>   dentry-limit-interval-ms -- pacing for the worker while still over
>                               the cap.  Default 1000, minimum 1.
>=20
> When the cap is exceeded, a delayed_work runs in two phases:
>=20
>   1. iterate_supers() draining only negative dentries from every LRU.
>      Positive entries are rotated past so the walk makes progress.
>      DCACHE_REFERENCED is ignored here on purpose -- an admin-imposed
>      cap should evict even hot negatives before any positive entry.
>   2. If still over the cap, iterate_supers() again with the same
>      isolate callback the memory-pressure shrinker uses.
>=20
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> ---
> There was a discussion at LSFMM about servers with too many cached
> negative dentries.
> That gave me the idea to keep the dentries in general limited
> if the system administrator needs it to.
>=20
> This is somewhat related to [1] where it would address the same
> symptoms but in a more unobtrusive way, by just garbage collecting
> the negative and then the unused cache entries.
>=20
> The other effect I have seen regarding this is that FUSE
> will not forget inodes (no FORGET call to the FUSE server)
> even after the latest reference has been closed until much later.
>=20
> In a FUSE server that mirrors the kernel cached inodes in user space
> because it has to keep a lot of private data for every node
> this puts an unnecessarry memory strain on that userspace entity
> especially if the memory is limited for its cgroup.
>=20
> [1]: https://lore.kernel.org/linux-fsdevel/20260331012925.74840-1-raven@the=
maw.net/
> ---
>  Documentation/admin-guide/sysctl/fs.rst |  28 +++++
>  fs/dcache.c                             | 197 ++++++++++++++++++++++++++++=
++++
>  2 files changed, 225 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-=
guide/sysctl/fs.rst
> index 9b7f65c3efd8..0229aea45d85 100644
> --- a/Documentation/admin-guide/sysctl/fs.rst
> +++ b/Documentation/admin-guide/sysctl/fs.rst
> @@ -38,6 +38,34 @@ requests.  ``aio-max-nr`` allows you to change the maxim=
um value
>  ``aio-max-nr`` does not result in the
>  pre-allocation or re-sizing of any kernel data structures.
> =20
> +dentry-limit
> +------------
> +
> +Soft cap on the total number of dentries allocated system-wide (i.e. on
> +``nr_dentry`` from ``dentry-state``).  A value of ``0`` (the default)
> +disables the feature and the dcache grows or shrinks only under memory
> +pressure as before.
> +
> +When set to a non-zero value, a background worker is woken whenever
> +the live dentry count exceeds the limit. The worker walks every
> +superblock's LRU and prefers to evict negative dentries first; if it
> +cannot get back under the limit using negative entries alone it falls
> +back to the same LRU policy used by the memory-pressure shrinker.
> +
> +The limit is *soft*: allocations never fail because of it, and brief
> +overshoots while the worker catches up are expected. Set the cap a
> +comfortable margin above your steady-state working set.
> +
> +dentry-limit-interval-ms
> +------------------------
> +
> +How often, in milliseconds, the ``dentry-limit`` worker re-runs while
> +``nr_dentry`` is still above the cap. Defaults to ``1000`` (one
> +second); the minimum accepted value is ``1``. Smaller values trim the
> +cache more aggressively at the cost of more CPU spent walking LRUs;
> +larger values let temporary spikes ride out before any work is done.
> +Has no effect when ``dentry-limit`` is ``0``.
> +
>  dentry-negative
>  ----------------------------
> =20
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 2c61aeea41f4..4959d2c011c0 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -144,6 +144,19 @@ static DEFINE_PER_CPU(long, nr_dentry_unused);
>  static DEFINE_PER_CPU(long, nr_dentry_negative);
>  static int dentry_negative_policy;
> =20
> +/*
> + * Soft cap on the total number of dentries. When non-zero and exceeded,
> + * a background worker prunes unused dentries (preferring negative ones)
> + * until we are back under the limit. Zero (the default) disables the
> + * feature entirely; the fast path in __d_alloc() only pays the cost of
> + * a READ_ONCE and a branch in that case.
> + */
> +static unsigned long sysctl_dentry_limit __read_mostly;
> +static unsigned int sysctl_dentry_limit_interval_ms __read_mostly =3D 1000;
> +static unsigned long dentry_limit_last_kick;
> +
> +static void dentry_limit_kick(void);
> +
>  #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
>  /* Statistics gathering. */
>  static struct dentry_stat_t dentry_stat =3D {
> @@ -199,6 +212,20 @@ static int proc_nr_dentry(const struct ctl_table *tabl=
e, int write, void *buffer
>  	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
>  }
> =20
> +/*
> + * Writing fs.dentry-limit should give prompt feedback to admins
> + * lowering the cap, so kick the worker on every successful write.
> + */
> +static int proc_dentry_limit(const struct ctl_table *table, int write,
> +			     void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int ret =3D proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
> +
> +	if (write && !ret)
> +		dentry_limit_kick();
> +	return ret;
> +}
> +
>  static const struct ctl_table fs_dcache_sysctls[] =3D {
>  	{
>  		.procname	=3D "dentry-state",
> @@ -207,6 +234,21 @@ static const struct ctl_table fs_dcache_sysctls[] =3D {
>  		.mode		=3D 0444,
>  		.proc_handler	=3D proc_nr_dentry,
>  	},
> +	{
> +		.procname	=3D "dentry-limit",
> +		.data		=3D &sysctl_dentry_limit,
> +		.maxlen		=3D sizeof(sysctl_dentry_limit),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dentry_limit,
> +	},
> +	{
> +		.procname	=3D "dentry-limit-interval-ms",
> +		.data		=3D &sysctl_dentry_limit_interval_ms,
> +		.maxlen		=3D sizeof(sysctl_dentry_limit_interval_ms),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_douintvec_minmax,
> +		.extra1		=3D SYSCTL_ONE,
> +	},
>  	{
>  		.procname	=3D "dentry-negative",
>  		.data		=3D &dentry_negative_policy,
> @@ -1325,6 +1367,160 @@ static enum lru_status dentry_lru_isolate_shrink(st=
ruct list_head *item,
>  	return LRU_REMOVED;
>  }
> =20
> +#define DENTRY_LIMIT_BATCH	1024UL
> +
> +static void dentry_limit_worker_fn(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(dentry_limit_work, dentry_limit_worker_fn);
> +
> +/*
> + * Variant of dentry_lru_isolate() that only frees negative dentries.
> + * DCACHE_REFERENCED is intentionally not honoured here: the whole point
> + * of an admin-imposed cap on negatives is that even frequently-looked-up
> + * negative entries should be evicted before any positive dentry.
> + * Positive entries are rotated to the tail so the walk continues to
> + * make progress without disturbing their LRU position.
> + */
> +static enum lru_status dentry_lru_isolate_negative(struct list_head *item,
> +		struct list_lru_one *lru, void *arg)
> +{
> +	struct list_head *freeable =3D arg;
> +	struct dentry *dentry =3D container_of(item, struct dentry, d_lru);
> +
> +	if (!spin_trylock(&dentry->d_lock))
> +		return LRU_SKIP;
> +
> +	/* Same handling as dentry_lru_isolate() for in-use entries. */
> +	if (dentry->d_lockref.count) {
> +		d_lru_isolate(lru, dentry);
> +		spin_unlock(&dentry->d_lock);
> +		return LRU_REMOVED;
> +	}
> +
> +	if (!d_is_negative(dentry)) {
> +		spin_unlock(&dentry->d_lock);
> +		return LRU_ROTATE;
> +	}
> +
> +	d_lru_shrink_move(lru, dentry, freeable);
> +	spin_unlock(&dentry->d_lock);
> +	return LRU_REMOVED;
> +}
> +
> +struct dentry_limit_ctx {
> +	long over;		/* remaining dentries to evict */
> +	list_lru_walk_cb isolate;
> +};
> +
> +static void dentry_limit_prune_sb(struct super_block *sb, void *arg)
> +{
> +	struct dentry_limit_ctx *ctx =3D arg;
> +	unsigned long walked =3D 0;
> +	unsigned long budget;
> +
> +	if (ctx->over <=3D 0)
> +		return;
> +
> +	/*
> +	 * Walk up to one full pass of this superblock's LRU, in
> +	 * DENTRY_LIMIT_BATCH-sized chunks. The loop matters mainly for
> +	 * phase 1: dentry_lru_isolate_negative() returns LRU_ROTATE for
> +	 * positive dentries, which still counts against list_lru_walk()'s
> +	 * nr_to_walk. A single batch can therefore finish having freed
> +	 * nothing when positives crowd the head of the LRU, and without
> +	 * the inner loop the worker would have to wait a full
> +	 * dentry-limit-interval-ms before retrying never reaching the
> +	 * negatives buried behind a long run of positives.
> +	 *
> +	 * The budget is snapshot at entry so a filesystem allocating
> +	 * dentries faster than we drain them can't keep us spinning here
> +	 * forever; freshly added dentries are picked up on the next
> +	 * worker invocation.
> +	 *
> +	 * Phase 2 normally exits much sooner: its isolate callback frees
> +	 * any non-referenced dentry, so ctx->over typically hits zero
> +	 * inside the first batch. The worst-case over-eviction is one
> +	 * batch past the cap, which is within the soft semantics of
> +	 * fs.dentry-limit.
> +	 */
> +	budget =3D list_lru_count(&sb->s_dentry_lru);
> +
> +	while (ctx->over > 0 && walked < budget) {
> +		LIST_HEAD(dispose);
> +		unsigned long nr;
> +		long freed;
> +
> +		nr =3D min(DENTRY_LIMIT_BATCH, budget - walked);
> +		freed =3D list_lru_walk(&sb->s_dentry_lru, ctx->isolate,
> +				      &dispose, nr);
> +		shrink_dentry_list(&dispose);
> +
> +		ctx->over -=3D freed;
> +		walked +=3D nr;
> +
> +		cond_resched();
> +	}
> +}
> +
> +static void dentry_limit_worker_fn(struct work_struct *work)
> +{
> +	struct dentry_limit_ctx ctx;
> +	unsigned long limit =3D READ_ONCE(sysctl_dentry_limit);
> +	unsigned int ms;
> +	long nr;
> +
> +	if (!limit)
> +		return;
> +
> +	nr =3D get_nr_dentry();
> +	if (nr <=3D (long)limit)
> +		return;
> +
> +	ctx.over =3D nr - (long)limit;
> +
> +	/* Phase 1: drain negative dentries across every superblock. */
> +	ctx.isolate =3D dentry_lru_isolate_negative;
> +	iterate_supers(dentry_limit_prune_sb, &ctx);
> +
> +	/* Phase 2: still over? Apply the ordinary LRU policy. */
> +	if (ctx.over > 0) {
> +		ctx.isolate =3D dentry_lru_isolate;
> +		iterate_supers(dentry_limit_prune_sb, &ctx);
> +	}
> +
> +	/*
> +	 * Re-arm while still above the limit. Re-read the sysctls in
> +	 * case the admin raised the cap or disabled the feature during
> +	 * the walk.
> +	 */
> +	limit =3D READ_ONCE(sysctl_dentry_limit);
> +	if (!limit || get_nr_dentry() <=3D (long)limit)
> +		return;
> +
> +	ms =3D READ_ONCE(sysctl_dentry_limit_interval_ms);
> +	queue_delayed_work(system_unbound_wq, &dentry_limit_work,
> +			   msecs_to_jiffies(ms));
> +}
> +
> +static void dentry_limit_kick(void)
> +{
> +	unsigned long limit =3D READ_ONCE(sysctl_dentry_limit);
> +	unsigned long now;
> +
> +	if (!limit)
> +		return;
> +	if (delayed_work_pending(&dentry_limit_work))
> +		return;
> +
> +	now =3D jiffies;
> +	if (time_before(now, READ_ONCE(dentry_limit_last_kick) + HZ / 10))
> +		return;
> +	WRITE_ONCE(dentry_limit_last_kick, now);
> +
> +	if (get_nr_dentry() <=3D (long)limit)
> +		return;
> +
> +	queue_delayed_work(system_unbound_wq, &dentry_limit_work, 0);
> +}
> =20
>  /**
>   * shrink_dcache_sb - shrink dcache for a superblock
> @@ -1868,6 +2064,7 @@ static struct dentry *__d_alloc(struct super_block *s=
b, const struct qstr *name)
>  	}
> =20
>  	this_cpu_inc(nr_dentry);
> +	dentry_limit_kick();
> =20
>  	return dentry;
>  }
>=20
> ---
> base-commit: 5d6919055dec134de3c40167a490f33c74c12581
> change-id: 20260513-limit-dentries-cache-63685729672b
>=20
> Best regards,
> --=20
> Horst Birthelmer <hbirthelmer@ddn.com>
>=20
>=20
>=20

