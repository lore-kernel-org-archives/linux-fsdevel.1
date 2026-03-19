Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2E1F37D3;
	Thu, 19 Mar 2026 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932560; cv=none; b=bo1773WTIwlwkd8Ia0TdjrCHvZdf0jrcYGQoUMpAsfVSlH6D9F7/SH1bk44XW2J3nV74UzKvsesWm+7BqHLlgynHcYQCMpha9dHKXhw7xL1zEjhbW1gAniiVmBt3k2n0ITmLTnRDFYrb5gSF+W4mTAO7e2bdi7V8d2tTce4XP48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932560; c=relaxed/simple;
	bh=fD1hh3FlLNb89rb3mybyFS8e+fEU4WiMeRwPeDfjcmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdCvU38dqI5vIzm9YwZ/7rrPMjON5WuwzI6ugy40HfMrk0zg8icKqBTsE40DnbH4WqFvaCmennMbD/HUhOumc8FC3O7W10aWApg9MtJbiV6B17xXmr8wZhXz7L4uWvMZvg906p6Cw7nGejht2Np2sD16rwJFmPsqg33S191t6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=D2w0lQAi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="D2w0lQAi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PxgY7FKa0ht39sNDHWrQOcdL11Zd3B7D1hAJCRXN3nY=; b=D2w0lQAixPQYyx4EgFKJATK9Bm
	OVrJ/ipoGK/PGyOzPTOSRGSS8jw6j2nHft5OaQndQ5tP58MCDtE3EN3FZKpGsRjlPhkzttTVQ8eNG
	1k0NzpegtHeWYw+5CXvnuOH3tPhyONeYIdjRqkLCTR8JpCP4e9xTNqjVm/yXo3e3aiIP3ZlCymqR4
	X8C3JZfViwoxFO5Q9nfoI2BUExjeIwVJc6okJjlV9/cOMOWW0hNrNL9hdEy7P5/KclkpyHoBVfoj4
	6hUyzNYh4hBGoZwflL3pI3c8ooqc4/JUmJF7x3lESHW5CVxbGPZLK3htAKf2j005agJGAcvxhWaM2
	gYdEzXXQ==;
Received: from bl21-120-186.dsl.telepac.pt ([2.82.120.186] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w3EtJ-003NxL-DN; Thu, 19 Mar 2026 16:02:29 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v2 0/1] fuse: restructure requests extensions handling
Date: Thu, 19 Mar 2026 15:02:27 +0000
Message-ID: <20260319150228.52789-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

I'm sending v2 of this patch after finding an issue with function
fuse_free_ext().  The issue was that this function was freeing the ->value
for all the ext args, which isn't what I wanted -- now it only frees it for
FUSE_EXT_GROUPS extentions.  While there, I've also added back the
immediate return if there are no extensions.

And for reference, here's the origin text from v1:

This patch was going to be included in the lookup_handle patchset.  But
since it is self-contained and it can eventually be picked independently,
I've decided to send it as a separate RFC.
 
It basically re-implements the idea of extensions, making it easier to add
new ones: a extension can be simply added to the 'ext_args' array in
fuse_args.


Luis Henriques (1):
  fuse: restructure requests extensions handling

 fs/fuse/dev.c    |  35 ++++++++++++++-
 fs/fuse/dir.c    | 108 ++++++++++++++++++++++-------------------------
 fs/fuse/fuse_i.h |  11 ++++-
 3 files changed, 93 insertions(+), 61 deletions(-)

