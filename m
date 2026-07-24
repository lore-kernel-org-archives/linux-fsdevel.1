Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE99418A54;
	Fri, 24 Jul 2026 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885588; cv=none; b=dZgQt4NIqr8fBgX5w4i82lCBKWH48BYYgNcgutGAAXZJTJ4XK/A+iA6y7zhlpkGrzhI3ad0c04VfdxGP4U55bQ/zMdPt5SjnoHr4a5rC3NoX8xjO0YZ0aICfwPQXadk21u1VcGgsBJbOoSPOrn7wud+L/7krEFVnSlm4bUpoweU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885588; c=relaxed/simple;
	bh=sjU1JC24b7l0ivU9UPlZbzZ3+CPk2FeV9WlFHV0oKCw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=lNGKeKBOUUBrO/CEi7QC4mLzznFpOaZtdJma+hoAIh0WGBFPn83E2AS+SdGf3T0sOxx05yQPsh/dvG2t+2q58PO7Z25jXns93r0ozwSYOZiEUKZift98waIWSBBe0trctrsaR4YrZgYyVZRvHUDHU1KChieYWnFC+hAYvQ/FvJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIGiig9O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIGiig9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3721F000E9;
	Fri, 24 Jul 2026 09:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784885587;
	bh=sjU1JC24b7l0ivU9UPlZbzZ3+CPk2FeV9WlFHV0oKCw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=hIGiig9O9RSE6pw9f9rIdJDeVCFSfNCTKJE5ppfuLz65AjExmWvoPRFkkVV/RAo5b
	 NstCDOJ27dT468tFZ5uGmJglnm9ROV/GnUil1CKiDnU8yx2xxLznU3bxlAh14PjZXy
	 +9/0lRuASaluaMAdbX8nakn3f61qAsEF8M6EeLoWF6qX12UELmLh48QHjusVudeATR
	 LrDR++ZG54ilqyDHeAvOUq/WkLDqDO3LD7LgT8OlfiqWe0jsoQu72FtU4Ms6zk21L5
	 f07qpinMvh5aONXIEdWNZoAVt1QKEJ3ASef2eH850v/BbpeUaRBfAA5dhaeb4Dz4dU
	 MqB4SoTezciGw==
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
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>, 
 Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <1713122837.215334.1784765444011@kpc.webmail.kpnmail.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
 <alS10NN_OduZEqvt@infradead.org>
 <20260722-mundpropaganda-vorwahl-funkverkehr-48efdde92a00@brauner>
 <amDBQN5lCGbRxGWm@infradead.org>
 <987276143.170754.1784726828216@kpc.webmail.kpnmail.nl>
 <178475745953.3371781.2895727677996716858@noble.neil.brown.name>
 <1713122837.215334.1784765444011@kpc.webmail.kpnmail.nl>
Date: Fri, 24 Jul 2026 11:33:01 +0200
Message-Id: <20260724-jazzband-benannt-bauzeit-08186a6e1986@brauner>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sjU1JC24b7l0ivU9UPlZbzZ3+CPk2FeV9WlFHV0oKCw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlG/ob1XWlnuertlgsbyT8qmKhSVbhhtaIE/wmYn8ch
 d4HrZ/YUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGf3owMTzRm9Ak3l53dcSHv
 IUdfPFNBXpGg18kIjZ6LKXXLrZ1OMTLc732o8jj9d+33arZvXd1/v8etfvExzjAgX5szvyLauJE
 DAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Anyway, it is up to Christian.

Please send a new version with support in openat() and openat2().
Fwiw, we have have not just a few examples of combinations that either
were ignored then became meaningful (that's something we shouldn't do)
but also were meaningful, then were rejected (something that's fine) and
then reused. Things I remember from direct or indirect involvement:

- CLONE_STOPPED -> CLONE_NEWCGROUP
- CLONE_PID -> CLONE_PIDFD
- O_TMPFILE -> __O_TMPFILE|O_DIRECTORY

I'm very happy to compromise on a lot of things - I think I've proven
that quite a lot in the past. But here we're deliberately crippling a
useful extension for userspace for a flag combination _I personally_
made return EINVAL years ago with the express reason stated in the
commit message to 43b450632676 ("open: return EINVAL for O_DIRECTORY |
O_CREAT"):

> So let's simply return EINVAL categorically for O_DIRECTORY | O_CREAT
> combinations. In addition to cleaning up the old bug this also opens up
> the possiblity to make that flag combination do something more intuitive
> in the future.

Thanks for the patience.

