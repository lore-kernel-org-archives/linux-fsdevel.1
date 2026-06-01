Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96088344DBD;
	Mon,  1 Jun 2026 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780355429; cv=none; b=CY5YcKdgn4pqk/LQJZx4gKer3kNukiUfA2DAMKJCM/AZHkquZ//apKdZq2cTleCaWoIGNIa3HHL+pwn19CvSgm1zwEKaaiU9fOLd8egjENHOpV/uR8N72DwVH1BK1Z4au1QxYebaa13KA3jJO5a0DGmJzu0eNjoWfpnIEXyHHwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780355429; c=relaxed/simple;
	bh=XFXpRIV3mDXUhdrIfwgFHC6jKMm7DYyIcaQUqjosygk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k7Wv6v38yzNLl7JxnqV/KQu0Ibil/Q/Uto9okw20whXB/bwY/5UtWPFd1wjsTFyXysZMs2E5jn4JnIAKlEFeIc9XwOSQSwd0t5OKXCXRoBxKo8oBcVX3F5r/HAmYbqeMCdtGeBA8pKYc3GJWIz6TPIoCcrI6/nga8M4Iyk5jQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UcuLTdYF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UcuLTdYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1BE1F00893;
	Mon,  1 Jun 2026 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780355428;
	bh=jmSU8+clGd9Vdr+0PQ5FxeSQ2EfOINrntLzTOj1OVhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UcuLTdYFJ45yGbhwq4JqV5rRBlsI2KOcUsj2hzI4QVrvlWpfknsw0mxnUG2kgHyGl
	 NKwBt+ok4mnD9QE2zdnUuN8BofrNb4vxTM73veVHbmfpu/tnvvYh3qwpGKcANbxpiY
	 ErXU92C50RKmfHmskjHokRs/Z0jxFNI5K9MXFzx4=
Date: Mon, 1 Jun 2026 16:10:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: david@kernel.org, willy@infradead.org, ryan.roberts@arm.com,
 linux-mm@kvack.org, pfalcato@suse.de, r@hev.cc, jack@suse.cz, Andrew
 Donnellan <andrew+kernel@donnellan.id.au>, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, brauner@kernel.org,
 catalin.marinas@arm.com, dev.jain@arm.com, kees@kernel.org,
 kevin.brodsky@arm.com, lance.yang@linux.dev, Liam R. Howlett
 <liam@infradead.org>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ljs@kernel.org, mhocko@suse.com, npache@redhat.com,
 pasha.tatashin@soleen.com, rmclure@linux.ibm.com, rppt@kernel.org,
 surenb@google.com, vbabka@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 ziy@nvidia.com, hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 kernel-team@meta.com
Subject: Re: [PATCH v7 0/2] mm: improve large folio readahead for exec
 memory
Message-Id: <20260601161026.d5905786bbd3a26d62be88c3@linux-foundation.org>
In-Reply-To: <20260601102205.3985788-1-usama.arif@linux.dev>
References: <20260601102205.3985788-1-usama.arif@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jun 2026 03:21:16 -0700 Usama Arif <usama.arif@linux.dev> wrote:

> Hopefully this is the last revision. The only change from the previous
> revision is that the logic for deciding THP order was simplified and
> the max is now capped to 2M. Thanks Pedro and Jan for the suggestion
> and the dicusssion!
> 
> The benchmark results on Neoverse V2 (Grace), arm64 with 64K base pages,
> 512MB executable file on ext4, averaged over 3 runs:
> 
>   Phase      | Baseline     | Patched      | Improvement
>   -----------|--------------|--------------|------------------
>   Cold fault | 83.4 ms      | 41.3 ms      | 50% faster
>   Random     | 76.0 ms      | 58.3 ms      | 23% faster
> 
> The patches are on top of mm-unstable from 28 May
> (8a74e22643189e0ae339afc91110ddb4cab1941b) which include patch [1]
> that make mmap_miss accounting symmetric for VM_SEQ_READ which was pointed
> out by sashiko in the previous revision.

We lost the [0/N] cover letter.  Please do retain (and maintain!) that
across revisions.  I used the one from the v6 patchset.

> v6 -> v7: https://lore.kernel.org/all/20260528165635.2068012-1-usama.arif@linux.dev/
> - Simplify logic and just cap the max THP order to 2M (Pedro and Jan)

Here's how v7 altered mm.git:


 mm/filemap.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- a/mm/filemap.c~b
+++ a/mm/filemap.c
@@ -3320,17 +3320,12 @@ static struct file *do_sync_mmap_readahe
 	/* Use the readahead code, even if readahead is disabled */
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && (vm_flags & VM_HUGEPAGE)) {
 		/*
-		 * Preserve PMD-sized readahead where it already fits in
-		 * the page cache. Otherwise cap the new fallback path at
-		 * 2MB: this is the common PMD-sized hugepage size, and it
-		 * avoids memory pressure from very large forced readahead
-		 * when mapping_max_folio_order() is high (for example,
-		 * 128MB with 64K base pages on arm64).
+		 * Cap max THP order at 2MB: this is the common PMD-sized
+		 * hugepage size, and it avoids memory pressure from very
+		 * large forced readahead when mapping_max_folio_order() is
+		 * high (for example, 128MB with 64K base pages on arm64).
 		 */
-		if (HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
-			force_thp_readahead = true;
-			thp_order = HPAGE_PMD_ORDER;
-		} else if (mapping_large_folio_support(mapping)) {
+		if (mapping_large_folio_support(mapping)) {
 			force_thp_readahead = true;
 			thp_order = min_t(unsigned int,
 					  mapping_max_folio_order(mapping),
_

