Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306628;
	b=lsGpiA2NXR/6ZFiYLayJqXQm5rIjJVPk8NSfDGV4N57WRuvwygtgCYQEuwIB1+l9bBqq
	 35UH305eg/4fuaDMBPQwGfCsatOXR2VmWebNMTjDRbm4CqVnWNmHdz9/VIf69iPyPQpMd
	 Ykq6/gsAeePvRmvNkazg+ytv/Jo6yzi3AQudMqLQZW68hA5KvDbMJuPwHeS9i1vZAVm3V
	 AdnuOVp77QxzB6A2shPfTsK+X8YKIHqf9fZWJgLAmHPKJOayG/M1i7inkqA6sytGftQdK
	 g/8MyOEvhX6bBkfg0+FAcyE1q6CQIddyLP3o9KNK+cEoOmFOeWytc6cR67ApiRqoyEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306628;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=3E34M28HzYoZvsTeEKolT2k8nmKkmFu85l0DW5vC3rg=;
	b=QDyczlCr0efrlrrKNbSO9LVFN5nTu4T0GUZKTBkPbLBv/fCcTVyOrmY7pUsZCTEzedLS
	 I+nqIQkWRCvG9BczsI/MaCTzwPXHK8znbsudCBEMTWE18Sklg0Z+Wi9aY7iqc0yUb+0DK
	 F26JgrXkX3QidT1HuOdKMCenzSjEqBJZ4GdAJD+QZDkdBoHHVaSCdEV+b7PTPRbJqX1uu
	 TBatzmGMKDZjVU8pKYJra2z0EK/rtKggLjOr6f0tXdhASRHlqpTiZqzKdJsNsiO9tDdb1
	 ESwBn3KyH793yGrKW4N1U4XFvPRumJKxuHKq2xSitGHDUeh4gDcO8KzhZKVgRO7NzPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=RRckdDSE;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=iQPFP+Xc;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125F7606A330;
	Tue, 10 Nov 2026 10:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 125F7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=RRckdDSE;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=iQPFP+Xc
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 4653E20BD28D;
	Tue, 10 Nov 2026 19:30:17 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1794306617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3E34M28HzYoZvsTeEKolT2k8nmKkmFu85l0DW5vC3rg=;
	b=RRckdDSEMhoY6crIxF5wOG1kXyhs++xcmVtsl0EcsI7s04cFMRZ9FLpYKK+o/+aArqWp4M
	kECZVDDKA2vWFMO1PymH5WG+rM755KfrY5s7pJVig8uddXzYUgZ4n7LlKE4Uebl7Qqhqpq
	tpEJfWRagr6IcOFdXjSzBHGYRYIQKBSXjL5rZi6HPLgtzUo1d/Xu/CAWa1Cr+t1M304b/g
	ZzZHinNCBovW1sP4pbg/7IYw4CHiKkadDhCGaH2iJ5IG/OW7ieyjVaIDunErZxH/eWApr9
	o83Gi2Cs1STeXy8mHSiuhiJbWnrjbc+tHF64GFgQXGaMazloCMPz4XiY28e3yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1794306617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3E34M28HzYoZvsTeEKolT2k8nmKkmFu85l0DW5vC3rg=;
	b=iQPFP+XcHKbSuV4FRUJWopQ49GXEaFBT8aoIWoOrHCrfZW9ZklKCWXz8fo1zybm+FzoRNL
	nKj2ErHgyh9U0+AA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id B9FABE000DE;
	Tue, 10 Nov 2026 19:30:16 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id AFF1922000A0; Tue, 10 Nov 2026 19:30:16 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Bryanna Marihugh <bryannamarihugh@manhattantech.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Jan Kara <jack@suse.cz>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fat: use write_inode_now() on flush to avoid racing
 the flusher
In-Reply-To: <9ced619f-58bd-41fa-b8fb-863bd49d5dbb@manhattantech.edu>
References: <20261029-fat-flush-isync-v1-1-69c02c258d0c@manhattantech.edu>
	<878q3gth64.fsf@mail.parknet.co.jp>
	<457c34c8-b52f-41c6-8b58-ed334b0dc483@manhattantech.edu>
	<87ik2jsp9n.fsf@mail.parknet.co.jp>
	<87a4nvso7w.fsf@mail.parknet.co.jp>
	<9ced619f-58bd-41fa-b8fb-863bd49d5dbb@manhattantech.edu>
Date: Tue, 10 Nov 2026 19:30:16 +0900
Message-ID: <87cxsd6ksn.fsf@mail.parknet.co.jp>
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

