Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315E4DC547
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694371; cv=none; b=AuLBKSKdoGzBeifwGX0SPVg12fWkdlmykzSt3VZH6qTL5IY+4qkEb5Ay1ZoaOAuyEm5x6qKeQbrh9WDRd65hrWis4kA/DIyAX4jyH5DPSGGyR56z9JgrdKz+9XWxK9rwk+9BQrRSFK1HkLqemFpAHOpbpaIfLFUIE1LjaSCnO88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694371; c=relaxed/simple;
	bh=tVPq6rd6AYwbRpzqVBQukXOCXU84mHbh7XSpaRo+xq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLbOQ97xAqZbXvG+pT/XdGkis1i0yqZucDV2nQ3skBoZKecXcTzNdOt6mj+oMLIRyJvq2Dh1Rbu3SSgc6OMtdrVIXE5OYxRDoFlDNeEqx7+IBmZ3d2XmrkYlykjOfihTNCDCFXCpx84R2zBEYCnZqMGC7/EPLyNShCFt079sg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Hjd23abP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sW4ZEN5g; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Hjd23abP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sW4ZEN5g"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 01F0C1400078;
	Wed, 13 May 2026 13:46:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 13 May 2026 13:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778694367;
	 x=1778780767; bh=V6MizQjMao3TwskEto6nH2VmCBabaehxfbC2sng6HN0=; b=
	Hjd23abPKVbHXiH+wpzcnfcCPUd3Awvf70h2v1TlH1hvJzniblmaKS7295fbbvBZ
	Bx8jP2m4Of7NaSo6M/F1KHlrtAfQBejKyE3hRTcCuFYdcniB13E3U0/dNSxsQZbF
	vFUb7qLvBzzq6yzH2GnwpJ/0QsdCwLiTTQdA3lrGaf0UurcUkwDL8gM4JuiaL608
	C+cxXnCUd7IENgUKFiKjXz+Rtp8nH3ueqLA3dzAv/9uqJPaBzTMB9asWCG+5oIxy
	vIO12KyUZ1g0tlVziw5W4K8qvk5CAManbFVJ0vGUX1cmqVdYOx5ouajEzHcCXpCf
	kE7F69fqUgPCvvPn0SjXqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778694367; x=
	1778780767; bh=V6MizQjMao3TwskEto6nH2VmCBabaehxfbC2sng6HN0=; b=s
	W4ZEN5gu62pDHk0ZiYJjhnABJGtko2p0SA2+XSiaDP2w9c46oPgqkt0hMtPgBLtf
	kYnJE7GnWHkhWxn8Rb0wrrt9l7paMVy6I5oh7W6v3uGIgcpZqICynjSrCqgdg75I
	oGqrle9qzLhEkMS8CIE0d2zhOB4+eH9EUPXjrlktmmzWgsopljfRoDv+qH7jwSPw
	fGH+KICbh5luatk6NAint3giJtD15G1eDN6um3U2tONuhZWHqRle7Kzy5VyTWSTh
	8DEsss2QvZdUF+r607+LbUhSTM3KD6jwMGPqjdOTiWFzb/xIf96G1zlhRXKsFpSX
	CYUHLgIj5gi1A7/gex3NA==
X-ME-Sender: <xms:37gEar_XbO7LK_tP1TlBZacpN9Llj8XiRmDi_WujeuA15ZFtutZG9w>
    <xme:37gEahDmLrjgBSjbzIwClpaZW5asxfuRzlUx6xkJPS6DG59afhqETF4HthVj3s_0f
    UqtRF0MXkG39lcgHiVXr8kSeQrbN2p4DVPmTAFGC9AqFAiqZk8->
