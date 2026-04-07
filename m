Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6A386C39;
	Tue,  7 Apr 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579106; cv=none; b=cuXsfjbU9i+oc2GVqYds+4zGY39CbRZNuPk4Cu2qGMxpvQMuCOX0VW/1lRWHlSNN664MeYwkPyljs3J8baTz05eCmFwFJaiQ5pMkCS3EH8+zQ30a78CQGcpqnnIN/CkM+HH2y9CUGwMo3HvfYMCjy+Nfg6QgfO7ISu0PR5Jfp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579106; c=relaxed/simple;
	bh=5yiclueQorkzNZxwE7GMZVWdW1LhmZ+XzswZlhzZvVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtGPyAGeIB40P5XcZspTRQQalMkal9DjKwC5Ywjd/gS2veMib9vsup2agrKL9Dybg/dZB0mt43xXU4CwMQQU1rzgtdO9AIUqhiLi0as2tLAwTxxEA9aSeenqB5sXJHJk9I0hDlIwfsHHvAMoF3qOVyvs9yyzNgfDHjI+ldztQQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=qWwMTIB1; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="qWwMTIB1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775579099; x=1776183899; i=deller@gmx.de;
	bh=EDTKaCSdO0fJHi7XKzZ9Vrk6p0AK43Yq7VPMk6LlF1I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qWwMTIB1h0tV4vRdXoYUy3XTwSZ+1VSM3mdIwklZrLpJVBq+dWq3iAKVqNsknu3A
	 +MOwauMCvDqCmg8qpP35wsJ5E8jumjzqqQKvPKnh7OtFkIRdxqfW9zCxEo2rmH9Xk
	 PFOFZUkt+VfY4J96IfvWtAzBAYNjNnvFB2jHK003SA4WAEDu2XIQQRdiBwpP+U483
	 iWmwjnT5zswVWRQ4k5wHoTGfSODneTH9Whk8vkZZlNA9fOm4iePzlJp0vLuEMzsEQ
	 AU5GlYI2Q8UvQSlsQKSwqDXQNLgR1BjMxkHY52/K0Z+jZhsYSnz9IN3EdjRYEk8RN
	 IMh3Ls2UbQCjHn/uLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ob6-1vNNnx0kwo-017h42; Tue, 07
 Apr 2026 18:24:59 +0200
Message-ID: <516c01e1-40e1-4bd0-9854-8e0969c3175d@gmx.de>
Date: Tue, 7 Apr 2026 18:24:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] [PATCH] Fix warning at fs/dcache.c:430 dentry_free
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Helge Deller <deller@kernel.org>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <adQO8B0rkR2ftusI@p100> <20260406200733.GZ3836593@ZenIV>
 <20260406202829.GA3836593@ZenIV>
 <0e4a8cef-2a64-4392-a5ba-f9f57de48f8c@gmx.de>
 <20260406211010.GC3836593@ZenIV>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260406211010.GC3836593@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xwSLoILqOCPQaIZlo3Eo3WlA/aXuHouNPYdXPl+iP8p3ETPMfJ6
 zyeg+uuvFp32FQH4OpW0lNrvVRv4aNPlDr2P6ytAVaWLT2i0+Vzt2RxkuUB1kGokj/cPgy9
 NpmNCCtwsYUE//VvhsdBYE5Uf5r4fLByizwby5FqbQuXBOWi0uFJbap3ukj2LRPLK4xTojp
 V2J6y9Kjw6xrnyCqMivdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UXwYP8vCkmI=;o+mg86sj3wC8HG/Igl6ACOh/Uqg
 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
 ijoumfS93Qa

On 4/6/26 23:10, Al Viro wrote:
> On Mon, Apr 06, 2026 at 10:43:57PM +0200, Helge Deller wrote:
>=20
>>> BTW, could you reproduce it on viro/vfs.git #work.dcache-busy-wait?  I=
t's possible
>>> that changes in there might accidentally fix that, and if they did it =
would narrow
>>> the things down a lot.
>>
>> Ok, will try.
>> Please note that building kernel/ installing / running dpkg build takes=
 hours & days,
>> so it may take quite some time until I come back here....
>=20
> Which kernel(s) had that been reproduced on, BTW?

This happened with all Debian kernels from (at least, maybe earlier) 6.16 =
up to 6.19.
 =20
> Incidentally, can that be reproduced on any of qemu-based setups?  And d=
o you need
> to build the kernel natively?  Debian kernels can be cross-built, after =
all...
I know, and I do in some cases.
Nevertheless, everthing takes often longer than expected... :-(

Helge
