Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACDC3921E6;
	Wed, 15 Jul 2026 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784153269; cv=none; b=dqWd204rQpf91P0iTCVsJ6UrS50lea1VoqFIIuBDx+qrCblbLhbXXFiOwzBXLTRKMKuWor8ZLotinsc3Gw80tPGZdFKDbpSiqH5dejauTFhh9JFgx1HCVx6/gjNLM7ONw6M0MCsr1ynSJ/fJcM07s7bRjFH48d8411p3S3unwfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784153269; c=relaxed/simple;
	bh=QLGENVF/eZztDHEK4iKUim8VCkdPcKMl/dwC08OKrxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrYtWdPTHrRhMOC1HQ7sDXzgzdNIyYa8nA7ppbGISA3KfygVl7nt0yoBtjxcFMUWTL6GcBM+hxmCdH5d+JYD8j3+G2LBQht5Xr/gzkQGoxLyzCO9hB7SjBN89p65AXI6YovcnTXTh9XstzNOqTLeyLNflYy+xqs36sgqS0F1diI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=lQXqV2Pz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HLeNT+Co; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="lQXqV2Pz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HLeNT+Co"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id F2B571D000BC;
	Wed, 15 Jul 2026 18:07:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jul 2026 18:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784153266;
	 x=1784239666; bh=rfbd4CBlREu1XZrK+uIN64Z5ylUjpV3mMumvVJN2ijY=; b=
	lQXqV2Pz/U/NrhqEeZv/ZdJH45ZKZFC/63yYyoBZiYEJbyG9VH+NVL/c5LHY58Qs
	qjNri3FBVdppSrAXwUm0AWLX+ZdoVWUDJJKNS0RpoC1SpEdZEWFznwsx99MbFwlH
	euCWq9IjenKOuDYYzPAd5cAPlfZdFvOHfLZKVlNlu+V1+fRiuMNkDBMwtspjFwxS
	AfYnxqHmOWijqI4v2rgWXZbQ9Bp7DjSzC7CRGDtdpT7aMSxtypnFulrGbmuajjEP
	k3wBsdpfvVTbtAFcqASjjFso5wePBAWfbXWHYvSqYe2WUG9czt7lgDJFVGAv6uu3
	2Q4MRRA/aCkcsRWJkRg8Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784153266; x=
	1784239666; bh=rfbd4CBlREu1XZrK+uIN64Z5ylUjpV3mMumvVJN2ijY=; b=H
	LeNT+CoxV+RLjgGO99zQ34amsoGB5gZxsyKxBHs8vr1i2NL4wWIJ2fKvQy+eAwww
	NrzYNF9SNuZrjeNENRJcnyD4xunHUBsgK0mDxCdrZ06Tz5ssOEBRn9Nq71oZuw+C
	IWL183kOBeCX/eCV8gAcmA/A+pFShJbfYUR4iZCEe98xtUv2nn4lUzsj9lsO2U+1
	vgbrKz71zE+eZVn+62Yl3aYGekTyu9OjXCHtc+xNhebD3KEMk/JPFYLQzdG/1Z3k
	AS32Us/Q05RzEwXZqHtPXJqoZ5X5WNJiAnwfMpM+9FV5e+LUh1zvaTva7L1ZM8bt
	yXBJ3D7hMCviM6hy9/yxg==
X-ME-Sender: <xms:sgRYaqi3MgWi-TsDx3jKLLP9grFwo-mKptHz3XqR-3TaT1-EvBIAhw>
    <xme:sgRYalGCxhgT05gDLfMT1g4g0kCB6-yJcnn8YEIXoIE9VAGX5q7jft3Vg0OV61dFh
    Yd_OBkiEaJh9MJsV5s91BT4krRWSj3wa1EgaCTp8AcgVbBaM0qT>
