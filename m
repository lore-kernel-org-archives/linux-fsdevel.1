Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BB53B0AFB
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778701476; cv=none; b=V9yn78IBRxLgzGpYY11knqw7rdot3n6POdXmGoFUb9SBcPOdtJAAvrFzjaGWQFr3wbbw/nY9YalVZczjXXbCIO0MCxcQb/LY9ob48NMfLxsbwYPtk8j8275f7vyOG6smxkonoTWq2sUSGzOuwC95qfnjeSGV/pVtMkMQM5BOmto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778701476; c=relaxed/simple;
	bh=gsUPAsL6EI1oq+DCQsyJe6Euf3MaqjfCVIOlfQ2koUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQGRN9RNCe/xODdejd/N9ekMeSF3XFHjAO4yX+NsVK8jxEzVraYk6MsbkLgaxPLNnUqlE3aq5g4ixVh9K/qbO396HUXmbHb/7lMduxUUt6nzmmgRs+7OxgN0UJCrHWRlTCiVVXqkCrcb6FvWwPCAd22hZC0o6j07BzSqjKxwAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=WrDHuutK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KdQ+2uGr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="WrDHuutK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KdQ+2uGr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 44AF5EC019C;
	Wed, 13 May 2026 15:44:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 13 May 2026 15:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778701474;
	 x=1778787874; bh=gQkCUjExmwMAUBPbW7JpuFJZDjYI1ekOw5jNW1Dt74c=; b=
	WrDHuutKWCRSXHFDT7xvsIQTO0M7pYmGK+A6pG8VK5GsExJHj9m51lcZQIHTC8QX
	ozotXj3zu559bDaaPLyONEsnP0yhoyu6oYCspuiI04TbN5OeeZG4aOA6ePD6SQwE
	YBrXB/ITwHWfQtl3OarMSp7bhEAuwqTXptUqmRnxNQhIGpSj14ZsSi85vLw0IAfh
	iCSnlzFzH8LoxKgNPwrYZL29hpntJsbo8LhRM7NfUpKHtetqNh0mph1boC/hWbPG
	BoQQUXcNRDuPcc2IdCLP5XMwpvV20eDuItd2FWIbwSAcoqdKIMxR0Y0HtaaO79Jv
	JpFHT1DpgnghL6rAEsHkfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778701474; x=
	1778787874; bh=gQkCUjExmwMAUBPbW7JpuFJZDjYI1ekOw5jNW1Dt74c=; b=K
	dQ+2uGrBoGqMCaked3cXTfX5XAC+IDSIMyk6VkS1LBwhXXMPVQOMqoEmvO8coYMA
	USp5o0JwIcvALefs+hSzgKR/kms6MXy7fcO/2GSpBz78anUDnHCSSoDsVjc3mf0j
	nF29iUTv4h/PCPNlb4QiO3T34dUFsOACltNvDwzzENkmLHR00jzXh71I1tIr/Nuh
	M0mL+p3tFp6p4BSE189byrxMT4t4y2U0BTICDZoTULsLnUyl8vxyb8IJQAlvzxhI
	YkVbrzNS5VVtlfcEeChtqNTGWC+KrBAWSM7TVh17/eTu6YzIcUTQIpjK9KQznubb
	zkKHv51OCYP/1VwVL+3Og==
X-ME-Sender: <xms:odQEak18dJ9LJB0QzbKqD5s4keyusi1wWofqhzkMpkD8AsGbGjQXBQ>
    <xme:odQEaoaKL815wA9_57PiUXVH-GH8SSKdg_myYHitbi7dUb5uZBwRBXcqLtZ2t2W-V
    EzD9aPgXZ4l-Raxlj2wwewAw8SBZcvovh84EXfncxH_t9aee1TBkQ>
X-ME-Received: <xmr:odQEakIusGFpH7q5_k-lMcUHmq5ngLEZ7tolUaFs49zHxQfegYYfI8u1yAKsAXFQBVyvb0lJbCwXnvmA81IUP2Zi3cTraR6bUFFFOu6jlEjIpGT0tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeeugfevvdeggeeutdelgffgiefgffejheffkedtieduffehledvfeevgeej
    hedtjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghr
    vgguihdrhhhupdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtoheplhhinhhu
    gidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfuh
    hsvgdquggvvhgvlheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:odQEavEcm1FTSrQ011EWaQVhg_10-Vl3hVOu49xO76SeoQUFG7Mg_w>
    <xmx:odQEajtPQNWXaEupVcModqwe65Xe9LQoOrxCqbNM61EJfe9v2ySNWg>
    <xmx:odQEamvCwsb2qjNACREHrV16bqf6k68vmrhb7uZiiK9HPGJwZIrzSA>
    <xmx:odQEapDFgIs2h3vALIXmpluSCzAmcKH_XvcfsK1RBwNIjk7vmhPrQw>
    <xmx:otQEal_v-UnlGx_Md0DiWAvcao2B3kWT4z3XXyii7k8XhAZVuO-PPM_x>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 15:44:32 -0400 (EDT)
