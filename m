Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2818244667
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070352; cv=none; b=Ix6ShKXciFb3WtQYwVV9OfKJU2h4mj+QA4ChzVA5j7ilJKUcbLsSCTLsK5GQQ/Ke/WtG4rgm8rhEq2KpMkYSE4LOIKiOfs0tUVRyogAIVqbcxAefYtn3niFhcFDIEIyoJCXmU/meFw9bXD0Jx1d3ajcdno4pElrg9mtrN0K67vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070352; c=relaxed/simple;
	bh=kH/trLyDnlEZiMiVFlxNIPHAiJCG4OGm3XrKhQtnjNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dVfTFDm5KGDbpL93Pw8OSAE5wFwqc0JT00rZgqyw/wOg6I6T9X925YuMHVLJ+oNF7c8V1D5rtQJV9TolZONDyi9zdM8zoDZj1QKTFDQaM2zlG0N9+GV9sHkYcda4NSdX42IHG1+ZL/xHzy/7rrR4nddN7iVMC5d2+fdFsnk8Q+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=XgFKtWAd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LCiQalG4; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="XgFKtWAd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LCiQalG4"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D1791D0017D;
	Tue, 14 Jul 2026 19:05:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 14 Jul 2026 19:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1784070346; x=1784156746; bh=kH/trLyDnl
	EZiMiVFlxNIPHAiJCG4OGm3XrKhQtnjNk=; b=XgFKtWAdOeX4r/uSSJzLwZMl9c
	cJ9Ty0UdGE2GOM7nFU4/WRvY1ReYpvzHzBhxVI5yYqpvx2DdDdFCetDsf2uvhBy/
	GQj47v25x0HDD1aNhEjveZi94E1SxxbqOzG4oKNWTqUZ0Ejt/uJmCBIHiv/Ex5uD
	jDQdaFYes86iWkn0MaWLcJOXCxj9R8CFQLtdfHDGbD/BM3qWAKeneu/PCV459m8j
	vWz9rdbPpgoufbkaT0PnCqj81f6AgxJC7JvKZk7StZxPAj/Y/E+auYIM3akWqr1b
	vcn3XAUX5qHW4H/Kh5SjBLjZP8vN7/QMbdit7oyFseePtGv6KG2qd5u/rQkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784070346; x=1784156746; bh=kH/trLyDnlEZiMiVFlxNIPHAiJCG
	4OGm3XrKhQtnjNk=; b=LCiQalG4eInshAsZlKxpSrnYuTe1WR9YjDWtiMroXeJV
	z83jFGO/cOjqNirhBreaBUDb4DHGoLwxznb+qqr1akKqfcyt1tXx9MF0S1iak8Yi
	YwCqJRsCbwvtjd3lfMKxUfniuoUmM0puEtsiFPByN1HgNKpw+DTq8/CExAravnvz
	xR7PchcmgqHibt28YLLfYekWO1pzTtdf1rOKV5j0CSPG4i4ZSsZeOoYiSMdFjOEV
	0eeghbmv6J3G52jMN1REmUQdJRKvNZGh2+s5v7ub4Guz3fn55Srvjl/w25cpELSR
	mUbh/bZeXtkD4PCtv/rAXAayHXCi0CcpPFQKn2sOAg==
X-ME-Sender: <xms:ycBWahhIwWuR-WkHbSF7icgwvMaGGjNx64c-keBv8HPnWaWNeQjw8A>
    <xme:ycBWau-bLdIsyY1bcqMOJo8ny85PfD2fQ5Q84DbOa9nEvYocwJw0zXMCk9KaW8d0X
    gFGnQdw2SkQhO8Q-JFUPUH_ts1CgqMEgfXrKzF8pLi6TkQq7Q>
X-ME-Received: <xmr:ycBWaspmEdDOwHvpxVNwIszzr3IA5P8W7r_ogUj9k6l5feHjUW80ngLGE-SQm2XJ1anWGAyoSHxJqoOpc3w9MLGW5lMNYx8>
X-ME-Proxy-Cause: dmFkZTFqDGIC4xmIOezFrV51Lb6BZo5Pyq0qYSbqiM+4qapHVSAjcxYrJnzCtPlgcKQnpf
    ITonCLZBJbVqE44cx5lN0omlz0HsBUo9ztDT7nYIshNmh0kAI8AJ3s8PGwfLyXb+8aawa0
    d0sG7wKPtLHDjp2FvdKS3oD74xLmflHpf+Rj6kp9dxaSayDTTiAHebZfU7zkuO91nmkSo3
    eLm3OXQFD12Xb/aPenM3kKDa2673Sejlchrm2I4AXc7PUl7HlKeu0HX/8AWRRDFcdCLJaC
    DA8MPNNb04WNmlENpehYTfxKX6Mhl8a+bk5t5sxsw7jv4EAlpUQGNHS9fM7rsSsYhRX2OH
    6wxwrZTg4XcE30IeFYtl8Bzef/t2LK3pnFHwYaTFMxEtzbG6yP12n2B9IsRBn1S5PlmTfE
    wD6f3v/LJkOkvAAy7w7ynlyMbMo/DponjTJgUs5U+SNh3sy3ZOIln+7VJu/kkzWs1cG90k
    yEEO6mwXaD6/lJqhLXz96rwpPJg/Vsa4dDaC2wcswk5H28ZUCPRN42JWSswhxjc0V4O/Jr
    PquIBcWKr39hKPgdYOQED9AoiGJzi+yU+0mir1eJBw3MjmRbsh9EVFIbz+FzgFKgwYKApS
    X3YR7EwoLXan4aemTbOpd92eASHu09bju24Qw0wu6RPATusUKo09FZbfYzjA
X-ME-Proxy: <xmx:ycBWamWBax-TxuTb9Ck4n4CkKygO8XrE1dTXQRH6JzDxLicvoLaqGw>
    <xmx:ycBWarAw5h5F0fwlwB7JNkbLO8-JWqzifLBTWY1aLqdo4xo2IHvIDw>
    <xmx:ycBWaq1K7l0p3Yg8_eKiagNjmts2IC5Fau1xUPmQVkqNEDKdASNAlg>
    <xmx:ycBWat0If1n0Kz6fk-bcJAzksSJRgzJh150dDxIAbbL31Htk6Hjr3A>
    <xmx:ysBWarfFK352TqbzsOzaDaOvqTQ4cRpDOlmdEp8q-x6K8f8z7s0nIUsu>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 19:05:43 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v4 0/3] VFS: refactor lookup_open and add vfs_lookup()
Date: Wed, 15 Jul 2026 09:04:11 +1000
Message-ID: <20260714230534.776886-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v4 add a WARNING for unsupported O_ flags, and fixes some
documentation typos.

Thanks,
NeilBrown

 [PATCH v4 1/3] VFS: move mnt_want_write() and locking into
 [PATCH v4 2/3] VFS: move delegated_inode retry loop into
 [PATCH v4 3/3] VFS: add vfs_lookup_open() for nfsd
