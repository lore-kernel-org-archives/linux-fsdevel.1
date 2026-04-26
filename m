Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0422F2D1931
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777232135; cv=none; b=ivq/Ft2GBlg1z/FfVGLsux3IdpuIfWgzvSQaB+0ufLdV1DGkeFGzmffKAZ1gBUhaQg4Aa1mKrdzEJCBoa+CyE3AHEqU106PlCLzh5j4ylH+SS9zGvXZVWNzMZ8u4F7mdYhfw0YXbrr90g6I3sq77NZrJeWHdLuUGCPLt7eosnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777232135; c=relaxed/simple;
	bh=nM3rOCWDY5UBLmkGQsMwbjX7IK/9GceP4KJf/6/kQ0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMvIUsXEvEZbu9inB2hZADfFw/hgVt298XQWKZTsIjvbvQdVSeEsMjMT0BDaXwbXMuDlDF8boMqxThJrXNsF5GcIm+hUBNXfURBfL9k6/WZAkO3fgeAZgElXRt2RmDuyNwngq1SiFuDfOVujMxkmMELW2pPhD2PnL+BZvxhWXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=FEknJeXG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l2EsCohe; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="FEknJeXG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l2EsCohe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 31FF5EC050D;
	Sun, 26 Apr 2026 15:35:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 26 Apr 2026 15:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777232132;
	 x=1777318532; bh=zQYcf8MezFUKwGeGOXQz4Q0f6AQzZdnUEomKzCn/Mh8=; b=
	FEknJeXGxg5liinJuiM/TP84hiLSXYFuqk+vv//gN4Rn6tF8zfMZqqww6Ra4/2w5
	i0AdqT1lb4/Tk77JY6bt/wJkDy0eoQlbCrZk4EqGXmA2i9Ref0gwHVRipK3nM1jc
	oZzahak/SIWR0La4o74Ih3iY/JmnEvQ8EIBiqvrCN1ZbuXMLMvUzjK5HJxzEAGyK
	H6TVsedqZAoQzac0A8gvC1//k2uS3N5ErEMgoYnJv9t+fhF2KyGRisL2tAB9j1pj
	PCYtl6XB6/31crPUOOVSItkoqGeLVMf2730vTMEYpCVpXz1c+dZQdKCAQJhkL4N3
	k/muWq+ZLhPYtVhPdao6qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777232132; x=
	1777318532; bh=zQYcf8MezFUKwGeGOXQz4Q0f6AQzZdnUEomKzCn/Mh8=; b=l
	2EsCohesuH63DNx4DNZ+/DwtrEw0FM7o7JJxFHqurbVHf/QXplCoGYan0aTxJx0e
	JO6n7jAHA3d5BzyFuS2MlbuAhhoVGMnfaiZgsikNpJVv5XCZhdQiNCzRlBFM0ths
	qALXWTrymfLtExErpo2tpIJHP5BBkcKMZ0j4mVS3sG/+r5GChFyMBfdv868fuIr1
	cj/CxARlC7i148nr8nWqONnV9c8vs8RfbMx574BlG0uCV4NKxwQ/sb76JBkhVWPU
	3GSqNlU1Nlf20niOuck4GkE+6NOXLERGquKkXmRVPB/7oCzFwf1t+Ax0o1cTmgXm
	hfPYSpVu4VVY5aNNIC6+w==
X-ME-Sender: <xms:A2nuab3dMz3AfqkwMxf0q7wlYobs5XmFYoqiYM6EL43Q7aF7DikPxw>
    <xme:A2nuaaylOIeKpLyG4YuGp8kiJsFbKM-ZJNKi6_0rh0KCwOLMTUUESjhzA0nIiaTE2
    1eyzQeU1ibDr2C90T-XLhaAOUe5q26LnMuuGKmpKJS3Qnw969GQeQ>
