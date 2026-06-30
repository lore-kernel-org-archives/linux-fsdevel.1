Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8063BB114
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836647; cv=pass; b=GBvbKwwdh77WqVj5sfwEJvVxr4BoAKcgyDDWlZJ1AM6fm1cGBXkphfjzYJcjDt8IXgFg0Dh6dKxAHpmdbxYH4IpIF14Z3+jwsoDECcoDJbq6ORogA/hz9nDncucBubOfbZHQGJ0Xl3mehARSlOhLOOt+FdeoiBiBxALex4C0LWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836647; c=relaxed/simple;
	bh=FSGgdSi0nGmUA5A3/9tv+BeLzD127JNG30JyrlcNsT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDCTLT5Mr1RTb9+TsLOirPN8kkh8EWR05GvpeD37NfZ+YZpZBpA/0BoT23AdwV1b9dtYDZ9AwPcKqebU7Jge70bRnIQVn2sNwhbODgFRzRtRDqqjdOnqDpUzlGLU60MS/SYgaFHZCQSgf0QDjVgfms/UQQ3h5g3vgeBbIQdUveA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P7mTi9Zy; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P7mTi9Zy"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-13b2d7dc8d1so1376309c88.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 09:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782836646; cv=none;
        d=google.com; s=arc-20260327;
        b=FIeisaYIRLglUsKVRIVbI+EddPESXqHoLjQQl67jqcoPAMmimKUNYrMOYcy9cQBYED
         TbSOe7HUff0T4B8btONj4USe9l1Nbci2dFmKcIHZL3FF3yYXNQ2cctFUXee/htN2Ulf8
         Hw5HGNS7+RG/DtpiFm1fyAGD6TM+2WOLpvjDIVAzL/R2gxLoqdEc98rEOFWvVOYv48B9
         E3KrBqoPZIuKWiMY0yU4LWdxsUC3i+bX+2w8HdYcBf9qlqtY4DnO0D+ujrVeD2KcrBio
         b3Hbn8YUJRnHdwWwsiUP5iC3D5Rn/XCDEmAeTo0Rep1YCEsButjznY5rCFZzfeLvAsNe
         d61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GM+dTTSKLoTXlWRUSA7edb0GWK7rzbACYvRC3T4yKNk=;
        fh=3OeHyWvk33BpAy9Ah8deknP8WrKfQoiSw6FeaTwqVDc=;
        b=rkl+a/9zGe9LKMcXHSVTLEg90W2rgT2x+bjpY1nLtt6h9z46ykp2w818mx6koj1iBU
         pk3R1wf4H4yo+heNYJPWvyAx2fzWRSXZ8FK9NJEEJzg9cfVF6lybOBHjz+qhByqfctN+
         WTB2OzPXcED42kLTtl2CFxwM0b7RSGYzh4YvHsM6jhskgoyOZ4akFB9OWq71atLI8eE0
         GrxgOZKj7nu57S5mFUWq4acEJvxX6Yp11NS4UBpWmvq/79Q/m6uAtOT252szkXjUgRvP
         ThM5HeFnpNmJTsgFlEcl0ZVtNYg+ebGNW5w3YKghDaCRKZvabxFoBvaAwkrss7tHIZJ8
         hoAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782836646; x=1783441446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM+dTTSKLoTXlWRUSA7edb0GWK7rzbACYvRC3T4yKNk=;
        b=P7mTi9Zyl6+yfYPFMlvsYAZjMuvx+EJkMWAQI6WrSAI3P44/zTjCbszVGAEF3hzc9e
         lPh4WU3j05VhpEi3kbDmDI5g5raFRVxRPiMBm67mWFIQvR9KxrTx2IkQyIE1cgP6txzD
         TTda/VYdeN+FgyRPMzJdsSSMKKY1xavKX8zQxP6pWG2gXhfOKYnOsf1siIsxIQokWcPR
         j6PHRXJcCT816VwWch/VAsbgT2t2q2LDmshdgw78yRVXS+2MhwM5D87dikVxxxHrs3VY
         Uuq9DcVzneucQV4O0IKraj1sAP5VjlG6OmhF5JWaj9se3ny4hbTITwQIaziqJ8F+ndTk
         siJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782836646; x=1783441446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GM+dTTSKLoTXlWRUSA7edb0GWK7rzbACYvRC3T4yKNk=;
        b=rCU5TgU2gwrL3UYzN2tmrVNxxMO9idBxxFl9tRYuFIiXfX+m0s78/Gnt1ym2/07hCL
         TVt2+3hdXfV3+t3McuW04L3pVPa63lmkeYODETD9cu9VvQ2JxIrYdy4fQ658d2jG8eBf
         SjjZXF5L5eqgnKdSRZGtFhxZ4MRKA4Dakh+8W9rDVwJFvkIiqmP0LwL/3/8jcJBm/3oI
         OOZQZP4qKZXz/fpHQi7WStBLz+ncL3PWQe83dGzob+CHjDQcNMnSvVCkGTrMNY2twCTM
         qZQPzIS4dirHl+mCPcnIEBfiEJ43dPf6vjyh77MGpH3lIloJ9FdErG5qXLiWXHblJok7
         xR8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9l7NRsRT0MQwZd8xUoSJ5ItjpWKw+zdIIMx7okzUR0x4jvFCYYD1dDgMiHpUVoYMkF5Z6pOTBFrSuP5x8D@vger.kernel.org
