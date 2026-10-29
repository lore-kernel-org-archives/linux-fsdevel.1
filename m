Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793303768;
	b=VR8l/lyyQ9r8SwneEbRv3JkJ2nRVyqhTKsdVEAfCT91RhgUmylvYvUhS7rYfK1GjOona
	 sVVMVxvLsoc2+sLCFqQZ/B2v3gIsWNtjiYhtUHwmfJaUD/LwBEwEh9WxjDxhWWITFoG3f
	 nSc3KFEb8kHlnuVmSDhRLh7pgvXXSQiEYTFNXNoMyhykT2lmfyJVd5/y5pOeZCMCG0tNg
	 rb6SUb6asAq3PVbxsNtk9WepWhXXgKVq8ooLVhSRdVTMIV+tiVEsaI14qPU4p3Y/cgjpQ
	 G7Y7RIiSQP/mfdxeD50P1vrQ32jsBVDXs9YXt9sajlbhLqtN1PnRKCbpg7nor2L5Lfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303768;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2TOcI1GzA7PjARjMSYnbdoxEHVIECUaxBU8yUS4IU2I=;
	b=fCxkhkeSHOopvf5/MnrEh7mr2/hhOmIXznrpKEA9SHDAyx357smImvT6j/sA1/lhXhEC
	 AN57WqGp01cDOGg6RFUqKoDjQ3+64Hlek+oVjmhkOpWl7lrf6odIfdCbK/puZSASHZ326
	 JoXmgETORl/8JjgoHpkdTpfToORrN9di3G6HQy/+FKyVvbhn7CRFfKVrIJ7/Y1OalAf+V
	 oh0h00Vssq3TP+Qpa3WcFgxAGSiSf8cKBo+ZA9WLDRJsnynPo63p2gWCE6RZnQ4Whjxzp
	 BMcAAblIVlGen8klFHcDsTSx1gmctuxZ1teGWTq5ItWa21HZb15dQnmyWernPwiQvYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=WrnQihcq;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=L5GuXURd;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6C606A31A;
	Thu, 29 Oct 2026 19:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4C6C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=WrnQihcq;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=L5GuXURd
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 37DD126F7699;
	Fri, 30 Oct 2026 04:56:04 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1793303764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TOcI1GzA7PjARjMSYnbdoxEHVIECUaxBU8yUS4IU2I=;
	b=WrnQihcqXyuNBPcRfQM2YnOmgoPyJqOpOStnOzT4av3QNdZ3BdB8NN3b6Ft524rL6PfZP4
	TA2O4XppfEGSKmNBOzvVTOxmCs3lM40hPZOFnNvmxvbcn9KK1/SOcWsaB8rKwKGj6n1Ajv
	ipdq2HI6kV76hR6kajzKY9ibWjFZB+uBk63f4cvUVEghnV56kKQ130bd7LNYg866tEyUFH
	BSovjbnYy3QAY22o2wneLeZ6Q2ESG/L+wyPQZ5E+svxznWr3LqHrHs0+YBuvl3/DB6HGTY
	pjUJ6FYX53fqecqpyXZRRcwB3GtOL4rwXvZlVylC9x7fyPO64B6D4O6a+LZyRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1793303764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TOcI1GzA7PjARjMSYnbdoxEHVIECUaxBU8yUS4IU2I=;
	b=L5GuXURd6Ct/fh72d2wi93fwnnH8/SiKvOm3E+lzfYgiMR5enM5ybk+9nIaAC+WxJ8jh1j
	HIcIxz4TG11NjNAg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id B6793E00154;
	Fri, 30 Oct 2026 04:56:03 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id A1C9922001E2; Fri, 30 Oct 2026 04:56:03 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: bryannamarihugh@manhattantech.edu
Cc: Andrew Morton <akpm@linux-foundation.org>,  Jan Kara <jack@suse.cz>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fat: use write_inode_now() on flush to avoid racing
 the flusher
In-Reply-To: <20261029-fat-flush-isync-v1-1-69c02c258d0c@manhattantech.edu>
References: <20261029-fat-flush-isync-v1-1-69c02c258d0c@manhattantech.edu>
Date: Fri, 30 Oct 2026 04:56:03 +0900
Message-ID: <878q3gth64.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Bryanna Marihugh via B4 Relay
<devnull+bryannamarihugh.manhattantech.edu@kernel.org> writes:

