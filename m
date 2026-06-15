Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF9238D54
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 02:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781490987; cv=none; b=hh5pZV84oWg98g3ySkC4WeVZUUzU6x6kWenFiRu08TQxXA+GDIAImPkybVclU0Hz8F4MjJOvHWtiM58bs4aP2zc6oP3spFdhTAK4Ky76bbMocXN7Yy0kX3uZyFTFra2Bgq6BGM7LhqckFWakIA0h8DYv+0Q6baukir1u8jQuijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781490987; c=relaxed/simple;
	bh=L/HrQeHYHUyfI2NnBxAh06HbodmSrDkcHbKkNpKkPx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyJFUQTt4D/nVUjDrtnywvZFnNQNqbQlrENa7o5GHgOqIUg0N+kvB7EKsQPmaNB1RlAy6V7TqwSyHRISRH5Npp/WylW34eQfl8Nj+8vfqA0ANvJb+pMdE4uDj1cacJAPdbI5CVN8lGOaLsYIS71YmoqLHAhxs2m2kjvIdRQpOyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VLAyNAoR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VLAyNAoR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I5QCFZfmBpSyEAU6mlKpvNOiFrVqxfzRtkJsLhCyKko=; b=VLAyNAoR2GkoL44M/cJguFrb/A
	2krYBx5OyHQ4UNxJaOzwpAwMu1hAU/sQ9Z3jO+04Ol0DZwYq9IJiksAXQ0h2sew2An07l7qMt1ilJ
	UqBBZC98vipj8+4U2gg8m0b8gvjW2748cmviroKvX5Zik/FZfWkOfa9pbWkfEwNtAy+TDqQ7c+jxA
	CYNlrpGwqBb1RJW/JLfV6KrPrSYb7tTLtEA3/GeWAfRcw3pkDnT/GiBFg3YNQ7KfnIsgkuTlqI4KM
	iPhMilsPSDLLXPkb+YhKuauJ/qDgwipRG0SFKYM0RjbP0eMPWE+E+Bl217m/SP8/AL/uy4HMbekXq
	GKg6gXjA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wYxBV-000000090uF-27IX;
	Mon, 15 Jun 2026 02:36:22 +0000
Date: Mon, 15 Jun 2026 03:36:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
	Eric Sandeen <sandeen@redhat.com>
Subject: [git pull] old udf fix
Message-ID: <20260615023621.GA2142293@ZenIV>
References: <20260211201845.GN3183987@ZenIV>
 <n7blo2z6tk25p2pkjk53ifm2p2nejodngojrnmgdcr2bqpv3m4@up4qbcufnfii>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n7blo2z6tk25p2pkjk53ifm2p2nejodngojrnmgdcr2bqpv3m4@up4qbcufnfii>
Sender: Al Viro <viro@ftp.linux.org.uk>

[just noticed that udf fix had been sitting in #fixes since February;
still applicable, Jan's Acked-by applied, very belated pull request
follows]

The following changes since commit 2005aabe94eaab8608879d98afb901bc99bc3a31:

  functionfs: use spinlock for FFS_DEACTIVATED/FFS_CLOSING transitions (2026-02-05 13:53:12 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 462bdd08fbdf41db223c6117d907c8fd68d666ea:

  udf: fix nls leak on udf_fill_super() failure (2026-06-14 22:29:21 -0400)

----------------------------------------------------------------
old udf fix that had fallen through the cracks...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      udf: fix nls leak on udf_fill_super() failure

 fs/udf/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
