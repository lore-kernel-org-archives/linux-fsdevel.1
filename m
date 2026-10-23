Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798104;
	b=bJ8z29tcMSvczonD+Ggs4V6EOMdmw2EmsKrrmtWJuxqNkj4N021imbSiz37TEv+9qtXd
	 iYdj7i4DaMXImM5VQZmirxqcaqcaOVkn1TYsLvuIlL46IyNqEZ8tsUgo0+26gvu3NfFPl
	 4xWOVh/A+CtysA+19ral4+qOTM1e74osrWgvYpoB8GqDB2ATJMfqsrJdJ/oLDd0RUeozF
	 o6G8g6k9czEIAlmM/cqVsNpcNYr1CtiGpOlnxKZdUrFG8A60sr9lnOa13HHv3OzqoSB3p
	 WejARCPwVCJA619vYzp1er81n56qGzAVfaBn+reQTYCifUdBw2xhrpqZ8a19GHNCyHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AhPa34WjyM0Rk+T0nHyrrXNrKgrug39dI/CFZCoWjh0=;
	b=Rm/5/ZhIfh62kdPY4NnBEz4hK1b1H3UboVXtvReNHZQ2PetLhOuGoPZiNYYOJ3m32b+e
	 VzHAkP9HT2tYebHvNXabJh73yCfwqJMP98RJSCFz5RBaFh1sM/HT/1+V5Ew+OkZO0CFxK
	 aH0MJA9LglbDrOdPhb40BWqnJlUQnyx3OGNmxaWvyOvnoDXFTBTOaep4+1EXWx2G5aYZR
	 zf4wJq82/lE5nVQAq99UsJOYw8PTh6nVronn3ol9ktYAwYrAhdnIn//G8eXiveCQK/A7i
	 dTWII9FJblCaxKtXxyn+Qbp0Y47aGLpbs/pFfxi4rY6mtHc6WieRuAz3l2ncoL32Qdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=euaf7HDf;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928DB606A329
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 23:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 928DB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=euaf7HDf
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eac6c5f927so558475e0c.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 16:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792798102; x=1793402902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AhPa34WjyM0Rk+T0nHyrrXNrKgrug39dI/CFZCoWjh0=;
        b=euaf7HDfGOvMTtBYQz52bNcERTURIMXSM4+PjNFp86cK5pUaVQXlZR0zTCCky68xqh
         0uua6T2fBrdEDDr0TjfMj9RMcWbAut/UlY0jWEH14aWOy7PEnjDgqZfp89KoxnyWyTo4
         AiUxIx5WNSpaz88zLBTP5gBq9yYnaR/nNpTSKZ85WuSHTVG3n6A55Hs6l6HNze3ti7Rz
         QG57o5SfLcR2fuUI6+ru5Zby5MmtCi5dm/LhPfgdY3yE6oU9x+gjPi5YXua4gn5jamS0
         4Qh+RgM/iDhhwewSgrOYmRFvT52OmIl5JFjt7QlNqx89gVIU2b3mkUgeafM7e9Y5s7bs
         W1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792798102; x=1793402902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AhPa34WjyM0Rk+T0nHyrrXNrKgrug39dI/CFZCoWjh0=;
        b=hsUcQfk//naPGF+AUEyK0deSsz1r5AR9ko59TIJV9OserIkyPRW8iXVsYiBk3NKiR1
         ulmsiXnxashOIgA8qsAhRQrJ3OmBJuIEGkXOY2uZBX5jP+pqgjWpJkAR67S9EP3hgD3Y
         xIbqi+RCFJZBsX3I8ywz9eU0BXZiitRnYwOrPaJA7UHfLLPO1lj+olhHdp7I9EevQP+c
         zxoPttYrNP/cDmqckXcVH4deF3xp6WJMfldSc88c3fGJDK+KwaLExY578fMHmzO+sp30
         DOPjz5v4IsqnzW4omwzxO3UUd5tvSoPv5qfxQZ1ykwj+CgCml8DPuxy7anwDhDSU5Qm8
         og1w==
X-Gm-Message-State: AFq9FYLaB922spLiciVDJiBndOjVziwY0eaSYs5qjs36cT9Hcl4yE1Td
	Bh5xoho6G9aPUuyLZmJDF0/Lqq0Az6jUsBxwpjvAnk+9tUj1u9sSU143
X-Gm-Gg: AYBFou19p9fhQFTjyPaq3EbUQwJfU+Yhp0ZfzDNJ/MkPSJNLWwr41IBrOyS1wFel0f7
	rzMqobDG1LQFoDhtjukF8h28Do3PRKD0MSjtXvzG+D8H0hTZGAKGPJh9dzS6cVugq43z2nSoplv
	izmf9ZHEvmi+bozoQQkqFSLn/2JUMya2ZH30K6wGdGWlPaB779qBVwqU7J8jxfHMf/huVXrGCFa
	YQXpTTNzMdXDssCXfU7o2sbyOasL26UDfqSzUOPr3vMs2q0rCnMGyZjVoV+9NyCcWm/BUivd2cZ
	emvDrKFU4DxK+B2K6/64KPWhgLY8WsKn9pqaW4mG6INApuhVXEEhEi0OdKYYTQ2BDp6+RpC6rQN
	RIIqxqT0dpg2P8WEnTCclJWxoyDQJxXkfnsMaTN9ANnKI9SNAMwPnJItucVdnpHfTrnt4bd13O7
	jqMkIG5RQ34LtGZCQkRhns9h8ba0J8YtqQxJ1C664qASCd2x3E5EN9jsuzNvaUefwBzL8dSCTbu
	gDmlTw1OaRZwEA0NmyzCun9kblKWu2PWGoZgjz5T4+etEJ/zI3e1Sdsd3/MgRjx1x81lR6TFb0o
	sl9DhdhW5CFH93tiZS1KleI=
X-Received: by 2002:a05:6122:552:b0:5c9:c60a:e9b6 with SMTP id 71dfb90a1353d-5ec232dd5cbmr149854e0c.22.1792798102466;
        Fri, 23 Oct 2026 16:28:22 -0700 (PDT)
Received: from Biostar-A520MT ([187.94.15.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234a940bsm418764e0c.15.2026.10.23.16.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 16:28:21 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v2 0/1] MAINTAINERS: mark HPFS as orphaned
Date: Fri, 23 Oct 2026 20:28:06 -0300
Message-ID: <20261023232807.206097-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023151850.96475-0-breno3011alves@gmail.com>
References: <20261023151850.96475-0-breno3011alves@gmail.com>
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

This is v2 of the HPFS series.  Based on the feedback from Mikulas
Patocka on v1, the approach has changed substantially:

 - Instead of removing the HPFS driver, mark it as orphaned in
   MAINTAINERS and route patches to linux-fsdevel.  This respects
   Mikulas's use of the filesystem with OS/2 and the fact that
   MAINTAINERS still listed him as the maintainer.

 - Drop the stale maintainer entry (Mikulas has confirmed he is not
   actively maintaining the code) and the personal website URL.

 - Keep the driver in the tree.  A future removal can be proposed if
   no new maintainer or additional users step up.

 - The HPFS_SUPER_MAGIC value in include/uapi/linux/magic.h remains
   untouched, as does userspace ABI compatibility.

I'm sending this as v2 of the same series rather than as a new thread
so that the discussion stays together.  If reviewers prefer a fresh
thread, I'm happy to resend with a new subject.

Breno Rodrigues Alves (1):
  MAINTAINERS: mark HPFS as orphaned

 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.56.0

