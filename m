Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C53D7D8D
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933430; cv=pass; b=reh+0j6dw1tknuaHjVpMC80v84ms26LLENzqdYZR2BqY5tU+idqRByoYucsiOcwVfQjYAhDN11BxwTtlp72TJchiAXey5PJPP0BXrlVvx0t5aB/ITBGHZgfIoFpEJcTpTv0hBltTD6psUjWOy2sLklJi2wdsxMdEtmhcFFSzuuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933430; c=relaxed/simple;
	bh=r+NletA3FmRDG/GD5IvXS5VhekYurTM15nt1C3iy2LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0l88xdFPocaIlnGRFQUFyPfACkgaLb2ZYzayMqaTHFE6Ff8V8kIOu/f4AyzyRjDZQP59Rnx2HlgvNbmQMnQC70JsKIGN8NAqBhZDSH6H+nZHav5rXOPtLEPGCJ+gy12y9HT4/eh5F85a24CxTbHbLcJrNzRfPNInLUPS22kHNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml0ih55n; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml0ih55n"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-44cb68d549fso259655fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 12:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782933428; cv=none;
        d=google.com; s=arc-20260327;
        b=GyePnXRxBsS6NmUSfPfuQaOMFmM0idlXIh3Qx43EP8kuhl939A0R0luib7u69YOyAg
         eTgnd+2ibIOYNtM5JdKBTyFeIGPd51xBHeKQs2L4jxbTNYi7atp2L7aOW3VJseXfIpEK
         Cxle5cqF0QqHUl0ogtWvWc1G+uZFPBxkymtKdB74v+vnhPHaq1F7BoXo4RQe98P+OCHH
         eQaRYdpsQd7EoFeM/6K+0oGB70wps0Sc62CUrJXJZ1M5pJFn4nZ4jh325OejngSOFhmc
         TVWqc9rLdNIlO1HJVEVfoo3XA4IpKDb5p+mLRk7ia98AD9aLTXTe/ZIHJj7X2fIwrZoC
         1/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r+NletA3FmRDG/GD5IvXS5VhekYurTM15nt1C3iy2LU=;
        fh=304d1jPDChQtq5dB/HlNX+eGJMmC8FFwciLt2zMNvJE=;
        b=nERi2Y/ypto+Jjac0hlgXVLY+WFv01M2SqRXlPA4mPB9be2im4gZOoqJKAOoeFMFOl
         xMEVWH1bTMRQMGd3gAdcypk/DMKz+0fTkHDujwotQ2B60T+ROJ5hkk/yFLEThfF14pHn
         WijQaFCwlLaJMfXDc81ifAOHT2nIOxfGqRA13bFD6x2d67zGg2XbiGtskw8nM40kp1d3
         7rpmGRXhl5tPl4tGt9E8doKYgHKdGj5O9PyvnUkZySSExJJ3eJ4Z74VghO09OykojqcU
         aLly74427hsw3q9qv0xeRnk1bjmJS7vRFOiMTt74PoJAOIB8PDxFBqj76f4KmT9x6re1
         8jMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782933428; x=1783538228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+NletA3FmRDG/GD5IvXS5VhekYurTM15nt1C3iy2LU=;
        b=ml0ih55nsFzrKA+0lWHweYf0yqKIE40M0dLzZRhgy0Kagi1TSlkeTyLxkLZiymLcPM
         riMpj/bwV8kBuLKI0CQGgJjlIqmu1KmFxFS1AuqH00kQfaVuUTMUUJNhvTtj/QtfBqQn
         e7L/KLLhD+kOhoZkDFhmUXkYuHK+zMJQurdgZUBO42jwOb5AnA4a0Gau2bLvu7dB64rS
         2CHP8ycB5ebKneaFg4zfN0KiYx5pvZXjDqw8pdzja1zAw4v6UPiuFcbcygN7jsRdR2JE
         0P01vu7eVa5OtiHuVFLeVKP/OfK9H1BGUmoZuyXQTPUvpbpT5j5Ve1lUvYGH1XtyiC0t
         svTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782933428; x=1783538228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+NletA3FmRDG/GD5IvXS5VhekYurTM15nt1C3iy2LU=;
        b=clh6/r9MdKfQeklzGm1oinyRpTCBN+0S0m3bPaVAREDK/qKyFw+bLfHt7+G6P4q6F9
         lenr6dWx/kLY/eJQXF7zBz9j8orNqGYjJMnnpMDbnBXVUkQqTcegA9INs8knTaPFukIm
         upyK1xQ8dbjIjleX8aKkYbANd1JnMTgc71++v4ng+a84chew/W2qQhDoS/yDg32C90t0
         RSAoHmMFBvxMF0aDYYXfY80NiHylAmP5xxu1UbZT4O2SfMrvFubuePdCIcdEUwqBpe35
         zDe/JDxVVm0kVuP8KjeFZb/fadNUSVmyWVlV43+rkLRRBFH5QKfMGxiAye9S6i9MGwNj
         hiKg==
