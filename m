Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768C41CB4C
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575585; cv=pass; b=jPZ46naOH8QcpVHk2JqZZc+LF/NwNHsO9Nr2eY35EZo2SCEDWwseknbWmwwaBVg/8wQKlZYvmhtOMlqW6x63aYGh3IRC1Tw8bf8q6IL7VD28IVnoGgZw7Amm5/q2QdggU809Xf0sBfDcozi8Skst9SwEDoNccTHwtskijaRU9aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575585; c=relaxed/simple;
	bh=na8JIQo75Pdth4y82rNFxeTKyWYOOf3LctSL+0RAXJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTM7vCNAzqTcjy3y5S/roCieDMss/SVNYw9ZEKP8f1pYVxCUtjpuBdVCqrOsZbWHgITQv+mvpAY2wImV8vK5unXO69KyekEnqg+yEKQv0r2G7a6VsbwSW6bmy9ZSc5n+etbr7CIrb2B2MB5wyAOos8G2hBq7WYr68ztzjysKdGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wtgu/cLJ; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtgu/cLJ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so5123930a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 05:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787575582; cv=none;
        d=google.com; s=arc-20260327;
        b=b4Da5YfFrVk6KZZEcNjg1Gy7TC5wHDaZ2doG2o83seVAu6Dk4DKINtCqL5mEWgfYKn
         SbF+BYayAWW1z9jIPYMdwWFC8Rp8ZeJi23YNL7nx/myqgGtYg7sRftI3/UIbfmzxN1vX
         nTem2VuWsiOLP2k4FyWaoWzkSDpFDSaWZZrchoRW7RlpYn0WWh/k6/Yl9j/SQunwgK5/
         P3GRvS4HE8vZMXWCcvoZhvXSrKfAUlxLjxTuhqY5QD44vSRKKFYw/cUSjGawe03mdiIW
         Wt09veBqe1WlJVTn3THlX9HoW4YggPQ6CBg8yJl8NQ/bFaSSUtD8QTv2CbrArLMLtwDO
         SowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/VypvkIcJcp7e/WBgYqncsZyzB3T37OpxbL4nvoiDJU=;
        fh=D3iNSQsZtR1bvz83siMFKHOXyDVKkNTrjFfX22+8A7c=;
        b=ZeRm4dtrFIM0kxQOmNZxzKC/NtR+hU7gYqoLoHDj0O+yTvOjKvwnYfsgy7l9OPnyPm
         mZvFo/L0TCXPxT5g3kqSqAdk3vOztysNoCWTNqWW7EoQk28E9a+YRumz7+1mB2HoLvRF
         8Ksmup0hnA8rohB5i172DbVghcIa2XBDrdP7mEnuPAWMjs6dBk/FQvRb6r5odvEdkFSC
         kve6lKLqGBYt186vODkuWHaCMn2xyR8JgOKAMwKZ/lzGM9vBLEVDAFPb4bDSgd4BqHEp
         GfQvY4+RNUIZ55o7U2ZYhWqEw1IsNnySZEpZZsZNsnOFodnJcjd5tZ/FEs4fcDpklLGg
         DDMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787575582; x=1788180382; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/VypvkIcJcp7e/WBgYqncsZyzB3T37OpxbL4nvoiDJU=;
        b=Wtgu/cLJY8viz6pUVKSsXFQFEKIwOqnnN8fSbTrdAwaooIItY4lokfK1PkEbFgyXsi
         ug77jG4wGcopDpD3DTRQvnMdir4oHF8V67I9C1ruR47wBU6wF9gG0Red2qX1iJyvKiAo
         KkX2kSiO8+9WIiaKJF7Warj1/93Jh01g9kycDIrgAKPNU4bMaQf2NRoe/w036TuATmrQ
         1nnjou1z6DfRgcC/esTbR1pJMYoKK/VxNpEm2F5nbrGgKD8UZRaOkElCnrOeC2/j5A7i
         4NO1nVOmg7NgCpi/tA0UJh/h8onvpka3HevqYqlIye7Sfk/3xWAUbs4KghfDzRZaS1U4
         uRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787575582; x=1788180382;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/VypvkIcJcp7e/WBgYqncsZyzB3T37OpxbL4nvoiDJU=;
        b=aziDC4cb7ZTMBk4O8K3AOHENaOfPcZqPyFjd5Z5GOFh0M9yzVVlG8kHmaDaMEqXySt
         lgiI7jsgLMFuOCiyiCImwiuhPj+B18NmIEIEqvtOEVf5BecEvageQWIphyQL+cH1BoTq
         IuaXWlsOCvWtU9akJWnIAxzlvan5Z4QezLFnbX7o5Gm3BmsEq0Y5SattIrk5q5vUsN/j
         +PxnVU/gSVLXzlWb8V4NceBuzY/3YbJ9/kgi/kEjoS3cjs8wTSMmRdizlvXtGTMC+x1+
         ZlPK5/8zoMogmBJZqzn+MH5vPDkt02tNyF1RKV8ZuzXSWXuFguX6PPqZv/77AVyLlu3F
         1qKg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2N28G0Ia9RoXFpbnh5uiLUtFlzAVUqX+6j+LZ7rbmelLDe9pPMip/Cfn7r9QbjNXHwEoh9nkAjU+HGQi3@vger.kernel.org
