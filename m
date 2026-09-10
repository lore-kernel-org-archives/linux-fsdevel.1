Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9413C6606
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073925; cv=none; b=WzcYx8T2ADUF1ShvkIki+hB16xBK0gw9C0aqQVj6XQa2HIrB6bdMRJmGmN5Q1TNj88EH2lds+qbLd1x+E6iggbxBEn8qTdzNzpE3AxlxKA+XJE3JQoK0NwOKnTHfE+X+GBtc0hTt9y4uCGZeUev/h63nfFO8D5XVsoNlce4Ikpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073925; c=relaxed/simple;
	bh=ylWdr8yhyOUHr5p7rV7V/FTvMFhwSjE7Fa4ndWREMxM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MYhisBktPPoVh+ZQCIOEJ1Z9Dr/U1TJjiP1rr2FyH2x1ZW9ccScagt294ACOyMcFg2+K/fpc8nuz1zVBhVcIK1DXwnFhLIFH10w3z804tB7d5VJ8Krn75Z916SJ3xhPa8mlwOT6X/xpmh9Yb2cEuqLf4Z0R1xqcXmqtBRTyx6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=JCWIFFcL; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="JCWIFFcL"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f5934ba2a5so134489a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 13:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073919; x=1789678719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=227EuAsNywH5Ru6uyjfcvigTr1soLZnaZRqqI+5pgxA=;
        b=JCWIFFcLxLQxXdXDZEqLRBuXsJhUNNgngvc5gWsDUDvJybqybK9yVb7iLek50ShSMZ
         /weV9JaumU1fbMQSuJRjtmii5oKcvXI7hapFyIj9WN1anPieaNLAHzzxFVkj8Ivrd/Jl
         pbN/PxTQogxvZNrlHqRZtGoAM8uAriRL0ZuTT5QF0L3VfSsLvn7cHYJWEnnsRDuATUDR
         ol3EcgyDzCYe1VdcsqdVzSFGG63cpGPsck4oVgcEVsNpWQ6wl7Imye9o2679pizPWvOH
         XPgaL+71rKMZA1s640W3tlBhJbBFo9l3PYafygM90yKbz34uCamWM5ssODooIH9n/OZG
         4SRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073919; x=1789678719;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=227EuAsNywH5Ru6uyjfcvigTr1soLZnaZRqqI+5pgxA=;
        b=MbT2FzuzuGDAt2K0q1g5kp+54PfXTzjFAjO2uT9T955kZM16D0HZ8DU8/IqSbPHDIc
         hK7zbVcmchLwNyUvV+sd2znbd6SXmp+q+13QVqaOacM/+UrYujiV32TtV9syKTIsk/Or
         P+b3yhpPJC2P6RSayiRySj/SbzXyg59TOL6QicBrAbTn4iOQnLbjZ2oaeO+6lsp8jDrh
         dI4zsimKYQpNd+JdNCpfIgUKLsK5marrnM/hJs0+ThDryTm241BEcj9/l0PGa/Brvq2q
         xWQZDxopgpOc7dJYMX5w71Qhl/XpAeHw8HjA0MPiNxUWotbxGhJvZBdyA463nB8yYq+7
         tjTg==
X-Forwarded-Encrypted: i=1; AKwUvBwHLgjx+Qa90pm4Tuqvifg+SHi8R9+IC+sbXXqs6MqAF9C4hVTP3bpnj/J2vYL28AatN6sGGGR3Fjl+s7iC@vger.kernel.org
X-Gm-Message-State: AFuF++lFLnLnFF4yoKtoWuyXIelGYL5OmCzFeGiT0O54oS/y3Bco8cGj
	Ck9LNJKshW2uV9Scb0RKDAr1HRxm7twECSYstgC+SSAM5wAAcTE3L/ZTMfgnDiUe0GM=
X-Gm-Gg: AYBFou3kTyb/0TxBlj34G7Cfl4B8LGztnLpDSAXSVgNVGT17Ng0bTLCnp/u8nFEAaK5
	dVqxOmuAtfqPSnC+w8AnF0DxpVtms8x5R8fkzGOV6f5cVX48zORkkxBK1m38HX7ZMbOamg1hDvw
	4Ksux8eK6P3NAIOJSKoMnuPGMQNSWIJkXl/6WgjeGONnwKFVgQk1lnyQy+7ivH5ssK/EemzttQ0
	UV1FwM1DDbb6iedN5IDoGiuJJP/G//4RqntQnBs/wcWiockXMIkV5HBqo659EHPBafDANArixRT
	i6KZhZyPk8kEUWncmYJM+35jEGAbQyAX4TekavbxQCmTT7svilnaaDO07MIl94zxUyUe2Uam9Qe
	iAiO8CzedYUged6bMXAhV5HywzJfKqR5wjk7OWgNKellmHWBw5ZDlvd9bWr4M57U2AAuYK2IhoN
	hgnc+CRGJEXLOWLj97W04nRTcNCQGtZkNVP0Xu5duVUAWJlJIXzaRnN29FADFq01yWp3trpUKXQ
	+4PJ9+VJFtJkNJil+GIoOEAEMOaQWzL8p3BVE0ji9pvlXcDj1eAPGdE
X-Received: by 2002:a05:6820:3411:20b0:6c0:5630:bdef with SMTP id 006d021491bc7-6c0bd97850emr353461eaf.67.1789073919642;
        Thu, 10 Sep 2026 13:58:39 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c09a122443sm1108879eaf.9.2026.09.10.13.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:58:38 -0700 (PDT)
Message-ID: <eb469580-509a-4895-a819-e7f3e4fa0b0a@kernel.dk>
Date: Thu, 10 Sep 2026 14:58:36 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/16] Add dmabuf read/write via io_uring
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <cover.1785596451.git.asml.silence@gmail.com>
 <178907372259.484803.15807864431748251506.b4-ty@b4>
Content-Language: en-US
In-Reply-To: <178907372259.484803.15807864431748251506.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/26 2:55 PM, Jens Axboe wrote:
> 
> On Sat, 01 Aug 2026 16:46:12 +0100, Pavel Begunkov wrote:
>> The patch set allows to register a dmabuf to an io_uring instance for
>> a specified file and use it with io_uring read / write requests. The
>> infrastructure is not tied to io_uring and there could be more users
>> in the future. A similar idea was attempted some years ago by Keith [1]
>> (from where I borrowed a good number of changes). Later it was brough
>> back up to life by Tushar and Vishal.
>>
>> [...]
> 
> Applied, thanks!

Eh no it is not applied, was just looking at the series locally and I
guess it got added to the b4 ty pile.

I am, however, wondering if we'll see a v6 of this soon? I had some
comments on the nvme dma mapping, that can be improved, but I'd rather
defer that to post getting this included.

If the series is dormant, just let us know, and we can pick up the bits
and pieces.

-- 
Jens Axboe
