Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663461DFFB;
	Mon,  3 Aug 2026 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752014; cv=none; b=qelHDScqsGKPK+0/TB5sAAcnkmvAnDKPAF8PTNDmtYqktF/dMyoMimWPdMBBs4UOTKWYyfB+fC8ZUMLPXRoHlQqNuYxKzgy8yQ4+QV3kg6lyjynAq1DmtY7xS4mXpOfOZqYiz0tXqdYqKMo1QVoeJxr12DK+0DLObacw67kJZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752014; c=relaxed/simple;
	bh=6Dl1ivfAGnlWvMQh2UNSEZt7UsaKMpYZqYuXdW3VLo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUpS/lfpRnS1YIfOtWZGqhpPOvKdFdlQTP0iP8hJ0V9Z17kcTHa8wewiWDFma+CYX7mYUCmnndjXlTuIzW6r8LCsz4ofNOutN9EceNl2720P72QdUUhHydlq4L9rJOolBLFrkHEJMaLTHCvPZR+QZPB3Owq1fZtrH208IuFapHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBnsXI1z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBnsXI1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D771F000E9;
	Mon,  3 Aug 2026 10:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785752013;
	bh=avyOmjvyQonHxvBu4LC6bxN7dVZH+praK/SydX29h6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LBnsXI1zzy8U5QQIUHC/Mos03wpfdQVKtDBqc4faBMfEsjWNtpruxYt/PNp3Jzqae
	 KDa4U5rsiIS7KR208wO4M5NvFyflHjlhKFi+RpkpEmckGrjvUamhlSVlJaJr6W/RXH
	 eP7H/ibrWz1deWm1abIQXzJDyiclABNBC+rLA4De4NM3CPqtHDZflZbixp/BSq+98p
	 3nAI1BEmHwb93dj27p+qI3KPc6ppCUfNRGlXar3lZ3008Ew1e/mf0DE24XJMjjYUPv
	 fkDBKUNIyhGY1YvaoYvKfLieMTvuY4tBipkAGxJZmbjdblYuU+cwNIiSqbPlmsH/eJ
	 5ZG5Wn8J2ppNQ==
Date: Mon, 3 Aug 2026 11:13:11 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 01/15] mm/vma: introduce VMA anon page offset field
 and add helpers
Message-ID: <anBpLadvsoCcKzqU@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-1-e8ecfefea812@kernel.org>
 <2ac2746f-18b4-4960-8628-82e87c2140ce@kernel.org>
 <anBjLV4CvmpBzEiw@lucifer>
 <1d84f43f-6f59-4685-bd4d-ac7a724bff5a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d84f43f-6f59-4685-bd4d-ac7a724bff5a@kernel.org>

On Mon, Aug 03, 2026 at 11:58:02AM +0200, David Hildenbrand (Arm) wrote:
>
> >> The former would be better
> >>
> >> 	__vma_set_start_anon_pgoff(dest, vma_start_anon_pgoff(src));
> >
> > Ack that's fair, will update it.
>
> But looking at the existing code
>
> vma_set_pgoff(vma, vma_start_pgoff(vma) - delta);
>
> etc, maybe we can keep it as is for symmetry.

Sure.

I mean putting start here is valid because you are setting the _start_ page
offset of the VMA, but then the field itself kinda has that implied.

Obviously could rename vma_set_pgoff() too but then it gets churny and adds
noise so makes sense leaving it as it is also... :)

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
