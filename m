Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353777;
	b=hhYxie6HeJw0suUCHT0M5Bs0QdM0oxK1awP12+WOFolfCCc4g1o8RZtHsZQxCDJ2pENy
	 tgnQUbbX3+FEM/SkWF3uwweVBlxNxW/Zyip3C3/qez+BFGoSlLL/5orHUhyCPhITWGJz2
	 1Z0lpmgazD9wWh5JuTGerVEyHZLqV3QWqQlX3MXQC1T89fbk+0Rm6AoX6pDJZf8RA8L+j
	 2sPyrwPJ7ZQ4SCp8C+Ol0Miz/Yal3RDnSaDQIi/VaqBux8qyo0RwWXzF1FETG76EXpqTh
	 lGg11bp0YQS+JntKZTQlhgJnp8qRMV+O2JsRNVjPdNaZA+Cpx6SPh0BETnx4kaWa80Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9j40vAAQxWU/iVBPss+tYuSkGZovCJ/UyhmWEuObdcw=;
	b=2ViaoMNH5sa57LaDCb9qyQE7r74cRkF3Mxk6IUDSMRpsPf18v56BC5IvEhNIG5VsFndw
	 Sj5a/iRKduKvQxjqvRkx5DXsIvP6iMhy8QEmGbW5gn0FNiwolTDcmu0zkGx/8zwPdAnet
	 5lK6++v8phJe2HX/4OaS7Nk2Ocu09uZAQY9kGAjVGWmtAvNBEvOzG+jdU3outBahANjfs
	 kobg4lzF3XJ7kbzJfaNXXDA1bsrC6zm+Ul2pZqsb+6O1Rft4Z0rjXwbn4Fh7ZuqLMqINC
	 WC1t/bxa3tHqIAJ5zE4mQpW3xaAe8ELAfIiFszAKbNw0/sW3517eUq8SUzrCvwv0Wbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Y4wSKttz;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A28606A320
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 23:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6A28606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Y4wSKttz
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b30ff12f84so20102047b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 15:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794353775; x=1794958575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9j40vAAQxWU/iVBPss+tYuSkGZovCJ/UyhmWEuObdcw=;
        b=Y4wSKttzb+XEpQBmS61mROvznHqsOvQ0mrkGAHS39dCaYJWPbf+rFxjRL31CCiKuTh
         vy0jsr6bEAFdm4Q++G/3C8V+U/OwhTkLhAJYxhuych6NwDvvnTWZMbL77DIZnppTOT/+
         nBdfg0Ui72qiqCimp+6RjMMSnTzWjUjiwYJstvgQOtHyNjfy4p8SSchlzJMlHGdo2FPn
         HyQq0OOAjz+rmn7j7N0Md5GTIF6GQX8PsPc9AJfjLH9J5qTjS5UzFhfDnq3H1RHy2Ed2
         Ewa6pkYLECxPdXw5yGnQfCWEpgCfx6SRUUYoeJd60DdiCGUDp+OQn6FUOOpHbf9/aOMl
         vgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794353775; x=1794958575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9j40vAAQxWU/iVBPss+tYuSkGZovCJ/UyhmWEuObdcw=;
        b=D/0TI4Pdnz39TXqNA8kfRLwFZPT8kSfFsqz4mCEWke11AkzhKpLm7ax01xmuaZ7P1G
         VSVNzYz7g3pxZkRVzVL1Ca/RYy+psG1OLkjBvrQJpy064yHXKw1V/Et6UScQnSh/jT2v
         S1aCDZX3bUf/jK8XN98pp+W1o+OUh1FGGV0+d77On9s5VqNKGtp+syMh3GHW8xpYs+ap
         H6KeD4cxrI/aeLQQBZ+KeFcIuzslhjWKZfOWKP+qIDffTceyOQ1YGYvmC68qT8NsirZ8
         n7RyG+nbTXPqfBmNPgemeM6yF6YUbzW2EpYsfVqrv9P1A+PjRvfjRzaOvXjnmfUTqE7q
         YmXg==
