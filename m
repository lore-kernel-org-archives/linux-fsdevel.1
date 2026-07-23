Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9C459AD9
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811938; cv=pass; b=EAutIWyQR8PYBOZAqSL4kf50uGZf56g3XD9IMeBw+fxz8IETDdmCrr/YsWIyp9VYpPGixQM6cm8jpeHYWZo4Jnvcsb8HPXDUHXHziFCAGJ8ictwSE9rAowGmziRpOgS4U1AtkcViKmGJjbB9cYJBRTrKPm5sby2ELCdHlw1/cs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811938; c=relaxed/simple;
	bh=/4fm2fLiIiNTAePr7znlAXofmEYIJW/1wI/ZsofAPsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F60G8K1WZutlt3GSn1GOc70oIei12vka4RDbsEX+XwxyMMryzKEFapgHeOhKGDMIrQGLo4T9aCjDiiEx4XC0YLXhAZsmnjBTDfdT+bZgPyGOgMm7huYhP42VXRwaiWcCOQSAsD1pnbUUi1J9XGaKWg/26caaexi+hbjDiSEkt34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csiIwXKk; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csiIwXKk"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb4d532e65so188319a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 06:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784811927; cv=none;
        d=google.com; s=arc-20260327;
        b=hgmNcx4WULQu2zQQuZfGFMK0Jbtjid5U+tQQRP5VPwAkIdclpM5l5pIp96hURBwi4b
         cAgUoTO8ZSWbsIGFgCsVDsSe8r8k93C98zEiWYa2xkY8z27TtWXFaovclh8j0SQuGZs0
         Kf+E3he6xLlzHJPXr9akx+9in+vCkZCSwcLYykyAUJVZnr1z5UA2SBmeDn9Y6wiJdRjZ
         bMbmM3j9h0jtq5meEsQbJG/6iwCi57tRMLPjCd7XZOACAVHyQ9lWpkkuT3OZncVRrkIU
         acyPK2zKPb9R8NcFAGWTmn0i0zPW0ra98bc+1EBaBf7oLRvBUbeRWR1SecKzNbYx5Kz+
         n2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4C5V4EO0BxW93DEU9+ggAWGxFKYimvpCcl5jO1xW0aI=;
        fh=x8zuYGQhmvl+PnH1dcGUZY9dvO3+MTjJNlBG63Xt7AY=;
        b=KONQwX4/4s2Ob+VtbZ4I40JvX6Napod41B2cgwbSwqWxjrCyC8cZd/l/1XIHViExr8
         LDg+VY5ToJsvi4nxW/+45/wHKe+MNBg49ZZh2RkgYa06W5TQTIZtz7hmNmVU8Llvaw4f
         7JK/bfSkaSYO5FKHGyE2TJH+DhP59eRaDKgzUR0k8zvwq07mKJCBCyIhoHJPqdFjmxmw
         +ksKDW7atgP3Z/000bMkZ2bv8jsmxEt51Bgb67ecONrJd67l0T9f08Lod6Ruq2xkEetN
         sNLFOjvMOO2Rba8jAczmxK9wJf1cgy9W0CDWr7Ar4eaQS3YPC6I4N0TbCbGW/U86WGEg
         z78Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784811927; x=1785416727; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4C5V4EO0BxW93DEU9+ggAWGxFKYimvpCcl5jO1xW0aI=;
        b=csiIwXKkXi6LFxNkJ/xf61FFnm9hsYvdyBHc7AFnWJwkr0rxMiVLEDntltigSaUc4X
         NnB/Lp7Sy/KzmV8s1ZhZaSAYlR8Cr7wqZTJzbQk1gLItWv1vcLKHNH9y5cHR7lFvY8i9
         eZ1mzXg/xQWj7wy1uGD+r8aBsaPsg9o2DlfSic0Em06kmFup+NsCA3co7JveVcSYxpCT
         0SoNu5uvR/2ClhaqfkG1DWXdkuXXhwIRzTlZq6YWAVseilLp4q5YJYQCH0iw/6EuNxt3
         5Tgj8x4y29hwVlcbkLCLiB2bDEi6U2Kh/qnlyWXun9u8uEqFRT0DlXB3GlEtcQyM89YY
         OYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784811927; x=1785416727;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4C5V4EO0BxW93DEU9+ggAWGxFKYimvpCcl5jO1xW0aI=;
        b=R6M1uJkYawwTUBfKxH92/vpTXl1fNO6Cw5PqN0XO7vvzM3RKUzudHrY6XaoR4qwwcg
         dn2DdhWzZ1t5UTejytmaApe1mmRMBxQMKwcc8OxDj/5fL1VNJmaOpRsfwFOMz5jQOMjr
         WeShA9oETg4fLDupp2PoOqD/tX5iOcw8uh1lIBSBFKMZND1cU6a/IDwi+iteXzan6EaU
         KfWMCTF3qwZahwC5OpTC0iNhE+6L10LIiQ6C3Uv1RrxOQuSTx+tSvIFrHkScWVDW5jRR
         Zca4cmEqNOr88/0G1xYPZPuE8l3hqkNf+1KQNUZcJaAyiKs2BANGYqrKq8SxIm42fTwE
         D82A==
