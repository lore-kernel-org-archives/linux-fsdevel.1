Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E12361DD5
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701941; cv=pass; b=ZNsFFXSrYa7k1S6bUxCQI69iUoRc/O0/U7FEFHvI4uLWKZW91bieW0NZph6zCIzxWaaLL1f+OiPQRLMAkgmbN7/sk6T+Ic9EWRdyXGEHD4LmuP7n4ufWtdsb72ie+pqHE+8Vw1FZ0FMwE9XKDVjXOlqpVC52W2nElSRe1Mt1aV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701941; c=relaxed/simple;
	bh=6epAAYMkIG/HYt9GjNWbYDPrwxgNXLiUu6MWiJ298Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzgczQHMTFpNHLCcpngtrO9wDgkykBmYRMFSYtlWXgZk/mN65sDYal/p80c2rEDBvDPPnh3pdgUp5+kpsWtBhjLK/g56j4AMyk2hijATY2qlLhDJ04L1Mp3sMtrs64wQWGDOQNh4hW1je/+S3D2eMTcUXYWUdKWSUgN5fCPi24g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=La3IJUlx; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La3IJUlx"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15ba5b151dso1218491566b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 23:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784701938; cv=none;
        d=google.com; s=arc-20260327;
        b=nkGX4jYZnP06vaSi1pumpIk9Nk6Kwuc6KqPYY+vjisVEqrUmzNvgYBNNixqm/+5vKR
         FScGprw2DQdR21xoQn1CSoEhdRmGnI7bBD9VxVuHAeOdSngb938SV+SP2Txn1L0pwWA/
         /789y1HfLyk0+py09PSieXD4ZTNtfOQB4ZRmM8Pwf0e6ByCRihpNexcl6VpsgX873qJ4
         uGg+Qfq79eElx4lIEpmESEb9H0qLhebFGYxdd0okV1gSUkboDYh/2nVxj7djfyMhuzJw
         cd0oURx5FByrtdVtNCZ/tgUId0//CcCyxmv49noDDnfhs6pmKt7Cg7uRiJ4mWYlfKqim
         ytyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6epAAYMkIG/HYt9GjNWbYDPrwxgNXLiUu6MWiJ298Ho=;
        fh=XTrArKhal6xNvF20cBsLjMqLUJHnZTHPhoiRnVZkmgk=;
        b=jYZAQZNKuW83Viwawpdk1QPxIPPb8plsJFGAkMxq5iYpgUs0AtKquX7KFkS3fERoWF
         g7k3bjgyuVqeHDe2zyTxSqGVD2JXkJpewT636RprHRJjCVyHxDi/hOKVXStL+/91FqB3
         CijP111nuBZej8ootXZHDv2fe1meddI8xZ9eisECJUcPceOdfQY4q3qRY0wv52OJUMYx
         YC4t0xUJbCSajuFywtURIRmooO+OanXqmEFC6n1dxWeJlxZK/PauN8BQGuHNgl+EiK5D
         jBJQXzhKZFDg8piSiByk0qOUTGE5UloHVRRY9yyUSWqk+99m8eAOyQ+gp0YCqQx1OiEm
         kSYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784701938; x=1785306738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6epAAYMkIG/HYt9GjNWbYDPrwxgNXLiUu6MWiJ298Ho=;
        b=La3IJUlxM6YKoQF5wFoEOw5rR5fHzyHTf3++uMUJqo5+uPGx7zdKZhoGSvzY6XzaEX
         FZX4iW08nRITIaabTBno4cQyApZBfKYfB4TolEkEGZ5qv7YHDVT6NKnKn7fczRo5mQxs
         xn8+Q+JdEy/qrEJyAtln7vDW6e9ijyf3YtUX3bgUgkK7VWapdu2MI21BEHjO1Inu1g6+
         s36L24fBGyewOUQoGvQS6+tPvq/nV+y6UFBBV0ab0ZUggOGPqFQdsRSp9BnYYFPihTh2
         GLyC40QfUFGJ72S+yAjWDD4NyF1nrVEF8w+l2zPzenZsX7yrl/TwI5t2TOef3jfLD7Up
         h4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784701938; x=1785306738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6epAAYMkIG/HYt9GjNWbYDPrwxgNXLiUu6MWiJ298Ho=;
        b=LDWfe2E8DAmLqfO2S0Ga/4xoQuc0SMzo/cMVqso3pMdcOwnzrKGX4cijKdXyfegY2F
         pFfRDoXVuRbTz8pON/L2cKcYEwtLED7khPgKiyKA/Nk0hKwKQBMjzin9Xexggu64Ta6C
         iyKQ2rV7qJv19JaEblzhV+IK/Q7Ua9g/z9PlTeGl08ZsiLSeSOXbrAVXx/PegiObQL6k
         O61enVi17yRz00abHCgenMIVT7O+lbhv9IJMqZdXuCvyCKAJ7ZUIlvUHkdeAW0Jvncbp
         wDIUDag7RFuJdnoVB/6HZxhB0euJb8WcuxLX6mH2qneRmqAOsMUz6P9ztxfGXf9zafAh
         xw7g==
