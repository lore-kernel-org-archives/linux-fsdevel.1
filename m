Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C1449B0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586000; cv=pass; b=bknONZlNMn2uTB8R1UWPNS6g2QDNMxf6DdKFzc1NYVSjhXZJ7GHY3P+43UUKIHKeVW//+aAfd4VsZuWP8cuCBqj1xG/yeCEgKtpKtAncrqopT3hQtZ/e348Zh9G+qf5HXdYNS8vD0FntWi9WJtzQQk4teNQ8qJz+/nSxaRka77Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586000; c=relaxed/simple;
	bh=TKa+7Rt0HMct/L3Y9OQKcWqR+kqwOl5wJxjs0oMkUU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWxr0g7aPnJa7eStHAvJVJmXoX1jwIdWYC8zVH+O/xjPLVTybRaeymtiL8RpwbKGmUv2+taB8xeeW2qvqvwBymnDGy+wPh1bUPmbax9Qb+H78/rxbFkiKLeFV5S9n6NgBkLNSrITlGtTLKw4irMzpI5zSxd7ekaJwU+v7RXtPow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3PgV/+u; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3PgV/+u"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so6461073a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 08:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787585997; cv=none;
        d=google.com; s=arc-20260327;
        b=EUJKEvbGLEgqX/X6K5vMeC2ZtvEBmLRZ0hhb6JprVO3DJATnOwc8cnhkn3o1baVYL5
         wf34OjVsdUZXAbfh5r8kyTZMuJ7GCg6a76nmBnPRZOyc/NyW+CVXoWUSSy7vkwPNuw3q
         lLy7Zsomf+DXAz76Nud9qRkSwO23TjvpyWuX6fF1nP7cglQ6nwsgKo3eJnkYl/euAa17
         C/9tAZKYWX6HHRnRHj3oupMlmnZ95Lzw3IUSIG2kkQt997ZSrdtiryfrONvyx215heyt
         W4WABu2U1LtQ5lx9mCXNbGYd4TbYTYRpjJWj9W93Mnt39WFrlElsfLBGScniCkhLi2V1
         XHIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wJCHcWH/H7HoSqeQAsfWyCv2ylIhs9AEwOmpHAgZ6Mo=;
        fh=cl2GW9ljIdStdGh5JfvzG9IzP8BjYrLZlzHRNJIE/4A=;
        b=NNr5LyFPyOuk3YxWmaoMElTaZZspwO74ZyMKS3Atj9GMm64EiPhjLMcM3P3Bmwu5On
         LPYNetQGI3g1VGFBm5peUNbsl16Ul3cTMkj10JzJCZUhAaI+drv2g8/G05+g5B5Wd3YS
         QNiftFpaLS+eS6nBq14FNCyOk/N68XWVgnUe9PsXBKyMJn2Q9J2D96aGSgOFHsITQz35
         dvBsrdglMziUTI7gqRR0n9RkfAxKiT4mG2AI6Khcf1qq9fE+EDLxucSn04evi/SrCjo5
         4Xa0vp9YC/Y/QxETbsL1H7llPi/9usOMeRlznnBKcC2kOaWJx86oY7L2DcpN1I9DYlmz
         +04Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787585997; x=1788190797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wJCHcWH/H7HoSqeQAsfWyCv2ylIhs9AEwOmpHAgZ6Mo=;
        b=W3PgV/+uOfQUz8pF76YCRrs84UlPEQPXY6HtwG0yI1HdTUh2ba/YB+1YJpUAS8XdXn
         Nx3XJL9Oc00PyQABJxkNHFOgjCSoI/xWe345bzxJ/b+/kz+4kSbygw7HCiQgxjGaaY4w
         sghmbsvrUQl3pnPyXdGdA9OZQnrQ3Opb24oUwzcYrUtP9FEkKTZuwypkY5AjwFbFS7XO
         yXa9rXb/qmJZWLA0UVIlNsn2+ODVi/ShtKx/zqYe1EQzakHcxF5auvyTFihZJF/CcTTj
         7uN/TKfLsHjfnw2WMoiN/6eXZExCjtCWKoYymHKhPSIbWZYRwFyYcpRQTDjzw//We5Rb
         2vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585997; x=1788190797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJCHcWH/H7HoSqeQAsfWyCv2ylIhs9AEwOmpHAgZ6Mo=;
        b=PzxjtamdX9u5RxsOOzo5287t2ixhQFLO2bsHm8g/noUrxZ17Fg0A+Zm9yw4gbFnX+G
         jPAo6QCyv42EkdYXlctwhPJR7sEFo+P5UBGFnUFVVghoIInaInVX0TzjE34vZF0bIaPN
         Nyr9+htbqjbHrQH8P2MLHVt3RrI1o1nzq2IMf0RK9jJf2UqUOrCIPnwJPP2/PW/mTg3u
         7stIqDzGySsWvv+Pe3r1fRpgcrE1SB0VHiqkbrn3Q26b2RAi4lEOScaPHEEPxXybQORr
         BowCHrPNcq7RIpSrfrrQgI1UqdhNVP3QAhynvQoARgIy0b2otpqFT6mAjMdpcz+J2Ijk
         bkJg==
