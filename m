Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304725;
	b=lgt//G9kaSjmQ9XWdubZKZtkixjsl+HuZHuSu7C0VEQuUCVhAdeSdHNNAtCZtdgmdfT4
	 79klkKV/l86k9v2FwtoR/T3giuJBgAR45sVFbOiifINdfWUWIpKG7bKDPSThyuAT2gYF6
	 6f5ndynOhys7kJZ/h+ZZwcRHlQO5YFwyCqxWYY3cYxjcDBgSX3s4p1Wgmlf2T9Ld7jtBr
	 UfGBvTk7Hw7BWhiTFNl3vIOSQB+YksZ4tGf73wijiXzP80YkWHOO2Br5cqm7fAQqyw52G
	 wON07SaWZCVuvPixhAnuVRbCQcZ3jU9UUgTA1dEG9Eo5Pd1bL1ZZy5MBtE2CHCximbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304725;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=v25Odk+w8zqh+xoMuADbn2dgTDEctJs52lZ7sJTHx+4=;
	b=mpglgyNDPEcEBA6mSjYadO0irgGTIE+u0PJqLSJZeI7Ez4zaCEle9hduQzKEXdy4cuR8
	 QdsZy3Ne3UHJRaqiwzE5LjXalnONHZ8aqZwCIvQhLdgr/P8Q4CbMtRlPPJI9Hmlx7hyTH
	 floduDJDUBvpdfzLhL7K62nn7XaJDeZuSx9yLozqyRkS164kWJ810NlfAv3K8KIjdL0qB
	 whJinrmi7spz9y9aVe/ewNhFG6zKTmfVTd0ljhMwEPvCAZCR1uOty8kPEWXa/sgeibJy2
	 Ui2VXU8y3Q/1JnDHCltZpqOaWewPC7eoXOEiLR/1w9/zfLbYLZtgDqu3XnDHjohTjxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=4gGYnZBI;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A4606A31A;
	Thu, 29 Oct 2026 20:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 005A4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=4gGYnZBI
Received: from DESKTOP-PJTTJ93.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 4D27412021F;
	Thu, 29 Oct 2026 17:11:49 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1793304714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v25Odk+w8zqh+xoMuADbn2dgTDEctJs52lZ7sJTHx+4=;
	b=4gGYnZBInza8ErhRqp01hIijDFba+eYqAeB2uTZVThs/r4MgYUZNHG5WaqvA55QwtYnhld
	aV6+ZjxoEWNW9eE6p7N3Wb4ajQlIpDWfywXbsDtnLQbrcA/JfbvhS7Utw271qTDXFMIeO9
	YPzTB5N0F7xuotrNFVqQmBBYduEojP++AEscLT+KzucON4byYKp1yP/itI4b0WkjegEd6r
	Y9aKCmguhaCcDoTl3eEpH8IvB4aF1PVsT/7+RHG+5XMVxg6jXS+n9PiyIp2rkUua7jcXMl
	vrsHmvKa3FRaGl2brGta6pQRMXVt2bgiAm8JxKFuhRQ/8ox3GTCuO4Ge6lZ/6A==
Date: Thu, 29 Oct 2026 17:11:46 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Bryanna Marihugh <bryannamarihugh@manhattantech.edu>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fat: use write_inode_now() on flush to avoid racing
 the flusher
Message-ID: <auOlUam8nXqdTZu0@DESKTOP-PJTTJ93.localdomain>
References: <20261029-fat-flush-isync-v1-1-69c02c258d0c@manhattantech.edu>
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
In-Reply-To: <20261029-fat-flush-isync-v1-1-69c02c258d0c@manhattantech.edu>

