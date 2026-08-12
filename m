Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE0453A54
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547240; cv=pass; b=lWQm9kf4CYDU4NYsKJlJ97ZrP3FtnJVCYuXvz3ibyAcSPKQAcpwC0xxXk608RHjZTILVitSCA2Vn71Zp3p2vwCtKBbYVHrPUZr3OG0xMtMUMigykbQpSeb7v51ZwroRGVOhexnTAQCUu1ZWW5qWQ6ErOXRtc6rLrnc6cg7OYU1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547240; c=relaxed/simple;
	bh=SlZLfgo1HzckHxM/PmeaQG3Wasnf7U+/Me0RJrjBNFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npLZ7S+PTALsP55TZl42/JsX0QRJCy4hG5Wfz6Rg4zD3RzjR9g43oZfzO6zY89suo8U4gSAEiyiKJHycDC3iqQEcwrwqh5yM4jWdNczJ6+7v4HOslazoBSd528d/5yw6uKJFNC5h2yuK9ZQbk8Gw1McJgFTXOWDoCbCWGud/MnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwlK4ENd; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwlK4ENd"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccdf36f63dso104505ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 08:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786547235; cv=none;
        d=google.com; s=arc-20260327;
        b=Z9m9ukb6lsb6nMAEnleAaflLyf3KN5lbhVuKcyn3NCnvd1GG/+Dd4bqCJbDZCddAIS
         O5Dawt8trLJ40bRQsqNtEM2tZN9PoUS8ysmOc2oNUgaUDSQlfK5fUMSTgnIitAhuOjew
         fQ0LEDj8ucoX6g/5WX4BIFjEVe9d5ew3z2W1kcH3hKOtwv509aoLwjTWGboMC14HEblp
         uGIEfF5fHtV1SP7lJ6ojQKZ9PB6XbV951+9kftUVLMDkVTOoeeEuJQbGmfj6Prk73/Om
         wKBzMQYr/CvQEmWgSyHoBKfb2iqYoSfEyTlYJUdqFPEX0v7LT5slpCk1PVOK2lZHhLbB
         KZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NzGKVDxszs1TFSJeo9cTD6Uf/WnU6D5XOWsHATUWRrU=;
        fh=mg2vpv0tgDcHFaCg0440g/VNaqTOTl15qNZz5oENon0=;
        b=ZtNYAW4A3BEQZCRc+hByEEcc9qg3LG8gnI9ZokPgyqnEawYME0uEv/m3cjZEg422dm
         iUPbXnhBKVwwtLArRAZ1t3p4BCebSqSZld9AfIxSmbgsUnYLpn6ZerfS7XG/vg4CziWE
         wx/dBwlGvSS9Dj8Jzflm9uVb0lSrp3FrhiMfOT+yYcSWCmiSaLAopXEuAMonJlv8oRnZ
         7HMWhIB/mnfIKGM5cwGHc1/PYnb+aXR9cRMG5bYqd+JSqFfJlT5x8zLoYt2LiO+TAbJ/
         6iRtxjt93IQjPVMl4HwVqrpTG8sBL+p0X5nDdT4nK8bOWcryDDUgKDmjcOHzZHtXyQZQ
         43Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786547235; x=1787152035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NzGKVDxszs1TFSJeo9cTD6Uf/WnU6D5XOWsHATUWRrU=;
        b=gwlK4ENd0x2vm/rFCZRyFGOAH7ERE0vZ02mvr8BH4fttzgrtTCscbkWr8xOtdGeviT
         /YM+GAOvZOnNkOAMJNQTojtjoWEOI0cRkmJtGeNhfH0ol7KlrQIGknZGzCeBqvh9FSyP
         7+o0zr5flbUk2Ep56wTOugKmABrf1KND6zoj+FYHD5h5SeFM5mX8umpbRpGvb8nhESCZ
         AjW6MKXY+dnfeva6YIUX68xoiX6w0CCXxQixvOnHjp55Xl2na16H/NaK3pvdZ8lXikjq
         fOLQ3iyyaB/KQRz5spmV5gpiQ+Fc51kGJD8DJ+dryzYhBODT7u7QxjUJE24KiP2T/++t
         1M2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786547235; x=1787152035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NzGKVDxszs1TFSJeo9cTD6Uf/WnU6D5XOWsHATUWRrU=;
        b=CHnr3Ay83qfXbARx/8oh2bg5DYpXfLel5F6UgJ1XHO/movPZlhkE0Sg/bPjGryDaym
         cD5pudYBRvMRA+D/sbCHL7fbXMW4GO8cbrUX4OkEyZ4HUCLFry54VAunSntvNRf/eEo/
         q6lat7dOZQ2ugDuEuMQMBTjlyhayg0kdGoECOF5P7HIKicqdGfTtprsJKaXR9ejjwgNx
         soAa/130AiSeDAxmt0zIE7Z8PFul6lgmMMrtxQoPlaGv14zV8hot/6vNlyoYShadJ0Yg
         Zf28/obaFL9H+uYlAzqawNU3o8gKVFbAlyKTJs4rT7VP+cI5ez4UIW5/AKmDHXgwBNsm
         eNTQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIr4G0sqSHQ7cq9J7gwvSUzxvFVwIn57152IR7In4XecFBqQxSXQ0M8SPxQ7ZhVqFWX3G71z9wOWDhA9vh@vger.kernel.org
