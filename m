Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB93921F0;
	Tue,  7 Jul 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450547; cv=none; b=g6dJPIesapbjTuWvdPvgrw7gCxipFKvVtXNBVyNPKQqRKzzEx4pzzQUpxxUFHVCRE8gkhDiw4XMxkdmVAn34WkuI4lwldAyIIiJq2zvIZ8GHKXBdlMxz3d32X6MutQbxOYYcbaShFz/65RiF1sekarEkVSnnHDhqnsSdECk9+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450547; c=relaxed/simple;
	bh=fiT1IVXNR/13qgRPKA2bpMQVZgLaTwPYM+29FlvpHRg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NXjhWjJFUySBbLXaPd0nel1vtWMohzF4TveMJfQVx3c/yVN0jHBlaDwQIyvB+B8OLkcUvGFPWP1BYcgcEJoha4+ZC6pScW034YgUMFM1qGlxNVm6VSHC5JWZhoeSllh6eq/O/o8Sr9iyo5MZmsVLdlswuJf6C1dHhE3/Ju9r4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ckadr1@gmx.net header.b=SQcP2fE3; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ckadr1@gmx.net header.b="SQcP2fE3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1783450536; x=1784055336; i=ckadr1@gmx.net;
	bh=fiT1IVXNR/13qgRPKA2bpMQVZgLaTwPYM+29FlvpHRg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SQcP2fE37ReYdio7jJ9GVIwd5Q/IATVlnOW8hVaV3M96ch3QNpmtWtTxkpPOF1lh
	 MdLN4biIrDqQj6P+bCHqGuWilMm5ULfRKISg27LA2Bx/yCbF3Vv39c7gxbH/O1ASM
	 g1ZrSI1FxSVTW09e5WsQZ3X2nNrVv8fS4FRlfFyhteR4YQ4r0kzGYrVftkkkaC9Bw
	 gUoE0kr+ZYQdhPPFSC3xJebgoBD8vwLat92/nny3XzCCnaEr+1kZ77VbdP1C2+r6g
	 pKO4T2xa9vaIeYSpkcXrCX/BKtouurfRm/upEj66RYk2t5dUIfttRvHJdd4wuRsgJ
	 bUr6YLPH0HXZp6mv7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1poA-1wey1o0z4S-00FD4j; Tue, 07
 Jul 2026 20:55:36 +0200
Message-ID: <5a789547-5c7c-488f-ad5f-3642c6c36d6b@gmx.net>
Date: Tue, 7 Jul 2026 20:55:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Content-Language: de-DE, en-US
From: ckadr1 <ckadr1@gmx.net>
To: brauner@kernel.org
Cc: axboe@kernel.dk, corbet@lwn.net, david@kernel.org, jlayton@kernel.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 vbabka@kernel.org, workflows@vger.kernel.org
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <20f91215-f0db-4bb5-9ada-f3df33d78534@gmx.net>
In-Reply-To: <20f91215-f0db-4bb5-9ada-f3df33d78534@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RSleTyeoVq8sR/Y3pW+PvETabraNJ6LEbbPdgAVxqANquTIDQpg
 cd/Q5g3vaHFlltsFAr7lNPr0YSw/+S4ADCT02L2u2ZMy07o+FVTETiTGnt6TUnsfHccF2DS
 yGNCNSfExwB00VH1F+oYP1Ws56kClwi7rDJFqu0GZXYDB1hCsJoO85mQpihgIUmj5DummWH
 zqOJY2JDVwE+wMBd2MGVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s2k42Rh/eYI=;hFPWKe5rjHtyPy9tKoxIIAaHf7r
 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


Hi,
I agree that providing an advertizing platform for LLM/LAM/MCP/A2A
providers should be avoided.
Detailed information could still be provided in announcements or the
mailing list if others might be interested.
There will be public discussions about who used/likes/prefers whatever
model/tool for whatever task anyway.

With the patch itself, maybe it might be important to know how AI
has been used/helped to create it. Copy+paste code from AI / getting
code from AI but verify,rework,adjust manually / getting the basic idea
or how to overcome issues, but coding done by humans / comments
provided by AI ...

This dicussion might be the easiest part imagining the future.
What if the patch/feature would actually make use of MCP/A2A - that's a=20
different story. Local guardrails need to be guaranteed, remote ones=20
requested from the endpoint, eventually dropped if not satisfied like in=
=20
a failed TLS handshake.

Just my 2c,
Christian
