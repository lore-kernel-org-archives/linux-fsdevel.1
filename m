Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795192473;
	b=uk+2p5zLf6eQNhM9pamUhOk6wXIl/mTjWS+bWWeWVsPPp2oxr7/cbnHMtBL2UYfDMVIk
	 Px4chVBiO3ZPFB+RH8U6o8NGXQ5nCMgE1sYjCHupOa7tS38KIRZfb/qAOwWAKK0DgnBly
	 v/ptNL1/68bGVcOiUq45uVWkL6UZ6RVT4ewRwEtsAUjzQx0quiRVd4DmOve/eY7tk9WeP
	 W70PVrV3Jk68YBv6qAy1MJT0U9GxU+0PEot0IKQ7m5kotXsW8dmPDMwutWbxWbMufFdd2
	 RWGVjkfk/3QRxBFZenFOHdqs0hqLi6wrecWo3mS5iSKN2svFrgiFDuYgamSuHHhGQjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=c1Rcr1MG9hY9GluuOfSjwXRdDdQ4SancKFKcdqDjkVg=;
	b=FASmeXXZJHz40KA5BVapJNa9wUnc5CORcZAxssTMjDSwkjdKbcmWZXgQLDaMPOwg/tcb
	 /nFscmsX38S6raFFNCSwqLZ1dojCJjp7KS7hxt9u0SE5KKzopeTEyoZW1WZIB1vhZj2e/
	 GJE8CX4uXeTI/O0M30sHH6vpYaJBBQ99CaCr/VdsSzz/HDy2q94KOaUYdPCTi3H0kfEat
	 FwRXJ679xYFZUiH8lwHlri1idxxUlRbKu0zn65HDZmoWepWLWBUQ3WoliVonWQOikPwfC
	 AdJTfhu5Pnt4MFqWbljPJyeguLcj8bGXqhmDtqR1XRE1v9lPVcxS9autU7U1WP+QTww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ncy1yMiT;
	arc=none smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05CD606A336
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 16:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A05CD606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ncy1yMiT
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-53dda625f63so633205b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 08:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795192470; x=1795797270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c1Rcr1MG9hY9GluuOfSjwXRdDdQ4SancKFKcdqDjkVg=;
        b=ncy1yMiTu4EtP79tQOZos0QLbejJNFuqyBgDR9X3iyW+hfAww4Ad3m0/1iceuQ78Ut
         VRW2j6b9nDSOQvQs/+uq2R+UrcOlaH9d1t2I850rVpi9SzQ4JRf1ptc+gYAbNv6Hs/J6
         usT0lZbX6dWWFsTS2+wOAPug/LppyTiL7RKlF4lleCju/VPCFBWF/p7U0KXSuuSiCTh7
         bP2gw5aDHGEgcRKdMkXihybWs1CFKqvdsmqa0GSbMz0o0PqfYpvSyVbp0l71QTWt29+H
         Z+i4uhhz3vCDYj6+Gb2wqR3CTvSbGMb3+URG0ThzQYaytxUVeZuFNkIzVfT0r55eBaKb
         lE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795192470; x=1795797270;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c1Rcr1MG9hY9GluuOfSjwXRdDdQ4SancKFKcdqDjkVg=;
        b=NnS7OfT6MePT9PS6OkyQZq/z8IFmjHx58ddXvs1j4yBO0dTAZYWBXBiDriDEsJi+Mq
         Iump085xBv1Tdr5qEtne1WgOHWVIy1c+jALr++R00CNcQhVVNplHPEE3CFRx8lLP2giQ
         xfM0SnHWRv17xD/J+lqI9CSFfJouP75tIk3uGlH9/cvwfWA+qfnDjA+lYeYOiYIsXzPB
         QtJuRq8lZoKiXmgvwjIq6RPbgT2LP5Hq+8VEiCZd0jNYM6pX+4M218ACSvyJGYRrixxu
         5vCU79/AH7uRASsV1CtQ+0Rcb+rJxcRfasSbEx0qelTA/xxwRGFre3TLgsAR3YDmzWVS
         KOpw==
X-Forwarded-Encrypted: i=1; AL+hErF1UhFIFAXP94/AzFsTQXGjnWw0iOOzgNqJNPwIB2euTuhbE8ev5o0qPNxxgts6c8TUPyaGwZDSd9XfVBAU@vger.kernel.org
X-Gm-Message-State: APuU4Z8coeUgn8MhQnN4nxQtpmNYd9VYP5hCRIg7+pHx0uuHw/eIiBM3
	Mffd6Kmskvc28n+cAu/KD4BhzFPQgxsYfd9VZoZlf4QbdvKcJqlmQCE/QGFeZ6eA1QM=
