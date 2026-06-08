Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9495736F8E7
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952790; cv=none; b=u3R56YsRb9R1In3qNSm/yYO5RR+0R/CMF+1b6kGNwD4VkHVhukxE7sgo9oPA9SrD4X3kwkyYRnlNNinyzYAvIsGA41rjVfXaU7cze3eurhOOaH+m5DcMtf96bHRO5Ef/3/8hs/OOE5zr0f/QUUAFMArGcDrSg1G8iDeLUtHBvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952790; c=relaxed/simple;
	bh=gsvoO6pjB37CuF9dB+MbD4DuS+gzOQkC3ddPzhMO9Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7B5eDWS8PH6i9mlcx6CGZsyFrb/rA3wSY/n80fb19MeW8HzOD4++f04sbkorriv5tPb5ii68NA2MxB2J8G4Gv9gQLKhQPZm5mcBi16l8olNmV6hSmY1uDWTHF+e467lGAEptd2VbrOqXnsZqRl5O5szXnYHZAYdnXZrP83SDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZP8cNywy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZP8cNywy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=D4t056VLnliANpP3l47/phb+n9DgzAiJw8SOlskV6Ns=; b=ZP8cNywyK+sLDCL0Lxu9wRkD31
	ly+PrnGJBy7xkRS1rFbf5NJoA6OmNY6xSyYRFunQUOXTc28IicjV07/ExWmRwTg2DqpcLyGiJT+Uc
	ke6cb6av7IPmyt1yYJeh9Ooadte5Awb2yN7RPCuoIZI//OQ/4I5b/gYxId5reRwlbibOyyMBp3S28
	515GKp6LWasunYOj147KPoy845NEBit3+2AZfmFE8M4s29cAdvM4HIk+9bneML6lvA3f0ZNLpJky9
	a9OqKflM6KGv5HkRWZNmmqSh4rm6E4rjgMbECWUujNuv21C/gxDwJMgrVQqUBcYAxg9mw4mzYG2HH
	4kDD1aBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhAq-0000000EQB8-0mZs;
	Mon, 08 Jun 2026 21:06:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/6] Remove __folio_index again
Date: Mon,  8 Jun 2026 22:06:10 +0100
Message-ID: <20260608210618.3437216-1-willy@infradead.org>
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
measures to make it inaccessible except through struct folio.

v2:
 - Split patch 1 into patches 1-3
 - Remove inversion of the i_size condition
 - Use page_offset() instead of page_pgoff()
 - Preserve the call to flush_dcache_page() in all circumstances
 - Use offset_in_page() instead of open-coding it
 - Remove shadowing definition of struct folio in patch 4
 - Delete the printing of page->index in show_page_info.py
 - Unname the padding where folio stores index instead of trying to
   create an unguessable name (Arnd)
 - Justify removal of page->share in patch 6

Matthew Wilcox (Oracle) (6):
  ntfs: Inline zero_partial_compressed_page()
  ntfs: Remove use of __folio_index in handle_bounds_compressed_page()
  ntfs: Use zero_user_segment() in handle_bounds_compressed_page()
  ntfs: Remove references to page->__folio_index
  show_page_info: Remove printing of page index
  mm: Remove __folio_index

 fs/ntfs/compress.c         | 53 ++++++++++++++++----------------------
 include/linux/mm_types.h   |  7 +----
 mm/zpdesc.h                |  2 --
 tools/mm/show_page_info.py |  1 -
 4 files changed, 23 insertions(+), 40 deletions(-)

-- 
2.47.3