Message-ID: <5bd3e5b2-af2a-4184-95c1-54ec645a679e@bsbernd.com>
Date: Wed, 13 May 2026 21:44:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] fuse: make debugging configurable at runtime
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205214.4101881.6181001367021214200.stgit@frogsfrogsfrogs>
 <20260513174102.GG9544@frogsfrogsfrogs>
 <e7ef9cbb-2692-409a-b24d-998b18e74324@bsbernd.com>
 <20260513183536.GL9544@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260513183536.GL9544@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/26 20:35, Darrick J. Wong wrote:
> On Wed, May 13, 2026 at 07:46:05PM +0200, Bernd Schubert wrote:
>>
>>
>> On 5/13/26 19:41, Darrick J. Wong wrote:
>>> On Wed, Apr 29, 2026 at 07:24:28AM -0700, Darrick J. Wong wrote:
>>>> From: Darrick J. Wong <djwong@kernel.org>
>>>>
>>>> Use static keys so that we can configure debugging assertions and dmesg
>>>> warnings at runtime.  By default this is turned off so the cost is
>>>> merely scanning a nop sled.  However, fuse server developers can turn
>>>> it on for their debugging systems.
>>>>
>>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>>>> ---
>>>>  fs/fuse/fuse_iomap_i.h |   17 ++++++++++++++---
>>>>  fs/fuse/Kconfig        |   15 +++++++++++++++
>>>>  fs/fuse/fuse_iomap.c   |   43 +++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 72 insertions(+), 3 deletions(-)
>>>>
>>>>
>>>> diff --git a/fs/fuse/fuse_iomap_i.h b/fs/fuse/fuse_iomap_i.h
>>>> index b9ab8ce140e8e1..c37a7c5cfc862f 100644
>>>> --- a/fs/fuse/fuse_iomap_i.h
>>>> +++ b/fs/fuse/fuse_iomap_i.h
>>>> @@ -8,17 +8,28 @@
>>>>  
>>>>  #if IS_ENABLED(CONFIG_FUSE_IOMAP)
>>>>  #if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
>>>> -# define ASSERT(condition) do {						\
>>>> +
>>>> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_BY_DEFAULT)
>>>> +DECLARE_STATIC_KEY_TRUE(fuse_iomap_debug);
>>>> +#else
>>>> +DECLARE_STATIC_KEY_FALSE(fuse_iomap_debug);
>>>> +#endif /* FUSE_IOMAP_DEBUG_BY_DEFAULT */
>>>> +
>>>> +# define ASSERT(condition) \
>>>> +while (static_branch_unlikely(&fuse_iomap_debug)) {			\
>>>>  	int __cond = !!(condition);					\
>>>>  	if (unlikely(!__cond))						\
>>>>  		trace_fuse_iomap_assert(__func__, __LINE__, #condition); \
>>>>  	WARN(!__cond, "Assertion failed: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
>>>> -} while (0)
>>>> +	break;								\
>>>> +}
>>>>  # define BAD_DATA(condition) ({						\
>>>>  	int __cond = !!(condition);					\
>>>>  	if (unlikely(__cond))						\
>>>>  		trace_fuse_iomap_bad_data(__func__, __LINE__, #condition); \
>>>> -	WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
>>>> +	if (static_branch_unlikely(&fuse_iomap_debug))			\
>>>> +		WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
>>>> +	unlikely(__cond);								\
>>>>  })
>>>>  #else
>>>>  # define ASSERT(condition)
>>>> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
>>>> index 934d48076a010c..1b8990f1c2a8f9 100644
>>>> --- a/fs/fuse/Kconfig
>>>> +++ b/fs/fuse/Kconfig
>>>> @@ -101,6 +101,21 @@ config FUSE_IOMAP_DEBUG
>>>>  	  Enable debugging assertions for the fuse iomap code paths and logging
>>>>  	  of bad iomap file mapping data being sent to the kernel.
>>>>  
>>>> +	  Say N here if you don't want any debugging code code compiled in at
>>>> +	  all.
>>>> +
>>>> +config FUSE_IOMAP_DEBUG_BY_DEFAULT
>>>> +	bool "Debug FUSE file IO over iomap at boot time"
>>>> +	default n
>>>> +	depends on FUSE_IOMAP_DEBUG
>>>> +	help
>>>> +	  At boot time, enable debugging assertions for the fuse iomap code
>>>> +	  paths and warnings about bad iomap file mapping data.  This enables
>>>> +	  fuse server authors to control debugging at runtime even on a
>>>> +	  distribution kernel while avoiding most of the overhead on production
>>>> +	  systems.  The setting can be changed at runtime via the debug_iomap
>>>> +	  module parameter.
>>>> +
>>>>  config FUSE_IO_URING
>>>>  	bool "FUSE communication over io-uring"
>>>>  	default y
>>>> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
>>>> index c22c7961cc0bdc..f7a7eba8317c18 100644
>>>> --- a/fs/fuse/fuse_iomap.c
>>>> +++ b/fs/fuse/fuse_iomap.c
>>>> @@ -18,6 +18,49 @@ static bool __read_mostly enable_iomap =
>>>>  module_param(enable_iomap, bool, 0644);
>>>>  MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
>>>>  
>>>> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
>>>> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_BY_DEFAULT)
>>>> +DEFINE_STATIC_KEY_TRUE(fuse_iomap_debug);
>>>> +#else
>>>> +DEFINE_STATIC_KEY_FALSE(fuse_iomap_debug);
>>>> +#endif /* FUSE_IOMAP_DEBUG_BY_DEFAULT */
>>>> +
>>>> +static int iomap_debug_set(const char *val, const struct kernel_param *kp)
>>>> +{
>>>> +	bool now;
>>>> +	int ret;
>>>> +
>>>> +	if (!val)
>>>> +		return -EINVAL;
>>>> +
>>>> +	ret = kstrtobool(val, &now);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (now)
>>>> +		static_branch_enable(&fuse_iomap_debug);
>>>> +	else
>>>> +		static_branch_disable(&fuse_iomap_debug);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int iomap_debug_get(char *buffer, const struct kernel_param *kp)
>>>> +{
>>>> +	return sprintf(buffer, "%c\n",
>>>> +		       static_branch_unlikely(&fuse_iomap_debug) ? 'Y' : 'N');
>>>> +}
>>>> +
>>>> +static const struct kernel_param_ops iomap_debug_ops = {
>>>> +	.set = iomap_debug_set,
>>>> +	.get = iomap_debug_get,
>>>
>>> Codex points out that if we set KERNEL_PARAM_OPS_FL_NOARG in
>>> kernel_param_ops::flags and teach iomap_debug_set to handle !val as now
>>> == true, then we can support enabling debugging with
>>> "modprobe fuse debug_iomap".  That seems reasonable to me, so I'll make
>>> this minor change.
>>>
>>> --D
>>>
>>>> +};
>>>> +
>>>> +module_param_cb(debug_iomap, &iomap_debug_ops, NULL, 0644);
>>>> +__MODULE_PARM_TYPE(debug_iomap, "bool");
>>>> +MODULE_PARM_DESC(debug_iomap, "Enable debugging of fuse iomap");
>>>> +#endif /* IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG) */
>>>> +
>>>>  bool fuse_iomap_enabled(void)
>>>>  {
>>>>  	/* Don't let anyone touch iomap until the end of the patchset. */
>>>>
>>>>
>>
>>
>> Hi Darrick,
>>
>> would it help to just use debugfs? I will try to find time to send that
>> out tomorrow.
>>
>> https://github.com/bsbernd/linux/commit/5f25afb42ae7bb7ead646cfa3a3683817975ccb9
>>
>> (on this branch https://github.com/bsbernd/linux/commits/fuse-debugfs/)
> 
> I'm skeptical, because debugfs is disabled in lockdown mode.  Presumably
> some $enterprise customers might want to turn on the extra logging and
> assertions even in production?  Some product groups I work with require
> secureboot even in their dev environments.
Pity, all we need is a debug-fs that can print some fuse specific
topics, nothing insecure there.

Cheers,
Bernd
