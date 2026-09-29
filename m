Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98940F721;
	Tue, 29 Sep 2026 03:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790652585; cv=none; b=pIoTfG0G2Pv4Qo5bgiXP290efjuKDqQEqT2z0Nl2tNGGU1LeQCKBiz9Nw9pm8oxnyP/+KvLqxKxtJpRcAF3YZ8ht2UdHyd9aTfYxKiJxnemfQcw+doz8KWvQNXjo5Fax/RZP5xHOHKjBwdQ4BlAYXAcJeo89bgH6iC9/DnIl9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790652585; c=relaxed/simple;
	bh=7f8Aa5fo7eEpQYWHh5EnbL2cq+jY/fb/np0MlKfS5mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHP2dxo/i4zKyoGWuAuhnyq1hUbSVxiIxlR0JI1+I/uOsgA16oYfG3bKjiNy+/Scm6QjI2VMnqPQtIaGPUXGGT/7/RRBRXRU4B+X61N/i1Ccp/pRU0dXwqeHldva3OkQacc9jzrXZLP2B1b4s0E8k2sJuNiiIpB6B2J6KkYzx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=UQgOCDje; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x+dzQojf; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="UQgOCDje";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x+dzQojf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 44A4C1D00103;
	Mon, 28 Sep 2026 23:29:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 28 Sep 2026 23:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1790652583; x=1790738983; bh=9hJKAXpF2s
	LzODfI9vGGcsByD6WcWqX1LcRMl5/KGko=; b=UQgOCDjeZG4VJg5oVRejslHW4Y
	EyCZ9KYeN1C5EEVPoH4fnhzX28xuQv4A+hN2JJ0iGh4z3ZyO0nhpeJ0Rs0iyTfmu
	7KmapBGqkNmo+TwRRtBrDc/fQ3dwFolzdBh5oBHIUOmXlA9tZexiFLwsfq6nVfIS
	OvjqeMBF5TbqjXd9Gz8gwv3OnG9GbqZWAZvX09jDSds0VA2UM6Eox4mdEU+mhNfs
	KP23GlV2GJn5Uq140Y2+OBNgQkb0d3nlbtFVZ5ofszXRdmC8s1t8pGVvlgB1WAgn
	Ji/VVDkexCWjwpkLWXCUM+SyBKn7mYijbJeFEFTHRC0nWCmqsjBP6xMKyIKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790652583; x=1790738983; bh=9hJKAXpF2sLzODfI9vGGcsByD6Wc
	WqX1LcRMl5/KGko=; b=x+dzQojfVPAlXqYQJ5DnmOhG3zz5FyVgHs1//sG+ESR5
	wLem9SKQ08pfubwQ5KMFgpPhGqa8be1xFEMxZmWklEckWGJxRw+rraM4Uo7P1DFE
	VQTP0vc007Dy8Se7PTG1etkMvuowEnhkBHBiW4pfb48aCeYlOCjdDZnXuSCiSCPG
	+zxXiB5JJ5gMC18dvAcI6o+RMzfeArsKzyAgfWXyfC3dNGhPktt/ZBcBpEy9VsDp
	9/lkh76pHumwE4dOOYFtLHjxHtzRnHTr+xXuF8QjSscb3ZjpmM1yoQCzchLZhQmB
	iyXMX62/oL8bDylkVNHU1E8yx7e6oncTjBB8yTWl2g==
X-ME-Sender: <xms:pjC7ahMZ6v9izReFO24K7P3vcaQpDMcVDMYiwkA8vH7W6iLXStB0Fg>
    <xme:pjC7ao50RO4uuJwFAhsndEi-hKj5JeuuWPmVIBTVxWg8Cx8VjvUi_USvaxtvv8t4r
    eABtqSEzc54tABX4QnZoGL8-i8Fvvyg3EcDB3oGjRAvThigOPo>
