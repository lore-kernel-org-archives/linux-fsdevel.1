Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1A363C60;
	Tue, 31 Mar 2026 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920619; cv=none; b=dIyF75Oq6W9id72bCikBelVxZhVEGukLLKv62CWeo7H3+dVgFpmVRGtZEBx3hbOzFV0adIKvnhEfv2BtA/7vdZetM02O5JEct+aFkivl+fFBuhvCIWdd242Xij4+ZTNwRjKEgyLDs4vcCT6ABWvWz7PrtiQhjH5PNo3fnj4ENnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920619; c=relaxed/simple;
	bh=h3aE6ySObvrIqFwofipofH6NcC0JbLvSOD/6/eqfqUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akC8JwkjF7uMsrIJ5D6TzpNz99+nnYztyBogGE8+yQKkVKID5ehRGRs/meH28h9b2H8lUscjIwFpYkisSvchu4DhV5Z52Y6h/OatLJ8WBYP6uz3+o1V8sYypcNTo0ye0kbMlKg22uWi/yO99+nea0uMn/pBHNISj2hbj9sf0TrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=j0zhJ/r9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EH29gXkc; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="j0zhJ/r9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EH29gXkc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id ECFF0EC0214;
	Mon, 30 Mar 2026 21:30:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 21:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1774920615; x=1775007015; bh=yam9x1q3LQ29OaLOD7A31
	V/OO8egxGl89PwT3/pVXBw=; b=j0zhJ/r9ek7k5AHJssNo2X9Xvez/bLVSzxkFg
	DtWxhXstFjTOdXFoMqlbyD4jLZVTOZcbPOc5JweXGTSFjRWelp1GNCzKKgZhxOc2
	s3c1A2YntZgBmseIzu5hP/nkHSe2bafqrg0wLdQgjD2C0WRw1fSg5f7g0uvBPm7P
	CnPy7gP+c7d3nUz3viMYd8AufPbE4E2t+krm0trugpFgBtVOZb9Rg4DXgRXyiolt
	ZQOEegoGmEwc2ZJsWXrccQJL3cLXL8asJ1Z0WJbvwYhe6urvQXhKZs3jHRzp+/IB
	OHVAyf99vOxchMfl3zn9IoSsDoFhq2ZDMWBT+F12b+7X5FU9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774920615; x=1775007015; bh=yam9x1q3LQ29OaLOD7A31V/OO8egxGl89Pw
	T3/pVXBw=; b=EH29gXkc+6ad1tCljraYN9yNlykFzbaukCW01d9EC9WctsVu/Ax
	GbA65zueJ0EN0RfBUPWoU3dG+zotacPJQeSnDq2OFOXBjGYbMdyV/V02Kw7T8giu
	GPrsfDXsYwubmTSp+vGfN4n2fsQz2lLQnSGoti3Swmp2GrpwoDc5Cpx5qG4d+SNu
	+utt9PS+ucBg64VFu8En9Ed5YXjBfaTSQ7ocaAyg0gVCV2+9szAyZ8BfzWkL5VJy
	cE2JT07okFwarZvn0CWKy8W8fhC/CZ0OPO/7Yz4+a6JR0B8SXQlri1xYWwaUBZEB
	lIhqonNZYWSGRpjMxC8WvYea+Z8TmrP2N5Q==
X-ME-Sender: <xms:piPLaSQx1ZX_rFJH5zYeffKBcc_qGyBHg-j4Sf52ohFr6VVpqb8XEw>
    <xme:piPLaWSCorod6Uk-Vgt9Ws1aBWJGPtbyW6Ls2FvWfx5Q-aqHI-9H6TGAF8GZZCbYi
    tdy6ILeoT8cPutF6eiebU9DSqTKcZbn4wqRlOcGPLqMqhhP>
X-ME-Received: <xmr:piPLaWp4g9pubxzrv8WGA5nB17nYi4IGSmmeAdq-hYM7ZuKDTJnkyPtR2OgG5qapcF-730YsqyrZAMpLFgQJYrtVDL8mkTPX1wSa6BqIHN6ZTdN_56j-xlL3Kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgvnhht
    uceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedutdfhve
    ehuefhjefgffegieduhefhtdejkefhvdekteeihfehtddtgffgheduleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmh
    grfidrnhgvthdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhroh
    esiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprhgrvhgvnhesthhh
    vghmrgifrdhnvghtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprh
    gtphhtthhopehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhrtghpthhtohepfhhs
    ohhrvghnshhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehjrggvshhhihhnsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhn
    uggrthhiohhnrdhorhhgpdhrtghpthhtoheplhgrohgrrhdrshhhrghosehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:piPLaeDMR-fFppwwwJKASuCGXl0Bly7CNmz1tH_hWpqTtPWYOcwJIQ>
    <xmx:piPLaTu5IupXYALeLPFOxe89EIyBX04XNlZ-2e43y2T29o9t_afxpg>
    <xmx:piPLaVZe0AuTm851Cs0G1KTooWtA8v3UJskjc7-oZixGfTp4ViBMrg>
    <xmx:piPLaXF0bqYWJh90zgmMcYbnJISzrtEdW5xwS-7St1IBxZ9jq3LghA>
    <xmx:pyPLaQLBUTs7QyKRrTH38tnhq4Vpvswi7LW9n0x-do1VI93wV5HA8Nbz>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 21:30:08 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Eric Sandeen <sandeen@sandeen.net>,
	Frank Sorenson <fsorenso@redhat.com>,
	Jay Shin <jaeshin@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Wangkai <wangkai86@huawei.com>,
	Colin Walters <walters@verbum.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] Limit directory child dentry retention
Date: Tue, 31 Mar 2026 09:29:08 +0800
Message-ID: <20260331012925.74840-1-raven@themaw.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Please forgive the long description but this seems to be a long standing
problem so I'd like to offer a suggestion for improvenment (but probably
not a complete solution).

I have seen a problem where, in one case, a directory has around 12M
children with about 80% of them negative. Then an fsnotify function is
called that needs to traverse the entire list of directory children
while holding the inode i_lock with obvious consequences.

Some time ago commit 681ce8623567 ("vfs: Delete the associated dentry
when deleting a file") was merged to try and solve excessive accumulation
of negative dentries. It was later Reverted in Commit 4a4be1ad3a6e due to
performance regressions. In addition commit 172e422ffea2 ("fsnotify: clear
PARENT_WATCHED flags lazily" was suggested as a fix but one of the reports
we have triggeres the problem via fsnotify_add_mark_locked() which still
traverses the entire child list after commit 172e422ffea2 is applied.

Having worked though the above commits (and the revert) it occured to me
that a similarly simple approach would be to only limit directory dentry
retention when some highwater level was reached. A kind of keep a bunch
of negative dentries to try not to interfere with the dcache but discard
them on last dput if there are so many child dentries that the benifit
of caching them would likely be negated. TBH I don't know what that
highwater value should be so that's one thing to be worked out.

I don't have a reproducer but I presume the people I've included on the
cc list may have some tests. TBH I don't see how Commit 681ce8623567
caused a regression since that should have required a re-create (probably
many) for the same file to cause it. Nevertheless the patch here is yet
another a very simple approach to helping with the stale directory dentry
accumulation problem we see all too often.

Thoughts and comments please.

Ian Kent (1):
  vfs: limit directory child dentry retention

 Documentation/admin-guide/sysctl/fs.rst |  7 +++++++
 fs/dcache.c                             | 28 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

-- 
2.53.0

