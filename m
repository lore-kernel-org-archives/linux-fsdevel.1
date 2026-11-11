Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408348;
	b=5jICnd4LaYvMSFuJktgG4SAocgd4Tmb5N+cq9CxslA7fVSZY/uU7gM0FCnosS3NyI2lI
	 319j/tibInaQTBx2EOaHqBqLdPrj1V3L+pXeJg15PQ0XNnbe/hX33AGMoT4SaMaCuFafB
	 hmMfIuTeSUodSZc4JuWEt53fC37JByZqkxdXdN9srOAJeFdezXowOTpGK+IZPP3j+ff78
	 b1YhFZL3VPJInkGOBzupWAw4HyZjJsfNcw52b507K+LNkgFVpdcZVVf/iWnDuVEsjWBc+
	 b3KXfV/OaoQdDl2iQmUj1oj6BeTElazorxsRJ06VyQ7Mdg+E93iIYA2dTvVqQySWPKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408348;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=+/KI1uKtvmdWUDWfBWuIRSM1SIl3IB8I/zH1iiRa4B4=;
	b=2KJqPEh1vQ2gzGWMqowFanVcQ6WlCyxD1j3gUaS5NYkjSKe5LDriZS5l5rATC9jnDMo8
	 2nfI9eO6/p6FWVrrPdnWWQIUAGYFHTRdrqbB6hxdHJv1JSyHL9pReNL9i5UAxiYt7W9lx
	 vawNi+tHk/aoUnB9xcOg8TixPh10WUoRIv7nzshSYlI4dOr+43D16gkuWsRr6zj+btS38
	 +NEhUu1IllUb7YzMqZG9BQ01DxQZiS2u3flPWg0YvW77fEqTt0gS632UrqMtgoTVLUKFn
	 YftDK8HZkCsB33XZ/3tLp/u9OfxUNkv4BQX4jPZm7bGPb7t/yLQJpZRvThbe240l7vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UPC4lBDk;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1KNLLQ0F;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=URS7iJnM;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UAn9B18O;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774C606A33B;
	Wed, 11 Nov 2026 14:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A774C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UPC4lBDk;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1KNLLQ0F;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=URS7iJnM;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UAn9B18O
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D730C200FB;
	Wed, 11 Nov 2026 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794408346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/KI1uKtvmdWUDWfBWuIRSM1SIl3IB8I/zH1iiRa4B4=;
	b=UPC4lBDk7tk3XlTWZZFeNMbc2HgsqB99ae2Z6+IxHrjxawkSXQguoZoOAtTJNAiNHMuI+A
	uWIx2aspP7xawTUwz5vBGA2XBP702t3ykOMyaAHVfjhiYpEd87Q4NGdi0IZ8Y40T54RxCo
	GnHTZpua0TyVocONDTZGJQknNZ3ORKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794408346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/KI1uKtvmdWUDWfBWuIRSM1SIl3IB8I/zH1iiRa4B4=;
	b=1KNLLQ0FSTDrbOByVVvqmUpYG+qKB++a85XgTBcFdJsEG0aE9U7O2a4N7ZOR9d7+TCHSmQ
	nau+7aFq0gMs6pCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794408345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/KI1uKtvmdWUDWfBWuIRSM1SIl3IB8I/zH1iiRa4B4=;
	b=URS7iJnMiKuoIJenCr94xXBJoCKNO24EFo8fwwOBs73hcb8y8JbtpOM15lcjKvf4DsvSyk
	Zi7P7t4l4vM3LlzEAre9+W7eWZ2dO55svNS2/tXos0ejyQ/rttXFNpCUWmx6WwBrB0bgqn
	mjLLxn2tTaXExURdVDBo+7m5dfaTM8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794408345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/KI1uKtvmdWUDWfBWuIRSM1SIl3IB8I/zH1iiRa4B4=;
	b=UAn9B18OtdVyoDJHzvclEfKmUIzq1ibgY5u5xG6Ima8kth8hntrf632yOismtZoMWZHO0R
	bKJnnuuox7r+YnBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8BF0134E5;
	Wed, 11 Nov 2026 14:45:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bCfFIJl/9GrrIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Nov 2026 14:45:45 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 393DA22951; Wed, 11 Nov 2026 15:45:45 +0100 (CET)
Date: Wed, 11 Nov 2026 15:45:45 +0100
From: Jan Kara <jack@suse.cz>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Bryanna Marihugh <bryannamarihugh@manhattantech.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fat: use write_inode_now() on flush to avoid racing
 the flusher
Message-ID: <5iw7225asalwfuv7qdojzx7aqslfh7ctabqzicvrabfd5irsry@v4qvxiod3yz4>
References: <20261029-fat-flush-isync-v1-1-69c02c258d0c@manhattantech.edu>
 <878q3gth64.fsf@mail.parknet.co.jp>
 <457c34c8-b52f-41c6-8b58-ed334b0dc483@manhattantech.edu>
 <87ik2jsp9n.fsf@mail.parknet.co.jp>
 <87a4nvso7w.fsf@mail.parknet.co.jp>
 <9ced619f-58bd-41fa-b8fb-863bd49d5dbb@manhattantech.edu>
 <87cxsd6ksn.fsf@mail.parknet.co.jp>
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
In-Reply-To: <87cxsd6ksn.fsf@mail.parknet.co.jp>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -12.80

