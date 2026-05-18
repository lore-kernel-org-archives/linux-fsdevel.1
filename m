Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2B37A48B;
	Mon, 18 May 2026 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779072957; cv=none; b=NRT0LUyk3W8fjGHX284HFUKW7Hm61+mTrnmP9gQpIKKxbmhaWkG/tjA6I1E4db+4duFzIocELs5ZzswZr6IBh1GF6l91uUv81fwZyZGOwFi+8wFVwhkmuiTH1aP/hmAJx+fXZPD96Epolh4PNe1yH+TB8FSezEfLi9ZtQQ8dqnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779072957; c=relaxed/simple;
	bh=ils/0XArzsr+6li/vFSk/uyj2QJ+mfof7lPCAUJlgag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Usp9XULki2CYyPvpRXv1Nl0+ztWJnJBAs+NlQXrbVqztFhcHRo4i7fDdTkU3QCDjBYWHR4q2V9nAT9wjO+8wIfOe76NKFojcdeXC22Ew2XnoFHO4YGNTdeLqfsPReJsnrDJlv0ALw6E49evCq5PhCFJ4uFsAV5LO5JkKizQmlA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=YmkeXz33; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J7KqqDrB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="YmkeXz33";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J7KqqDrB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E620C1D00093;
	Sun, 17 May 2026 22:55:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 17 May 2026 22:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779072952;
	 x=1779159352; bh=Ued1SoIi3eANLqXQqgvye/DHM12pgMnF5GHPF4sjYlI=; b=
	YmkeXz3390to4GWwPFw4aGykZ0kaO3Jv0nuqsveAQxxs8giIUYk5sTo2Kx+KGHzj
	YsF7c+nuJ5o5FqsSp/3x6VcPZtOu3NGxfginsz9dM2KoyQXcqHSPByYKHkR+Ff0o
	CIFpixSmTAMt6qx/3VKllMagWML70DNNMHEqoOAakdFR5oI2WQWTf1qDm/0jdcO7
	ghR3JpeMbXQrKxrfeR0knPJSD8XkyIK5w/NBZWUVt93JiA9jylNNP+7nGmDBNyHL
	rlwv98zrJ46ui1Vk8dCG/2Z1kq7WMWuNlcdB/D+rPSqbtSut4QcXWKH9LuDaTGIh
	xqGYso0Jpw7IaXMXqDgONw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779072952; x=
	1779159352; bh=Ued1SoIi3eANLqXQqgvye/DHM12pgMnF5GHPF4sjYlI=; b=J
	7KqqDrB29s+fa66JPBMrIzvaLN26jyuz63h4Umh+x+KUJn7iRnC6PjQfj0XeGKVS
	7xkP3H8Lx5Bt0RYhQMZHqw9JRMAl1A/lKRBVMAWLlYrksC0mtYz6EidmPB/5Z2EO
	5rZFsyQdTC5gnQykoCUVZRQcjmsy44wVlTgC08W6UqwcPCqp0z/DLYF96zuhp9Yu
	SAYbqeMb6Eeg8xC1ivvW4Tn6E1b1bo7Mvk4XNYkPkPk/bsK9+1cYJWy61rlRKLqe
	lfmUjamQZBfnivvRoAKbiG2MwQIeDfZ0QST8NngLnTQg3cWg5AyfRwEgCBh/CZ7g
	AECKIsz0c3f17B7Jp3UfQ==
X-ME-Sender: <xms:t38Kag8eoeEUUzXarnzgCp9dRubl2yzxNZmX0QM08pyEDuYo0l46bA>
    <xme:t38Kat6N77r-zwUALh2O8RBm6yf52rz6kz06QkTBBOJ61wH1P9d_aqaEuEFPu27AL
    IorAbMWSoFcKN-aPe7v1zRdftkJfPm7yN3sqbYa_yibO2RP>
