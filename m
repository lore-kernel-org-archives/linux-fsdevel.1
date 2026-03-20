Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5B364956
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997616; cv=pass; b=pyYOkHIMhfrdtKe3SQLq9MMJjkfpbEUqfFNOVFIIVzb0s4jRkquyMWYLx4EURj2vJKJ+uO0TBZ7bBPC6qsLnAn9IvxE4T4SQeFzkUb6X3QxTRskE0rzawEIg9IuO58Z8j8gLy+KgkrGSm9wHmiB84Wa+cIxiKEfwOURAOqBjlAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997616; c=relaxed/simple;
	bh=iRpkVJycTe5WJPiy8H2R6B9eTxYSfDaJK9A/9Z23n2E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RkInntulx7YcijYq1Pie+2YtCebPGkdm+0+dvqmcC8F78up+0j6MlehlIqF1sDyYE7XcTb1deUxizTe2MCfGQdNlKh969As/LLLd0ozzxsfIgUx+Gs/uTt/5SoGnXn1itNx7nEKPiOXWGCpO95+n5zWQ3ZpAgX12HCVsVHlLkqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlFzEd2V; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlFzEd2V"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b886fc047d5so297007566b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 02:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773997612; cv=none;
        d=google.com; s=arc-20240605;
        b=YIw8PiLdYpjUIG0rEVX0Pn3s0WbaMXOUObBCGY1AKVrAKGma6XD05070DeTC2T/mib
         VAf+6ttbCCmNEweUXRWFxybPI8JBLye+Q6xOUhk3o/LkjaHDw4QtiE90PtCXiblDT+5Y
         qz3k94lAmsWYjTtNtMQ9u8cf6GY7wsbkOyLWGEOjQkq5nQpXqYtvVQkZM5AXp1kNK6vY
         gAJ0tpXOZpIgsQWH9rKVIzHcuqly/2aGTWqQhtET84MFqJzWkQ9VCrCwA39W3faVwvEt
         FIO0wUvnV8oVXfyP5FvApMx1SgVrh0WYHgVE7jGzx4L2ITLKNEpGcfqBKgDRb1ZExf88
         d9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=iRpkVJycTe5WJPiy8H2R6B9eTxYSfDaJK9A/9Z23n2E=;
        fh=on5so1iZ1tYm751VXv8x5u+l+XerJy9A4qWb/XOx/D0=;
        b=dXnojvmYDKc8ZQUO6kH43Ywfa5Gn0A0hacOgZtWak2Xu659kHv0/4JOjr3CSeGITZ9
         tUNngWTQnAGPzFcw3zT7MjecnTIFYFHFwFssbnGhAob5PN+ZdzbTD4YjCa3CHLrLpMFj
         dlgGWxh8os6FOxK91E2v4mQmdzRybzaxrcbBfePGEXRg8g49VUs8VU+IJIXHwxEs9i/0
         Tu5mxjnD+1Fw2x/Sh1lthCBG0WVvzmxhlZjOjRg+bcSpWB3TZJUrxMZtIjraaLdz2qkB
         QrmGeFv+CRUeOlCRVmTWY9NBLn/Lm9/cT+PDJoryHOskrHgje/8hGsfQfYDMyXQYVJYP
         Lynw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773997612; x=1774602412; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iRpkVJycTe5WJPiy8H2R6B9eTxYSfDaJK9A/9Z23n2E=;
        b=BlFzEd2VXaN5LIxEf84yCR12bIXDFfjol0QHH7FkTQ3bRnRlQO7Rk2YVOwE8Ax/Mtj
         ABxdCRwBolPVkDwLtykGqKcMjr2eQD3Ct7SAKhxkosRIwJhVlsRqRFoJCxUHLTYRJ8ev
         ss98Ih4dbkMD5/xYunc0B2wnDXgdi+hofDP5JTkqNAqNCpI/nNls3EFa/nbdUmQ/4EBa
         pBwcxR4KU9uOXt8VvBFHC9ABTRdBiO0h+5XyanD3I0AjUF0mXuAD/vdn/VgWXBtayE6r
         jAt3EDdPKZZ0Q62qE3B2OeLtGvX/h5fED0u1KbT8RzSLHQH8AtuVx2j6bdPuum7MIeHC
         WPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773997612; x=1774602412;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRpkVJycTe5WJPiy8H2R6B9eTxYSfDaJK9A/9Z23n2E=;
        b=ie7hO6+R9apnIZr0PWwIEuvknFr3RYtoevezwYkkCFJFMsqw2cmyEXdYBw24P+Qmv/
         9emcYmt44UgPOcrJPTJbN2OeevmrRegAdyd1UiB+iDZwAyMsXPs4b9P56giedqCBix5k
         lHwbZtnWLD/YyB6E8d1KZyAK+HchDM4F2LcpGuh8I66hYXsuW9sJQcwQ8ToBDEyu23xW
         +qP0+3Wt1mko6WPsSIDS/XKsxDP7Yrf72ff4nLK0KmcUF7poiry8syvRqgd+NhOGXZdF
         yiHJTcepL45iljKuH3E37eQcWqnWb3utGwx3O6Zu2FSZQCkzoWoA74sLnoHZ34fr64Hf
         CEZw==