X-ME-Received: <xmr:A2nuaaHmO6LgOwfOR5g1xA6sQLm-dlhRqqSTvw8A1xU4JavCiGyZKpgVPkXGOZizbBu2NYfXiY38bZhf0lwkArMKP4zGmxYTs27QolnLh4jpkSVbsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejieeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepjefgleejueffhefhueekvdduhfetteehtdehfeejhfevudethefhtdetvdek
    keevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegujh
    ifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghstghhuhgsvghrthesuggu
    nhdrtghomhdprhgtphhtthhopehnvggrlhesghhomhhprgdruggvvhdprhgtphhtthhope
    hlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikh
    hlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehfuhhsvgdquggvvhgvlheslhhi
    shhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:A2nuaVY4b3G0dfRUuq2WAwX2xB-o0FHjX-2BTCABDIhZ7Lj6e4yPbQ>
    <xmx:A2nuaUCcGjDIh-i-aamwKxkXj_rn4_cfF55VCE6ED5VI9gKBo0ahZg>
    <xmx:A2nuaVkCH31Z6LWEQlbzV0Ov0-px8B4gp5Er-4Z9UALE6H2cezLd2Q>
    <xmx:A2nuadyz6A2RZmDxfoQQbFJeyRYA5TBlkn7jHOggTnwX5arXLCpeRQ>
    <xmx:BGnuaeah4yWMIGpZ8fRQK4iQmDSfh60N-mg4vXdREEBOyjnZsdfVzCB7>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 15:35:30 -0400 (EDT)
Message-ID: <665ed148-43e2-4807-b2be-01e82a98d10a@bsbernd.com>
Date: Sun, 26 Apr 2026 21:35:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v5] libfuse: run fuse servers as a contained service
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bschubert@ddn.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 joannelkoong@gmail.com, miklos@szeredi.hu, fuse-devel@lists.linux.dev
References: <20260422231518.GA7717@frogsfrogsfrogs>
 <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
 <eed525ff-8f83-4882-a5db-574d2d3a913e@bsbernd.com>
 <20260426165640.GK7765@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <20260426165640.GK7765@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/26 18:56, Darrick J. Wong wrote:
> On Sun, Apr 26, 2026 at 06:35:11PM +0200, Bernd Schubert wrote:
>>
>>
>> On 4/23/26 01:18, Darrick J. Wong wrote:
>>> Hi all,
>>>
>>> This patchset defines the necessary communication protocols and library
>>> code so that users can mount fuse servers that run in unprivileged
>>> systemd service containers.  That in turn allows unprivileged untrusted
>>> mounts, because the worst that can happen is that a malicious image
>>> crashes the fuse server and the mount dies, instead of corrupting the
>>> kernel's memory.
>>>
>>> v5: Refactor socket IO into helpers, tighten the security checks in
>>>     mount_service.c, always set nosuid/nodev for unprivileged mounts,
>>>     use posix_spawnp in mount.fuse, restructure sample programs and hl
>>>     library code to avoid the need for unmounting during startup
>>> v4.1: fix various cppcheck/codecheck complaints
>>> v4: fix a large number of security problems that only matter when the
>>>     mount helper is being run as a setuid program; fix protocol
>>>     byteswapping problems; add CLOEXEC to all files being traded
>>>     back and forth; add an umount command; and strengthen mount socket
>>>     protocol checks.
>>> v3: refactor the sample code to reduce duplication; fix all the
>>>     checkpatch complaints; examples actually build standalone;
>>>     fuservicemount handles utab now; cleaned up meson feature detection;
>>>     handle MS_ flags that don't translate to MOUNT_ATTR_*
>>> v2: cleaned up error code handling and logging; add some example fuse
>>>     service; fuservicemount3 can now be a setuid program to allow
>>>     unprivileged userspace to fire up a contained filesystem driver.
>>>     This could be opening Pandora's box...
>>> v1: detach from fuse-iomap series
>>>
>>> If you're going to start using this code, I strongly recommend pulling
>>> from my git trees, which are linked below.
>>>
>>> With a bit of luck, this should all go splendidly.
>>> Comments and questions are, as always, welcome.
>>>
>>> --D
>>>
>>> kernel git tree:
>>> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-service-container
>>
>> Hi Darrick,
>>
>> going to look for your previous pull request - kernel tree doesn't help
>> me for libfuse ;)
> 
> Urrk, that wasn't helpful of me. :(
> 
> The following changes since commit ff7aa456d426d89eb19661da7b4c171153bac516:
> 
> update kernel FUSE io_uring doc URL (2026-04-20 10:34:32 +0200)
> 
> are available in the Git repository at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container_2026-04-22
> 
> for you to fetch changes up to 4f47bd86cd84bd511afdeb59fc18994915eb13fa:
> 
> nullfs: support fuse systemd service mode (2026-04-22 16:08:25 -0700)
> 
> (Sorry for the slow reply, I'm at LinuxFest this weekend.  Hopefully you
> could construct the path to the 22 April version from the previous PR.)


No worries at all. Enjoy LinuxFest! I had taken the
"fuse-service-container" branch and HEAD points to the tag. Got
distracted by another issue anyway. Right now I'm trying to look at the
test failures from your branch, but github seems to be very slow.


Thanks,
Bernd
