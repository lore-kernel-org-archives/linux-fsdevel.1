Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3C21E0BA;
	Tue,  2 Jun 2026 03:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780372278; cv=none; b=tJoSQod4psqCxSapQ34Dim26gvdMTbM0/0lby4JuwkkIcYJ6/SZzhxfsfs+9jWiBpk7J3rMX1MpRzz9AWqPbS/iCwmXYmA8hdL7+cpbZTfNjw7wekU5J6rSM78Hb5z8DIP8jqZ16MUf3TT4L18uwZK2AxciFQNSyonpqm2FjJlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780372278; c=relaxed/simple;
	bh=QFKCVVikYfhmder00k/Y5GpW1EP8qMqbn+hTT2bNGOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYPDPOmEmpepuE67KDFA4JGh2fokHecU80DP0+4S59bbn0lAJnodIMFLplgG7rZLirgA+hsXKPoxLTI16ZmyF9s2pvYeBbCwK7wO4h1mBAIRaPKeJPXIMfKc5ae9bbiEa2OASkUuj+k2SH1hIKVRSTB2LJI5/7pnkkMbBgQ7jKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxSsoNn5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxSsoNn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1C31F00893;
	Tue,  2 Jun 2026 03:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780372277;
	bh=RjMhCk/o5NC1phCHo9ITOCgxpvxbQwvB79yIHI8KxIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YxSsoNn5YJCuKxeKl6PAX++Bg1aMM2RevmuoB3R+3Asp5hkDYkYRJMv/TpeoLf9B7
	 Ro5GqUKqVtSJmc5PF+GpOiLc0azL+gPTApbXdxRHccH8Hr+f9xJ7//k0XcZqLOHvSi
	 kGrbwecefO6SaCt1vbjnccI71sOts8z+Y7MsYvqGsWup39aDDNQTED3u4+lj/rv/8F
	 syhtFXtiRdqG9CWJa2E8dieXcFf76SrQLQvLUGV2C2xznjLRecAhHWsKvgkLiwkJ25
	 xTybY/DuKaU+pdIyACHJmrYf48SqhRY4KcLhkA2h2XeK7eAcBCWailPapF06VTCHY9
	 SOQC8eSGQAvkQ==
Date: Tue, 2 Jun 2026 05:51:03 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
	willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org,
	pfalcato@suse.de, r@hev.cc, jack@suse.cz,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	apopple@nvidia.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, brauner@kernel.org,
	catalin.marinas@arm.com, dev.jain@arm.com, kees@kernel.org,
	kevin.brodsky@arm.com, lance.yang@linux.dev,
	"Liam R. Howlett" <liam@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ljs@kernel.org, mhocko@suse.com,
	npache@redhat.com, pasha.tatashin@soleen.com, rmclure@linux.ibm.com,
	rppt@kernel.org, surenb@google.com, vbabka@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>, ziy@nvidia.com,
	hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH v7 1/2] mm: bypass mmap_miss heuristic for VM_EXEC
 readahead
Message-ID: <ah5TJ8tNqcztGS4F@localhost.localdomain>
References: <20260601102205.3985788-1-usama.arif@linux.dev>
 <20260601102205.3985788-2-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601102205.3985788-2-usama.arif@linux.dev>

On Mon, Jun 01, 2026 at 03:21:17AM -0700, Usama Arif wrote:
> The mmap_miss heuristic is intended to stop speculative mmap readahead
> when a file looks like a random-access workload. That does not fit the
> VM_EXEC path very well.
> 
> VM_EXEC readahead is already constrained differently from ordinary mmap
> read-around: it is bounded by the VMA, uses exec_folio_order() to choose
> an order useful for executable mappings, and sets async_size to 0 so it
> does not create follow-on readahead. When VM_HUGEPAGE is also present,
> the larger readahead is an explicit userspace opt-in.
> 
> The mmap_miss counter is decremented from cache-hit paths in
> do_async_mmap_readahead() and filemap_map_pages(). Those paths are not
> always enough to balance the synchronous miss increments for executable
> mappings. In particular, when fault-around is effectively disabled, such
> as configurations where fault_around_pages is 1, filemap_map_pages() is
> not reached from the fault path. The counter can then become a stale
> throttle for VM_EXEC mappings and suppress the readahead behavior that
> the executable-specific path is trying to provide.
> 
> Skip both mmap_miss increments and decrements for VM_EXEC mappings,
> matching the existing VM_SEQ_READ treatment and keeping the counter
> accounting symmetric.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>


-- 
Oscar Salvador
SUSE Labs