X-ME-Received: <xmr:t38KapZjhz094dBWvElpSLyb50JR9MaCdXYUxibBTQS4NlJGJE60EnMizvmJv0s2gZoegTfgsgzkZlJPqEl3rsuxPHU8JZ1IlnZ19Shr1O39uVbT0W5LWRc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepie
    fhheekgfeigfeggfefiedvtddvheduvefgteekfeeiueelvdejleefieeufeetnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthdpnhgspghrtghp
    thhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghilhessghroh
    ifnhdrnhgrmhgvpdhrtghpthhtohephhhorhhsthessghirhhthhgvlhhmvghrrdgtohhm
    pdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    hikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopegtohhrsggvtheslhifnhdr
    nhgvthdprhgtphhtthhopehskhhhrghnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgt
    phhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkh
    esshhushgvrdgtii
X-ME-Proxy: <xmx:t38Kav9phFbUJw2YzJ2ydGQjr43NjWo7iX_GVmWifO6K7rnl8R7rfQ>
    <xmx:t38KagTPK4nw3JjMKU3ZRMyZjk5M85d7iYFlf984q6qYBBjaWFxFbQ>
    <xmx:t38KaqI8NVTTw6H_BwUNwuFPcf3AxaIPRBVr98Tkjo7FkU2_sFqTFw>
    <xmx:t38KaiTuN1P71Pt8kmBw1WZe7wxcwA7mj_gTHDxPlR8LONXydelo6g>
    <xmx:uH8KambDNnZdkOA0XmE-BtvjbXv1jG11rkdhMCS_Xa0s9qmBl80XQxne>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 May 2026 22:55:46 -0400 (EDT)
Message-ID: <bc359831-e653-4269-9d57-742b48d56d9f@themaw.net>
Date: Mon, 18 May 2026 10:55:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dcache: add fs.dentry-limit sysctl with negative-first
 reaper
To: NeilBrown <neil@brown.name>, Horst Birthelmer <horst@birthelmer.com>,
 Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
References: <20260514-limit-dentries-cache-v1-1-431b9eb0c530@ddn.com>
 <177906210551.3947082.4313294634549021141@noble.neil.brown.name>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <177906210551.3947082.4313294634549021141@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Neil, ;)

I just happen to have been caught by this problem too!

See below.

On 18/5/26 07:55, NeilBrown wrote:
> On Fri, 15 May 2026, Horst Birthelmer wrote:
>> From: Horst Birthelmer <hbirthelmer@ddn.com>
>>
>> The dcache only shrinks under memory pressure, which is rarely reached
>> on machines with ample RAM, so cached negative dentries can accumulate
>> without bound.  Give administrators a soft cap they can set,
>> and a background worker that prefers negative dentries when reclaiming.
>>
>> Two new sysctls under /proc/sys/fs/:
>>
>>    dentry-limit             -- soft cap on nr_dentry.  0 (default)
>>                                disables the feature; behaviour is then
>>                                identical to before.
> Is a system-wide cap really a suitable tool?  What guidance would you
> give to sysadmins who are considering setting a number?
>
> Is there a better approach?

That's a good question.


In my RFC (with a different, almost trivial, approach) to get a feel for

what people thought of the idea of limiting dentry going to the LRU a

