Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2993277029
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739668; cv=none; b=i4N92arSqzOAys98fKxipEOc53rCkHMgT6CihM26lFzqLVLjMYdoSSbRC5qAaOOlC0Vt28qHu3kn2U6t5BU8UDMEPfnWRIZV0WNp/yponNJoJLiobCuPAZCpbanJUc8TK/RQQGOb6obgSjXdudyLleeyGy8QzghnAy3AMZvh/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739668; c=relaxed/simple;
	bh=FAuU+viCRyfOazEtOV1ewbhPbA4M2rURXfeu/lfxZdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STSz9GMiTe16lnfvJbkRo1B9246ElJEWAki2d4eEb+uCpooCF3+eHSoRc1PVp1fbK+KyM57gd2Fhdya9BSe8HS5XJQOXZoGdF5S6oIpWOY5kDM1XqFK833eDsktnTovlq79W4WdcZdwz2M6BZL7hLDpkVhSiqSke7ethFjVcPSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b/6/BKg2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b/6/BKg2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b8efed61so7454805e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775739665; x=1776344465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pboOsBqZdZszXx5xrZPHuc+J1U0ko1Sn2+9rj83d0ao=;
        b=b/6/BKg2AX0C822JbMPJ8N0fS7U4RZrwhK7Lc979esukKyjeK/Qp2RvjJjRoHJNi7U
         m/TLj0VoHhe2dcyaS/BMLSJVAx/oBhAAt6nC+xn7qzCVfvfJgoX2dPATLFXgryAxz2s6
         2Z4m4C060rwifwYJzmh2GRBje4BTVkXB0kW4jEeVO75aUr0OoRdA/eQ4/qfIl99U7RV0
         n5gGc26B3gEjGJkk3UVSvzvANznpZpyGglW4Y+H5W+pSjldZFNIXytj9fBfkYAqbYD6n
         hq661QhEbGJlOKA5weYw9ZtQyQEQJ2cDT/Xdf77QBSL7iVzSNQbDRrqTyG6U1AM4Xl8O
         aF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775739665; x=1776344465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pboOsBqZdZszXx5xrZPHuc+J1U0ko1Sn2+9rj83d0ao=;
        b=FxL6OQl4CpjTK+OLzg9fdGty0Z4qYITA4Q4M340MDuUWZA73TwXVEj2xVpCAs8bQnQ
         lhAFJN194PAZZeF1vAzHlnebzPogz7C5zOmm6sP/MH4yVA8kfUiHnu6P3lU/DIIWxt4x
         UxuraCwJ370tpEEYZGfFQhhJXdoplGoeTBkbd7Ayk7kFbhUkg0JPHLe8Y9lLy2koSMVk
         HY8KKKRAEY00SHDNmReDwYk5u2+8xUI7R5wJgpmflLz1F/sy9iv9LxSFXRRp1mHH1ZHP
         WTJ9ibOp/dSg58MoKmXZCAYrQ2a2NdyT5YTqU8uM2NvxfvMdnrxQ0yCKtSLyZYOwWoj2
         zJNg==
X-Forwarded-Encrypted: i=1; AJvYcCX+U/FNqQd1lCfPJwatuUfeyy5rn1z7ugGZZ7t0BtghQ6eHE4jti55K0MunE9c20m+kUlrpiJqEDOUBSvXl@vger.kernel.org
X-Gm-Message-State: AOJu0YxF/s5pTwhvXFjeVAzMwuY0bLsO6yG4KkulmtXPUGQZh0LePpzg
	ymLzbieLiJzPjN6xZsOtNsb9NVg7FKCTjgM1gAbK7Ghsd64ECfTRWnln1/xcrUW3KlM=
