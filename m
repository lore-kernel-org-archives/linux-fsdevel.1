Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A3136923F
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922318; cv=pass; b=SlZAopn8d7CPt/CjpcoMw4GRWfPfsmtJnhGSCnmoF8zFVOOgPvSrG09voDDgal29Ik0oFwPsWmWaxVyvBwLZDHm+KYBRdSpv4Bg4F1jKpSjWF/yplyQOwTzO72VxllUyAM2r/MytV8UvkDYdXMDnFyjIWYDOeW8IKV5zr0NXaDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922318; c=relaxed/simple;
	bh=pajnVni3fs8345lKRDE3FBdUZGFKUMVeC0hP96aTX6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMyKimPduGceG45ba8uV65NcYCgtRynaRiK/6fNxjiNtaP1juUWzqxYajqe6Su4zV2n5fGQcsA/16PUBVnWhb5yuA0N0ltXqgY+s4Yo3XHiz0NwgZ/JSMV7ircD+E0QFZ/ONJU3lu7HYilsE5Okh1cjvNPVeYHShYL6XfwQt4eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9xMtPrb; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9xMtPrb"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d3b440b97aso105955ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 06:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787922317; cv=none;
        d=google.com; s=arc-20260327;
        b=J4XAcX/2uNXAhKqxkQDu/Bb+wI2tuHjbnPDM4ppkuNsVQmENcjGz0wP2Tl0VFIlsrx
         9HMfQVCkTBJyTydU9GhJgaQFGjDAUVYIHzud59Z7Njc5KzI6F6OfaBjDiKOTUG/+VkSR
         SBasGhgBY30ZlxF1ZAf8UbDeu/T5BlflmK1ybZnOVzgnvf7vo3n7Akh72ZlfIQyLQutQ
         W2ZA2ydJ8ObmQlaTMLJA1uCVBFk+wjTV7juYAqWRw1wfIbYR+thaKgbk9HcHdLC5zMQg
         VnDYU/qqGKGJpMPSnzrCBZEPxaOsYUfAMpLjc4kmw4VkeCUstf+bP6MMHBTmdgL5JLlk
         cxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XyY15gZ/uyotBCsU5YViQYJjvIkD9znAZ6y7wL3wuFw=;
        fh=7zd+MId25ICbLNnfuQfSJ8Ca3kqjO0x4n2z7aVFFKdk=;
        b=Z7U808LLXdXBu/sFrMOwRfbttWlLmQ7Pvev9mbr0vn6ZDJVL1a36KMCd2r6f9qh+Vt
         1yeB08bCX48lJ92Le2wEl0sBb1u3foXOORvLwnXbw62YQStZFNdjat/dc6kjw0kBhMwK
         YV0QN38h3hay0E5mJdYS02nYPKjBBaMgJoIdV+mGsu3Bpo9WjK6yhhldH7H00PWhr8sg
         xfIay9ywEvodvW213lYRlTjjJ9l8rKmVDuUkr9EcoGDxT4I6/R9FQ2Xrf5V03tGi7Mvh
         gE1dE8AuQ+72G28gbYQEQtu4wyZU5UMnIjV9GPA+W0pRuwgBlcvpwjlcSCggfMJSlHI4
         IXnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787922317; x=1788527117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XyY15gZ/uyotBCsU5YViQYJjvIkD9znAZ6y7wL3wuFw=;
        b=s9xMtPrbI2x8d4KzdhJwQ75f7SuKGJFJduQsbl43byIuGIM+LumG6m7kK017wSxnsj
         5ephCSET2uQRpKk2fTa/VeI4zaQRGe+mqr4BJ9N587Em3ZPJFVxHuxi+kstCvGWO7ZI1
         Umk9Sh7dMT3DhbdU6yCbJTnCNOFlV/HvSdzxIhOB0JRJoOXIS1GfzZiTcNhepGp4FReT
         uygpTFo3O2Zm28B3M6FxJho8mLGv6iMg2nbAi/bfG8jXRQqTYuqv1BWavat6gYrgmKwf
         kHoxOrGmo2vFPk82zKAal7NBlRBC3DRJwhRAw0O/QJgs7vJprFtoso5TBzZcexaMFlfb
         WxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922317; x=1788527117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XyY15gZ/uyotBCsU5YViQYJjvIkD9znAZ6y7wL3wuFw=;
        b=ALBcGAo/WZLS9Zf+W/0qzvTES+1xp8rng/6FBaGBLHeV6yuHDbQPKiLZQpJNYnkRfO
         MS4O5zApdpabURB1JumpwDHFE4mI4uj99I3OTvJBrluBn3+4jIboWouXjvrQLXuLe4Mk
         MMXfpkqDvOje4l7kJtfQDJjb62mZs7mFCNi9JHD3oY3Qnbi4JDSmlVap8a9C8IfYkJhU
         B5PiduhZhp2yUX0SwJCVhM4l/DUMOuoLpKPGnLrxyQzSelvPb8jbyOV0pji9RkVR1/o2
         r1xxB3+vv72oHrb0qKmDJEFWiRe/C2lpDgkR1+zlHkn2sCdtH/DRsbt5CUFK7a+tKkMF
         ARBw==