X-Gm-Gg: AYBFou2xSfklClDo9vMBGWVSCHjqI9k7dszZn1vv022ZvQavBJJqGtLMCxZR9utflqX
	3WRjlEQhTOESRczcYEkiO3xXHioCp4lndq2Pxfw1PJN7/ZnKLFyPEMna78aJSdvcu0tHlc9NZBR
	D7P2/bsmCEttwuCW5OKE0G6/JyCA9hYaZLrnoNt76fU3cYW/sPKd9/WhDXVXkIcxW7tR6T2mzHO
	NFHpEdfASCnIS7wQh6lGhoNBUdpH1VJUr7o0Xs17ycFMwtBKJMRH51AVbkIvX9LTJQDzuDaTAXQ
	+jrkXsV49fn3wQSVY9v80PY0IX6elrb67yczNQRnGSEXedjVMjQxsMP+CUjDA/HwFFB+sZ/n2a/
	PFl+Zzx7EuOj65mg8ubp/UKEmJEW9CDDUVoC9H+k3GlRLCdECIqmHp/v40sLxoXA5lMcu8kfJNP
	kyGagVkoueohx9v7g0IRiFGuNHwLXp7/z8K94RGIIj5yYZtpXTj/WCbLinAjicfrmMJLi2rW6FK
	9QPzIhSTNdRj8nU8Bbnug57+QgZRGw8d1fGLvklGwDvL0CQmoWvd5kfGKDol9noAW4ejrN2+nBL
	kIh8ujz5tcqp5rK19fAXl1CBLUDN57F+b+tfEWnH/i+07aIMGuY1umMsZi4e8M4KTsiU0r5IXjn
	JBAD33VkeG0QZ4jH22mRTAmsNvL9ZQMnOEPulIlR8Cm0X6Wg=
X-Received: by 2002:a05:6808:244e:b0:574:6f37:671d with SMTP id 5614622812f47-57a056c81c5mr4578880b6e.5.1795192470491;
        Fri, 20 Nov 2026 08:34:30 -0800 (PST)
Received: from [192.168.0.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35e5ab03sm2517054b6e.16.2026.11.20.08.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 08:34:29 -0800 (PST)
Message-ID: <0460f99b-ab87-46f3-ba58-2daba2e821db@kernel.dk>
Date: Fri, 20 Nov 2026 09:34:28 -0700
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
Subject: Re: [RFC PATCH v3 0/2] io_uring: add IORING_OP_UTIMENSAT
To: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?M=C3=A9ven_Car?=
 <meven29@gmail.com>
Cc: io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 =?UTF-8?Q?M=C3=A9ven_Car?= <meven@kde.org>
References: <20261114104621.1186744-1-meven29@gmail.com>
 <20261120-vorfeld-formlos-nahbereich-00aebc4c5150@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261120-vorfeld-formlos-nahbereich-00aebc4c5150@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/26 3:33 AM, Christian Brauner wrote:
> On Sat, Nov 14, 2026 at 11:46:19AM +0100, M?ven Car wrote:
>> IORING_OP_FCHMOD was proposed in 2024 [1] and not merged. The same
>> questions apply to fchmod and fchown, which a copy also needs, and a
>> single setattr opcode could set the mode, owner and times in one
>> ->setattr() call. I started with the times because a copy always sets
>> them.
> 
> To me it seems strange to grow an io_uring opcode per attribute. What
> makes the most sense to me is a common interface to set multiple
> attributes in one shot that is shared between io_uring and the regular
> system call path. IOW, an extensible struct based system call that takes
> the mode, owner and times and does a single ->setattr() and an io_uring
> opcode that uses the same struct. Then a copy sets everything at once
> and userspace that doesn't use io_uring gets the same thing and it would
> reduce the number of system calls for userspace and less work for
> io_uring as well.
> 
> The other thing that this would allow is for filesystems to implement
> multi-attribute changes in one transaction.

Arrays of things is usually unhandy for io_uring, eg if the idea is to
have an array of structs to deal with. It's a lot more expensive for
persisting the data, as you know need to copy a bunch of it, rather than
just have the single item which will fit in the per-sqe data for
io_uring and not require any allocations. An example are things like
sendmmsg - that kind of construct just doesn't make sense for io_uring,
as you could've just done N SQEs instead.

It also becomes problematic with the non-blocking aspect to deal with
multiples at the time, dealing with "yep first N worked, N+1 would've
blocked" which then turns into do you blocking retry the latter bits, or
do you just return N done and let the app deal with it.

With that said, I need to actually set some time aside to look at this
patchset and render an informed opinion :-)

-- 
Jens Axboe
