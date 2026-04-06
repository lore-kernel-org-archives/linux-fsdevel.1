Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3487629ACC5;
	Mon,  6 Apr 2026 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506891; cv=none; b=g8RgFv2dH7FT33HPudbsDyM4YmEQaGKzIH4jUNt+HtSyAKM6heNfSbcXEwohwClDu8bhmzmSn50AUUYFTkNmWp2kweLqJyRvtriahbwib955GFc9T3d2/ZWBvLtH09VrEEvzIy0Yqcu4cRb4Vkg+HQEtGH0GDpWPT/I5gAXECa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506891; c=relaxed/simple;
	bh=dtKEyoAzC9iiRSidVO8hQ3bT5ZrvWLfIugiUEAWTpDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcLOr8GcE00BjG0LcS3ZjFSbsrXphGpuoaQ32F7yHNBGrTVQyKPV86C9BeCq67hJQepos2+AEqdL64U3N5FLd+/ZsN6Pbdk+XED6xtcD3b1pc0ZFaVWIdwqGbe47Y9/sl78sfX1s3Eyzyv0Bqj+s9P5scA30DBvWQ+teSMs+e6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=hxy+LPND; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="hxy+LPND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775506878; x=1776111678; i=deller@gmx.de;
	bh=9GrXkuXAcnpNrr9vMaMv0VhYTGK2TpTP93vM2lVh7GE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hxy+LPNDzoO2Zyplfucew3zRX3CQZ6o6nFv8o6u9AIOqj9lqBtbbrYPjmDlGdqAh
	 Qs7kh8CuPJn0a29nSmBm8eQMso9CDx+EC+giZUmuejaNV6YGpQdO7pCklr9XNXb33
	 zxFdqDEktvkfMsRoEnmH5lvURXZDriu3KJ+eLGMdxWyRTHjHpWs8GEJPGsjYobFY2
	 tWSMohEAnyBwfY/1Lq9KNtll+o9gkMjNqhYG15eoB20FrDcGX5ZagxneEeP2xkO+E
	 HFz13I5zIJN3ZLiwZAfY6KhTjuDgAwETVUFJUFznJDy7cuaTw81ESEcO19Y0qi87C
	 8Z8WVoMNEGKOzS9Exw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXtY-1w19Ha0wpU-00YGZx; Mon, 06
 Apr 2026 22:21:18 +0200
Message-ID: <cfd3b7e4-b791-41b3-9f9b-76082025a906@gmx.de>
Date: Mon, 6 Apr 2026 22:21:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] [PATCH] Fix warning at fs/dcache.c:430 dentry_free
To: Al Viro <viro@zeniv.linux.org.uk>, Helge Deller <deller@kernel.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
References: <adQO8B0rkR2ftusI@p100> <20260406200733.GZ3836593@ZenIV>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260406200733.GZ3836593@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a+Yi7mR/Cr4euFOCl5XdlPqj+HlxpdL7pF6xu/7IEuuBcx6UvbS
 +/JxMQNSjgfXeErRRssowRsdnAE3GF5vYGibXnwQA/q8xd6MkNxBCC5dL69HtcRksmA+ytd
 eldqnrIkB1jW3l0KJ51J8z0dzSIvVHV+ZYp+odo9765PenmanDVCssX5nkac3uMCcN2AdXl
 dRlH6TryABq/D+ByT34fQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Jxx0X5jydhg=;8jIMErPPX42aKeaZopOT4SfUKAs
 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
 GFqm6XIWM/5cfCHXwIjd

Hi Al,

On 4/6/26 22:07, Al Viro wrote:
> On Mon, Apr 06, 2026 at 09:52:16PM +0200, Helge Deller wrote:
>> The debian buildd servers for the parisc architecture crash reproduceab=
ly when
>> building the webkit2gtk debian package, shortly after having shown the =
warning
>> below.
>>
>> This patch keeps the lock of the dentry up until when the dentry is giv=
en back
>> to the cache and after having freed the "external dentry name".
>>
>> I'm not sure if this patch is really correct, but it seems to have fixe=
d the
>> problem, although more testing is needed.
>=20
> Hard NAK.  You are turning every place that grabs ->d_lock on a dentry s=
cheduled
> for freeing (like, say it, any RCU pathwalk trying to check if the end r=
esult can
> be grabbed) into a UAF.

Thanks for looking into the patch!
I assume UAF means User-after-free?
As I'm not an expert here, could you please point me to where
this use-after-free happens?
The kfree() is used on the external dentry name, and the lock is
unlocked before calling kmem_cache_free(), so I'd not expect that I
introduced an UAF here. But of course I could be wrong....
 =20
> Do you have a better localized reproducer?

Sadly not yet. I will try, but since the package is huge and the machines =
are
relatively slow it's not easy to track down.

Thanks!
Helge
