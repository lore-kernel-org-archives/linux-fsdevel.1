Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA130EF91
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785234285; cv=none; b=upibobIPKpprYEmZBzGuzT9vOJNZLGxdePeLpGF1TJ/o+DgRaj1Kd18qaLkl0j/CgtETpia1+FBpugPQppeFOncn8Goc1vH8HfgzOYhRn4kvXA1+b7LU4JDOdA01UIvsWUcr5PiRc5YdJlarUOXwztadWmfrlV9UV1oAUxpTJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785234285; c=relaxed/simple;
	bh=94E8HRVRTivLOZTA/gFWLgSFoHdq1Rkcfb5c2xXbFvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Po4MAQRamChGkR6miYdI3H0HlwTOvgWqIe+OFhCwzbLpDWgo2rkqErSQRCRqR4yVFq7buDbcczX0HmyJlaIZW8xRbdZIlEEVNQcUURHQhgrYzC5x2qR3QhJc/gT5In1XUOGSwPjD1lFci2xNtEtIl9tnI3BYu7cRjDXOnQYj+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwxMssBL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwxMssBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06421F01559;
	Tue, 28 Jul 2026 10:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785234284;
	bh=s4inssPqpsD7BfQ38galVPAMa7N06dym7Nw4RodxwSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jwxMssBLhOB8rIsSMd8YAnlLthfYIHaV8LSqShCqV6EsTTXlWGfBhgH7l/ZUmNVGN
	 J915WjAr8AC1Ilkz6D2SxsE/6uiq5tJk6TqRbSAG4cwM9LwVAB82D8RbT02E/Zcdrr
	 DUIofSQcqBnDdGB4RLS6OrvgINMvJwvz1wyfLd4uj0GWR9M8mD6Y2glaqnLczDbzvE
	 5vBGJAFwVK+vPnDDtPp6E1tJUufKmC2LMTCXfgqiLd+ylXN83obNIgF0GOV4B6yEcV
	 SaCQNqj/L+aGnIEl6CrmrmGLSP14oH0K/WgSX36ox0vfyheIDlDAi814j24YcGsARe
	 W8kiYITkduYjg==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id D486DF4006B;
	Tue, 28 Jul 2026 06:24:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 28 Jul 2026 06:24:42 -0400
X-ME-Sender: <xms:aoNoas9G7TBIfPeEHgDvlk5EhbAe7R_soy7Wyydi-8nyyo_3EtVLdw>
    <xme:aoNoalLn5ea_pHQYwa2OqD1z_vIXOWiboFC293hVRkEWKY2T8H_lD7nsXtWJr6QRd
    eO0-J9aqggWOxr9NbxDfUox7W7ugCqW43V5MK176b7kd8vDNJatYA>
X-ME-Received: <xmr:aoNoandtDQ42MXn6wBoWYA1DjCla7_EpsmB_iUDMsOogJKKpumqeKLTqTUKEGg>
X-ME-Proxy-Cause: dmFkZTEyehosGDrX7K3E/QOll5f4laseRKTHb5EXYx6g/CSljkTyK31g3IhRDiB55hhpRD
    +rj6sLLTD0TAT7a1nJudQaenOaU0Q6jK5rqmvXufpwIYH4DKRCeskDfAKHN3gUBRky2CHN
    UhSqI4piK7mkQO2R4Aw7x87pfhDwGI73W92J/c1tXRrQe7AffmrnpfU+uu6DJT5c1/E/dT
    O9lrj1TcFK6FzpMaIbm7xoPsGBMduVWfYzYAgkfOyQ+P9dzAUlUuX0zFB2lZdWSSp8DRmC
    VV7sqWMMjXGNicieXSixPSHMw2e439xTLDc2pNBjzLhPrfNfnnxK0jfyj7sC40E4PJSpJq
    NAWSrXzPUDBSPoYFlO6XEhhyqUSe/vFImDBq2g9YLHDhYpzCT5344zpofLOa9dlJ0vDGHs
    xx5IM/OHQngE6vqpqa3YRLSm2ex7bALcbG3/Lj4eZMr6zIOSM/RQun1RdZJxT7OYb6F9Qy
    8SVHdcD/UstGp8BqAbbHKLD30zXcBED8u2VmrAd21BmkFSmUU1sPjunbH3qhz+Lv8HLEnM
    Q4VggKqr99LxIWHJ79TO1s1Ss2JcDQqCNfXlkRjiUHV63UeUzK5SoorTmND/V6Ezd6kKyE
    8aKLdmRP2gCvWF3faEMPNJ0egFJDc9C5pic5o19aFNP12sAu6e1210B5IryQ
X-ME-Proxy: <xmx:aoNoaqbc_D1ygYkAJW7Obc9xJEIpk_hDtBxAh4jzpaefUF1nxYy4Rg>
    <xmx:aoNoalCPpud04phSjS5k1GV_imkGQKrNIsegsS9Krl14ZbLIlGWH7w>
    <xmx:aoNoalLsNdrmPqQNMOZHfz6akZvAOTsFUcwN-B08lljVrUrtu3tUfQ>
    <xmx:aoNoakowoblts5ut0D0t8TjzCr_mbWriI8OdXUyccoYugpWJy3ECFw>
    <xmx:aoNoamOyTVFj5wfP5SLV9zq_xIPM1VYmIubpFyjM45WMbyuZbRtH8-cx>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 06:24:42 -0400 (EDT)
Date: Tue, 28 Jul 2026 11:24:40 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Kairui Song <ryncsn@gmail.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	David Hildenbrand <david@kernel.org>, Chris Arges <carges@cloudflare.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/filemap: __filemap_add_folio() restore index before
 retrying
Message-ID: <amiC5t0HLWar2NCf@thinkstation>
References: <562fbfa6-dd6d-0b6a-2461-ed2ff1173bc8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <562fbfa6-dd6d-0b6a-2461-ed2ff1173bc8@google.com>

On Mon, Jul 27, 2026 at 10:24:14PM -0700, Hugh Dickins wrote:
> In __filemap_add_folio()'s split-a-conflict loop, xas_set_order() is
> applied repeatedly: each application modifies xas.xa_index, rounding it
> down according to the split_order attempted at that stage: and if all
> goes as intended, it eventually (or immediately) converges on an
> xas_try_split() to the required folio_order, with xas.xa_index now the
> same as index: then xas_store() puts the new folio into the xarray there.
> 
> But if a new node was needed, and GFP_NOWAIT allocation did not get one,
> the lock is dropped, xas_nomem() used to allocate, and sequence retried.
> If (that part of) the xarray is unchanged when the lock is reacquired,
> no problem. But what if the conflict was meanwhile resolved by another
> thread (perhaps even doing the same thing, inserting a folio at that same
> index)? Isn't there a danger of now putting our folio into the xarray at
> an intermediate rounded-down index? With !folio_contains() bug to follow,
> when CONFIG_DEBUG_VM=y is checking for that.
> 
> Fix this with an xas_set_order() to restore the original xas.xa_index at
> the bottom of the loop, so the retry does a full re-evaluation after
> reacquiring the lock, and cannot reach xas_store() with the wrong index.
> 
> Production was suffering from rare SIGILLs and SIGSEGVs, executable text
> found a page away from where it belonged, !folio_contains() bug hit when
> debug enabled: symptoms not seen since this patch went in.
> 
> Fixes: 200a89c159a7 ("mm/filemap: use xas_try_split() in __filemap_add_folio()")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org

Makes sense to me.

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
