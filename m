Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2734EF1F
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567502; cv=none; b=P14jApUJnxdomnTA4lVmMZhrlcNAePAC02UbxfgwosGWJNnqPeGOSmxpDEIP5pY6lzM2yeXINv2rTt8frPA4QVaKm4UDVDEdZVWa85sSseyOSwyPFJd2feTJ/tgzPHFtjtaTexbfBDcvxODOwHgU1LEB268FO34FaBEpOiU2KCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567502; c=relaxed/simple;
	bh=pVW+S45AUw99y9jBlxP4dBrQBDW6s/gciYJoPeMq5zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzJDO4QxbkPSs+P3NvltVpAXDwwEuVMWJMBCfmZ8ji+PFeFVik0hu3GffSHRmqngbdPGQMaSoWHgwQssv6KW9tqr748tgYkasXLghDg4abfg7enamhreZadruOCOaSmKHY0GFkpb69eGabgRngL+WX3O5k9TCfLHqbLdgj49EBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=YxHumlqc; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="YxHumlqc"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51bfad59921so10682561cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 23:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1785567500; x=1786172300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hFZDtRlmAh/lYsw1peIZwBoJQwUYUw/2AfYQGPu/NJo=;
        b=YxHumlqccpBRSuSv/WCuyMZly5BIwNoPiTKXkxMw89qJiWrb3QLfD/fg4y83x0p/Bn
         Ih3UOgMm4xwq2ZSaC99WVqFwNOe+DlpUmPAJlW3KlNquHtQialEnJ3vxC0SCMCRIoeY8
         lBNNlMUGXsXG84RJrCWOUPtSc48qDbzy66IezCGOAk0mZ3SLi+x69qWCDuYFwsEuw8w3
         D4JowN0sokojwlZdaVzrT3rw3Bn8dnm5O2lEGwl2W0oBFydwe48UAK2ovBCvg++ZZ2+E
         eE+EpXl4qx1vgpPdNCGmTmQ+H705jXUvjH80YgR+29UGtLRFoAM0RpK6Fy/eJLBDwy6b
         Jaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785567500; x=1786172300;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hFZDtRlmAh/lYsw1peIZwBoJQwUYUw/2AfYQGPu/NJo=;
        b=cKCk5EIFhSQOmwPmBPQWiLs1QxI7TYXX/MAQzVza3WEXeVEhsESJ4x2swADAfl6zao
         p7XTwUdVYjCQGlvwZefg9NqxYecF4qntmWMY0acSWYl2Hpxyp1zVA1kh8tO6eZA0udW6
         HAMdMMJkFSYVqi6KfeXT6rx8KxeXBf93xj0AyFoWXaY2WwIPbpZRDJbSgZSI4y+Y9JcP
         obdP5mSGP77n62x5ld2GqXlft/alyQBazXRM8pTSWZ+UmMduL/G370XMQwpKfm2lA/lL
         Sj2xtw+JPV/mkUyuvybYKgoq/OOgI9kBJsBz9f5l7J9pNGCLEEdmJn9vZvCdcdav1P+p
         MKxA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+0Tl7++ZMMvnWvoEv83Zbl0dUSO+KiSWzxG50tTgiB36WQcZ5CwBG/btSi/DMSkkBdfR9cQk0fD3x+Bbl@vger.kernel.org
X-Gm-Message-State: AOJu0YyLMBRvS1lkxEVfLiDEoVG/dbZiITTeKQaLWS+nRbkoICDBSZ3y
	FF+UbjxMehGfrKEUJzJbOOIAxBIYA+hPK0qibqCJJAMS+0twqIea+xu62hGfMdjhBwQ=
X-Gm-Gg: AR+sD13UShgj99lQdXNhZPrJABvYv8pub5sp2zrvkHz+P+AxtbvWeQVdSAPdcbr+62l
	aSdaQ+e7g8hy+MYkvrfLV6WXyWFGrXVGEDgpAzZeeMYx5IcDvUsXz84CCDhzho+ztc0eEtOUd4j
	2hCkyJuXMZSfvupNqK8gQtOmZgzBPHXb8V4WUWgtqozRGYN/Tn1IO6Q84J+s2+eVb4wavV2p5Ml
	tQ8xB9ynARADhyFvmX7U7djuoyLATBhDa44XU3cltbb52LrmeDN1WzS/BvCkdp1E63xykZ6WGvF
	K4FxmNQjDLk8XP4mGya5xSNlDE32XQp7GRFdTZ+yD267RBlO4EBbVwkHRq8PuFxOLFOzh6ETjl/
	3iE45kf+C8OeexLITbpn9nQrkC2iR4UMwse8KT4XDWyEVuwWq8qzw3AiMIauKreYIppqqoS87be
	AgasN0A/VH5vXT0WX0xQ6dKYAkc8KqtB0LTYrX/msR4E7Gq78RmjX69bSnw62ze2bW962CSw==
X-Received: by 2002:a05:622a:4d04:b0:51c:1532:ae93 with SMTP id d75a77b69052e-52b567dc76bmr61225711cf.26.1785567500235;
        Fri, 31 Jul 2026 23:58:20 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4eb6a862sm23462961cf.16.2026.07.31.23.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:58:19 -0700 (PDT)
Date: Sat, 1 Aug 2026 02:58:18 -0400
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
Subject: Re: [PATCH v2 2/2] xarray: honor XA_FLAGS_ACCOUNT in
 xas_split_alloc()
Message-ID: <am2ZCpXRNS7BK1_g@cmpxchg.org>
References: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
 <20260730-add-gfp_account-to-xas_split_alloc-v2-2-5a56c2361d85@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-add-gfp_account-to-xas_split_alloc-v2-2-5a56c2361d85@nvidia.com>

On Thu, Jul 30, 2026 at 10:18:01PM -0400, Zi Yan wrote:
> XArray operations that allocate xa_nodes, such as xas_nomem() and
> xas_alloc(), add __GFP_ACCOUNT when the array has XA_FLAGS_ACCOUNT set.
> This charges the allocated memory and avoids the workingset convergence
> issue described by commit 7b785645e8f13 ("mm: fix page cache convergence
> regression").
> 
> xas_split_alloc() does not have that flag. Add it when necessary.
> 
> Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache")
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