On Tue 10-11-26 19:30:16, OGAWA Hirofumi wrote:
> Bryanna Marihugh <bryannamarihugh@manhattantech.edu> writes:
> 
> > OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
> >
> >> > Bryanna Marihugh <bryannamarihugh@manhattantech.edu> writes:
> >> >
> >> >> There is some regression with small files on the uas drives from the
> >> >> wait.
> >> >
> >> > Is this wait=1? The flush should just be early flush, no guarantee to
> >> > flush completely. So I think it should be wait=0.
> >
> > Everything I have posted so far is wait=1. I just wanted to provide the
> > benchmarks for my existing patch. I have a wait=0 one I have been
> > testing now. I labeled it in the benchmarks.
> >
> >> > And the flush is assuming basically for removable media though, we can't
> >> > choose. I think we need to check the result of such HDD/SSD.
> >
> > I did tests with this machine's dirty_background_ratio=5 (the kernel
> > default is 10), which results in a 3.4-4 GiB threshold, and with a
> > 256 MB threshold (dirty_background_bytes=256M,
> > dirty_writeback_centisecs=100) to test what a more RAM constrained
> > device might do. I set FSINFO next_cluster before each HDD run so all
> > three kernels write to the same part of the disk.
> >
> > WD Blue 500G 5400RPM HDD SATA
> > copying a 4 GiB file 3x, then sync, MB/s
> > (requests and average size are from the third run, which was traced)
> >
> >   5% threshold
> >     stock:  89.4, 86.9, 87.8  (8,913 requests, avg 471 KB)
> >     wait=1: 97.9, 97.3, 95.2  (2,168 requests, avg 1,951 KB)
> >     wait=0: 96.2, 95.7, 98.7  (1,626 requests, avg 2,580 KB)
> >
> >   256 MB threshold
> >     stock:  81.0, 88.1, 81.4  (16,291 requests, avg 258 KB)
> >     wait=1: 100.7, 99.7, 98.4 (2,257 requests, avg 1,859 KB)
> >     wait=0: 101.9, 100.5, 98.7 (1,532 requests, avg 2,738 KB)
> >
> > WD Blue 500G, copying 1000 x 1 MiB files 2x, then sync, MB/s
> >
> >   5% threshold
> >     stock:  9.44, 9.45
> >     wait=1: 9.34, 9.32
> >     wait=0: 9.55, 9.58
> >
> >
> > Samsung SSD 870 EVO SATA, copying a 4 GiB file 3x, then sync, MB/s
> > (requests and average size are from the third run, which was traced)
> >
> > The wait=0 runs were on a different day.
> >
> >   5% threshold
> >     stock:  338, 340, 341     (1,460 requests, avg 2,874 KB)
> >     wait=1: 333, 339, 339     (1,366 requests, avg 3,071 KB)
> >     wait=0: 313, 313, 313     (1,792 requests, avg 2,441 KB)
> >
> >   256 MB threshold
> >     stock:  377, 378, 377     (11,476 requests, avg 366 KB)
> >     wait=1: 378, 378, 378     (1,675 requests, avg 2,505 KB)
> >     wait=0: 346, 344, 345     (2,278 requests, avg 1,938 KB)
> >
> > 870 EVO, copying 1000 x 1 MiB files 2x, then sync, MB/s
> >
> >   5% threshold
> >     stock:  9.61, 9.61
> >     wait=1: 8.92, 8.92
> >     wait=0: 9.61, 9.61
> >
> > PNY 32G USB 3.0 (usb-storage), copying a 3 GiB file 3x, then sync, MB/s
> > (requests and average size are from the third run, which was traced)
> >
> >   5% threshold
> >     stock:  6.4, 6.9, 6.9     (12,481 requests, avg 252 KB)
> >     wait=1: 17.5, 17.9, 18.0  (3,720 requests, avg 846 KB)
> >     wait=0: 17.9, 13.7, 16.4  (3,809 requests, avg 827 KB)
> >
> >   256 MB threshold
> >     stock:  5.8, 6.1, 6.0     (13,996 requests, avg 225 KB)
> >     wait=1: 17.9, 16.4, 14.7  (3,575 requests, avg 881 KB)
> >     wait=0: 18.0, 18.2, 17.9  (3,663 requests, avg 860 KB)
> >
> >
> > PNY 32G stick, copying 1000 x 1 MiB files 2x, then sync, MB/s
> >
> >   5% threshold
> >     stock:  5.49, 5.62
> >     wait=1: 5.82, 5.62
> >     wait=0: 5.66, 5.65
> >
> > Samsung 64G USB stick (usb-storage),
> > copying a 4 GiB file 3x, then sync, MB/s
> > (requests and average size are from the third run, which was traced)
> >
> >   5% threshold
> >     stock:  33.0, 33.0, 33.1  (12,725 requests, avg 330 KB)
> >     wait=1: 33.2, 33.1, 33.2  (4,521 requests, avg 928 KB)
> >     wait=0: 33.1, 33.2, 33.2  (4,583 requests, avg 915 KB)
> >
> >   256 MB threshold
> >     stock:  33.3, 33.3, 33.3  (15,757 requests, avg 266 KB)
> >     wait=1: 33.3, 33.5, 33.5  (4,534 requests, avg 925 KB)
> >     wait=0: 33.5, 33.6, 33.5  (4,645 requests, avg 903 KB)
> >
> >
> > Samsung 64G stick, copying 1000 x 1 MiB files 2x, then sync, MB/s
> >
> >   5% threshold
> >     stock:  7.34, 7.34
> >     wait=1: 7.33, 7.34
> >     wait=0: 7.32, 7.35
> >
> > I was a bit surprised by the improvement on the HDD. I will see if I
> > can find a high end HDD.
> >
> > With the SSD the 870 EVO I did the wait=0 test on a different day.
> > Not sure why but it seemed to be slower on the wait=0 test, I am
> > blaming the run being on a different day. I think performance is
> > probably mostly flat with the fix.
> >
> >> And maybe it needs to check unmount time (check how many dirty was
> >> missing to flush).
> >
> > wait=0 does come with that downside. If the flusher is already writing
> > the file at close, wait=0 skips it and unmount has to write the rest.
> > At 5% the 3 GiB file on the PNY stays under the threshold, so the
> > flusher doesn't start until the 30 second expiry. That's why stock is
> > still slow there and wait=0 behaves like wait=1. The 4 GiB files go
> > over it.
> >
> > PNY 32G stick, 3 GiB file, cp then umount right away,
> > average of 3 runs (5% threshold) and 5 runs (256 MB):
> >
> > 5% threshold   cp returns  dirty at close  umount   total
> > stock               485 s            3 MB   0.6 s   485 s
> > wait=1              184 s            3 MB   0.8 s   185 s
> > wait=0              180 s            3 MB   0.6 s   180 s
> >
> > 256 MB         cp returns  dirty at close  umount   total
> > stock               513 s            3 MB   0.6 s   514 s
> > wait=1              176 s            2 MB   0.8 s   176 s
> > wait=0              2.6 s        3,004 MB   172 s   174 s
> >
> >
> > WD Blue 500G 5400RPM HDD SATA, 4 GiB file, cp then umount right away,
> > average of 3 runs (5% threshold) and 5 runs (256 MB):
> >
> > 5% threshold   cp returns  dirty at close  umount   total
> > stock              47.4 s            3 MB   0.8 s  48.2 s
> > wait=1             43.5 s            3 MB   1.2 s  44.7 s
> > wait=0              2.2 s        4,064 MB  42.3 s  44.5 s
> >
> > 256 MB         cp returns  dirty at close  umount   total
> > stock              51.3 s            3 MB   0.8 s  52.1 s
> > wait=1             44.0 s            2 MB   1.3 s  45.2 s
> > wait=0              2.0 s        4,021 MB  43.2 s  45.2 s
> >
> >
> > 870 EVO SSD (internal SATA), 4 GiB file, cp then umount right away,
> > average of 3 runs (5% threshold) and 5 runs (256 MB):
> >
> > 5% threshold   cp returns  dirty at close  in flight  umount   total
> > stock              11.9 s            2 MB     362 MB   1.1 s  13.0 s
> > wait=1             12.2 s            2 MB       0 MB   0.9 s  13.0 s
> > wait=0              1.5 s        4,006 MB      22 MB  12.3 s  13.8 s
> >
> > 256 MB         cp returns  dirty at close  in flight  umount   total
> > stock              11.9 s            3 MB     112 MB   1.0 s  12.9 s
> > wait=1             11.9 s            2 MB       0 MB   0.9 s  12.8 s
> > wait=0              1.7 s        3,350 MB     180 MB   9.7 s  11.4 s
> >
> >
> > I can type up an actual patch with wait=0 and removing the helper
> > that Matheus suggested.
> 
> Hm, wait=0 looks like affect umount more than expected. The following is
> untested and not perfect though, how about something like this?
>
> (I'm not sure if this is acceptable as generic function though)
> 
> Thanks.
> 
> 
> /* This want to flush dirty without waiting write completion. */
> int writeback_inode(struct inode *inode)
> {
> 	struct writeback_control wbc = {
> 		.nr_to_write = LONG_MAX,
> 		.sync_mode = WB_SYNC_ALL,
> 		.range_start = 0,
> 		.range_end = LLONG_MAX,
>                 .for_sync = 1,	/* purpose: don't wait write completion */
> 	};
> 
> 	if (!mapping_can_writeback(inode->i_mapping))
> 		wbc.nr_to_write = 0;
> 
> 	might_sleep();
> 	return writeback_single_inode(inode, &wbc);
> }
> EXPORT_SYMBOL(writeback_inode);

Yeah, I guess I can live with that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
