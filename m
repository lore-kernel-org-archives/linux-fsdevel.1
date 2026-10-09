Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F03E1701
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791588537; cv=none; b=oi5TsNL/v3faSkx4CieJAdT4iuGg785UOUxFMO6z8DYZ3PKutxj/np7P8YpNxWzWbqbQjVbrGop0a7SR/i9Ssay22Rg1EsOUBUfBPSBMgoc/0zj/0ZXwslTePDxF5k5EjsNk4TDhom2dY5AYq5P6OkH5g7OJXxp0Cr4JPNB4d1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791588537; c=relaxed/simple;
	bh=3p5XqxeYR4CnRWjEkfitWmRDeFwIoCUnBHgm/AzDALk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU7Uv7Wq4Goypl3RCR7zrgCeYy9qjiaGS5Rz8lXTKMegoFPFfSQQRu7kkvhyz+CybzxabAckmkpICekvHjbAf/lweXcMshzTzKTD+1AGreucHstbfU5mfoarDWTM2RUkpEenOkflZXeUgFg+UyHOG/XVDrVPRv75iifLsHAJAdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ih4qwODr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ih4qwODr"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533972e0cccso2755841cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 16:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1791588535; x=1792193335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i8fGiA3xoaDWPU6XKjh9IcWOAynrlR15W4KHQ08CPA0=;
        b=ih4qwODrnvCH2f+Gc10APFAT/TSdW1gD3TOiiyrYhoxJIyC0o+X+be7weMOMGX6Lye
         dgQzaI+GcB8/xQPR+8OPYqWZz7BcYHOMPdF44dFY/tIA0mmw0c50NHdG2i/Ev82MlvYg
         DH9zdRGUwi5r7V1tvIAFkluekYD7yPAWQlE6MRO9dz0WKVzPVE8LramMzIhGxekL1/cw
         EdjjMDD2jYotwjTfL9LszMZJDqfqPd1Qq9aqj+6IG77NWpAPWXLu1ympjbrJB5NiZ9Wb
         smZeHXua4b5Lb77QwGo1adsWY81qMcsN0PeDyLbMItvCz1JrMG1SviMVpuyuk2WRNb4R
         qAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791588535; x=1792193335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i8fGiA3xoaDWPU6XKjh9IcWOAynrlR15W4KHQ08CPA0=;
        b=El727XKU/M7SLMl0JubVUEdocqBSmFkWdqPyoTyhTZ3fc+0Vb/Uk+/nlLp9r7+388k
         hHCcayupprJD1nyhH1bNxFfOzWPi6GN4FqrtIaQUFeb/ckgBOFrlunyfoFvWIy7TOUgz
         0NdEgHblEVygYN9W0bd9znUYKL3am/jD1RrLvohR07uqyqcvP/aUpEqzbaya+W19PjdU
         05N1lT58sgvHO5oGJQMobZMx476+UIzyOLXQngILhKmn/P2iCz2ouoOqI7BfG5nUxj9C
         ZBkE4SR2bxaUd4gHTohXme3JdFSZtX/jICNadtmXfi0DkF/E+am3+xU7R/gXC7NWHMSh
         BYKg==
X-Forwarded-Encrypted: i=1; AKwUvByuEGMdJ1VQz/VMWZA8C+5SyGpe4bho5JzCTOkGaAviXfZO8ZchOhleCWUGDWkPn6pxKEnNthDL9r8PaWxs@vger.kernel.org
X-Gm-Message-State: AFq9FYIUPpxGnHS7snNLivCTFms9jBk1BbQVjqv/4r5dxRHbeeJVIbYP
	2in3BVCvmbEkq/YuHcdg7/AX42Hdfud2oy/SKER0yWL4YpurMnYMwuWgbCVhpGrVfr0=
