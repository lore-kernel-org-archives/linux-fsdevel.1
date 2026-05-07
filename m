Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03253A873C;
	Thu,  7 May 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158133; cv=none; b=JXRDedGzeDk5o+RyYxGk43p0UTsC82ylYSDwkmkS/Dkbk/OVlQ3XeechNG9So5u5PmgjqaVShNpAA+5pWlfPGT7aR8JV5VL9Iy2bi7Jc+TMI5fk43egBUoXeWG8bK6uMMYoGo+qzNiYEnaFdGenH85Awb9ix86z4GcL2sSFqcYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158133; c=relaxed/simple;
	bh=pSSRQxdxncErXCf+M8Abk9qqkUbDfMbi4JtFvztGRiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPcFl//ekmeQWkudnPp/l6uZc8woZE8RRTOmT1TcQ49XDuoRTZv9C75o7zWGLchbLAgFCX4BL9uqFDEZoPBm5+NYn4yXneAbCEGR9rJU3wkn1qJ1ooN3HlnJdliyWbPgUh8H0lvCZ+Dh+E7CKRLaudQeLsEIRH86F0w2nj/YLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qvfqq0Mr; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qvfqq0Mr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778158118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSSRQxdxncErXCf+M8Abk9qqkUbDfMbi4JtFvztGRiI=;
	b=qvfqq0MrdFu3htA7X+3DVI9J1HnuCZPsjnH7d6qjDFNBVDjVLceHRm7h5Pi/HTENRr1KAO
	GRyWvfieSYK0eVhvrs+/NmN2z8p4SYTudIZTFlHTapyXKurKDPrHvMT7J5CFmBGp8vl/HO
	4tcRj1efiuk7XV//++Nf13mg5oiWCj0=
From: Lance Yang <lance.yang@linux.dev>
To: ziy@nvidia.com
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	willy@infradead.org,
	songliubraving@fb.com,
	clm@fb.com,
	dsterba@suse.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ljs@kernel.org,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 05/14] mm: remove READ_ONLY_THP_FOR_FS Kconfig option
Date: Thu,  7 May 2026 20:48:24 +0800
Message-Id: <20260507124824.96209-1-lance.yang@linux.dev>
In-Reply-To: <20260429153538.727855-1-ziy@nvidia.com>
References: <20260429153538.727855-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Wed, Apr 29, 2026 at 11:35:28AM -0400, Zi Yan wrote:
>After removing READ_ONLY_THP_FOR_FS check in file_thp_enabled(),
>khugepaged and MADV_COLLAPSE can run on FSes with PMD THP pagecache
>support even without READ_ONLY_THP_FOR_FS enabled. Remove the Kconfig first
>so that no one can use READ_ONLY_THP_FOR_FS as upcoming commits remove
>mapping->nr_thps, which its safe guard mechanism relies on.
>
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
>Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>---

READ_ONLY_THP_FOR_FS lost its job now that mapping_pmd_folio_support()
does the gating ;)

LGTM.
Reviewed-by: Lance Yang <lance.yang@linux.dev>
