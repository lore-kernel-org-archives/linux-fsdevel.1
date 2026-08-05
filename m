Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4473E9C2F
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918624; cv=none; b=EAtxuDV0Rka0959tOa9RYxf5Af7kkJAnIIAGHDse5WsmPmhxxnAFv56vXZfL10Wqwe20ynsUjHUl8/AlB4SsryYeTO2ME4Qv8ycS6cHP+pgvR+q6oImzY64JKIE3HHqoCv7Edyl9NLktiRu6lcT+CSTBR49fR6TRMGmDB+5RE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918624; c=relaxed/simple;
	bh=nQ1NCUDBxf7/2HybHqgxgN+S57hXK/KTaVChqtsEuKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PE9HmoeRfgQt19emkAy8T6fzNRwRj88SDkAg4Ert6HIssKRLdxXr4sGsUIdX4328w6KaMJ/jgNPQtVeIjzZcUKh3CTNCbMGGz4tXOiGUX+dX3zSF3UzAP+OoU3Zmaq7JiBf4KhU5QTH1teuOKS9Gw8J9U/KH+BqTZQS1WLhX848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pUmgdlOs; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pUmgdlOs"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-529a1ee0e62so4289841cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2026 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785918622; x=1786523422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XOBR/YIjpOqevYoPUdylhCXb2OTHUbA6kWHOmhD/jcc=;
        b=pUmgdlOsxvJguZRhPL+G9WC1e5d+9ulS2kSMmx2aOek7w4UOnlLaS7YJIbgsooO3e5
         icmVyiBHb+h7utIRLgAi782wW4Trb103yvWbzcXTypmsr+PYTxyOWs+5VaNOaLOYmXYa
         lhYWE3dzFEXWN6gyCn0AyTxaV5GtyQY4SdIKGBnyn8vQ8MAj5gk4waGeGBxuAvf6jNz0
         L2EIOfIzCn82cQvZDWxtF2Jp0yPOxPg8HErYFTjyEjCL5AK9l8h17x/DCm0ztjNbxNTr
         NsUbf2Yh15diFSaHQCuue7ao4W6ASo2gnCJPD5tiaa/fNlsnSXfoITf8B7p1Kr5keYye
         aTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785918622; x=1786523422;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XOBR/YIjpOqevYoPUdylhCXb2OTHUbA6kWHOmhD/jcc=;
        b=I18PpONaactrKYIG+39TFHP7tqQzLpCFh7AB80soD8AjFiCLQOZr4jIfKqhBO5/U72
         zkdILV2Kq/QoSDlXChpNJPKqA2FGfdEeBCaxcwypmM1bdtBZXW/Q2WSBGeyzYSDxnkn5
         MNXkeHsjL8s9xDJfm9ElJG6KWoR6jqmFIhISErCHrudQeIltQ7pRj5CFFHPD/JaIhaui
         A/P9kqiOz5fgyDV4VhW5+DFCGKkvZT0YgqmTXrsIco+/gtMWmFSSyxVNXR4oHuJFGN3d
         ulUxXZuMe+pPkeoCrC749CuXUovHuvV5SB0NsGedcjc4OiQzYskcZz5rT5sArCR1IyyY
         9xuw==
X-Forwarded-Encrypted: i=1; AHgh+RrA40e7qiv1GSunokeRGFamVoS3u9kUs8uA3SVUJ2AaCUNn3M731TNgdTdefbtIQECPAluJdv6bl7jvjr8u@vger.kernel.org
X-Gm-Message-State: AOJu0YwueBgXIvT0/aQf2K5JwL6qngLc4E4qb0tpFzSF5ImjGDACXpeB
	k3iOoc+uxKGFnyOKucFj0r1WIY/9FfDNXtR84wdnm/OSDrG/RERmfRQJxevBp0inEao=
X-Gm-Gg: AR+sD10QjKP2sAdQ4bfjDqJ9s++P1Q1heNbCwmVhx/B08fngTjFxtOWQF7+PsKh6iaA
	g27Pmmotq+jF05IncXh6ECuZbPPO8pG9vdxJIgO6d5or/Do7UU+Q56F3Ve4GtX36m8sKpyl7Si2
	hYNA3mHcdy5XHX9bzq5dbXlrHssiRH2DVmXsaG9JfhVj4vqudKhDliloEqQZvAC8dnL1uQOiVh4
	b2WRLnPUKUFm9i2cwAIiLW5ZCrpcGAiUsXNmlre4RNS61joBoiYD5HDU2rn5OiPgGj/r2y4Fb1Z
	FELz1Clz8xICDIcDAuEuT3s3e5Keqb/lAdpi5E1x7kDUU6idqxxoSdLpW+hgZCzMC286GU0Rw53
	EduCnJFv2dfn8u3LoLOkNyue4CdZBYZfqCtUw6Qnj709r9VHo8J5yO4idQeQhBR2F+VoCq+tGJL
	rKyfuryIaa2uDak5A08XhE2+XtZnv8F5kQlIK1D6umjvWHyB29GE/PIZrCpxXIckmE5NS+GNce+
	v3o4Tb320szHKwYmG+5hpaQ6oIwc1h2nOiE9b2cauke
X-Received: by 2002:a05:622a:143:b0:51c:1c2c:a8bc with SMTP id d75a77b69052e-52ce61fa747mr43158721cf.37.1785918621889;
        Wed, 05 Aug 2026 01:30:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce8972e90sm14423461cf.27.2026.08.05.01.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:30:20 -0700 (PDT)
Date: Wed, 5 Aug 2026 04:30:18 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
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
Subject: Re: [PATCH v3 04/15] mm: update print_bad_page_map() to show
 anonymous page index
Message-ID: <anL0LEhb_bp_uQ1J@gourry-fedora-PF4VCD3F>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-4-e8ecfefea812@kernel.org>
 <amrvgjPNfKqWPUU0@gourry-fedora-PF4VCD3F>
 <fec1be38-406d-4656-95eb-048729afec40@kernel.org>
 <anBqV9z6hVLIqoIn@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anBqV9z6hVLIqoIn@lucifer>

On Mon, Aug 03, 2026 at 11:19:17AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Aug 03, 2026 at 11:39:11AM +0200, David Hildenbrand (Arm) wrote:
> > On 7/30/26 08:32, Gregory Price wrote:
> > > On Wed, Jul 29, 2026 at 05:48:39PM +0100, Lorenzo Stoakes (ARM) wrote:
> > >> This is potentially useful debugging information and matches the existing
> > >> page offset provided.
> > >>
> > >> Use the raw __linear_anon_page_index() function so as to always output this
> > >> value regardless of whether the mapping is file-backed or not.
> > >>
> > >
> > > Begs the question whether we should mark the value based on whether
> > > it is file backed or not, but i suppose you can gleen that from the
> > > other printed values (anon_mem, mapping, vm_ops, etc).
> >
> > You mean something anon_pgoff_t or what did you have in mind?
> 
> I suspect he means e.g. adding a (A) suffix or something? Like page offset xxx
> (F) or yyy (A) I guess?
>

Yeah just an F/A in the print I suppose.  Sorry if that was unclear.

If it saves someone the head-scratch of whether some bug is because it's
"file" or "true anon", given the ambiguity here, seems like maybe useful
debug information.

~Gregory