X-Gm-Gg: AYBFou1X9gLuMWMteu8ZcxvRLA3YA4on1xnLaLtjT/uugaWBfawEavZKfEbjiw4b8dM
	nx7JVRRgoQ1sUOYhm7u4JhMbxwyJONyRcxuKsyQyIi3d0iCzN5wKXwsYqrx1Y7Hcku1HJUISBRn
	Io5d+4fQ3Jn7C8OcGxNIkkcAfGNIIn3ryMavsTcESxJUNuU1cMIPbPE31IWXKtN73Ejphfrm3cK
	4LyRKHtmNwUmlq0Om8VWx/QiMFwGEsMEBsVbSm9J1CqV2lDP6/LaJkBS7XJ/jMlTg78fSDXsC1f
	+813+Yb77wdL7DztpFG7kmzNu0XNDrQkpTsk6ftm7yvew6ONHgr1bxfJrzHNX1INPVp4pH6s0mE
	incnIoPS5qIg9mBYRxWj8xMhkFwpIo+hsABBAPFd7HVl2Y2py6G+tx/k2RlOqbjkY4+GkTDniDj
	BBfH3KtrUiQudWN8jMDTWWfaU3MAUDTfBeQDBef1wJN/BtlNb7KsDzI9VJ8jyoBnJOF6QKgC+gS
	kPIKLR6BgGJNVRjTO/JourijBigcmyWVxVjx9r6vM2m2oJLVywV4WQ=
X-Received: by 2002:a05:620a:1a1c:b0:93b:d7a0:d9e4 with SMTP id af79cd13be357-93ebd263d45mr580212785a.62.1791588535148;
        Fri, 09 Oct 2026 16:28:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984889fsm301000185a.13.2026.10.09.16.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 16:28:54 -0700 (PDT)
Date: Fri, 9 Oct 2026 19:28:52 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, willy@infradead.org, vbabka@kernel.org, 
	brendan.jackman@linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com, jack@suse.cz, akpm@linux-foundation.org, ziy@nvidia.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, ying.huang@linux.alibaba.com, 
	surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org
Subject: Re: [RFC PATCH 0/6] mm: pass alloc_flags through folio, filemap, and
 bulk allocators
Message-ID: <asloWFM96BATH8SB@gourry-fedora-PF4VCD3F>
References: <20260923211041.3127588-1-gourry@gourry.net>
 <asdTptfeLkuypU8t@gourry-fedora-PF4VCD3F>
 <df588805-6f97-4ef6-a64f-39222669bf3a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df588805-6f97-4ef6-a64f-39222669bf3a@kernel.org>

On Fri, Oct 09, 2026 at 10:55:05PM +0200, David Hildenbrand (Arm) wrote:
> I do agree that two sets of flags is suboptimal, but likely more flexible. I
> guess an alloc_flags only interface is not easily possible ...
> 
> I do wonder whether it should be:
> 
> 	typedef int __bitwise alloc_flags_t;
> 
> instead of "unsigned int alloc_flags".
> 
> ... while at it

Does it make sense to leave alloc_flags to internal-only state
and just implement a new flag field?

gfp_t       -> describe the page (fully public)
req_t       -> describe the allocator behavior (mm-internal only)
alloc_flags -> internal allocator state only

typedef int __bitwise pa_req_t; /* Page Allocator Request Flags */

#define PA_REQ_DEFAULT        0
#define PA_REQ_NOLOCK         BIT(0) /* from ALLOC_NOLOCK */
#define PA_REQ_NO_CODETAG     BIT(1) /* from ALLOC_NO_CODETAG */
#define PA_REQ_SPREAD_DIRTY   BIT(2) /* from __GFP_WRITE */
#define PA_REQ_DEFER_INIT     BIT(3) /* from __GFP_SKIP_ZERO */
#define PA_REQ_ZERO_TAGS      BIT(4) /* from __GFP_ZERO_TAGS */
#define PA_REQ_NO_FALLBACK    BIT(5) /* select no fallback list */
#define PA_REQ_NO_OOM         BIT(6) /* do not oom */

Off the bat we recover 2 ALLOC flags and 3 GFP flags. Possibly more with
a bit more work.

Then we get:

#define PA_REQ_PRIVATE        BIT(7) /* allow private node allocation */
#define PA_REQ_UNMAPPED       BIT(8) /* page must be unmapped */

And we might not even need a new zonelist for private nodes in this case
as long as we require internal users to pass PA_REQ_PRIVATE and add a
function like

folio_alloc_private(void *owner, ...) {
   /* validate (pgdat->owner == owner) before allowing allocation */
   __folio_alloc(..., req | PA_REQ_PRIVATE | PA_REQ_NOFALLBACK, ...);
}

User still has the option to request NO_OOM via __GFP_THISNODE :]

~Gregory