X-Gm-Message-State: AOJu0YzVofm8qycNT4jIq9HbiMOpi5puw8+J/QZGchR+jkXlna2Ufwqd
	JsHl39oYUscRumI/6TrylgZPGw1b/MJkelgg0SqcCe2nS93NFU4AP3Cg9suRIEB+JNk9UQIzzpi
	BEDjVhrSrHrrRAUCszymL76Ye/VJ6HZs9N44dzgs=
X-Gm-Gg: ATEYQzw5s0gKQyayWVpbGipMFs/2yl+RBGbYiyMevhys6RFIwyER4qX7ineX2aSDGVA
	4rZQbZX9ndJ2wFotY2LMK+l42VnPHZjKb0lGXqegJdoe6pJb8LtFlcdXuUqgzmkIfDHT4OcpIQP
	mVVMyMbr1+bYL048S6BY6jo2SG4zKfFkW2IO+EmpD2hktqjZPV6INDRQS6TQ00E6wYAjTciQJmI
	GwuE5qGmDcam6RefD9yfpj4+2aFsCdTUAuyf8oLQvnh3cOL1AaUYSxFb6I0vvL9zaWWFhxi1+V/
	XU2PEhhbRt55H9UuOj8=
X-Received: by 2002:a17:906:8d8c:b0:b97:ba90:edb2 with SMTP id
 a640c23a62f3a-b982f4e33b6mr148844266b.50.1773997612238; Fri, 20 Mar 2026
 02:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Raghav <raghav.original@gmail.com>
Date: Fri, 20 Mar 2026 14:36:40 +0530
X-Gm-Features: AaiRm5388GPujSelFmfLoMPzCvaR4YiOdGH0duxWj2q5GMDHNIoQgYcdn9dUhxY
Message-ID: <CABR4S-vSW7qpvBfUrARtfgc91iF=PZPQNHvd0Xc=iiK=mx79vQ@mail.gmail.com>
Subject: [RFC] FUSE: support for file_flags and birthtime (FreeBSD use case)
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I=E2=80=99m a new contributor working on improving fusefs in FreeBSD, and I=
'm
bringing up an issue in FUSEFS.

FreeBSD supports file flags modification with chflags(2) and file
creation time (st_birthtime) at the VFS level. But, these are not
currently supported by the FUSE protocol.
As a result, fusefs on FreeBSD cannot expose or preserve these attributes.

I think we need to append struct fuse_attr with:
uint32_t file_flags;
uint64_t birthtime;
uint32_t birthtimensec;
Handling them in a backward compatible way.

Is extending fuse_attr in this way acceptable? If so, I=E2=80=99d be happy =
to
make the changes and follow up with a patch.


Thanks
- Raghav