X-Gm-Message-State: AOJu0YwHV1HC8WgIycnoJH5zSPWz2ri9ePTRLMkbeUEuTlJ9BEjH8nPE
	aRVhKKvI/7yzEHkraSKHN13HhBIoaIIBz8om60Wtz6bzYMHQ5u3N1jSTs0WQ/o+uOgR8XKzbeR5
	eiqyxJAdYLW2Uq6PiB5g2px7wiw9/ttAaRuyJft1z
X-Gm-Gg: AfdE7cnBD3rkJ159JAf8UUU4DD3T4Kelg3Jx3p30khyL/xoHhIDA7iOCXprWwFIlGqS
	2lKLUkkP6H4aBqdfLTI/joce9GCMMohF3tr6yQfIuiBkT6k6HI7M/qYrEQC0euPy10SVSYMfdaL
	6uG+A+vBUy86PshEqJaC7C+48y+v+HE5EqKZFRkmyTIvflFYfwy0Ky8wKKL/pHMBEkHn+606TeE
	jADgPZqnbJMd+CPR9tsYmJZiKF6Get9teIK6OPPF38F/XIxO4ogvLUGjUDrR+SrOAYHr0k1YJRO
	+GM99KoM/qGSIyh5nYLx+hHp2m3QwZ9AXL02mBg/5WDfXmuv5jyG0HFkDhhPYPfDlheD4p7e3jY
	n6bFCEadPzqOhLkVzzg4tbYECSauKioTh9buW6A==
X-Received: by 2002:a05:7022:6192:b0:138:4f8f:e2f3 with SMTP id
 a92af1059eb24-13b2a1ac4f7mr3103245c88.32.1782836645150; Tue, 30 Jun 2026
 09:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl> <20260629194327.2270798-6-jkoolstra@xs4all.nl>
 <20260630071701.6b583d1e@kernel.org> <1957659940.3537950.1782830112890@kpc.webmail.kpnmail.nl>
In-Reply-To: <1957659940.3537950.1782830112890@kpc.webmail.kpnmail.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 30 Jun 2026 09:23:53 -0700
X-Gm-Features: AVVi8CcZ9CVHSUJiGG-FPzfXUKqW9ybqtqzrGjbGkhBXBvz6rHYirwPIu6CdUNI
Message-ID: <CAAVpQUDn5Pt1TwfEs=-Uy4Khr=+r43AMCzTw2si_49e0oDAb5g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] selftest: Add tests for useful handling
 of LSM denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jakub Kicinski <kuba@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 7:35=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
>
> > Op 30-06-2026 16:17 CEST schreef Jakub Kicinski <kuba@kernel.org>:
> >
> >
> > On Mon, 29 Jun 2026 21:43:27 +0200 Jori Koolstra wrote:
> > > The test uses the following Smack labels:
> > >
> > >    "Sender"   - label for the sending process
> > >    "Receiver" - label for the receiving process
> > >    "SecretX"   - labels for the files being passed
> >
> > Not sure this test belongs in net/
> > 99.9% of people running this test do not use Smack.
> > At the very least you need to use XFAIL instead of SKIP
> > we use skip for problems with the env which are fixable,
> > like a command missing.
>
> Ah, right, because you can only use one of these LSMs at a time?
> I mean one of AppArmour, SELinux, Smack, TOMOYO.
>
> I just need some LSM to trigger the reject of security_file_receive()
> and Smack was the easiest to get going. The series is totally agnostic
> to the used LSM. I am fine with moving the tests elsewhere or porting
> them to SELinux if that is really necessary. We could also drop them
> altogether.
>
> What do you propose?

Maybe tools/testing/selftests/lsm ?
