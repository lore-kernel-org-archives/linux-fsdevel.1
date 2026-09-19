Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C4035C1A6
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789829085; cv=pass; b=F/18c9+6t6Xa0rMGS0orgMgIigikRPZCHbibnOJpGPoV6TgusHr5SCSH5/xt/+MOMItFeGvsfj2hHHDvJ0bgnJ/0iioXlAG7oLCFX4ngV0mr47hEmld7Rn/kA4Czw33jhFMtGlZrr0/MQuVmN/daGVaFmapWggLjD37x+uwELYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789829085; c=relaxed/simple;
	bh=SEEDrnoYh0mOnGCpCP8AW5s7jRnMWmh4+4NV544y7SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+mMLz0HJZh4UfKka/w1M8vd9RF3REkqXTt2LicOzM86MSauh7QiP3jggE2vlhsPDHXWowXUTi9zFHDzypmdMFD3Hqlskl+KMIHK/L/hUDuVUbrOkFiU7o57i23ShfZ9MbPRWeEGz9AxFbiq/JfNPFIjq3Xf0xMNwalNbv//qcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thechris.in; spf=pass smtp.mailfrom=thechris.in; dkim=pass (2048-bit key) header.d=thechris.in header.i=@thechris.in header.b=M8T8bq94; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thechris.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thechris.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thechris.in header.i=@thechris.in header.b="M8T8bq94"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d4ddd179eso13653937b3.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 07:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789829083; cv=none;
        d=google.com; s=arc-20260327;
        b=Q8/RbaYS3zOZDQM2Lh1iCtdpzaNTTV9WYxuoD/uYkfVYxV0KlCGYEuFWKs255Cst9w
         rGsFYw7mY77Lb5dLcdSTf8ZIEd5O0fYwgViJg49qqu4x3wRBjVGedZlhKhRSSi19lkFi
         oBreAT1U+HrGA8WcEZE3upq36AcqF1U5HvyWllBUoB7DhVm5XhVUgwoNG6g0nlkpIT1w
         brFmoVCE91+fSVCjJNlGVr+3uIsFynfXrrjN6XzRA3QJdCJscEJnjQJlYkhETbFaC2zy
         8WPzJIZplvVEREFtZNUt5U2blzG+MMS2SvfSExRyg6LGNGrKTlxw1MDpQEnYVJ8T6B6o
         fWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BaTMOAzAK//5V3+VmXnptDmlkQpvBCAoWeySpIAKihg=;
        fh=8nbD7i9m47dRfM607NB71LiV/6m+c7DTf8oxdCrVLVQ=;
        b=OK23U/BV4I/4EjdWK22+LqVFZD110kfw14ETnM+rhE/l+5Y3C7zsfqmjCp3Vvp8r0j
         qQ91Xd2Mvvc8SrMEDQFhQ/AIZjcZ+MFdDpsfXwst8Gu6D6cQK8pvQwJnys+6Fonu/b1m
         fX0vLdR0Vy1K35NqBqB2H0T6T9UPWgfUEHAYj+vGBbJhoiVe1Gs0bifIBKKFyBVpXMyG
         cSj0Z3mdXdr9Cx1+/n2GP2klML4SJbRHFr7CyGa8AW6L9x6swKsoZzlml3m1lIyQlNIz
         FfroYk5M44NXQruhTwYU+R2PnJ2xk5rPJGm9b56xy7N3c03PHEDXasXaaUn5LBGat8UO
         dDfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thechris.in; s=google; t=1789829083; x=1790433883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BaTMOAzAK//5V3+VmXnptDmlkQpvBCAoWeySpIAKihg=;
        b=M8T8bq94Zy4wB+w1MJE8Lc9Dgi/vIjcvW/tPfyMErJqHNQW4v8PFhhDFH+QfoIDhvO
         hD1W3kqYUCxZmLkMD1oDeXzj12Yel5O9YwLU3ZEhIP0UILWXnLN8VvecWg22ujd98jPB
         2mCjFMO/W/KebI2IHmiKUgVNdPFERsDebcXrv/+vjI0v/3zkWYSJcJcy54muK6eWzNgL
         YnJTwgVCgNM29vQwfJwKLzIzcrOlUMVRF1dsn1H5kG/8TnfTCTo7ZWC0UK53fJSO41Ix
         MnwR5C/0LpU4tYVzIhZWU9f8s6CRaDskdZAgCel8KL2wF30z4KyzIEt78civbA0ygnOB
         otYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789829083; x=1790433883;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BaTMOAzAK//5V3+VmXnptDmlkQpvBCAoWeySpIAKihg=;
        b=XAuEUrTyzR6gCruhodvEuCmeLMqLtNTJNG5ZokULJ77ZIP7Tbc+e9An6KxxWv5b5Ip
         aBYGz8VKgPdcuqb7v8RAWL0johkdMT/oE3x0SWj+T2xwZVDkmVOhZGMMrHrLIlAowW1z
         OmkdYIThmc63DrU7kxX5Y9c7OW6iIv9yNPRxMvYsgQs7XWCeMkZSJIboH8nPDlIO6BlH
         lqWex0F8VxoRH9UrPAoDu15UF5GR5EvntM+aXyspVkMcP0j1F7/ib2Hj/4sZPpRjjNJc
         vwx2KDj86jy/Efadv53me9hD7TWaVxVaS1egC3AYQxIHuHq9WEBPvp3NrcBNJtdPeFf1
         QM8A==
