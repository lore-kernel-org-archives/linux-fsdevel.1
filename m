Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4C33F370
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585142; cv=none; b=uJdFbmRN96gKeEd+XZRdU1TKXQzISVlrPRs5N+FiwbshjUYfICnbI/ZWjwGuUfTWOz+hib/OGHx6if9jA/bU9yaSwzgIXK3y1ZqJ1/vjabkkIEK0o61Loz/ITpMtJef/mZOfmphgDwmGA6yl5DpRHKYicJMViFNGnjvZesZUFV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585142; c=relaxed/simple;
	bh=6stKIcINqn3M8Gg5I1ZOzhFKk4wPoBM7zGZ4krEWOBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYkDYtNLVdz2EQUiAqUyPkwsgWbVRGMYtoIHjA6l/9AbCJGpdtXqIU+G0ZiEsJCSIOswlEAjxWxQkM4gxnxIlDvep0caKFYDQpolYitW/tg/R9vop6W69j1TcolZsp+PaeQFLS22i4c9oclBbD+P4wfxPH6fJUodGNk6ZVAoGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=dsCborjf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NKCmwLMy; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="dsCborjf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NKCmwLMy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A793D1D00179;
	Tue,  7 Apr 2026 14:05:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 07 Apr 2026 14:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1775585139;
	 x=1775671539; bh=blqHuqVu9Sr0bYx1oXLc1i2AkOxHF2v/RBfSn+QPtzI=; b=
	dsCborjfOEJHZWWxbNrEovl+n5d3mTRl9jEFPAgPaB3uQSM48bQFGHpdwfq3adRv
	QhsLwjjtU9U46k3Cqv7I5baDNZl0NlvF1sHWq+6T3LWj9SEsjsJrxiahcUat0RYs
	kfewAWXG/Fc0li4eplHIIOMhHQBqFBW2p5lNZ4caWBGna3rc8c4Zuw7XP8huByxS
	N2/oVz63MY7IHbyAZqhW+CbzjJ3nG/3gWgsF3iH5xRIlHtwAb0P5QA2noOxg5vSh
	jeGy65r3og9ZbQ4C+YAc/x5bn74AY5teIQjsgRTGr4ZV1etDLf14sJjBgYcWd26t
	OtQVEmQCIsKqlhrzEnQJFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775585139; x=
	1775671539; bh=blqHuqVu9Sr0bYx1oXLc1i2AkOxHF2v/RBfSn+QPtzI=; b=N
	KCmwLMyR2im2u5uxcW1IUUCFfqm/cKDLakt8PTZJaliEmuAGYTiiO84uyt1HYCwp
	fqkWaMRQBUwHkYLQ1UQShjnUIEzFyfdECJP0xhHYcp3KdFtKAlgwjcm33Q3vt6Jc
	LHG0tvs01oDiq7bBRrHwTo8Hr3tdCJGnjONi4AYXqAFJIX0yQG9SMy6iMAKKidJn
	Lr6jqH4Sg5cUx0Off6P8rMG/0kJoM/1x0qqbUpc/UMBrxIR7mcE3THHxVbnRMv0R
	IjjJOCV1OBFvA+XeYS8owXB7oxKdKeZpQClv1fRWTWMzB2E+ynM9fdqi6cpyc4AV
	KykzM5XtYd/Dmmkq82yOQ==
X-ME-Sender: <xms:c0fVacf4eMCxPSQoJeRk8ybpxqxUVkJWsVsUR-08tnvrWXwmr0YsXw>
    <xme:c0fVabySvHdId08dPWdNjlcYT0vnbTtTIcu1TFv_W1ZRhJehH0fFG5ygjXZhdfo1y
    D76HEdTkG5ExE3f4-iMHmNi2ZRg9P12QBonjm_zsDxoRW367k_bWQ>
