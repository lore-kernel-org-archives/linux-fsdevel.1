Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7D357D02
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341992; cv=none; b=B1pOFDmb3f4GMTaWQvcoYq+UJLJ2A/m+R/mXzjLhA38YR3ljYJoKdpOg4JjP9Hl/gmn5rXNtSUWlyEpBINNPu577cXW/g0/O6CdgpCMmfPs8e2a8ubNdIW91zycsknasF8BAUF8Nnl3cbZ7f4rSPRCOLJnzjDndfe9gFAaieZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341992; c=relaxed/simple;
	bh=LNDbSncytyV30p7bUG6HGLdDHJFjAKWl6sBYA9DYydY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTiWOlLco/RWfR0tJ8EajoT3n3dYpz/efQ3RfSZJlDE/wuy7aYmiR1GC+2tEEf/oDB8sR2YPNB0LmjOcwlg87SXkZRrNd20GvcmP0mepXhMlIZB1LadcvbQEzCht8gu+1lRk2cXnyLC9IMYWWqO/K9VH0B3phxJ80wsuj84m+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W5+367Ih; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W5+367Ih"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=3PRjEsmgqn76Hd2Wr35ebCoWayo4PkHbW1sfCmMDIy8=; b=W5+367IhtKRMk7vu0I4HVYNrL4
	h0RK0yNF5w7DQIxzCKJ4gTHZD5sC2tmCEfTCxYIikZGm9+jjZ/BI3T9qoTRLUDnuSSn2xx28uzoUk
	nOS7wb10dm43jRP07T7UsfOMmOVF6fYLlIdXp44TYXe/7qLOWHG8ohAR9LHQTEWPNBMY79DyW4VXE
	26toNjsg/wTctKnds1uCTX9vHlufAsNGaLEcQ21OEsxiNYWdbnRv1mWG7z8qYmdXDiAKOyBiuPwQn
	qPpRPcEcJEOLscP+UAtnPkW+GmxbUyt6DWVQiDIIuVrHUdIpzbbzaAuUM3XydHaPdsYIh/8G1hjNc
	52CpbIeA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU8HL-00000000dEU-3LO9;
	Mon, 01 Jun 2026 19:26:27 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ye Liu <liuye@kylinos.cn>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] Remove __folio_index again
Date: Mon,  1 Jun 2026 20:26:19 +0100
Message-ID: <20260601192626.150804-1-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I renamed page->index to page->__folio_index a year ago.  That proved to
be insufficient to prevent people from using it, so take more extreme
measures.  This breaks tools/mm/show_page_info.py (I expect) but since I
don't know python and have no interest in running this script myself,
I invite the author to fix it.

Matthew Wilcox (Oracle) (3):
  ntfs: Correct use of folios in handle_bounds_compressed_page()
  ntfs: Remove references to page->__folio_index
  mm: Remove __folio_index

 fs/ntfs/compress.c       | 54 +++++++++++++++++-----------------------
 include/linux/mm_types.h |  9 +++----
 mm/zpdesc.h              |  2 --
 3 files changed, 26 insertions(+), 39 deletions(-)

-- 
2.47.3