X-Forwarded-Encrypted: i=1; AKwUvBwOMdbvn30hSME9xtPlIKs833aDCb/Tzob4ruYj+A0GeEaKldEib7/TZ2MAWM+mOyJP0EOiTCpryRnQ9ANx@vger.kernel.org
X-Gm-Message-State: AFuF++k7aaAZt7PCbCxifZ8ulTIRKup7UUYsH+xO5qmVm10bL+qG2ng3
	Qo5FA111oUnBaZOgZwULPBTk+5E7GxcKTgUHYtgerSRCd/8DmnNnmkciYRmstRn2XQSUUcV7ZAu
	fKQYHJkaLLrU0HrbUYipvp1G+s1AkjUCi8MiOmfWX3Yw=
X-Gm-Gg: AYBFou2RgKHfG+GYnSXafsH/CAx9KI1c6RWB6BmcmQJyrhp2ZltBA4IIn0Ac+K6Ai2V
	rnMa5eoPNV7/MtHGOPZt5IJAW6mkpk+ClfZ+4J4O/oX33Z54MH7vJUFDq1g59iaJjpwXER9vSA0
	eCevQUB6qEI+6bm49thr49D4jmjBAN9IceGESia873CER2HOS9bR13zCjBSRAyvdlMtW0/iuBBJ
	OKdotlqNu1N6yC+QA5daZxumvmnzRu0mlgvngUOlETA9J9S90sRy8XXJMUoUCuAKExvNDMfIVkM
	eL4D5N8mB1H9FtIOtLB3U3waiujxFgXIuIdUkk6ge0+w5VK/EOk2j+fKn/193eAIB9ov5qSCRUu
	7wXSgd5XvSnvwAqY1IUp+1uL2OhiRXgq9C/1DaxHQt+XORLOD4t0yUTSWwHaCfZ3f52+2ttZ2dE
	nD9nfleDUrV0yLWi0=
X-Received: by 2002:a05:690c:e685:b0:89a:63da:cbe5 with SMTP id
 00721157ae682-89a63dacd4cmr7313797b3.43.1789829083163; Sat, 19 Sep 2026
 07:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE2Bdm3NuEHshrG6K2boKAnCQUvT5SX79cP9nPgS2s1afzY1hg@mail.gmail.com>
 <6aab0f82.e91c2013.3bdb06.0009.GAE@google.com> <CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>
 <2026091753-broadness-bootie-b683@gregkh> <CAE2Bdm14hif17B8RTAE+PhWEps5Fzh=WPurZeSNp9C6TqCKumg@mail.gmail.com>
 <aqwuWWMwdIcx3704@cashel.logfs.org> <mu82xsi6.76ee613a-07fb-48b1-9336-99e8780e8b6e@nod.at>
 <aq6afmdN5DYpuUa2@cashel.logfs.org> <mu8hfoxj.7ce5e90c-076c-4b73-813b-f9c60310ddab@nod.at>
In-Reply-To: <mu8hfoxj.7ce5e90c-076c-4b73-813b-f9c60310ddab@nod.at>
From: Chris Roy <iam@thechris.in>
Date: Sat, 19 Sep 2026 20:14:31 +0530
X-Gm-Features: AcwNN1VVdZq_i5--e-uskgSmXVQpAASq_eAqaNA9x5LP_XOGGCjlgNcTays_lsQ
Message-ID: <CAE2Bdm2UA2UTkYY-w2qxLaXWjnujTkOoC2mS+WXu7McZV2MyeA@mail.gmail.com>
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
To: Richard Weinberger <richard@nod.at>
Cc: =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@barelysecure.org>, 
	Greg KH <gregkh@linuxfoundation.org>, 
	syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>, dakr@kernel.org, 
	driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com, linux-mtd@lists.infradead.org, 
	miquel.raynal@bootlin.com, vigneshr@ti.com, 
	Adarsh Das <adarshdas950@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026, Richard Weinberger wrote:
> While we're here, maybe it's time to add a decent configfs interface to
> this driver instead of configuring through module parameters.
> That way also multiple instances are possible.
>
> IMHO testing is the only use case. I use it regularly.

I would love to look at this if you think it's worth the added
complexity. A couple of design questions before I start
on anything:

- Does configfs coexist with the existing block2mtd=3D module param
  (for early-boot/cmdline compatibility), or replace it outright?

- For multiple instances, would a configfs group per device (backing
  path, erase size, label) match what you had in mind?

Can sketch an RFC-style doc once I have a sense of the above.

Regards,
Chris

On Sat, 19 Sept 2026 at 19:58, Richard Weinberger <richard@nod.at> wrote:
>
> Am Sat, Sep 19, 2026, 16:22 schrieb J=C3=B6rn Engel <joern@barelysecure.o=
rg>:
> > I added Adarsh Das, who also attempted to fix this bug.
> >
> > On Sat, Sep 19, 2026 at 07:42:25AM +0000, Richard Weinberger wrote:
> > >
> > > While we're here, maybe it's time to add a decent configfs interface =
to
> > > this driver instead of configuring through module parameters.
> > > That way also multiple instances are possible.
> >
> > I honestly wonder whether this driver has any production users.  It is
> > somewhat useful for developers that want to simulate hardware they don'=
t
> > have.  But beyond that?
>
> IMHO testing is the only use case. I use it regularly.
>
> Thanks,
> //richard
