Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83D37BE62
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260353; cv=none; b=VZv8g+wEXhNWd4osw6zxrcw3Km1HOe68Ng5o4jZx+S352logmVSdoj03J8UyoX+TNHcI683AmleO7iWWJ6Di7s4oAGMu0/Y4YuqkoeNMnGbNy/gOPalmeSo+gys+xQv223foI/SVnOJwlhJJ6GqVVxL9HAij/IiPsKMAsvyQbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260353; c=relaxed/simple;
	bh=frmOMZsL4Cy7rOtlD0ZsUyg+T4nxFKf8ZNdcUWYZZOM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iKk7MGibOOa5OAnWFKVgbxw258TCup146iALLi1uQNuFHR7KnL9glHNuT//fC1fh4Fb5AZeO5gzZzk2DVNY3zsVkCCveZ0ffozbSpKIha2NHgV5Qn29icylwfDxDEAd8tP8YRCQL8ibp6TG+2rPaXUi8/vdDsXOBTc0BKe2cHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=aBJ5f3Z1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=naZtQj/K; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="aBJ5f3Z1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="naZtQj/K"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38E4E14000A7;
	Fri,  8 May 2026 13:12:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 08 May 2026 13:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778260351;
	 x=1778346751; bh=frmOMZsL4Cy7rOtlD0ZsUyg+T4nxFKf8ZNdcUWYZZOM=; b=
	aBJ5f3Z1Xp+oWuiOJ2EHLU2WU0zPgbJMMG4VwwMrULBmgNU7Cr4fYpIcS03/+F/g
	jQ3CHCed2bfRZ+YtGgGP/Mq7Pbq15VuO3AK39EgcHH5ZKjDen90bg9AJd5UKRLKZ
	oeWaPrU0KCVU9L065XaHk4mrtakBB0ujfWpLoXVuXezICR8sUvA0Xv3aLJyrajog
	j37Pa05tThMcUfZYBJSgXvYNAfjR3Z/diOL+eTAEtb6eM9lrfp9Yu5qCfHpTFjIW
	TT2d4HYJGBu+YXVLI+27lGG7F5s1X+wzSG+7/ol/P4lDnmaINK24N0GTOrc/L6Y1
	7QdbPyupHPL4USbm7Xzljw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778260351; x=
	1778346751; bh=frmOMZsL4Cy7rOtlD0ZsUyg+T4nxFKf8ZNdcUWYZZOM=; b=n
	aZtQj/KXXp0u3ZZEGgK0ByFFbD1j2Rz2IHr2nw08y5uv1ec+c04UQR6xw0whRWkU
	t+pPf4S4H0mU8MZvXmeeL0XSgeIAr0k7ewsIqQ2nDlQpExFVY1/uBVmwCnnhosD6
	Z1oy69W64O6Skc+9wmhE9UayMzY4oYwfgvgCpbXUgEpabUSsM61UmJYL4AlJGBp2
	re9y6fwCCKRoPPZCG6vj44xxZwrpyFtwyuqWWeelpxmYCCY6PDGxML8/KyLkdT0p
	foGpWu9pHOKdKl736+hyFG0A6JRsqBsIkPCTFW62EvWaDVIeYViZ9ZJJhpIaI2l2
	SipBxFYnhaoeialThXx6A==
X-ME-Sender: <xms:fxn-acrlwOcFMbHDWOjvS1XFqvn1KyUkiYPXKRRqP0fima5YhC4R7w>
    <xme:fxn-ab_CuuEg8vC5WAx2FWoM0uDduxkmJ3nQ-anlwLQx14P7Jb5iO1ESaLOugdzhY
    AjW3Z9tN4bNPCLkHaTmxYhbEaSQjfSzXQDK8YDhnTJ8MHaOpaiU>
X-ME-Received: <xmr:fxn-aYdUBngXC8ekSRTJm26K29GORrnicYjsIg4j5pNXNeWcBOdLE-P52WVfLyjdO2U80Ei1Qgkwzjll0_XfPjPXaRv0Ii99_vf6y6XDtfWgkq4C8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffhvfevfhgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpefgtdduheetudejleeuieehffdugeejvefhkeevgffgkeeitefgffeiffei
    jeeujeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghr
    vgguihdrhhhupdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepfhhushgvqdguvghvvghlsehlihhsthhsrdhlihhnuhigrdguvghv
    pdhrtghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fxn-aVJmR1hSq0hAvPTiKoU50PR-5AgllKdrVCgSXEqKiCrFMCPJ9Q>
    <xmx:fxn-aYiz9DmJyWJXkRcC6BJznhLuTJv44dETTpIpCO-H3CmEDvLQiQ>
    <xmx:fxn-aTSlqvYOE-DGDtM-NwUkHmGbIszgTSVQNo2enEZ0JfWePositg>
    <xmx:fxn-aSXrSKbXdWmwgynqiR79qcByoReO1ZVnK3vGr7M1EWiIgvJ9QQ>
    <xmx:fxn-aR61itUtSSnZ-j42Rl9K7g1_B5T26Y_JmqcZ_JafIDi13hzxL-2q>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 13:12:30 -0400 (EDT)
Message-ID: <8c59846a-0e7e-4366-a8ec-206f5684284a@bsbernd.com>
Date: Fri, 8 May 2026 19:12:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 2/2] libfuse: new mount service container fixes
From: Bernd Schubert <bernd@bsbernd.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org
References: <177819198049.3490792.9243635053987314774.stgit@frogsfrogsfrogs>
 <11a04b4e-db8c-423e-a351-e7fd2a8bcc7a@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <11a04b4e-db8c-423e-a351-e7fd2a8bcc7a@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Darrick,

could you please also look into the CodeQL reports?

https://github.com/libfuse/libfuse/pull/1444#discussion_r3144133589


Thanks,
Bernd