Bryanna Marihugh <bryannamarihugh@manhattantech.edu> writes:

> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
>
>> > Bryanna Marihugh <bryannamarihugh@manhattantech.edu> writes:
>> >
>> >> There is some regression with small files on the uas drives from the
>> >> wait.
>> >
>> > Is this wait=1? The flush should just be early flush, no guarantee to
>> > flush completely. So I think it should be wait=0.
>
> Everything I have posted so far is wait=1. I just wanted to provide the
> benchmarks for my existing patch. I have a wait=0 one I have been
> testing now. I labeled it in the benchmarks.
>
>> > And the flush is assuming basically for removable media though, we can't
>> > choose. I think we need to check the result of such HDD/SSD.
>
> I did tests with this machine's dirty_background_ratio=5 (the kernel
> default is 10), which results in a 3.4-4 GiB threshold, and with a
> 256 MB threshold (dirty_background_bytes=256M,
> dirty_writeback_centisecs=100) to test what a more RAM constrained
> device might do. I set FSINFO next_cluster before each HDD run so all
> three kernels write to the same part of the disk.
>
> WD Blue 500G 5400RPM HDD SATA
> copying a 4 GiB file 3x, then sync, MB/s
> (requests and average size are from the third run, which was traced)
>
>   5% threshold
>     stock:  89.4, 86.9, 87.8  (8,913 requests, avg 471 KB)
>     wait=1: 97.9, 97.3, 95.2  (2,168 requests, avg 1,951 KB)
>     wait=0: 96.2, 95.7, 98.7  (1,626 requests, avg 2,580 KB)
>
>   256 MB threshold
>     stock:  81.0, 88.1, 81.4  (16,291 requests, avg 258 KB)
>     wait=1: 100.7, 99.7, 98.4 (2,257 requests, avg 1,859 KB)
>     wait=0: 101.9, 100.5, 98.7 (1,532 requests, avg 2,738 KB)
>
> WD Blue 500G, copying 1000 x 1 MiB files 2x, then sync, MB/s
>
>   5% threshold
>     stock:  9.44, 9.45
>     wait=1: 9.34, 9.32
>     wait=0: 9.55, 9.58
>
>
> Samsung SSD 870 EVO SATA, copying a 4 GiB file 3x, then sync, MB/s
> (requests and average size are from the third run, which was traced)
>
> The wait=0 runs were on a different day.
>
>   5% threshold
>     stock:  338, 340, 341     (1,460 requests, avg 2,874 KB)
>     wait=1: 333, 339, 339     (1,366 requests, avg 3,071 KB)
>     wait=0: 313, 313, 313     (1,792 requests, avg 2,441 KB)
>
>   256 MB threshold
>     stock:  377, 378, 377     (11,476 requests, avg 366 KB)
>     wait=1: 378, 378, 378     (1,675 requests, avg 2,505 KB)
>     wait=0: 346, 344, 345     (2,278 requests, avg 1,938 KB)
>
> 870 EVO, copying 1000 x 1 MiB files 2x, then sync, MB/s
>
>   5% threshold
>     stock:  9.61, 9.61
>     wait=1: 8.92, 8.92
>     wait=0: 9.61, 9.61
>
> PNY 32G USB 3.0 (usb-storage), copying a 3 GiB file 3x, then sync, MB/s
> (requests and average size are from the third run, which was traced)
>
>   5% threshold
>     stock:  6.4, 6.9, 6.9     (12,481 requests, avg 252 KB)
>     wait=1: 17.5, 17.9, 18.0  (3,720 requests, avg 846 KB)
>     wait=0: 17.9, 13.7, 16.4  (3,809 requests, avg 827 KB)
>
>   256 MB threshold
>     stock:  5.8, 6.1, 6.0     (13,996 requests, avg 225 KB)
>     wait=1: 17.9, 16.4, 14.7  (3,575 requests, avg 881 KB)
>     wait=0: 18.0, 18.2, 17.9  (3,663 requests, avg 860 KB)
>
>
> PNY 32G stick, copying 1000 x 1 MiB files 2x, then sync, MB/s
>
>   5% threshold
>     stock:  5.49, 5.62
>     wait=1: 5.82, 5.62
>     wait=0: 5.66, 5.65
>
> Samsung 64G USB stick (usb-storage),
> copying a 4 GiB file 3x, then sync, MB/s
> (requests and average size are from the third run, which was traced)
>
>   5% threshold
>     stock:  33.0, 33.0, 33.1  (12,725 requests, avg 330 KB)
>     wait=1: 33.2, 33.1, 33.2  (4,521 requests, avg 928 KB)
>     wait=0: 33.1, 33.2, 33.2  (4,583 requests, avg 915 KB)
>
>   256 MB threshold
>     stock:  33.3, 33.3, 33.3  (15,757 requests, avg 266 KB)
>     wait=1: 33.3, 33.5, 33.5  (4,534 requests, avg 925 KB)
>     wait=0: 33.5, 33.6, 33.5  (4,645 requests, avg 903 KB)
>
>
> Samsung 64G stick, copying 1000 x 1 MiB files 2x, then sync, MB/s
>
>   5% threshold
>     stock:  7.34, 7.34
>     wait=1: 7.33, 7.34
>     wait=0: 7.32, 7.35
>
> I was a bit surprised by the improvement on the HDD. I will see if I
> can find a high end HDD.
>
> With the SSD the 870 EVO I did the wait=0 test on a different day.
> Not sure why but it seemed to be slower on the wait=0 test, I am
> blaming the run being on a different day. I think performance is
> probably mostly flat with the fix.
>
>> And maybe it needs to check unmount time (check how many dirty was
>> missing to flush).
>
> wait=0 does come with that downside. If the flusher is already writing
> the file at close, wait=0 skips it and unmount has to write the rest.
> At 5% the 3 GiB file on the PNY stays under the threshold, so the
> flusher doesn't start until the 30 second expiry. That's why stock is
> still slow there and wait=0 behaves like wait=1. The 4 GiB files go
> over it.
>
> PNY 32G stick, 3 GiB file, cp then umount right away,
> average of 3 runs (5% threshold) and 5 runs (256 MB):
>
> 5% threshold   cp returns  dirty at close  umount   total
> stock               485 s            3 MB   0.6 s   485 s
> wait=1              184 s            3 MB   0.8 s   185 s
> wait=0              180 s            3 MB   0.6 s   180 s
>
> 256 MB         cp returns  dirty at close  umount   total
> stock               513 s            3 MB   0.6 s   514 s
> wait=1              176 s            2 MB   0.8 s   176 s
> wait=0              2.6 s        3,004 MB   172 s   174 s
>
>
> WD Blue 500G 5400RPM HDD SATA, 4 GiB file, cp then umount right away,
> average of 3 runs (5% threshold) and 5 runs (256 MB):
>
> 5% threshold   cp returns  dirty at close  umount   total
> stock              47.4 s            3 MB   0.8 s  48.2 s
> wait=1             43.5 s            3 MB   1.2 s  44.7 s
> wait=0              2.2 s        4,064 MB  42.3 s  44.5 s
>
> 256 MB         cp returns  dirty at close  umount   total
> stock              51.3 s            3 MB   0.8 s  52.1 s
> wait=1             44.0 s            2 MB   1.3 s  45.2 s
> wait=0              2.0 s        4,021 MB  43.2 s  45.2 s
>
>
> 870 EVO SSD (internal SATA), 4 GiB file, cp then umount right away,
> average of 3 runs (5% threshold) and 5 runs (256 MB):
>
> 5% threshold   cp returns  dirty at close  in flight  umount   total
> stock              11.9 s            2 MB     362 MB   1.1 s  13.0 s
> wait=1             12.2 s            2 MB       0 MB   0.9 s  13.0 s
> wait=0              1.5 s        4,006 MB      22 MB  12.3 s  13.8 s
>
> 256 MB         cp returns  dirty at close  in flight  umount   total
> stock              11.9 s            3 MB     112 MB   1.0 s  12.9 s
> wait=1             11.9 s            2 MB       0 MB   0.9 s  12.8 s
> wait=0              1.7 s        3,350 MB     180 MB   9.7 s  11.4 s
>
>
> I can type up an actual patch with wait=0 and removing the helper
> that Matheus suggested.

Hm, wait=0 looks like affect umount more than expected. The following is
untested and not perfect though, how about something like this?
(I'm not sure if this is acceptable as generic function though)

Thanks.


/* This want to flush dirty without waiting write completion. */
int writeback_inode(struct inode *inode)
{
	struct writeback_control wbc = {
		.nr_to_write = LONG_MAX,
		.sync_mode = WB_SYNC_ALL,
		.range_start = 0,
		.range_end = LLONG_MAX,
                .for_sync = 1,	/* purpose: don't wait write completion */
	};

	if (!mapping_can_writeback(inode->i_mapping))
		wbc.nr_to_write = 0;

	might_sleep();
	return writeback_single_inode(inode, &wbc);
}
EXPORT_SYMBOL(writeback_inode);


-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