X-Gm-Message-State: APuU4Z9jGJFLlLrIIz46shVW4922rFOY/veAUATQnBfrwu39POsCbu1V
	nzLDPhrv8eUch1ruVv21LmRo9eplxIZ/YIA2ggND+0KdAyxyjPgfpFSUpunFZfw8Xt8=
X-Gm-Gg: AYBFou1UUWc8SFkHhp97N56x8ze+b1CxI4IiV4d/3h6hB49111BIWk9bxnL+63BjRAu
	aeEsJTwAE+/XDvh9KnIsOM3WJjuKC37vdHlFqaxh+3cVV8pUpgw2qYfkdd28sGs3zHnCj84zX6u
	wDrq9gSO90grBpjmglr1kAjvrV1zFGkQczRxzohrvrxD1BNotFoGH4K9Y2MdfpzPiwydiHok8Nk
	n6tGJ3SQm5H8M01CWgtjElffIS039lRXKGrdQATG6fqwz1dM7LjGWTPpTW+VyUM/YMDRq+m2OKY
	0ActD2Uch2pFwSVvbaIbtmhfbSMPc83bLrewo6wdTkAq9M4BrF76PMGLMA2nLKV0m2EpCqtM+CM
	AK8u+L47x54Q/QkMw2ozTGw0lB3qc2/SoM2WYGQSCwrdbK96xcyuW39nqpeaytC4ZFOD/i8xNQZ
	oiHTbKIvZT15RQb6F2ZSksTlae677FddGIOrVWB5M+rHX130mzxan0fjEbSXxSE8FQAHA3YTP/T
	AHGkHUy+qesP/wgX8pXiEXxN0SeGsTUR+oAlmVWoH3dalRVLkdqUhGWcIowN/iETR0u6zG7Ixb4
	mWAVclWmwMk35/61EAtZ4FJEDEoDhVmNDxsvw4e0UI+E8Xy62XiBqIembVdZEe9f6UB/256XO9X
	NYffSR5UYeY2+wKvxvZCwpSpUs+TvaNeNJAAp3T9rlhED/cBG6qJ5cZ78GM1E/ihJDpbrkncJtD
	L/AHBKd5K4m0aCCcWQ
X-Received: by 2002:a05:690c:ec2:b0:8b3:361f:5d77 with SMTP id 00721157ae682-8b3a8120d7cmr8569287b3.26.1794353775437;
        Tue, 10 Nov 2026 15:36:15 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:1541:987e:e160:f038])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933d1047sm31652577b3.19.2026.11.10.15.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:36:14 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 0/2] hfs/hfsplus: release preallocated blocks on truncate
Date: Tue, 10 Nov 2026 15:36:07 -0800
Message-ID: <20261110233609.561557-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
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

HFS and HFS+ extend a fork in whole clumps, and when an inode
is loaded the number of allocated blocks comes from the on-disk
physical size of the fork, while i_size and phys_size come from
the logical size. So the fork can hold more blocks than i_size
needs even when phys_size equals i_size.

hfs_file_truncate() and hfsplus_file_truncate() return early when
i_size equals phys_size, before comparing the required block
count with the allocated one. This logic has been added
to avoid dirtying an unchanged inode, but it also skips
releasing the extra blocks:

 - a file whose size is aligned on the block size keeps its clump
   preallocation after the last close;

 - the catalog delete path does not free the data fork and relies
   on truncating the inode to zero size, so a file with zero
   logical size but allocated blocks leaves those blocks marked
   as used in the bitmap after it has been deleted.

Make the early return happen only when neither the
size nor the allocation needs to be trimmed, which keeps the
original intent of not dirtying an unchanged inode.

Viacheslav Dubeyko (2):
  hfsplus: release preallocated blocks in hfsplus_file_truncate()
  hfs: release preallocated blocks in hfs_file_truncate()

 fs/hfs/extent.c      | 13 +++++++++++--
 fs/hfsplus/extents.c | 11 +++++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.43.0