X-ME-Received: <xmr:pjC7akhkRQwuBRWyV-amAfvCQRYyccIukiXkP_YfeSuE5J-Yo_4o4hG46g0Z4cQ-wAneXLuaUvTJpjBvJdRJ3hIuw8FBJ9I>
X-ME-Proxy-Cause: dmFkZTGOx/+Pvc5ych3eC+UU4wDR+ryhvnN5NAcpBNOGBHPYXabDq5OhbMpHIr5C9IfkR1
    lvqc1KgQ5z6ZtrHK1SfezsFnqLzd2zmx0B5tPTL0kgNl6/19majMbeGZPuZMJ+G8DxfADU
    dbP0gyawezda0oyLmKOSUFyKwEN7A+yRluSLoC4ICaVANsLb+gUOKg3D/u9y3ozLXD9s6I
    zxb3D6wilw6aguHY4sKXyW6gCoWn9nqeOrsF1vbqzEVnBSl+dUCiXjepnwG6NzieDN8ZjY
    OTw9WbOYGhdly37TfcVbrN13T4YY/pi+7GKAHqSIU3wv8I6KhUJbQIMZ2JLloHlgPoMrmt
    vh5Qp7gKQBfgYcdSZzUmi6fGW6gHcLPHLRJPcP+2xJKEdQT/0JwR82ByUwst84rt9itafQ
    4L7QfconP/9XB/Ch4bADMQafZ+Kuw53oCZj78JRlvc22YB0XgTUWlGg4AyIRdef9SyBxtP
    zF0fOJYuF8hBPblu2yj0SidOnHMzR+1BPm9msDrLl6JFFQ+eTS/8dpkjMoOs6blB3ed9jr
    GM0KlSLUDVaJT5PAWGcJh7QxViiIieeBErMVN6YPzXF1uSG89QSpPBuDUnHDJF5uzdFX9E
    jhlow0VPuhLdk1ZiZjk9tu3UmjQWBIOeZYMWlMcjbNRAvQ7wdP/92bsAv3kQ
X-ME-Proxy: <xmx:pjC7atcYpoXfAquGmy-SX1Pd_AMffrpgS3TsDVQxxQtFVFJkxP-cDw>
    <xmx:pjC7asy5REOJfyiIUKiQV9vnjJR4bqGPyzKNHazo2kHiMipAQZgfEA>
    <xmx:pjC7as1KDAsrkP34fdalfnT1eTNsxiExL3ILSPYhCZc4j6BMPKmvIw>
    <xmx:pjC7aixAEu763atouj7ItlkNJ70DvbkkmEVrm7zGSYWWOSsHbE42Ww>
    <xmx:pzC7ak23Z3Qlw_9mv69KZj6foxIAT3it_hAGDyp_qwuD23cBhZowMbbl>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 23:29:39 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fuse: prepare for VFS locking changes.
Date: Tue, 29 Sep 2026 13:26:14 +1000
Message-ID: <20260929032927.1451259-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am working on changes to directory locking.  The medium term goal is
to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
can be run unlocked, and consequently cannot be called when ->i_rwsem is
held.

The requires:
 1/ the d_alloc_parallel() not be called while i_rwsem is held.  fuse
    does this when priming the dcache from readdir results.  A new
    interface d_alloc_trylock() is now available and can be used
    instead.

 2/ a dentry must not be d_drop()ed while an operation is ongoing, as an
    unlocked d_alloc_parallel() would then be able to create a new
    dentry with the same name. Now that d_splice_alias() is able to
    splice a hashed alias, create_new_entry() doesn't need to d_drop()
    any more

The patches depend on patches recently added to the vfs tree.  I would
prefer these land in that tree too with an Acked-by or similar from fuse
maintainers.

Thanks,
NeilBrown


 [PATCH 1/2] fuse: don't d_drop() before d_splice_alias()
 [PATCH 2/2] fuse: Use d_alloc_trylock() in fuse_direntplus_link()