X-Forwarded-Encrypted: i=1; AHgh+RrgJrK2jcv8tu/6GffBN4SpB60Y7SE0Z2OwLfwVwFyMtIx72c93YckGdoxkGRUptl0Peup2dZWSoFyib5tu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4I30nyHFJTtpr4CzVfYbvu1N7w+j1v5T1mg3ajhcQJf15AIX2
	bckqJZljACYAMr5aBMWGE5c+lP4WhJlxaHqilIl/HvqOlLsDlIK00aBPUw+3zRoD2GrL6TiiJv5
	6NG8JL6pTQKpSnCs1DcQHGlyz71y20dg=
X-Gm-Gg: AfdE7cnMwpcSzgGgy1NlBiWWKWWAQ+USkZwDMtgeFCFfuxPtmOEaLSJCJlnGFTc/q8X
	buUYhqYNQMkF+EMxSmC7/ebKfrrUFds14j+Ohb2eOXVF73Z8p+eDZTO5HpW0ijWtXbz4TaBj72v
	t9SZnSHDJnr8oka/nu+iD6HqKAampWK2QPUCA50yLnc8WqFrdxHbnhAaB2U9/EpDE9g4Cpgp1lX
	UV9IzdCiIr9qeKRjyGy1Xo7HWtq7phgGe23c2DAzc4338lDzpUIP2O52be53uXeEa7bNZ4=
X-Received: by 2002:a05:6871:c8c7:b0:439:ecb3:52bb with SMTP id
 586e51a60fabf-44ae2b77260mr4418100fac.2.1782933428320; Wed, 01 Jul 2026
 12:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <89ea76b3-e956-4232-8180-ee3929adf905@kernel.org>
 <20260625101132.3859505-1-safinaskar@gmail.com> <63f7860c-4f5c-4682-8914-27978b9fbfe1@kernel.org>
 <20260629-bauland-knabbern-abgeladen-c0acbfa62cc2@brauner> <CAPnZJGAJROqfCWSeeBu31HsE6nmgxVqHTNeC554S5y1Y-VN19w@mail.gmail.com>
In-Reply-To: <CAPnZJGAJROqfCWSeeBu31HsE6nmgxVqHTNeC554S5y1Y-VN19w@mail.gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 1 Jul 2026 12:16:55 -0700
X-Gm-Features: AVVi8Cfr-c-MwbiVa4Na7Gy64V9E0QAPHBSr0wHsSXCEVpPyigPKnVtNTDOprcQ
Message-ID: <CANaxB-wewdUnxApVU3yn7hqbztNJFQfN6Y8r_XZk-TZRXpOQ=w@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] vmsplice: fix some problems in my previous
 vmsplice patchset
To: Askar Safin <safinaskar@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org, 
	axboe@kernel.dk, collin.funk1@gmail.com, david.laight.linux@gmail.com, 
	dhowells@redhat.com, fuse-devel@lists.linux.dev, hch@infradead.org, 
	jack@suse.cz, joannelkoong@gmail.com, kernel@infinite-source.de, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@amacapital.net, 
	metze@samba.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, torvalds@linux-foundation.org, 
	val@packett.cool, viro@zeniv.linux.org.uk, w@1wt.eu, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 9:01=E2=80=AFPM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> On Mon, Jun 29, 2026 at 11:56=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > The amount of regression reports that we got in short succession doesn'=
t
> > make it likely that we can merge a plain degradation.
>
> Let me repeat: this v2 patchset fixes all regressions found so far,
> except for major CRIU performance regression

Askar,

As previously mentioned, this isn't just a major performance issue for
CRIU; it completely breaks the current pre-dump implementation.

The other proposed fixes look like workarounds that target specific
projects. Since few projects run tests on linux-next kernels, we should
expect more projects to be affected by these changes.

Thanks,
Andrei
