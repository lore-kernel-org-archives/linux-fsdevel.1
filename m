Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BFF377EA1
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355128; cv=none; b=KFI/Y1MJlw0ntrdRTUQV7JayOeW7FWYT+zYpnr8m34ue1BFEavFkozIEz++eLL+AtDYQEbtLnmHWIYGivXk/HoBXYZW6IoGocgE4Y63NX0qb5zj7dtP543btY0n8v0RXMd2XMaaSm75vwiD+trfPYZWq+6djvGxdquVcHzkhxRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355128; c=relaxed/simple;
	bh=OngPMQkfo3ei1/VP9NszoGptuPyt2v5m/e4/k2jjxbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHpeqzL3rcE237U1aorOSNPVwhP+6hUqxSWbiwNqd1Flq9DUWGA0nw91UzCDSmp1g117eXv9Nj2VKqDLDAI6ZvDs/dcLDEcpnBU0LUc132yCHm194a5kRZKku1k5yFLf6Wd0h0gVe3ZX4AYlwLRXHQEM3CMnaM3D/yaEgkq9C+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=ZS8vQ3br; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EGZ3W+dd; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="ZS8vQ3br";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EGZ3W+dd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5BBAC1D00050;
	Thu, 21 May 2026 05:18:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 05:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779355125;
	 x=1779441525; bh=6JSTUGbU0EQbmrZZLTGRFVjV4A9LwG+ds5dNjSSCmkY=; b=
	ZS8vQ3brph8R09KZ21wOjHXNN3WDS/ph/2csA83iyRLH0iBtuCtIez5Zqt7b/rTf
	YtOI1O5o+I9opSv62LpKNcGTAHRyGStexceOlN20UtEBrpgu4X2nT6IoFyvDDbzW
	tCudJsgpxeKzi8xR/IqW7lGBLx02Cn7yErMlXDQNfTsjeP5CdIHy/bAYcTQbr+bq
	qwMxAYK7x1M6U/6htvR1RrETZRgzDUC4qYHUjX8a6LOVPUw4wBdBYdxVSxR/MeMX
	uIBhcr0DhCiZZHF3ElCKjJf5dEiJmmWtwaMCNe7hDvHUsDaBkaeh/KzgqXNHmS0R
	Zlgni8OMF+jnok7O7A5vSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779355125; x=
	1779441525; bh=6JSTUGbU0EQbmrZZLTGRFVjV4A9LwG+ds5dNjSSCmkY=; b=E
	GZ3W+dd79U5bTnQSMqGN1jBKP4F4xAIPEq0WSSPWVJOgLDkmfj9qrq3NgWKNvzIW
	RuIg0EvEvmd0EkMMPVpdtv1C998nYPBO3zEbJD6JOc7Osc4octMwaXLz3KyMJfj/
	zNtMlXBIMWV2weGs8OQuIrvhfhs7WfVxieTNAiiFphkW8cktxRIso+64Q3OT3DU7
	IENWj+VBpQHc4zKI1MB/8MnHawoWePLbCghteWsLYr8U7LeToaciZCUusangJpWA
	At1H3INHPU6kgTyRVaY46hDDNx5YG4jizDFzbCZCKPq57KFOKGFZCaKYyxri7Oyt
	VmMGDydocDs8HbZsYnvpA==
X-ME-Sender: <xms:9M0OauyEkDgunsFj6FtdsbEPsnAEVogSVqah8d14qIdqC87Kte2A4g>
    <xme:9M0OajkQcgI7l8YE2ZFcYIDEyu9FybyIk57deiBVdHv6SSTkHcnYZghOdavbtX2Ph
    O6OtKH0H8AYEK0ce-qQRSjkVkvdvtpC1pUF0hnCAOj2wogldYor>
X-ME-Received: <xmr:9M0OanntJU4rR9V4aQMoSQ1ics28rA8IeDAkQ3LjC2RXWJpAYPO1nDm0VRJEw99RPx9cTT42f72yVtaZJ6H5-YRxJ4Lb3fMw5ma-7vPQdGKiIyGmNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeejgfeljeeuffehhfeukedvudfhteethedtheefjefhveduteehhfdttedv
    keekveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfuhhsvgdquggvvhgvlhes
    lhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhngh
    esghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughird
    hhuhdprhgtphhtthhopehnvggrlhesghhomhhprgdruggvvh
X-ME-Proxy: <xmx:9M0OalzxPMKS857R6NvXjo8IgLlEA7vA480iPG61-yy9hNmYKpad1g>
    <xmx:9c0Oasrio8ut96ombZEYkwK3Quya8QtCg-JjYu3UKLjV9-KPxx6q4A>
    <xmx:9c0Oak4Qjy_v9WtC7JaiRIZJmMGp3hc_mKfXraPe4hL4-4stzzagRA>
    <xmx:9c0Oajfhu1-r7zCGmU48CoCWttVpU8VRnOn5d6to1rG8uEwhgOzyyw>
    <xmx:9c0OaqBX93D7K8fbw5cHZvSkLgxkcI9JdUKW0e9WfL0Gq_pt3B0DLoWX>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 05:18:44 -0400 (EDT)
Message-ID: <24f4f09e-be03-4743-8732-21631c01cedf@bsbernd.com>
Date: Thu, 21 May 2026 11:18:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] libfuse: new mount service container fixes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fuse-devel@lists.linux.dev, joannelkoong@gmail.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
References: <177933241816.3536811.12585235323301633919.stg-ugh@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <177933241816.3536811.12585235323301633919.stg-ugh@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/26 05:07, Darrick J. Wong wrote:
> Hi Bernd,
> 
> Please pull this branch with changes for bsbernd/fuse-service-container.
> 
> As usual, I did a test-merge with the main upstream branch as of a few
> minutes ago, and didn't see any conflicts.  Please let me know if you
> encounter any problems.
> 
> --D
> 
> The following changes since commit 93892e469ddb9f5bd3b0923d95410a9d5dba65f7:
> 
> libfuse: fix cppcheck warnings in the new mount service code (2026-05-19 15:04:54 -0700)
> 
> are available in the Git repository at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container-fixes_2026-05-20
> 
> for you to fetch changes up to cc9f7792afe2cb3df4c5cc71ab2ff5ba270acd8d:
> 
> fuse_service: fix uninitialized variable (2026-05-20 19:57:57 -0700)
> 
> ----------------------------------------------------------------
> libfuse: new mount service container fixes [01/12]
> 
> This is a collection of bug fixes, codechecker, cppcheck cleanups for
> the new fuse service container code.
> 
> With a bit of luck, this should all go splendidly.

Thanks for all the updates!
Before I can merge, there are still cppcheck warnings, had forwarded the
mail I got from the tests.


Thanks,
Bernd
