Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B641D78F2B
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 04:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780028179; cv=pass; b=DXGUfg/sdDCDhcr429kSCb9PgdVmw5HKndg6QkkKAze8+HMGu2Z7EfiLDkE5MiVBfZd8egdPOg0f7Yo1lLRKH9a1l4OKC0ZJQf9AhicwE7ZbPupJwYMextUQg5B+q+dnzffL33YBBn2lsWXryUoCSBQuQkJy97obVy/+7SJyn80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780028179; c=relaxed/simple;
	bh=BFOKOVPme59erEMfzfDis9lCDNoZIkq0mEh7prAMf+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq/W/9RoLpb2IMQLJgTIJ2wLD/OJ+xiq0rmQvl2rN/Pxjm+93PmzVzzyTZ691IZSvk9i4YULQDWLfX7zTlMZorBW+VGNX0xXJrPLVedJSbHy4kT6bcus5hUxls7QVHvTliRQ7u/wgsfyrufkRun6qcU/KJk6T0inPGNVQ8w8LNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmS4M79L; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmS4M79L"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7ca947f9b00so132871127b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 21:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780028178; cv=none;
        d=google.com; s=arc-20240605;
        b=ZYGVkykCvGYTVteoFJ4CnsaQxBLeZfPDLfQTkPEh+PVi6fKBn+jFpTrJAOIXL142n+
         mXTLFOudL2cSMty8pa1eQve6g0qgxanp0xeAs7eAPr1XypF+HOzYZI3+GctpOSTXkn3y
         dIGXf6sziPUk3JYVXO/xCyDgb8JFJybTH+wfh2u89rDl58AkJOarnsEfHmSmoNoPVxmq
         GBVx0jgJbIRj9Xw3XOszw6qeSaWF1w2dSx1DpMxKl+QWnryCI+HhuQ4YJN55JriXQSRT
         +FGHLICHPAQlLkUV8bENxLvDq17uVukSkgg+tGq6KIrsX8lxR2e8qasEOaUdHixvHcqA
         7MbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BFOKOVPme59erEMfzfDis9lCDNoZIkq0mEh7prAMf+s=;
        fh=yTXZu0gkbGVErmG1IgBJ2Dk3A6Ntwg+KSGUaOEA2r0Q=;
        b=itTyKhOBffwJuea3lWoXcnCONCqASULt30f2kqq7LTEnDOccw2vN52kVxnZipqcQ8x
         /I7I4s9Vmy+Sprt8rhN45lFfhh0E40lShqznPNrlXHoRcT+PKM1oMqshvzGY8kAEfPmC
         biE0k6Wk0/kSTmdygZgLReF7zs8+92Q+D1aMCBAzLhQk/4J6sc0A9QN4Hm/QhnfXmAGr
         4U+0LsCQGXbMtubunxF6a0v5g17o0pn6x5NeeJNU55OA2YquFJSUOawCDjYdm4XuOrQ3
         AxISurXbxxsOgb7tPJNrB2mebTCmtyFgipCfO65fletZYzbw5YodYoUCY4vgN2terqFN
         yeCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780028178; x=1780632978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFOKOVPme59erEMfzfDis9lCDNoZIkq0mEh7prAMf+s=;
        b=RmS4M79L61XMVKcpgHFNr4U1pRB0+fNwror82veyyODMGrfR966Um6K+GxtXV7TqQn
         z25D43lc/j0sfk1OIpkCw1Rcv9W3FwHY+139d2qRYJJSArqnWj1/H4CpAreUtlkQRLhU
         bQFg+z57oMRCs73N/02ixMUM/Ok7vnejufv5HX1ID79re3HJwOkI84MZEONDBy/TZWeM
         mM1Dk87THdEDeY8vXi7U32hwSjFKEdjClebccxgQla2Bw4YQ4KxxYeV/nqN9ZGTU/vCA
         yBgk8m50XarU5Ln4Y0m39i7E66t6YM/esSMEsBbVFqPiHWpkHxeNECV2J0cJm64RtJ+1
         ghvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780028178; x=1780632978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BFOKOVPme59erEMfzfDis9lCDNoZIkq0mEh7prAMf+s=;
        b=cswwB0H6onFzKKTHIktMX39BZOJrlYPp+Yeoa7zJ0Usxvt1Rr7K5nosdBVmyLuOgYW
         9YvyOQ98Ko3GY/lx6pWLaIKPed9vji6iL1SuBu2+/5rr16pi7lucBg7lGCrUVprxofjj
         De9qMVC57hCo7gzTXOkA80+PM3B2V/nlxnvURCVETOjN3KtBGlr1ADec1Tb4cDkHZcIc
         S3hf/5d0FAnNiqJkqLpyjpQ+2/R/yOM3ztZEra8yP4IBg8FEaE3BxqYnryjk8IPhyYYR
         SIzXxVWK+94hY057XWQ/htaUzYxLzthIU4EoBgfLH0EHbwXmkwfm7j/i+xdA/Ubw9z5W
         Bzfw==
