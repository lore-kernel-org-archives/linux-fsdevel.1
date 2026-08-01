Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442B2580F2
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567480; cv=none; b=fO/wFsOLykXtSyn9d7zoX9u8/5fHOkiJ9KYLbpxn8cZ4gbCqrNrUzAgZB6dPEg4fXoIjUQpXNlUcgv4EaYUbanxT/dWilrx69q689epEqIOxsjNRbxWYmefDhvJEXm+NYA7DhKEdA9L1th2zlK2MSb0d0zzx5e0kBczA/9uhEBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567480; c=relaxed/simple;
	bh=48PPM40scDjRX52NBwqqnrJ9hzRWEqiStrS/eq1a6GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkF/s8u/IRfK+YW0/GLlczNXEyy5JiFmkAeejV9WbZk9IjD+PmnllUii8PgPuXgA+KWKeQ74Pd/38j3jJE0ATRpkEQVlnTe9hmIQZqeXJGwTr/VwmmMCx1Fh5fmMCJ6jWUgWPm37TVqwQ2LpdWXWtUJSefsFrZ45fg71+BQQaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=BkoRITIO; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="BkoRITIO"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c04bf4711so15364191cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 23:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1785567476; x=1786172276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l6qM8HHytw9VOLZx3IXJ9Xf+DVG4kFaCSzoE8n3hynw=;
        b=BkoRITIOCao+o/HwBG/g+h79iZhkuMpEDlvVbiJzH5qkFGq8+4E1Mqs69WMjc13wY/
         pSR9e5YQ4vqqfS6kIiTsUU7gHq0jXevKu0oY34FjRhtj362gqbxIAGipdJGVe4J9iFEg
         R+x7++MIi5bYc51n6BcAZSo4FOD8gg9JuSQb/v9TgabvyS86SX7APw0o+svTnb7f9XjP
         IkOAAZe+yeCSjtQyt5eN+ALD3zHRPNI5foSMdGdjTVud2IT8YcjMAf2EzuzrhRo+2aJ4
         jaGl6qxnzl5wArLTtC6JII0clErEyQ/0vTq8NaEdqnspuh6zoiyrUEk0BZMAT6JKa0Aa
         o2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785567476; x=1786172276;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l6qM8HHytw9VOLZx3IXJ9Xf+DVG4kFaCSzoE8n3hynw=;
        b=EFnmzjgW5ygTTJXM4fcnqVi9W+u5s0LxrLV8gSzpjFhDnucKy1pISU2tpP3yJx8XAM
         scft4i5rwIKBNwaMiWGy1+uPouwOvb4BMAdqQaRwkZcQmM0JCEwm1WuMFyScDHjTftPl
         PXGipXAj0sEJA41oDlO8Na5x4CLEVPQDrqthkhqYhbLcr58Crc2MT1mkAFGk2M8ouWHa
         hS17dC7UHInlnhHtbyGATLQY2h8/ivTyJ7RYj0kzfqBIYGqMcP9kcqJx6W2P2vbG9p6K
         fLyVtfz6IF+7jV8R9zpEs89DT33nNYlNezyFfsxXSsNsWmLQXGEUP+XsJWis5LoXGuUF
         99kQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDsVH2LlI3uSLlaSavFm6lCI7eZH2N78nvDSEeobKpNjFTqL1GAabKqCmhGRemAGfIgj8NopFwGJutkl3q@vger.kernel.org
X-Gm-Message-State: AOJu0YzStycNznGwmfBV7nSVjoVJ04zOpCBBAkR6W1wVbiadz3KnpC8b
	5hrHePu8lqSpOcrV4wSSCFN5SBuHa2+8jGLy+DDrg0kRiyr3qIbQs+Hy6f0bG9igyCE=
X-Gm-Gg: AR+sD11UxsViN3aA8jHAUC6uimDEJTsr9vOhGjMTf7XvGD6VL+DtYEM3dnGN7HG70Q+
	MCwcJiFG0tdo36ZxZa+uOO4mzvH5aoWEfAhUqnXRDsqXu+j2Fk7WPdKaofAuB2eeoZBajDJhF9J
	RLDHn9avhjBKW92ogWHMOY4QtTURnnDCwV7MTs2lr8wYx4ckvb9tNlaMvbEbH3+RiaEdwCIhmhD
	hHSJRj+wkkDZDFZ4ddFiFWP7RB3DHJ9UbT7ZW5jWDCt97/xBbNPFhfgprVy/iy3KwjnWIxxc9AL
	CR1avJKzBhlBGkpNCLTXDCEAVf8WKRvH5FZI4LY74uM8Y2cql4zeQ8F49KUcCx/OwEaNixEv5sV
	xT7+vT9/rYR9UxVHbQ15fVhGB8PYcAgB9fR+V0OhGU4hjbguvgeKVFpKGOzzYGm568WSBg7fymR
	lnHXtxLKeRjREphW/1CzfraIOhe0wimq1VzEEizCoKqDVi85vIqt4M2Nh86EA=
X-Received: by 2002:a05:622a:4d98:b0:51c:19af:6330 with SMTP id d75a77b69052e-52b567cdeeemr57512221cf.36.1785567476437;
        Fri, 31 Jul 2026 23:57:56 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9084a8386a3sm13495486d6.15.2026.07.31.23.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:57:55 -0700 (PDT)
Date: Sat, 1 Aug 2026 02:57:51 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	William Kucharski <william.kucharski@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] mm/huge_memory: use folio's memcg inside
 __folio_split()
Message-ID: <am2Y78jxTQTlIPPe@cmpxchg.org>
References: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
 <20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com>

On Thu, Jul 30, 2026 at 10:18:00PM -0400, Zi Yan wrote:
> During a pagecache folio split, an xarray node allocation can happen and
> needs to charge at folio's memcg instead of folio split invoker's memcg,
> because for example folio split can happen during reclaim and reclaim's
> active memcg might not be folio's memcg. Switch to folio's memcg at the
> beginning and switch back afterwards.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache")
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
