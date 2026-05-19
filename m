Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7A23F1676
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182515; cv=none; b=A0cjO0Igl6NvPO3UdoyhSkhU0LSqe3QiYbWOFSWL9vgBjxQ9K1UjXFXQ1ZDIYYYQ//hkNezd8ok1X2ZRwJBok4437JtuxHWCf/BLm3ZC8bJwXGYnNIJW1TxLg7pqlCRdcOeeFtHrm1SUvpFtRrb5DclM0PvP33uPrwPnl2JSoMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182515; c=relaxed/simple;
	bh=wSz4n6ZHAULGvzhTDNuqX4TTX95Vfl31WZE4J82fus8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmT8DeipMUczlXGB8Ft60sJ0nO/ecgySLTb94ZS/z8d3OzFxoewA2E/Mvv/uuBU2UAE8OHU3kbVAbJpDxUVWKdsWSDIVoJuId2Kq+gs0gP/oAgQX9XJ7KD56JroynwbEqg9A5wOGOOjrJuDsArnowH9EsSNrDdR5TkQqHmPmngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXpWbKTo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXpWbKTo"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48d146705b4so35847505e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779182511; x=1779787311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoHvwM4p61ukSgPZjfDBcRJdrzaBcrrvLVu02xCIKiI=;
        b=TXpWbKTojEsG/x9DQwsk/0H+XskySEyrX0rBufagIM5coaGZbN4GMMyWHMx4wOTKnO
         6nM1l2EQGpvGlehe2RC3T4ZBB1WXsj5Rf1E3MrufZxH1mcHQuV2DAjr18FBVYOUqYjgc
         +6y1OM/nUF90Z8+DA5+FZSGWcJgji8lL/IivBQGcVB2VBugHWaXZs3DvHHfOHbKVJOLc
         vV+FsJBSqOSx/H3aGa+CQ0UCZvTUjL0to9I1RZpRrMVSq0L1BHC0/CMKYJEwpHBcmjhf
         OXkr4+d8/+ve/13fJL8u6Pr2sBaon2BIZEsoQmRkPYR4psV5RmARGkuLDY7jOuB2fCFu
         Dd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182511; x=1779787311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QoHvwM4p61ukSgPZjfDBcRJdrzaBcrrvLVu02xCIKiI=;
        b=qqDRXZG3r6U/OsnRczZbd6+lRtVyWqTS2opG2ecrJhY+LWHnvaWoVoapoh9qJqkxrp
         OMxUs26Y92nFMq/mi8f+i51yzcu5vg00CvEp1USWus5goNf64nZiN/a5NFchv4NYXtjG
         LqVWhsCKL9xndiTZuzKMXe4YjGULX/rI+rWNCDvQyDZLNYGfsP7fg7Ngvbd7WbVtMLcY
         Cujp8+RTHjMVpNAF8kBJvkvOqLBaIM+2sJt7n0Fg7fmXfRU+6INct/hxoRlCfcX+MFov
         2kPD+M3eAnMl/ax2mtyjXT11Q777KDQ2tGGXmMCYQKeGmtiI++IKbh9aHkDksYtBBaFm
         mc8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/svU213GmBgAjElL1e9HL7uUGSihMgKhGdbIRwx2QYTerD12r5xD5TIaIZgCBcRiWzDurjkJqIeBGOybKX@vger.kernel.org
X-Gm-Message-State: AOJu0YwKH3KQuTnwZFSH1D5eEDzoMY6abAdAloy2qUYMMdMhEXP5fN/S
	wpvrjTq4dctKIu8ekcoX2e31ebYwcZu9STbzG/i6qYMkE1UzMgHa1UIK
X-Gm-Gg: Acq92OHOFAocMqEiZLHUwsqylKLPB7nGeurZ0ZeOfgwiSGiGXYAKCe3EFrhpwh2Bnae
	5mrjQDPfVUg0M+faPNJbgjU2j+ZSEB9B1+9JnWhRX+J5MLVENAepI+kCzW7N15x1HiS8q02Hc9h
	J2AAITjGOv1ZysG7lqMB52n+2TxPsCVOG8iixxZZubH7HcB+IxDUseA1pRVfcxgIq9cPdFmCMu2
	l2KWbUUfznr6OFOTH3LuRs6lC5Mt8qGhDl9qPGDiLkTUhV0fsFYNTqULDkMZ/KSs/ep5EkKxKQI
	RS4cgX6h96F5srwDBLJBcxtMvuGOCiOpIx8wBxF3i6s8Gw5kaZOwicCJHFQd1BB53bdHOyV9FKs
	aYg828QaTpGyJVGEpN0avXei7PaLIWL99p35ElKtrmdsqL85EPZpT60AP8eOts+uB1k0583zPMw
	LO/aLCfIZ/kOLFIsLIbfO2NLeG0BcpVoBLCxOVYY4ILD3sX1+DeELypdft6BHcWOLyL13Ph3Jle
	1A=
X-Received: by 2002:a05:600c:4f13:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48fe6328bb7mr321111245e9.21.1779182510799;
        Tue, 19 May 2026 02:21:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2a23dsm102576065e9.5.2026.05.19.02.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:21:50 -0700 (PDT)
Date: Tue, 19 May 2026 10:21:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Nitesh
 Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, Anuj
 Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
Message-ID: <20260519102148.21d42afc@pumpkin>
In-Reply-To: <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
	<646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
	<20260513081929.GD5477@lst.de>
	<24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 11:29:54 +0100
Pavel Begunkov <asml.silence@gmail.com> wrote:

> On 5/13/26 09:19, Christoph Hellwig wrote:
> >> +	if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
> >> +		bio->bi_io_vec = bio_src->bi_io_vec;
> >> +	} else {
> >> +		bio->dmabuf_map = bio_src->dmabuf_map;
> >> +		bio_set_flag(bio, BIO_DMABUF_MAP);
> >> +	}  
> > 
> > This is backwards, please avoid pointless negations:  
> 
> I can flip it, but compilers tend to prefer the true branch. E.g. this
> 
> if (cond) A; else B;
> C;
> 
> can get compiled into:
> 
> jmpcc cond B
> A: ...
> C:
> return;
> B: ...
> jmp C;

I'm pretty sure gcc completely ignores the order.
Some very old compilers didn't - to the extreme of generating a short
conditional branch around a long unconditional branch to get past a
large 'true' code block.

likely() and unlikely() can change things, they are definitely useful
comments to a human (or Human) reader.

I'm not sure you can rely on the branch predictor to do anything sensible
outside of a loop.

-- David
