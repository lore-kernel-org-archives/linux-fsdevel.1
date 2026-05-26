Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9423B7770
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787890; cv=none; b=hmaJ5iT+5DyBqeKFVSyvDq7lfvW/Z/2z+cExaHvNM/L8sYHvq3aROtPIKNjx4mJBPPKW5P8DHly5lKCcJJ5lpHapgiKoJslssiJ06dy+ykFdYBJ/6+CPrUdT0khC7SOQylNLW74Dzqr2Yh181/FOm9GSo0bVlgKmlJqDT3iMqKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787890; c=relaxed/simple;
	bh=RHtL8/dyrko5u4sBEctY6jE9Wro1GNzH9pxZAT9Ca/Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HCielZmZteTrvSPg8Aq01bdeh5qaOjOk+s7Uht5tYeFW1n8bS58/bCTDbkskCu0w3XT6gxZNl8TLDd1Z4FSz5J85FckTQzraVAbnDy9tMYdz9wCTeVYx4rAtj0PU5r7MB4EVBhjof4u0MlOS83vNSKB1ZrgBjZVFAHZtuadbNog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l+iWaZOg; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l+iWaZOg"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779787877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMqGSTNX/ruzLxK2F9/7GP9Wked/JMlEDdRD6w8SgUQ=;
	b=l+iWaZOgyJwBFGr9oefKDRKZQVlf/pzjINJ5Jc6x3rQzEONt6AzN6prAQJG7ZlGa4EVTKO
	EfwhRlk06EAwcbJqRtqkJy7JUz4uFLk2PYe1DfiVoGukTvh1XvsnZhlitXPIh1GwWw+Z5E
	OmEXTyyNWsI91UaCR+ptfieqjz/WwpA=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] mm: make mmap_miss accounting symmetric for VM_SEQ_READ
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: William Kucharski <william.kucharski@linux.dev>
In-Reply-To: <20260525145751.2671248-1-usama.arif@linux.dev>
Date: Tue, 26 May 2026 03:30:55 -0600
Cc: Andrew Morton <akpm@linux-foundation.org>,
 jack@suse.cz,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 willy@infradead.org,
 david@kernel.org,
 hannes@cmpxchg.org,
 kas@kernel.org,
 shakeel.butt@linux.dev,
 kernel-team@meta.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <715DF460-33D0-441C-A732-D029EBAE4BBF@linux.dev>
References: <20260525145751.2671248-1-usama.arif@linux.dev>
To: Usama Arif <usama.arif@linux.dev>
X-Migadu-Flow: FLOW_OUT

Looks good to me.

Reviewed-by: William Kucharski <william.kucharski@linux.dev>

> On May 25, 2026, at 08:57, Usama Arif <usama.arif@linux.dev> wrote:
>=20
> do_sync_mmap_readahead() skips both the mmap_miss increment and the
> MMAP_LOTSAMISS check for VM_SEQ_READ mappings, since sequential access
> is non-speculative and should always read ahead. The two decrement
> sites in do_async_mmap_readahead() and filemap_map_pages() do not
> mirror this skip, so concurrent faults on a VM_SEQ_READ mapping can
> still drive ra->mmap_miss down to zero through the decrement paths
> even though nothing in the sync path ever increments it. The counter
> itself is per-file (file->f_ra.mmap_miss), so it can be moved by any
> VMA mapping the file, not just the one currently faulting.
>=20
> Skip the decrement for VM_SEQ_READ in both decrement sites so the
> counter only moves for mappings that also participate in the
> increment side. No functional change for VM_SEQ_READ users, since the
> increment-side gate already prevents the counter from being consulted
> on their behalf, but it stops a VM_SEQ_READ mapping from biasing the
> counter for other mappings of the same file.
>=20
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
> mm/filemap.c | 14 ++++++++++++--
> 1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 5aaba0d3e81d..cca20e350c95 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3433,8 +3433,13 @@ static struct file =
*do_async_mmap_readahead(struct vm_fault *vmf,
> * Don't touch the mmap_miss counter to avoid decreasing it multiple
> * times for a single folio and break the balance with mmap_miss
> * increase in do_sync_mmap_readahead().
> + *
> + * VM_SEQ_READ mappings skip the mmap_miss increment in
> + * do_sync_mmap_readahead(), so skip the decrement here as well to
> + * keep the counter symmetric.
> */
> - if (likely(!folio_test_locked(folio))) {
> + if (likely(!folio_test_locked(folio)) &&
> +    !(vmf->vma->vm_flags & VM_SEQ_READ)) {
> mmap_miss =3D READ_ONCE(ra->mmap_miss);
> if (mmap_miss)
> WRITE_ONCE(ra->mmap_miss, --mmap_miss);
> @@ -3935,10 +3940,15 @@ vm_fault_t filemap_map_pages(struct vm_fault =
*vmf,
> * In such situation, read-ahead is only a waste of IO.
> * Don't decrease mmap_miss in this scenario to make sure
> * we can stop read-ahead.
> + *
> + * VM_SEQ_READ mappings skip the mmap_miss increment in
> + * do_sync_mmap_readahead(), so skip the decrement here as
> + * well to keep the counter symmetric.
> */
> if ((map_ret & VM_FAULT_NOPAGE) &&
>    !(vmf->flags & FAULT_FLAG_TRIED) &&
> -    !folio_test_workingset(folio)) {
> +    !folio_test_workingset(folio) &&
> +    !(vma->vm_flags & VM_SEQ_READ)) {
> unsigned short mmap_miss;
>=20
> mmap_miss =3D READ_ONCE(file->f_ra.mmap_miss);
> --=20
> 2.52.0
>=20
>=20

