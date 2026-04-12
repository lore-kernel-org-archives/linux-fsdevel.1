Received: from claranet-outbound-smtp01.uk.clara.net (claranet-outbound-smtp01.uk.clara.net [195.8.89.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA7282F20;
	Sun, 12 Apr 2026 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.8.89.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775988461; cv=none; b=p6VEcgDOsEXuMfSyUut/AkfogHao00V3itErolqcEi/s/Y8ioNaWPife8zwyxUwvOjN9KfIXxChr2mBt2wwpt0+fWojxoyWtzdlvq7BYCeVkFYYjA0ETKZlYjFxxj8ff2sTeoqlyx8wPdPcUzDgjTDFQINt51Ggv0Zh0GRY53IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775988461; c=relaxed/simple;
	bh=JVV6k/PnXHfZn+PFigqhNLak7Xgt8lw9892D90zcrk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-Id; b=JVomr07t2TgnlHf15hN26eLSM57d+MDYI++JgM9vZpueTDCcCX2HlJQpSZHNMj5sPXoC2wNAeAkTNNecT90SEjfiY37pUhG/pq1OYPkttqpUetXvpvs+08OhppBJjYGyOgkoGvGPkq3u1nYg3n0juEUe04S5//zc8qT9V37XyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=keehan.net; spf=pass smtp.mailfrom=keehan.net; arc=none smtp.client-ip=195.8.89.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=keehan.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=keehan.net
Received: from nmal-25-b2-v4wan-166098-cust2627.vm24.cable.virginm.net ([82.35.106.68]:41943 helo=localhost)
	by relay01.mail.eu.clara.net (relay.clara.net [81.171.239.31]:10465)
	with esmtpa (authdaemon_login:mike@keehan.net) id 1wBrRc-007Nho-4w 
	(return-path <mike@keehan.net>); Sun, 12 Apr 2026 09:49:33 +0000
Date: Sun, 12 Apr 2026 10:49:32 +0100
From: Mike Keehan <mike@keehan.net>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vfs: require verified birth date for file creation
In-Reply-To: <20260401-i-hope-someone-believes-this-is-real-04f24e03944e@brauner>
References: <20260401-i-hope-someone-believes-this-is-real-04f24e03944e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1wBrRc-007Nho-4w@relay01.mail.eu.clara.net>

On Wed,  1 Apr 2026 14:43:21 +0200
Christian Brauner <brauner@kernel.org> wrote:

> New regulation mandates that all digital content
> creation operations must be performed by verified adults. As file
> creation is the most fundamental content creation primitive in any
> operating system, the kernel must enforce age verification at the VFS
> layer.
>=20
> This patch introduces CONFIG_VFS_AGE_VERIFICATION which, when enabled,
> requires every process to register a valid birth date via
> prctl(PR_SET_BIRTHDATE) before being permitted to create files. The
> birth date is stored in struct task_struct and inherited across fork().
>=20
> ...

Sorry to be so late to reply.

Should we consider that mental competence versus age is a bell curve and add
a test for being past it, say 65?  (Yes, I'd fail that test. Err, what am I
doing here?? )

Mike
