Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926114;
	b=b20IudV213Rqj6ivjnU07Z5F4PluTOeCYt+VPlyBTF74RUACgxi38ZavkEZ/7PuUjyYe
	 JSRpFE7taoHabtbkEXpampD6cvEY5gAxLDM7GjW1RJ+60U6yIopOPnZFymUFhkRrODg/e
	 D+a8PmgLXJe98nl8z7zV5j3nwgi/k0sly6BAB2En25Xikc1SHBgFnfvgS1t/dHNC4Ood/
	 niNfR+kW+OxKSJTHjcemiHlmRORDknwEpv2rXaKJeIdjjkqknzz7qnyJgmWwSF+2ouFp2
	 nPkoKYUS0JYroymvntWBHeMDxDDJ4bKAjg6CxQGeZz84XfE62tIUhhgNO7Ms3IiyfrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926114;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CeU8u6kHty1en65kZgb//LJNkT2SLxzl4jsFSjT+bcg=;
	b=zRskVjUwAz6dhnsawFtc2b/WrOM8jpGazFsqnsdLctIaTj3v4HPFEIaGD7u0CRD/2Bq5
	 2jBPsXkiZl804rSmkXqH7EUNE2vhztNnM3Agdvl8sx+IBYUhMb3ayzVsFK3XhnWWI+xTS
	 rl+VrkudnF8axTGDTRY0/1YdSbLp+RvQnapdxZaOYFDAu17JXON3hkOXwvyRuLCXgNCPA
	 JHbGykpJBOp87ODlJgVsWn2M0arRrYPe16AZ2oA77d7ArmjUW1qXT5iDv4l4LvPmKjjcs
	 YA/ZzW4Zma8bXhDHxbjAYHDiAdEwyOrcCK9G49aiYHyDe2yHl1I5CubCIP2uHqITjLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bsbernd.com;
	spf=pass smtp.mailfrom=bsbernd.com;
	dkim=pass header.d=bsbernd.com header.i=@bsbernd.com header.a=rsa-sha256 header.s=fm2 header.b=n9WLMk00;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hsqDA1CG;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC5F606AF43
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 14:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFC5F606AF43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bsbernd.com header.i=@bsbernd.com header.a=rsa-sha256 header.s=fm2 header.b=n9WLMk00;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hsqDA1CG
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2FC917A0220
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 09:35:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 17 Nov 2026 09:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794926112;
	 x=1795012512; bh=CeU8u6kHty1en65kZgb//LJNkT2SLxzl4jsFSjT+bcg=; b=
	n9WLMk00+6g1ZPx80lj6+Vx1E1EqwvSXRtOyz/tOzVHxQzFF3DMe2uLuBHTueM6V
	ussqjX7obeEquu8mT9t99sUPGjQvYlzs0ydMwJtQT4GWR00/VjKXDxdL2hRRTDyA
	XBMHcJf16H2UeUla+dUMEII07uZ2EqUqIYXnxNlfZhwF7uSsP6JeXch6Hm69HdCw
	JkuWOx6EwgY8s6P/dUPXShuuF6TKncSoUm2vsoIz1bu3+NHwLhevAj0LbKSHl++X
	KLQznj+reBECrOqrlS+2S/g58ogGtAOJ37hwoiffmuA4lRO1QUi5n9UFsZR6JGhZ
	KVqtDieGhkpzM+iCQi8RtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794926112; x=
	1795012512; bh=CeU8u6kHty1en65kZgb//LJNkT2SLxzl4jsFSjT+bcg=; b=h
	sqDA1CGUxuFPEdx0RneK59nO+TGxzCW3/8afFQMpFbi6wje/YDXCpIEJ/L4Tyhd1
	45pMJpNRbeFXC8TFqwvv0DCpXhdLVYKo8bE/palW5iZze/eIQdSBbNlPSuKYNBMZ
	QiDNIlCScWkQuPo+z1JbPqczyu5ssAOXO4qMs8XMPf9TW7YDE40TOsVKWobtlk7+
	WxVY4JCfCZ8vOzYCGW089v/AQUbuiDZNrUbhSrAquxOgRJyf70+zgU6GKYxgitaF
	f1uesaSFGlSGY/tbSBv7I77tQ0HEa85bWvxr55SR0cdS5Cc1bpdbwttp4XccEoGG
	q/i+wIl+2LgC4yEcDmwoQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=bsbernd.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794926112; d=bsbernd.com;
	mf=PGJlcm5kQGJzYmVybmQuY29tPg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:M4uICaljRxA2kNF3JI6tYOP+Ab/r7Mmf113gZG2E3LxHOu7
	5pufIKrs3X/GoS6fQk4yWpiK18SXjFa/0Vt5sWsY1+iVUFKPURhNVUbB2Lb0EkBd
	37jjBt2DdUmHsdLW80mK0AgYmWMZeIXK51b17VqKL9tavCHAxFVcjwfeT4/8GRc8
	tTqTZ0QF+XL2D5EE5VCcrhiqKpZcYHuM/XnjUF5zXfR//kSNfeUJhrsY0cscY1Aw
	5B/ALr1KpCx9n7oMc4D+EcofVkEpQUDc8h9iMEvg2///MVQTCfkj40IogIXx9J8G
	VvHJlusknXouH32JX4qQiL9gcHL3fJiMEwgwkZw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:7hypwa3nbFfIJjATnk0iw1mWV17HEp+oyblRc7RalcA=:RxA4ZNiec2DNqPpkEm+eitwnO5pTWrVjiIVd+t/Fwqs=;