X-ME-Received: <xmr:c0fVaT_QHkN89pD5EsdvZP3i-clTre5enuV0JDIFgjV3t7f0uH77EOOrdxy9czOiW4Ne2wQe10yhe4MLYej7Ql1FrPCBJHY87VzaXBFjszfPMWfTtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuh
    hsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefkffggfgfuvfevfhfhjggtgfes
    thekredttddvjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnug
    essghssggvrhhnugdrtghomheqnecuggftrfgrthhtvghrnheptdehueevvdeihfffjeeu
    gfekfedugfeiuddvffdttdevtedtjeetfeehheefudelnecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghdpshhouhhrtggvfhhorhhgvgdrnhgvthenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtoh
    hmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegr
    mhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhhlohhssehs
    iigvrhgvughirdhhuhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilh
    drtghomhdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhgthhgvnhesuggunhdrtghomhdprhgtphhtthhopegsshgthhhusggvrhhtseguug
    hnrdgtohhm
X-ME-Proxy: <xmx:c0fVaTgZACfwp2mVt_sOdo8Ns8WeIZYgIp-5xXURnZ4g35G6UFVHwg>
    <xmx:c0fVaaFsoNOUqFhdIL-MkW0Z6ljbdwTBrweughU9fV0QGXGn1iaa0w>
    <xmx:c0fVaS9CLXOC3BlA7hhbe3ekGociXQmSBZdS_NT4EMCy_p0JfeKM0w>
    <xmx:c0fVaRxjeAfSdLK9DY-WStQpBL94vret92rAe970ArPUF2v_fl20cA>
    <xmx:c0fVaZOM9BWDuzoxQvIW7cO56tAHjpjfHMlZoqClPYnONhOhQ5NBvpLh>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 14:05:38 -0400 (EDT)
Message-ID: <5d7295b0-bd7e-41e7-b176-3d19b240413c@bsbernd.com>
Date: Tue, 7 Apr 2026 20:05:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse-devel list on kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>,
 Bernd Schubert <bschubert@ddn.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <adTyw4UJ04qOggCQ@amir-ThinkPad-T480>
 <c4ffec34-fad0-40d9-bff1-06c3cd202351@bsbernd.com>
 <CAOQ4uxhBC7eTkaB6Ws1DqewzxkGdEfcCyJ8EZszn+YeHwG0-wQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <CAOQ4uxhBC7eTkaB6Ws1DqewzxkGdEfcCyJ8EZszn+YeHwG0-wQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/7/26 14:29, Amir Goldstein wrote:
> On Tue, Apr 7, 2026 at 2:25 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>>
>>
>> On 4/7/26 14:04, Amir Goldstein wrote:
>>> On Thu, Mar 26, 2026 at 10:34:33PM +0100, Bernd Schubert wrote:
>>>> I'm taking Darricks example here and posting API changing libfuse
>>>> changes to linux-fsdevel. We should consider to create a fuse
>>>> specific list if that is too much. The existing
>>>> fuse-devel@lists.sourceforge.net is rather hopeless due to lack
>>>> of spam filtering.
>>>>
>>>
>>> Let's do this already!
>>>
>>> https://korg.docs.kernel.org/lore-archives.html
>>>
>>> Do you want me to send the email to kernel.org?
>>>
>>> I suggest that we ask for fuse-deve@lists.linux.dev
> 
> Just don't copy paste my fuse-deve typo in the request ;)
> 
>>> and then we can migrated the old sourceforge archives
>>
>> I'm all for a new fuse mailing list.
>>
>>>
>>> As far as I can understand getting the archives from sourceforge
>>> required the admin password:
>>>
>>> https://sourceforge.net/p/forge/documentation/Mailing%20List%20Archives/
>>>
>>> Mikos,
>>>
>>> Will you be able to handle the archive migration?
>>
>> Have that password from Nikolaus.
>>
> 
> Excellent, so will you be sending that email to helpdesk@kernel.org?

I can login here as admin:
https://lists.sourceforge.net/lists/admin/fuse-devel with the admin
password.

Here https://lists.sourceforge.net/mbox/fuse-devel which is supposed to
create the mbox file it asks for "user" and password. Assuming the
password is the same, what is the "user"? Also tried my user sourceforge
credentials, does not work either.

Can we defer this a bit? Too many things to do and I think for now
reviewing Joannes Patches and finishing sync-init and Darricks mail has
a higher priority than fighting with sourceforge mbox.


Thanks,
Bernd