X-Forwarded-Encrypted: i=1; AFNElJ9uHqttzWV9Fo0viMiMdRvvgNriqA1SwMrm5Rm2su7JpU4W+p8pMWH/3Ch+ZBK15KkKnMxKQATTWLb8q65g@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6et99z2hes00AtOCC40hQS86GS73je+n10Kq7eIT5hFLiwxLQ
	WOHSBFxW5pl8qNiH6ik0CIIePlAdUwnvI2fVUQ2MvH4z4x0P+GftCnWm+QAFSMpUFXAyH5IsiTy
	B3eWD2itbXwOqpQqPxKhDODdYD6OE8Vo=
X-Gm-Gg: Acq92OGBenMOLbRWBvjIrPdH/QpwIzoAnv/Ihipvk9erhjYRguIbJjytqrtd6jyaYkx
	P+pyLAddmDo/n9HMW6hifcqk7mkajcpi8M/iJ9UQiz1OP6ek2YUlMCDiG3rxbhE9EmjTEZ/nMCx
	W9Xt6RBZT6hJP5SLkSMYaLijbyJIFSOgtvWP/+e15ZUI1jA6klcESN2oPWFlkj0d5TYK83fSIdk
	vufV83H5oTZLc3J8KfpD9/yxb4hjlsvmv0EUh7n/OW7IyjeEZs9S5weiWQsqOFZC5hwJIeO52zF
	QpqrAUE6jyp9v1b6Lk1FjVtdST8OtG/CejV3pZo5gFmNTlxRTKA5lgCmMsEu2EmnAyY358PpQS3
	d6mkcp0I=
X-Received: by 2002:a05:690e:140d:b0:65d:7d86:7758 with SMTP id
 956f58d0204a3-660531221admr668197d50.59.1780028177828; Thu, 28 May 2026
 21:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523091107.61880-1-kartikey406@gmail.com> <20260528-wendung-vielleicht-klargemacht-27241ff15b32@brauner>
In-Reply-To: <20260528-wendung-vielleicht-klargemacht-27241ff15b32@brauner>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 29 May 2026 09:46:06 +0530
X-Gm-Features: AVHnY4KK8przQseq03FTociD-OXXQ0jatvgrHWgeFxIX1HcBmGGDY7pqdtc_gEU
Message-ID: <CADhLXY7O=JSZAGZ-B8Ozq-vAUCPAmpZZ1Q_iX8hxsFychUpbEw@mail.gmail.com>
Subject: Re: [PATCH] eventpoll: fix use-after-free in clear_tfile_check_list()
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 6:12=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:

> Better than the other fix but I'm really confused about this define...

Good point =E2=80=94 EP_UNACTIVE_PTR is already the sentinel used elsewhere=
 in
this file for the same kind of "inactive slot" semantics, no reason to
add a new name.

 I'll reuse it directly and send v2.

Thanks

Deepanshu