X-Forwarded-Encrypted: i=1; AHgh+Rqo1uGew+ZZneElwnpWNvb3UqwSRfO2GlEZnGXjX9vCWZsS41aOSLnYirPsz2fx0cNDDvqDi2uaGKvb4Xcb@vger.kernel.org
X-Gm-Message-State: AFuF++kFhAQsUTASNjmkZMzsbz0irWy52IYgBuHmdRyloUUM6Oxw8wZ5
	TXkoPzmrymGU4i8PfXNeoBR3bBZ6PXVIDrRT9OB8FQlVKnuewwGjhHqAOIhxwZ0pw78hUzNYRq0
	YolhwNL/yLCYHPdKruEABHTqiSxkOW49utdPkALzs
X-Gm-Gg: AR+sD12ap7VWGIUPDBouoH4eOvSMCGCw6D9U6VbVQoq/FLz3pQ3UhgVky83A+tzTpDU
	1jLuRKrpCOPPx+t6gMzSQ8wspoAX9QOtdgZuHdnEU4StPh2PvdPAfP5wq6d62p0aF/NgeeyGJHs
	x1JJzYY9HmhbErxnmBrba4aJOJyCRIVZN7Pe81rrzmmlqKyH8A+hmmNnno9aM6RaBnu+Y1isZ3g
	b4HaCnwXeK+IPWudGUy6d5Sy57ouWosWoz8PZ52kjx5J2O3GEFOsP5eQ3I2dcECnijNRTKP4hBd
	LsURQaA9pJjwEUqkZrcmfTeVN/IQcRqoaoNGFHdpHbjFoTG8kCbSDhL0AFeGpwHu9dQKKWCT//H
	kjjSk02cmGQNrpUYI7GSKBNLP1eMkm9E=
X-Received: by 2002:a17:903:987:b0:2c7:b1e7:501e with SMTP id
 d9443c01a7336-2d75482c43emr5737145ad.3.1787922316046; Fri, 28 Aug 2026
 06:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com> <de5f1c2fb1ccbb92beda6906e23ac457@paul-moore.com>
In-Reply-To: <de5f1c2fb1ccbb92beda6906e23ac457@paul-moore.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 28 Aug 2026 15:04:38 +0200
X-Gm-Features: AcwNN1VyfOvZNu7ELf4xzHHJ3BQoTm58QSMty2PAZc7oNVjQteiUlR74XB89qaw
Message-ID: <CAG48ez1NsUqpZmr66RaeFXMicpZT2FjMfwqTJwcQva50XN6cGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE introspection
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:10=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Aug 25, 2026 Jann Horn <jannh@google.com> wrote:
> I realize not all of the SELinux hook callbacks use proper kdoc comments,
> but I'm trying to fix that.  If you could make this a kdoc function heade=
r
> comment I would appreciate it.

Ack, will do.
