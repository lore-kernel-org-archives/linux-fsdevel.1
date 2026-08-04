Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3534B1A5
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884520; cv=none; b=ChOd2BQDiCajUkq4lkCox68T0A9RKImeS5UEXX8tSrmC93lpJXQZyhN3xZoPd5TyoLZBUchHE94f4b5ueX/Lm7r6WcXBAJG/MDNNWgXCy0Kp3psL/MQPkt7npUS1zaDW8d3SdtK4YwnFAAfofN+7TlfwclBVcJisQ3B+Au/ulRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884520; c=relaxed/simple;
	bh=YEbEh11h1lkTcHqOa8rTVrEmdBxzcAJkMjqtjJhJzHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWDkrt0zYMTWFyVH/WUI28K9Jn00bEyR+e37J2hc0SJsqKe1Yay6TW4Ja3si34aO+plDNsULu9bz8tkgM8EENLRdDaqcFZVNOXlvLcoyEcB16UD9APfNHGj852/BJ7NgnXf+y+kx7FNme0D5Z3e/t+oGQpE3FWDk5uoLs+BYsAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ut8jhEBg; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ut8jhEBg"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-97622cc1f40so239792241.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 16:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785884518; x=1786489318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iz6wwUefZFkmNA7PKZhIfUvF38jPXDSd/DYv372kOcA=;
        b=Ut8jhEBg4LRsaOvcPBFZ2wSgnNnftcLhhrYk6UOWMuF7qe5jV/0Wfsf8FE/IE0CBIp
         hGJPKtorUWQLZp1W8eGUUObW32LSHX9gBE0gSWT+N0Tn5WZRY7gNe0XXGlHYxPyR+Eti
         QtwSlSuIXE6cXcjwMpnk/wWraasCu9eBspR+ujVt9RrHEV6DLFGkOMKSC4BwCX8MeHlI
         oNYhfsJvLfuukdHV+qgfrbyHbFULOy+RuLsnTSqLGAuIRzvWmkDiXFAnuwhFMqWXQqkl
         DkIFJLCyXN441Woiv9EPO70vCiem5ElRr64bv1gP8JqLONuDeWX39C2zufu3PzxOnicU
         54qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785884518; x=1786489318;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iz6wwUefZFkmNA7PKZhIfUvF38jPXDSd/DYv372kOcA=;
        b=Q3aBa6TBMHv0+RQvwEs5KN2/WgtXB9p1rAePYqr2KlZfjb7D83ukcSwzVDfPnKqmrb
         IMvJ5wKrMMn3eeDYhqpamIHxSSGWIdyrnh/duVXJVFbHoAJBG1GM/xAMdL0owjoaQacx
         o1P01+gUyEfekf7rBtRgKDHEtNRBzwPkH+Rb6tS31TpA0gqqbC8R6RW4zxuhFkY3uRRb
         j/uRoJVCTmOuRwRjT0UY6G4ADAzVTfSjBZgLidUiCgZ82aFeiFX4si2jZLfwuAMFw6pO
         a/Mt4VemSC6FFDYRjqwc4WkZPqv9M7Fr5eo7Laz5NR89QzPzz1XTenSQWjS4KBxpRYQx
         bNVA==
X-Forwarded-Encrypted: i=1; AHgh+RpPESvRhEatnbjcWbVpSRGc4jjUZyKp60t5cbyWg6Y7Ch8tn/q3DssreaznAoc5sY3gy4yTkKSC4k8dsgGn@vger.kernel.org
X-Gm-Message-State: AOJu0YztOxB2u+bK/CtBvPddr+GT7pfzdEgb3IgyUHPDLu+JQ4egp1w2
	uMC4NWU+Cod7i89t1Qy5puotLB9jprhkj0Empmxqm1Zj7Y8nCS7wufBzEHrCheDWsg8=
X-Gm-Gg: AR+sD13FfiIZAl6ENTneteA994W77/wwAXPYexgMsrkx0m4fIY0M9DKUw1qdaE51ZaI
	g5z0mRZyjU9tkoMx81bk/tSerInxYjbCqrRfnpx1ibzk09MNVcP0b4J59j/SYgCzChpKX7IjbJB
	C7Zkb2kFNtPAZ2v+VNIrGiKoEZ9cXNkXDVFNTM1FKkIggUBdfF3tL5hQG/DlKHMbvMHFyjOpcXZ
	3RfIa1IrU+Zbm1eiKVA7KMAUIHnk2WmDlM9EDImgT01D48Xm+vnziKAqMT//j5aQuJ27SHKpoAd
	ukZCRC5A9Lq5N61dBCWI7EEInqqMxeFBi+iJ39scnA2MDciCAvX/X4lyzmDXKoHKvKW32H7j+FO
	0DJiZodvx1heoEJyXlvqIfEtlgThWwKKi3NlkH7B9CUH6yGp8mT17uHlZfJ4LCOaELFbkFQs5sv
	YVfbB/+I6/S8Tf3iS1KHvszTc18QyJ/USjXR30xJIWfTFxb2WBJ2FJLnd1zk/GhqIRLoICiQoTq
	hkQA02Rp0oxuwA4RNS6aqgO2PJn57d6MO0r3+CgqgO+
X-Received: by 2002:a05:6102:5045:b0:74d:ce64:efa9 with SMTP id ada2fe7eead31-760e9951613mr747189137.12.1785884516765;
        Tue, 04 Aug 2026 16:01:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ff9d04csm13795626d6.3.2026.08.04.16.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 16:01:56 -0700 (PDT)
Date: Tue, 4 Aug 2026 19:01:54 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v8 10/15] mm: Check individual hugetlb pages for poison
Message-ID: <anJvBEHeq58WBQaj@gourry-fedora-PF4VCD3F>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-11-willy@infradead.org>
 <anI5bPVScck1WXvh@gourry-fedora-PF4VCD3F>
 <anJX2bjH57IHz-jX@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anJX2bjH57IHz-jX@casper.infradead.org>

On Tue, Aug 04, 2026 at 10:21:29PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 04, 2026 at 03:15:37PM -0400, Gregory Price wrote:
> 
> So the pointer we get back from page_folio() must have been a folio _at
> some point_.  It may not be a folio now.  It may be a folio, but not one
> that contains this page.  But it's not a wild pointer, and treating it
> as if it's a folio won't cause any harm (as long as we're really careful).
> 
> Specifically, we call:
> 
> > +	if (!folio_test_huge_poison(folio)) {
> 
> and all that does is access folio->page.page_type aka mapcount.  So if
> the pointer we have is not a current folio, it'll just return false and
> we'll check PageHWPoison.
> 
> So the only case this can return 'true' is if the folio was hugetlb
> at that exact point.  And we've got the hugetlb lock, so it can't stop
> being a hugetlb folio.  At this point it's safe to walk the list.
>

This is basically the reasoning i came to, ergo "not worth addressing"

> That's my reasoning, and I think Sashiko has explained enough of its
> reasoning to be fairly sure Sashiko is wrong about this.  But hey,
> you're not Sashiko.  Maybe you've found a gap in my logic.

I think sashiko is essentially just saying:

"But if someone does a dumb thing with this interface in the future dumb
 things will happen"

To which we say "Don't do the blatantly dumb thing :]"

~Gregory