X-ME-Sender: <xms:IGb8atHPO9oCws_xDjkjHdFB_cv0_Pnm42MveANiPrl26DWTaKzdTg>
    <xme:IGb8aj1segCav2qv39IciVTvtL-wVe6e_Ia-I7NnJFp5bsyrCwFVAQexITqQmcfGB
    sE7JhSfZeYa4HPucWmvmWAFl-UOacaBpZdQ9Ykal5KngXnHKEw>
X-ME-Received: <xmr:IGb8avOgsBQ--9sIdw0sZH922ULIFX54YzOoHk62jGfkZTJrc-ULA83VandGUMMZ7LwoQhDrf8QoVHm8ya9-s8ftygAyl1BxhrtYDE_Ynm4A5EggfQ>
X-ME-Proxy-Cause: dmFkZTEj5qh6GJUq3G0N2GQxh+bRHHIBK5QbSD7sviIzjQMo14Qtydmn9YFJ3PQQ08UemD
    R6u2CitZfQ43CFu5iSv72IQYkcyH2ytd5ifElTDgA0xjX5udpxtfjX2zdrQi0fd7bMjLxr
    j8AyxDsHJSfaCjDSz9u9NrETAMTcGWCJpSgH3YQSwD5o8QMnEtHIvbAvj0gqVRKLA7iTSE
    zkYqzCVCyyNeOffcnGNlA12UUnpdDSgfAqElmAfkMhyITB/RgXSkccbXAD8u/4xUBLlFSF
    4k/MvDgdw9Rqc6WDOLibvOpylSwxfz8TV/NRcOutg85rPFb67AhiHlfGayy8uBOkzTLzuC
    wZbpnvShmmVHFXO4MHcGvJnAu+RBAqgJSLIgbXiKjzXQRhpoRXeJr0OBMNoSMgFwPX59rV
    nweTFUMLW0lV3mFaGpEZ38mAFDmHjGZZiEw+Rn1waX93MhIa1vzU8hHBzpAMQ2zDx7ukw/
    8gQUq/QX03pp5cZV56EebBFl6zg2ILAWFa8e/7DPTXYItD+ksY0W0lTd9L/hIr/Y0W+odv
    FopSf0R7bdCvF9x35VH0OGAyVXZO3kN6STejj8dD0xfjBVMdhRewD6/9tq9yNu8j7yRaa8
    fvq+EX8gbVZC0xuH9/KL3ayCz3yBVwYn+G+2igc1ql8AhPrP26nKkXVMYsnQ
X-ME-Proxy: <xmx:IGb8ai4zz51zAW4J2DI-731NVsjJNS5OzCMrb7aq5D3XF1YnmBVqYA>
    <xmx:IGb8ap1m1cEFNPeVmOZepj3okYo4wYA-ACTIPN844zWWGkoXWxP8EA>
    <xmx:IGb8ajwAO_j1kqLvAjWIRCR36ZveRbdKtFEL_RU4SUXClvADbUTz-w>
    <xmx:IGb8ajtcaDtKFJWOhNXBrNNZQHon_u1eElwRGl3Yj8YH8FXNGvAdTg>
    <xmx:IGb8akmWvdTcCp_xwRzloPC5olG0bMgEDBkp4N62UphhJC_J61Oyjd2K>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 09:35:11 -0500 (EST)
Message-ID: <21b9653a-ffd1-419c-b33d-bf7965bf82a2@bsbernd.com>
Date: Tue, 17 Nov 2026 15:35:09 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse: HANDLE_KILLPRIV_V2 does not kill suid/sgid on fallocate()
 and copy_file_range()
To: Miklos Szeredi <miklos@szeredi.hu>, Mitar <mmitar@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
References: <CAKLmikMhOYpGEw6uCqX_Bm0JPEg-4FhdJMNa9+tgtw3-Kf+eZg@mail.gmail.com>
 <e75cf549-07a6-4095-bbf8-8caff7a3338b@bsbernd.com>
 <CAKLmikN9Aod9Va=FsqkRmF20=69sdgdDOoV_bUuGh6wTykVcBQ@mail.gmail.com>
 <CAKLmikO5y916zgeX_UFqfGQ+BUmNC6uvHFR_bsizeTJu4AwxcQ@mail.gmail.com>
 <CAJfpegs9wm7JWBSqY6eFj+9JeaThE1RGtdxqo21_ytL1_okN_w@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <CAJfpegs9wm7JWBSqY6eFj+9JeaThE1RGtdxqo21_ytL1_okN_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/17/26 15:06, Miklos Szeredi wrote:
> On Sat, 7 Nov 2026 at 08:58, Mitar <mmitar@gmail.com> wrote:
> 
>> Not sure what the process is here, but how to get this patch further?
> 
> Posting it as a proper patch (e.g. git send-email)


I will do that later (Friday earliest), I just didn't come to it yet.


Thanks,
Bernd
