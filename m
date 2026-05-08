Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7024E4B5
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258672; cv=none; b=Q3+zi/RsvIpogBpesQisnK7MCyf/P58Q7wcAu1VKx4z0CWKpkl0SRhDvn4LL0md51rvsCRX7trt3LhpLdiYdq3JEUjJYOK6V2Xvy/06De60enHBMOeXvX50eS7yAsZKcQNGPNmVitk6UrMJdk/pYofYNtawMDlMIwWPUmjHWnck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258672; c=relaxed/simple;
	bh=aeM86RbDl9RtK20Hj6hueVqg2Eug05MOdiZz7H2B3CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrthMEbVdCZyOwUaNSSgkDanGzvepUJB/3XbI4O5kK71ERwKd2gQ7I4GPooSh0KsZWmtYvD17+bc85B9gQfKvNUOY+g6GgokZb2CcuOqv23Y66QjkQOztWaiOYeFAZonr9u/xZX+PJ6CQExzVnXtZR3igHj2GiTe/13Yn/SzW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=IrozEHfW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GQPCtun2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="IrozEHfW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GQPCtun2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3F3C1400124;
	Fri,  8 May 2026 12:44:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 08 May 2026 12:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778258667;
	 x=1778345067; bh=wbQyJrHL+eBAOXZGwnIrgzXT5kRpiT5/b03F0U6lfZg=; b=
	IrozEHfWyvK6yxSS6Q/Bl5CeFS9gK3wJaTBtWpeM6AUzSZpeiROExsR0Ii6D4sf4
	lJSLw3Fc0KewjAGMEkOQX2dI7mXl5TTWzOJSwkYBioV4pb19TFNFhyQxB4DAIRpp
	i4vMgY7izeWC70yNtd9Mjf1AxRAH/lCV3mQ15imtBVideRBn1xoBz8MA2pWUW22x
	ZhcV+mVXX+3PcrclqSwGJHVDpe8A9FalFeGx72QRexwMVwpcGktNkXo0UkqiU/ha
	6z2CBEQIEQ5GJigHz9GyZ11UgEhqpiR3sP4xv9k4P1dBWaP3qcT/t7cdl7d30PQp
	yFcaOCPExOSEUnfWU91Iaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778258667; x=
	1778345067; bh=wbQyJrHL+eBAOXZGwnIrgzXT5kRpiT5/b03F0U6lfZg=; b=G
	QPCtun2c7a9RhHZYe2ehAr2X/jzIEjbre5tG8+dWN/BKGpdPZZ8GPnUoCtxw0htN
	hqUh5idA+sgTUP3bQLGkKZUzCa3YBu+YTl8zqqpTesRPPoVC/sWh7QtjZ18l+PxY
	jugMhky0J8md+k+QDR5jgHKWwB3Pa+mfjfFoYs5hLww+TachMJrNauH3Afo3ZMvC
	WUSdPOakNujH/EwumvYTIWgsTVIc3LwDa1VVfSj6A1dw+CrvWJNNRd4ODRBhbBKl
	DqvPudIT5wZ46io/kkBzwMP22VvAYCiOS32by5oXR/2Xm7vRg8IcB3/u15GjRc/B
	W/HUeZP6YlV3xdhwNPgrQ==
X-ME-Sender: <xms:6xL-abSN2XpI-E30D2MrKBLOqaHSH2Wmpqa_m2tbdbk71CzPOfaBwA>
    <xme:6xL-aWF9zmEKSceHGE5H9AAOCKaoFq_AS60B5BTisNkwQqPJmp0V_2M_qCadlNZQ_
    -30nqWB-25NvgHKg4TbJv3BTaM396_HIROzpoaLVFJ_tjDGCgc>
X-ME-Received: <xmr:6xL-aYFXckO92MUevqvSVLO0TOCWO38Dmnl-Zv3BFVMHphLdgCvU56FDX2_fXYlPSKuWEpZjqSwllnYGDp8joBeMjQyZGvES3fSiIj1Rm1Lb2cXpPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjohgrnhhn
    vghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehfuhhsvgdquggvvhgvlh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehnvggrlhesghhomhhprgdr
    uggvvhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:6xL-acRGaYogH_lf0b0HDpVDVMpMf44xAo3cfmKSpVuq5kyZBPsXdg>
    <xmx:6xL-aRKwH8d99Tzd-2jk82uul7y0MGu1YkSehRBw4dCdf9aLaYgBhA>
    <xmx:6xL-afYnFCxtA_o5ZRZi0Qwfg827kZzTDY3hIvTuYYLpnc2FFiK-wg>
    <xmx:6xL-ab_jh_bRaOK6FELosE_1nRpm17nrd6Ae7v4ceGyiI8iYe02pZg>
    <xmx:6xL-aehZGFmEY4JvIBObUnQ0MkUw1dujkDSoKyHWVCuM4CJl24ts_Gxg>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 12:44:26 -0400 (EDT)
