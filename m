Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438537;
	b=rXL1WrgAbCFWiq5Hq92V/qgWd2W8yHjUq3hg1NkK01CHdjKfTX/iMeuBLVhCTNbTZz/9
	 Brcjdamn2rnIUwl7PyTGixf7J5gR5ZpgfPxf1oBDVYIY6anT6HDuCZgBwXVu5BmraFmBc
	 KaAZ7JmvuSSxY3x2iks6+hXDAMqqeD3Z1ASLGLrq7w593rDnZZB8q3sfVaIl5V6kdUmv9
	 WWnCi2zS6QgoMBT3oLgF5OaikVzRhQ119BD6z+6oPJXVYrc+Bfjty+5hZCjTP9XAYjA9E
	 lox9A9nJoiov+9gev6zddJ2p69DRk5u5ob3b3TVo3giETjAnXitLTV3jnPAyW0V+ZcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438537;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Scanned-By;
	bh=VjyhhMdU/juj15oJVBCmYzPOqIzW+pggsmwSOSjRyIU=;
	b=F7oF+wRddAfMCtikDU8+bcmHS6hG6yhG/BWegRsnjY8OCoVHjzDOp3DCtabFBk0CI9im
	 ZGNsHtqhZjUNBbetpMJ39y8cgTEv/LiVzF10RdDCtjrfM3yCATnBjrBgsq8h2X5BInoQC
	 f4zQt1+A+0MciDvxkk0nLf7Evs7A8FZxJodSw+qGD36S1lSQWEM3UdKTfxEASbQ1g/G1Q
	 fkZ9IhiRleuoDZ+qw08a81BICQ7GJkWUHbsZSWdipjRfvSGQjJFowqmMO5j7P7JdZLxtD
	 Zu/QndrcPU/qvbTSWWlFm+r+yJddvu5gp3hJEIhEEEzJva+ac6hlDaTCk0i/Swf76JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fTBmUH67;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381F606A31F
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 19:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D381F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fTBmUH67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792438535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjyhhMdU/juj15oJVBCmYzPOqIzW+pggsmwSOSjRyIU=;
	b=fTBmUH672SkqE+ZRLdmChWTsZJysJTuyUNxZYQIFYJ5gIZ4nV3oR1ViALJSJuLvRljoHy0
	7CQ0xyP82TdjU8lcGBjtn7Mi6BzhCvcplNCFi2YPzfAbtlXXELBUjxkmq4aV6wa4YJXEf1
	hyUIgycs5TLf/vCvf+aVJNnJ/i4x6fU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-YY74PiJOOlKz-zqKYJbeLA-1; Mon,
 19 Oct 2026 19:35:34 +0000
X-MC-Unique: YY74PiJOOlKz-zqKYJbeLA-1
X-Mimecast-MFC-AGG-ID: YY74PiJOOlKz-zqKYJbeLA_1792438533
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B830C1955EA7;
	Mon, 19 Oct 2026 19:35:31 +0000 (UTC)
Received: from bfoster (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D367D767;
	Mon, 19 Oct 2026 19:35:28 +0000 (UTC)
Date: Mon, 19 Oct 2026 15:35:26 -0400
From: Brian Foster <bfoster@redhat.com>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/truncate: fix the zeroing end of
 pagecache_isize_extended()
Message-ID: <atZw_gtMIIKXgc1q@bfoster>
References: <20261016222721.791785-1-nickolai@csail.mit.edu>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016222721.791785-1-nickolai@csail.mit.edu>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Fri, Oct 16, 2026 at 06:27:21PM -0400, Nickolai Zeldovich wrote:
> A process that extends a file by 4 GiB or more past a dirty folio, on a
> file system whose block size is smaller than the page size (ext4 with 1k
> blocks), reads back the bytes it wrote through a shared mapping beyond
> the old end of file instead of zeroes, and a later write into that block
> carries them to the disk. With the example of commit 52aecaee1c26 ("mm:
> zero range of eof folio exposed by inode size extension") and the
> truncate taken 4 GiB further (pwrite 2k at 0, mmap the first page and
> write 'X' over [2k, 4k), truncate(2) to 4 GiB + 2k), the read of
> [2k, 4k) returns the 2048 'X' bytes, and a pwrite of 16 bytes at 3k
> followed by fsync() and a remount leaves 1008 'X' bytes on the disk in
> [3k+16, 4k). No privilege is needed, and every size extension of 4 GiB
> or more reaches it: truncate(2)/ftruncate(2) through truncate_setsize(),
> writes beyond the end of file through generic_write_end(), ext4, iomap,
> btrfs, exfat, ntfs, afs and orangefs. Affected since v6.13.
> 
> pagecache_isize_extended() zeroes the part of the dirty folio straddling
> the old end of file that the size extension exposes, from the old size
> to the new size or the end of the folio, whichever comes first:
> 
> 	end = min_t(unsigned int, to - folio_pos(folio), folio_size(folio));
> 
> min_t() converts both operands to unsigned int before comparing, so the
> loff_t difference to - folio_pos(folio) is reduced modulo 2^32 first.
> When the file grows by 4 GiB or more past the folio, end is that residue
> instead of folio_size(folio): below offset nothing is zeroed, above it
> only [offset, end) is. The bytes beyond the old end of file stay in the
> dirty folio and, now inside i_size, are file data.
> 
> Compare in loff_t; the result is at most folio_size(folio) and fits end.
> 
> Found while formally verifying pagecache_isize_extended() against the
> kernel binary.
> 
> Fixes: 52aecaee1c26 ("mm: zero range of eof folio exposed by inode size extension")
> Assisted-by: LLM
> Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
> ---
> 
...
>  mm/truncate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index b58ba940be47..5c444812f37a 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -878,8 +878,7 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
>  		unsigned int offset, end;
>  
>  		offset = from - folio_pos(folio);
> -		end = min_t(unsigned int, to - folio_pos(folio),
> -			    folio_size(folio));
> +		end = min_t(loff_t, to - folio_pos(folio), folio_size(folio));

Good catch...

folio_size() returns size_t and folio_zero_segment() expects size_t for
the offset params. Perhaps we should that instead of loff_t?

Brian

>  		folio_zero_segment(folio, offset, end);
>  	}
>  
> 
> base-commit: 70dd4ee72eb2d5793c62e71c14e3aba78e5a4e56
> -- 
> 2.53.0
> 
> 

