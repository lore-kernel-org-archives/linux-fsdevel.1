Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794949842;
	b=zUwn2tEvQVzAz1zRz6vf7Kvho4bUQO8Tc7d0QqvuxArj2AFKpbHBmxcZKAXDM0PP8WsJ
	 tpFqo5NDyT3D7uFCSYMKorgmGKpdpnglPSuk1jQjJrVbCLnLulU6+/zJkIvEdmzzRl8LQ
	 82eu0SdgjdA6xQPVi61L464dicISbh+V59OI0jWT8dhNF6gQANBqojrkDHFIEpE2Kz+Qn
	 hzhuwOPizuhTuLDu1w26mcz0Ff2ER+wDXOJRyVFt29aBmlTOrVL3AmJSQuLlXaZYW5jX/
	 vNhtSrgT7BfG9iMntecopulcsYlej/hBTeXNmorFxRJcMjK3V5rk9YwiMgz4JoYGVeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794949842;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Scanned-By;
	bh=qdKdEl0zxLLbjG6lERQLivg57KN6iKjjOdwmcujeJ9o=;
	b=Etts/GntJqHruakHaM+FUWE5BkxLiN1oQ9tZCilPUUNmkpxh6njDcghRIjuhPo59t15q
	 aQqkrvhcDcuuD7GM6ImDl2N+haojzcY8H3/4wiE68ELMdXd5hQnokvolExpvB9s9li0Fu
	 7GvAOqHt3vyfNpwTXVvQX8XJ2XUKpdIuFTody9zG2iNqflsB60sc8XoR9MAjDeunpYQgU
	 RAl31n5l2h66AkKmHmaLGLOebaTkl61Unef7lGs1a64ZFN/VTKsR7ftWqK70msZvTlyCa
	 9vRohmDMusiG/LyX8gI6OleeRg+TrYuUEg87iijCy6QEI3dhjo3jGPh7auVLskB/JDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Na384WxW;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76210606A32F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 21:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76210606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Na384WxW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794949840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdKdEl0zxLLbjG6lERQLivg57KN6iKjjOdwmcujeJ9o=;
	b=Na384WxWjEnFxv6INQ7/xaJruc0WsCZjrcQfkhs0lItub+cqhFjS1aBt3PfLI8T9/Oe9/a
	W7uE/EJuU9DuJ4Bz4q2MV8CAuBk5zqhG8LVudb8R2E7XXgQGYOusqbLSTwLkvrV3P7qpIQ
	lwlaoRFLJ3SlYQgfN4lsTc61xkR4o+8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-l5Lup1M-NmSW3rGiqJPyIQ-1; Tue,
 17 Nov 2026 16:10:36 -0500
X-MC-Unique: l5Lup1M-NmSW3rGiqJPyIQ-1
X-Mimecast-MFC-AGG-ID: l5Lup1M-NmSW3rGiqJPyIQ_1794949835
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDC98195606D;
	Tue, 17 Nov 2026 21:10:34 +0000 (UTC)
Received: from bfoster (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43C071801977;
	Tue, 17 Nov 2026 21:10:33 +0000 (UTC)
Date: Tue, 17 Nov 2026 16:10:31 -0500
From: Brian Foster <bfoster@redhat.com>
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: fix offset truncation in
 iomap_fill_dirty_folios() on 32-bit
Message-ID: <avzCx52Sl5g3tuZu@bfoster>
References: <20261117164756.97065-1-jain.sm@gmail.com>
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
In-Reply-To: <20261117164756.97065-1-jain.sm@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Nov 17, 2026 at 10:17:56PM +0530, Shashank Mohan Jain wrote:
> iomap_fill_dirty_folios() turns the page index at which the dirty
> folio lookup ended into the file offset it returns to the caller:
> 
> 	*start = (pstart << PAGE_SHIFT);
> 
> pstart is a pgoff_t. On a 32-bit kernel the shift is done in 32 bits
> and the upper bits are lost for every offset at or above 4 GiB.
> 
> XFS uses the returned offset in xfs_buffered_write_iomap_begin() to
> trim an unwritten mapping to the range covered by the lookup. With the
> truncated offset the end of that range is below its start and
> xfs_trim_extent() leaves a mapping of zero length. iomap_iter_done()
> warns about it,
> 
>   WARNING: fs/iomap/iter.c:38 at iomap_iter+0x33c/0x36c
>   WARNING: fs/iomap/iter.c:39 at iomap_iter+0x34c/0x36c
> 
> and iomap_zero_range() does not terminate: a mapping of zero length is
> what the iterator takes for the start of an iteration, so it asks for
> the next mapping again and again without checking how much of the
> range is left.
> 
> On i386 with XFS (4k blocks) this is enough to trigger it:
> 
> 	fd = open("f", O_RDWR | O_CREAT, 0644);
> 	fallocate(fd, 0, 5ULL << 30, 1 << 20);
> 	ftruncate(fd, (5ULL << 30) + 1000);
> 
> ftruncate() never returns. The task spins in iomap_zero_range() with
> the inode locked and does not react to SIGKILL. A write behind an
> unaligned EOF which is in an unwritten block above 4 GiB fails with
> EFSCORRUPTED instead, after "XFS (vda): Access to block zero in inode
> 132 start_block: 0 start_off: 140002 blkcnt: 0 extent-state: 0":
> 
> 	fallocate(fd, 0, 5ULL << 30, 1000);
> 	pwrite(fd, buf, 100, (5ULL << 30) + 8192);
> 
> The same calls work below 4 GiB, and v6.19 behaves like v7.3-rc6.
> 
> Cast the page index to loff_t before the shift.
> 
> Tested with an i386 kernel in qemu and XFS on a virtio disk: the two
> sequences above hang and fail without this change and succeed with
> it.
> 
> Fixes: 395ed1ef0012 ("iomap: optional zero range dirty folio processing")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

> Prepared with Claude Code (Anthropic), model Claude Opus 5.5
> (claude-opus-5-5).
> 
> First sent privately to security@kernel.org on 11 October; Matthew
> Wilcox asked for it to be posted as a normal patch. Sorry for the delay.
> The code is unchanged in mainline, so this is the same fix, rebased on
> 666539eecdf4.
> 
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6d843b1..846f87a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1735,7 +1735,7 @@ iomap_fill_dirty_folios(
>  	}
>  
>  	count = filemap_get_folios_dirty(mapping, &pstart, pend, iter->fbatch);
> -	*start = (pstart << PAGE_SHIFT);
> +	*start = (loff_t)pstart << PAGE_SHIFT;
>  	*iomap_flags |= IOMAP_F_FOLIO_BATCH;
>  	return count;
>  }
> 
> base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
> -- 
> 2.43.0
> 

