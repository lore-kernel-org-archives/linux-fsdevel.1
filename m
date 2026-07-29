Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF43B6BFD
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352742; cv=none; b=F5NW+ulh7yjNxS3e0NqxRyNnjskX/x5Pw4Zq3UfePv2vl176VjqhrRWhgsbhseYY6BeACW5JkPX5KzvIT6PGBZ1qeECA+bfIALPiWxLYkhsnAP02LBA2/P5cMRR8hi5LnRmgAbH0KkMzoCDHvySN5y6n7l/f/ssDm/F3YfKEsow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352742; c=relaxed/simple;
	bh=nAm+AaubmVJCxA/cyDcHaFkSO0RiDodDXMzyrjHbL/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYlVWka+e29qna9PTGPpo1kEupNaKKkcbSXyiZeyLT8TM3df5vFwwtCI9bsPTalogFe0c0dLW6TzVqzqHZMQFTkMv1u22ONM6ZazwyBhmIWAjf8M04kViBDpiNQ4MjEUUg8RUNtB6LzRBq7ndR5Arpjn0/C0H8smZqRm2mgFbR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=SIDqjUjC; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="SIDqjUjC"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb9b427da2so47666a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785352737; x=1785957537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jqt83cqxF1IU8PaFS5z1qjSliqQHp1IdJNxNs+7YlvU=;
        b=SIDqjUjCR49oTBtR0Hm4Bu90IXFvjYyBYSldzP+nGgLqWbvvD4B5Plp0xihHmDx3Pt
         dkl3XWyb3i0datBmkdd2f2lC2H2MJwfQWI8l/RbGMcYsNzdc5HR6pxKh4IW9A/BF/qjf
         0WTSuc+8QWM/k3aNAea0OW7z0q4CXn79L+sYpoeQAeA75vBxi4l3LU0cynMbKF7yEZ8o
         MFUtRXHSCcXY7PqfZNHWtNv2vKWBcfMlUVAb0rzh07Qh9hHgAnQ8xuAFC01D3e9EmPaz
         cXoQlJwezp5WuCiPiHK4E2gyFlTsbKJ1p4XKuzQInanmbW7Q9aDMBjQgb60yCrG3poZT
         Txnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352737; x=1785957537;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jqt83cqxF1IU8PaFS5z1qjSliqQHp1IdJNxNs+7YlvU=;
        b=e4hEghDtBjQMpgA6WCWQT9pENh0374eWbDKnv9oYMmKqRBMxDvSpYFSjq55j/BDrot
         mu3DI61Mh126atvppB3gHqRnLmDMlKqKIoTbH4Tpe2Gtw+O9ZbDcSJVZ6fOMDkqonnqW
         Ld8herGiTRrEZCf1N/zTXrjSI5BfvQkVknX3A8T57rISQ6ceanH6ffKW9qEJ77CwTHJ7
         Gjj5HK9VjaAael2jLY2yPkFzeqOerfogv6wkqa6mZKhBFEnyIW2Mpor9L3y5hdpjHyNI
         FBmjUZ1xPv9Bv+0wUSxQaaFqjlydn2rEWA6Vjd4g0rD+QXqyd0iImsCUj1i+DuuU3qOk
         xoyg==
X-Forwarded-Encrypted: i=1; AHgh+Rof2szYLa9N8rUBrxWwLkYzgyyBWrpmTSuH+VIp4KYHxjaPaS24ylY39aPTE798VxovaoKduBfBnX5ReJ3p@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1XYKq1UjX2RKw5GL51k/sJQZGBgn0eIuDMH7lCejalQMkI8ZQ
	MJbTfFLiXu3hbN08Lyjqjw5C0Zyqg/V7KQLIdzBmUGJo56n+HdNGv6kgglMThqfk+rM=
X-Gm-Gg: AR+sD11i8JO4Q24fB6/c0S2EzCw3xHxAf6IG3/OdxqFwNfeZI11/omyA227EETOl4Ox
	e/l69U7jlwKnZmtuVnmr4GTRr7uwV552qI0981k/x1KDc1uuPeSjnkyhZcSzdUIWdA/Wuf1x50/
	RUgHx+xsyanSkjYl7j3y2xC2owaIGGahqq0zDFFYfyDzSqezH74sTkjzAEtWH5BHKmsPKKS7GWs
	wNPWaFKBnLv2wihN+vQ+/8GOnfR/nRlplj5UAwMStRkYCYhcOaDmtoaT58WnQ4YKeeUQkhoCpFl
	z2P2K+liD5g3ybMipoOXLEAvKwZxtNzSb09IwoYDi5rJcWjFO+DjTZvLaKXRYgWMtsPBbMy2Aqb
	7GDapxTtTa95gPvkCNrzDOfzkildME2V3r2K0yMrmOBxI+ZU3HVHaDPNsP5wIZiDX+v2tuKaeg5
	PN95yLYHg7iWHshj44NNtnt0+f3aBQAtz5kEbehepvHEsGk+Zle5k9J6bt7JRrqswVIdLWVzIce
	KdPYwemz0050/4=
X-Received: by 2002:a05:6820:160c:b0:6a3:d8af:6b89 with SMTP id 006d021491bc7-6aca9962397mr1376206eaf.28.1785352736967;
        Wed, 29 Jul 2026 12:18:56 -0700 (PDT)
Received: from [172.19.0.220] ([99.196.129.79])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aca528b2b7sm2488573eaf.7.2026.07.29.12.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 12:18:56 -0700 (PDT)
Message-ID: <fbe9e74d-c389-46f4-9874-3e9ffd9c91d3@kernel.dk>
Date: Wed, 29 Jul 2026 13:18:40 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/5] block: validate direct I/O memory alignment
To: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@lists.linux.dev, hch@lst.de, brauner@kernel.org, djwong@kernel.org,
 viro@zeniv.linux.org.uk
References: <20260720201057.1862857-1-kbusch@meta.com>
 <ampRQyXDbGgeg49V@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ampRQyXDbGgeg49V@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 1:15 PM, Keith Busch wrote:
> On Mon, Jul 20, 2026 at 01:10:52PM -0700, Keith Busch wrote:
>> This addresses the misaligned direct-io problem behind various threads:
> 
> Hi Jens, have you had a chance to look at this one yet? This addresses
> previous issues with certain device mappers under direct io.

I they look fine, but at this point we should toss them into 7.3. Yes
I know there are regressions around this, but from 6.1x days. And the
series doesn't apply to the current block-7.2 anyway.

What do you think?

-- 
Jens Axboe