X-Forwarded-Encrypted: i=1; AHgh+RqboKtxwFrMgoBdrQWLzFJWZi300NpDMjqMQTHoK6mXBTG0f5jCyW8p3gZqRYmeIuT61ejoRY6wM7HqQC4y@vger.kernel.org
X-Gm-Message-State: AFuF++kFqjxbO+p9/8e70ItZ3ScPMttWSqUUgZYOUVOoYKpVMIs/iYcU
	I0ADIbioX21ZaNmbF2+0XiwJLL9ZMyf9qPvTHtBzYnw9BVUKL+F0od8ktvkGRiKPltl/XZPgurj
	UTqr3MKNYUMqx3Izfr1SmdDVUnb8w7zw=
X-Gm-Gg: AR+sD10jLVT6RZQHawtovB6LetlF+Ta5kMthmpk4jeD1LTZFhq3Z2vErRy0V9f0Bu17
	LM3wUSa8UpqyToqJ9N39cNePqn0Z2d42dwRdMnB3c3x50Sc5/k7fxRUHuyPJsMVZqzzaAwHwKPU
	SyxLWO7LU5AdoQxqqm/OeyjriqLQDbBf6NUo48Q/piqPqbqrjUyO+hdB4V8X4tH16kvWfYXy4h9
	zouWNhF+NpqTwNMKm9Mk2bZxO49oAgRpdWu0t3odTnpSmkwnQiTjtjAgYUykMQ0KLHK/SkoPvqU
	qhhLKAhgQvSjWA5WyejB7ltCWGVHgyL+QC0iYoZp8tRdVethgO+nzWJYJR402Kwr2knd7mTBeoA
	5
X-Received: by 2002:a05:6402:1ecb:b0:6a0:dda3:83db with SMTP id
 4fb4d7f45d1cf-6a42eec0421mr29612154a12.0.1787585996720; Mon, 24 Aug 2026
 08:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824144130.759997-1-dhowells@redhat.com> <20260824144130.759997-31-dhowells@redhat.com>
In-Reply-To: <20260824144130.759997-31-dhowells@redhat.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Mon, 24 Aug 2026 17:39:20 +0200
X-Gm-Features: AcwNN1UVhOm3jvQyZ6QNY0YG-DuDugP0zSGCGTU-9BV_0e1-yGju4sTdJrlUq5g
Message-ID: <CA+1jF5qPZUhCevwbu7zQDEVWss6gMdoDMhqKqH3k7v=WStRtEA@mail.gmail.com>
Subject: READ_PLUS in NetFS? Re: [PATCH v10 30/35] netfs: Simplify read abandonment
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Christian Brauner <christian@brauner.io>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Leon Romanovsky <leon@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Stefan Metzmacher <metze@samba.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, ceph-devel@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 5:04=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Currently, if one or more of the subrequests in a read request fails, the
> read collection algorithm will attempt to salvage folios that are fully
> downloaded but that span multiple subreqs, provided all of the contributo=
ry
> subreqs succeeded, but this makes the algorithm quite complicated as a
> subreq can contribute to multiple folios and a folio can be contributed t=
o
> by multiple subreqs.
>
> Simplify this by just abandoning the rest of a read request once a
> permanently failed subreq is hit.  This is what read_folio, DIO/unbuffere=
d
> read, gap filling, RMW and write preload all need to do; readahead is the
> odd one out as it doesn't have any return other than unlocking folios.
>
> With this change, even for readahead, the rest of the read is simply
> abandoned; read() and suchlike will call ->read_folio() on each
> non-uptodate folio to retry and retrieve the error.
>
> Note that retryable failures still get retried by netfslib as part of the
> request as before.

What about READ_PLUS, i.e. sparse file reads? If you do this kind of
work of handling partial abandonment, can such a work also benefit
READ_PLUS?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast
