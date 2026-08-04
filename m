Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A0547A890
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785861375; cv=none; b=NGvDMkuP537Nsz4KcwBUUBy5TEiZGLp1P5GJ45psxKh6TFHBuYu/q6hHON7fV3b2Ymeh2Ey5tURyqo0Mjh6QmC5vos68iT3PaFuGnCVkvnYlG/5+YI9PhXKY8LSP9ocheMpnkBAJPnF1ecprco7b5maIh/QyT5ajyMMh4ma5Hdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785861375; c=relaxed/simple;
	bh=jgz+B4ugISm2mRbjgWewSOYUb5dmq1uXNau9fu3d8Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qm6rG77UTsnNEY4LTkQpr+Uk2TzbrQA54oGahuVofIoZM6IJdp9xYJAZmoVCQ1YOvD3rvdZd7ag8Mx9+elwq8IhDDJbpGWq+DkkoaLT5B/0QLl7qtvYmb9PO5Rp2j4kNNrM4gRzdO3+fAR7iHFqfBGF380YdNs1TFo8ZA6nGESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UlXFWrVW; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UlXFWrVW"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-934956bee57so4531485a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785861363; x=1786466163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5a+BLaoSLHItF9v1223ZI8dgUJ+oeFH6YBlcTBazBe4=;
        b=UlXFWrVWOhfsQovBB3uYuNo3C1So7E7gQavqNh9kr0vP5Q3SZ9WO4NJMkQ45TdeLeg
         ZSrqUIHzGjB7Blz6jsZJulkSb5e1izIS7pSwhSFD03VJx/maF7vcCDTZ0L7qOxH9KphI
         96YUMTcD7taTAg5DjS68R3IKS/4UjjiRbrN7Xa02l5nDS+EMH23Cdg9ovmR5qTR3PRdl
         oTuE6ti/+4DSOxGoy+qjZdbMdHv9hfuEaqyb5bsaovcHhnqNf1btJrHdBx8pIWYp1xV4
         drfVnZvXkaJks9GSofellw6ZBOg05xtHoZHVKoFckNPLOI9LlqICFpjEeIyNIKe1Xdyt
         XNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785861363; x=1786466163;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5a+BLaoSLHItF9v1223ZI8dgUJ+oeFH6YBlcTBazBe4=;
        b=YWkPYQcpkrUFl+a/BrqPZDX4eX5affZFcyAuDjUFeeeREKA6yClwHUoIamR27xZ7EK
         Tc/GDr2JrQidHHQK5t6so4aGJvM+oYuA5IqTKm5YImLKTUn5+a6J0GcOdqTZCd8/X4Dw
         CY/7Z6okXhdgS1pww95hbVdoV1RF3oKq7PfgivlUfdaB9tHOzFYlVORqQwFOZahuMMsG
         /s/MS99yfW8AtHxfXn9H+CMqXZpB0ZSAg15JPKkkI7YKQKJJd1nXU/nl/DVytvgF2sK7
         yFXMlZfEuE75sGNiJSP67ZYcTcevh7UtnkLBzlti5VFtTlichOgV6dzaCtibhFD9iIpZ
         ukrQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQKHvKV7SQ8NCOh+IRmKBTo8QgXH/pYxkNpg8kGKrjQv2vUmnAteeanHdCcNuvWVmnSHWYhZiQFVR8sFby@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4S8dwrqyAppDsHAvXOdLjPcPB8re171yoAKAuW9CvTYdMfhe
	kHDHm4X7LGUPt+tZN4kHz1P72wydj6UqdeDX1oF3RYY0GInvEy1rW+7dxlQQFIj2uvg=
X-Gm-Gg: AR+sD134yVUbPPZganITMi4RIU3rwKXANy2MjYqqLrKeUYRrkj3EOXAyA9/MP9AUVjt
	SZgFrhVtPBHkYo33SEbbH8KJqi2IVqOgtGYcnMnDyS6LG2UWStVyHMjmcn+SgY4+fkW41y3SnpD
	+4uWw38TWndSzSt5rMMMI2SyasFpHuqJJ1F4DRIARWLDSuzpzG+bQlLI2wKMDJyCZh+LiFJiKVP
	ccQcw551eC3ype5ZN9iIatgxVL3z734HBnfJqC/E9P93cW7yOI+zTt632CKFFugQjn3WdsmirXF
	KJSwHawy4WnFRKE4yzLHEpNBOYTuTQSlw+3cm5tBvU7MumdLTHeDlqJQlytx3UEo/H9rf+Hxg6v
	+0iMtp3ChuKTFtjcJitBp6AnzQhNgBr8tIAFvav7SaYi/RbkiWo+himE4h7KNlu+lDmtJsPVUWa
	B8C9RQAT6clM/DuMS9wYVPt72F0wF3ASJRvnl3LF0nwzEUsN2BlxmSyBznO+DJ3dsX5iwwlCvq8
	+1kFsTRAAoC0Kx287a6X0HxCGQ3jGbnoZJhLBHMn43s
X-Received: by 2002:a05:620a:6504:b0:932:ddff:1241 with SMTP id af79cd13be357-934a093c62fmr2874633085a.26.1785861363074;
        Tue, 04 Aug 2026 09:36:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936418ee312sm115244985a.37.2026.08.04.09.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:36:02 -0700 (PDT)
Date: Tue, 4 Aug 2026 12:36:00 -0400
From: Gregory Price <gourry@gourry.net>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v8 09/15] mm: Remove locking mf_mutex in
 is_raw_hwpoison_page_in_hugepage()
Message-ID: <anIUe_Zq8bFX0-Dk@gourry-fedora-PF4VCD3F>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-10-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731200802.574821-10-willy@infradead.org>

On Fri, Jul 31, 2026 at 09:07:54PM +0100, Matthew Wilcox (Oracle) wrote:
> Sleeping in this kind of predicate is unexpected.  Add a new spinlock
> to protect access to the list, and turn it into a normal singly linked
> list now that it doesn't need to be a lockless list.
> 

Out of curiosity, wouldn't sleeping in this context not just be
unexpected but theoretically cause issues? (mid-poison, sleep, scheduled
process generates more poison on the same page...) - at a minimum this
takes a thread out of the future potential poison-generating pool?

I don't see any particular issue with the patch, just curious the
implication of removable sleepability from this context.

> Rename is_raw_hwpoison_page_in_hugepage() to hugetlb_page_hwpoison()
> and make it take the folio (since the callers naturally have the folio).
> Also remove the handling of non-hugetlb folios and make the arguments
> const.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

