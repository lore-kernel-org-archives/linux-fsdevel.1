Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795222228;
	b=K0t1UHUox0vF5ot4Qx/qYXssYDynhuj4eF7nY3aK83GJDChbWJPdJUtO3O94Iwb70MPh
	 SrUNm8nq9yS2D8F2v0DB68S7eIys4tU+Kd+pa+cE97khbhnu6tURWe8iZ+DNZWcQgVQlw
	 dbmdFRySvHVRwhvB0wGueyuxGkUlImUnl7kteb4m6xCv8p7xvKNyXYnxEkeK8Lj7/pOtT
	 JbHxzNEA5HrVtaZPKOHUq002DkEWVIDgAh4wzNfOU5ghwMcARvCEPN5TIXym+FI8Or0UH
	 Ph60tIVNF45SrqDSPPdwwclyAe+N80rPMa+/pFUw/zwabiaihGIxrqi2fkQIzuzfrMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795222228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=iqTE5jp3Bza3ytzjTemgIJyEzZnCoev1iwuFO5Yvh4A=;
	b=QCgdN6r1QEWERe8anK0HlQwbrIqhAivSnK0tm8xXkATDeN8WiWVYfidAYUBGGZuR3FAJ
	 Cx5WhScrdIc6P7JRVGspUpv3fxUCuUtWawGEInSSXlqXMrsf0+uTYv8431wa9VIz0i5nP
	 P7P+LOuRswGI/WNtJT6GCmEEOHiOVE8QLMC/qw84vRh7yFVFx5NxoKMUlFKKCrzEcrqBs
	 xvm1erEpPsw7L8SDvN6JJxjEXso28hySLsaj2N6DbIm0QKtELBw5U+S0KRTatvks5w4SC
	 8iVMyZCHRvU/Bi0XaiTfPB026wENaiGPJg9DcWYPM+a1e9nlanH0zE89N8wuyn7Yffw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="WTl7g/ki";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208AF60A2601
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 00:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 208AF60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WTl7g/ki
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b87a240de3so1792932a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 16:50:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795222225; cv=none;
        d=google.com; s=arc-20260327;
        b=ZsZLrPPao3fsU8xiU9gIPVghBeS3CuAeQ2LD85Q2QV5EqSb1k6iD8cdspgtk+FZBVr
         TbL4oKSgUlTjO7ctZciBJgt627JTRE7kHinyYPDBZavZPizWCpDbIDlmWk7DTX9ssk6t
         3VQ/Wjpg/mmifigj7taSk/2wHXsF6usIg/1JCb5E0Iw/8H867V699Awe0X/hXv+KKtep
         uJ0CdeZOs4rGdnDjoCB+1abiAdwzcoehGT39AdWzaK3EklgEEOQ4DunRndP6ug3SUUfz
         5rwdwvGjIgiA3ktXyokDEMmcYqArDXV4wew7XhLOFmJSLE1Zt8/h8OMheBILEF5QQqnB
         2imQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iqTE5jp3Bza3ytzjTemgIJyEzZnCoev1iwuFO5Yvh4A=;
        fh=F6qHF1tIjRaG+L/22sdyTsEZYmpfumAFxpzUG5XcCL4=;
        b=pYCuBllLdkeY74c6o/wYLwqzqKopt0tHelVocmkL1qo9X7e7ZX7RIXm0nlIEQcFbBP
         OmP3YcQnBrjBlMqpW4wIeZvxVoUa15nIXLv4c166pb8zwJeVI3iCcYhW/bptQPjWPXea
         +wZD19nfUsurWwbfDrijOBrS2X3j5yu9oPGsdFypt6UF3ixsC+jftUimi/BfzHJAeXrj
         7k4KMAQvt1t6liZyjEXOFl988CBGC2+r8PmFmOeCJZNppmTL1qXRVrbc1whf38HczSpf
         L5YD80ANWTp8EACUMVPQVv7fSQpJNIkSLlrZdgNZ+RtoWNtsaKdyfAhV1vWsTrxcQ6Of
         Eyzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795222225; x=1795827025; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqTE5jp3Bza3ytzjTemgIJyEzZnCoev1iwuFO5Yvh4A=;
        b=WTl7g/kiy+SOUYfbzX0gVDtVMdqSpTpX18xebz2fUY8n6zqvVwNnd7y+UhGjMuR86k
         cbBBAl4Rpjn6TgWuytsVnV9y1pfCHcReEcGN0INj+2J34WQawjFxCu+7pI5Xn+OV1RvC
         VZoP/J823WtANbDMRZ+RXWZqYKrIOF4C3keyH5BuCvxJQIQ+EFG+VurP/TTLLDgY+rar
         0ahOXRDeBV7sZDRHVJFPYTnOdOHenegMPKqgT3M6Ya9mpyUXzl9ErfHJJXqFzGPiyq3l
         5d+E5nbD4Ren4Dl8RmVCPJr8TsUHjDofxDm42/ykusSAD2yKZC0iEVr79wou5/0ssowK
         2FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795222225; x=1795827025;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iqTE5jp3Bza3ytzjTemgIJyEzZnCoev1iwuFO5Yvh4A=;
        b=0ZaLs2H1qzfCTga7LogQcVPryRj5vHqO6QituhImofdLRVjxWxHyPX0YgYZYjay4WE
         qrZ9j4w6BdpYbVk3wQ5Txol8d9rBv17WOWUnDsnlnzsqn/ogwucy5BInosQ018WD8V+M
         j8EO/Od/u0ie3GTwqJHJa4BmeKht5f+q8RD8w59rdKM9UyA46fVBqR5VpmksRFTZ0wqp
         nDrF8WbI51dcuPbmmuJjXBMXP8hnBNvtuwuPBSzFlvUVMEJ9BC/T4s41Kr6mseZmwAVb
         mlaOqukY8DD++fXC5nSfuK/7Nk+23RNVH89cbatlAAX48jGzk3/JOlBqwv9J5K/GTD1g
         DzXQ==
