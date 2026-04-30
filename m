Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70260345740;
	Thu, 30 Apr 2026 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518594; cv=none; b=Qolqfqq0+/0E/eFPr4I7dXZPNSdB17dYVAaDUmXdPHCuez1Os26sT9kM9Urp4zz92RuN8kJQNMzqkkAF7lZ4qeWNiyi/xNhObkdOrZxBm+LM/rTxoslV5nz1X/qRa43dZoVKgaCkI9mM3ZVLEF32U7l4gPhFzS0QjHH5M+J89F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518594; c=relaxed/simple;
	bh=yqFj5Zsm7tkd8nS/dzRw+B43QS+NhBr34s3sY4hRmJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uEztRZ8T1OpBrjEMd2zOh42hWH9JyWsJ9MvK+1wYnanm6EKVyaAqHPrpgsjIqlH5uzJouv4zIl+x2xzHbyXjhS0ZSZcAymDrxETxE3le8TcXOszgG7meuS7+C1kKQQyM+2+RKZ7sEwOoipnpZwBduGuyo/2pe8yyEIEzt6gT+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hQ8ocWme; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KlC5NOh8; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hQ8ocWme";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KlC5NOh8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A50807A00F5;
	Wed, 29 Apr 2026 23:09:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 29 Apr 2026 23:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1777518592; x=1777604992; bh=8hpUWEbKtG
	UpCSVbycD7XwuisKq/8JyiwqIbYefkOMs=; b=hQ8ocWmexk/PIKrwF888DLA5B6
	wZbuYuOZDwazhA3mD/gN6FgAmMx4gmZjHTt5th5zEuw9Cw4ttMLzPaMK1M4EURok
	T8BzXl4Z464g850k42T/9/qyWlp22o5jJpXYV0aLco7vctelg9ziqQB1/9FP9kKZ
	LSoS6rFs/zQCjDPNSZHLMGzbF9F5K3v4v8n8XdJGlTjGeJgM0HyNK1wbTZwYD5ZL
	D01A8HoZ3jA5hhI35zEJt6Csr1uPPML0D42tQmUYq9gg1k03wgQeuqXQO2FnUIA/
	I2N0tvvt/J0BltlBoHy2ONVvBfCAcqRxK6Fm+UdMJtpdZq+GJzaTPrU6uS0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1777518592; x=1777604992; bh=8hpUWEbKtGUpCSVbycD7XwuisKq/
	8JyiwqIbYefkOMs=; b=KlC5NOh8G3jJZuY3GDxQR4OUmo3SWP739IvsrhdLly5n
	NC5ArTsUe2otKwGDh0eUI5tCiLSndPcIzHhao/wTcvrKtWh20NZCXl2Wj6SSfQ3l
	VPxMV1gZa+/1PttI6lar3ucdZl8U/RoRpTper2NejS7Ni+xY3WncI5pMq6+1kCbP
	oKMkf+lMihG1zKXkDlsphWKNOesOUSAGl6QzwiTrdxNxRcsOUXwsIovabY7S/iPH
	vyKThoTToBOzwdH8Ene+GpVK1RmOTSgExK6J+o3biYWIbvWT1M+H0cj8A8ku2kmt
	Pskutx+aMq/bZ1WumduBWxtxzup0oHPtLz2YmWZB3Q==
X-ME-Sender: <xms:AMjyaW7tPHIz-l5O1sM-YcpwY8rVuLtKbgXXiVt0b-qCmiz8EMpoaQ>
    <xme:AMjyaSfMXdm8rYDKU9rPEiR9d67gr7sT5wXNGGnaGjQj6w4kdSFmafv5GDawB0HMS
    Yd5k3O9gC4bK63Uzg3hdIRABFSgu9VJOfKvsrS1i3yZvxoCCA>
X-ME-Received: <xmr:AMjyaZHLbF8UCeFtjG3pCxlvIbQfM-3OzHyN1UNLIPn4H0InJ3gMoOe8VQ9mEn6xZF25J9Eg4RIKlic2QwULwWpLUTPmchs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekiedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkfforhgggfestdekredtredttdenucfhrhhomheppfgvihhluehrohif
    nhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeegte
    efgedttddviefggeeuveefleellefgjeeufeeukedtleeiieekvedtleevleenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofi
    hnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgushes
    lhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:AMjyaTSob9XIRyhAm0FQX21SGsFvJxJ4SnAnO9nw9MKIa9nKOZahlg>
    <xmx:AMjyafaFGdtPyT2HJtPFFDAaefGMi7opUCMAkihhgHBPpJX3UQYA_w>
    <xmx:AMjyae3DohzEsvGfWrdBVSOZ6VUlGOTOhw2RWPz65l84E6qs7bUeSg>
    <xmx:AMjyaSpW11q_JLBhBPJlnET-oS808HNssrIbWrKIN6-rv57oYeXcog>
    <xmx:AMjyaUBT5VlrWxF1w4LWSvruV2Ur8DseJYXPrY8ACUK9pk64G94KNuS7>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 23:09:49 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7]] VFS: Prepare to lift lookup out of exclusive lock for directory ops
Date: Thu, 30 Apr 2026 12:03:21 +1000
Message-ID: <20260430020505.3308841-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following are 7 VFS patches which modify or introduce APIs that will
allow modifying filesystems so that they will work with a proposed
change to move d_alloc_paralle() out from the parent i_rw_sem lock.

If these can land in a non-rebasing tree, I can work with individual
filesystem maintainers to start using these APIs.

I haven't included d_alloc_noblock_return() as it is only needed for one
fs (ovl) and it is not yet clear that it is the best approach.

I also haven't included the change to d_alloc_name() as that is only
needed so that I can deprecate d_alloc() and there is no rush for that.

Patch 2/7 is exactly the patch Al proposed in the conversation for v3.
I have taken the libery of adding a Signed-off-by from Al to match the
Co-developed-by.  I hope that was not inappropriate.

I have been testing this series over NFS mounts from XFS so patches 2
and 3 don't seem to be causing any problems.  The changes in 4/5/6/7
won't be tested by this, and some cannot be tested until filesystems
start using new interfaces.

Thanks,
NeilBrown


 [PATCH v4 1/7] VFS: fix various typos in documentation for
 [PATCH v4 2/7] VFS: use wait_var_event for waiting in
 [PATCH v4 3/7] VFS: enhance d_splice_alias() to handle in-lookup
 [PATCH v4 4/7] VFS: introduce d_alloc_noblock()
 [PATCH v4 5/7] VFS: add d_duplicate()
 [PATCH v4 6/7] VFS: Add LOOKUP_SHARED flag.
 [PATCH v4 7/7] VFS/xfs/ntfs: drop parent lock across