X-Gm-Message-State: AFuF++lIjqS6R/utcZExdGsmlFAp1UuaG0ecGrYnuOr0afM4e1wZiI6+
	7QYOzzTkn+09GBtBTQywCHLcP53evULqBb82B5SCOpDZa/JJKJlFLHZWs/TCZ9pBIbU5ofpSxuW
	l2kDqWlpIv1pdC9O7S7emkKqrFARnIBY=
X-Gm-Gg: AR+sD12h0cyJCJDCgE55i8Tyr0uSHR4IEiwHonv3t8Bh3GvGAQ5321ReKgMOajznnyD
	PlTVMA0mRf7cQTsDpmKvUYmyhde3frUznf6t5LBleqO0uguP5FXMmhhZZCDabWsH9Wy9uioi9kB
	V4PWppSr1nSeZXYXvJrKzSdC4j2Q2sw1bSJwikAEU6kdQCUlAblp+2chlS5IDvs4dTPd9JVBoth
	LvTCyQGw/UBaVugppIO/g3V85EUp2SjDsROJ3Fyu7No1VhEvASOXfgk6oXwrWBLmMeUBquigiau
	e4TVC+IiCX0YbY1siVWR8QjtzERnTYSnIrgENiduf7bSGg==
X-Received: by 2002:a05:6402:e09:b0:69f:fa13:ed3 with SMTP id
 4fb4d7f45d1cf-6a42f229682mr31280179a12.16.1787575581425; Mon, 24 Aug 2026
 05:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026082150-autograph-perky-e3cb@gregkh> <20260823224256.2724025-1-fahad@codepure.com>
 <CAOQ4uxjhfpNVvoVrTayj46H2CViTOc3oxzM6xdb8+E7ikE2CSA@mail.gmail.com>
 <CAJfpegt1WinKmP5nOGv8Yx9VLf4Mk1ojg7e3xR5iUz=7yDAh0Q@mail.gmail.com>
 <CAOQ4uxj+GRa8CaCONwPQzLCjx=R8MRr6PTYYC+QW7VrK0PEhMQ@mail.gmail.com> <CAJfpegsVoUyqy0dYkTvBGRZvgdv_nmzmCw_uF+LP-Vq3EhEkSg@mail.gmail.com>
In-Reply-To: <CAJfpegsVoUyqy0dYkTvBGRZvgdv_nmzmCw_uF+LP-Vq3EhEkSg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 24 Aug 2026 14:46:09 +0200
X-Gm-Features: AcwNN1WWxmYJPrVM9Ge5X6sHe7OCCLwjKJKIFqRT9clkb6H4QXavLQpEQacWmu8
Message-ID: <CAOQ4uxhX_neohTAjZDOT0oSWC-JNiqNWqnfE5YSa7Ln05QPQ-A@mail.gmail.com>
Subject: Re: ovl_copy_xattr() can write uninitialised heap into the upper
 file's xattr
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Fahad Alharbi <fahad@codepure.com>, security@kernel.org, 
	overlayfs <linux-unionfs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008a79c60659ca5f1a"

--0000000000008a79c60659ca5f1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 11:49=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Mon, 24 Aug 2026 at 11:30, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > It's not really a retry loop, it is an opportunistic buffer auto grow
> > loop, see
> > e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")
>
> Ah, okay.
>
> The logic is too complicated, though.
>
> I'd still go with a separate helper  that gets passed (..., void
> **bufp, size_t *bufsizep). Single caller of ovl_getxattr_value() can
> also be converted to that.

OK. something like this?

Fahad, can you test it with your fuse reproducer?

Thanks,
Amir.

--0000000000008a79c60659ca5f1a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ovl-fortify-ovl_copy_xattr-against-underlying-layer-.patch"
Content-Disposition: attachment; 
	filename="0001-ovl-fortify-ovl_copy_xattr-against-underlying-layer-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mt78bqic0>
