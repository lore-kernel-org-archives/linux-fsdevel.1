Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CB41E8332
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220156; cv=none; b=WxcI4RU/jHssnOhsUuaj3J2/bXZPDP5Oa+36di88p+n6Q1kUWz4krY3xnrMlWY6Vi61NLGELKZF13jmvmIT4PayJIy+oO+NJJJY8sfnFHw9PLTIpV439zLgnJyulnvKfgFtuSSt5BdX5QqTRgPXuJI3xzkogX03p73Mh8k4C7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220156; c=relaxed/simple;
	bh=gyDJgflFgmduOHp1GwgR8Z2J+9wB3m9UnT5xMUNJkCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIaJ9HB8P5u2U0gCWeku2CwotOk8gKpPYIM3M16u/O6UUhmS8YWOidWVKB1gvzCiVywfCI+DbW99TWW4uKVvU+3vWLFpHzpT6NsyumbfVt2oeB1ZL2kTfY7Xzd6QuX1azs32jnvoSdCF7gjn6srU8X5ijZv5BTmpL8O1LwL4uHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGTb8Ite; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGTb8Ite"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-463f00cda04so3262675b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 19:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776220154; x=1776824954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsHolYzCuCMig4brfjVoKd0+wlDIH68uItyQD+saKOM=;
        b=XGTb8Ite9ZUih/d9ANXmrwf6lTQHoO3sprJV6nlBWwSUbiB8/HwTD5XB7i8tIvuixQ
         X+weVpBwRZCFVhO5z3d9MOxTVK8x+YJEyiAzzhjiipKWmgyzrssOHdMzptXLQo6ZyfLM
         WuAaV7UO24ZthgDpodsAWehfjs4pviKRZFCW2C1jvcCVdRIsHfCzEHRu2v3hfnBKsCyZ
         POEKJHs/4QZTOFyU1MRNOqDua6MoS5gCbg4XAyIeY2xRsSN2/DBQ6z0tKSmcnFtsXaAd
         yPF/dtBaNjdWsfcOr/Liv/uZ05qBKbMciP5Zc10O5nGOhbw2oFudL2oQvEyK3hBexoSF
         2oXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776220154; x=1776824954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XsHolYzCuCMig4brfjVoKd0+wlDIH68uItyQD+saKOM=;
        b=JIocQ729etve6JZtDmzuHTyqnru6Ob8dMByOHJ8X7hL6MyJDSQ3r+B6xcWFCxP7Il0
         GaZ8ZdX7aur+khTS9jkoOFJXYKqb0EvRhLNj0WJLinwmBUA2q4Fd1xJkKtBLxcDZPWQ2
         LsbcEFKqtzgmf2gosz1t+pX0NZsJ7diC7AbTM+uKxEKFre31m9rvUOYY2GDTHmy9o+n3
         bAWPel6dRsJjY0mu4O8LbtVR6eRPZ+7EsklBg0+4yX7te5nHrN9S/xTLUXiWAyi3Wenh
         za/WVUptWjahIRrRr9as21he/Ed+2plvElP+4GcfTdAQqnbStjNpZEDvWXVUteTUOuc+
         OYWw==
X-Forwarded-Encrypted: i=1; AFNElJ/1yDHL5hy7Lr230GXre6lKEx1J2G6D6yWBnxrVu9epv5MM83C45CHy/5/WqhcUu9GnY/q+2mzidnQiJzUF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv4NJE9Wd+ivPfkkRDP/dWc/FcdiC/y2Y6J7DF6AEiOQfQBTnq
	tYwYcN85jYsIBNhTq1/r7vRIvi/LIGJVnhAB9yeGMVC+Bt2AT1gRzz9i
X-Gm-Gg: AeBDiet1NMAXPi72hyKS71HjXt6hxKd3PA9KC3A9V1WDNwnugBlHcJYlhoaMtokbH/j
	6Em29MR/utGp8k5792zdIRjVJEBrCMuSKwdAbPa3nKE0R5sO6BUGEGo3ehY07XS1g9JH1bhra30
	MTwv+q6iw1ziZrAkIcIY5l4XMMSyc69ntb/ac7LubGGLtde3y5MHRQIlkp9P5GD4udiOSTnwNjb
	xV+lb6QBDNx929U4tHq/ivmK91NNu14fcN0y8A6SphQtB4qg/HBDp6kQuFHuGXKGlCsDX5wLmwN
	xVm5OcGuEOpdYaZ6IiuxRMV+J3IKStwdujjlpeprgj2Jc10/dlLzPy0Y4hjVuSaZzpoZ12rZn52
	sValSdLmARxMyCYE8hlpkA+PTGfUCE5Vu3R5t0e+jbrvjyoHxI9EhKEB3eg2blbIEWIZDsYJgLC
	m2T6APpi2PARY41IOYBsLY
