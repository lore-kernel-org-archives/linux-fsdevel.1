Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD511F2B8D;
	Mon, 11 May 2026 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483836; cv=none; b=uMHkgtBLVsiUnfE4WkgYW5a0rS4Bmy8O08S+dQrT7OHylwzIdr4Z3QquX1sHNH+u/7To6/JY7cd0SFdFOVrGZRB0uuxMl+5l1vH4l5kBuyPVOEQ47GWcNxMk0BogkubRpJ066TzAay2VTa7Rw7ommjdODnUvbiJzfhvqPnGndqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483836; c=relaxed/simple;
	bh=YFUc5/HNZVDjg/McInXWlXD3uIgjxGoJCtBR4vT6hNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYpmAuZrNUTsJxoETwSfgXg1/K2VL2Bf8Kl7j38f3e27Yl5l0G6V9wbFfh+JxR2UD5SaH2He6J7k7rEsrXqiKjNdSSY7B4IS2VMCyT2Bznlxu+QL6EYvwFMf72eE1/2QaUzeFga2vOkjYorYqttM2KCLN2M3ZdwshEu79Hf7F8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VR+soprw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VR+soprw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CqLRqpQ5+b1NdRH6j4SQ9/lMP5JkMatBucn/LfaDj7c=; b=VR+soprw5KCmE46puPFBL3cxUu
	TVpHA5cKLiFKacf7j4YGudVGCaKg6X8o8dSiULNT4qRmoghqA9cgsAM6QyKiMWXYQLIOT/r/8OrnG
	iL/NuRuvSuSBdWe2VfOA9eQIqAhg+3nrrzKh4drXycLkJAMbpe++B0mPFeXwsZVElc7nf3Gqsxv59
	4UOKtT2L3W8seZcBFvE6oUXzIrHs2JsjY1h62I5xRr6ht17yHm9k8NVBG43Yla8MzQFgs1a798FdX
	ye6sQ963p0RLXU6HhWMOaHspmJewkETOpY4GVs0BUE9HBxaLGYpHaDK2SfjBgcs8veXbUkqt9dz0T
	N8InYT2A==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKt1-0000000CZso-3e5l;
	Mon, 11 May 2026 07:17:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Dave Kleikamp <shaggy@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Bob Copeland <me@bobcopeland.com>,
	Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	ntfs3@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net
Subject: fix crashes when mounting legacy file system with sector size > PAGE_SIZE
Date: Mon, 11 May 2026 09:16:45 +0200
Message-ID: <20260511071701.2456211-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

due to an almost comical failure on my part, my work in progress test
case failed to create any file system on a 64k block size loop device,
and then tried to mount it, leading to a probe of file system built
into my kernel.  Roughly the first half of the series are file systems
that actually crashed, but I fixed up all the pattern of missing
error handling that I saw.

Diffstat:
 affs/affs.h     |    5 -----
 affs/super.c    |    6 ++++--
 befs/linuxvfs.c |    3 ++-
 bfs/inode.c     |    3 ++-
 hpfs/super.c    |    3 ++-
 isofs/inode.c   |    3 ++-
 jfs/super.c     |    3 ++-
 minix/inode.c   |    3 ++-
 ntfs3/super.c   |    8 ++++++--
 omfs/inode.c    |    6 ++++--
 qnx4/inode.c    |    3 ++-
 11 files changed, 28 insertions(+), 18 deletions(-)
