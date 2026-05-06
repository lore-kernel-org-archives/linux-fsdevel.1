Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085A33128CA
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 May 2026 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102848; cv=none; b=X2Kq5fNvKo9uwj0KMJK31cEG+091dkrFO6AHwbl4bESrnPxcVo4GzGTiTFh72YlldefrY8zTwd9oXLDeARCYAnnnUWvFJnE3FEocfIT1vTl5zsKe7GvpcRro36Mc89VFCys6pX6MdRJ5slB87WGQ0/G5b/h/vO0ppvlwK2+6eTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102848; c=relaxed/simple;
	bh=x2qyDhGSExwelEJx56uGmAqs++59MajuevYUTDzB/1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXWw2BSj8e+vyK/IsILlj4+FPUnCvdBHV0qsZWX+6fgo3pHUWmvCT92+7OsO3MflRfe5TZx0J3C2L1rQi2giQl4S7G3la+J5fWOxa9f7qMnyiE88fg1Dq/8gCJoeuZnr0A6aOgwSODYqBPzQvSmUxRKl04rA0FKSk6QAIq5+l68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=DU/Sm14i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f6MG6/8e; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="DU/Sm14i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f6MG6/8e"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4DAE4EC02B3;
	Wed,  6 May 2026 17:27:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 06 May 2026 17:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778102845;
	 x=1778189245; bh=KAWBf/bloIFloicPBY0UwxsP1knrR1VI6gPl3F/3rT4=; b=
	DU/Sm14iNeI3lu8s9jZ5invA3oaDFn5BTnQ5pyVuxDWF3Jud2X13lQ3k2svOVWbL
	11xG2QA2CjUbODXFPD937aqIkaJo2DzbRXGo2vZhqjkQFx7zBr1vgG6w21qdAsd8
	UmCmFL3Q4MnftNQDsOA8onHu+3ZWpk+VhzIBjWZn8IW3KTKtdzNBKhSDFtsXYQ4v
	HcIc9dU3WJB0zA25LRxrYC1zkOVg/ierAC70vtsK5HHU6y1eEFQCwJizEANNRKqb
	JdGF7w4Cv0aXsIiEMN9tK3lmUUKEdVN+cOFKoBjbJkHwk/8GuFhZH/HvnlYMNyXu
	x+2LEh6JQX80J9JuSSordA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778102845; x=
	1778189245; bh=KAWBf/bloIFloicPBY0UwxsP1knrR1VI6gPl3F/3rT4=; b=f
	6MG6/8eK1Q7zh3OEiGYEHu3XR89+yyA8olrhc2mrIsWah0uFL4HwuvS5xKVWb5Zs
	6tOVuF10TyPgmYtOyfwGFps+KXcoOyJPuDiITCRaUe4uhAXcrt2yFU13WZOBe2t8
	lyVF4//0zx61kW6rx9YTA0EqjLW83iDAAbOCnRb+ALYD6BHUC17BSkyJyKRj+6mr
	sswMX5zrkqZ13JfVnJvyMLLiYJGtrFmKBl6WWGxtln60wdx3hZ2D9ohg6U4oHfbJ
	A3fm3tEkzrINgok6fhQ8T0gRAy2fxD8Umz2tKcKH/0dsK3j4PXmrmOaw9POAACB3
	eVnHR/lSd2av5YetGuy/A==
X-ME-Sender: <xms:PLL7aTyMo4WvbuEBtifnxHqsSCTI3i6R-HlmwQnvgARwVTqfM7yKCQ>
    <xme:PLL7aUkN3gk_Oe9f-6gonSZ5BRyK7b7sFGdwyDz-js-Ly_IaVoOkHX0_AnZ0Dp7gF
    gf8_URDR_cSuwoqikrZL9lTke0Y26o11OGST4Ugm1EqbuuntH9L>
X-ME-Received: <xmr:PLL7aUkNPadlg9Uye4E4lQ0Y-zDFA3M-giSjgFetrerru40R6iUSpjSjXhngG8BTAVFyC7oJ129rUpu8lAmGBsTzl9qkHUC0EB4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdehieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepfhhushgvqdguvghvvghlsehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvg
    guihdrhhhu
X-ME-Proxy: <xmx:PLL7aexcaivyN6gSxleJu8EzDbo2Vxr_WHgN3mkcU83fQBglE2eMbA>
    <xmx:PLL7aRoPXmvKAk-snGKX2CHBpCCUGbRSJSid6zhlk0v9B5cm2-eYvg>
    <xmx:PLL7aV7OY6-TtS27x2AsG5Feca2EjGzAEUQcUhcW_CZaxxuZTTaH1Q>
    <xmx:PLL7aQcu0wbA268zZNSTo9DY8yKDLqXNxTvjunRw5zmdROTcGzr_og>
    <xmx:PbL7aTKiiHl5S0DKiL7u5DXzc_GrNeXIaJwGP-6XmH7kbyX1D1xfdlOF>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 May 2026 17:27:21 -0400 (EDT)
Message-ID: <605ed94c-82f8-430f-b753-99b06eec27fa@bsbernd.com>
Date: Wed, 6 May 2026 23:27:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 2/2] libfuse: new mount service container fixes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
References: <20260505052133.GR7765@frogsfrogsfrogs>
 <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 07:23, Darrick J. Wong wrote:
> Hi all,
> 
> This is a collection of bug fixes and cppcheck cleanups for the new fuse
> service container code.
> 
> With a bit of luck, this should all go splendidly.
> Comments and questions are, as always, welcome.

Hi Darrick,

do you have by any chance a branch I could pull from? With PATCHSET 1 in
the same thread I don't know how to handle it with "b4 shazam".
Alternatively, I'm also open to learn new b4 or git am commands.

I will try to review it at airport or during the flight, but would
reallu help me, if I could just get the patches into a branch for
offline processing.

Thanks,
Bernd

> 
> --D
> ---
> Commits in this patchset:
>  * util/mount.fuse.c: loop in waitpid
>  * fuse_service: handle weird behavior during SCM_RIGHTS fd transfers
>  * examples: improve documentation of the new systemd service fuse servers
>  * example/single_file: sync backing fd when statx wants us to fsync
>  * example/single_file: fix ctime handling
>  * libfuse: fix cppcheck complaints about constifying pointers
>  * libfuse: fix cppcheck complaints about constifying pointers in user-visible ABI
>  * util: fix cppcheck complaints about constifying pointers
>  * fuser_conf: fix cppcheck complaints
>  * example: fix cppcheck complaints about constifying pointers
> ---
>  example/single_file.h   |    6 +++-
>  include/fuse_service.h  |   18 ++++++-----
>  example/service_hl.c    |   20 +++++++++++-
>  example/service_ll.c    |   20 +++++++++++-
>  example/single_file.c   |   31 ++++++++++++++++---
>  lib/fuse_service.c      |   76 ++++++++++++++++++++++++++++++++---------------
>  lib/fuse_service_stub.c |   17 ++++++-----
>  util/fuser_conf.c       |    9 +++---
>  util/fuservicemount.c   |    2 +
>  util/mount.fuse.c       |    4 ++
>  util/mount_service.c    |   68 ++++++++++++++++++++++--------------------
>  11 files changed, 183 insertions(+), 88 deletions(-)
> 

