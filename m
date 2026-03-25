Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7813A86C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420642; cv=none; b=hopBErv2QeCcYKFnWk8hhB4zEGJ0wxsT4Ym/n2ld1TmcC5mU/VzSiY0Zix4C22nN30jF7aETb1ovCnqpr08aSZfWBPju1XINpd+sTzHiBxOAXxeV0Xd/KEsFjNFqiMRz1HmlEFZ8gSv2Eg83+3IFp2ZYUIdBh7C4N+3L+hX7kg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420642; c=relaxed/simple;
	bh=rVprebRosOBu54lH6gfDZScX3fYQQEaSQfi+nPb8NbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbU8VWi7HgD6Ofjit0zpmO8dDrbRx5KUxcBQd9zk8E0ic928+uxrfzRGDxR5Rpv9AIkqK9xAouE5rWm5AwOtyO73924VX4J+gHKqODpuxl38yWC9eF62uB4Dm7PqQw747tG5Ydu7sFlaiWm99U5nv5GAjylyBdXW8YFnlYEDrTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=afwIgGjP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="afwIgGjP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SSVNfxiiMTcHhQtQwtpwS+wroFKWOjMGRT7P5t5x9oM=; b=afwIgGjP0shmC1zg/YxNsNArDa
	twXV4JI8hUVxJandfKiqe8HwGfn3HACH19zxEdmNRRn0ph8VHoRUc6q7MThYkRhM7gDr67MivVesd
	JPPygFamaE/IEakZvHugV24nIcJsqFX4s1srb1NKIJT0PZciU8kWLwSeo+hulR7rWrHOzaHd7Oe/2
	pEpNFCqjPe+zyfe9NMXgHW/q5ASKIc0Gteyd0icPsoAS8gi30V3KhA3vofmwuB8MRLXAH10yF7Wa6
	JAI+le0jH4VDi4NnbHkmRfkqtvBSX1+PZQ2UDu87Qn8EqoWtjHEflhPCe6zqF+kQjdK5WWsUSO+Oo
	6DM3YrFw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5Hrh-00000002nMV-1NaC;
	Wed, 25 Mar 2026 06:37:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: trivial ->setattr cleanups
Date: Wed, 25 Mar 2026 07:36:47 +0100
Message-ID: <20260325063711.3298685-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

I've been looking into changes to ->setattr and noticed that we still
have a few instances where the method has the ages old notify_change
name.  Fix this up and include dusting off outdated comments.

Diffstat:
 adfs/adfs.h       |    4 ++--
 adfs/dir.c        |    2 +-
 adfs/file.c       |    2 +-
 adfs/inode.c      |    6 ++----
 affs/affs.h       |    2 +-
 affs/dir.c        |    2 +-
 affs/file.c       |    2 +-
 affs/inode.c      |    5 ++---
 affs/symlink.c    |    2 +-
 hfs/inode.c       |   21 ++-------------------
 proc/base.c       |   22 +++++++++++-----------
 proc/fd.c         |    6 +++---
 proc/generic.c    |    8 ++++----
 proc/internal.h   |    4 ++--
 proc/namespaces.c |    4 ++--
 proc/proc_net.c   |    2 +-
 16 files changed, 37 insertions(+), 57 deletions(-)
