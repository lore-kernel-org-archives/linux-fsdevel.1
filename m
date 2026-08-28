Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDCD3E2ACA
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950478; cv=none; b=bpMf93TFtJnTHUbzdxwr7JiNjYEL5FWHCNlso0kLkwh1hieEWdqR7z3kufaNdA01py7hvmxXhEwro7raTfjyBh0KevxyaIi5sldrmt3STMTDrCJTsu34zGfs4IDWOdPCsivsr/lR1Euex8JeNvA8CV1RhAUCxknZHY/hP5D+258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950478; c=relaxed/simple;
	bh=7kiKzmx4MhRzEFZPEkAlDY2WC7kHMWwbvIVm6Mn39yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MVzoaaC07T505aRJd6TL8Yvotf3mQ1avDuxVcY923jcc5FFHlT8vOBFcVQriY4J5U7IbG0cIoRCJ/Oek/N6WAMzHytWVFSsBVT8kqfboVBtfLfPNJ83UfwhbO+TGxPTf2ieI05gZJ88HzPLrQGdLwsGxQMx4OtnemaXt/zYlSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rjyfl3Zz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rjyfl3Zz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=oVLcUhW9Gh1Gf9Lx4R5g8BD6mij9+HzLS1RbXdEWupg=; b=rjyfl3ZzZe9vRMUrwAdPfPKqVW
	b2OSNrcdyoVrQenXLpBWaCvO7Bx/C38gGUI3tNsm3UfdHYIseIimFcVSusar8aMYXBQQNuJpHi0us
	l9SAfjcdjcOhnM6u4mUnmD8TymNF28sTY+hCuq5BqKBPzw1BlU9IRYpBe1qTAtDpRMjKkIjcOK/F/
	a0vcbArGsquvHT809jQVjElIA3uXGEPZbbwqcCh9PldcxezHxaCfFIu0OF087jRIKfOPD9xlQAcom
	M8lzgldTsAqN3xn+EXfv4eh1BAgM3wScrAWDrdbAT6uQot9qLdp/XRRQ6X/dDRdGwoEXKHYun2138
	cvpVBW3g==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x03ao-0000000FQs5-3TXb;
	Fri, 28 Aug 2026 20:54:30 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/6] Buffer head documentation updates
Date: Fri, 28 Aug 2026 21:54:20 +0100
Message-ID: <20260828205429.3678204-1-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mostly just tidying up some out of date documentation, but I found the
time to document some functions I thought were worth documenting.

Matthew Wilcox (Oracle) (6):
  buffer: Remove reference to unmap_buffer()
  fs: Remove references to mark_buffer_dirty_inode()
  buffer: Document sb_bread(), sb_bread_unmovable() and sb_breadahead()
  buffer: Document mmb_mark_buffer_dirty()
  buffer: Refer to folios in comments
  buffer: Rename label

 Documentation/filesystems/porting.rst |  2 +-
 fs/buffer.c                           | 93 ++++++++++++++-------------
 include/linux/buffer_head.h           | 50 ++++++++++++--
 3 files changed, 94 insertions(+), 51 deletions(-)

-- 
2.47.3

