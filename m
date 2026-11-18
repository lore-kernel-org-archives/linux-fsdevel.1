Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795008783;
	b=GRCtns2W74IPf9ducb0Sc9l3A+v2KdQDw4oxJ0T5/gFfeQkrAd0cwaxm+u/aMDDypHdA
	 LU9/9dhfDcFPM5xEVNIaQr5cZcfEl+4abyt4gvTxU/TIBwVvRuk+eTk9SwEJTrwGUcAcX
	 GxGmz/CGNIwVdydLvZHV6w+Br47/axQ5KpcNnOLCOaIJtU19dvuKDqgF4oBeSUff0KSYl
	 RqJA5Hm/gwysPS+wFfG94hN1tCRoXb70pRmzFjOeig2e/K9tfhy/Of4EW+2jSTQTZRbeV
	 FVD4bzjzT3KYMtbOOPAK6huen6actTqNdOY2B9KEYUYGEeuD7d8eSaYIiFjbLmeHTcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008783;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=+LzKfkpJBe8FV8Ilo/QVOQitYmQkxIW2qNl9LG+xUfA=;
	b=jG/iuc6uHhGlRh1D+hIMJIvHs42M7xEXYp/I7RUql9FBS6KJ+Ap5DvfnD8LWvYP3e67/
	 N06RZ3SLODzXfLRByMeyoqcsmppPA6uIVA9RL+hbd3CiGTRHnke9W6u/62GibSAtBZ85I
	 wQ9Y1u4vhyp1oL12g4un6UnZWBQ5IUicnjzj7FqWUo085251CiXlxsaqL+FQ8A6mlH4HV
	 mA7VfO6qQd3kqHtPFrO3mUEp/zSZWLFzs/JyEc+HRVC8f3FRx7/lSauXELTkHYhdqGXCb
	 6NC6Cw0Lh0D14f3KbQfbOHQSltThVxExCt1q4V0IaehK1V8YUJt4UIUG3ROWNwoQvbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKhtM6TW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7644606A320;
	Wed, 18 Nov 2026 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKhtM6TW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A671F000C4;
	Wed, 18 Nov 2026 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795008783;
	bh=+LzKfkpJBe8FV8Ilo/QVOQitYmQkxIW2qNl9LG+xUfA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QKhtM6TWxMnfqOEzL0JS0sue+b+WN2v4+QMgoGmtl6vIGT/qoOsV4yCDswDkoxzrQ
	 y1ZoE6cCiHldZ4sDXj+jnvKcwLZzyUZLDpZPYhaEf/WqkX1pR1iBExymjqL0JteINQ
	 xdoJL+tp4LFE6aA048rmL2orp5XebHSgPYlTmKbayW4NLlEqLFe60p6Jkm6TMZWDxO
	 xZzrqVXmH/v3AqNURK99igD63LWz896gHeZg4XhUCIX8iTrIm8j9ekQ8vpWFeo+V5+
	 rzZWqo40/twBl3N4u7PrhohI3CTApt3PAEMr06qi7UZ1TyzJqWPatPyEskTDbqjYtQ
	 Y56w3LuZUP7Eg==
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Hristos Nenkov <nenkov2004@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Seth Forshee <sforshee@kernel.org>, 
 Lakshita Jain <lakshita.jain@databricks.com>, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, regressions@lists.linux.dev
In-Reply-To: <CAO7_G+xaooz=gYyO5kw3Qbz+1MF=TUD-XQpAy33ETSX2xBVQ-w@mail.gmail.com>
References: <CAO7_G+xaooz=gYyO5kw3Qbz+1MF=TUD-XQpAy33ETSX2xBVQ-w@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: preserve daemon-owned ACL permission
 decisions
Message-Id: <20261118-tiefpunkt-revidieren-mitreden-bb6926db02ae@brauner>
Date: Wed, 18 Nov 2026 14:32:58 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-04696

On Tue, 17 Nov 2026 08:31:47 -0600, Hristos Nenkov wrote:
> FUSE daemons without default_permissions historically handled POSIX ACL
> ownership decisions themselves. The generic ACL owner check prevents
> non-owner ACL changes from reaching these daemons.
> 
> Add IOP_SET_ACL_OWNER_CHECK so a filesystem can perform the owner check
> in ->set_acl(). Set it on FUSE inodes and check ownership in fuse_set_acl()
> when default_permissions is enabled. FUSE_POSIX_ACL also enables
> default_permissions, so it needs no separate check.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fuse: preserve daemon-owned ACL permission decisions
      https://git.kernel.org/vfs/vfs/c/830f05167ee7

