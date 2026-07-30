Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927243932B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419109; cv=pass; b=sJt5qWLz5DWtFOrY5hYa/mkjqVcSlNnO8nKIwMkFVRkwxa9QFDGXwa580yO85XeMJw6tPLu5PnBx+EFqva+hlKkNGWncKzTtje5oMVUnLUh9q65QDdo1rkpxCbp06d9C50hoEmZkqx8TWR6kAl2fAxX//wCAsJEegJcch0RNjwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419109; c=relaxed/simple;
	bh=DooZteQHa6eWWZGFxr9TJH9KInviPRQxKqtAVgETm3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgSh+M7y20bdCLsJiSrnfzlrGFfpgDUHYRqunRCrEmRMo4KV2CWFJvQaQFvoTvrwY2PgWm6lpQZ4ku4rKVxkcz/df2NL92Ook5ZRZ66RxA/v1faYhjUeViAJcRK5SKG2G+/MlQxL39N3jNTzXURQJ0fw7CkbARpVa7ozpOFWkGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEWYII3I; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEWYII3I"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69e0f4eb4ecso407163a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 06:45:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785419106; cv=none;
        d=google.com; s=arc-20260327;
        b=fafHMFHa9VFUGa05vYkLs+MIMNVi1HFhdLME4aObXfWWfc6FNgwLVnzv3LYGI7qAtv
         c6YSS87rgl97oGFltcbLdQr1hUCEiRwrKOpn1wPLR1YTOKTcQe+lkRLs4xSAwiL78aSC
         RMkDsAMXiH1fHuBtEjQ5fHukbTgfZTcgy8FZUOKI3MojvykcjPRRmrT5MX08pPqBXOux
         9wRtD3jlJ3hSFhUEXRHMjMPaR4lVVNR5P3hLlZWIf5oU8lRMmGTnoqcI9eQyCsaevypR
         kMbWJYyDNnvmQHi80a0SRiXmUUdrO4gq/VwrKCJh5UJnnrP63btedQfgkMYWv/wmPcFZ
         EHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DooZteQHa6eWWZGFxr9TJH9KInviPRQxKqtAVgETm3U=;
        fh=2lHsj27fLb48ELtx7HJH5ToeHSdf692aocSedxG9Qaw=;
        b=esCPQFSE2+k0BPPd5EpSpgA1GFqguUmQ5dWS+vTW6C9QEdfkfVy55cAYqQBvwKEA5u
         uhZWjtaqSCh0bHod/NQjZG/nLfxe7o0dCODtn+9pIlyNp1Cc5oWnQrVNBQ3s02MUzFhc
         266WHDktkrzFx9NI8LZ6zJoRB+H41eS3fEujLjhxooYPbr39FMPEBf6yZwdYfB0RLtMR
         L89xrOYbJxdJcytITqAqWsz7nIlpZrNaYWeFLg84j0dxBG3Yz/a/FaFWiegdeRCaASmo
         p3Ufhif6k6U239/EgeN4s9XN1pbRCrHjf0kuHQ0O3BR3epAF661MqYbelN79aCmFSIyz
         uI+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419106; x=1786023906; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DooZteQHa6eWWZGFxr9TJH9KInviPRQxKqtAVgETm3U=;
        b=QEWYII3Ifkto15G1Clm01lB1APsrQ7NLiHyfD3Qm6kjRRca9pUMTSFGoRVNnqJKki9
         vjvjOWLiZlibg85qb8JAH+Zk/dQ3GfYFN6b5aS3xXorYi7PaXzayi1r1qJGXdzpP+HxW
         u0UIfOzkgTrbmsRvB68PffEG4t5bTUjNEdiSvU+Nv+evNgMv+qST1vLSeg89rQyxTNWf
         jDkEKJxhUlpl4QI6Y5I5f1K+FL6YSjdPyWTpytOpJaVjN9syOdZrVgCCtdpT9/O0mBhw
         sbRb/EWcztQWLHec46C+pQvpXFg5kckGuaoyFa4f8IfnjvRXybUC8mqTtHR/KR/SZ6mY
         L1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419106; x=1786023906;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DooZteQHa6eWWZGFxr9TJH9KInviPRQxKqtAVgETm3U=;
        b=gQUgHaVYF4A548CEAx7gQUf3U9uVkDgk+hEg5w/tRTlwxRHq5nnx/+Ae5k8MZ5Z97H
         hkU/NFRTnLea1TtEcqmQFMol52pPDxWdEpvFgFHXiXcHK34KeejbavVbxA+KiB4ySuJF
         K1m8uFtk0WdLM3pnCWTabAngBI6/zGAoJk474QpChwXi8OhDsbQdwkw2UYa+8V4UY05s
         Z+T0Dxf5tTPDlxVQDZc3rDdd4TDQeLRxaJshvr9s1DO0B0hka0YcrfbuM5069CgE8Zcf
         EdndIHojV13C6xTdezohZx4gTaaxXVRvDk8v6snSAzUiGKYBhIzHTLq780oA8gTXTIpC
         iQcw==
X-Forwarded-Encrypted: i=1; AHgh+RrPVb5720SJyEMHJkgPTwaPqhnCQ3NFkV//4dno3DgIdlxncJRT2e6srV48QSnWtDRiUAv0Oxq9aWOZJioJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxEcHKn3R30ADbyQv1qIp6HwJZmmfGzSobkF3KKZJKJMSx3Hg64
	Ce1eeLFZNPw6hv9HFUg/dkkqOfuSIzFY+OjZSrmhjxhSuNXNZcbAeFIR/H8W2ScQdfRU+xFlqH2
	QW5KYklumuP7YSPs959POBA0B7J1yliQ=
X-Gm-Gg: AR+sD11MypfWi+5sTsLoTAMaAef2DXBsgli6EGay+HBTqxHPQzZI93Ev93h3hXipil/
	hvy75zvUyUq/9zAF2CWWRYa+QAHPF3UM8raOQLaGI91/NtgHR6GbFl3Dd0oDGb/3o4QYWIiympd
	oTe+CmmyTakq7EH/sjla9UhvD5UOsoz60xeqppDRk99pZQE+mnSDoIxurQ5CpCJ3wGPLsStfPbT
	rxxEkrAl3mwuSMXRVgwDHoRdEp2/CDwSG5d7JT2uwBtzdl2tgx81kxxhYNdD4ZmaMFkeclikwCt
	DOtJ0wnjdmECQi4i3MY9+JavLesopFfFg6QhPMq5wwvhsNd6rkbu10I6rrIa4nzFuldknK78qw=
	=
X-Received: by 2002:a05:6402:348a:b0:698:81d7:b812 with SMTP id
 4fb4d7f45d1cf-6a090d4e711mr170014a12.3.1785419105759; Thu, 30 Jul 2026
 06:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730085801.2068723-1-nicoyip.dev@gmail.com> <lkaqsnjtsfqbnlm456mxpq4k3hchwpmd4rnwydj2xektrnem7f@gwz5xjiduxfg>
In-Reply-To: <lkaqsnjtsfqbnlm456mxpq4k3hchwpmd4rnwydj2xektrnem7f@gwz5xjiduxfg>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 30 Jul 2026 21:44:54 +0800
X-Gm-Features: AUfX_mzQIuIsZgyj3bKZW58ZUjulPcZN3lMNMEWWAdVUByKDmN1gIKHVWbC3Qv4
Message-ID: <CAAo+4rW8f1MB3u4V=uHbw8RRex1=MKUY=kUQo=5zp83eR9S8pQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: fix use-after-free of file range info
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

The v2 is just sent, thanks for the review!

Best, Chengfeng
