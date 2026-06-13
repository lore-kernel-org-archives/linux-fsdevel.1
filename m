Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749ED14AD20
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 03:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781320707; cv=none; b=cwOpZFoe1/oRjx6g7+DoK3khDW+5iFBgBAkpPMTGxUdtPTuVKhhyiBY6b8fdA9A8bIVJminXPXE9wuYYR6lqeWX38MDRpjw1bxVZl6yHyQ0rpgKn4+u8G48VEO/pMqwbkYswpANXr7eze9BB5VrCeXA9nrD5gdPD6PVFaNVvcNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781320707; c=relaxed/simple;
	bh=hhOFFrS8ouk9jY64z5o4dAwi0Bb/m2gbZEbWr66GbyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+XWybmLt0BEW5uPTSESAf5bIiv5LtUbEa7t0jj5AMu36ZMBYED03lXkkVPDp3D4pwLGOKXRk4saXhl/TpqRMjjV9RY/nFwyO1RJo6/HlirUFGEgZo+O+Bq6/bfyXA+qAYIaVmoKxa1TOPXA9pCXoFqe1WXyzJit3tfuHOkpxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HRtZS6HU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HRtZS6HU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=HmwnElAJhoAdKoLbXN+G95cQPfc8xbBCwPXx/b2LWdU=; b=HRtZS6HUlaTflQAFw0/MzUwjxR
	AHJEMVHKYuNjg69Zt/peB0oP5zXn7T9G+JmKy9+Qwriv1OCa85o3Scce8I6LEir65txd6lvqW+INZ
	o8ZvUsBDCxcVnxB0yq+g5TKPMrPCKyoppjrGsuzJNNiUXJe7Wq2NEPwjL+dhjnTTgKlU2ZMi0s/8u
	DQ/tP1K9EMIE/aTL7OxVh6PcdK8FEzISSS7tcJxw3bCngTFCJ0dtaRxzAkW5szMRGNalfLsUiNa84
	qbud9xrB9wS5KZxcESLQBRnxLYRpD/M6RqOZ3+eVYhz5BVSQ42lQyPa6N29OD1s/eu15SYMyghhjo
	yoLY7BGA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYEt3-00000004sPH-1DfW;
	Sat, 13 Jun 2026 03:18:21 +0000
Date: Sat, 13 Jun 2026 04:18:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 5/6] show_page_info: Remove printing of page index
Message-ID: <aizL_QrL4dNWMJ8Y@casper.infradead.org>
References: <20260608210618.3437216-1-willy@infradead.org>
 <20260608210618.3437216-6-willy@infradead.org>
 <20a5a752-3ed6-4fde-96c9-e8369b15524c@linux.dev>
 <ainCu2HZTTdP4skd@casper.infradead.org>
 <11cc4dca-7841-4897-8665-e27d7555f246@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11cc4dca-7841-4897-8665-e27d7555f246@linux.dev>

On Sat, Jun 13, 2026 at 11:02:06AM +0800, Ye Liu wrote:
> 在 2026/6/11 04:02, Matthew Wilcox 写道:
> > Thanks, but could you explain why you don't just call dump_page()?
> > It's more comprehensive and will continue to be maintained.
> 
> This script is based on the drgn tool, but the drgn tool does not
> have a dump_page helper. What kind of method do you mean by      
> directly calling it?                                             

void dump_page(const struct page *page, const char *reason)

in mm/debug.c
