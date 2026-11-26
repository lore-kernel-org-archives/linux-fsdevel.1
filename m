Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672870;
	b=Dy3yvnglT8XP8DtYT0S4jdy4Fi4f8s+q+xbjhsdX4YGkKCVbUqO9oRzvBcO2v+FwRP8D
	 M+/mue8nBeDOfG3oneMqHpf2CvkUw2LX6EXkJQtdSL14da80O6EqLPv0x9naTRtFBZr7I
	 Z6ioosPI1qfLjIu/SM5Py/Ne8sDJ523EYNUvu/+9ySmjJDSbfWVlf6tMhNlqV4ablCjUG
	 drNd09qLhiSH6u+Ah7c+IPSR5lG/Stk4cKYLnbS/UC24pFTGjrpFSxTj4BwDBirGEi5Aq
	 JKVf1k1N9+3Eqzi9vPQ6/WRAj3t7M9u8blEF106K6cm6vSCK8cyMO/YxBh1tyeu/snA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=Adjp5RP4U0lbT5v6eOF7Mh/DtCyQZE5cE/uugkCDfqw=;
	b=fqXYXJh++w37bRevbPQHKtiS1LNtLktOVm9jhvrIVan3dDx/ATdCqrnHveNVvEiha4HS
	 clk5T5E84gWmlArxVlhTozsRTE2uri/G6pYcAUJzzNsGnItectYPBeodQUWsXZw8DbNLT
	 FRCducZqgfDl22VzqzSOOEGLl+e3f/wnjehyXAjTj1rl/sN7Gsc8opNY6qHspv54zuNA0
	 sjtEXewfLp7zSXMJpK5rZxw9hHU/iBgfRe7hJ4Sqbbv+lNNgAfEVkFTdsPmOYvVMuNSXo
	 U1afew0MGwzTNekzxI9JxnXcW0CpP3BelFClf7u9LfEl6+ctUeW2ZakX+xRTg90iY6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JXE05y2A;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0E9606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 06:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E0E9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JXE05y2A
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f04fab527eso51152115ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 22:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795672870; x=1796277670; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Adjp5RP4U0lbT5v6eOF7Mh/DtCyQZE5cE/uugkCDfqw=;
        b=JXE05y2A22ceOlqJrz09kRtSlGnLeaiWQ3Ld44fRaHDZ8r1SyXki+OaBduDCzI6r5g
         LzwQo2Vw4ObgsAALNahfqcRjkxPNpUIG1rsjn04q/uy1OvtJ6Sw3ytBNEQNyp8uzg6lb
         lhEBiFqhvwWZwqbJxX486H6yvryFchtp9unS7MvQCC+OweZrwWgpDHRowYhpLEF5Fgn8
         RnIPV0Ypf4eD+MoPwJzuVuvsDVOE14S0f2QukiMX3BhpafM3HRtiSkDqJb+JYfd8MBzC
         6dcOWOCeN1TctXZe2EwAu62nTpAdfoKyyiE6omAdC9T8FktjxH625yOtS+5cySdEi29o
         3GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795672870; x=1796277670;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Adjp5RP4U0lbT5v6eOF7Mh/DtCyQZE5cE/uugkCDfqw=;
        b=nw/9mlUntZoCfiEHQ3i2E4cDWoziqGtumoYqGZRfoPHUlMMWR8r9OkYdJqsqUQNSBh
         RAlrtE42sumOtDMCqy/UZ6xK9ZOrg7EfnPtpYyASdNrE4GGj76w/hRSgEIgo/SCFvBfh
         IMkc4tlk+/ExTtnqCaoIii1IdG6bBUFc/cHc/MPGolZhk5w3MI9QlY3i+69u9hvxfCXK
         DfoyUMzM+Q754Gw0qL/yfm5k6rqw2+fuctraoHAZj3cApxdBiiXXrsyzBqNGUtNqOzag
         P8+fpbWA3OsHC1yd2r+PhH59uJIBJCsmIEOmWxsxeR9hhWzCe6Pb2Y37xMfAniWGfqhQ
         xcfQ==
X-Forwarded-Encrypted: i=1; AL+hErHd8VoNlIy3IXtA61vuFobQS8Gmonw1jn9Y+HNA378CzE8pdMHPG9sTtEuRNXsVMCa1rBd6koVtALdByO2o@vger.kernel.org
X-Gm-Message-State: APuU4Z/raSvXJBqyzZTaSa++Teox21bLk7V6vkCQQfozxh4nIDvunE+U
	ZcVeElv7LP3PVNUsgwHtWnsi4HeXBw2emGhoYW6hDpt0erQIvG0IvSMm
X-Gm-Gg: AZFdTZcDmY6V/3s/0+M3kd0UKtSRyDLCgIUhLlHcCZxjP/l7p9CBuTxUFk+8q4JFPBJ
	g3CnOq64jyF+SCRdWX8JX+gh3f4Tsk5PL48RFvphjAaOsSfgSp6nL9RLmLOpcEtj9hPiapUGey6
	zMtl/3xdSynNiUWObFxgoBMBs/mDBQIeOgYsbPEse6OhzjFw/Wq+DwSK5qjm10fp0Q3ueaWg9DD
	keOdrZ2AH6HHw8pVG7HJqzj6a2RJ1Htn8nHtlWGsE5pvnm+0tK+NIug/jTpKX3oPvwV07xOnSgK
	KZdMnDavNauuF8XPP+o7yDw0BXEWC1pHDgh+3X+yiLwSJGoQY5WcME96cNni9WzWsXYIXpXLkw3
	RBWggWP/D/wIj8r7X5Y++q/HmOxxCOvJoz5GuVG+mNt/tEb2vz+OuDsJf49ifnUGh6GwYGF6wr0
	GKPhZuvpEqdsc28fRxiiA/xeDHBoKRediOUHvBjrN4MJqL6SNyYRbfALYyFroYivB4pthKo5Stw
	vDyqCLTum3NOhX4DZBjYYt51JcofCYgmsOZ/xWQ6+CeNCKjb7Pl0xXGvRIN04N8AHXtW88=
X-Received: by 2002:a17:90b:278c:b0:3b1:bdc8:c32b with SMTP id 98e67ed59e1d1-3b41c97ac78mr20450613a91.53.1795672869686;
        Wed, 25 Nov 2026 22:01:09 -0800 (PST)
Received: from [172.21.0.2] (vldb.skku.ac.kr. [115.145.173.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a33fsm31531327a91.6.2026.11.25.22.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:01:09 -0800 (PST)
Date: Wed, 25 Nov 2026 22:01:09 -0800 (PST)
From: Kyuwon Cho <kyuwoncho18@gmail.com>
To: Ding Feng <dingf3ng@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Ian Kent <raven@themaw.net>, Jeff Layton <jlayton@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] statmount: retry an overflowed seq buffer before any
 other check
In-Reply-To: <20261125-statmount-retry-v2-1-dingf3ng@gmail.com>
References: <20261125-statmount-retry-v2-1-dingf3ng@gmail.com>
Message-ID: <179567282158.141640.1989619625784759549@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Ding,

On Thu, Nov 26, 2026 at 01:13:48AM +0800, Ding Feng wrote:
> Check for the overflow before both, so the string is regenerated in a
> larger seq buffer.

On v7.4-rc3 (x86_64, QEMU), our reproducer, a tmpfs mounted on a
12278-byte path, gets STATMOUNT_SB_SOURCE back with this patch. Without
the patch, statmount() returns 0 and leaves it out of the mask.

Tested-by: Kyuwon Cho <kyuwoncho18@gmail.com>

Thanks,
Kyuwon
