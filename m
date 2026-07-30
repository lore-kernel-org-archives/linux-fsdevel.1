Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1773B47EB
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 06:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393573; cv=none; b=blb15csYhY4B1N/Ap334rFlzX8uCIjFmfRXnesfx9exC+zlU4T34uM8HKq9xXL6y1ve0YzgiA2rP8VAA1PBatdPisPNaYvZN3IeDz0w580DJEZ1XIUsvINNqLN0WMO/VsLe6x7eTYAm2nHPHCC7Yc1OAiucMJhOCQgv2go5Mous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393573; c=relaxed/simple;
	bh=WncTQphxVp0l2Tk7Aew9QDDKQTVA3eE7asUk3yooeoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhodS33WWbUeHD53gu5mf1FKjEkfjfOgXNLFBnhYF62QtDBLRv9Ltq+J6VLyqkyk6SKBs8eEa7bdygQHglC6zmBrj+mwgOjpTELpWEG3RdeWMldZfDtKPVvkv5g4YzToSvSMBKUvrTvZXEsJoXMYtpzOsd2DVmQgCnA+gtXx3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=r9Bnawsg; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="r9Bnawsg"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9309d4ea213so153002485a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 23:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785393570; x=1785998370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kOg1TP69pkfX9jACUFVlU927ii/AFS16vNDFEmK7SsI=;
        b=r9BnawsghlDcat/pe84AtaXEUH943VqDqoT86wpPLtvduovJvTkepYIApcK1kcS8dm
         Vsbr2HII615RJDo632lNp0VVIk4jIsyUPPLcjZ8G4kf7MUiscXwqTTMMwLZfyFdC/QnN
         f70GImoBQnn4kdpfMeSMKIUTaVJIokZFnAWahC3B01mdSflxvyXXndmWwaULOUhz0m3q
         tPZTXKH1pcBVfEDmSEhiq8AuTzB3paxBpAsg8AYTUEfIz9cdRVb8d9Zl+BpjDqEH0Bo9
         nLEdgyH+WPJoX/9Jvq4uTgVa8DmfohQOLZK2BWsHLPOhSI6MWT2TSx+G8e8h2lnHSk9K
         fJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785393570; x=1785998370;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kOg1TP69pkfX9jACUFVlU927ii/AFS16vNDFEmK7SsI=;
        b=ay/blahTSKEgGS0zOSJP+icc+VlqhziJwWRbg9HvB+WkqR4BC/1vrlf/2VnUZNFpUB
         D7QoyF/0k4Z4XxbbekC+9mSUO521SIAf4voUyokWAU/OPQKjORyAPJ3r2qOtEOJ90J8L
         ga+BpjHus5Q0muQui9r4NT7I7GeBfhso0t5n8xVhOp4coWem91imZPpKSJVrqXHY78Su
         rmkFQq/w7kDY42NP8Jx4//gOF1uC6PvncATP5agDLIAURuDyOSi+RwCHpHKkWrRBc3qo
         YbRnLC29Ni9feE1sAJjHC4f+8SawN1sTMeU9rRD1iW93eivRr92ac3K4QBumvIN0V2M9
         c6Gw==
X-Forwarded-Encrypted: i=1; AHgh+RrvS5OwMGND5FpGl8EGW8ehkJgxafMm1NaLej54R6UVcHCbUgyvvxTOEKNR0I1XR3FJHjWkzUIptIsJy90v@vger.kernel.org
X-Gm-Message-State: AOJu0YxRHLzPvxewe7QbBxuVl0iSQd9A/jV+qVDeoprBg8dBYywXkRsr
	2j64EZ4d09kLIgAznvpawHYzfbANwQ9NJYaRstASC+un69pOY2++pyHy3hgoW6BLhK4=
X-Gm-Gg: AR+sD13fUsHfrmteMaAAon0phGM3FQ3QStxuVW69+t3Aib3MENj8im0sfj86Dc7/J3D
	QhE6FHbABdabx7hQqsbEgbfj29M20ifLXV+8+peVBxO5XTSOmBjdcyDmku9QFxHal8zKQJKX7lS
	FCUxn4op4wVF8wm0tNc6soASCQfmbcmf6VRCM0AVS5EE0xKK9HCd4BE2Zw896Kf8717Ly/eNt/a
	d6kLdXz+F0axlviERRZe3oCB1uJED+gyzTa8yIm+oH3olyRzSj17e8ek3dmOS5QHBeosygVjwvY
	ftqtlHuwEHAKlwitL6C/6Eq4m08rs4jphSvN2pCtQfv6apYemPVmOS050+ZztEm+V1i63JY+DKq
	jjFN4u17Po3miOrbPGchCkngaO/SO1VOOAn+mSXtahuYNc5UFdrQj5fS3KpkzLHPd35+cOYmAoz
	U1hIqB7yLCKZzDreoENnVAD0zJhedB9HTouKteokgjNYJHHX1+kjZrC2m+vn7Jf3jOlcp9blMDs
	q8CI170nThpFeLfBAf24Xxdj/gNa5o/eC1Aruq4fTIY
X-Received: by 2002:a05:620a:72c5:10b0:930:ea99:8097 with SMTP id af79cd13be357-93486cf8599mr88361385a.61.1785393570464;
        Wed, 29 Jul 2026 23:39:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3221c71sm356647085a.2.2026.07.29.23.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:39:29 -0700 (PDT)
Date: Thu, 30 Jul 2026 02:39:27 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 03/15] mm: abstract vma_address() and introduce
 vma_anon_address()
Message-ID: <amrw2v7TVl_AG5_3@gourry-fedora-PF4VCD3F>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-3-e8ecfefea812@kernel.org>
 <amrV0Y7ZUtihiB2B@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amrV0Y7ZUtihiB2B@gourry-fedora-PF4VCD3F>

On Thu, Jul 30, 2026 at 12:58:22AM -0400, Gregory Price wrote:
> On Wed, Jul 29, 2026 at 05:48:38PM +0100, Lorenzo Stoakes (ARM) wrote:
> > 
> > This will be necessary for determining the address of a folio's index
> > within a VMA when the folio belongs to a MAP_PRIVATE file-backed VMA but
> > has been CoW'd, and thus is anonymous, once the anonymous VMA page offset
> > field is used for the reverse mapping.
> > 
> 
> This is a doozy of a sentence... 
> 
> ... determines the address of a folio's index within a VMA when
>   - the folio belongs to a MAP_PRIVATE file-backed VMA, but
>   - <The VMA> has been cow'd
>   - thus <The CoW'd VMA> is anonymous (as well)
>   - The original VMA may or may not also be marked anonymous?
>     (just clarifying, could be original mapper or a COW that COWs)
> 
> Ow, my brain.  One question below
> 

After re-reading the cover-letter again - my note here is wrong and
my brain hurts more.

... determines the address of a folio's index within a VMA when
  - the folio belongs to a MAP_PRIVATE file-backed VMA, but
  - <The Folio> has been CoW'd
  - thus <The CoW'd Folio> is <now marked> anonymous
  - The original folio may or may not have been anonymous
    (depending on whether it, itself, was a CoW copy)

Lorenzo you are truly doing Darwin's work untangling all of this.

~Gregory
