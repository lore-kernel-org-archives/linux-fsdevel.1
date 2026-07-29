Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BBC45C71F
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351234; cv=none; b=A9jBuJaHJKGz7JGy1xmesU4sABnhqIiuOzGIc0h9ThVd4M5TdA5zDt3oK5kVKvbNVn65/IWxRigOSHcGPKgzWN0SFb2mmGr+qjl3/Or1qOwt2klH5CrewQbYxzYYsClVP8bXSI8b26lgH2aLSu8C1W81CnSLgq5nMChX13Clebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351234; c=relaxed/simple;
	bh=fUPRuaiOlF8IjdKU/JUT8uTNv07joECWXpeuy6ZZkhA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Mime-Version:Date; b=ReKae2C6WJcftzCxlUvPZ3jNyYMh2aYd7NE2w2XV0ztp3g5ostfjOyUu1iuDJTsXDYC05/BzpjwvG7ARQDB8XzzluHf8sp1L3FQaLNwIfSCZZrQpaiwGue4ZZRQmB3F4jA+0UsI9jqpX4aJGKrJSB7Pl4Mld2cR+OeTeWyIuVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sysmikro.com.pl; spf=pass smtp.mailfrom=sysmikro.com.pl; dkim=fail (0-bit key) header.d=sysmikro.com.pl header.i=@sysmikro.com.pl header.b=anMhwvh0 reason="key not found in DNS"; arc=none smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sysmikro.com.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysmikro.com.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=sysmikro.com.pl header.i=@sysmikro.com.pl header.b="anMhwvh0"
X-Sender-Id: hostingeremail|x-authuser|kb@sysmikro.com.pl
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6A5B94C2F8C;
	Wed, 29 Jul 2026 18:35:46 +0000 (UTC)
Received: from fr-int-smtpout20.hostinger.io (trex-green-4.trex.outbound.svc.cluster.local [100.108.64.42])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id B1E924C3780;
	Wed, 29 Jul 2026 18:35:44 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|kb@sysmikro.com.pl
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|kb@sysmikro.com.pl
X-MailChannels-Auth-Id: hostingeremail
X-Plucky-Bubble: 70d08a9c2d5569e8_1785350146176_252235098
X-MC-Loop-Signature: 1785350146176:3119559993
X-MC-Ingress-Time: 1785350146175
Received: from fr-int-smtpout20.hostinger.io (fr-int-smtpout20.hostinger.io
 [148.222.54.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.64.42 (trex/8.0.2);
	Wed, 29 Jul 2026 18:35:46 +0000
Received: from linux-m4k8.home (195-128-180-188.cgnat.inetia.pl [195.128.180.188])
	(Authenticated sender: kb@sysmikro.com.pl)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4h9LcZ2ysWz1xxS;
	Wed, 29 Jul 2026 18:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sysmikro.com.pl;
	s=hostingermail-a; t=1785350143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzhWHRcxKDOJuQmmjs5g5+VbEx+08913ONeyG/j3orA=;
	b=anMhwvh0aK/QC5KvfiN+utxpjaiNBZiJV1s1fjo9voeZW2a2ACcluvX2Z1+9Iq/0DhL4WJ
	bYUbnQrKhOZl9FBg1mB5yti628mvraMVqFL2ujcSM1xda8se0GpsM7B3pmqenyGImWKEOU
	sPycRwncrBSWyr0KplRgrp5XvtirS+SpXuHGlOkWBbWo8+tNJ284RSoiU1bAA2aQWWty7n
	8Zzt0Fh7akEmfkZwwzuga9rpfy5jtU111Cz9Vz37tkt1DTO05H/ryRr5+04f74WB6EmRIQ
	K9F1qD1rFn5gPo8czezuta+4+Tf25rQ4ib3t4RBcEUbWMlqBtbQKKjcmG+hZsg==
Message-ID: <1785349669.5841.303.camel@sysmikro.com.pl>
Subject: Re: RFC: remove the freevxfs driver
From: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@sysmikro.com.pl>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
In-Reply-To: <20260729113643.2255419-1-hch@lst.de>
References: <20260729113643.2255419-1-hch@lst.de>
Organization: Systemy mikroprocesorowe
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Wed, 29 Jul 2026 18:35:42 +0000 (UTC)
X-CM-Envelope: MS4xfIIIDaSr/7hMr1Vry1T8EtmgdijbxjfBQQWOTQt+4zDeUtbf/O//ST6PZFKwP3FIQv2T/f6LDUsKFtDmEFLlON1rIINtSU0ml6xD+HkNKKDclpw09gby IsZJtxQJp+oHTJuZqZBfTuDFHMhNRxhVc+VCbjE4YDfj0ClNTpBziqqpY8X1abUlDuOgTwEiAUs8epS9Ua5PxLKKzamATJovuVVLeZbzKggZ7OzutjldghlX 6J0KG4FWx3vmdnm0SBPv+A==
X-CM-Analysis: v=2.4 cv=GMJaEfNK c=1 sm=1 tr=0 ts=6a6a47ff a=PYkihBpiioeuc7cBO5OYvw==:117 a=PYkihBpiioeuc7cBO5OYvw==:17 a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=PVJjOhMCFCpgX5v7pf0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-AuthUser: kb@sysmikro.com.pl

let it be removed.

On Wed, 2026-07-29 at 13:36 +0200, Christoph Hellwig wrote:
> Hi all,
> 
> I've recently been getting a lot of AI fixes for "security" bugs on
> untrusted freevxfs file systems.  This driver had one known user in
> the last 15 or so years, and I can't really spend the time on
> dealing with all these automated report.
> 
> So I think the time has come and we should probably deleted it.
> Unless Krzysztof as the only recent user and contributor wants to
> take over, in which case I'd be happy to hand over the
> maintainership.
-- 
Krzysztof Blaszkowski
