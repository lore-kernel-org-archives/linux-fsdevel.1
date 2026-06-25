Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3C2DC792
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782417897; cv=pass; b=c4IkW3mU3eRaVMka/idDx3qmW9qULM+cV+5F8Eizkd2hYYGTMPbO0v/XI3DeSPPAzBn1MqnT8bUcReXjWjx8ir2r7iOhz7oECXEL3erbaoJsmBoq0wtjOm1oPa2mRkQdQZVhemttFHdtqpy0ts70wCUqPtk+3xerfj/Oz9wKE0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782417897; c=relaxed/simple;
	bh=MVNLxkQrXE1S2WSeONnDNVgt+bN73psBVtnU0fQNojg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNDZg7gXaIa4Ahs3gnVWWslRxrOKUXXsi5rrCTOmR78jpoqcZ/EWWCdpKn6c9HbhGlnrJ5Ehlm5/EWJ+bQqzrAtz4Gi1t//NcnfVop7s3sHMyGI+gwSoU6SQHyPl85Pe6vKci0CxCFJFA5UQLNa9BDS5XgBfTpTjX+JfnHy/KoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MinqNNF8; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MinqNNF8"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-662b95934dcso336895d50.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 13:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782417895; cv=none;
        d=google.com; s=arc-20260327;
        b=oL2wFkd1JscclmoMPh5zuLyd3WGNGV3RIsenziJVwlywI3VMmxyLs5KI4D97nl7mun
         MIpFjvUd9mPwvl5Xqb0cq5q6XEv1J73c1r3TxRPQZmLDfr8Mlaio4S3I9Kkv3ILi93Mr
         JA4loeqhlhVAoBc8InuQtocM34xt0vgON5SghNnq8P1OKUfp7+0Giz3dl9AdhfNII2yD
         5H4WWrqFTriWASxGo1wiWIpNnnoRe/PdwQ48FzgfL/VYFPOJRUey6bRmuKMChb6DolqU
         3bye0hscspvAFd0IKChNn5JNxdJ7hGXnnpM5fXh047kqiMQL+FDmhKp5LcvxE5WAzjv6
         x8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MVNLxkQrXE1S2WSeONnDNVgt+bN73psBVtnU0fQNojg=;
        fh=085PXWA1ygQwQDiW9Iuq8/qY3H//r1AeeSiiGD4SqNQ=;
        b=GbQur647jsdAnx5Ce51RYdUtRFREuaA/EsI/7T1k3x4aHc+pnnsUE0Wec2qg0UyleW
         oMFIT+SziC+hiKhk13toK28acjGKFjtZVF7fb7VjFtKIzzOtLx3SpnOnCW/NNvRtPAj5
         TMtZXVWRQwYwdo8KAL42atj4oAqJxHiDXXBdfZJMWiKRgA/76pTRKt/oZJOk2dpS6L7I
         KWs0PNvc2xt6B893Xn8vW9dJdsKRQ653WPqkG5zLlibgBYztw6bmgFqPfDgUf4FW3LKY
         W/K/MTausNPmGLmiicn0TMrwtBBw6W1I5fejXifGaBZEQ39deMIGbAvGbY/H5mIeSmfO
         pMpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782417895; x=1783022695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVNLxkQrXE1S2WSeONnDNVgt+bN73psBVtnU0fQNojg=;
        b=MinqNNF8CT+HIs/EKx/e1wHu3pQ+FLVhOlq+rRPIOn4FSe6tLDNr7NKJn8hq8E8D7F
         0rsXUGn5uYAL+MV6gaDRj64YfqPp+tHrzmR9BfUzWsQoPPK065wImf6MJTki2HRI16dT
         jAUVwU8wIvQEKDNqaCVR5xEz75Z671th1MwliTatQ+jtvWSWNdgiGKpr6JcUbzQhd0DM
         Sn9GTlWwSJgt0+jDTMqFwXrATevuYCTROILaTQnPtOe3Zcdw54k3zrN21GdciOdvAELP
         TgZpQeboKqsLg3ou7ccv8xllBUrxJNqunK0QXU1ibIWkt3pgdfBXhWj0ZW76AfJN+u+W
         RF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782417895; x=1783022695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MVNLxkQrXE1S2WSeONnDNVgt+bN73psBVtnU0fQNojg=;
        b=mmKw6x9T1vfLHKy7mExThkPQ2wzllT6g9m/lvV/Vn8tCov0LtZQSKtIWCoo6me6T1y
         aK5jZsst4cTntfWRLrgL7aA2cMMYkGoEVOKPsZAO0wAl1IPvuN2+doxen8Vjmr1kh4No
         20wByXj3gsg/XfvzMs7RHVZMQqTFKwX34iGSYR3lFZpMI41ZsfesCnxjvxUfasqOIcEC
         gqE2xp+Ebv59GT71+pqU9tvoLFJmYPZu+z2bu7Qa4psiTTC2sCYbMwNigqLfSnW5xn5a
         jaInU/2w1JBRP7tHqUBgsV62igGwxOsq8TV1iCb3lNr/zqzSAReJ5XrZQrkCskg8jJ9k
         v5RA==