X-Gm-Message-State: APuU4Z86RqjGMNA0MzeRHHm8dskHK1GuBUcfZTGbeBdm5OyNmxDYn6A4
	Yh3J2niFu+UOyeCsRMUEYaYZA1JP8Ei+SwTCzWj+O975+agcpj0VhJEdAAb+vYMdx+SJeZ9BwL5
	w07Q+5VuTyjBgns7oG483rrfVJ61vjpHersvk
X-Gm-Gg: AZFdTZf2W2q3Av6mH5TzQCQCpTcR2mMxiLFaGoIqXgxBMjLc2umzhVISV7A+mj4pGPq
	Ouyd5TK+mdA4FFx8qaQ+UpdULwcIcTVzd3tbh1LKS1/17OYb7yN7TXqLL+QaQ4Zh6+8TkDcq5qq
	aC42JtPp1IuiqVWZtiTuV7akyPOT5PetQrK+0HPQKOKiQQa/OUCa0s5YohfrcJKn7b+bqI/JA3G
	bAgCNUBx3TCK8XuLmhMvuO0buz+TiLwa1PVg2+e+p+ZKdK9OFQyxG3k/RUZXusw83AoTGOWwD1I
	qh+tZz2lL/GQGeG9DBogUexnefoC+2CSikALg/QXCQm5MJcPvsS/eW0lq+NzYIJF/48ncNezIiE
	kd2feysl/PQhZTx1yJZ9dZ1MrKr3l6V5+iLJ+tAWNj2ZRaFyQXKaKiZaGBBzr
X-Received: by 2002:a05:6402:2046:b0:6b7:749:4bff with SMTP id
 4fb4d7f45d1cf-6ba37e81887mr2868207a12.26.1795222225243; Fri, 20 Nov 2026
 16:50:25 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121003356.290201-1-technoboy85@gmail.com>
