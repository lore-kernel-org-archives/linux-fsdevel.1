Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEDC1F09A5
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2026 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786233082; cv=pass; b=EltQIOln8llE678GQqYu+pu2B1MHctNmk0ban4UH2nOLVp0iswIyBLkkufKv6CAgILfYyTIUE6ex9G+DyxsvP5z5Kha+IRPH6LCUO0R7igzcl3+yiEAL8gpFKqcEMNX7K5jIRafzSXA8QjeOjAQgvE8bR1Gn+3AUOMDXEe6ONZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786233082; c=relaxed/simple;
	bh=X/4GL697DIpdRLh2JolYFh0Xvpfh0iDY1+pv9hSlcss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U56hgeP1UvxT5FH51wDjTfwSCTw+imRr6k9lO0FbPkJLQ5hwDnJQPjFNCVKGFsF4y/PhwDOpSi8oI+qnBoZ3t/ImPQon8AGKlxdiWyobXZeRQig5wH06zAhbGxCVGhhBfFcoX9VVJO5tQBsEvQXWlmZiLX7lnHZAsE0QU/MeT4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sh8KaKSW; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sh8KaKSW"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39f9d4bed90so26228221fa.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Aug 2026 16:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786233079; cv=none;
        d=google.com; s=arc-20260327;
        b=DJ6QWEBINF1etFsIX0mElsUrq8aoqMAGS32FofS57OkV7G1kBJa5wSeqy3KbjUNENq
         WAlYb7LBgWXAm9wUbHU/S61Eqwnnxb+n0nLZLUr9gcAwBmxHv3s1vvnIB9hxxGPzXVW1
         Ifs4mfIuGb+4tYAngRKB/IeLWF8F3s25e89hDC+4lnl9r2MzU71chii8oLZR+U+CYgld
         yaBhj6O8gnWB+Ok6gEpZAvZfLkbEgIdHmIhBsLtQvPN3ZT4JRZ2tkLp6yDDMK7uHafca
         DeLGslTGtmtOcHxmPmkfEonSJSk1Mgi0hqYYF/fKW/g2j1omUKQZzpsJRDu4VqTOfyY7
         ZNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0EI/7cdTrv+pUiQdbGaU4idt8hz2XXFh5kbiSCgsyCQ=;
        fh=G6yzRo6q0ge+eoeXe+zmxLznGGcORg6VgRHomE3yaTI=;
        b=Giw7hUrW+p8FkQTmPGF64XxiGZ942Gd+ZLSsPgyja8/zbiuZg7UtzuIDGLKqUwVaGZ
         NTH2qce0zAMldsf4FHbq97qxXf6NDIF0pAAg/AVfCw4/MJ5bFek+JrtM/tqAJWpt+5ul
         cwZtZjG9qzE58GyE1pyIEX+xoy/maV8aTRzMb/21APfHMaNPdjmxWFK/fIUIkBnudJ3t
         nFSmCp0+KTtKB6m/Zo/fHgT31G3b/ZLKqDFzFFuhSg+R6UsCICn5uNNjX5c/t2wVefLW
         YMdbdJvwLJIGbcnMxM7WGclDFaVa1zuKq/Fmqmq5UIpetXXMwAHunEx4BVeBQzZ+mjj/
         y/zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786233079; x=1786837879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0EI/7cdTrv+pUiQdbGaU4idt8hz2XXFh5kbiSCgsyCQ=;
        b=sh8KaKSWQCVETf+JqFd3hYxiU1b/Nw+u+4RpAMCM/0Iomd0/kbJw9Db4QNPyRqISPz
         c2rTGDga8w68t9H6kxCD6wRqPW+Eqin88t2d8OL5a/SoyxXRMoOEL/4fM0rOuKddCRD0
         VIUTeVIN2Qp/e+C8ii9rj2SGfeixBecCVSRXvLkPWFuwSgn4AjSDL1Q8C9BH6D89fJ7L
         UnTIq9D7b7Jo2butvnC5L/dzpsBvbW5e7U0PyvIDoQ/u44m+9979Yox/54AJtv/jyXrV
         jpjItNLsRVIBuXFatujVhDxif/r1qEePABItkRUS59UJg+k/SWpouBeNlvozXENzye73
         BB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786233079; x=1786837879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0EI/7cdTrv+pUiQdbGaU4idt8hz2XXFh5kbiSCgsyCQ=;
        b=WEHFPLwfQaVUz9/GyKJqiKExwStrp7A10L8jh0386DAY+ScZ21IzacOUNjYGBuXW/F
         aG2dzi6vIAMXR3M8wYi+Sk5/I0TbC53WmbosN47DUYqzH40M79w2jPrSn38J9TsE+/mq
         kzjeLpZq4gHlqMd0KDndM+fhQZdP+H96DaREWDJlpkhdSbfbbGsBy8avrSMq6erJqBE/
         sL2TyEl1hB7ZnBfvTKkAjgNW6HkZL5i8lDb7wkej4asnQz84dP258Csy00bvwOzfIYbq
         jLXJXNixNVUuMi1rwY3d8C0nsDM6I1avvSJW8N/WuADa+fJjI3UFZ0owSuuC4i05P+pB
         LBAg==
X-Forwarded-Encrypted: i=1; AHgh+RqJhByivsZgbY2RNfq1uv0g2IJSmJQqfaelma6IMahY4aTyYjqU28pJEWWhsAo53Yu/8uyT/35pGcad9AD0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7KoCEbUv0pvDgsPvFM8uee5FWSQrLixdILaZyOEEhfX1R/H8F
	JNfhB17+C1ejeyvoCR6ZGAA+hTG8cZu+LVrfnSfzUuUE7gW4AbVBvPe8lF2HjMwXvUJ9covOmRP
	zAnZrtxtujQbOWBuNkiTQ64x1PYNyDFU=
X-Gm-Gg: AR+sD125WGZ8d6+LYGchzE+Ceoh9/ggPM0IVMMt4rEsNrFVZr1vaHSa1JMryUNlYrhl
	ZBkc2JhCr9p72VmJo9AynZT+Z2lIQnVtEx73XGsvzrXhg5N6qlBVkhdZSG0I/Z6KUsk6jQxUu7a
	U4af/bAQy5Zk9j0FbnTEusmH+2qYGxCbxN9zZmf4FgQOPadoHoDK0iPQBh+L/6L9N3o18yDcoMF
	J7fcL/B8nNImqJlnD2qRmJjyeV0TRvvmnKdWMDpc3E4QZfyzOwIfovdwLYYrybXSXJ6I06mZuQt
	05UnRllpbXQgbqxbmyzIJfg0zjp+1TUbYOd0z0steurjdQ==
X-Received: by 2002:a05:651c:150a:b0:39a:c1dd:5399 with SMTP id
 38308e7fff4ca-39fe8461201mr11982351fa.7.1786233078738; Sat, 08 Aug 2026
 16:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808003523.2760509-1-slava@dubeyko.com> <20260808003523.2760509-3-slava@dubeyko.com>
In-Reply-To: <20260808003523.2760509-3-slava@dubeyko.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sun, 9 Aug 2026 08:51:01 +0900
X-Gm-Features: AUfX_mwvQ3IKbHIJ3MMQqTH9pNa9TgYyTxYyCM0XMxMS9Y8cSH8SIlDIbLcdMLg
Message-ID: <CAKFNMokwaRf7e1yzYBNAxpHhvMZCsEzeqc8L066OaJRfS4b4zQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nilfs2: switch O_DIRECT to iomap based operations
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: hch@lst.de, linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	lilinmao@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viacheslav,

On Sat, Aug 8, 2026 at 9:35=E2=80=AFAM Viacheslav Dubeyko wrote:
...
> +static ssize_t nilfs_file_read_iter(struct kiocb *iocb, struct iov_iter =
*to)
> +{
> +       if (iocb->ki_flags & IOCB_DIRECT) {
> +               return iomap_dio_rw(iocb, to, &nilfs_iomap_ops,
> +                                   NULL, 0, NULL, 0);
> +       } else
> +               return generic_file_read_iter(iocb, to);
> +}

Among the tests that used to pass before the iomap conversion, I found that
running xfstests generic/418 and generic/465 now fails with a "broken bmap"
error, causing the filesystem to remount read-only.

This happens because iomap_dio_rw() is called without holding the shared
inode lock.  To prevent this race, I think iomap_dio_rw() should be
protected as follows:

        struct inode *inode =3D file_inode(iocb->ki_filp);
        ssize_t ret;

        if (iocb->ki_flags & IOCB_DIRECT) {
                inode_lock_shared(inode);
                ret =3D iomap_dio_rw(iocb, to, &nilfs_iomap_ops,
                                NULL, 0, NULL, 0);
                inode_unlock_shared(inode);
        } else {
                ret =3D generic_file_read_iter(iocb, to);
        }

        return ret;

Adding this locking resolved the failures in both generic/418 and
generic/465 in my tests.

> +
> +static ssize_t nilfs_file_write_iter(struct kiocb *iocb, struct iov_iter=
 *from)
> +{
> +       /*
> +        * NILFS2 cannot perform true direct I/O writes: new blocks are
> +        * delay-allocated and are only given a real disk address when
> +        * the segment constructor writes them out as part of a log,
> +        * which works directly on buffer_head lists rather than
> +        * through iomap. Fall back to the ordinary buffered write path
> +        * for O_DIRECT writes.
> +        */

Also, regarding this comment, following Christoph's suggestion, how
about simplifying it as follows?

        /*
         * NILFS2 lacks direct I/O write support; fall back to buffered wri=
tes.
         */

Thanks,
Ryusuke Konishi
