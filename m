Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795759797;
	b=KGf9BBCIurL81i3y8VEypKcbF58pbUrLxbp7P1GmPDVvIAahS+WEiw13YL2ay8Up3bGT
	 w3PHsZeGsuNCm8WganHWZmsSfTBm7GcfYK+/8uhigmlmD49Kp1dax0hVtO9/fOO29pQbf
	 cE3BBGQhXIKwSbeKRigLUuG11qvI4xjOJxY2S6JMZ/s9WY99YrUgXToIuSmzX+U6+RkF1
	 ynStb3w4SdMPggm5Ubc+nfSmeT1TNeeKDMsXgTJFm+PIoWUlWkGqs50Z6mKE1087pXts1
	 YXTnxsB+U5VxgxioF5hunFtipJqycguyxRxwutLsobejR1kEJQhXuYKHpJmqt+SnRXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795759797;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=rylJ4EnxKNIcixfDOljd+e6hXXj/Ks5EE/NnudM1ajo=;
	b=FaHRS1KFn+Q5pXDY5xxTWTbI0n/Uzv2kzXDUX8BODDbIZTL3Db63DIlcWNgfDuhKAxJ8
	 /28nRNgsqwZDwa8Ge3unLIkaCVp1cvke4u2zdVbCBvFvf57N7NWcl/rSXbJjuNbKw4fmj
	 mfsbanyixxBBxeoyE7avSsR3ZNoVoKFb5cGpp33gnP1UwzPJYsUz5B4smjd5aSrXbGGIe
	 pgBCqD38HoqU5HyPvSvuZZyPZH23WoSOuB3kn/bJdLcVKWl3iMu2gKvFUQvYYxVHAr/V9
	 UzdLJPcLD5BIvm1tyLzQMzujwvPJdw0avtWwm+BmkYrEFAjjSz93/Dp8kwbxrnoaVOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m8FLExAR;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70752606A31C;
	Fri, 27 Nov 2026 06:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70752606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m8FLExAR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ry
	lJ4EnxKNIcixfDOljd+e6hXXj/Ks5EE/NnudM1ajo=; b=m8FLExARKIB4aPMSQC
	J8kBJZWZJFdvRxNIPKbUTBLMaQy7moE/YP6qql5TJFqbzYleirmF1bNBNTXkxAbJ
	cGgeRU5sAy54BR2byhEeLVSKp79mQ6vTdbnRgZIqXAanDRy8RkOxCJ+gPVX/h1lC
	tMS/f81cb6s4gOIVqdFBngUyU=
Received: from ubuntu (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3f91fHglrpiWBKA--.777S2;
	Fri, 27 Nov 2026 14:08:40 +0800 (CST)
From: Shaopei Zhu <shaopei_1012@163.com>
To: David Timber <dxdt@dev.snart.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	exfat@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7] exfat: add EXFAT_IOC_COMBINE to append a file's clusters to another
Date: Fri, 27 Nov 2026 14:08:29 +0800
Message-ID: <20261127060829.940607-1-shaopei_1012@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <059a0b05-2993-4e98-a640-c7c8364c7c69@dev.snart.me>
References: <20261124230746.850528-1-shaopei_1012@163.com> <CAKYAXd_ap120uprmarov-GuO0fb1eXEgw-U8G08L1xRJ9bv18A@mail.gmail.com> <20261126075247.850895-1-shaopei_1012@163.com> <dcd27d38-60a2-4c1a-81ff-4a82e99520ab@dev.snart.me> <20261126190704.935716-1-shaopei_1012@163.com> <059a0b05-2993-4e98-a640-c7c8364c7c69@dev.snart.me>
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
X-CM-TRANSID:_____wD3f91fHglrpiWBKA--.777S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU5zuWDUUUU
X-CM-SenderInfo: pvkd01phlbiiirs6il2tof0z/xtbC6gi+TWsJHmgYXAAA3B

Hi David,

You are right, and I am sorry.

I do take your time and your comments seriously.  My English is not
good, so I used a tool to turn my answers into English, and the result
was much too long.  The facts and the decisions in them are my own.

I am a developer and much of my work is on exfat, which is why I would
like to contribute some of my ideas to it.  Your comments, and those
of the other kernel developers, matter a lot to me.  I will think more
carefully about my replies, and I am sorry for the trouble.

Thanks for telling me directly.

Shaopei