X-Received: by 2002:a05:6808:c1a6:b0:46a:cf7e:4b5e with SMTP id 5614622812f47-4789f50b740mr10154449b6e.43.1776220154167;
        Tue, 14 Apr 2026 19:29:14 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42689699dc8sm348039fac.14.2026.04.14.19.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 19:29:12 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ye Liu <liuye@kylinos.cn>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm/vmstat: remove unused __node_stat_* wrappers
Date: Tue, 14 Apr 2026 19:29:09 -0700
Message-ID: <20260415022910.1890050-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <9a852e74-1499-4a5a-8e98-56a33c67d639@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 15 Apr 2026 08:50:54 +0800 Ye Liu <ye.liu@linux.dev> wrote:

> 
> 
> 在 2026/4/14 22:59, Joshua Hahn 写道:
> > On Tue, 14 Apr 2026 17:15:20 +0800 Ye Liu <ye.liu@linux.dev> wrote:
> > 
> >> From: Ye Liu <liuye@kylinos.cn>
> >>
> >> Replace the single call to __node_stat_mod_folio()
> >> with node_stat_mod_folio(), and remove the dead inline __node_stat_*
> >> wrapper definitions from include/linux/vmstat.h.
> >>
> >> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> >> ---
> >>  include/linux/vmstat.h | 18 ------------------
> >>  mm/page-writeback.c    |  2 +-
> >>  2 files changed, 1 insertion(+), 19 deletions(-)
> >>
> >> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> >> index 3c9c266cf782..54da7d820f78 100644
> >> --- a/include/linux/vmstat.h
> >> +++ b/include/linux/vmstat.h
> >> @@ -440,24 +440,6 @@ static inline void zone_stat_sub_folio(struct folio *folio,
> >>  	mod_zone_page_state(folio_zone(folio), item, -folio_nr_pages(folio));
> >>  }
> >>  
> >> -static inline void __node_stat_mod_folio(struct folio *folio,
> >> -		enum node_stat_item item, long nr)
> >> -{
> >> -	__mod_node_page_state(folio_pgdat(folio), item, nr);
> >> -}
> >> -
> >> -static inline void __node_stat_add_folio(struct folio *folio,
> >> -		enum node_stat_item item)
> >> -{
> >> -	__mod_node_page_state(folio_pgdat(folio), item, folio_nr_pages(folio));
> >> -}
> >> -
> >> -static inline void __node_stat_sub_folio(struct folio *folio,
> >> -		enum node_stat_item item)
> >> -{
> >> -	__mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
> >> -}
> >> -
> >>  static inline void node_stat_mod_folio(struct folio *folio,
> >>  		enum node_stat_item item, long nr)
> >>  {
> >> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> >> index 6f9b7b081ab7..ed3301753e89 100644
> >> --- a/mm/page-writeback.c
> >> +++ b/mm/page-writeback.c
> >> @@ -2627,7 +2627,7 @@ static void folio_account_dirtied(struct folio *folio,
> >>  
> >>  		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
> >>  		__zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
> >> -		__node_stat_mod_folio(folio, NR_DIRTIED, nr);
> >> +		node_stat_mod_folio(folio, NR_DIRTIED, nr);
> > 
> > Hi Ye, thank you for the patch,
> > 
> > In addition to what Matthew has pointed out, I also wanted to note that this
> > substitution isn't trivial; there are differences between the __ prefixed
> > version of node_stat_mod_folio and the one without. Even though the correctness
> > of the two versions might be the same, I think that a change like this should
> > be supplemented by a description of what side effects this change has
> > (i.e. introducing additional overhead from the cmpxchg loop).
> > 
> > Thank you, I hope you have a great day!
> > Joshua
> 
> Thank you for your review, Joshua. Regarding the difference between
> __node_stat_mod_folio and node_stat_mod_folio: in the current implementation,
> both functions ultimately use __mod_node_page_state, as mod_node_page_state
> is defined as __mod_node_page_state. There is no functional difference
> between them in terms of atomicity or overhead. The __ prefixed versions
> were wrappers that are now unused, which is why we're removing them.

Hello Ye,

Thanks for the quick response. However, I'm not sure that's true.
For #ifdef CONFIG_HAVE_CMPXCHG_LOCAL in mm/vmstat.c, I can see that
mod_node_page_state calls mod_node_state, which includes the cmpxchg loop.
I think many users enalbe this config, including x86. IMHO, we should document
this effect of the changes.

Thank you, I hope you have a great day!
Joshua
