Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7BF3CB2DF
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785569530; cv=pass; b=GvhSdqZOvAO9ikOGoQWbK5ckB7+7uSmbhKNtOojxMPl66bTvpIpvTy8fA0fSAAQ2U8wToJGXLCi49VVvVnFt2q4In/9+c1LYKhw0T3xrNPBwaaB///DMKa9UqKKQe0fwxoP7BClnHrakxw7lxLK6LTihDCz77vBbNKS7Xfswk5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785569530; c=relaxed/simple;
	bh=kLDdy2fbP0nIkSq0a7IWWE3HuI38gV2RvdCd8aJVslU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDOqjtZVOz4pNJRmKvayqpySkdWp1wWvVZgoewp17vS5ZrRww7SRdG5q2gIHgacINhFA3hnKCkD/2IfvAJFz1QuWn9A+uPB3y4f8OO4x3Z1HHC2Kpmpl7EiDDOzDuNY0HFGJTIbzb5bZClEArqBfydj1cIcVXqgXFkyf2gp64ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=IA1B7iI+; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="IA1B7iI+"
ARC-Seal: i=1; a=rsa-sha256; t=1785569472; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=lElEU+ZF24MMY9yn4fbveVmQIkuxyWzo7Mud0M9NO3m/K6m/QpbXgITRxKy/3I5IY7rfj0I3x5Y6wHXXRDfETBxbEnuX+Yif3k0S+AAgozFK7z/fZkrizO9VbTOplkWP28+GvWltDj1CWOlYZvehuEZWrtDwsmvKNZKdv5kN1n8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785569472; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=80/ZHsMA6sURvDsYpknDnJzU+W0Jz6Zub+wlZq8bO2E=; 
	b=cQj/s3ider2bTHVSmiVoF/Il8DITiXW96D8l7BkVjHdi14c94UDKBKk99J7fGimERYW6wFSI2SihQSOvErBpvXfMDJ8KfEVDdPgJxvQWVxy1PoIQCh7WIkDj4SerYImMrVAqpE2yWuUobvoOB6XnRfqixf7rkQOI9UgmpuM6iT4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785569472;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=80/ZHsMA6sURvDsYpknDnJzU+W0Jz6Zub+wlZq8bO2E=;
	b=IA1B7iI+3LUkuXBNZfy8NW/DfWdadOnMvNjNDt/cJjzMAwzcIYUMQWDpW32i4QF+
	abDWpL6ylDSGE+M7MCRSenyLu033/jVcFFjqrMcXDUVe0Pn/bIwwWCXUm1VwPziQouW
	fJihh7y5GX5XEWmEVhsgsdhy46tSI/FTryQnENkw=
Received: by mx.zoho.eu with SMTPS id 1785569469604853.2168044972021;
	Sat, 1 Aug 2026 09:31:09 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as UFS filesystem maintainer
Date: Sat,  1 Aug 2026 10:30:59 +0300
Message-ID: <20260801073059.63651-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <am10yuQx5a3h2pXH@casper.infradead.org>
References: <am10yuQx5a3h2pXH@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On Sat, Aug 01, 2026 at 05:23:38AM +0100, Matthew Wilcox wrote:
> Convince us you aren't Jia Tan.  You have almost no history with the
> Linux kernel (one commit that I can find, and that has a different email
> address attached to it).

Fair question, and after xz it is the right one to ask, so no offence
taken.

Proving a negative is hard, so here is what I can actually show.

The commit you found is 607af438e643 ("tools/power/x86/
intel-speed-select: Harden daemon pidfile open"). I wrote it as Ali
Ahmet MEMIS <dev@unknownbbqr.xyz> and Srinivas Pandruvada applied it. I
still control that address and will confirm from it that
ali@iusegentoo.com is the same person if that is useful. I have moved my
kernel work to the iusegentoo.com address and will keep to one from here.

Past that, I would rather be judged on this week's work than on my word:
  - ufs: do not treat unreadable directory blocks as empty (rmdir data
    loss)
  - ufs: free the buffer head container in ubh_bforget (Luis Henriques
    posted this fix in 2018 and it was never applied)
  - reviews of the pending cgsize and cssize hardening patches
  - a two patch hardening series with KASAN reproducers, for a mount
    teardown NULL deref and an out of bounds write driven by on-disk
    cg_cgx

On the entry: point taken, adding myself as Maintained on this much
history is premature. Consider this patch dropped. I will keep sending
fixes and reviews, and if an entry ever looks warranted to you and the
other reviewers we can revisit it then. The fixes do not depend on it.

What I care about is ufs bugs not being ignored. If routing my fixes
through you or the vfs tree is the better path, that is fine by me.
