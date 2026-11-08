Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125319;
	b=iWa4vbHc4itlstl5wMOugNpxjY9m2ibvUbdDYZTAoUwqMfWSm16UgjJOa0j91pSE8MWK
	 SIdBvV5s4eNZYb6EuFyE2k/K7iVW+Whvki35+D74ymyQ87ex8OGxL9bGA5NBmeh2GJNYi
	 F+jzeMSb77oX0ujS7wbFC2b8ps3QDJC8pXVOYzgCyqCn45Qe/DxZFdHFgIk5T9/JymKsF
	 XGSm4De2fR9kTZelcOSP8locHXf7BlU4eYXWP/WcXpqGAqpxQl1BetmnKqENPaD+H2z3s
	 06P5zbKQmsYqKhI7knj3reomL0acmefz+mQZL6dIoP78yLDDb6tcY6h6zf2wMzgJ3kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TsRttVjyd52nFqSKn2goHPGI41zRyopfMZ0qKg9Sa5g=;
	b=JqBoLf02gX5uEgWwe1Hn324/M/8v4uMUdv4xI0Nv1HZySbMiGWCElk9mTFz2SN7glYFx
	 RNq8tBwLhRMFYySFrqnark5e/0RVU+cpq87RlFDz2TppD6fbEhpzWoGx/ZV6Bfm47zyku
	 i3vBeKK+a7JIxBL3clTZNxALEPDBFGOUK3DrS7vFak05qUOeeZQ6EzQjecP7fzNlsx5+x
	 72TRz+c/TMD9v99yoRI8bQEVhkBJQjtK1ymwRB1zyd5gM8yvOjECBZScUxCIu32jIxs/L
	 pT+AIPr34olfZ8wKIRsUzDnGtguClRGc/Z9QSlkYC8BaiJGHg2YinO4n7uzCAS27T6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="r/m7Zo7P";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915FF606A323
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 08:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 915FF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r/m7Zo7P
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-37000e7234bso890324eec.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 00:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794125318; x=1794730118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TsRttVjyd52nFqSKn2goHPGI41zRyopfMZ0qKg9Sa5g=;
        b=r/m7Zo7PFarqKvoI+Fpdim0GYjyaCzcMe1baV5ykCMlaJ6T5LaoNb+8dvaJT6Yzkin
         gHMf/n3RrOD0/WroYYQgCvWZTaxBZJBD2Xnu+++W4i9MSQBVDi++W1MW8dc4KhNWyE4e
         xdsFkdy7HfL1s5NdGxVC1vUn25pqrc62mMSWzFndU4Yr0KE4t4qbdoDDZEsiyG/il9gi
         jwkYhPePT9pxrvJB47bqpscAuW6M/7N6vLlrDLge9gMgBjOFpi7P2ww4teKeuRxMMc34
         qzcTkSVhDx9s3hObPtescXpepLafzuM+v8lQupntdbcHnGJ0z7+xEjBlEwWro5QbDY3M
         4SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794125318; x=1794730118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TsRttVjyd52nFqSKn2goHPGI41zRyopfMZ0qKg9Sa5g=;
        b=bt6imIjpb9AtIRtk2zYJG+TpBPqqOLkJ1mBYnsAW4t4im55c0fIfyNZEjvV8Xbnk6N
         GZIXc3oMkXtHlhp5mG+btX4ReLLr+6kRS/y262/yzLwwv0Mdz5y4YquzzqV6+x4IrVyO
         +URsqeIulQTahpS7Lu8uiUHgX3HHd0ENs//4NQ0YevApv/AAX+7dbs35ojiOvp8CqXR/
         fSLfct1uopJWHOAPKqRB0J0zqQrp1APGQGLLYzbcbBZnYps8bsXwvmjK1R8vLvxUXe/N
         AomKjkCIVS+YbG4UH5a8glnz2BM6lJs/3GDvCLU/bwYvXJ4yUVVK4DLTSzd5rbph7Zkb
         y8gg==
X-Forwarded-Encrypted: i=1; AL+hErFPLOQCkO3Mi8Ra9V3x3unBnBXrELN6SHZlII73GTiWyweYdnc6LZd8tlxC55T24fVBls2b/3t1CfG2etMM@vger.kernel.org
X-Gm-Message-State: APuU4Z89PyhJg/aupcqF2HGG8vFbrSZTI/TqC4jmFksgqpUEpq4wsHrl
	bUquk6pGaNivfPUj7gO10tjNgQ6Sz7VPgjh5OQTBhy+OuTP56Gqy+LFpPdUwA3TvyaDdpQ==