number of similar comments came up. The commit e6957c99dca5 (("vfs: Delete

the associated dentry when deleting a file") is something like what we

want but also doesn't use a limit and so lacks a calculation to work

that out. It's probably a little bit "too" aggressive.


Worse still my claim in the RFC that many entries in the dcache can lead

to a performance problem with long hash chains didn't hold true when I

looked closer at it. For example (and TBH I've forgotten the actual numbers

now but these should be close-ish), with the dcache at 12 Million entries

with around 8 million negative, AFAICT, leads to an average hash chain

length of around 12 which is a little too long but not terrible by any

means. In my experience an average chain length of 8 or less performs

really well so this can't realistically be used and by this time the

problem is already evident.


Leaving me at a loss for a reasonable way to calculate this.

>
> According to the email you linked, a problem arises when a directory has
> a great many negative children.  Code which walks the list of children
> (such as fsnotify) while holding a lock can suffer unpredictable delays
> and result in long lock-hold times.  So maybe a limit on negative
> dentries for any parent is what we really want.  That would be clumsy to
> implement I imagine.

But the notion of dropping the dentry in ->d_delete() on last dput() is

simple enough but did see regressions (the only other place in the VFS 
besides

dentry_kill() that the inode is unlinked from the dentry on dput()). I 
wonder

if the regression wwas related to the test itself deliberately recreating

deleted files and if that really is normal behaviour. By itself that should

prevent almost all negative dentries being retained. Although file systems

could do this as well (think XFS inode recycling) it should be reasonable to

require it be left to the VFS.


But even that's not enough given that, in my case, there would still be 
around

4 million dentries in the LRU cache and in fsnotify there are directory 
child

traversals holding the parent i_lock "spinlock" that are going to cause 
problems.

That's all that much more puzzling when I see things like commit 
172e422ffea2

("fsnotify: clear PARENT_WATCHED flags lazily") which looks like it implies

the child flag depends entirely on the parent state (what am I missing 
Amir?)

so why is this traversal even retained in fsnotify?


>
> But what if we move dentries to the end of the list when they become
> negative, and to the start of the list when they become positive?  Then
> code which walks the child list could simply abort on the first
> negative.
>
> I doubt that would be quite as easy as it sounds, but it would at least
> be more focused on the observed symptom rather than some whole-system
> number which only vaguely correlates with the observed symptom.
>
> Maybe a completely different approach: change children-walking code to
> drop and retake the lock (with appropriate validation) periodically.
> What too would address the specific symptom.

Another good question.


I have assumed that dropping and re-taking the lock cannot be done but

this is a question I would like answered as well. Dropping and re-taking

lock would require, as Miklos pointed out to me off-list, recording the

list position with say a cursor, introducing unwanted complexity when it

would be better to accept the cost of a single extra access to the parent

flags (which I assume is one reason to set the flag in the child).


>
> Thanks for attempting to resolve this issue, but I'm not convinced that
> you have found a good solution yet.

This same sort of issue comes up again and again and I have thought about

it many times without actually useful ideas and it seems like I'm not

alone, ;)


Ian

>
> NeilBrown
>
>
>
>>    dentry-limit-interval-ms -- pacing for the worker while still over
>>                                the cap.  Default 1000, minimum 1.
>>
>> When the cap is exceeded, a delayed_work runs in two phases:
>>
>>    1. iterate_supers() draining only negative dentries from every LRU.
>>       Positive entries are rotated past so the walk makes progress.
>>       DCACHE_REFERENCED is ignored here on purpose -- an admin-imposed
>>       cap should evict even hot negatives before any positive entry.
>>    2. If still over the cap, iterate_supers() again with the same
>>       isolate callback the memory-pressure shrinker uses.
>>
>> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
>> ---
>> There was a discussion at LSFMM about servers with too many cached
>> negative dentries.
>> That gave me the idea to keep the dentries in general limited
>> if the system administrator needs it to.
>>
>> This is somewhat related to [1] where it would address the same
>> symptoms but in a more unobtrusive way, by just garbage collecting
>> the negative and then the unused cache entries.
>>
>> The other effect I have seen regarding this is that FUSE
>> will not forget inodes (no FORGET call to the FUSE server)
>> even after the latest reference has been closed until much later.
>>
>> In a FUSE server that mirrors the kernel cached inodes in user space
>> because it has to keep a lot of private data for every node
>> this puts an unnecessarry memory strain on that userspace entity
>> especially if the memory is limited for its cgroup.
>>
>> [1]: https://lore.kernel.org/linux-fsdevel/20260331012925.74840-1-raven@themaw.net/
>> ---
>>   Documentation/admin-guide/sysctl/fs.rst |  28 +++++
>>   fs/dcache.c                             | 197 ++++++++++++++++++++++++++++++++
>>   2 files changed, 225 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
>> index 9b7f65c3efd8..0229aea45d85 100644
>> --- a/Documentation/admin-guide/sysctl/fs.rst
>> +++ b/Documentation/admin-guide/sysctl/fs.rst
>> @@ -38,6 +38,34 @@ requests.  ``aio-max-nr`` allows you to change the maximum value
>>   ``aio-max-nr`` does not result in the
>>   pre-allocation or re-sizing of any kernel data structures.
>>   
>> +dentry-limit
>> +------------
>> +
>> +Soft cap on the total number of dentries allocated system-wide (i.e. on
>> +``nr_dentry`` from ``dentry-state``).  A value of ``0`` (the default)
>> +disables the feature and the dcache grows or shrinks only under memory
>> +pressure as before.
>> +
>> +When set to a non-zero value, a background worker is woken whenever
>> +the live dentry count exceeds the limit. The worker walks every
>> +superblock's LRU and prefers to evict negative dentries first; if it
>> +cannot get back under the limit using negative entries alone it falls
>> +back to the same LRU policy used by the memory-pressure shrinker.
>> +
>> +The limit is *soft*: allocations never fail because of it, and brief
>> +overshoots while the worker catches up are expected. Set the cap a
>> +comfortable margin above your steady-state working set.
>> +
>> +dentry-limit-interval-ms
>> +------------------------
>> +
>> +How often, in milliseconds, the ``dentry-limit`` worker re-runs while
>> +``nr_dentry`` is still above the cap. Defaults to ``1000`` (one
>> +second); the minimum accepted value is ``1``. Smaller values trim the
>> +cache more aggressively at the cost of more CPU spent walking LRUs;
>> +larger values let temporary spikes ride out before any work is done.
>> +Has no effect when ``dentry-limit`` is ``0``.
>> +
>>   dentry-negative
>>   ----------------------------
>>   
>> diff --git a/fs/dcache.c b/fs/dcache.c
>> index 2c61aeea41f4..4959d2c011c0 100644
>> --- a/fs/dcache.c
>> +++ b/fs/dcache.c
>> @@ -144,6 +144,19 @@ static DEFINE_PER_CPU(long, nr_dentry_unused);
>>   static DEFINE_PER_CPU(long, nr_dentry_negative);
>>   static int dentry_negative_policy;
>>   
>> +/*
>> + * Soft cap on the total number of dentries. When non-zero and exceeded,
>> + * a background worker prunes unused dentries (preferring negative ones)
>> + * until we are back under the limit. Zero (the default) disables the
>> + * feature entirely; the fast path in __d_alloc() only pays the cost of
>> + * a READ_ONCE and a branch in that case.
>> + */
>> +static unsigned long sysctl_dentry_limit __read_mostly;
>> +static unsigned int sysctl_dentry_limit_interval_ms __read_mostly = 1000;
>> +static unsigned long dentry_limit_last_kick;
>> +
>> +static void dentry_limit_kick(void);
>> +
>>   #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
>>   /* Statistics gathering. */
>>   static struct dentry_stat_t dentry_stat = {
>> @@ -199,6 +212,20 @@ static int proc_nr_dentry(const struct ctl_table *table, int write, void *buffer
>>   	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
>>   }
>>   
>> +/*
>> + * Writing fs.dentry-limit should give prompt feedback to admins
>> + * lowering the cap, so kick the worker on every successful write.
>> + */
>> +static int proc_dentry_limit(const struct ctl_table *table, int write,
>> +			     void *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	int ret = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
>> +
>> +	if (write && !ret)
>> +		dentry_limit_kick();
>> +	return ret;
>> +}
>> +
>>   static const struct ctl_table fs_dcache_sysctls[] = {
>>   	{
>>   		.procname	= "dentry-state",
>> @@ -207,6 +234,21 @@ static const struct ctl_table fs_dcache_sysctls[] = {
>>   		.mode		= 0444,
>>   		.proc_handler	= proc_nr_dentry,
>>   	},
>> +	{
>> +		.procname	= "dentry-limit",
>> +		.data		= &sysctl_dentry_limit,
>> +		.maxlen		= sizeof(sysctl_dentry_limit),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dentry_limit,
>> +	},
>> +	{
>> +		.procname	= "dentry-limit-interval-ms",
>> +		.data		= &sysctl_dentry_limit_interval_ms,
>> +		.maxlen		= sizeof(sysctl_dentry_limit_interval_ms),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_douintvec_minmax,
>> +		.extra1		= SYSCTL_ONE,
>> +	},
>>   	{
>>   		.procname	= "dentry-negative",
>>   		.data		= &dentry_negative_policy,
>> @@ -1325,6 +1367,160 @@ static enum lru_status dentry_lru_isolate_shrink(struct list_head *item,
>>   	return LRU_REMOVED;
>>   }
>>   
>> +#define DENTRY_LIMIT_BATCH	1024UL
>> +
>> +static void dentry_limit_worker_fn(struct work_struct *work);
>> +static DECLARE_DELAYED_WORK(dentry_limit_work, dentry_limit_worker_fn);
>> +
>> +/*
>> + * Variant of dentry_lru_isolate() that only frees negative dentries.
>> + * DCACHE_REFERENCED is intentionally not honoured here: the whole point
>> + * of an admin-imposed cap on negatives is that even frequently-looked-up
>> + * negative entries should be evicted before any positive dentry.
>> + * Positive entries are rotated to the tail so the walk continues to
>> + * make progress without disturbing their LRU position.
>> + */
>> +static enum lru_status dentry_lru_isolate_negative(struct list_head *item,
>> +		struct list_lru_one *lru, void *arg)
>> +{
>> +	struct list_head *freeable = arg;
>> +	struct dentry *dentry = container_of(item, struct dentry, d_lru);
>> +
>> +	if (!spin_trylock(&dentry->d_lock))
>> +		return LRU_SKIP;
>> +
>> +	/* Same handling as dentry_lru_isolate() for in-use entries. */
>> +	if (dentry->d_lockref.count) {
>> +		d_lru_isolate(lru, dentry);
>> +		spin_unlock(&dentry->d_lock);
>> +		return LRU_REMOVED;
>> +	}
>> +
>> +	if (!d_is_negative(dentry)) {
>> +		spin_unlock(&dentry->d_lock);
>> +		return LRU_ROTATE;
>> +	}
>> +
>> +	d_lru_shrink_move(lru, dentry, freeable);
>> +	spin_unlock(&dentry->d_lock);
>> +	return LRU_REMOVED;
>> +}
>> +
>> +struct dentry_limit_ctx {
>> +	long over;		/* remaining dentries to evict */
>> +	list_lru_walk_cb isolate;
>> +};
>> +
>> +static void dentry_limit_prune_sb(struct super_block *sb, void *arg)
>> +{
>> +	struct dentry_limit_ctx *ctx = arg;
>> +	unsigned long walked = 0;
>> +	unsigned long budget;
>> +
>> +	if (ctx->over <= 0)
>> +		return;
>> +
>> +	/*
>> +	 * Walk up to one full pass of this superblock's LRU, in
>> +	 * DENTRY_LIMIT_BATCH-sized chunks. The loop matters mainly for
>> +	 * phase 1: dentry_lru_isolate_negative() returns LRU_ROTATE for
>> +	 * positive dentries, which still counts against list_lru_walk()'s
>> +	 * nr_to_walk. A single batch can therefore finish having freed
>> +	 * nothing when positives crowd the head of the LRU, and without
>> +	 * the inner loop the worker would have to wait a full
>> +	 * dentry-limit-interval-ms before retrying never reaching the
>> +	 * negatives buried behind a long run of positives.
>> +	 *
>> +	 * The budget is snapshot at entry so a filesystem allocating
>> +	 * dentries faster than we drain them can't keep us spinning here
>> +	 * forever; freshly added dentries are picked up on the next
>> +	 * worker invocation.
>> +	 *
>> +	 * Phase 2 normally exits much sooner: its isolate callback frees
>> +	 * any non-referenced dentry, so ctx->over typically hits zero
>> +	 * inside the first batch. The worst-case over-eviction is one
>> +	 * batch past the cap, which is within the soft semantics of
>> +	 * fs.dentry-limit.
>> +	 */
>> +	budget = list_lru_count(&sb->s_dentry_lru);
>> +
>> +	while (ctx->over > 0 && walked < budget) {
>> +		LIST_HEAD(dispose);
>> +		unsigned long nr;
>> +		long freed;
>> +
>> +		nr = min(DENTRY_LIMIT_BATCH, budget - walked);
>> +		freed = list_lru_walk(&sb->s_dentry_lru, ctx->isolate,
>> +				      &dispose, nr);
>> +		shrink_dentry_list(&dispose);
>> +
>> +		ctx->over -= freed;
>> +		walked += nr;
>> +
>> +		cond_resched();
>> +	}
>> +}
>> +
>> +static void dentry_limit_worker_fn(struct work_struct *work)
>> +{
>> +	struct dentry_limit_ctx ctx;
>> +	unsigned long limit = READ_ONCE(sysctl_dentry_limit);
>> +	unsigned int ms;
>> +	long nr;
>> +
>> +	if (!limit)
>> +		return;
>> +
>> +	nr = get_nr_dentry();
>> +	if (nr <= (long)limit)
>> +		return;
>> +
>> +	ctx.over = nr - (long)limit;
>> +
>> +	/* Phase 1: drain negative dentries across every superblock. */
>> +	ctx.isolate = dentry_lru_isolate_negative;
>> +	iterate_supers(dentry_limit_prune_sb, &ctx);
>> +
>> +	/* Phase 2: still over? Apply the ordinary LRU policy. */
>> +	if (ctx.over > 0) {
>> +		ctx.isolate = dentry_lru_isolate;
>> +		iterate_supers(dentry_limit_prune_sb, &ctx);
>> +	}
>> +
>> +	/*
>> +	 * Re-arm while still above the limit. Re-read the sysctls in
>> +	 * case the admin raised the cap or disabled the feature during
>> +	 * the walk.
>> +	 */
>> +	limit = READ_ONCE(sysctl_dentry_limit);
>> +	if (!limit || get_nr_dentry() <= (long)limit)
>> +		return;
>> +
>> +	ms = READ_ONCE(sysctl_dentry_limit_interval_ms);
>> +	queue_delayed_work(system_unbound_wq, &dentry_limit_work,
>> +			   msecs_to_jiffies(ms));
>> +}
>> +
>> +static void dentry_limit_kick(void)
>> +{
>> +	unsigned long limit = READ_ONCE(sysctl_dentry_limit);
>> +	unsigned long now;
>> +
>> +	if (!limit)
>> +		return;
>> +	if (delayed_work_pending(&dentry_limit_work))
>> +		return;
>> +
>> +	now = jiffies;
>> +	if (time_before(now, READ_ONCE(dentry_limit_last_kick) + HZ / 10))
>> +		return;
>> +	WRITE_ONCE(dentry_limit_last_kick, now);
>> +
>> +	if (get_nr_dentry() <= (long)limit)
>> +		return;
>> +
>> +	queue_delayed_work(system_unbound_wq, &dentry_limit_work, 0);
>> +}
>>   
>>   /**
>>    * shrink_dcache_sb - shrink dcache for a superblock
>> @@ -1868,6 +2064,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>>   	}
>>   
>>   	this_cpu_inc(nr_dentry);
>> +	dentry_limit_kick();
>>   
>>   	return dentry;
>>   }
>>
>> ---
>> base-commit: 5d6919055dec134de3c40167a490f33c74c12581
>> change-id: 20260513-limit-dentries-cache-63685729672b
>>
>> Best regards,
>> -- 
>> Horst Birthelmer <hbirthelmer@ddn.com>
>>
>>
>>
>
