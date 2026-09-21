Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5F9435EEA
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977966; cv=none; b=E3pZxZ++eBZcHUorlOh4XCRreURH41xLhrxWNZqeJBMxp3hzzRgTsAB0vqfBVSufSfcB+CMqkhdKeX9qAt0r1GYfRrCNuIqDbiQ+Wjj8qMMLtcrrgkUxyddO3ntG77uJWyP5KZMXQMoHhyjx6Y7Rpv9fWW3tQiHHs2KWSni7vjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977966; c=relaxed/simple;
	bh=weGnp7IBbryCjvpWBBTbgpO4sETZOPpzMirjmNwz5rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbSRSPOl+tbzTWalxZyYS3JZTvIe1cGDHVYaPVgSb0+eJQTJvXZK5yGg26dyOIOB+biiPAUl90LAUbEZay1D8JdKTAqOuuDhZUkAp7uuMKB0GAQUXfJ/0zz21eT+9cTodcKQiSVsIdT6uh/LPCV9IvE4z/74JTFt5feJkPJsV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0b1t.tech; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0b1t.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76ef1d0so23857581cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 01:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789977964; x=1790582764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=weGnp7IBbryCjvpWBBTbgpO4sETZOPpzMirjmNwz5rA=;
        b=RAfvKtoRZV7Zn1+t4UztHgmIRy/7Q7AutaTv72yTFAwMx8neqZ6QCF9iZ0fFqJ5IZC
         FhZ0UiSfgwKZJ8rhmsUCkdx5jx1Ql46CrPNSqGDpE+MGlyjpKdf2C+Lrk6CcxNNaFE0C
         YDviWgzROWkBXhntTn/UErB4FyaFyHPVpd7LA6z6aad02yg08SeD3ZmRfH6G1szzgjqI
         RCKToUgc3HLQ+6+qQ/8qS+etysqPJztSMtLV+w77Wt6egzHJ1tP5AhLdTHvS1Edgce/t
         dUQHPW/2B+NZJQCVCbHK7gERkB2fSd2ECPJFb7CGhvnRGrEoEJ5JUJDT/oa8XoNbXv+d
         AFiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNjLF3EDWcyrn6oqy0MbI0kLtYVoLcAzXBX+1nIqUsxjyRN+O44wIHZ2Jsx7kjWw9zfCEgP2zWMHUd14w/@vger.kernel.org
X-Gm-Message-State: AFuF++kmAyDqN+MaFWomhHsERKZod6prCWWh61HJ2RixDAfx77Zl+pvX
	yp4xdJIFIxWjvE+mJ80Hp/Z6IaXOG1uLMGM3hzug403jskgFbwefZX2sAZeHfZTXmtlmCu5z
X-Gm-Gg: AYBFou3JwWdN+JrgdQYEy+wf8Ycu7ZcC/1rejldzGdUgRAbjQbRbeBlCHUbS6XI+afY
	nc+tX8BLE0hcAgdjn1v6lbShGvYICemWx0Tp7vaFvV5h5wPoLVqfnn+EfPgEuaDWiC6+r9ujotd
	O/zlC+K0PF6aRyVBEl30V0kXsTH928cY6J3mGIIz4VVzh22HMrMbfLSsSLZehAmqziQVHBd4bz5
	Yu2/fTGliPyiw2LGYJurEtWsuoBv1HLx9rqpB1fkRyxP0W8/oW3YoxBz/HCTT7RNx+L04yWyGnS
	33CLSZ0Jcj5MrqGXgF/uWvIqUt9FpZsQcN3YfPvqtq2jRsiCs42bMXSPs1BHgvqrzMoLGraf91U
	50/ZAmPbAmIFu7IfRll6uh8FClArLeatzQtcK2/0l4689LM0O4zJGyuwzB3u6QxvQkLo6BtqBf6
	SKMZVCm5OQipi2IUOEVrEoM0fvsye1eF8w/2VM+MZeqA/yo3ly3RbL/T20BB3rJdYOo/+m5ePt4
	0xYWB36QCP+ek4WFy278QWNU+dz