X-ME-Received: <xmr:37gEagQk4OsWFMpBavv4DrYRiIqAkSv02KybY_bZLK7_llkAHbPMG_uZKRcGhPrvnhzPu6WM9Moau-3bhIjwqvtwDBuGZ0LwAvv6mT7w-FzC_9nAfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdehvdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:37gEaosMqwluuSdyR6wsIm6-pCQhvubo3yJ3iyta5s_6oPRsZeuM9Q>
    <xmx:37gEas2vRfO5_8OfaHvh7-UaLLF-Ig6e7eT_AE2AzGyHTiRHas9cyA>
    <xmx:37gEapUMaAaYuiSgscgF_CWE2lKFA5ZD8Jm3C4ffBbAHZT3HzpGhag>
    <xmx:37gEanIVO_B8a3-mcKvIl_S49F-ut9W3H6JNCxg_omRuqYyjrc_OeQ>
    <xmx:37gEaoPFEZEAsT4B4lENHUWhwODLd62wnR-0GSGBd4X2eZX4KyyzQ8Wl>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 13:46:06 -0400 (EDT)
Message-ID: <e7ef9cbb-2692-409a-b24d-998b18e74324@bsbernd.com>
Date: Wed, 13 May 2026 19:46:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] fuse: make debugging configurable at runtime
To: "Darrick J. Wong" <djwong@kernel.org>, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205214.4101881.6181001367021214200.stgit@frogsfrogsfrogs>
 <20260513174102.GG9544@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260513174102.GG9544@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/26 19:41, Darrick J. Wong wrote:
