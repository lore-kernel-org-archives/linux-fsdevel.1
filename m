Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E135E955
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731977; cv=none; b=Xb0I7uTxeEvu/6EuL95IeleT/NfI5mDMG4a3ctodZgIV6W6iOx1HRut8TEAy5Rgiea4yBwPe9GmFhBqbzcSneHffC5FhY3CpsdEiD2totUk2qOwxRCrs2GzI4cosegTlZzHcbPhrUDHoaD4pY1HruN3RqzRR/Hg8smrTacwYmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731977; c=relaxed/simple;
	bh=RGaD41iqQ+c/7rBk1zzpvJF4gwiFDxjxp+HOz6aumdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTZ05//7UBhuEmzhh+fjSN6FOOI5DdCWIKxInDh1N4RapuGbdhIsK3v/DMraUZU5cqwH2M/EMNEiLkS0IklhKWHkoHkux5Dc61zYSj8VtAlM9Wkr9IGz83M8beR3FUOru/wqYFk+Muj8TYetgvEttBLC13djJwnZJp8SNa5FrLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZAXuqSqb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZAXuqSqb"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so10770155e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 03:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775731974; x=1776336774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCNnjCDtLuHr5UHP7kVukL4KIBHk7Q20HqZoqNmaLow=;
        b=ZAXuqSqbONmfEHImpE4dWugSEIfdEbKsfYNVavdTGdDf8KPhJ1GdE+4h8MH26o6AWk
         7oXiUEO7+1ufnKM66lv1BS+fubjQnvNHALvtD6/iZauEusI0ooE8zjMT3sg1fFyEdCj8
         AEdUQe+x82lhRz0dofTsi91I2qVNJicWzedWA0n5oEC/qk+roWQ2f16xbbMRhc/XfoUc
         7JCwJmrY0CoSULtx7ydIC9OqtT071Niil7/Ntfj8JT36sjgFj+4rEZ2Yx0XYz5Oe5O3b
         iYQ0102HBVblOtwTxh/R4DkcAOwh1cKLAa4O2YhS9Cc8Cbk8pbhy/tzo4P/l4mHj0k+e
         vvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775731974; x=1776336774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCNnjCDtLuHr5UHP7kVukL4KIBHk7Q20HqZoqNmaLow=;
        b=EzMK2z+OHGh0SkO0hyKu3mZWf0CJP6oVmOLfnEXPqMW8wwEgLH2CIEzO+UD/Tmxlro
         fsGdXdcEYuXoUgCQySr2BeKGprLq9Kg0NAeT0fJsevjvSaWMBvZaPcUZ5x+Rm4H+ih5h
         S4yXR6v12wudJlB2+Zvh/3Ioyb7etN6AfuYGAYd2ACeIVYWVBZcA8A8uSwwjDz3Hf90k
         HzFxguzbqLPqTIWIeIpAaSATF9ETtmCmH/ZM4VFpntKaTbU/AsRKdTrsA4ZAM2SipAOz
         d3ycd3ALdvDjtMgA+2AkUJqPtuwu6AOEHJEL2BsZPiPLKqS+3WWXoyff3XAgq84URaKG
         9SDw==
X-Forwarded-Encrypted: i=1; AJvYcCUKMS5drQIUcF2D28DeTlrKw/+H9ckZk4Jqrs9igPR2T82U2EbNVeHhJLfNrEZnBGW6eBzx9Dz0oywyU7kQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj1m325Y/B5bKQeGDRjl+DYY6AODBNAg+KE5ohe3MvomzijR6e
	GkjpaThDDtIHWnJRxDJLq+HzD/92cbx561M8chPVnJlv2psnQS4jawotD+Sqf1Y8840=
X-Gm-Gg: AeBDieujVeosubOAIOcZxi5SO6aqM8r+9ltYHeavUjNDkLD1Hgp8GT1q9px5HPnn6eM
	pWFrlgrvsjkTPrPdXd5QZ+55CkSB4T7Vc6dTSmxVhMDO7zb94deWBKGIBfvZTqz7xP85z4aB5OX
	fxhAqvOCkgnW3S2/CDYEULvjpDQGigOus0WqVNfWcqsBnxh4LViK0NWOdSKgivylQ14tYPPoNJn
	18+DTkoUNbo2np1t5U/6JAiJoSYndXPQiaEgyIV34/WJnwrW7SqQGBr/VcJ7hURHx3VPsP7P2Qp
	FUOnNv8YbbjmxT1oQjED3jSb1oXl8ZJEYz+Xmj/ZnKfVRej7KaRxwJKroLh1PuWJYfhjrjYVKv8
	/PxXQXldnioK6HIIX02aieMjRJGlo982SjpSyCdN1I4k33FlV8KJkTUK73/RfrC7EBv3eU8hl5i
	Gn1kBJbi+5KLHG/HGNIH5aerfiKK4zezVbGA==
X-Received: by 2002:a05:600c:6305:b0:488:80b6:873a with SMTP id 5b1f17b1804b1-488997a4679mr330822135e9.21.1775731973787;
        Thu, 09 Apr 2026 03:52:53 -0700 (PDT)
Received: from localhost (109-81-92-28.rct.o2.cz. [109.81.92.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e1c27sm63954645f8f.26.2026.04.09.03.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 03:52:53 -0700 (PDT)
Date: Thu, 9 Apr 2026 12:52:52 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC] fs: drop_caches: introduce per-node drop_caches
 interface
Message-ID: <adeFBKzNq9rNzbHk@tiehlicka>
References: <20260409063503.3475420-1-wangkefeng.wang@huawei.com>
 <addP4MKmA8zfSN1o@tiehlicka>
 <dbb92553-58ba-42e1-b7df-b8450bd69d33@huawei.com>
 <addhuRqrB-u7oDp8@tiehlicka>
 <bdd49511-9b84-42cc-a286-9fdf2ef531a7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdd49511-9b84-42cc-a286-9fdf2ef531a7@huawei.com>

On Thu 09-04-26 16:54:48, Kefeng Wang wrote:
> 
> 
> On 4/9/2026 4:22 PM, Michal Hocko wrote:
> > On Thu 09-04-26 16:08:37, Kefeng Wang wrote:
> > [...]
> > > To use the reclaim interface, there are two differences,
> > > 
> > > 1) we need to input the reclaim numbers and swappiness, this is not a big
> > > problem
> > > 2) for reclaim, it supports swappiness=max to only reclaim anonymous pages,
> > > but cannot only reclaim file pages,
> > 
> > Why is 2) a real constrain?
> 
> This should not be a restriction, but a strategy. Our product wants to
> migrate anonymous pages to the local instead of swapping them out. However,
> the current per-node-reclaim interface does not support reclaiming only file
> pages.

Yes, I do understand that you want to keep your hot anonymous pages
resident on some node. Those shouldn't be reclaimed by the user space
triggered reclaim anyway, right? Migration will then happen during the
memory offlining.

This will certainly require some fine tuning but I do not see any reason
this should be completely impossible. Certainly a more robust way (from
API POV) than the suggested drop_caches. I am also not convinced we need
page-cache-only reclaim for the existing reclaim interface. I believe it
makes more sense to look at the reclaim from hotness POV rather than
anon vs. file.
-- 
Michal Hocko
SUSE Labs