> From: Bryanna Marihugh <bryannamarihugh@manhattantech.edu>
>
> On cheap USB 3.0 sticks, copying a large file to one formatted FAT
> slows down badly when the background flusher runs at the same time.
> This only impacts performance; it does not corrupt data.
>
> udisks mounts FAT with the flush option, so closing a written file
> calls fat_flush_inodes(), which starts writeback of the data with
> filemap_fdatawrite(). That does not set I_SYNC, so the flusher starts
> at the same time, which causes lots of small requests.
>
> Cheap controllers handle small writes poorly and sometimes stall for
> seconds. I have found this to be a problem on many cheap USB 3 drives.
> Older USB2 hardware, better drives and ones that support UASP
> don't show this behavior.
>
> Use write_inode_now(inode, 1) instead. It goes through
> writeback_single_inode(), which sets I_SYNC while it writes.
> Close now also waits for the data and the directory entry to be written.
>
> Benchmark copying a 3 GiB file to a USB 3 stick (PNY, 154b:00ed),
> default writeback settings: 11.6-16.3 MB/s before, 17.6-18.0 MB/s after.
>
> Signed-off-by: Bryanna Marihugh <bryannamarihugh@manhattantech.edu>
> ---
> This is a performance fix for cheap USB 3 sticks on FAT mounted with
> flush (the udisks default). It stops close and the flusher from writing
> the same file at the same time.
>
> Tested on v7.2.12 (stock and patched) and mainline c339f4010dea
> (patched), bare metal, same stick. With the flusher kept busy
> (dirty_background_bytes=256M, dirty_writeback_centisecs=100) cp goes
> from 6.8-8.7 to 13.5-17.4 MB/s. With the patch one task writes the file
> and 96-100% of data bios are 768 KiB or larger (4-16% before).
>
> Only measured on one usb-storage stick. UAS drives I have used did not
> show the slowdown, but I haven't traced them.
>
> fsync() and sync_bdevs() can race the flusher the same way on other
> filesystems. I kept this patch to FAT, but have numbers for exFAT, ext4
> and btrfs if useful.
>
> I am a sysadmin not a C dev haven't written it much since school and so
> did use an LLM for help reading the writeback code, analysing the block
> traces and drafting the patch and text and who to email. I typed,
> reviewed and tested the change myself and feel confident that I
> understand it and can answer questions.

Looks like this waits the I/O, and sounds like optimization only for
specific drives. Well, so no slowdown for other drives by this patch?

Thanks.

> ---
>  fs/fat/inode.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index d85c8fbdcca4..0643244223c5 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -1911,28 +1911,17 @@ EXPORT_SYMBOL_GPL(fat_fill_super);
>  
>  /*
>   * helper function for fat_flush_inodes.  This writes both the inode
> - * and the file data blocks, waiting for in flight data blocks before
> - * the start of the call.  It does not wait for any io started
> - * during the call
> + * and the file data blocks, waiting for in flight data blocks and
> + * ones it starts. write_inode_now() takes I_SYNC, so the flusher
> + * does not try to write at the same time.
>   */
>  static int writeback_inode(struct inode *inode)
>  {
> -
> -	int ret;
> -
> -	/* if we used wait=1, sync_inode_metadata waits for the io for the
> -	* inode to finish.  So wait=0 is sent down to sync_inode_metadata
> -	* and filemap_fdatawrite is used for the data blocks
> -	*/
> -	ret = sync_inode_metadata(inode, 0);
> -	if (!ret)
> -		ret = filemap_fdatawrite(inode->i_mapping);
> -	return ret;
> +	return write_inode_now(inode, 1);
>  }
>  
>  /*
> - * write data and metadata corresponding to i1 and i2.  The io is
> - * started but we do not wait for any of it to finish.
> + * write data and metadata corresponding to i1 and i2 and wait for them.
>   *
>   * filemap_flush is used for the block device, so if there is a dirty
>   * page for a block already in flight, we will not wait and start the
>
> ---
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> change-id: 20261029-fat-flush-isync-ae828e018ee0
>
> Best regards,

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