X-Gm-Gg: AeBDiestn3O5NmpkXWvhiTr160UKIfQ66c4ZuL7dc16lqc9w3v3JCHN2MxCl+Au0ysy
	9SokyKX425oiIn9zAH4I5DlXK/2glbOZIrfC23f7CYg34QVCGC2W38zfwRuCNmwv2+mcO2XBFTV
	dDIRtpwXYTt1frqLz/3L2r0S5Af+fpTA/mLiujf8inc2rXgXV6KPeKJJ5Bc80NGyznLyETuXWEV
	CEXYy3V1xSSQx312V1h9evE8GC/bXrRyMWNPHf4ZSDACf74+Wvlq13EfF4Mxi7qIwC3i20sd+Lq
	ksCmi51rdseWk1gALW/yv/E1AA0uDXSaS2N1O6KQxGH79dzQ6Ml4/5Mqr9fJ6qpEXssSG5Qjf8l
	1Beneg7KSTjqhaHg3EQkEBQMjX7qm1t7a58pO4UlLONby7lbDdJPMtwSBwGrswCBQ9zMPWTEBAh
	IhpR1g3I86/VUnVvJf7Lsdg0dLCALWSNzSsg==
X-Received: by 2002:a05:600c:4a12:b0:488:aac9:7a31 with SMTP id 5b1f17b1804b1-488cd23f39fmr33183335e9.0.1775739664774;
        Thu, 09 Apr 2026 06:01:04 -0700 (PDT)
Received: from localhost (109-81-92-28.rct.o2.cz. [109.81.92.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d5e969bbfsm4486737f8f.1.2026.04.09.06.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:01:04 -0700 (PDT)
Date: Thu, 9 Apr 2026 15:01:03 +0200
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
Message-ID: <adejDzw8Mf6407-a@tiehlicka>
References: <20260409063503.3475420-1-wangkefeng.wang@huawei.com>
 <addP4MKmA8zfSN1o@tiehlicka>
 <dbb92553-58ba-42e1-b7df-b8450bd69d33@huawei.com>
 <addhuRqrB-u7oDp8@tiehlicka>
 <bdd49511-9b84-42cc-a286-9fdf2ef531a7@huawei.com>
 <adeFBKzNq9rNzbHk@tiehlicka>
 <95bc0034-a72b-449c-9be4-b691fd03dc1e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95bc0034-a72b-449c-9be4-b691fd03dc1e@huawei.com>

On Thu 09-04-26 20:50:33, Kefeng Wang wrote:
> 
> 
> On 4/9/2026 6:52 PM, Michal Hocko wrote:
> > On Thu 09-04-26 16:54:48, Kefeng Wang wrote:
> > > 
> > > 
> > > On 4/9/2026 4:22 PM, Michal Hocko wrote:
> > > > On Thu 09-04-26 16:08:37, Kefeng Wang wrote:
> > > > [...]
> > > > > To use the reclaim interface, there are two differences,
> > > > > 
> > > > > 1) we need to input the reclaim numbers and swappiness, this is not a big
> > > > > problem
> > > > > 2) for reclaim, it supports swappiness=max to only reclaim anonymous pages,
> > > > > but cannot only reclaim file pages,
> > > > 
> > > > Why is 2) a real constrain?
> > > 
> > > This should not be a restriction, but a strategy. Our product wants to
> > > migrate anonymous pages to the local instead of swapping them out. However,
> > > the current per-node-reclaim interface does not support reclaiming only file
> > > pages.
> > 
> > Yes, I do understand that you want to keep your hot anonymous pages
> > resident on some node. Those shouldn't be reclaimed by the user space
> > triggered reclaim anyway, right? Migration will then happen during the
> > memory offlining.
> 
> Yes, that we need.
> > 
> > This will certainly require some fine tuning but I do not see any reason
> > this should be completely impossible. Certainly a more robust way (from
> > API POV) than the suggested drop_caches. I am also not convinced we need
> > page-cache-only reclaim for the existing reclaim interface. I believe it
> > makes more sense to look at the reclaim from hotness POV rather than
> > anon vs. file.
> 
> It is already support only reclaim file pages when swappiness = 0 for
> memcg.reclaim, but not for per-node-reclaim, so we can just make a few
> small changes to enable it(no tested)

This might be small changes wrt code impact but they are changing the
semantic of the interface and that needs proper analysis of impact,
potential regression risk and also evaluate whether this is what we
really want/need. Memcg has been special in this regards from early on
and we pretty much had to keep the status quo IIRC.

-- 
Michal Hocko
SUSE Labs
