Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBCA3B2FD6
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564090; cv=pass; b=FsWEsDtkECtAlhtEcXpzRmqclmM5/EhxZXmLcaKA1yuCJmHGb/d7VYqkIRLrB9apR+45VNoTWSAi9jcgKXwKiJhvUM75eBBAW9OjzIAK1Gv+pMCAca1WapQ6I7Drg2zGbLQhAz121MWeoojZtz92gtXxKKtAKUDsb59NhOrjW7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564090; c=relaxed/simple;
	bh=DYtH3ovqeZiNqkreX7Nz4nkPWobgUXsJ5dwCB2BpWgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lh/9rPVw3IDOM6n6Lku37lQXGzyjsM5Tzl6anSZ4KMVE5EnfV53tWkhhMTUUKthwoL4YQlS5N8KoXdMD4hRos902GN9L0n7sSLtfFusvIeRNijrA22oI1hyrH/4MLiUT4qLT2RvUy6sSTCyPJtlPVesT4CeCBNiTczQeCo1CRz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVZPYGFy; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVZPYGFy"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so2764341a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 05:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775564088; cv=none;
        d=google.com; s=arc-20240605;
        b=HWkrh+y6uDMwLwmxomRJ70UaOQe9ICD7h+Eo7GEZhoPjhCd90mmYMmIBMfWjdDR4H0
         JDAHXq13rFDntLP8hlMggL4x/Gz9jV7sKfSzkfa2kMHIYyQCic3Y+ee8CMrNImRE7uZA
         L/dO24jj8GiGHXzo+Qet8uZalnZtbsWhQANktGzxyYZfNnnd+F9cDWjc1W8Ig7LFKblg
         7M7B++qqIbGN37KPoaqyKSYQRZ1+wg+RzPzM2QsA/WgpVdL2Nm6xBIom3qG9LZ8CJTnJ
         JGcctMF4rr78do7Sqsk9NVvL8NQOw4950wNNNSxmNsari0tJoc+hC+Jg5WLrJ8CDOv9p
         9YbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zTDkABRGJ7UHzKZMFM6DSH1URUE3mRRr3uWbQhi8EKg=;
        fh=X2eNYe18bJ/qXN8dGZzS/w/x8RYSsb2adAPdHvu2U/w=;
        b=cxWMfN8uSLQT7zSQQfjVUDJUZj+YsybtLh8PLfS2lD6xbResQofk8p8fNhXzjUyChl
         zglIeguxe/M+B0+LVOKcU3uIlfOYTDuU/HPEoE0tIIASUBd2XpJUyQW07acAFMkHOgQv
         kb+Q5ov09te8rK0ZXkOmVhQCjVy/UWUtSjhT+PZDhyPKkcsOSdk44UlpORAMM4D54Qp9
         8VASqFUtJB2CvmRUbsD3QaOz0su+TIB/MQTMGtpx01PT8jEtiDoR72Jw5LReXfOxv+uU
         4XEZjqsHhE/p+y9jQkCrvpDeVOBBtyPINofIoYDRGWfGKt28XBn+fb1mMMQAP0sLbsMa
         0UhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775564088; x=1776168888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTDkABRGJ7UHzKZMFM6DSH1URUE3mRRr3uWbQhi8EKg=;
        b=mVZPYGFyBgGtpWk4sX37nuVl392e96R4bjfs0ORNcxHmm4repjBBJl6wER9s05QPRx
         u9yMmyrIxhKtFPIgahhJkUem9XXnOt0Y4udHqUe5ZV5JLiunPgHbLwuF5YVLX9xOMwfS
         SHajj6jRYt56S5BkSVItPD2zTTs+S886TqgSWf6wGsfmVf48l/adO1vgGfcBxFHMUdKk
         98zAae8oxZWozMTxhB3oIy7PG5AaxmT0a1YdtlKIlVFcGbOdculw91xtDE6pfiAGsJ+L
         dEx4POQKFfhhxVSIboL7SSA5JB8IVPNytMGFiSoathMYqf1+sLX8Za9GGxj7OoZpqzGF
         gAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775564088; x=1776168888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zTDkABRGJ7UHzKZMFM6DSH1URUE3mRRr3uWbQhi8EKg=;
        b=BGJBUKzGQ8fAovUsrSMgm5+9S9id5hfr8W3wNhTub8LXnE1kkI0NMl9wglKS4+Vgun
         7Ya+ntdiYRvM1vGW3u1py8/asa+xoqbcMgrXqvqTwcLmiavJEWh/mw/rwzwvGPKxYAPc
         bPyVNtj4WC8uT8QiABBn52zWJ+uEOKOPSG5WN2Jv7AmeQ9RRqQxJ03Mq4VIj3l0xa9bZ
         S93K7PJ7fGdN1B+D8tR8Ps0AN0Y8mPyKa3T2G3eWQgy5wOX2X9QAkznSPrnw4gcTP+xq
         u1p6m9TGFpNe8N1jItN1SrFybCaEg2uUqReRQFRp3JLKBzNjQc0EOVJqKO5Xip/2Akwp
         93vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYRmgyOM95JPumYGz/YkJ/ZzJ0jEas0AbqK8J2n3U+cW+DuEhtf4fT9WTYNPUF62uWb8DDI8/1RxstWrgf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vM4s5PgxjOtuA7JeJNKHqp89csEuflkG0kUWHghw0KKGlZlW
	IHn0np4K/xeaJbNN8mZBvommZ04ctuyNPCuMG7tVHNNdLr/HTBu7y1zamypt5xoJm6DK+ev34dg
	vnTA4pmGRNzDyi0PE00uU//sHXfsKoQU=
X-Gm-Gg: AeBDieu3QaYYIHs2uQ3GOSKowk4lBq9Cax91fJu1+8j8OHlswruW5965KjRq7CaoI2V
	46557Rv5yjACEPVb7hmVKbHq4zUz+GYO9N6U4S1qOLStLHAS2gERT3PwuEE71ONzBbrh29Rr1Zn
	WZxv45AzfMjOn285j1ofoqUZiQshxAztCEbLUL/vBdU1RKTa3U6drlZkcE/5eMpTHlWd9UDd2m1
	TDx+F+em2t9jX5v9FUB4VIBftRjznO3MAbayysJ394LdHFjo5rRtcNEKyNyOaDYj5PWdVXvB+rh
	Jib694k=
X-Received: by 2002:a17:90b:3d4d:b0:35c:d37:6024 with SMTP id
 98e67ed59e1d1-35de67ea9d5mr15645164a91.11.1775564088070; Tue, 07 Apr 2026
 05:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
In-Reply-To: <20260403030848.731867-8-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Apr 2026 08:14:36 -0400
X-Gm-Features: AQROBzAHeiE5r-KOh8TmARe6SlYgAd0n8yvhwUwHmTAae_PdDX5ZmAScFcPTcfU
Message-ID: <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>, 
	Gao Xiang <xiang@kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The existing SELinux security model for overlayfs is to allow access if
> the current task is able to access the top level file (the "user" file)
> and the mounter's credentials are sufficient to access the lower
> level file (the "backing" file).  Unfortunately, the current code does
> not properly enforce these access controls for both mmap() and mprotect()
> operations on overlayfs filesystems.
>
> This patch makes use of the newly created security_mmap_backing_file()
> LSM hook to provide the missing backing file enforcement for mmap()
> operations, and leverages the backing file API and new LSM blob to
> provide the necessary information to properly enforce the mprotect()
> access controls.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Do you have tests for these changes showing the before and after (i.e.
failing without your patches, passing with them)? I tried running an
earlier set from Ondrej but they failed.
