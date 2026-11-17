Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794926017;
	b=DCvH/ABEDTClnD2wx6MfuznYEiDFW1qVOJMDhaLtj5en9PgQMT3tG9vz0wL8L7zbt6LI
	 fCa6vPRr18yCmuRNz+6Gj6TMLyaEId2GimWJ9XMzXdm7sT4UjQsSjxD8pRLZMOMnpU+NE
	 YBlu2wuOe1kYtg5k/X9hLhgtRvX2WZj5/deacCfH9fTLR1cVkw9d7coBrk/LX7GKQ2o20
	 cFsWLquTwplQ8eLPVld4JhN/kH5w1/sO1YrFh44diLbENNDLDlm4w9FRnfTzZnXrq4vJz
	 jTWDuke2ZMZ8UqXdPTgmJo41uj2RJiuFSlsjQANjMd3jGDtvTgl4iO2L+i+Q6HqsU5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qYqqunDmmSSST3DA/CdKBNtQiNEx8lMxFK8nZ1VqJzo=;
	b=f0SppQMcV2GS7yM6kEbzYF+jsMJgqX2uDBd5SB1QBl/xxT4ceA5HFjLSps2g0SW4DH8k
	 +fUCqMmxRPiclookd2WAI4GfdNYZbLkGO+B8jBzWart2PUN1yC8Ffxas9uTy58Ma+vbbG
	 i3+g99yaaZ5a9BO+uJJctXNI2p8ZDZtWMxqptOE9Fk+E/YHXfVnr/0iUu+5gZogVx33p3
	 QNVwR23LOWEVhoWRzn4rgOaKmL+qZHb4HqhvijTdhB9Ifrlb8mSdrB4/oR5UrfW6rl8jC
	 aHlWfLKhZe/vbly7Uk6i7665GDC4fFUGaLt36gZZv1UEww7LfwqmY2BKu3N2rhLA/Kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0mNVNXfi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5D606A336
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 14:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83F5D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0mNVNXfi
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b8627e0eb2so1111743a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 06:33:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794926016; cv=none;
        d=google.com; s=arc-20260327;
        b=Od73+LeS9+0ZHTE7C9FCtsFxciIcGvdwMw1CLXSqqDAk27olPPAdy4+65PPmDSLi7b
         XodeyASSk3uk4jHQHtP386IpPQzgYmJAwXrg6kq5SAnJ4Ie6CejzLT3t07iPBRh0k+Uh
         8doxKuM37c/cEV0C32qBiiKQ+dJ76hNgKSJbv/L5/k5LQR2nCkKZ51sOFfpQHDZZ3dIr
         dR6ZnsF3MPEtODWjp5zvcPaCDymkVd9CU4sfzXIEk+5MMN+N43WQrlOVckMKLBB8agR9
         5MPp+hRlPuwAoAIGlk+vIrKpL6mDatjcI9fwTJPElo9urc8Kru8t+nbqd8TJy7/vxv5A
         NvPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qYqqunDmmSSST3DA/CdKBNtQiNEx8lMxFK8nZ1VqJzo=;
        fh=7FFtL5QfNpqQ55vKbpH5wFO2iNhYLF/ZzH8ALpAoClU=;
        b=TIKSX9CZNX/AiAWui9s/kfAnQv26IamXgRpbtf4qzJQ5YiL56vnlSQI7uHPQ8sKGkF
         kn1ILXpuonLMD0blqad3gNVJFqN0pE0kkm2Z7nu2xcxRLHpin3b5xh1hCfDgKqOhBG/y
         WDwVJLQOjfM57Iu82ldc+BhJ7ta2YCsc127zrgTxRPLXyVaQdQykGewBtJdtif8sTHv2
         BdIphsd5hD8Delni8xZcZ3wptICSDvxoyNcf5+Vn9eYxe/tbmJfpgeDUkoYbNKhIuvoO
         RaRNknJzMy0Ah+xCtneHf9UDChMD/2KmVhcbQFVnY6Vk0WVNiKoPsRFer86jOpKopBQR
         j1bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794926016; x=1795530816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qYqqunDmmSSST3DA/CdKBNtQiNEx8lMxFK8nZ1VqJzo=;
        b=0mNVNXfiQQ9XqB1g8J5uwr05zLt8Zy9JB1kORj6uu9v/Enc/dwdj2h+ayrhTSnTLAM
         mzSIM7IlSWTsQWSwG1nSKV+JX+YoMc50pW67PftdsGvCL2im4XdFKBZivszLqUn5ifMb
         iH3f2/7XZjvbWh1tovAcbMkickWuKZqmp0xyfK5/w6rP9fyMSHqn+X+uzyrboAH+kzxD
         Dvt+ZOisKHzi55lVGVTz8HWUpjQrVbOcU0sq5d7HwzKIGDihFUI2iwA5JEJ4wMzXO/BL
         2xs/lUipTtlGQNL9Gm4g6O+r0pYP7bLhEUwD/qTqeTMVCjDHNKwne3jD4ItWcO+ziZ4A
         DDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794926016; x=1795530816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYqqunDmmSSST3DA/CdKBNtQiNEx8lMxFK8nZ1VqJzo=;
        b=OLqTQjN10vC2YCLJDayxWVNewm5AmviHO8O0f4c6Rfcgd0f8skP6zF00hEGD1H6i2C
         Md6SQpFVqA6HxFGECkrc87LGoUPJSTowH6K49EccPHPRQiHi5ymz0GKIFjQB5kvF6Bbi
         CX71vqSdasBj/8hhdrTxiB6GlSONJLqabUwA9XWH9qga/X/WEqrwQty7HU1BMnvB/vQh
         BeI5ybca/FWJcnh8KKbuP4PBbCRRBTsgl5str/cOlAJVqEziLuMgBt6Bcp1VeU+Kpcjp
         6tV2LlY5KO6vnvyNQnwcdeSJL5tdzvcU4c+eiVTHDJcx62g1KAeVY61XNYQQFf8vNX3O
         7tZA==