X-Gm-Message-State: AOJu0YxCoI4Pb0L+oEvsXSUaZykYRSlbZ+QjuGJ9boZkldBzuhfH+OqY
	CqmI1Od/WsbNGEVfURFYkjO8XBcPaeXe+3hvj/mdQeZ3jCSzOHuuK0c7WoWBTyq3edtszd8ywsG
	v2osDwaLyKsXR6Pjpq6GSScXie6qnsA==
X-Gm-Gg: AfdE7cm7F19PaBFdm70JWMTgQE/ZcX97mgc4/1eLabiP6qhWWK6WhQS34bRce3M7qX4
	fb5V0LxZ+emsRZzW3kS3bUneKkGO1pLsgnfCtNnkkeJMPbueP1jsBh/rlI/0kfrI2MkBnH+PtPQ
	HJaE3PNTC7bT5N9ZYd5c223aYrMQ78+xZZUsOdHgT3vKIfgda8YK0ar9MyKw3fMQXytxQ0iAu4B
	h//XNKAlxcRj5A8qCDTQLMp9YOfrSida9i09yhFxnWAswcdUHzFbZrBqcgaBdbFLbzJgOcQNZkH
	tE5Oej3RegOIkNTgteC23mjywbt2KHB81JL15dKseaRMKkfmZ81Ikp1o3DmDG7wpKYwH+5YBTjQ
	QzV68gpOM+YounK34tWamz1sujyZsH82bhuOMajkwVcKzXE0=
X-Received: by 2002:a05:690e:bc6:b0:662:cf48:c1b2 with SMTP id
 956f58d0204a3-66487dd13ccmr3315402d50.36.1782417895370; Thu, 25 Jun 2026
 13:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF3PHDynqk0fbtthp8cPQCtgFajrjNvCxmDp8Lq=Gs4TD=ztgw@mail.gmail.com>
 <CAKYAXd8fYZ9ZXM=F7H6q3bCW66NYT96ckQk20dmfzramV8FxrQ@mail.gmail.com>
In-Reply-To: <CAKYAXd8fYZ9ZXM=F7H6q3bCW66NYT96ckQk20dmfzramV8FxrQ@mail.gmail.com>
From: Razvan Dinculescu <razvandinculescu@gmail.com>
Date: Thu, 25 Jun 2026 23:04:44 +0300
X-Gm-Features: AVVi8CdPnkNiHQ9GSCwbSUXHs0ElSw5hksCfcADlqeFIdYY1MgahwmTrW6qFelY
Message-ID: <CAF3PHDwm8CW5rSEkoAPCAFxuom4-OBMVtGVUSSomrqxUQ8YaFw@mail.gmail.com>
Subject: Re: ntfs: RO->RW remount is broken - two bugs in the quota-marking path
To: linkinjeon@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Resending as plain text - my earlier reply was HTML and bounced off the
vger lists.]

Confirmed - cbe287fd fixes it on 7.1.1.

I exercised ro->rw remount on a freshly mkntfs'd clean NTFS volume
(loopback, in-kernel ntfs driver), three runs each way:

Stock 7.1.1 ntfs module - fails 3/3, volume forced read-only:
ntfs: (device loop0): ntfs_mark_quotas_out_of_date(): Lookup of quota
defaults entry failed.
ntfs: (device loop0): ntfs_reconfigure(): Failed to mark quotas out of
date. Cannot remount read-write.

Same fs/ntfs rebuilt with cbe287fd applied - succeeds 3/3, mounts
read-write, no errors in dmesg.

Please go ahead with the 7.1 stable backport - much appreciated, and
thanks for the quick turnaround.

Thanks,
Razvan

On Thu, Jun 25, 2026 05:30 PM, Namjae Jeon <linkinjeon@kernel.org> wrote:
>
> On Thu, Jun 25, 2026 at 4:33=E2=80=AFPM Razvan Dinculescu
> <razvandinculescu@gmail.com> wrote:
> >
> > Hi Namjae,
> Hi Razvan,
> >
> > Thanks for the new in-kernel ntfs driver. read-only -> read-write remou=
nt
> > fails on any clean NTFS volume. I tracked it to TWO bugs in the quota-m=
arking
> > path and verified the analysis by building a patched module against 7.1=
.1 and
> > confirming that fixing both makes remount,rw succeed.
> Could you please test the patch below if it fixes this issue ? It has
> already been merged into 7.2-rc1.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/fs/ntfs?id=3Dcbe287fd65f1a51eb1720e93ceca7ee8d8b011bc
>
> If you confirm that this fixes the problem, I will submit a backport
> patch for the 7.1 stable kernel.
> Thanks for the report.