X-Received: by 2002:a05:622a:1389:b0:531:1e10:b658 with SMTP id d75a77b69052e-532b736795fmr90533001cf.48.1789977963844;
        Mon, 21 Sep 2026 01:06:03 -0700 (PDT)
Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com. [74.125.230.235])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ae5ee8dcsm59516481cf.9.2026.09.21.01.06.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 01:06:03 -0700 (PDT)
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-939109fafd6so232534985a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 01:06:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw8QdCi4Xbhcb4C5hawmVIOvB5p5q2gbSxljpjsZdaeiq1qia71bZcODN3APCxMkAFa4qJMoeuxg/ZOW0DZ@vger.kernel.org
X-Received: by 2002:a05:620a:7013:b0:939:fe9a:6437 with SMTP id
 af79cd13be357-93bf551bb21mr913701985a.6.1789977963158; Mon, 21 Sep 2026
 01:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909060924.1102037-1-hch@lst.de> <20260909060924.1102037-14-hch@lst.de>
 <arDN1UdZIydNLUjz@shinmob>
In-Reply-To: <arDN1UdZIydNLUjz@shinmob>
From: 0wnerD1ed <l7z@0b1t.tech>
Date: Mon, 21 Sep 2026 16:05:52 +0800
X-Gmail-Original-Message-ID: <CAKTh27_szTVmVmV26ASynzdJUwQEe49wCxMNq5ifRH9z7tiykA@mail.gmail.com>
X-Gm-Features: AcwNN1V0k4-278Z_kDhRyPxGbZjTPAIgWklsd_xSilZS02b4Xifc_jGYXYctnbM
Message-ID: <CAKTh27_szTVmVmV26ASynzdJUwQEe49wCxMNq5ifRH9z7tiykA@mail.gmail.com>
Subject: Re: [PATCH 13/16] xfs: add support for lazy direct read bounce buffering
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Tal Zussman <tz2294@columbia.edu>, 
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Sept 2026 at 14:40, Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
> I found that recent blktests CI trial runs started reporting the failure of
> the test case block/046 [1]. I confirmed that it is observed with the kernel at
> the linux-block for-next branch. I bisected and found the this commit triggers
> the failure. The error message "preadv returned -1 (errno 22)" was printed at
> src/bio-bounce-read.c line 121 [2].

Thanks for the report. I've taken a look at the v3 series. block/046
deliberately uses iovec lengths of 1, one logical block, and one logical
block minus 1 to create the partial extraction state that exposed the
original double unpin.

Patch 13 stops passing IOMAP_DIO_BOUNCE to iomap_dio_rw(), so the
request now goes through the ordinary bio_iov_iter_get_pages() path
first. That path validates each iovec against bdev_dma_alignment(),
and the one-byte first iovec is rejected with EINVAL before it is
pinned and before xfs_ioend_submit_read() can select lazy or always
bounce mode.

> AFAIU, the test case does direct read to a null_blk with bounce buffer, and the
> kernel side introduced some new requirements to use bounce buffer for direct
> I/Os. Then, I guess the test case requires some refinements to meet the new
> requirements.
>
> 0wnerD1ed, may I ask your help to fix this failure? At this moment, I don't have
> much time to dig into this.

Setting csum/read_bounce to always therefore would not make this
particular request reach the new bounce implementation. Patch 16 also
removes bio_iov_iter_bounce_read(), including the special bvec layout
that block/046 was written to exercise. Changing the helper to use
aligned input and forcing always mode would test the replacement iomap
implementation, but it would not preserve coverage of the original
regression.

I have prepared a minimal local blktests change that keeps block/046
active on kernels using the legacy implementation and marks it not run
when the mounted XFS instance exposes the new csum/read_bounce
interface. That preserves the existing fixed-versus-vulnerable
coverage without treating EINVAL as a successful result. A separate
test could cover the new lazy and always implementations with aligned
input and an oracle appropriate to those paths.
