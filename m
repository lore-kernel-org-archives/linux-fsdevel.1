Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D514541A780;
	Tue,  7 Jul 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431070; cv=none; b=Gr+agnVvj067qeETP6uJSYw4mgunXXzdBrVGaVWpmfIlaXhH5hUezyT0TsDZkufcauRkZr/Fe/6p9YfJsPHqbMaKz7eN5ESDLsGqkysC391YmrsvLnDHQG/pPqHWFpbNXotcxkeBVP6iA0YhZrUrFdZlqDJcLp8FYrKrlnsadGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431070; c=relaxed/simple;
	bh=WmO80l1SD5HY7Unc+OCFlPoZSP52QxY3HF+7mu83FDE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=uDIOGcqzwOK8GgXxvYmClC4ohkaEnbpBHx92VFDodjE1Fq98J1K7yX9JMmpMZEX6+caZr5w3ttCcxN/ID1ejktbAYlSJdc5dPFljbFVFekmoLZZmcg2Xbc1k55c89tlofKpXFTDXGkvJVM8tBdvjAbzxDqGAi7Q8lr6XqF6z4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV0KJE74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV0KJE74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3434F1F000E9;
	Tue,  7 Jul 2026 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783431069;
	bh=Rby1RBiWqJnzk9mNnV+XrOGLTtOndBvCufIEfXFj6Sw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=XV0KJE7455Ss/udve5XmdFiBHyryqb4pYpuys6K1RJbAftKue1HBy+7e0yFj1Mxj7
	 W5HsaSuQOtK+s9ppSk6PYFP4no4hAyjO4kMxLLfOEx5UZVbXh72w76hUC2kZXYNUjx
	 gpqwGWstRSh+lWDyhuzS6owbbA0CgR3TcbzZJq7JDIcq7A0WgZtpxQLMNqDdUiBiPD
	 Kn3/dMWYDM9Wa93BVM1oasyqeST7yQ9/5H72uxkFaoWCJ7pG8EMk5hUmMaV3uMq2X0
	 VAbKmOM8tRLNcqCNkdKanhU2tDF5IY9G6kkT9CcFJTvleqmgyh7phNCHJaq8ywo4xJ
	 Ln8gj3LTKsA2g==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
From: Christian Brauner <brauner@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, 
 Jori Koolstra <jkoolstra@xs4all.nl>, Jeff Layton <jlayton@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <aleksa@amutable.com>, 
 NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <akznq3Tzkg3XbPAc@pedro-suse>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
 <akznq3Tzkg3XbPAc@pedro-suse>
Date: Tue, 07 Jul 2026 15:30:59 +0200
Message-Id: <20260707-latschen-positionieren-akkord-314a884b8868@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WmO80l1SD5HY7Unc+OCFlPoZSP52QxY3HF+7mu83FDE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5/J96+iVHcICVUHw271f/V6VCarODDfIvnph+i2OCa
 vvVE/rfO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbylJeR4erP5OMhFQxP3nnV
 cfx6Epkhl+9mUDT3T4f31GeL7DOl/BgZjtneLnkZt1C3Pbbu/qz/393crjkuzZv07sfMKXyny0r
 8GAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> > It's been years since O_DIRECTORY | O_CREAT has been made consistent
> > which means all LTS kernels have consistent behavior. We often make flag
> 
> This is not actually (as far as I can tell) correct. Your commit dates back
> to 6.4-rc1. Since then we've had 6.6, 6.12 and 6.18. However, we have 5.10,
> 5.15 and 6.1 which all should still have the old behavior
> (per https://kernel.dance/#43b450632676, that was only backported to 6.1).

We can backport the old fix fwiw because the behavior as is is just a bug.

> > I appreciate the concern but even if this were to fall flat then
> > worst-case we'd add a new flag and we'd still make that work. But I see
> > no reason to not try the semantically obvious thing and make
> > O_DIRECTORY | O_CREAT work.
> 
> For what it's worth, if the fugly test function moved you, I do see an easy way
> forward here with openat2(). Namely, openat2(O_CREAT | O_DIRECTORY) with
> mode S_IFDIR | 0777 could Just Work (and will unambiguously be rejected
> in old kernels with EINVAL). Of course it doesn't work with open() :=)
> 
> Hmm, if you could use openat2() as a way to simply feature-test for this,
> then suddenly open(O_CREAT | O_DIRECTORY) can also Just Work...

Feature testing has always been a pain that we forced onto userspace. I
think we should continue with that proud tradition.

