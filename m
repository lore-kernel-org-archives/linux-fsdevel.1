Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694774;
	b=dYUp5H59TY+QAuW/2n71LZFxl4jv0UEYzdJqCvSMtc3fdJ92zf6TrAwIK9Du2rK/4yJU
	 JrYkYlTlMIg6eNae/SJ3frq5gBv60/I+ggS1VYtLo4hOu3xnqyIymcD9k3n6tl92rsmAq
	 nnX9Xai1vZP8qJ72+PjRx+pxEK5c1WDBvHytcQOkqPP6fr2IpxoDozsgJdAIlkSVE2ghB
	 DZn8bLxjUHV5/lH19aSWZLs+mS+k5SUxEVNB5oCPDcj4UwrVu+sH4CS0QHvWS4qLSe5AK
	 pSxX7ZJA6o3ZbegwTiWhikkiKyg/prCdeO9wRFRazakUGewP/lYMEskg8upUOjLIXYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694774;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qO2aC5uaUEhaDSdNYo+SgI2KvSgkhfT6uqbSumdTfBE=;
	b=5txX/0Og0G2EECXLNQGVDBY+DxQwnYP5BM4Q4V6FXngKsCwVpnk9YbNIb9bxM11LpvYD
	 tHszjxMZEFcC45ITf2aVDuBH03bTTwX9uecBuzjLkEJDD/CdccthJG/bND+LFfBURORw9
	 WyeFLIxxj78kgXDezA3/PzrnxKhVpfVJdhEhUsOdm1I4xCx59mILO2x/hzG5n31ijHqyh
	 FH9eOWiT4JTRU4dJafTTLhRz8UXJjkQMUEnvvUR08tb0CFCEaIaihA2TmHDjsHB4pVzTj
	 WSyUpm1kPFC7SOKA315FdMecTGzcKHzCoWOx1PxzJHnOu+C0RCuBIPSGTF1272HoK9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ACnU884M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15A6082BDF;
	Tue,  3 Nov 2026 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ACnU884M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ECD1F000C1;
	Tue,  3 Nov 2026 08:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793694773;
	bh=qO2aC5uaUEhaDSdNYo+SgI2KvSgkhfT6uqbSumdTfBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ACnU884MWPyAYiASrPu94YVhKiQ1UYyZUVARfbXDk3uxO4Pldu86DcqY8Yx8mrCeO
	 x0YabdzJSQWl3l/YJ5yG8W55zJss5Zp6PapKnbrPdTGj6QcExMvJOfAICOv9XzLogV
	 BoPmAQuYIjOA9hFbuJff9iRGlHOxvMQ3ueCKoybS2qwlXL3VGHVgaCtI69M1brCGDm
	 6A37K8rTYWSVLtRQ6ZZsB/2qNtzS5VGpb2XwXfJO2aYCqTyFkMijOfspNUbBmbVMRD
	 Min9MSJNPg70zQBrcXu8RUILTGz6nD7YAP0m4x4/e7/bzPbErBCrMZB7afZrUNYTpw
	 mWpgdkcKGFE9A==
Date: Tue, 3 Nov 2026 08:32:45 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mm: remove wait_on_page_writeback()
Message-ID: <aumcI8m56_MXLb08@gremlin>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
 <20261102-page-wrappers-v1-1-e7280bdb31f6@columbia.edu>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-page-wrappers-v1-1-e7280bdb31f6@columbia.edu>

On Mon, Nov 02, 2026 at 05:54:06PM -0500, Tal Zussman wrote:
> The last caller was converted to folio_wait_writeback(), so drop the
> wait_on_page_writeback() compatibility wrapper and its declaration.
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

LGTM!

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/pagemap.h | 1 -
>  mm/folio-compat.c       | 6 ------
>  2 files changed, 7 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 73af18a37367..c0f7c06dc6fd 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1299,7 +1299,6 @@ static inline int folio_wait_locked_killable(struct folio *folio)
>  }
>
>  void folio_end_read(struct folio *folio, bool success);
> -void wait_on_page_writeback(struct page *page);
>  void folio_wait_writeback(struct folio *folio);
>  int folio_wait_writeback_killable(struct folio *folio);
>  void end_page_writeback(struct page *page);
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index 6212fdd6761a..f880110ac980 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -23,12 +23,6 @@ void end_page_writeback(struct page *page)
>  }
>  EXPORT_SYMBOL(end_page_writeback);
>
> -void wait_on_page_writeback(struct page *page)
> -{
> -	return folio_wait_writeback(page_folio(page));
> -}
> -EXPORT_SYMBOL_GPL(wait_on_page_writeback);
> -
>  void mark_page_accessed(struct page *page)
>  {
>  	folio_mark_accessed(page_folio(page));
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