X-Gm-Gg: AYBFou2ZgBR2vlr4kjTqQks6OvpL9K5ImFnoIJrV20T/LJBU7DWG8+qvtP9RI+r4rpz
	2q5yh6vhZNHB/bmMDNP/AHswhdTvzhyTcfgOGYy+efPcbfbfqj//0DaHQNFM8ergIJf7ioRnm98
	TGyQnhpeHwGS78VC243O71I9QfIp+vUnIk4EeHFwvj+oxCD8VS8yt38CtZ8qgESjGbipEzMVOsR
	uX/bfhOf7vLYjwv7vOQf5+idBT1t/UwYbpOduCSp/kuvpp60ANOK+Rhu47MX2XummhZI0+Wh52r
	DsPMvO0wUUs7WNn96XPnJpwGjyBpqWVt2XVbpd7gSuIDgUWnSRIpCWz9CFKbie1N1c3nihTQEdI
	4Ic2Ale/otGfGEGMPNOkinh8Os1jquUxiQf2qyaJQnj2KUxwE4rY1VegNgHw8Uco+I1klZXZ/hM
	Q4/9htlBOmEu/hyczRYNNQBYthCqW7+Nsvv1yhxEkqOjlasHxy02v4zZz8tH7zFyDQs66m091nF
	GLr7wjQuKRnZyKJsVSrz6HDZdjehKCqlPc0yjCk4FBeN2n1tJGFNfqOdTAVELY2AhUmRyNwW8dW
	RZ/nLqO2e/fNEVQIupsa19x7nRAIJm/ALc6bhCPaE79EVbieprURLFCDNxNOE0jLRQ==
X-Received: by 2002:a05:701b:220d:b0:1b2:6cba:7f48 with SMTP id a92af1059eb24-1b39ff068c2mr1346405c88.31.1794125317382;
        Sun, 08 Nov 2026 00:08:37 -0800 (PST)
Received: from anon-laptop ([103.187.196.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e8a27sm3898586c88.7.2026.11.08.00.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 00:08:36 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ntfs: do not convert a named $DATA stream when making room in a record
Date: Sun,  8 Nov 2026 13:38:23 +0530
Message-ID: <20261108080823.473369-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKYAXd-68oCuAU=x0TV6BMsNJZkmBcdVZTtOQXh3iEm6BptJSg@mail.gmail.com>
References: <CAKYAXd-68oCuAU=x0TV6BMsNJZkmBcdVZTtOQXh3iEm6BptJSg@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

You were right, v3 deadlocks. I reproduced your diagram: with a debug
delay before the folio lock in ntfs_attr_make_non_resident(), a reader
of the stream and the make-room loop hang the kernel (hung task, lockdep
shows the writer holding the unnamed inode's i_rwsem and mrec_lock and
waiting for folio 0, the reader holding the stream's folio 0 and waiting
for mrec_lock). The same direct conversion of the inode being written
is safe because the reader of that inode waits on its i_rwsem first.

An automated review of v3 also listed other problems with converting a
stream from this loop. I could reproduce most of them, with a forced
make-room pass and debug delays:

- a write to the stream that passed its residency check before the
  conversion carries on with a non-resident attribute (iomap_iter
  WARNINGs, "possible recursive locking", hang)
- an unlinked file with an open stream: "mft 0x1b, type 0x80 is
  corrupt. Run chkdsk." and the next write to the stream fails
- a stream that is being removed is converted under
  ntfs_stream_finish_remove() (unlink returned 1)
- two streams whose names differ only in case: WARN in
  ntfs_attr_make_non_resident(), the lookup ignores case

v4 keeps ntfs_attr_iget() for the named stream and adds what is needed:
FGP_NOWAIT for the folio in this loop (skip when busy), convert a
stream only if it is not in the inode cache and its file is not being
deleted or unlinked, and compare the stream name exactly. All of the
cases above fail on v3 and pass with v4. The WARN from the original
image is fixed.

I could not show data loss on unlink, only that the unsafe state is
reached. The debug delays are mine, so these windows are narrow without
them. If you think this is more than the loop should
carry, the one-line v2 (skip named streams) also fixes the WARN.

Thanks,
Wahid
