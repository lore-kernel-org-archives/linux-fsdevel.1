Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6A2288D5;
	Tue, 23 Jun 2026 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209088; cv=none; b=tUityigofCufyKsw7cm+4rxQDvB0BeKKvqdKywNPlGUSIQKBBSe7lg9h60Urq4WKbPvSs6QlfMr3v4IadL2Td9QLWmcAixbGAZOaFEkwHbUZbj7so1rmVooOtkhFDOKziZWsrcp5gdE3N1ft38u8dqyLKAnwNdfD4HEzS9DpUbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209088; c=relaxed/simple;
	bh=LhicTvQG3rBuY/4XUlOWnsKngw5nyjME+Ra34lr+tWA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DyfJVlzWUAfKbAN0y+zuylY1Tu+lomeadZnrAX8W2/G4LdfOlbOgfrhYHRLIpYqYhNBq5co+qr/cxwqjONc5CVJ0cpq/btq7aIT0Kh6GBTeEh/ciq9OuJWB/aafQXdJCNAbGj+jiM4a3l0KW9t2Zcc7aT3blg0S3/IKRlE+FaNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ud69vIUM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ud69vIUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC2A1F000E9;
	Tue, 23 Jun 2026 10:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782209087;
	bh=cd1JUWEWry+Bw3Ln84DVOD3bF1pJkMxaHLBpHRjgYpc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Ud69vIUMxZShdEcq4rg2pboZ8gsAUmSLecJV1R0Yw8dzGfw4sfhkqlDUPuMUQALkX
	 0dlcxg0OMaG+nIAHV+n+PDboMwnkCJJZjet/FJJPJ3ED9B3u+WVx8Ef1RpT1uBefCq
	 VFgbwtx3jQmJ9IZtzUtGN4WrYIaICEJt2MxnS9giN6MpFOFCeX3TBtuvafoKFeUIO+
	 5Y/CrEzjnmAQwpCbc3xua3lLDAxKrG1HFgEcHs+vdubzFjPO7iqtffaO1/mTkGIb3o
	 yWOziEnbkVDc5v5gsr6WJoUZTZ0YUykzfCdqkY1ALXPHahWPAx6yafAiqA4NPup7zE
	 LPkD5/Nk9pH7g==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>, 
 Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
In-Reply-To: <CA+0ovChveuAwv=t15dr2m09E32bM48hHJxvfeEYZOhdNiEc9Tw@mail.gmail.com>
References: <CA+0ovChveuAwv=t15dr2m09E32bM48hHJxvfeEYZOhdNiEc9Tw@mail.gmail.com>
Subject: Re: [PATCH v2] freevxfs: don't BUG() on unknown typed-extent type
Message-Id: <20260623-anbot-kanon-imitieren-fea40d9418fd@brauner>
Date: Tue, 23 Jun 2026 12:04:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-df257
X-Developer-Signature: v=1; a=openpgp-sha256; l=876; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LhicTvQG3rBuY/4XUlOWnsKngw5nyjME+Ra34lr+tWA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRZRdnWHe6pVPJ91dK066vHRUu2q49XXIq1VFshm8A9y
 2N9xyPnjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImEsDAybGGIn3Mi+GrB0siV
 cRFGbz9eMZM0ELu49vw+YfGc83cVWhj+Z81b7TBJwWbOU9Edwlcvxc90q1EWmpiq6aurGLBr+p8
 qdgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 01 Jun 2026 20:10:08 -0700, Farhad Alemi wrote:
> freevxfs: don't BUG() on unknown typed-extent type

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

[1/1] freevxfs: don't BUG() on unknown typed-extent type
      https://git.kernel.org/vfs/vfs/c/f2f1b6ebe857