X-Forwarded-Encrypted: i=1; AHgh+RpaoHpHmlkH8q7vFlC89HYcD/Gsv6u9DjNI16TjEnK7gx3n0R69F0pETmyKE8Er0yYYjmL8N19i2aZfpWRx@vger.kernel.org
X-Gm-Message-State: AOJu0YxOea4ePWyOFYJrsL0T/DuCaiKog1qGNVMlZscuK4cRqLufEhuK
	bCZz/wF4e+omdbCc6wNZy8Mt6hdsbsyZt/R9msQMp7Vtd9mmOw1kIcNr/m25PwEbg7pLkrM/R80
	ryvhIeVhCEupNP+wern5HwjxHw+L9YFw=
X-Gm-Gg: AR+sD10w3u6nKws0/FpizZb/dsv65DZvJ/sA0xVNzueTuqlWie3eeeqEl3iTEPLXLa2
	Xd9YTNDgAFYpfLF9HbiEwPpCQW9d6R0INS/mmsEbYrfTgwgPbEDLDt7PbuM8lvk2Y5irqdNbfay
	G73GmYhzL/3qKhCa8uAVLZH1TpyFJIHOKDAX61lfjTIkamX4wrSSH19mBbNp6BLE+NvvmJk8HVs
	eSWwltEf9HXdNxLZCmFoRleAca1I2mu888NQX2vOAMt5sxAo1Vz9Qrpyw16SgmXbM74TADU++A5
	2N8bkSdt7jvR36tNkNJ62sIOC5Jb8ZJEkNh0s6RxUhZ1B8tX7VzEjn/NRQ92Nh72L+W7G23DJ9/
	BnA==
X-Received: by 2002:a05:6830:4182:b0:7e9:b4d0:53a9 with SMTP id
 46e09a7af769-7ee44209175mr1579151a34.26.1784811927392; Thu, 23 Jul 2026
 06:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723114848.1212429-1-amir73il@gmail.com>
In-Reply-To: <20260723114848.1212429-1-amir73il@gmail.com>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Thu, 23 Jul 2026 15:05:16 +0200
X-Gm-Features: AUfX_myEei0bzutzXlBHitMsWfFiaQmYM0otuAjagzJ4Rt_DGQ5CK8JsnPe63ok
Message-ID: <CAO8sHcn=b94SL6KTfPtnqau++-g9CXD0LOpPjp4L+b9cu8mMSQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5] Proposal for Cross-fs copy_file_range()
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Amir,

I tested the series on top of f6cde11eb46e and cherry-picked these
selftests:

https://github.com/daandemeyer/vfs/commit/0b0e47d408311fe2b4a3e1711656f836b56e10f4

All four tests failed.

The accounting test reports two reads and writes, and 128 KiB
accounted in each direction, for one 64 KiB copy. The outer and
recursive backing-file VFS calls both account the operation.

The credential test fails with EPERM. The explicit source check uses
the source mount credentials, but the recursive VFS call checks the
real source again while the destination mount credentials are active.

The permission-order test times out because the real source
FAN_ACCESS_PERM event happens after the destination inode has been
locked. The process handling the event cannot update the destination
while the copy is waiting for its response.

Finally, denying that permission event still clears the destination's
setuid and setgid bits. ovl_copyfile() removes them before checking
permission on the real source.

It looks like the root cause is that OverlayFS-to-OverlayFS is
classified as FS_COPY_SAME_FS before the FOP_CROSS_FS_COPY checks.
That leaves it on the existing recursive VFS path, so these issues
remain even with the series applied.

My (admittedly much larger) patch set does pass all of these selftests
by moving most of
the authorization checks out of overlayfs and into vfs and can be found here:
https://github.com/linux-fsdevel/vfs/compare/vfs.base...daandemeyer:vfs:push-zolnnszvmkry
for those interested in taking a look. Happy to post it directly to
the list as an RFC if that's
preferred over a github link. That patch set also lays a foundation
for cross sb copy_file_range()
but I opted to not post those patches yet so we can figure out how we
want to deal with the above
issues first.

Cheers,
Daan


On Thu, 23 Jul 2026 at 13:48, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Hi all,
>
> Daan De Meyer requested a way to do copy_file_range() from overlayfs
> to/from another fs, where if that fs is the base fs of overlayfs layer
> the copy could be an efficient clone.
>
> TBH, he also requested support also for cross-fs clone_file_range(),
> but I am not happy about providing that.
>
> copy_file_range() already supports cross-sb efficient copy (e.g. with
> NFS/SMB server-side copy).
>
> The current limitation of staying on the same fstype is mainly an
> internal technical limitation (choosing the right f_op), which is
> something that this RFC is trying to address.
>
> The overlayfs implementation itself is pretty trivial.
>
> Thanks,
> Amir.
>
>
> Amir Goldstein (5):
>   fs: clarify cross-sb copy_file_range() code
>   fs: add support for copy file range from another fs
>   fs: add support for copy file range to another fs
>   ovl: add support for copy file range from another fs
>   ovl: add support for copy file range to another fs
>
>  fs/overlayfs/file.c      |  35 ++++++++++++
>  fs/overlayfs/ovl_entry.h |   7 ++-
>  fs/read_write.c          | 119 ++++++++++++++++++++++++++++-----------
>  include/linux/fs.h       |   2 +
>  4 files changed, 130 insertions(+), 33 deletions(-)
>
> --
> 2.54.0
>