X-ME-Received: <xmr:sgRYah-eILqdF72kJy3PQfcvdDchcjD90fhf_Xu8erzpEnOjeVm3h9oZpCIOKmdzUyhrBbpawzV2V_c5TXRro2k1KeI_ZZmTzH9uyGpeTyM26ei-Ab-2c0efTlTrRwY6pFrwE6eWVKMvUq0tOF4iUqp1Mg>
X-ME-Proxy-Cause: dmFkZTGLtYiKMwKMi7WNCTmQ48wGGLmlDn0qTiktf1rmbkgXjJPXUSSkLywUNzPeiGoWQa
    H4PhyF4lnbLj+7icllVuPlcZEmAAXVd17yFqE0RmN+q9/IgftL2JvdnWUrXN/qwFlLdf2p
    Ewr+xVVTcEdDAzJBvbwLnpzIFBtCRDipeXUqksEF0MLwHsjeLkgFotGxo5zy8l8HKwCAHo
    jijBoZaz+s/6iCoxSEBKkmuwAwjaJiqcq5H8yOzCFNgd+dGgxnD2O2BVgkdsk/n1sog0x8
    DBC2Wa1Kv1LzUI3WxtWHzbDxNcuwdDtsVuBRxuuTjWJBBSradnsI42rAcyMvNqkHPftVbl
    L6S5sulYc3U84fmN59dmrEpDQ31XZQdtEgWT6rQXx5W5xU3S55JxKNAYDBGtNzEkeb/6/u
    Di2XNfvEXBHcjxOKhksWKG3KYEcZ4180rxyUU+Fn/QT3S9+QfA7iD7TP501bV/ki72L72b
    Q0Ps4683q/2nLeOzlr01MtlLgVXii24LA6ypP4vFWeXB405bot/3KqE11FWw6c80wC15EK
    oe6pPbFk1R1Q3WtsiGrxFWM/SWcxuLFZBGTCpC+ioKSAmJpvu6M3Pebb3xaf768bzEnmuV
    mLFADLIgM5Oxy9kEP3QKHioPy/iEwwMLtZ7M0XogwQKKV6zlr9B7sZaqGPBQ
X-ME-Proxy: <xmx:sgRYakwo8MJXhCcmniYQvYI-jqID3cE_pvBH6mM9INCXim5KGfapXg>
    <xmx:sgRYalMuEmbizQKfaCYGxetbNseatZ66mtU08McrhIyt7dIa4Asm4Q>
    <xmx:sgRYah9pye5xnP_fwsk0gNDwVfd-JeXiG4QeS2CkU23vHoppMbi4Yg>
    <xmx:sgRYaq4qBpMyCwDfgyEnOtY8ELN5L20ZMvUpe_Q2Jz-uS3g3t56N2w>
    <xmx:sgRYasilsDucOrHrPIzZ3QtROQ6d55lcTomO2ud0NV5a0lUdTE18aWes>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 18:07:44 -0400 (EDT)
Message-ID: <1eda9765-67ed-44a3-8127-eba4254502b2@bsbernd.com>
Date: Thu, 16 Jul 2026 00:07:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: select alternative io_uring queue if local queue is
 full
To: Joanne Koong <joannelkoong@gmail.com>, Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jinxu Du <dujinxiu@kylinos.cn>
References: <20260714073230.4324-1-liwang@kylinos.cn>
 <CAJnrk1ZGVFJykTmtLr2jbxtvrJqq1P+-T3LgHsyrUQPj5wFxLQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <CAJnrk1ZGVFJykTmtLr2jbxtvrJqq1P+-T3LgHsyrUQPj5wFxLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/15/26 19:51, Joanne Koong wrote:
> On Tue, Jul 14, 2026 at 12:33 AM Li Wang <liwang@kylinos.cn> wrote:
>>
>> fuse_uring_task_to_queue() always maps requests to the queue for
>> task_cpu(current). A single-threaded submitter with high queue depth
>> could leave other per-CPU queues idle while one queue handles all
>> traffic.
>>
>> Prefer the local queue when it has available ring entries. If the local
>> queue is full, try other queues on the same NUMA node before falling
>> back to use the local queue.
> 
> Hi Li,
> 
> I think this is already covered by Bernd's changes in his reduced
> queues patchset [1].
> 
> Thanks,
> Joanne
> 
> [1] https://lore.kernel.org/fuse-devel/20260529-reduced-nr-ring-queues_3-v5-0-1dc08c2fccf6@bsbernd.com/

It is a slightly different approach, but both have the same goal
to get more balanced queue/core usage.

I will submit a new version once I'm back from vacation.


Thanks,
Bernd