In-Reply-To: <20261121003356.290201-1-technoboy85@gmail.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Sat, 21 Nov 2026 01:49:48 +0100
X-Gm-Features: Aa3M54riaCEWFwXTktSbfzqeuT3IodXupdwqKrEwzt88Kf_vZI7TBflZsHqS66s
Message-ID: <CAFnufp2uT0D8-5jw3DLhQzdfpB=eSuzhmGdmDqoB7arExaw9jw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: shorten I/O that would extend past the maximum
 file offset
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Ding Feng <dingf3ng@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>
Cc: Paul Eggert <eggert@cs.ucla.edu>, LKML <linux-kernel@vger.kernel.org>, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno sab 21 nov 2026 alle ore 01:34 Matteo Croce
<technoboy85@gmail.com> ha scritto:
>
> rw_verify_area() fails with -EINVAL any read or write where
> pos + count would exceed LLONG_MAX, even when pos itself is valid.
> Such a request should not fail: a read should return the bytes that
> are there up to the maximum offset, or 0 at end of file, and a write
> should write what fits and return a short count.
>
> This breaks ordinary programs that read a file up to an end at or near
> LLONG_MAX, even with ordinary buffer sizes. For example, dd fails on
> the last block, where it should get a short read, and cat fails where
> it should get end of file:
>
>   $ truncate -s $((2**63 - 1)) hugefile
>   $ dd if=hugefile of=/dev/null bs=1M skip=$((2**43 - 2))
>   dd: error reading 'hugefile': Invalid argument
>   1+0 records in
>   1+0 records out
>   1048576 bytes (1,0 MB, 1,0 MiB) copied, 0,103536 s, 10,1 MB/s
>
>   $ (dd bs=1 skip=$((2**63 - 1)) count=0 status=none; cat) < hugefile
>   cat: -: Invalid argument
>
> The same happens on a 100-byte file:
>
>   preadv2(fd, 200 bytes, pos = LLONG_MAX - 50) = -1 EINVAL
>   preadv2(fd,  50 bytes, pos = LLONG_MAX - 50) = 0
>
> With a large count, the range crosses LLONG_MAX even far from it:
> splice() of a 20 MB file with a count of 0x7FFFFFFFFF000000 fails once
> the position reaches 16 MB. sendfile(), aio and io_uring fail in the
> same way as read() and splice().
>
> Files with FOP_UNSIGNED_OFFSET, such as /dev/mem and /proc/pid/mem,
> have the same problem at U64_MAX, their maximum offset: a read or
> write that starts below U64_MAX but would end past it fails with
> -EOVERFLOW.
>
> Add rw_clamp_count(), which shortens the count so that the range ends
> at the maximum offset, LLONG_MAX or U64_MAX for files with
> FOP_UNSIGNED_OFFSET, and call it before rw_verify_area() in the read
> and write paths of the VFS, splice, aio and io_uring. Where the I/O is
> described by an iov_iter, truncate the iterator. This is what
> filemap_read() already does for s_maxbytes. In io_uring, also save the
> iterator state again after truncating it, so that the short read retry
> loop does not restore the full length.
>
> A read that starts at the maximum offset returns 0. A write that starts
> there cannot transfer anything and still fails in rw_verify_area(), as
> do negative positions on files without FOP_UNSIGNED_OFFSET and counts
> above SSIZE_MAX. For files with FOP_UNSIGNED_OFFSET, the file's own
> read and write methods still decide how much of the shortened range
> they can actually transfer.
>
> rw_verify_area() keeps its check, so callers that are not converted
> behave as before. copy_file_range() already clamps the range in
> generic_copy_file_checks() and is not changed.
>
> Reported-by: Ding Feng <dingf3ng@gmail.com>
> Closes: https://lore.kernel.org/linux-fsdevel/20261120051457.47753-1-dingf3ng@gmail.com/
> Suggested-by: Paul Eggert <eggert@cs.ucla.edu>
> Link: https://lists.gnu.org/archive/html/coreutils/2025-12/msg00097.html
> Link: https://lore.kernel.org/linux-fsdevel/20251219125250.65245-1-teknoraver@meta.com/
> Signed-off-by: Matteo Croce <technoboy85@gmail.com>

Forgot to re-run get_maintainer.pl after the io_uring change

Regards,
-- 
per aspera ad upstream