X-Forwarded-Encrypted: i=1; AHgh+RrFasDM3IA+wQ1qVs12Y7SQDKePaWh/3uNxdT4rBSX7bSBt2AMuWFm6Pe/fTwOH1omX6MsahqVPMPzU4oGG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ZPm3T9f/pgcn+y66PUMg5/RazfTz5nkaE7W3QSkO6j5HQ25Q
	o99Veliifcc1Wmv54c77kBghoyAtEQ2LAMKHhyMhO7YSen/DkuX8VONX2tuWgY16nBCQ5Kq29RY
	DZrWcjPjsDoJMBgjDsY0eXfuE7rWcjZQ=
X-Gm-Gg: AR+sD13nmZmulL5Pwi+nvBkfecpuDS8wMXdb3TvgOtbDZ1ZcZWxYs99TX9MkqKYElWs
	ppaovqV2z+8OcjZEkI3E/K1sxMevWEXQmYHnBn3qA4tT8O5/2UnOBj12ixoGjOPsRORJfTQkk0e
	sC+0M6QNXqEktqK1vQQyTiPRz0Sc8Ooiu834HQWItDXowsoNKP/tNCq9KYOKSoWWMlNWSkK0pqZ
	ShphvNROUWteYEsYuFKJGqUP4Kvssey2zAQkYYZPbNXoR7M/zhIZlkez3o7KvbnxiuRYPuJ0jeB
	CgYtOckgDxgspXx/1w==
X-Received: by 2002:a17:907:3c82:b0:c12:525b:4e84 with SMTP id
 a640c23a62f3a-c16b469ac15mr938228266b.9.1784701938294; Tue, 21 Jul 2026
 23:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718093723.153324-1-alex@ghiti.fr> <20260718093723.153324-2-alex@ghiti.fr>
 <CAGsJ_4yvfGZ_2505PRWFHaqdmUvb3R77GFJSzpQ1vEFChAK+Lw@mail.gmail.com>
In-Reply-To: <CAGsJ_4yvfGZ_2505PRWFHaqdmUvb3R77GFJSzpQ1vEFChAK+Lw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 22 Jul 2026 14:31:41 +0800
X-Gm-Features: AUfX_mz1mCudY-8Z72SaI3qCGA3dJ8_Dv-4yerw9MvVzb5hMas3XwFUw_t_eTRA
Message-ID: <CAMgjq7A1Qb+r0p+byXMpum9iM-277HE=Ks7a8it-DUmJ=vOKHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap: free synchronous-IO writeback folios directly
To: Barry Song <baohua@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 10:41=E2=80=AFAM Barry Song <baohua@kernel.org> wro=
te:
>
> On Sat, Jul 18, 2026 at 5:38=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
> >
> > For synchronous-IO swap devices writeback completes in the calling cont=
ext,
> > so the folio can be freed right after the write rather than left behind=
; do
> > that. Because it is freed directly rather than through reclaim, it is
> > allocated off the LRU: dropping the last reference on a folio still on =
the
> > LRU would trip the free-time page-flag checks. A folio that a concurren=
t
> > swapin has meanwhile claimed is left in place and reclaimed as usual.
> >
> > Asynchronous and filesystem-backed swap complete writeback in interrupt
> > context, where the folio cannot be freed; they are handled in a later
> > change.
>
> Might be a bit off-topic, but I've been thinking about this problem
> for a while.
>
> MADV_PAGEOUT, and reclaim in general, don't actually free memory
> when using asynchronous swap devices. Do you think it would make
> sense to free the folio directly, at least for anonymous folios,
> once it has been written out, instead of waiting for another reclaim
> scan?
>
> It seems a bit odd that after MADV_PAGEOUT completes, the memory is
> still occupied.

Yes but I think that immediate drop might be actually better be
limited to things like MADV_PAGEOUT and zswap cold writeback? For
common swap, keeping the swap cache after writeback sometimes helps a
lot by catching fast refaults. Because we perform swap writeback
asynchronously, we can easily overshoot the reclaim and send more
folios into writeback than necessary.

For direct synchronous IO devices or direct zswap compression that's
not a problem because their writeback is synchronized, so the
reclaimer waits. And we already free them immediately after writeback.