Message-ID: <4a4dda92-4c60-471f-8afc-6afa68d06f2c@bsbernd.com>
Date: Fri, 8 May 2026 18:44:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mount_util: fix mount_flags entries for MS_RDONLY
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org
References: <177819197881.3490692.13850589276777261250.stgit@frogsfrogsfrogs>
 <177819197899.3490692.5280827494230619038.stgit@frogsfrogsfrogs>
 <6276b3d6-cc8c-4e37-b670-ff2a25c69686@bsbernd.com>
 <20260508154400.GC2241589@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260508154400.GC2241589@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/8/26 17:44, Darrick J. Wong wrote:
> On Fri, May 08, 2026 at 12:43:14PM +0200, Bernd Schubert wrote:
>>
>>
>> On 5/8/26 00:13, Darrick J. Wong wrote:
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> MS_RDONLY maps to MOUNT_ATTR_RDONLY in the new fsmount API, but the
>>> table omitted that.  Fix that.
>>>
>>> Fixes: 0d7e72541564a5 ("Unify mount flag structures and remove redundant is_mount_attr field")
>>> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>>> ---
>>>  lib/mount_util.c |    4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>>
>>> diff --git a/lib/mount_util.c b/lib/mount_util.c
>>> index 1a0aec9bfe1a70..7ab1dba91e28e3 100644
>>> --- a/lib/mount_util.c
>>> +++ b/lib/mount_util.c
>>> @@ -110,8 +110,8 @@
>>>  
>>>  const struct mount_flags mount_flags[] = {
>>>  /* opt            flag             on  safe  mount_attr */
>>> -{"rw",           MS_RDONLY,        0,  1,    0},                      /* fsconfig */
>>> -{"ro",           MS_RDONLY,        1,  1,    0},                      /* fsconfig */
>>> +{"rw",           MS_RDONLY,        0,  1,    MOUNT_ATTR_RDONLY},     /* fsconfig */
>>> +{"ro",           MS_RDONLY,        1,  1,    MOUNT_ATTR_RDONLY},     /* fsconfig */
>>>  {"suid",         MS_NOSUID,        0,  0,    MOUNT_ATTR_NOSUID},     /* fsmount  */
>>>  {"nosuid",       MS_NOSUID,        1,  1,    MOUNT_ATTR_NOSUID},     /* fsmount  */
>>>  {"dev",          MS_NODEV,         0,  1,    MOUNT_ATTR_NODEV},      /* fsmount  */
>>>
>>
>> Hi Darrick,
>>
>> I had already pulled this the night before and it fails the new tests as
>> well. I think issue is that ro needs to be done via fsmount(...,
>> MOUNT_ATTR_RDONLY) *and* fsconfig(SET_FLAG, "ro"). I'm going to add a
>> new column into const struct mount_flags mount_flags[].
> 
> Ewww, you're right.  util-linux also special-cases this, and in a weird
> way:
> 
>        Since version 2.41, libmount has the ability to use optional
>        arguments vfs and fs (e.g. ro=fs) to specify where the read-only
>        setting should be applied. For example, using the command:
> 
>           mount -o ro=vfs /dev/sdc1 /A
> 
>        will mount the filesystem as read-write on the superblock level,
>        but the /A node will be set as read-only. In previous versions,
>        this required an additional "-o bind,remount,ro" operation to
>        achieve the same result.
> 
> "ro=vfs" means apply it to the mount but don't tell the filesystem;
> "ro=fs" means apply tell it to the filesystem, but not the mount;
> and plain "ro" means apply it to both?  Apparently??
> 

I just sent out a new patch series that fixes plain "ro". Thanks for
looking it up in util-linux, I see "ro=vfs/fs" as new feature and
already spent the entire (public holi)day on this series (there was
another critical sync-init issue, when sync-init was actually not used).
I.e. I'm going to ignore the "weird ways" for now.


Thanks,
Bernd
