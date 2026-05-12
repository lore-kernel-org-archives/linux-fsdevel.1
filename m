Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C213A8737
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616300; cv=none; b=MB672BSb6h3WA3ZwxdTz8sp9CxYlGzpIQVLIQfm9DBmEezJ+6fJUO6rIiJui5eL/kWCAMqmfFCh6Le9Wqqd9O1Ad2X0mMbjzbmmiT7K2+QJuvryPCFhupZrMz22cfjh+EwA+z49z6eiqEvLdeJw6/IjCqF1zZkHtxL7IEzK4is8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616300; c=relaxed/simple;
	bh=U149B7jOZDbYNaIBagtJTBhvtJfw5mB1hC2QAke5b+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZxT37MHrgOS51NtEJYPYPWzdogAnzK2lc01gKFyShPVk/HyS+xLB5k7ZcBDSekAXtGuMJIcazP9o3XvQMrGbXT3vbifZOSEIH/vdJPvtQ5lpx+HjYibZ7lsyMGoUUsEC/Eb3QIdULnYyJDdPmgwXXtNKWd2GuKMKIyEwzbBYFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=a13TEH6o; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="a13TEH6o"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dcc9b506d9so4883418a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778616297; x=1779221097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytaRvGyzRvrwPfExsZqDRmrBerTbe0eDzEQ+zX7gEI0=;
        b=a13TEH6o0QX8YWFboTTIBE7Au4HbM8Pf/JRakFnaXLJRXlcgF0YOZEK2I7wrajtl0k
         mREGo9aI1zCrKTI335CwbOz1xkBzQ6jxQEZFJPbrxEAGea7yd+mcl1YBgqeBGsV79UbJ
         /rpUpM1mS5V0eNS7yJJ0Xgtsnp5xEyvDka7gk4WhHs9T/sOkvH/GRJSHLKs1PhJehuXJ
         eMMA5KEzE0+d0q20xcibLAtJ+k6vl28UeF/H1xuwHZchzzcC5wP/KdJvYPSpzL/7c7XW
         3STgY/2QmYeLSzn4yj5q9OEBR3YcArGrUCyLSTbFX3zru2v4GGgmH3zm4wjGbM6bAmlW
         5ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616297; x=1779221097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytaRvGyzRvrwPfExsZqDRmrBerTbe0eDzEQ+zX7gEI0=;
        b=tOym6dYed1268nk9sREzO/7zIkgfutFxwd/Nv1lipZEuoAeQT742ICMbo0jsroiu+w
         JxnHMpHKQjq5XVRm312PDPK7fb5POzQ0pBUuG00VXv/mRgOHTceJxMq1Iujm9bjUERnB
         9QZCGTLBb5TPHxEHgEI/KBGCNOd3GJPSzwOLlzNECgCM3qDgziNE62h2f+nQ2yJ9AdFr
         eIkBvBg6gLv+f+WAQBprNKEu5uLxLiSTHrx5z2x80saLIQ2Z/DF50VFnXKF1WTke3ucr
         fuwDLpi7PrHQV0FVrCJr1m/dg+G4c0z0O5sOTtuJrmwwQsPXZcRIoEm+70Y9FPWw/Fm5
         PxQA==
X-Forwarded-Encrypted: i=1; AFNElJ+RZrwjThY8kpsXqMcwrUCXRtwo+6V2lD56X+PK0vRZmRuqn4CKBZvOz/GSsL+plctK+2iRvPWK/0cPJ6iw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9aggWkJxVefV8oomsWz5wIC0sUAVhTWM+JvnJXe5AJBelG5MK
	kvHiP/f1Mc7iocg6jFE5efLzexsw4hjny5cvKuM4KnC4d/TYa6uQ672KdTK79SP28YIru+w+Paf
	tOz2z
X-Gm-Gg: Acq92OHvXNqUIr1+9jxgO3dmrFNONoNr+bPO56i8QbB1Qqmz/oGYxzx6jFOiBMmS3BJ
	w6zpiwfX/zsg06M4q/J3BftpUVCOSyNhwP3iRwKwsUfUjnOHoBxPTArU8aVVpBiQALWFJZ4uI3l
	1mPdM9KmNYZ8c0Xy5S/NiW4yCasP9Ypm4k7JDUfU/YWsY1UO0vv4ctm7uvb+zH6mqRb58NnS8Gr
	bztqjuilUu3QRPS44eN7mf9VKBQtwSTCthJIHdpaMeaoRN8goxvLIC+eWLnAW+kIEvMMvFamJlQ
	4oCGIxok7WhvB7m4aWOAFRYnMM0rfrE/fwoO8IS6IAK9LDO5N/KNXeik/jcq6jWV8eSpVmTqQYL
	LtSBIypWCR71soPTfS/k3fhgXLQJhRDBWvibd43zLAL+uOkgjB8EG30SyG+vCWAyRAOXIdo+bQn
	OQvJ3Jvk8V6p4Q2iEJO+WxtCU06isCnHO2HuvMu1MjASRPik0IoDFLrAajy47DX9ciQyGAGHJYf
	XLbwRIiFQ==
X-Received: by 2002:a05:6820:1527:b0:696:72c4:5db1 with SMTP id 006d021491bc7-69b78d002e3mr201665eaf.14.1778616297483;
        Tue, 12 May 2026 13:04:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736f517sm13670314fac.12.2026.05.12.13.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:04:57 -0700 (PDT)
Message-ID: <ab0c9639-e636-4603-9e86-2db2d139c472@kernel.dk>
Date: Tue, 12 May 2026 14:04:55 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 0/5] io_uring related epoll cleanups
To: Christian Brauner <brauner@kernel.org>
Cc: io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260503085101.112698-1-axboe@kernel.dk>
 <177861542127.846060.15247420422293788438.b4-review@b4>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <177861542127.846060.15247420422293788438.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 1:50 PM, Christian Brauner wrote:
> On Sun, 03 May 2026 02:49:11 -0600, Jens Axboe <axboe@kernel.dk> wrote:
>> Hi,
>>
>> One of the nastier things about epoll is how it allows nesting contexts
>> inside each other, leading to the necessity of loop detection and the
>> issues that have come with that.
>>
>> I don't believe there's any reason to support nesting on the io_uring
>> side, in fact IORING_OP_EPOLL_CTL is a historical mistake, imho. But
>> let's at least try and contain the damage and disallow nested contexts
>> from our side.
> 
> I can stuff the epoll preliminaries onto
> 
> vfs-7.2.eventpoll
> 
> which is where the refactor I did lives and you can just pull it.

Sounds good to me - I'll send out a v2 with the rename of the
struct, then we can proceed from there.

-- 
Jens Axboe