X-Gm-Message-State: AOJu0YyBcPOmH4iAljJdldLz2BF3jBp0WH8gIcf9BJ1C/NdLKybWVIpa
	BhT6ICupN3UbjVN81SBjqyYEi4akdmLxBuq3P3fIpCiW26D2Zc25WFPD3utbe+YX67xG+Zabe5N
	MM93WDycjF7Jrbxs/y+/qONGZXELwRywXqpq/jtAj
X-Gm-Gg: AR+sD128h4Ui9nJwNgfGkJIgG8APMvFKRbsIm6mYwi9C9BzrQGugUfBSEEzR88EL9GV
	Wa9sNj2XpAYy6q+EwYqtSFq09fx/kNEbEPnz8Zh9RPSbvfo/XqgHtQ/W7UkSTAHxmS6xDftzLhB
	FcTtF6j7OpJxKQO2YyMBtoxxMDJxkK+5ufYE1RIOv4XbgmZbK0eWs5HdWSXKNnIxH5UGBitL5ay
	67M/E7iTsMHxo3ONyJABPIAeAlStif+3IfmFyYi6aoYLfbM0DUFz4K8AGR8Xz+qPmZjQ0m4GrU0
	ilKn+TnAoM5zaYQZ+uK8pan1YjIEdN9HsfZL0v8obVKthEjnQG+Z1rOoETQdB617vDlmmiXjvhx
	ezFfpGSQ7P1pLAbgU9nkZr0wpW827/I0=
X-Received: by 2002:a17:903:390c:b0:2c7:b1e7:501e with SMTP id
 d9443c01a7336-2d34aa35d46mr6961565ad.3.1786547234173; Wed, 12 Aug 2026
 08:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810204118.1981755-1-morbo@google.com> <20260810204118.1981755-3-morbo@google.com>
 <202608101713.34DEA00E9D@keescook> <CAG48ez1VBBkukXH17RRSnAU7rMu0St5x59rkTDVkcMebxuS4-g@mail.gmail.com>
 <202608111721.06C99CDB58@keescook>
In-Reply-To: <202608111721.06C99CDB58@keescook>
From: Jann Horn <jannh@google.com>
Date: Wed, 12 Aug 2026 17:06:37 +0200
X-Gm-Features: AUfX_mwt37BvXoWFUv-1vDnfuxc4lh2srUqJYKBk3og95OdTzVrG071DbNykp8Q
Message-ID: <CAG48ez3R+WKhcoJMTbQpkO+62eSDn_1bSLw3ZUhgo5dX4SJG=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: Add KUnit tests for fdtable
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 2:22=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Tue, Aug 11, 2026 at 05:42:05PM +0200, Jann Horn wrote:
> > On Tue, Aug 11, 2026 at 2:16=E2=80=AFAM Kees Cook <kees@kernel.org> wro=
te:
> > > On Mon, Aug 10, 2026 at 08:41:13PM +0000, Bill Wendling wrote:
> > > > +static void fdtable_test_alloc(struct kunit *test)
> > > > +{
> > > > +     struct fdtable *fdt;
> > > > +     unsigned int slots =3D 64;
> > > > +
> > > > +     fdt =3D alloc_fdtable(slots);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt);
> > > > +
> > > > +     /* Check that max_fds is set correctly and is >=3D slots */
> > > > +     KUNIT_EXPECT_GE(test, fdt->max_fds, slots);
> > > > +
> > > > +     /* Check that fd is allocated */
> > > > +     KUNIT_EXPECT_NOT_ERR_OR_NULL(test, fdt->fd);
> > >
> > > Nice to add these tests! Can you add one for each of the conditionals
> > > in alloc_fdtable (e.g. ENOMEM, EMFILE, and the power-of-two rounding-=
up
> > > logic, etc)?
> >
> > Wouldn't tests for stuff like the rounding-up logic get into
> > implementation details too much, and break if implementation choices
> > change?
>
> It seemed to me like we'd want to notice if that behavior changed?

Why?
File descriptor tables are often power-of-two sized, but they aren't
always. That is an implementation choice that doesn't impact
correctness, it just affects performance somewhat. So I don't see what
the point of a test for this would be - it seems like it would just be
in the way of making changes, a "Change-Detector Test"?
