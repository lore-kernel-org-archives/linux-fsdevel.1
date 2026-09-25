Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DFC36074F;
	Fri, 25 Sep 2026 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347494; cv=none; b=fPBQQtmd1jXpZQnFMlpPt0+oYr4R7lShpitL9sJZKQmEQa1cNhKLr1DqsIR2kz5Fz7t8Tay/blpPORqlEtVAieVUOCgPHnBhUtfffTDn4bk/Iq4SdqK/590D9N9DCGcQPd4d2QfuLjNS8RWf5j+0R0PRn6WOjdhfZWIAVQLg2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347494; c=relaxed/simple;
	bh=StPgB+My1OQ46FWMvus4kzwtATn/TK0NXZnXKwLzw7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lYGFSRf/QfABv4M1N2kB2hQ5cQp571QO5TAcLrUmIsoZ+I92qhc4zkOlo+WC148bsWDDGK3a3X840dIU00NTXd1sDG62n0dQd4QjDPF8f56RoAev8g0QbKS2ijtMMVY+iCXVWpeeddIkKx5jIDJdVNxBzNqXW+0ADMtAPs4hXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHL+fmAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHL+fmAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89771F000FF;
	Fri, 25 Sep 2026 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790347490;
	bh=RKe/Yts2FNdE3d486qCBER5F42PYotV+U0PNBCFOC+w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=EHL+fmAzl52Ct4tCCsYHxoWHGv3XZl7j8+YhPYevy9yXoKazbZsjiyFdL29TkD4SG
	 wy1ITsAcMLSn+Khz/hS9RobPWxFqzkqo8fOkxocZIGWJXwNM9l46qy88WzTQpYH+r3
	 E2+BJXJC1MGP4EEr5HNTBp16vVteAuK6slYHAGkDXPVpRdLiO06ji2IxgXj9fEHs/y
	 xRUDfRzNDufoIuHUkMuL1UbQhjpzxeGB1abIHWrzgIzMvCsMsI8HivcyVty2bIOnrh
	 9PHfFF8rJEtPt3jMR3uIwFdvl+mzH8cvOVrtG7p1xJRuHm8R65q89dIqH3v+F50th2
	 odG1WfYR5uZww==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Breno Leitao <leitao@debian.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, mjguzik@gmail.com, oleg@redhat.com
In-Reply-To: <20260916-pipe-resize-poll-key-v1-1-0f8f04f7dd5e@debian.org>
References: <20260916-pipe-resize-poll-key-v1-1-0f8f04f7dd5e@debian.org>
Subject: Re: [PATCH] pipe: pass a poll key when waking writers after a
 resize
Message-Id: <20260925-gepocht-notation-zwitschern-95e9f3e54443@brauner>
Date: Fri, 25 Sep 2026 16:44:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=brauner@kernel.org;
 h=from:subject:message-id; bh=StPgB+My1OQ46FWMvus4kzwtATn/TK0NXZnXKwLzw7M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRt67iXWTvZbYtwQHNRRb3+5EyvrWU3l/eznzs8W+zS0
 39tFWnmHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5lcrwT6dPrXiiZwdDrAtP
 Sfem7YzrNx/ZvmbFr7zw3wySUipvuxkZPge8j96r2HDohuFWxaaVR04ky0mJK5zWDlbdbej2UiG
 NHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 16 Sep 2026 08:57:14 -0700, Breno Leitao wrote:
> pipe: pass a poll key when waking writers after a resize

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] pipe: pass a poll key when waking writers after a resize
      https://git.kernel.org/vfs/vfs/c/b76721a82cbe