> On Wed, Apr 29, 2026 at 07:24:28AM -0700, Darrick J. Wong wrote:
>> From: Darrick J. Wong <djwong@kernel.org>
>>
>> Use static keys so that we can configure debugging assertions and dmesg
>> warnings at runtime.  By default this is turned off so the cost is
>> merely scanning a nop sled.  However, fuse server developers can turn
>> it on for their debugging systems.
>>
>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>> ---
>>  fs/fuse/fuse_iomap_i.h |   17 ++++++++++++++---
>>  fs/fuse/Kconfig        |   15 +++++++++++++++
>>  fs/fuse/fuse_iomap.c   |   43 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 72 insertions(+), 3 deletions(-)
>>
>>
>> diff --git a/fs/fuse/fuse_iomap_i.h b/fs/fuse/fuse_iomap_i.h
>> index b9ab8ce140e8e1..c37a7c5cfc862f 100644
>> --- a/fs/fuse/fuse_iomap_i.h
>> +++ b/fs/fuse/fuse_iomap_i.h
>> @@ -8,17 +8,28 @@
>>  
>>  #if IS_ENABLED(CONFIG_FUSE_IOMAP)
>>  #if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
>> -# define ASSERT(condition) do {						\
>> +
>> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_BY_DEFAULT)
>> +DECLARE_STATIC_KEY_TRUE(fuse_iomap_debug);
>> +#else
>> +DECLARE_STATIC_KEY_FALSE(fuse_iomap_debug);
>> +#endif /* FUSE_IOMAP_DEBUG_BY_DEFAULT */
>> +
>> +# define ASSERT(condition) \
>> +while (static_branch_unlikely(&fuse_iomap_debug)) {			\
>>  	int __cond = !!(condition);					\
>>  	if (unlikely(!__cond))						\
>>  		trace_fuse_iomap_assert(__func__, __LINE__, #condition); \
>>  	WARN(!__cond, "Assertion failed: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
>> -} while (0)
>> +	break;								\
>> +}
>>  # define BAD_DATA(condition) ({						\
>>  	int __cond = !!(condition);					\
>>  	if (unlikely(__cond))						\
>>  		trace_fuse_iomap_bad_data(__func__, __LINE__, #condition); \
>> -	WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
>> +	if (static_branch_unlikely(&fuse_iomap_debug))			\
>> +		WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
>> +	unlikely(__cond);								\
>>  })
>>  #else
>>  # define ASSERT(condition)
>> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
>> index 934d48076a010c..1b8990f1c2a8f9 100644
>> --- a/fs/fuse/Kconfig
>> +++ b/fs/fuse/Kconfig
>> @@ -101,6 +101,21 @@ config FUSE_IOMAP_DEBUG
>>  	  Enable debugging assertions for the fuse iomap code paths and logging
>>  	  of bad iomap file mapping data being sent to the kernel.
>>  
>> +	  Say N here if you don't want any debugging code code compiled in at
>> +	  all.
>> +
>> +config FUSE_IOMAP_DEBUG_BY_DEFAULT
>> +	bool "Debug FUSE file IO over iomap at boot time"
>> +	default n
>> +	depends on FUSE_IOMAP_DEBUG
>> +	help
>> +	  At boot time, enable debugging assertions for the fuse iomap code
>> +	  paths and warnings about bad iomap file mapping data.  This enables
>> +	  fuse server authors to control debugging at runtime even on a
>> +	  distribution kernel while avoiding most of the overhead on production
>> +	  systems.  The setting can be changed at runtime via the debug_iomap
>> +	  module parameter.
>> +
>>  config FUSE_IO_URING
>>  	bool "FUSE communication over io-uring"
>>  	default y
>> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
>> index c22c7961cc0bdc..f7a7eba8317c18 100644
>> --- a/fs/fuse/fuse_iomap.c
>> +++ b/fs/fuse/fuse_iomap.c
>> @@ -18,6 +18,49 @@ static bool __read_mostly enable_iomap =
>>  module_param(enable_iomap, bool, 0644);
>>  MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
>>  
>> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
>> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_BY_DEFAULT)
>> +DEFINE_STATIC_KEY_TRUE(fuse_iomap_debug);
>> +#else
>> +DEFINE_STATIC_KEY_FALSE(fuse_iomap_debug);
>> +#endif /* FUSE_IOMAP_DEBUG_BY_DEFAULT */
>> +
>> +static int iomap_debug_set(const char *val, const struct kernel_param *kp)
>> +{
>> +	bool now;
>> +	int ret;
>> +
>> +	if (!val)
>> +		return -EINVAL;
>> +
>> +	ret = kstrtobool(val, &now);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (now)
>> +		static_branch_enable(&fuse_iomap_debug);
>> +	else
>> +		static_branch_disable(&fuse_iomap_debug);
>> +
>> +	return 0;
>> +}
>> +
>> +static int iomap_debug_get(char *buffer, const struct kernel_param *kp)
>> +{
>> +	return sprintf(buffer, "%c\n",
>> +		       static_branch_unlikely(&fuse_iomap_debug) ? 'Y' : 'N');
>> +}
>> +
>> +static const struct kernel_param_ops iomap_debug_ops = {
>> +	.set = iomap_debug_set,
>> +	.get = iomap_debug_get,
> 
> Codex points out that if we set KERNEL_PARAM_OPS_FL_NOARG in
> kernel_param_ops::flags and teach iomap_debug_set to handle !val as now
> == true, then we can support enabling debugging with
> "modprobe fuse debug_iomap".  That seems reasonable to me, so I'll make
> this minor change.
> 
> --D
> 
>> +};
>> +
>> +module_param_cb(debug_iomap, &iomap_debug_ops, NULL, 0644);
>> +__MODULE_PARM_TYPE(debug_iomap, "bool");
>> +MODULE_PARM_DESC(debug_iomap, "Enable debugging of fuse iomap");
>> +#endif /* IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG) */
>> +
>>  bool fuse_iomap_enabled(void)
>>  {
>>  	/* Don't let anyone touch iomap until the end of the patchset. */
>>
>>


Hi Darrick,

would it help to just use debugfs? I will try to find time to send that
out tomorrow.

https://github.com/bsbernd/linux/commit/5f25afb42ae7bb7ead646cfa3a3683817975ccb9

(on this branch https://github.com/bsbernd/linux/commits/fuse-debugfs/)


Thanks,
Bernd

Thanks,
Bernd

