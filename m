Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C241DE19
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244721; cv=none; b=tkOk0SPnBi8anKrnMl32O4tEusgkCCdVqI4efj+KKpZi+4tHhBGxra7sQmJqJcbWt9qNMIl6rAecJ+nRfCRlVopLKmM6ZgE0EpwsNTF1XRkDEaNsJIaxhwxFceTnxxJR/JD8LilXeerbW9wfqm1JamwvpMHQt883V0FvsJWWeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244721; c=relaxed/simple;
	bh=Nc++9B0b2Rw64hQH1uTtHtl01UfhcPbPRHWlll6r3Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsJCsAVcrlfNMAp+yarR03hbY7WZSWD7bYRBLxjxlmXAgg98PQ+UUhCCf8HfxjHQ4vu4NXqrzYVxVex/Hz8+p/0RkRrDiBrSX6GkyrIqW/LF4WwspNzPKKFezr/1SxKfg7NNVAH3Ed0XckVLJQYN/nTD0BucBPoVGWtpEGi49eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnyQwCIX; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnyQwCIX"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-3a02902dce2so1078135a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790244702; x=1790849502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bJLApz7a6Sj13/KQXZnv/qEoqKgMiQN8Xc7a1Ahq80=;
        b=EnyQwCIXC4PGRgH5wI0rSgFqQ9tApQapPPuRAL72HEpAC8f9Cmh+Z2wXPBTS6gY5uL
         ds+0cmEhGzzmXvqPJ+LPhPqPXZ4kUKyOKTP1ZAdpW1JPIeIVicQShAEFuicG9R1PdMGu
         LQKEeTUodlfg6mcsnwE3qsehyYSKUqIf/7RLWcnPkQs69lIM9gCEdZWIw4dx6EjXjKpT
         PjSvwsr76dEvegmFa5nHC7MrywZ6poVCsKMKM5wjffl35ZHJE9D03QM6FBGm6jvIq1OE
         Qkct/4I3nRY+a16f1QOplaAkkVOHDq5YOyfbZ1KwayGeLF5BWUDcLszRu3/899xVkGiN
         iZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244702; x=1790849502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5bJLApz7a6Sj13/KQXZnv/qEoqKgMiQN8Xc7a1Ahq80=;
        b=x1cEo/S2JsS38eSgBTVMWSC30R+VKtg9x/vurGZsX2iwOz57yhOh9QIa9vulw6SXfK
         MrjqxhH6ilKqdlLNw0cdxixX9mho3pWRkpCdf6JYvTc/chntlMYkuRjCR+uAKYAwrWjV
         nbm5n4lCYsk09q+dnrQ2ozqazr5ZFyAUuUjrESPRG3D3vVJYkhLNjXUQU9l+ujfE93gq
         yuzvX8rv+wVYUfyjxhg52gs0gYByqjJbKo0zBCN1ok0HmPnbHbwXbj6ECJosjvVv9VW3
         y5sNoEdzssg9aY61VBDUHuSvOWKILV5Otz0a/fLJc/iwuTSUcxTLGFQG+M8M42sr1Ki5
         yVLg==
X-Forwarded-Encrypted: i=1; AKwUvBxX4nsbuYw256hBCtq7u0NPU77dyIitzNizzAh/NH4UPSvtVsSwcZeNWcf93aMso3bDxNOlWLaxsivXDyak@vger.kernel.org
X-Gm-Message-State: AFuF++l97mJ+mPN2mvrtz0G5UgrDiu2aWqnMlbEMmW6kXei0BGKxmgSZ
	KEMSqPmNOwwFbcr7loRu0y06WCUj4IAjOgL/zg416HoxB2yCCsD6HUsQ
X-Gm-Gg: AYBFou0jG8hd78/TzJ/s/FbSBIYL3x/gvhnqfqMv2XVTS48duv3MVXLyBLa98v8sZQG
	WkY/9esjbu5XOL4VAiNQGB5brClcr2fdS8RoLA8SC83zv5/pCFdKIA3ocIi3pY+iR8Qc+lfjSyY
	WWQyfmoMznGPVLngojpT6MVjlZY1uGDR5vqaykb5qfn5ewQTGDi+gs1CH0At6+Mue5r9FAxtAx2
	WrnD/s1oUyYxINCh4h8G1qr7nHlB2qManrVcu1zDdxlYGNeD7JfhDTSCjVTcTTRNLLFXd4uLQS4
	FW4x6kxPo0Y8tjBPmRE7Rdc7E6YWurMtd1IFFoMvV1xeGDw5K2t007MzRaIIha0Dpu49TtkI2Ul
	6wsSUUQjtsi6lsm4iYSgEiD+L2nELAfQhhbaBBUz/KbgXtu6YAadFFmULDxXDTHv9QPK2qCqXhg
	jgqbASrwlezijEkKZx2l1UBeobfvT1f6h1Oo0fO7SqLMr8AqscghUwp64X4rHyjQBHAxJCD7nsB
	gWko64Y5aDfJivCQeRFdhAWAiLrEYmZnRX1nnD7QuHwq6IAq/dzdmyn6MxHsMUErieRyL1klZED
	UxMhLDUNWdryEEKgDx6dLmr8tnIQHPnkWibnUnNLU5HFcZ6MS4a/QEHtf5c=
X-Received: by 2002:a17:90b:4b41:b0:39e:4c7f:7307 with SMTP id 98e67ed59e1d1-3a098b8ab32mr1639460a91.30.1790244700743;
        Thu, 24 Sep 2026 03:11:40 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec5dfsm4075446a91.3.2026.09.24.03.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:11:39 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Anders Larsen <al@alarsen.net>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/6] fs/qnx6: fix buffer head leaks, double free, and inode validation
Date: Thu, 24 Sep 2026 18:11:36 +0800
Message-ID: <20260924101136.2380154-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924073920.2782917-1-benquike@gmail.com>
References: <20260924073920.2782917-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hui,

Thanks for picking up my tags so quickly.  I tried to test v3 as well,
but it doesn't apply to mainline (40288c9206c1) or on top of v2, and
its context has code that isn't in fs/qnx6 in mainline or linux-next,
for example qnx6_inode->di_ptr in 1/6 and the out_sbl1/out_sbl2 labels
in 3/6.  My Tested-by and Reviewed-by were for v2 as posted [1], so
please drop them from v3 for now.

Which tree is v3 based on?  If you can point me at it, or rebase onto
mainline, I'm happy to review and test it again and send the tags for
the new version.

One small thing for the respin: the 1/6 commit message says
QNX6_PTR_MAX_LEVELS is 3, but include/linux/qnx6_fs.h defines it as 5.

Thanks,
Matthias

[1] https://lore.kernel.org/all/20260921042511.1473629-1-benquike@gmail.com/
