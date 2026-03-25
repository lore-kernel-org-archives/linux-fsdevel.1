Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37041D5170
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774397791; cv=none; b=fO9Nx8u2GPQGm7rSgutcqUHfzatIOw+4Mcwvbk2tTayd+T2eOHhDpXPNN8WnB5bd5YHh504yrzT2aEu7RddDFh7OzX6Ghx52Q0px2laiySnc7J1dFuYlXaqQEGs7w6d6rHr7LZeKNyxmZ1an4+AL3H+Hcn3NsD6H2rzNYsUQGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774397791; c=relaxed/simple;
	bh=MoLrdbwuxoKO2kYMSDxtCJV83ayachj6VWNdw0sH+RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4V2PPSoK9pURlcBA5mGp8aZ9KcPKIMmOw3ZTE6gji5WWj6NFG/gD5LSQ6xOyUoA9OsLYpXZW/xeJ/4oAwuAmVsq3bORQlvboSuCKazk5dVdOgWS6klcvj7LKULsJpdHodRtFokoASGZ/vd2xWxBOAAQyhcidrIeBDNklENdl/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SYf+r95P; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SYf+r95P"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-67c641dfaceso1093000eaf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 17:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774397785; x=1775002585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUE46PPV8ZBQbSpBMaJf2P+/9B1olmom1CQ0qLARqFs=;
        b=SYf+r95PWmYPO1n7S4yEVApA92diDLGXIPneKoub13/8urv4UW65pHpy7F4JHtAEA+
         R3f6hdyMDSGmO4Tds0VFrI6pYtW1NpIleRv/oF2T8YQ1Jp6AqGbv/XCOrOSrNczV5suz
         9iE9z43zJrEnfAjpMIB7FaHArsxFNos4nItFpJpck7uyg2uxuK+9jdOrln9Suas8Xval
         tHEm5QRW2F2e3q50poeKOANZlSGPwVDmqSL68vwYQG2QhaZ/JMUle7UINTpSYr5n7s+g
         81OjuIAGSa/zmgMtPh0FDm+q6funlL2oOySjo0rg8pqUQNFLDkWQX67oymjyKZOpSoDF
         LFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774397785; x=1775002585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUE46PPV8ZBQbSpBMaJf2P+/9B1olmom1CQ0qLARqFs=;
        b=sHX26i3vpIsZRr9nhyatnL//iSi6iFYeTEYEHjU6qLnqtxCmA/DrP3Zp/GkOM4pICd
         /6h5Dnqr+UoQFyjUk+ga6mncAnu5JcYxecLmt74eSE8SHLLFXpmPahhCuU1OVa4JdFa1
         QLNzQForV47169Ku0c0p/QFSzb38KucpObiDIpIpuriMq9vsym1Lptpr966NmeXEne1J
         PtakXyGWxND9zmyTnqt4N3YNWlvelpi7g9X+7TtS58cfEYZLHdHU8/slyw0/50W5qxi0
         v0DBmjfINglYHsne5j03t6NAU4nwF+KKS0OP47gxKyqlNTZ/2yfe1kSN7Ka5v2fV86N3
         9KEw==
X-Forwarded-Encrypted: i=1; AJvYcCWezU5+pJ7mYM2AzwOSk89ZDUYr207aYxulNx8mHbE54wCeE6ies6WWWg3NNNDxeLoeSkI52BdT6f3PrY2x@vger.kernel.org
X-Gm-Message-State: AOJu0YzMaO4trf+Ys3wwQZ/Px2j03zjvep3hwRwdJTEaDFBnJ+IhtHsE
	BbdAYLsXSki+FXruk4GSUQNWdfjg8ZU0hT6oqZUTXf4yv8bquBEU/IUL8nIHiXnS0tWRvz7jLnt
	o65hFq+g=
X-Gm-Gg: ATEYQzxBN/ByCvRI4V4csvAJky502FXp0FYK10xwouX1uGtMQb5D6/S4X01842cVfwK
	Xes7y8O2SzrDFC2QHnqWmFmMUKLf/LSS6xozlW414CqBtTla8ozkQB/CJEVOaOeNshfkn02vr9X
	EDqyFxVGmG3cnS1mfvTqO0mRkBpXouv9ykXNNmRLlxLDYkJMZQdsMMvvr1YEPopEkQeZywDRNVH
	a7mbJvHBG2D3L74WKSQcVZG3uBZ4RMQ1ajVQkjq3kKKeFlmoFPr5/tvKiM/iDr0jjTrelQ8XioB
	OL4tvnJfQb2FZijbNgTTwN8F8AP1k0vAyZ3gafLsiDGpnGpSyVbPSuGLxnJeK2yzE2EAW0mEYjV
	74CZJKY9s8wey19NyFEzVDu3lNQHjCM9Za2PkOUxxdfsTE0xDMErFTK3LIAgExgLp2tunB16ETK
	36SEQIh+NxhAzf+CFF1U1Crr09JpXjw94MWrIMy+JX78ADHbZmWWrSdgIOMFWhITjGKizngOCW7
	MA0r8cd1w==
X-Received: by 2002:a05:6820:206:b0:67c:2bab:bf54 with SMTP id 006d021491bc7-67dff5f7978mr793373eaf.62.1774397785456;
        Tue, 24 Mar 2026 17:16:25 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c57bdf2b0sm9253351fac.7.2026.03.24.17.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 17:16:24 -0700 (PDT)
Message-ID: <1ec0b46f-a1b2-43f6-98ae-43bb87d0e59f@kernel.dk>
Date: Tue, 24 Mar 2026 18:16:23 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: fix lockdep complaint when reads fail
To: Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong"
 <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Zorro Lang <zlang@redhat.com>,
 linux-xfs@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
 linux-block@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20260319194303.efw4wcu7c4idhthz@doltdoltdolt>
 <20260320163444.GE6223@frogsfrogsfrogs> <acDbFtQw0mom798e@infradead.org>
 <20260323152231.GG6223@frogsfrogsfrogs>
 <20260323210017.GL6223@frogsfrogsfrogs> <acIrtFpASaBmFZPU@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <acIrtFpASaBmFZPU@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 12:14 AM, Christoph Hellwig wrote:
> Please reword the subject - your are not fixing a lockdep complain,
> but the underlying issue of calling code from the wrong context.
> Lockdeps as usual is just the messenger.
> 
>> Zorro's diagnosis makes sense, so the solution is to kick the failed
>> read handling to a workqueue much like we added for writeback ioends in
>> commit 294f54f849d846 ("fserror: fix lockdep complaint when igrabbing
>> inode").
> 
> The code looks ok, although I'd much prefer generalizing it.  I guess

I'll take a stab at it. This one is fine since it's an error handling
path, but previous tests I did with this kind of approach for every IO
hitting this path have been utterly terrible.

Once done though, we can swap stuff like this too.

IOW, for this one:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