X-Forwarded-Encrypted: i=1; AL+hErEn5SdHRS9ck3wWeMrCIyVm8HIZJCbALFcPyOpqCjYDYzf4qMb81SDX6U7pq8lhzBrn5koWG2nT/bshXCYC@vger.kernel.org
X-Gm-Message-State: APuU4Z+a54/5MSuHcMeC7olwmUhq3CItJUoSSIR+gecWuUgQU7qnM6xd
	5y4dbiBdAI9BEv4i8sjEwgV2dQmjFrgqlkj7rOnisSGfWkaTNGRrr2Z9zRjUMZqE3YvjWBEwgle
	HAGfScNXiS5cXHvq8mt0/XlOrVDXlj5E=
X-Gm-Gg: AYBFou3lwGvNSkBstzcvXGLeotxRQbyW7hRvGTnhpCNDgwEmV+DczxtxXuj+v1ejJJK
	Zj1WrZ6yTR2FOwQTkovbm7vo2qNVu08UtdRg+l4oHP48tlzeZQyMH9vIOcxASWigpXtdBedZuFI
	qI7M280UrlvSbRwKvfnI8p82ByOEqclVDRMqsm91fvTOFGn8YkcN7DNqCiFgoS9TDcvgEmTZ0w1
	ught6KhGx6pVotjyr6GZnA9miymPUqbYfnzW535S/51y3dafryoVQJMaofIEbed6nRqVcWr//Yq
	ryLjnF/z3yItOUpL2xrJ60EDCLDeE/rFZO/rlakg54Vn5JuVJTEQhr0GX/20xsMkihfNlpDtm9n
	hbfwKup6aDW4VHbAuRQoc4Dv1mqBnllLvNuXcDtGXI1uau8V/biMTUAfJYqXUuGYHLCfvlQ==
X-Received: by 2002:a05:6402:c51d:20b0:6b7:749:4bff with SMTP id
 4fb4d7f45d1cf-6b7c0bc3facmr7573789a12.26.1794926015815; Tue, 17 Nov 2026
 06:33:35 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com> <20261117135146.3174252-4-graypanda.inzag@gmail.com>
In-Reply-To: <20261117135146.3174252-4-graypanda.inzag@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Nov 2026 15:33:22 +0100
X-Gm-Features: AclHuK-oqTtDNy1F_dD-TE8gCQJwenfN41foadOCG31m2aii0fr_9cwaA2IqUTU
Message-ID: <CAOQ4uxjO-eQPk3OS0iCTRqyFgFSRtVMFywCiPdgWGHkmRBuAUQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fanotify: copy full qstr length for copied event names
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 2:52=E2=80=AFPM Junyoung Jang <graypanda.inzag@gmai=
l.com> wrote:
>
> fanotify_alloc_name_event() reserves name->len + 1 bytes for each
> copied name in a kvmalloc() event.  fanotify_info_copy_name() and
> fanotify_info_copy_name2() use strscpy(), which stops at an embedded NUL
> and leaves the remaining name bytes uninitialized.  With the original
> length stored in info->name_len or info->name2_len,
> copy_fid_info_to_user() copies name_len + 1 bytes to userspace, leaking
> uninitialized kernel heap memory.
>
> Use memcpy() for the full qstr length and write the terminator
> separately, consistent with __d_alloc() and d_path().
>
> Fixes: 929943b38daf ("fanotify: add support for FAN_REPORT_NAME")
> Cc: stable@vger.kernel.org
> Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes in v2:
> - Use memcpy() for both copied names, as suggested by Amir Goldstein.
> - Write each terminator explicitly without reading past the source qstr.
>
> FUSE fanotify mark setup on a zero-fsid mount returned -ENODEV; the
> normal-name FAN_REPORT_DFID_NAME and FAN_RENAME paths were tested on tmpf=
s.
>
>  fs/notify/fanotify/fanotify.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index c25cf5c1fc70..2d6b5c2c6f25 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -221,18 +221,26 @@ static inline void fanotify_info_set_file_fh(struct=
 fanotify_info *info,
>  static inline void fanotify_info_copy_name(struct fanotify_info *info,
>                                            const struct qstr *name)
>  {
> +       char *dst;
> +
>         if (WARN_ON_ONCE(info->name2_len > 0))
>                 return;
>
>         info->name_len =3D name->len;
> -       strscpy(fanotify_info_name(info), name->name, name->len + 1);
> +       dst =3D fanotify_info_name(info);
> +       memcpy(dst, name->name, name->len);
> +       dst[name->len] =3D '\0';
>  }
>
>  static inline void fanotify_info_copy_name2(struct fanotify_info *info,
>                                             const struct qstr *name)
>  {
> +       char *dst;
> +
>         info->name2_len =3D name->len;
> -       strscpy(fanotify_info_name2(info), name->name, name->len + 1);
> +       dst =3D fanotify_info_name2(info);
> +       memcpy(dst, name->name, name->len);
> +       dst[name->len] =3D '\0';
>  }
>
>  /*