X-Attachment-Id: f_mt78bqic0

RnJvbSBiOTgzYzJiZTNmN2Q0MDRiMzYyYWE0M2RmZDRmM2M2YzJjMjllZTgwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBNb24sIDI0IEF1ZyAyMDI2IDEzOjM4OjI5ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gb3Zs
OiBmb3J0aWZ5IG92bF9jb3B5X3hhdHRyKCkgYWdhaW5zdCB1bmRlcmx5aW5nIGxheWVyCiBtb2Rp
ZmljYXRpb25zCgpBZGFwdCBvdmxfZ2V0eGF0dHJfdmFsdWUoKSB0byBiZSB1c2VkIGZyb20gb3Zs
X2NvcHlfeGF0dHIoKSwgYnkKYWxsb3dpbmcgdG8gcGFzcyBpdCBhIHByZS1hbGxvY2F0ZWQgYnVm
ZmVyLCB3aGljaCBjYW4gYmUgcmVzaXplZAphbmQgYnkgaGFuZGxpbmcgdGhlIEVOT0RBVEEvRU9Q
Tk9UU1VQUCByZXR1cm4gY29kZXMgaW4gdGhlIGNhbGxlci4KCkNoZWNrIHRoYXQgdGhlIHNpemUg
cmV0dXJuZWQgZnJvbSBnZXR4YXR0ciB3aXRoIG5vbi1OVUxMIGJ1ZmZlcgptYXRjaGVzIHRoZSBz
aXplIHF1ZXJpZWQgd2l0aCBOVUxMIGJ1ZmZlci4gSWYgaXQgZG9lc24ndCB0aGF0Cm1lYW5zIHVu
ZGVybHlpbmcgbGF5ZXIgbW9kaWZpY2F0aW9uIHNvIHJldHVybiAtRUlPLgoKUmVwb3J0ZWQtYnk6
IEZhaGFkIEFsaGFyYmkgPGZhaGFkQGNvZGVwdXJlLmNvbT4KU3VnZ2VzdGVkLWJ5OiBNaWtsb3Mg
U3plcmVkaSA8bWlrbG9zQHN6ZXJlZGkuaHU+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LWZzZGV2ZWwvQ0FKZnBlZ3NWb1V5cXkwZFlrVHZCR1Jadmdkdl9ubXptQ3dfdUYrTFAt
VnEzRWhFa1NnQG1haWwuZ21haWwuY29tLwpGaXhlczogZTRhZDI5ZmEwZDIyICgib3ZsOiB1c2Ug
YSBtaW5pbWFsIGJ1ZmZlciBpbiBvdmxfY29weV94YXR0ciIpClNpZ25lZC1vZmYtYnk6IEFtaXIg
R29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0tLQogZnMvb3ZlcmxheWZzL2NvcHlfdXAu
YyB8IDY0ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDMyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2ZzL292ZXJsYXlmcy9jb3B5X3VwLmMgYi9mcy9vdmVybGF5ZnMvY29weV91cC5jCmluZGV4IGU5
NjM3MDFiNGM4NzcuLmVlZTIyNTgxYjE0ZjEgMTAwNjQ0Ci0tLSBhL2ZzL292ZXJsYXlmcy9jb3B5
X3VwLmMKKysrIGIvZnMvb3ZlcmxheWZzL2NvcHlfdXAuYwpAQCAtNzIsNiArNzIsOSBAQCBzdGF0
aWMgaW50IG92bF9jb3B5X2FjbChzdHJ1Y3Qgb3ZsX2ZzICpvZnMsIGNvbnN0IHN0cnVjdCBwYXRo
ICpwYXRoLAogCXJldHVybiBlcnI7CiB9CiAKK3N0YXRpYyBzc2l6ZV90IG92bF9nZXR4YXR0cl92
YWx1ZShjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCwgY2hhciAqbmFtZSwKKwkJCQkgIGNoYXIgKip2
YWx1ZSwgc3NpemVfdCAqdmFsdWVfc2l6ZSk7CisKIGludCBvdmxfY29weV94YXR0cihzdHJ1Y3Qg
c3VwZXJfYmxvY2sgKnNiLCBjb25zdCBzdHJ1Y3QgcGF0aCAqb2xkcGF0aCwgc3RydWN0IGRlbnRy
eSAqbmV3KQogewogCXN0cnVjdCBkZW50cnkgKm9sZCA9IG9sZHBhdGgtPmRlbnRyeTsKQEAgLTEy
OSwzMCArMTMyLDEyIEBAIGludCBvdmxfY29weV94YXR0cihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNi
LCBjb25zdCBzdHJ1Y3QgcGF0aCAqb2xkcGF0aCwgc3RydWN0IGRlCiAJCQlicmVhazsKIAkJfQog
Ci1yZXRyeToKLQkJc2l6ZSA9IG92bF9kb19nZXR4YXR0cihvbGRwYXRoLCBuYW1lLCB2YWx1ZSwg
dmFsdWVfc2l6ZSk7Ci0JCWlmIChzaXplID09IC1FUkFOR0UpCi0JCQlzaXplID0gb3ZsX2RvX2dl
dHhhdHRyKG9sZHBhdGgsIG5hbWUsIE5VTEwsIDApOwotCisJCXNpemUgPSBvdmxfZ2V0eGF0dHJf
dmFsdWUob2xkcGF0aCwgbmFtZSwgJnZhbHVlLCAmdmFsdWVfc2l6ZSk7CiAJCWlmIChzaXplIDwg
MCkgewogCQkJZXJyb3IgPSBzaXplOwogCQkJYnJlYWs7CiAJCX0KIAotCQlpZiAoc2l6ZSA+IHZh
bHVlX3NpemUpIHsKLQkJCXZvaWQgKm5ldzsKLQotCQkJbmV3ID0ga3ZtYWxsb2Moc2l6ZSwgR0ZQ
X0tFUk5FTCk7Ci0JCQlpZiAoIW5ldykgewotCQkJCWVycm9yID0gLUVOT01FTTsKLQkJCQlicmVh
azsKLQkJCX0KLQkJCWt2ZnJlZSh2YWx1ZSk7Ci0JCQl2YWx1ZSA9IG5ldzsKLQkJCXZhbHVlX3Np
emUgPSBzaXplOwotCQkJZ290byByZXRyeTsKLQkJfQotCiAJCWVycm9yID0gb3ZsX2RvX3NldHhh
dHRyKE9WTF9GUyhzYiksIG5ldywgbmFtZSwgdmFsdWUsIHNpemUsIDApOwogCQlpZiAoZXJyb3Ip
IHsKIAkJCWlmIChlcnJvciAhPSAtRU9QTk9UU1VQUCB8fCBvdmxfbXVzdF9jb3B5X3hhdHRyKG5h
bWUpKQpAQCAtMTA1NSwyNiArMTA0MCwzOSBAQCBzdGF0aWMgYm9vbCBvdmxfbmVlZF9tZXRhX2Nv
cHlfdXAoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCB1bW9kZV90IG1vZGUsCiAJcmV0dXJuIHRydWU7
CiB9CiAKLXN0YXRpYyBzc2l6ZV90IG92bF9nZXR4YXR0cl92YWx1ZShjb25zdCBzdHJ1Y3QgcGF0
aCAqcGF0aCwgY2hhciAqbmFtZSwgY2hhciAqKnZhbHVlKQorc3RhdGljIHNzaXplX3Qgb3ZsX2dl
dHhhdHRyX3ZhbHVlKGNvbnN0IHN0cnVjdCBwYXRoICpwYXRoLCBjaGFyICpuYW1lLAorCQkJCSAg
Y2hhciAqKnZhbHVlLCBzc2l6ZV90ICp2YWx1ZV9zaXplKQogewogCXNzaXplX3QgcmVzOwogCWNo
YXIgKmJ1ZjsKIAotCXJlcyA9IG92bF9kb19nZXR4YXR0cihwYXRoLCBuYW1lLCBOVUxMLCAwKTsK
LQlpZiAocmVzID09IC1FTk9EQVRBIHx8IHJlcyA9PSAtRU9QTk9UU1VQUCkKLQkJcmVzID0gMDsK
KwlyZXMgPSBvdmxfZG9fZ2V0eGF0dHIocGF0aCwgbmFtZSwgKnZhbHVlLCAqdmFsdWVfc2l6ZSk7
CisJaWYgKHJlcyA9PSAtRVJBTkdFKSB7CisJCXJlcyA9IG92bF9kb19nZXR4YXR0cihwYXRoLCBu
YW1lLCBOVUxMLCAwKTsKKwkJLyogWGF0dHIgY2hhbmdlZCB1bmRlcm5lYXRoIHVzPyAqLworCQlp
ZiAocmVzID49IDAgJiYgcmVzIDw9ICp2YWx1ZV9zaXplKQorCQkJcmV0dXJuIC1FSU87CisJfQog
Ci0JaWYgKHJlcyA+IDApIHsKLQkJYnVmID0ga3phbGxvYyhyZXMsIEdGUF9LRVJORUwpOworCWlm
IChyZXMgPiAqdmFsdWVfc2l6ZSkgeworCQlidWYgPSBrdm1hbGxvYyhyZXMsIEdGUF9LRVJORUwp
OwogCQlpZiAoIWJ1ZikKIAkJCXJldHVybiAtRU5PTUVNOwogCiAJCXJlcyA9IG92bF9kb19nZXR4
YXR0cihwYXRoLCBuYW1lLCBidWYsIHJlcyk7Ci0JCWlmIChyZXMgPCAwKQotCQkJa2ZyZWUoYnVm
KTsKLQkJZWxzZQotCQkJKnZhbHVlID0gYnVmOworCQlpZiAocmVzIDwgMCkgeworCQkJa3ZmcmVl
KGJ1Zik7CisJCQkvKiBYYXR0ciBjaGFuZ2VkIHVuZGVybmVhdGggdXM/ICovCisJCQlpZiAocmVz
ID09IC1FUkFOR0UpCisJCQkJcmV0dXJuIC1FSU87CisJCQlyZXR1cm4gcmVzOworCQl9CisKKwkJ
a3ZmcmVlKCp2YWx1ZSk7CisJCSp2YWx1ZSA9IGJ1ZjsKKwkJKnZhbHVlX3NpemUgPSByZXM7CiAJ
fQorCiAJcmV0dXJuIHJlczsKIH0KIApAQCAtMTA4NSw3ICsxMDgzLDcgQEAgc3RhdGljIGludCBv
dmxfY29weV91cF9tZXRhX2lub2RlX2RhdGEoc3RydWN0IG92bF9jb3B5X3VwX2N0eCAqYykKIAlz
dHJ1Y3QgcGF0aCB1cHBlcnBhdGg7CiAJaW50IGVycjsKIAljaGFyICpjYXBhYmlsaXR5ID0gTlVM
TDsKLQlzc2l6ZV90IGNhcF9zaXplOworCXNzaXplX3QgY2FwX3NpemUgPSAwOwogCiAJb3ZsX3Bh
dGhfdXBwZXIoYy0+ZGVudHJ5LCAmdXBwZXJwYXRoKTsKIAlpZiAoV0FSTl9PTih1cHBlcnBhdGgu
ZGVudHJ5ID09IE5VTEwpKQpAQCAtMTA5Myw3ICsxMDkxLDkgQEAgc3RhdGljIGludCBvdmxfY29w
eV91cF9tZXRhX2lub2RlX2RhdGEoc3RydWN0IG92bF9jb3B5X3VwX2N0eCAqYykKIAogCWlmIChj
LT5zdGF0LnNpemUpIHsKIAkJZXJyID0gY2FwX3NpemUgPSBvdmxfZ2V0eGF0dHJfdmFsdWUoJnVw
cGVycGF0aCwgWEFUVFJfTkFNRV9DQVBTLAotCQkJCQkJICAgICZjYXBhYmlsaXR5KTsKKwkJCQkJ
CSAgICAmY2FwYWJpbGl0eSwgJmNhcF9zaXplKTsKKwkJaWYgKGNhcF9zaXplID09IC1FTk9EQVRB
IHx8IGNhcF9zaXplID09IC1FT1BOT1RTVVBQKQorCQkJY2FwX3NpemUgPSAwOwogCQlpZiAoY2Fw
X3NpemUgPCAwKQogCQkJZ290byBvdXQ7CiAJfQpAQCAtMTEyMyw3ICsxMTIzLDcgQEAgc3RhdGlj
IGludCBvdmxfY29weV91cF9tZXRhX2lub2RlX2RhdGEoc3RydWN0IG92bF9jb3B5X3VwX2N0eCAq
YykKIAlvdmxfY2xlYXJfZmxhZyhPVkxfVkVSSUZJRURfRElHRVNULCBkX2lub2RlKGMtPmRlbnRy
eSkpOwogCW92bF9zZXRfdXBwZXJkYXRhKGRfaW5vZGUoYy0+ZGVudHJ5KSk7CiBvdXRfZnJlZToK
LQlrZnJlZShjYXBhYmlsaXR5KTsKKwlrdmZyZWUoY2FwYWJpbGl0eSk7CiBvdXQ6CiAJcmV0dXJu
IGVycjsKIH0KLS0gCjIuNTUuMAoK
--0000000000008a79c60659ca5f1a--