On Thu, Oct 29, 2026 at 12:29:05PM -0500, Bryanna Marihugh wrote:
>On cheap USB 3.0 sticks, copying a large file to one formatted FAT
>slows down badly when the background flusher runs at the same time.
>This only impacts performance; it does not corrupt data.
>
>udisks mounts FAT with the flush option, so closing a written file
>calls fat_flush_inodes(), which starts writeback of the data with
>filemap_fdatawrite(). That does not set I_SYNC, so the flusher starts
>at the same time, which causes lots of small requests.
>
>Cheap controllers handle small writes poorly and sometimes stall for
>seconds. I have found this to be a problem on many cheap USB 3 drives.
>Older USB2 hardware, better drives and ones that support UASP
>don't show this behavior.
>
>Use write_inode_now(inode, 1) instead. It goes through
>writeback_single_inode(), which sets I_SYNC while it writes.
>Close now also waits for the data and the directory entry to be written.
>
>Benchmark copying a 3 GiB file to a USB 3 stick (PNY, 154b:00ed),
>default writeback settings: 11.6-16.3 MB/s before, 17.6-18.0 MB/s after.
>
>Signed-off-by: Bryanna Marihugh <bryannamarihugh@manhattantech.edu>
>---
>This is a performance fix for cheap USB 3 sticks on FAT mounted with
>flush (the udisks default). It stops close and the flusher from writing
>the same file at the same time.
>
>Tested on v7.2.12 (stock and patched) and mainline c339f4010dea
>(patched), bare metal, same stick. With the flusher kept busy
>(dirty_background_bytes=256M, dirty_writeback_centisecs=100) cp goes
>from 6.8-8.7 to 13.5-17.4 MB/s. With the patch one task writes the file
>and 96-100% of data bios are 768 KiB or larger (4-16% before).
>
>Only measured on one usb-storage stick. UAS drives I have used did not
>show the slowdown, but I haven't traced them.
>
>fsync() and sync_bdevs() can race the flusher the same way on other
>filesystems. I kept this patch to FAT, but have numbers for exFAT, ext4
>and btrfs if useful.
>
>I am a sysadmin not a C dev haven't written it much since school and so
>did use an LLM for help reading the writeback code, analysing the block
>traces and drafting the patch and text and who to email. I typed,
>reviewed and tested the change myself and feel confident that I
>understand it and can answer questions.
>---
> fs/fat/inode.c | 21 +++++----------------
> 1 file changed, 5 insertions(+), 16 deletions(-)
>
>diff --git a/fs/fat/inode.c b/fs/fat/inode.c
>index d85c8fbdcca4..0643244223c5 100644
>--- a/fs/fat/inode.c
>+++ b/fs/fat/inode.c
>@@ -1911,28 +1911,17 @@ EXPORT_SYMBOL_GPL(fat_fill_super);
> 
> /*
>  * helper function for fat_flush_inodes.  This writes both the inode
>- * and the file data blocks, waiting for in flight data blocks before
>- * the start of the call.  It does not wait for any io started
>- * during the call
>+ * and the file data blocks, waiting for in flight data blocks and
>+ * ones it starts. write_inode_now() takes I_SYNC, so the flusher
>+ * does not try to write at the same time.
>  */
> static int writeback_inode(struct inode *inode)
> {
>-
>-	int ret;
>-
>-	/* if we used wait=1, sync_inode_metadata waits for the io for the
>-	* inode to finish.  So wait=0 is sent down to sync_inode_metadata
>-	* and filemap_fdatawrite is used for the data blocks
>-	*/
>-	ret = sync_inode_metadata(inode, 0);
>-	if (!ret)
>-		ret = filemap_fdatawrite(inode->i_mapping);
>-	return ret;
>+	return write_inode_now(inode, 1);
> }
> 
> /*
>- * write data and metadata corresponding to i1 and i2.  The io is
>- * started but we do not wait for any of it to finish.
>+ * write data and metadata corresponding to i1 and i2 and wait for them.
>  *
>  * filemap_flush is used for the block device, so if there is a dirty
>  * page for a block already in flight, we will not wait and start the
>
>---
>base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
>change-id: 20261029-fat-flush-isync-ae828e018ee0
>
>Best regards,
>-- 
>Bryanna Marihugh <bryannamarihugh@manhattantech.edu>
>

I Agree with OGAWA.

Also, since writeback_inode() will just be a call to write_inode_now(),
couldn't this helper be removed and instead write_inode_now() be called
directly?

Thanks,
Matheus
